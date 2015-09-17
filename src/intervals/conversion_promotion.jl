# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Conversion and promotion

## Default conversion is to Interval{Float64}
convert{T<:Real}(::Type{Interval}, x::T) = make_interval(Float64, x)
convert{T<:Union(Float64,BigFloat,Rational)}(::Type{Interval}, x::T) =
    make_interval(T, x)

## Conversion to intervals (with rounding) from Integer or Irrational
convert{T<:Union(Float64,BigFloat), S<:Real}(::Type{Interval{T}}, x::S) =
    make_interval(T, x)
convert{T<:Integer, S<:Real}(::Type{Interval{Rational{T}}}, x::S) =
    make_interval(Rational{T}, x)

## Promotion rules
promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) =
    Interval{promote_type(T,S)}
promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{S}) =
    Interval{promote_type(T,S)}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) =
    Interval{promote_type(T,BigFloat)}
