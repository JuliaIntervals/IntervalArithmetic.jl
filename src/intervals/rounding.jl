#= Design summary:

This is a so-called "traits-based" design, as follows.

The main body of the file defines versions of elementary functions with all allowed
interval rounding types, e.g.
+(IntervalRounding{:correct}, a, b, RoundDown)
+(IntervalRounding{:fast}, a, b, RoundDown)
+(IntervalRounding{:none}, a, b, RoundDown)

The current allowed rounding types are
- :correct  # correct rounding (rounding to the nearest floating-point number)
- :fast     # fast rounding by prevfloat and nextfloat  (slightly wider than needed)
- :none     # no rounding at all (for speed, but forgoes any pretense at being rigorous)

The function `setrounding(Interval, rounding_type)` then defines rounded
 functions *without* an explicit rounding type, e.g.

sin(x, r::RoundingMode) = sin(IntervalRounding{:correct}, x, r)

These are overwritten when `setrounding(Interval, rounding_type)` is called again.

In Julia v0.6, but *not* in Julia v0.5, this will automatically redefine all relevant functions, in particular those used in +(a::Interval, b::Interval) etc., so that all interval functions will automatically work with the correct interval rounding type.
=#


doc"""Interval rounding trait type"""
immutable IntervalRounding{T} end

# Functions that are the same for all rounding types:
@eval begin
    # unary minus:
    -{T<:AbstractFloat}(a::T, ::RoundingMode) = -a  # ignore rounding

    # zero:
    zero{T<:AbstractFloat}(a::Interval{T}, ::RoundingMode) = zero(T)
    zero{T<:AbstractFloat}(::Type{T}, ::RoundingMode) = zero(T)

    convert(::Type{BigFloat}, x, rounding_mode::RoundingMode) =
        setrounding(BigFloat, rounding_mode) do
            convert(BigFloat, x)
        end

    parse{T}(::Type{T}, x, rounding_mode::RoundingMode) = setrounding(T, rounding_mode) do
        parse(T, x)
    end


    sqrt{T<:Rational}(a::T, rounding_mode::RoundingMode) = setrounding(float(T), rounding_mode) do
        sqrt(float(a))
    end

end



# no-ops for rational rounding:
for f in (:+, :-, :*, :/)
    @eval $f{T<:Rational}(a::T, b::T, ::RoundingMode) = $f(a, b)
end


# Define functions with different rounding types:
for mode in (:Down, :Up)

    mode1 = Expr(:quote, mode)
    mode1 = :(::RoundingMode{$mode1})

    mode2 = Symbol("Round", mode)

    if mode == :Down
        directed = :prevfloat
    else
        directed = :nextfloat
    end


    # binary functions:
    for f in (:+, :-, :*, :/, :atan2)

        @eval function $f{T<:AbstractFloat}(::Type{IntervalRounding{:correct}},
                                            a::T, b::T, $mode1)
                    setrounding(T, $mode2) do
                        $f(a, b)
                    end
                end

        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:fast}},
                                    a::T, b::T, $mode1) = $directed($f(a, b))

        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:none}},
                                    a::T, b::T, $mode1) = $f(a, b)

    end


    # power:

    @eval function ^{S<:Real}(::Type{IntervalRounding{:correct}},
                                        a::BigFloat, b::S, $mode1)
                  setrounding(BigFloat, $mode2) do
                      ^(a, b)
                  end
           end

    # for correct rounding for Float64, must pass through BigFloat:
    @eval function ^{S<:Real}(::Type{IntervalRounding{:correct}}, a::Float64, b::S, $mode1)
        setprecision(BigFloat, 53) do
            Float64(^(IntervalRounding{:correct}, BigFloat(a), b, $mode2))
        end
    end

    @eval ^{T<:AbstractFloat,S<:Real}(::Type{IntervalRounding{:fast}},
                                a::T, b::S, $mode1) = $directed(a^b)

    @eval ^{T<:AbstractFloat,S<:Real}(::Type{IntervalRounding{:none}},
                                a::T, b::S, $mode1) = a^b


    # functions not in CRlibm:
    for f in (:sqrt, :inv, :tanh, :asinh, :acosh, :atanh)

        @eval function $f{T<:AbstractFloat}(::Type{IntervalRounding{:correct}},
                                            a::T, $mode1)
                            setrounding(T, $mode2) do
                                $f(a)
                            end
               end


        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:fast}},
                                    a::T, $mode1) = $directed($f(a))

        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:none}},
                                    a::T, $mode1) = $f(a)


    end


    # Functions defined in CRlibm

    for f in CRlibm.functions
        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:correct}},
                                a::T, $mode1) = CRlibm.$f(a, $mode2)

        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:fast}},
                                    a::T, $mode1) = $directed($f(a))

        @eval $f{T<:AbstractFloat}(::Type{IntervalRounding{:none}},
                                    a::T, $mode1) = $f(a)

    end
end

doc"""
    setrounding(Interval, rounding_type::Symbol)

Set the rounding type used for all interval calculations on Julia v0.6 and above.
Valid `rounding_type`s are `:correct`, `:fast` and `:none`.
"""
function setrounding(::Type{Interval}, rounding_type::Symbol)

    if rounding_type == current_rounding_type[]
        return  # no need to redefine anything
    end

    if rounding_type ∉ (:correct, :fast, :none)
        throw(ArgumentError("Rounding type must be one of `:correct`, `:fast`, `:none`"))
    end

    roundtype = IntervalRounding{rounding_type}


    # binary functions:
    for f in (:+, :-, :*, :/, :^, :atan2)

        @eval $f{T<:AbstractFloat}(a::T, b::T, r::RoundingMode) = $f($roundtype, a, b, r)
    end

    @eval ^{T<:AbstractFloat, S<:Real}(a::T, b::S, r::RoundingMode) = ^($roundtype, promote(a, b)..., r)

    # unary functions:
    for f in vcat(CRlibm.functions,
                [:sqrt, :inv, :tanh, :asinh, :acosh, :atanh])

        @eval $f{T<:AbstractFloat}(a::T, r::RoundingMode) = $f($roundtype, a, r)

        @eval $f(x::Real, r::RoundingMode) = $f(float(x), r)

    end

    current_rounding_type[] = rounding_type
end

# default: correct rounding
const current_rounding_type = Symbol[:undefined]
setrounding(Interval, :correct)
