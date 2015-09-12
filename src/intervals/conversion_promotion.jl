# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Conversion and promotion

convert{T}(::Type{Interval{T}}, x::Real) = make_interval(T, x)

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) = Interval{promote_type(T,S)}
promote_rule{T<:Real, A<:Real}(::Type{Interval{T}}, ::Type{A}) = Interval{T}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) = Interval{T}
