# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Promotion rules

promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{Interval{T}}, ::Type{S}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{BigFloat}, ::Type{Interval{T}}) where T<:Real =
    Interval{promote_type(T, BigFloat)}



# Floating point intervals:

convert(::Type{Interval{T}}, x::AbstractString) where T<:AbstractFloat =
    parse(Interval{T}, x)

convert(::Type{Interval}, x::AbstractString) = convert(Interval{Float64}, x)

function convert(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:Real}
    isinf(x) && return wideinterval(T(x))

    Interval{T}( T(x, RoundDown), T(x, RoundUp) )
    # the rounding up could be done as nextfloat of the rounded down one?
    # use @round_up and @round_down here?
end

function convert(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:AbstractFloat}
    isinf(x) && return wideinterval(x)#Interval{T}(prevfloat(T(x)), nextfloat(T(x)))
    # isinf(x) && return Interval{T}(prevfloat(x), nextfloat(x))

    xrat = rationalize(x)

    # This prevents that xrat returns a 0//1 when x is very small
    # or 1//0 when x is too large but finite
    if (x != zero(x) && xrat == 0) || isinf(xrat)
        xstr = string(x)
        return Interval(parse(T, xstr, RoundDown), parse(T, xstr, RoundUp))
    end

    return convert(Interval{T}, xrat)
end

convert(::Type{Interval{T}}, x::Interval{T}) where T<:AbstractFloat = x

function convert(::Type{Interval{T}}, x::Interval) where T<:AbstractFloat
    Interval{T}( T(x.lo, RoundDown), T(x.hi, RoundUp) )
end


# Complex numbers:
convert(::Type{Interval{T}}, x::Complex{Bool}) where T<:AbstractFloat =
    (x == im) ? one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function convert(::Type{Interval{Rational{Int}}}, x::Irrational)
    a = float(convert(Interval{BigFloat}, x))
    convert(Interval{Rational{Int}}, a)
end

function convert(::Type{Interval{Rational{BigInt}}}, x::Irrational)
    a = convert(Interval{BigFloat}, x)
    convert(Interval{Rational{BigInt}}, a)
end

convert(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:Integer} =
    Interval(x*one(Rational{T}))

convert(::Type{Interval{Rational{T}}}, x::Rational{S}) where
    {T<:Integer, S<:Integer} = Interval(x*one(Rational{T}))

convert(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:Float64} =
    Interval(rationalize(T, x))

convert(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:BigFloat} =
    Interval(rationalize(T, x))


# conversion to Interval without explicit type:
function convert(::Type{Interval}, x::Real)
    T = typeof(float(x))

    return convert(Interval{T}, x)
end

convert(::Type{Interval}, x::Interval) = x
