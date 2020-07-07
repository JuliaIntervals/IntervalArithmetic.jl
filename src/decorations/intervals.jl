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
struct DecoratedInterval{T<:Real} <: AbstractInterval{T}
    interval::Interval{T}
    decoration::DECORATION

    function DecoratedInterval{T}(I::Interval, d::DECORATION) where T
        dd = decoration(I)
        dd <= trv && return new{T}(I, dd)
        d == ill && return nai(I)
        return new{T}(I, d)
    end
end

DecoratedInterval(I::Interval{T}, d::DECORATION) where T<:AbstractFloat =
    DecoratedInterval{T}(I, d)

function DecoratedInterval(a::T, b::T, d::DECORATION) where T<:Real
    a > b && return nai(T)
    DecoratedInterval(Interval(a,b), d)
end

DecoratedInterval(a::T, d::DECORATION) where T<:Real =
    DecoratedInterval(Interval(a,a), d)

DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(a..., d)

DecoratedInterval(a::T, b::S, d::DECORATION) where {T<:Real, S<:Real} =
    DecoratedInterval(promote(a,b)..., d)

# Automatic decorations for an interval
DecoratedInterval(I::Interval) = DecoratedInterval(I, decoration(I))

function DecoratedInterval(a::T, b::T) where T<:Real
    a > b && return nai(T)
    DecoratedInterval(Interval(a,b))
end

DecoratedInterval(a::T, b::T) where T<:Integer =
    DecoratedInterval(float(a),float(b))

DecoratedInterval(a::T) where T<:Real = DecoratedInterval(Interval(a,a))

DecoratedInterval(a::T, b::S) where {T<:Real, S<:Real} =
    DecoratedInterval(promote(a, b)...)

DecoratedInterval(a::Tuple) = DecoratedInterval(a...)

DecoratedInterval(I::DecoratedInterval, dec::DECORATION) = DecoratedInterval(I.interval, dec)

interval(x::DecoratedInterval) = x.interval

decoration(x::DecoratedInterval) = x.decoration

# Automatic decorations for an Interval
function decoration(I::Interval)
    isnai(I) && return ill           # nai()
    isempty(I) && return trv         # emptyinterval
    isunbounded(I) && return dac     # unbounded
    com                              # common
end

# Promotion and conversion, and other constructors

# promote_rule{T<:Real, N, R<:Real}(::Type{DecoratedInterval{T}},
#     ::Type{ForwardDiff.Dual{N,R}}) = ForwardDiff.Dual{N, DecoratedInterval{promote_type(T,R)}}

promote_rule(::Type{DecoratedInterval{T}}, ::Type{S}) where {T<:Real, S<:Real} =
    DecoratedInterval{promote_type(T, S)}

promote_rule(::Type{DecoratedInterval{T}}, ::Type{DecoratedInterval{S}}) where
    {T<:Real, S<:Real} = DecoratedInterval{promote_type(T, S)}

convert(::Type{DecoratedInterval{T}}, x::S) where {T<:Real, S<:Real} =
    DecoratedInterval( Interval(T(x, RoundDown), T(x, RoundUp)) )

convert(::Type{DecoratedInterval{T}}, x::S) where {T<:Real, S<:Integer} =
    DecoratedInterval( Interval(T(x), T(x)) )
# function convert{T<:AbstractFloat}(::Type{DecoratedInterval{T}}, x::Float64)
#     convert(DecoratedInterval{T}, rationalize(x))
# end
function convert(::Type{DecoratedInterval{T}}, xx::DecoratedInterval) where T<:Real
    x = interval(xx)
    x = atomic(Interval{T},x)
    DecoratedInterval( x, decoration(xx) )
end

convert(::Type{DecoratedInterval{T}}, x::AbstractString) where T<:AbstractFloat =
    parse(DecoratedInterval{T}, x)

big(x::DecoratedInterval) = DecoratedInterval(big(interval(x)),
                                                decoration(x))

macro decorated(ex...)
    if(!(ex[1] isa String))
        local x

        if length(ex) == 1
            x = :(@interval($(esc(ex[1]))))
        else
            x = :($(esc(ex[1])), $(esc(ex[2])))
        end

        :(DecoratedInterval($x))
    else
        s = ex[1]
        parse(DecoratedInterval{Float64}, s)
    end
end
