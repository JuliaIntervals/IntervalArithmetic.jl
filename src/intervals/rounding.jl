#= Design summary:

This is a so-called "traits-based" design, as follows.

The main body of the file defines versions of elementary functions with all allowed
interval rounding types, e.g.
+(IntervalRounding{:fast}(), a, b, RoundDown)
+(IntervalRounding{:tight}(), a, b, RoundDown)
+(IntervalRounding{:accurate}(), a, b, RoundDown)
+(IntervalRounding{:slow}(), a, b, RoundDown)
+(IntervalRounding{:none}(), a, b, RoundDown)

The current allowed rounding types are
- :fast     # fast, tight (correct) rounding with errorfree arithmetic via FastRounding.jl
- :tight # tight (correct) rounding with improved errorfree arithmetic via RoundingEmulator.jl
- :accurate # fast "accurate" rounding using prevfloat and nextfloat  (slightly wider than needed)
- :slow    # tight (correct) rounding by changing rounding mode (slow)
- :none     # no rounding (for speed comparisons; no enclosure is guaranteed)

The function `setrounding(Interval, rounding_type)` then defines rounded
 functions *without* an explicit rounding type, e.g.

sin(x, r::RoundingMode) = sin(IntervalRounding{:slow}, x, r)

These are overwritten when `setrounding(Interval, rounding_type)` is called again.
=#


"""
    IntervalRounding{T}

Interval rounding trait type.

Allowed rounding types are
- `:tight`: fast, tight (correct) rounding with errorfree arithmetic via
            FastRounding.jl.
- `:accurate`: fast "accurate" rounding using prevfloat and nextfloat
               (slightly wider than needed).
- `:slow`: tight (correct) rounding by changing rounding mode (slow).
- `:none`: no rounding (for speed comparisons; no enclosure is guaranteed).
"""
struct IntervalRounding{T} end

## Default
const rounding_types = (:fast, :tight, :accurate, :slow, :none)

interval_rounding() = IntervalRounding{:tight}()

# BigFloat conversion
convert(::Type{BigFloat}, x, rounding_mode::RoundingMode) =
    setrounding(BigFloat, rounding_mode) do
        convert(BigFloat, x)
    end

# Parsing from string
parse(::Type{T}, x::AbstractString, rounding_mode::RoundingMode) where T = setrounding(Float64, rounding_mode) do
    return float(parse(T, x))
end

# use higher precision float parser to get round issues on Windows
@static if Sys.iswindows()
    function parse(::Type{Float64}, s::AbstractString, r::RoundingMode)
        a = setprecision(BigFloat, 53) do
                setrounding(BigFloat, r) do
                    parse(BigFloat, s)   # correctly takes account of rounding mode
                end
            end

        return Float64(a, r)
    end

    function parse(::Type{T}, s::AbstractString, r::RoundingMode) where {T <: Union{Float16, Float32}}
        return T(parse(Float64, s, r), r)
    end
end


## Functions that are the same for all rounding types:
+(a::T, ::RoundingMode) where {T<:AbstractFloat} =  a  # ignore rounding
-(a::T, ::RoundingMode) where {T<:AbstractFloat} = -a  # ignore rounding
zero(a::Interval{T}, ::RoundingMode) where {T<:AbstractFloat} = zero(T)
zero(::Type{T}, ::RoundingMode) where {T<:AbstractFloat} = zero(T)

## Rationals
# TODO (?) Restore support for rational intervals
# no-ops for rational rounding:
for f in (:+, :-, :*, :/)
    @eval $f(a::T, b::T, ::RoundingMode) where {T<:Rational} = $f(a, b)
end

function sqrt(a::T, rounding_mode::RoundingMode) where {T<:Rational}
    setrounding(float(T), rounding_mode) do
        return sqrt(float(a))
    end
end

rounding_directions = [
    (:down, RoundingMode{:Down}, prevfloat),
    (:up, RoundingMode{:Up}, nextfloat)
]

# TODO Check what type restriction are actually needed here
# TODO :none mode is defined twice since it does not depend on the rounding
# direction
for (dir, RoundingDirection, outfloat) in rounding_directions
    #= :fast and :tight for functions supported by FastRounding.jl
        and RoundingEmulator.jl =#
    # NOTE RoundingEmulator.jl only works with Float32 and Float64
    for (op, f) in ( (:+, :add), (:-, :sub), (:*, :mul), (:/, :div) )
        @eval function $op(::IntervalRounding{:fast}, a, b, ::$RoundingDirection)
            return FastRounding.$(Symbol(f, "_round"))(a, b, $RoundingDirection())
        end
        
        @eval function $op(
                ::IntervalRounding{:tight}, a::T, b::T,
                ::$RoundingDirection) where {T<:Union{Float32, Float64}}
            return RoundingEmulator.$(Symbol(f, "_", dir))(a, b)
        end
    end

    # Sqrt
    @eval function sqrt(::IntervalRounding{:fast}, a, ::$RoundingDirection)
        return FastRounding.sqrt_round(a, $dir)
    end

    @eval function sqrt(::IntervalRounding{:tight}, a::Union{Float32, Float64}, ::$RoundingDirection)
        return RoundingEmulator.$(Symbol("sqrt_", dir))(a)
    end

    # Inverse
    @eval function inv(::IntervalRounding{:fast}, a, ::$RoundingDirection)
        return FastRounding.inv_round(a, $dir)
    end

    @eval function inv(::IntervalRounding{:tight}, a::Union{Float32, Float64}, ::$RoundingDirection)
        return RoundingEmulator.$(Symbol("div_", dir))(one(a), a)
    end

    #= :accurate and :slow =#
    # Power
    @eval function ^(::IntervalRounding{:accurate}, a::AbstractFloat, b, ::$RoundingDirection)
        return $outfloat(a^b)
    end

    @eval function ^(::IntervalRounding{:slow}, a::BigFloat, b::AbstractFloat, ::$RoundingDirection)
        setrounding(BigFloat, $RoundingDirection()) do
            return a^b
        end
    end

    # Correct rounding of other floats must pass through BigFloat
    @eval function ^(::IntervalRounding{:slow}, a::T, b, ::$RoundingDirection) where {T<:AbstractFloat}
        setprecision(BigFloat, 53) do
            return T(^(IntervalRounding{:slow}, BigFloat(a), b, $RoundingDirection()))
        end
    end

    # Binary function
    for f in (:+, :-, :*, :/, :^, :atan)
        @eval function $f(::IntervalRounding{:accurate}, a::T, b::T, ::$RoundingDirection) where {T<:AbstractFloat}
            return $outfloat($f(a, b))
        end
        
        @eval function $f(::IntervalRounding{:slow}, a::T, b::T, ::$RoundingDirection) where {T<:AbstractFloat}
            setrounding(T, $RoundingDirection()) do
                return $f(a, b)
            end
        end
    end

    # Unary functions not in CRlibm:
    for f in (:sqrt, :inv, :tanh, :asinh, :acosh, :atanh, :cot)
        @eval function $f(::IntervalRounding{:accurate}, a::AbstractFloat, ::$RoundingDirection)
            return $outfloat($f(a))
        end

        @eval function $f(::IntervalRounding{:slow}, a::T, ::$RoundingDirection) where {T<:AbstractFloat}
            setrounding(T, $RoundingDirection()) do
                return $f(a)
            end
        end
    end

    # Functions defined in CRlibm
    for f in CRlibm.functions
        @eval function $f(::IntervalRounding{:accurate}, a::AbstractFloat, ::$RoundingDirection)
            return $outfloat($f(a))
        end

        @eval function $f(::IntervalRounding{:slow}, a::AbstractFloat, ::$RoundingDirection)
            return CRlibm.$f(a, $RoundingDirection())
        end
    end
end

#= Default definitions, fallback and :none =#
# Binary functions
for f in (:+, :-, :*, :/, :^, :atan)
    @eval $f(a::T, b::T, r::RoundingMode) where {T<:AbstractFloat} = $f(interval_rounding(), a, b, r)
    @eval $f(a::Real, b::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), promote(a, b)..., r)
    @eval $f(a::AbstractFloat, b::Real, r::RoundingMode) = $f(interval_rounding(), promote(a, b)..., r)
    @eval $f(a::AbstractFloat, b::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), promote(a, b)..., r)
    @eval $f(a::Real, b::Real, r::RoundingMode) = $f(interval_rounding(), float(a), float(b), r)

    # Fallback to :slow if the requested interval rounding is unavailable
    @eval function $f(::IntervalRounding, a, b, r::RoundingMode)
        return $f(IntervalRounding{:slow}(), a, b, r)
    end

    # No rounding
    @eval function $f(::IntervalRounding{:none}, a, b, r::RoundingMode)
        return $f(a, b)
    end
end

# Unary functions
for f in vcat(CRlibm.functions, [:sqrt, :inv, :tanh, :asinh, :acosh, :atanh, :cot])
    @eval $f(a::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), a, r)
    @eval $f(a::Real, r::RoundingMode) = $f(interval_rounding(), float(a), r)

    # Fallback to :slow if the requested interval rounding is unavailable
    @eval function $f(::IntervalRounding, a, r::RoundingMode)
        return $f(IntervalRounding{:slow}(), a, r)
    end

    # No rounding
    @eval function $f(::IntervalRounding{:none}, a, r::RoundingMode)
        return $f(a)
    end
end
