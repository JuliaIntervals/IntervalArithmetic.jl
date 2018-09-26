#= Design summary:

This is a so-called "traits-based" design, as follows.

The main body of the file defines versions of elementary functions with all allowed
interval rounding types, e.g.
+(IntervalRounding{:tight}, a, b, RoundDown)
+(IntervalRounding{:accurate}, a, b, RoundDown)
+(IntervalRounding{:slow}, a, b, RoundDown)
+(IntervalRounding{:none}, a, b, RoundDown)

The current allowed rounding types are
- :tight     # fast, tight (correct) rounding with errorfree arithmetic via FastRounding.jl
- :accurate # fast "accurate" rounding using prevfloat and nextfloat  (slightly wider than needed)
- :slow    # tight (correct) rounding by changing rounding mode (slow)
- :none     # no rounding (for speed comparisons; no enclosure is guaranteed)

The function `setrounding(Interval, rounding_type)` then defines rounded
 functions *without* an explicit rounding type, e.g.

sin(x, r::RoundingMode) = sin(IntervalRounding{:slow}, x, r)

These are overwritten when `setrounding(Interval, rounding_type)` is called again.

In Julia v0.6 and later (but *not* in Julia v0.5), this automatically redefines all relevant functions, in particular those used in +(a::Interval, b::Interval) etc., so that all interval functions automatically use the correct interval rounding type from then on.
=#


"""Interval rounding trait type"""
struct IntervalRounding{T} end




# Functions that are the same for all rounding types:

# unary plus and minus:
+(a::T, ::RoundingMode) where {T<:AbstractFloat} =  a  # ignore rounding
-(a::T, ::RoundingMode) where {T<:AbstractFloat} = -a  # ignore rounding

# zero:
zero(a::Interval{T}, ::RoundingMode) where {T<:AbstractFloat} = zero(T)
zero(::Type{T}, ::RoundingMode) where {T<:AbstractFloat} = zero(T)

convert(::Type{BigFloat}, x, rounding_mode::RoundingMode) =
    setrounding(BigFloat, rounding_mode) do
        convert(BigFloat, x)
    end

parse(::Type{T}, x::AbstractString, rounding_mode::RoundingMode) where {T} = setrounding(T, rounding_mode) do
    parse(T, x)
end

# use BigFloat parser to get round issues on Windows:
function parse(::Type{Float64}, s::AbstractString, r::RoundingMode)
    a = setprecision(BigFloat, 53) do
            setrounding(BigFloat, r) do
                parse(BigFloat, s)   # correctly takes account of rounding mode
            end
        end

    return Float64(a, r)
end


sqrt(a::T, rounding_mode::RoundingMode) where {T<:Rational} = setrounding(float(T), rounding_mode) do
    sqrt(float(a))
end


# no-ops for rational rounding:
for f in (:+, :-, :*, :/)
    @eval $f(a::T, b::T, ::RoundingMode) where {T<:Rational} = $f(a, b)
end

# error-free arithmetic:

for (op, f) in ( (:+, :add), (:-, :sub), (:*, :mul), (:/, :div) )
    ff = Symbol(f, "_round")

    for T in (Float32, Float64)
        for mode in (:Down, :Up)

            mode1 = Expr(:quote, mode)
            mode1 = :(::RoundingMode{$mode1})

            mode2 = Symbol("Round", mode)

            @eval $op(::IntervalRounding{:tight},
                                a::$T, b::$T, $mode1) = $ff(a, b, $mode2)
        end
    end
end

# inv and sqrt:

# inv(::IntervalRounding{:tight}, a::T, r::RoundingMode) where T<:Union{Float32, Float64} = inv_round(a, r)
#
# sqrt(::IntervalRounding{:tight}, a::T, r::RoundingMode) where T<:Union{Float32, Float64} = sqrt_round(a, r)


for T in (Float32, Float64)
    for mode in (:Down, :Up)

        mode1 = Expr(:quote, mode)
        mode1 = :(::RoundingMode{$mode1})

        mode2 = Symbol("Round", mode)

        @eval inv(::IntervalRounding{:tight},
                            a::$T, $mode1) = inv_round(a, $mode2)

        @eval sqrt(::IntervalRounding{:tight},
                            a::$T, $mode1) = sqrt_round(a, $mode2)
        end
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
    for f in (:+, :-, :*, :/, :atan)

        @eval function $f(::IntervalRounding{:slow},
                          a::T, b::T, $mode1) where T<:AbstractFloat
                    setrounding(T, $mode2) do
                        $f(a, b)
                    end
                end

        @eval function $f(::IntervalRounding{:tight},
                                  a::T, b::T, $mode1) where T<:AbstractFloat
                            setrounding(T, $mode2) do
                                $f(a, b)
                            end
                        end

        @eval $f(::IntervalRounding{:accurate},
                  a::T, b::T, $mode1) where {T<:AbstractFloat} = $directed($f(a, b))

        @eval $f(::IntervalRounding{:none},
                  a::T, b::T, $mode1) where {T<:AbstractFloat} = $f(a, b)

    end


    # power:

    @eval function ^(::IntervalRounding{:slow},
                               a::BigFloat, b::S, $mode1) where S<:Real
                  setrounding(BigFloat, $mode2) do
                      ^(a, b)
                  end
           end

    # for correct rounding for Float64, must pass through BigFloat:
    @eval function ^(::IntervalRounding{:slow}, a::Float64, b::S, $mode1) where S<:Real
        setprecision(BigFloat, 53) do
            Float64(^(IntervalRounding{:slow}, BigFloat(a), b, $mode2))
        end
    end

    @eval ^(::IntervalRounding{:accurate},
      a::T, b::S, $mode1) where {T<:AbstractFloat,S<:Real} = $directed(a^b)

    @eval ^(::IntervalRounding{:none},
      a::T, b::S, $mode1) where {T<:AbstractFloat,S<:Real} = a^b


    # functions not in CRlibm:
    for f in (:sqrt, :inv, :tanh, :asinh, :acosh, :atanh)


        @eval function $f(::IntervalRounding{:slow},
                          a::T, $mode1) where T<:AbstractFloat
                            setrounding(T, $mode2) do
                                $f(a)
                            end
               end

        @eval function $f(::IntervalRounding{:tight},
                                 a::T, $mode1) where T<:AbstractFloat
                                   $f(IntervalRounding{:slow}(), a, $mode2)
                      end


        @eval $f(::IntervalRounding{:accurate},
                  a::T, $mode1) where {T<:AbstractFloat} = $directed($f(a))

        @eval $f(::IntervalRounding{:none},
                  a::T, $mode1) where {T<:AbstractFloat} = $f(a)


    end


    # Functions defined in CRlibm

    for f in CRlibm.functions
        @eval $f(::IntervalRounding{:slow},
              a::T, $mode1) where {T<:AbstractFloat} = CRlibm.$f(a, $mode2)

        @eval $f(::IntervalRounding{:accurate},
                  a::T, $mode1) where {T<:AbstractFloat} = $directed($f(a))

        @eval $f(::IntervalRounding{:none},
                  a::T, $mode1) where {T<:AbstractFloat} = $f(a)

    end
end


const rounding_types = (:tight, :accurate, :slow, :none)

function _setrounding(::Type{Interval}, rounding_type::Symbol)

    if rounding_type == current_rounding_type[]
        return  # no need to redefine anything
    end

    if rounding_type ∉ rounding_types
        throw(ArgumentError("Rounding type must be one of $rounding_types"))
    end

    roundtype = IntervalRounding{rounding_type}()


    # binary functions:
    for f in (:+, :-, :*, :/)
        @eval $f(a::T, b::T, r::RoundingMode) where {T<:AbstractFloat} = $f($roundtype, a, b, r)
    end

    # unary functions:

    for f in (:sqrt, :inv)
        @eval $f(a::T, r::RoundingMode) where {T<:AbstractFloat} = $f($roundtype, a, r)
    end

    if rounding_type == :tight   # for remaining functions, use CRlibm
        roundtype = IntervalRounding{:slow}()
    end


    for f in (:^, :atan)

        @eval $f(a::T, b::T, r::RoundingMode) where {T<:AbstractFloat} = $f($roundtype, a, b, r)
    end

    @eval ^(a::T, b::S, r::RoundingMode) where {T<:AbstractFloat, S<:Real} = ^($roundtype, promote(a, b)..., r)

    # unary functions:
    for f in vcat(CRlibm.functions,
                    [:tanh, :asinh, :acosh, :atanh])

        @eval $f(a::T, r::RoundingMode) where {T<:AbstractFloat} = $f($roundtype, a, r)

        @eval $f(x::Real, r::RoundingMode) = $f(float(x), r)

    end

    current_rounding_type[] = rounding_type
end

"""
    setrounding(Interval, rounding_type::Symbol)

Set the rounding type used for all interval calculations on Julia v0.6 and above.
Valid `rounding_type`s are $rounding_types.
"""
function setrounding(::Type{Interval}, rounding_type::Symbol)

    # suppress redefinition warnings:
    # modified from OhMyREPL.jl

    # dump the warnings to a file, and check the file to make
    # sure they are only redefinition warnings

    path, io = mktemp()

    old_stderr = stderr
    redirect_stderr(io)

    _setrounding(Interval, rounding_type)

    redirect_stderr(old_stderr)

    close(io)

    # check
    lines = readlines(path)

    # print(lines)

    for line in lines

        if line == ""
            continue
        end

        if !startswith(line, "WARNING: Method definition")

            if startswith(line, "WARNING") || startswith(line, "Use")
                warn(line)

            else
                println("Error on line: ", line)
                error(line)
            end
        end
    end

    return rounding_type

end

rounding(Interval) = current_rounding_type[]



# default: correct rounding
const current_rounding_type = Symbol[:undefined]
setrounding(Interval, :tight)
