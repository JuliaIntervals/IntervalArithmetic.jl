# This file is part of the IntervalArithmetic.jl package; MIT licensed

# Decorated intervals, following the IEEE 1758-2015 standard

"""
    DECORATION

Enumeration constant for the types of interval decorations.
The nomenclature of the follows the IEEE-1788 (2015) standard
(sect 11.2):

- `com -> 4`: common: bounded, non-empty
- `dac -> 3`: defined (nonempty) and continuous
- `def -> 2`: defined (nonempty)
- `trv -> 1`: always true (no information)
- `ill -> 0`: nai ("not an interval")
"""
@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# Note that `isweaklyless`, and hence ``<` and `min`, are automatically defined for enums

"""
    DecoratedInterval

A *decorated* interval is an interval, together with a *decoration*, i.e.
a flag that records the status of the interval when thought of as the result
of a previously executed sequence of functions acting on an initial interval.
"""

struct DecoratedInterval{T}
    interval::Interval{T}
    decoration::DECORATION
end

DecoratedInterval(I::DecoratedInterval, dec::DECORATION) = DecoratedInterval(I.interval, dec)

function DecoratedInterval(a::T, b::S, d::DECORATION) where {T<:Real, S<:Real}
    BoundsType = getnumtype(T, S)
    is_valid_interval(a, b) || return DecoratedInterval(Interval{BoundsType}(a, b), ill)
    return DecoratedInterval(Interval{BoundsType}(a, b), d)
end

DecoratedInterval(a::Real, d::DECORATION) = DecoratedInterval(a, a, d)
DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(a..., d)

function DecoratedInterval{T}(I::Interval) where {T}
    d = decoration(I)
    d <= trv && return DecoratedInterval{T}(I, d)
    d == ill && return DecoratedInterval{T}(nai(I), d)
    return DecoratedInterval{T}(I, d)
end

DecoratedInterval(I::Interval) = DecoratedInterval{default_bound()}(I)

function DecoratedInterval(a::T, b::S) where {T<:Real, S<:Real}
    BoundsType = getnumtype(T, S)
    is_valid_interval(a, b) || return DecoratedInterval(Interval{BoundsType}(a, b), ill)
    return DecoratedInterval(Interval{BoundsType}(a, b))
end

DecoratedInterval(a::Real) = DecoratedInterval(a, a)
DecoratedInterval(a::Tuple) = DecoratedInterval(a...)

interval(x::DecoratedInterval) = x.interval
decoration(x::DecoratedInterval) = x.decoration

# Automatic decorations for an Interval
function decoration(I::Interval)
    isnai(I) && return ill           # nai()
    isempty(I) && return trv         # emptyinterval
    isunbounded(I) && return dac     # unbounded
    com                              # common
end

big(x::DecoratedInterval) = DecoratedInterval(big(interval(x)), decoration(x))

macro decorated(ex...)
    if !(ex[1] isa String)
        if length(ex) == 1
            x = :(@interval($(esc(ex[1]))))
            lo = :(inf($x))
            hi = :(sup($x))
        else
            lo, hi = ex
        end

        return :(DecoratedInterval($lo, $hi))
    else
        s = ex[1]
        parse(DecoratedInterval{Float64}, s)
    end
end
