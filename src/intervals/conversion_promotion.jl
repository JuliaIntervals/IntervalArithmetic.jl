# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Conversion and promotion

convert{T<:Union(Float64,BigFloat,Rational)}(::Type{Interval}, x::T) =
    make_interval(T, x)
convert{T<:Union(Float64,BigFloat)}(::Type{Interval{T}}, x::Real) = make_interval(T, x)

## Conversion to intervals (with rounding) from Integer or Irrational
convert{T<:Integer, S<:Union(Integer, Irrational)}(::Type{Interval{Rational{T}}}, x::S) =
    make_interval(Rational{T}, x)
## Default Interval{Float64}
convert{T<:Union(Integer, Irrational)}(::Type{Interval}, x::T) = make_interval(Float64, x)
## ...because the following is type unstable
# convert{T<:Union(Integer, Irrational)}(::Type{Interval}, x::T) =
#     make_interval(get_interval_precision()[1], x)

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) =
    Interval{promote_type(T,S)}
promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{S}) =
    Interval{promote_type(T,S)}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) =
    Interval{promote_type(T,BigFloat)}
