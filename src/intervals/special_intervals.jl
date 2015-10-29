# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Definitions of special intervals

## Empty interval:
@doc doc"""`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one.""" ->

emptyinterval{T<:Real}(::Type{T}) = Interval{T}(Inf, -Inf)
emptyinterval{T<:Real}(x::Interval{T}) = emptyinterval(T)
emptyinterval() = emptyinterval(get_interval_precision()[1])
∅ = emptyinterval(Float64)

isempty(x::Interval) = x.lo == Inf && x.hi == -Inf


## Entire interval:
@doc doc"""`entireinterval`s represent the whole Real line: [-∞, ∞].""" ->
entireinterval{T<:Real}(::Type{T}) = Interval{T}(-Inf, Inf)
entireinterval{T<:Real}(x::Interval{T}) = entireinterval(T)
entireinterval() = entireinterval(get_interval_precision()[1])

isentire(x::Interval) = x.lo == -Inf && x.hi == Inf
isunbounded(x::Interval) = x.lo == -Inf || x.hi == Inf


# NaI: not-an-interval
@doc doc"""`NaI` not-an-interval: [NaN, NaN].""" ->
nai{T<:Real}(::Type{T}) = Interval{T}(NaN,NaN)
nai{T<:Real}(x::Interval{T}) = nai(T)
nai() = nai(get_interval_precision()[1])

isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)


## isthin corresponds to isSingleton; note that an interval corresponding
# to any float which is not exactly representable in a binary expansion
# does not yield a thin interval
function isthin(x::Interval)
    # (m = mid(x); m == x.lo || m == x.hi)
    x.lo == x.hi
end


# A common is a nonempty bounded real interval
function iscommon(a::Interval)
    (isentire(a) || isempty(a) || isnai(a) || isunbounded(a)) && return false
    true
end

## Widen:
widen{T<:AbstractFloat}(x::Interval{T}) = Interval(prevfloat(x.lo), nextfloat(x.hi))
