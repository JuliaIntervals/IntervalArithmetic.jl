# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Definitions of special intervals and associated functions


#= By default, intervals are expected to be represented as pair of numbers, with
the lower bound given by `inf(x)` and the upper bound by `sup(x)`.

Some flavor may behave differently (e.g. flavors using extended interval arithemetic)
=#
isempty(x::Interval) = (inf(x) == Inf && sup(x) == -Inf)
isentire(x::Interval) = (inf(x) == -Inf && sup(x) == Inf)
isbounded(x::Interval) = (isfinite(x.lo) && isfinite(x.hi)) || isempty(x)
isunbounded(x::Interval) = !isbounded(x)

"""
    isthin(x)

Checks if `x` is the set consisting of a single exactly
representable float. Any float which is not exactly representable
does *not* yield a thin interval. Corresponds to `isSingleton` of
the standard.
"""
isthin(x::Interval) = (inf(x) == sup(x))

"""
    iscommon(x)

Checks if `x` is a **common interval**, i.e. a non-empty,
bounded, real interval.
"""
function iscommon(x::Interval)
    (isentire(x) || isempty(x) || isunbounded(x)) && return false
    return true
end

"""
    widen(x)

Widen the lowest and highest bounds of `x` to the previous and next representable
floating-point numbers, respectively.
"""
widen(x::F) where {T<:AbstractFloat, F<:Interval{T}} =
    F(prevfloat(inf(x)), nextfloat(sup(x)))

"""
    wideinterval(x::AbstractFloat)
    wideinterval(::Interval, x::AbstractFloat)

Returns the interval `[prevfloat(x), nextfloat(x)]`.

Note that if no interval flavor is given, the returned interval is of the
default interval flavor. See the documentation of `Interval` for more
information about the default interval falvor.
"""
wideinterval(::Type{F}, x::T) where {F<:Interval, T<:AbstractFloat} =
    F(prevfloat(x), nextfloat(x))
wideinterval(x::T) where {T<:AbstractFloat} = wideinterval(Interval, x)

"""
    isatomic(x::Interval)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower
bound or the bounds are consecutive floating point numbers.
"""
isatomic(x::Interval) = isempty(x) || (inf(x) == sup(x)) || (sup(x) == nextfloat(inf(x)))

contains_zero(x::Interval{T}) where T = zero(T) ∈ x

"""
    isthinzero(x)

Return wether the interval only contains zero.
"""
# TODO (?) Move to pointwise boolean
isthinzero(x::Interval) = iszero(x.lo) && iszero(x.hi)
