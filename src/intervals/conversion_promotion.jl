# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Promotion

## Promotion rules
promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{S}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) =
    Interval{promote_type(T, BigFloat)}


## Conversion rules

doc"""`split_interval_string` deals with strings of the form
\"[3.5, 7.2]\""""

function split_interval_string(T, x::AbstractString)
    if !(contains(x, "["))  # string like "3.1"
        return @thin_round(T, parse(T, x))
    end

    m = match(r"\[(.*),(.*)\]", x)  # string like "[1, 2]"

    if m == nothing
        throw(ArgumentError("Unable to process string $x as interval"))
    end

    @round(T, parse(T, m.captures[1]), parse(T, m.captures[2]))
end


# BigFloat intervals:

convert(::Type{Interval{BigFloat}}, x::AbstractString) =
    split_interval_string(BigFloat, x)

function convert{T<:Real}(::Type{Interval{BigFloat}}, x::T)
    @thin_round(BigFloat, BigFloat(x))
end

function convert(::Type{Interval{BigFloat}}, x::Float64)
    #y = rationalize(x)
    make_interval(BigFloat, rationalize(x))
end

function convert(::Type{Interval{BigFloat}}, x::Interval)
    @round(BigFloat, BigFloat(x.lo), BigFloat(x.hi))
end


# Float64 intervals:
convert(::Type{Interval{Float64}}, x::AbstractString) = split_interval_string(Float64, x)

convert(::Type{Interval{Float64}}, x::Irrational) = convert(Interval{Float64}, convert(Interval{BigFloat}, x))

function convert(::Type{Interval{Float64}}, x::Float64)
    #isinf(x) && return Interval(x)
    convert(Interval{Float64}, rationalize(x))
end

convert(::Type{Interval{Float64}}, x::Rational) = @thin_round(float(typeof(x)), Float64(x))
# round using the correct floating-point type

function convert(::Type{Interval{Float64}}, x::Integer)
    Interval( Float64(x, RoundDown), Float64(x, RoundUp) )
end



convert(::Type{Interval{Float64}}, x::BigFloat) = @thin_round(BigFloat, Float64(x))
# NB: Must use rounding of BigFloat, not of Float64, when converting BigFloats

function convert(::Type{Interval{Float64}}, x::Interval)
    Interval( Float64(x.lo, RoundDown), Float64(x.hi, RoundUp) )
end


# Complex numbers:
convert{T}(::Type{Interval{T}}, x::Complex{Bool}) = (x == im) ?
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
