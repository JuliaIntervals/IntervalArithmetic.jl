# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Conversion and promotion

## Default conversion to Interval, corresponds to Interval{Float64}
# do we really need this?
#convert{T<:Real}(::Type{Interval}, x::T) = make_interval(Float64, x)

## Conversion to specific type intervals
#convert{T<:Real}(::Type{Interval{T}}, x::Real) = make_interval(T, x)


## Promotion rules
promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{S}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) =
    Interval{promote_type(T, BigFloat)}
