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
# Note that `isless`, and hence ``<` and `min`, are automatically defined for enums

# const decorations = Dict("ill" => ill,
#                          "trv" => trv,
#                          "def" => def,
#                          "dac" => dac,
#                          "com" => com)

"""
    DecoratedInterval

A `DecoratedInterval` is an interval, together with a *decoration*, i.e.
a flag that records the status of the interval when thought of as the result
of a previously executed sequence of functions acting on an initial interval.
"""
type DecoratedInterval{T<:Real} <: AbstractInterval
    interval::Interval{T}
    decoration::DECORATION

    function DecoratedInterval(I::Interval, d::DECORATION)
        dd = decoration(I)
        dd <= trv && return new(I, dd)
        d == ill && return new(nai(I), d)
        return new(I, d)
    end
end

DecoratedInterval{T<:AbstractFloat}(I::Interval{T}, d::DECORATION) =
    DecoratedInterval{T}(I, d)
function DecoratedInterval{T<:Real}(a::T, b::T, d::DECORATION)
    a > b && return DecoratedInterval(nai(T), ill)
    DecoratedInterval(Interval(a,b), d)
end
DecoratedInterval{T<:Real}(a::T, d::DECORATION) = DecoratedInterval(Interval(a,a), d)
DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(a..., d)
DecoratedInterval{T<:Real, S<:Real}(a::T, b::S, d::DECORATION) =
    DecoratedInterval(promote(a,b)..., d)

# Automatic decorations for an interval
DecoratedInterval(I::Interval) = DecoratedInterval(I, decoration(I))
function DecoratedInterval{T<:Real}(a::T, b::T)
    a > b && return DecoratedInterval(nai(T), ill)
    DecoratedInterval(Interval(a,b))
end
DecoratedInterval{T<:Integer}(a::T, b::T) = DecoratedInterval(float(a),float(b))
DecoratedInterval{T<:Real}(a::T) = DecoratedInterval(Interval(a,a))
DecoratedInterval{T<:Real, S<:Real}(a::T, b::S) = DecoratedInterval(promote(a, b)...)
DecoratedInterval(a::Tuple) = DecoratedInterval(a...)

DecoratedInterval(I::DecoratedInterval, dec::DECORATION) = DecoratedInterval(I.interval, dec)

interval_part(x::DecoratedInterval) = x.interval
decoration(x::DecoratedInterval) = x.decoration

# Automatic decorations for an Interval
function decoration(I::Interval)
    isnai(I) && return ill           # nai()
    isempty(I) && return trv         # emptyinterval
    isunbounded(I) && return dac     # unbounded
    com                              # common
end

# Promotion and conversion, and other constructors

promote_rule{T<:Real, N, R<:Real}(::Type{DecoratedInterval{T}},
    ::Type{ForwardDiff.Dual{N,R}}) = ForwardDiff.Dual{N, DecoratedInterval{promote_type(T,R)}}

promote_rule{T<:Real, S<:Real}(::Type{DecoratedInterval{T}}, ::Type{S}) =
    DecoratedInterval{promote_type(T, S)}
promote_rule{T<:Real, S<:Real}(::Type{DecoratedInterval{T}}, ::Type{DecoratedInterval{S}}) =
    DecoratedInterval{promote_type(T, S)}

convert{T<:Real, S<:Real}(::Type{DecoratedInterval{T}}, x::S) =
    DecoratedInterval( Interval(T(x, RoundDown), T(x, RoundUp)) )
convert{T<:Real, S<:Integer}(::Type{DecoratedInterval{T}}, x::S) =
    DecoratedInterval( Interval(T(x), T(x)) )
# function convert{T<:AbstractFloat}(::Type{DecoratedInterval{T}}, x::Float64)
#     convert(DecoratedInterval{T}, rationalize(x))
# end
function convert{T<:Real}(::Type{DecoratedInterval{T}}, xx::DecoratedInterval)
    x = interval_part(xx)
    x = convert(Interval{T},x)
    DecoratedInterval( x, decoration(xx) )
end

convert{T<:AbstractFloat}(::Type{DecoratedInterval{T}}, x::AbstractString) =
    parse(DecoratedInterval{T}, x)

big(x::DecoratedInterval) = DecoratedInterval(big(interval_part(x)),
                                                decoration(x))

macro decorated(ex...)
    local x

    if length(ex) == 1
        x = :(@interval($(esc(ex[1]))))
    else
        x = :($(esc(ex[1])), $(esc(ex[2])))
    end

    :(DecoratedInterval($x))
end
