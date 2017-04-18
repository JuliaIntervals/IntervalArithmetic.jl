# This file is part of the IntervalArithmetic.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

## Interval type

abstract type AbstractInterval{T} <: Real end

struct Interval{T<:Real} <: AbstractInterval{T}
    lo :: T
    hi :: T

    function Interval{T}(a::Real, b::Real) where T

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
        if a == Inf || b == -Inf
            throw(ArgumentError(
                "Must satisfy `a < Inf` and `b > -Inf` to construct Interval(a, b)."))
        end

        return new(a,b)

    end
end


## Outer constructors

Interval(a::T, b::T) where T<:Real = Interval{T}(a, b)
Interval(a::T) where T<:Real = Interval(a, a)
Interval(a::Tuple) = Interval(a...)
Interval(a::T, b::S) where {T<:Real, S<:Real} = Interval(promote(a,b)...)

## Concrete constructors for Interval, to effectively deal only with Float64,
# BigFloat or Rational{Integer} intervals.
Interval(a::T, b::T) where T<:Integer = Interval(float(a), float(b))
Interval(a::T, b::T) where T<:Irrational = Interval(float(a), float(b))

eltype(x::Interval{T}) where T<:Real = T

Interval(x::Interval) = x
Interval(x::Complex) = Interval(real(x)) + im*Interval(imag(x))

Interval{T}(x) where T = Interval(convert(T, x))

Interval{T}(x::Interval) where T = convert(Interval{T}, x)

"""
    interval(a, b)

Construct a valid interval, checking the end points.
"""

function interval(a::Real, b::Real)

    if isnan(a) || isnan(b)
        return new(NaN, NaN)  # nai
    end

    if a > b
        (isinf(a) && isinf(b)) && return Interval(a, b)  # empty interval = [∞,-∞]

        throw(ArgumentError("Must have a ≤ b to construct interval(a, b)."))
    end

    Interval(a, b)
end


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

# a..b = Interval(convert(Interval, a).lo, convert(Interval, b).hi)

..(a::Integer, b::Integer) = Interval(a, b)
..(a::Integer, b::Real) = Interval(a, nextfloat(float(b)))
..(a::Real, b::Integer) = Interval(prevfloat(float(a)), b)

..(a::Real, b::Real) = Interval(prevfloat(float(a)), nextfloat(float(b)))

macro I_str(ex)  # I"[3,4]"
    @interval(ex)
end

a ± b = (a-b)..(a+b)
