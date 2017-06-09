# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Promotion rules

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{S}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) =
    Interval{promote_type(T, BigFloat)}



# Floating point intervals:

convert{T<:AbstractFloat}(::Type{Interval{T}}, x::AbstractString) =
    parse(Interval{T}, x)

function convert{T<:AbstractFloat, S<:Real}(::Type{Interval{T}}, x::S)
    Interval{T}( T(x, RoundDown), T(x, RoundUp) )
    # the rounding up could be done as nextfloat of the rounded down one?
    # use @round_up and @round_down here?
end

function convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Float64)
    isinf(x) && return Interval{T}(prevfloat(x), nextfloat(x))

    xrat = rationalize(x)

    # This prevents that xrat returns a 0//1 when x is very small
    # or 1//0 when x is too large but finite
    if (x != zero(x) && xrat == 0) || isinf(xrat)
        xstr = string(x)
        return Interval(parse(T, xstr, RoundDown), parse(T, xstr, RoundUp))
    end

    return convert(Interval{T}, xrat)
end

convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Interval{T}) = x

function convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Interval)
    Interval{T}( T(x.lo, RoundDown), T(x.hi, RoundUp) )
end


# Complex numbers:
convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Complex{Bool}) = (x == im) ?
    one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function convert(::Type{Interval{Rational{Int}}}, x::Irrational)
    a = float(convert(Interval{BigFloat}, x))
    convert(Interval{Rational{Int}}, a)
end

function convert(::Type{Interval{Rational{BigInt}}}, x::Irrational)
    a = convert(Interval{BigFloat}, x)
    convert(Interval{Rational{BigInt}}, a)
end

convert{T<:Integer, S<:Integer}(::Type{Interval{Rational{T}}}, x::S) =
    Interval(x*one(Rational{T}))

convert{T<:Integer, S<:Integer}(::Type{Interval{Rational{T}}}, x::Rational{S}) =
    Interval(x*one(Rational{T}))

convert{T<:Integer, S<:Float64}(::Type{Interval{Rational{T}}}, x::S) =
    Interval(rationalize(T, x))

convert{T<:Integer, S<:BigFloat}(::Type{Interval{Rational{T}}}, x::S) =
    Interval(rationalize(T, x))


# conversion to Interval without explicit type:
function convert(::Type{Interval}, x::Real)
    T = typeof(float(x))

    return convert(Interval{T}, x)
end

convert(::Type{Interval}, x::Interval) = x
