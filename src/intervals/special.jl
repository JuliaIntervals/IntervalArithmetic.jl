# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Definitions of special intervals and associated functions

## Empty interval:
doc"""`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one."""
emptyinterval{T<:Real}(::Type{T}) = Interval{T}(Inf, -Inf)
emptyinterval{T<:Real}(x::Interval{T}) = emptyinterval(T)
emptyinterval() = emptyinterval(precision(Interval)[1])
const ∅ = emptyinterval(Float64)

isempty(x::Interval) = x.lo == Inf && x.hi == -Inf

const ∞ = Inf

## Entire interval:
doc"""`entireinterval`s represent the whole Real line: [-∞, ∞]."""
entireinterval{T<:Real}(::Type{T}) = Interval{T}(-Inf, Inf)
entireinterval{T<:Real}(x::Interval{T}) = entireinterval(T)
entireinterval() = entireinterval(precision(Interval)[1])

isentire(x::Interval) = x.lo == -Inf && x.hi == Inf
isunbounded(x::Interval) = x.lo == -Inf || x.hi == Inf


# NaI: not-an-interval
doc"""`NaI` not-an-interval: [NaN, NaN]."""
nai{T<:Real}(::Type{T}) = Interval{T}(convert(T, NaN), convert(T, NaN))
nai{T<:Real}(x::Interval{T}) = nai(T)
nai() = nai(precision(Interval)[1])

isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)

isfinite(x::Interval) = isfinite(x.lo) && isfinite(x.hi)
isnan(x::Interval) = isnai(x)

doc"""`isthin(x)` corresponds to `isSingleton`, i.e. it checks if `x` is the set consisting of a single exactly representable float. Thus any float which is not exactly representable does *not* yield a thin interval."""
function isthin(x::Interval)
    # (m = mid(x); m == x.lo || m == x.hi)
    x.lo == x.hi
end

doc"`iscommon(x)` checks if `x` is a **common interval**, i.e. a non-empty, bounded, real interval."
function iscommon(a::Interval)
    (isentire(a) || isempty(a) || isnai(a) || isunbounded(a)) && return false
    true
end

doc"`widen(x)` widens the lowest and highest bounds of `x` to the previous and next representable floating-point numbers, respectively."
widen{T<:AbstractFloat}(x::Interval{T}) = Interval(prevfloat(x.lo), nextfloat(x.hi))

"""
    wideinterval(x::AbstractFloat)

Returns the interval Interval( prevfloat(x), nextfloat(x) ).
"""
wideinterval{T<:AbstractFloat}(x::T) = Interval( prevfloat(x), nextfloat(x) )

isatomic(x::Interval) = isempty(x) || (x.hi == x.lo) || (x.hi == nextfloat(x.lo))
