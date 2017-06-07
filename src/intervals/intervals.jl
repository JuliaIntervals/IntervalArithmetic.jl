# This file is part of the IntervalArithmetic.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

## Interval type

abstract AbstractInterval <: Real

immutable Interval{T<:Real} <: AbstractInterval
    lo :: T
    hi :: T

    function Interval(a::Real, b::Real)

        if isnan(a) || isnan(b)
            return new(NaN, NaN)  # nai
        end

        if a > b
            # empty interval = [∞,-∞]
            (isinf(a) && isinf(b)) && return new(a, b)
            throw(ArgumentError("Must have a ≤ b to construct Interval(a, b)."))
        end

        # The IEEE Std 1788-2015 states that a < Inf and b > -Inf;
        # see page 6, "bounds".
        if a == Inf
            return new(prevfloat(a), b)
        elseif b == -Inf
            return new(a, nextfloat(b))
        end

        new(a, b)
    end
end


## Outer constructors

Interval{T<:Real}(a::T, b::T) = Interval{T}(a, b)
Interval{T<:Real}(a::T) = Interval(a, a)
Interval(a::Tuple) = Interval(a...)
Interval{T<:Real, S<:Real}(a::T, b::S) = Interval(promote(a,b)...)

## Concrete constructors for Interval, to effectively deal only with Float64,
# BigFloat or Rational{Integer} intervals.
Interval{T<:Integer}(a::T, b::T) = Interval(float(a), float(b))
Interval{T<:Irrational}(a::T, b::T) = Interval(float(a), float(b))

eltype{T<:Real}(x::Interval{T}) = T

Interval(x::Interval) = x
Interval(x::Complex) = Interval(real(x)) + im*Interval(imag(x))

(::Type{Interval{T}}){T}(x) = Interval(convert(T, x))

(::Type{Interval{T}}){T}(x::Interval) = convert(Interval{T}, x)

## Include files
include("special.jl")
include("macros.jl")
include("rounding_macros.jl")
include("rounding.jl")
include("conversion.jl")
include("precision.jl")
include("set_operations.jl")
include("arithmetic.jl")
include("functions.jl")
include("trigonometric.jl")
include("hyperbolic.jl")


# Syntax for intervals

a..b = Interval(convert(Interval, a).lo, convert(Interval, b).hi)

macro I_str(ex)  # I"[3,4]"
    @interval(ex)
end

a ± b = (a-b)..(a+b)
