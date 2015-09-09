# This file is part of the ValidatedNumerics.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

## Interval type

immutable Interval{T<:Real} <: Real
    lo :: T
    hi :: T

    function Interval(a::Real, b::Real)
        (isinf(a) && isinf(b)) && return new(a,b)
        if a > b
            a, b = b, a
        end
        new(a, b)
    end
end


## Outer constructors

Interval{T<:Real}(a::T, b::T) = Interval{T}(a, b)
Interval{T<:Real}(a::T) = Interval(a, a)
Interval(a::Tuple) = Interval(a...)
Interval{T<:Real, S<:Real}(a::T, b::S) = Interval(promote(a,b)...)

eltype{T<:Real}(x::Interval{T}) = T


## Definitions of special intervals
## Empty interval:
@doc doc"""`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one.""" ->

emptyinterval(T::Type) = Interval(convert(T, Inf), convert(T, -Inf))
emptyinterval(x::Interval) =
    Interval(convert(eltype(x), Inf), convert(eltype(x), -Inf))

∅ = emptyinterval(Float64)
emptyinterval() = ∅

isempty(x::Interval) = x.lo == Inf && x.hi == -Inf


## Entire interval:
@doc doc"""`entireinterval`s represent the whole Real line: [-∞, ∞].""" ->
entireinterval(T::Type) = Interval(convert(T, -Inf), convert(T, Inf))
entireinterval(x::Interval) =
    Interval(convert(eltype(x), -Inf), convert(eltype(x), Inf))
entireinterval() = entireinterval(Float64)

isentire(x::Interval) = x.lo == -Inf && x.hi == Inf


# NaI: not-an-interval
@doc doc"""`NaI` not-an-interval: [NaN, NaN].""" ->
nai(T::Type) = Interval(convert(T, NaN), convert(T, NaN))
nai(x::Interval) = Interval(convert(eltype(x), NaN), convert(eltype(x), NaN))
nai() = nai(Float64)

isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)


## A "thin" interval (one for which there is "no more precision")
# Note that this is not the standard usage of "thin interval", which is one for
# which the two endpoints are *strictly* equal

isthin(x::Interval) = (m = mid(x); m == x.lo || m == x.hi)

## Widen:
widen{T<:FloatingPoint}(x::Interval{T}) = Interval(prevfloat(x.lo), nextfloat(x.hi))


## Include files
include("printing.jl")
include("rationalize.jl")
include("parameters.jl")
include("rounding.jl")
include("macro_definitions.jl")
include("conversion_promotion.jl")
include("arithmetic.jl")
include("precision.jl")
include("trigonometric_functions.jl")
include("functions.jl")
