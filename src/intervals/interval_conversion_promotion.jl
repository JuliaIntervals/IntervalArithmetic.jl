
## Convertion and promotion

convert{T<:Real}(::Type{Interval{T}}, x::Interval) = Interval(convert(T, x.lo), convert(T, x.hi))
convert{T<:Real}(::Type{Interval{T}}, x::Real) = @interval(x) # previously: Interval(convert(T,x))

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) = Interval{promote_type(T,S)}
promote_rule{T<:Real, A<:Real}(::Type{Interval{T}}, ::Type{A}) = Interval{T}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) = Interval{T}


