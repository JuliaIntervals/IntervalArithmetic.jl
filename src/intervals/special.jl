# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Definitions of special intervals and associated functions

const ∞ = Inf

## Empty interval:
"""
    emptyinterval(::Type{T})

Return an `emptyinterval` with interval bounds of type `T`.

`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one."""
emptyinterval(::Type{T}) where {T<:Real} = Interval{T}(Inf, -Inf)
emptyinterval() = emptyinterval(precision(BaseInterval)[1])
const ∅ = emptyinterval(Float64)

emptyinterval(x::IT) where {IT<:AnyInterval} = AnyInterval(Inf, -Inf)

isempty(x::BaseInterval) = x.lo == Inf && x.hi == -Inf

## Entire interval:
"""`entireinterval`s represent the whole Real line: [-∞, ∞]."""
entireinterval(::Type{T}) where T<:Real = BaseInterval{T}(-Inf, Inf)
entireinterval(x::BaseInterval{T}) where T<:Real = entireinterval(T)
entireinterval() = entireinterval(precision(BaseInterval)[1])

isentire(x::BaseInterval) = x.lo == -Inf && x.hi == Inf
isinf(x::BaseInterval) = isentire(x)
isunbounded(x::BaseInterval) = x.lo == -Inf || x.hi == Inf


# NaI: not-an-interval
"""`NaI` not-an-interval: [NaN, NaN]."""
nai(::Type{T}) where T<:Real = BaseInterval{T}(convert(T, NaN), convert(T, NaN))
nai(x::BaseInterval{T}) where T<:Real = nai(T)
nai() = nai(precision(BaseInterval)[1])

isnai(x::BaseInterval) = isnan(x.lo) || isnan(x.hi)

isfinite(x::BaseInterval) = isfinite(x.lo) && isfinite(x.hi)
isnan(x::BaseInterval) = isnai(x)

"""
    isthin(x)

Checks if `x` is the set consisting of a single exactly
representable float. Any float which is not exactly representable
does *not* yield a thin interval. Corresponds to `isSingleton` of
the standard.
"""
isthin(x::BaseInterval) = x.lo == x.hi

"""
    iscommon(x)

Checks if `x` is a **common interval**, i.e. a non-empty,
bounded, real interval.
"""
function iscommon(a::BaseInterval)
    (isentire(a) || isempty(a) || isnai(a) || isunbounded(a)) && return false
    true
end

"`widen(x)` widens the lowest and highest bounds of `x` to the previous and next representable floating-point numbers, respectively."
widen(x::BaseInterval{T}) where {T<:AbstractFloat} = BaseInterval(prevfloat(x.lo), nextfloat(x.hi))

"""
    wideinterval(x::AbstractFloat)

Returns the interval BaseInterval( prevfloat(x), nextfloat(x) ).
"""
wideinterval(x::T) where {T<:AbstractFloat} = BaseInterval( prevfloat(x), nextfloat(x) )

"""
    isatomic(x::BaseInterval)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower bound or the `nextfloat` of the lower bound.
"""
isatomic(x::BaseInterval) = isempty(x) || (x.hi == x.lo) || (x.hi == nextfloat(x.lo))

iszero(x::BaseInterval) = iszero(x.lo) && iszero(x.hi)

contains_zero(X::BaseInterval{T}) where {T} = zero(T) ∈ X


# """
#     widen(x)
#
# Widens the lowest and highest bounds of `x` to the previous
# and next representable floating-point numbers, respectively.
# """
# widen(x::BaseInterval{T}) where T<:AbstractFloat =
#     BaseInterval(prevfloat(x.lo), nextfloat(x.hi))
