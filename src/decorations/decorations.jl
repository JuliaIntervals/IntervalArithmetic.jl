include("intervals.jl")
include("functions.jl")

# isnan(x::Interval) = false  # NaI is always decorated

"""`NaI` not-an-interval: [NaN, NaN]."""
nai(::Type{T}) where T = DecoratedInterval(Interval(convert(T, NaN), convert(T, NaN)), ill)
nai(::Type{F}) where {T, F<:Interval{T}} = nai(T)
nai(::Interval{T}) where T<:Real = nai(T)
nai(::DecoratedInterval{T}) where T<:Real = nai(T)
nai() = nai(default_bound())

isnai(x::Interval) = false  # NaI is always decorated
isnai(x::DecoratedInterval) = x.decoration == ill
