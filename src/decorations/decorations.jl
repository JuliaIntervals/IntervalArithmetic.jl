include("intervals.jl")
include("functions.jl")


"""`NaI` not-an-interval: [NaN, NaN]."""
nai(::Type{Interval{T}}) where {T<:NumTypes} = nai(T)
nai(::Type{T}) where {T<:NumTypes} = DecoratedInterval(convert(T, NaN), convert(T, NaN), ill)
nai(::Type{<:Real}) = nai(default_numtype())
nai() = nai(default_numtype())
nai(::T) where {T} = nai(T)

isnai(x::Interval) = isnan(inf(x)) || isnan(sup(x)) # || inf(x) > sup(x) || (isinf(inf(x)) && inf(x) == sup(x))
isnai(x::DecoratedInterval) = isnai(interval(x)) || x.decoration == ill
