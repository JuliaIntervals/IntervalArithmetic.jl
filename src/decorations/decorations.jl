# This file is part of the ValidatedNumerics.jl package; MIT licensed

# Decorated intervals, following the IEEE 1758-2015 standard

doc"""
DECORATION

Enumeration constant for the types of interval decorations.
The nomenclature of the follows the IEEE-1788 (2015) standard
(sect 11.2):

- `com -> 4`: common: bounded non-empty
- `dac -> 3`: defined (nonempty) and continuous
- `def -> 2`: defined (nonempty)
- `trv -> 1`: always true
- `ill -> 0`: nai
"""
@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# < and min work automatically for enums

doc"""
DecoratedInterval

A `DecoratedInterval` is an interval, together with a *decoration*, i.e.
a flag that records the status of the interval when thought of as the result
of a previously executed sequence of functions acting on an initial interval.
"""
type DecoratedInterval{T <: AbstractFloat} <: AbstractInterval
    interval::Interval{T}
    decoration::DECORATION

    function DecoratedInterval(I::Interval, d::DECORATION)
        dd = decoration(I)
        Int(dd) < 2 && return new(I, dd)
        Int(d) == 0 && return new(nai(I), d)
        return new(I, d)
    end
end

DecoratedInterval{T<:AbstractFloat}(I::Interval{T}, d::DECORATION) =
    DecoratedInterval{T}(I, d)
DecoratedInterval{T<:Real}(a::T, b::T, d::DECORATION) =
    DecoratedInterval(Interval(a,b), d)
DecoratedInterval{T<:Real}(a::T, d::DECORATION) = DecoratedInterval(Interval(a,a), d)
DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(Interval(a...), d)
DecoratedInterval{T<:Real, S<:Real}(a::T, b::S, d::DECORATION) =
    DecoratedInterval(Interval(promote(a,b)...), d)

# Automatic decorations for an interval
DecoratedInterval(I::Interval) = DecoratedInterval(I, decoration(I))
DecoratedInterval{T<:Real}(a::T, b::T) = DecoratedInterval(Interval(a,b))
DecoratedInterval{T<:Real}(a::T) = DecoratedInterval(Interval(a,a))
DecoratedInterval(a::Tuple) = DecoratedInterval(Interval(a...))
DecoratedInterval{T<:Real, S<:Real}(a::T, b::S) = DecoratedInterval(Interval(a,b))

interval(x::DecoratedInterval) = x.interval
decoration(x::DecoratedInterval) = x.decoration

# Automatic decorations for an interval
decoration(I::Interval) =
    ifelse( isnai(I), ill,           # nai()
        ifelse( isempty(I), trv,     # emptyinterval
        ifelse( isunbounded(I), dac, # unbounded
            com )) )                 # common

Base.show(io::IO, x::DecoratedInterval) = print(io, x.interval, "_", x.decoration)

macro decorated(ex)
    :(DecoratedInterval($ex))
end
