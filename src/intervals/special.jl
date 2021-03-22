# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Definitions of special intervals and associated functions

## Empty interval:
"""`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one."""
emptyinterval(::Type{T}) where T<:Real = Interval{T}(Inf, -Inf)
emptyinterval(x::Interval{T}) where T<:Real = emptyinterval(T)
emptyinterval() = emptyinterval(precision(Interval)[1])
const ∅ = emptyinterval(Float64)

isempty(x::Interval) = x.lo == Inf && x.hi == -Inf

const ∞ = Inf

## Entire interval:
"""`entireinterval`s represent the whole Real line: [-∞, ∞]."""
entireinterval(::Type{T}) where T<:Real = Interval{T}(-Inf, Inf)
entireinterval(x::Interval{T}) where T<:Real = entireinterval(T)
entireinterval() = entireinterval(precision(Interval)[1])

isentire(x::Interval) = x.lo == -Inf && x.hi == Inf
isinf(x::Interval) = isentire(x)
isunbounded(x::Interval) = x.lo == -Inf || x.hi == Inf




isfinite(x::Interval) = isfinite(x.lo) && isfinite(x.hi)


"""
    isthin(x)

Checks if `x` is the set consisting of a single exactly
representable float. Any float which is not exactly representable
does *not* yield a thin interval. Corresponds to `isSingleton` of
the standard.
"""
isthin(x::Interval) = x.lo == x.hi

"""
    iscommon(x)

Checks if `x` is a **common interval**, i.e. a non-empty,
bounded, real interval.
"""
function iscommon(a::Interval)
    (isentire(a) || isempty(a) || isnai(a) || isunbounded(a)) && return false
    true
end

"`widen(x)` widens the lowest and highest bounds of `x` to the previous and next representable floating-point numbers, respectively."
widen(x::Interval{T}) where {T<:AbstractFloat} = Interval(prevfloat(x.lo), nextfloat(x.hi))

"""
    wideinterval(x::AbstractFloat)

Returns the interval Interval( prevfloat(x), nextfloat(x) ).
"""
wideinterval(x::T) where {T<:AbstractFloat} = Interval( prevfloat(x), nextfloat(x) )

"""
    isatomic(x::Interval)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower bound or the `nextfloat` of the lower bound.
"""
isatomic(x::Interval) = isempty(x) || (x.hi == x.lo) || (x.hi == nextfloat(x.lo))

iszero(x::Interval) = iszero(x.lo) && iszero(x.hi)

contains_zero(X::Interval{T}) where {T} = zero(T) ∈ X


# """
#     widen(x)
#
# Widens the lowest and highest bounds of `x` to the previous
# and next representable floating-point numbers, respectively.
# """
# widen(x::Interval{T}) where T<:AbstractFloat =
#     Interval(prevfloat(x.lo), nextfloat(x.hi))

"""
    zero_interval(T)

Return the zero interval `Interval(0, 0)` in the numeric type `T`.
"""
zero_interval(::Type{T}) where T<:Real = zero(Interval{T})
zero_interval(x::Interval{T}) where T<:Real = zero(Interval{T})
