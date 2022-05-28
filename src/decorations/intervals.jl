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

    function DecoratedInterval{T}(I::Interval, d::DECORATION) where T
        dd = min(d, decoration(I))
        dd == ill && return new{T}(Interval(T(NaN), T(NaN)), ill)
        return new{T}(I, dd)
    end
end

DecoratedInterval(I::Interval{T}, d::DECORATION) where T = DecoratedInterval{T}(I, d)

DecoratedInterval(I::DecoratedInterval, dec::DECORATION) = DecoratedInterval(I.interval, dec)

DecoratedInterval(a::Real, b::Real, d::DECORATION) = DecoratedInterval(Interval(a, b), d)

DecoratedInterval(a::Real, d::DECORATION) = DecoratedInterval(a, a, d)
DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(a..., d)

function DecoratedInterval{T}(I::Interval) where {T}
    d = decoration(I)
    return DecoratedInterval{T}(I, d)
end

DecoratedInterval(I::Interval{T}) where T = DecoratedInterval{T}(I)

DecoratedInterval(a::Real, b::Real) = DecoratedInterval(Interval(a,b))

DecoratedInterval(a::Real) = DecoratedInterval(a, a)
DecoratedInterval(a::Tuple) = DecoratedInterval(a...)

function interval(x::DecoratedInterval{T}) where {T}
    if isnai(x)
        @warn "trying to access interval part of [NaI], returning empty interval"
        return emptyinterval(T)
    end
    return x.interval
end

decoration(x::DecoratedInterval) = x.decoration

# Automatic decorations for an Interval
function decoration(I::Interval)
    isempty(I) && return trv                         # emptyinterval
    is_valid_interval(inf(I), sup(I)) || return ill  # invalid input
    isunbounded(I) && return dac                     # unbounded
    return com                                       # common
end

big(x::DecoratedInterval) = DecoratedInterval(big(interval(x)), decoration(x))

macro decorated(ex...)
    if !(ex[1] isa String)
        if length(ex) == 1
            x = :(@interval($(esc(ex[1]))))
            lo = :($x.lo)
            hi = :($x.hi)
        else
            lo, hi = ex
        end

        return :(DecoratedInterval($lo, $hi))
    else
        s = ex[1]
        parse(DecoratedInterval{Float64}, s)
    end
end
