
## Convertion and promotion

#convert{T<:Real}(::Type{Interval{BigFloat}}, x::Interval{T}) = big_transf(x) #Interval(convert(BigFloat, x.lo), convert(BigFloat, x.hi))
#convert{T<:Real}(::Type{Interval{Float64}}, x::Interval{T}) = float_transf(x) #Interval(convert(Float64, x.lo), convert(Float64, x.hi))

# convert(::Type{Interval{BigFloat}}, x::Real) = big()(x) #@interval(x) # previously: Interval(convert(T,x))
# convert(::Type{Interval{Float64}}, x::Real) = float_transf(x) #@floatinterval(x) # previously: Interval(convert(T,x))

convert{T}(::Type{Interval{T}}, x::Real) = make_interval(T, x) #@floatinterval(x) # previously: Interval(convert(T,x))

#convert{T<:Real}(::Type{Interval{T}}, x::Interval) = Interval(convert(T, x.lo), convert(T, x.hi))





promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) = Interval{promote_type(T,S)}
promote_rule{T<:Real, A<:Real}(::Type{Interval{T}}, ::Type{A}) = Interval{T}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) = Interval{T}


