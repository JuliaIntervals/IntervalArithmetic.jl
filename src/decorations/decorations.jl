include("intervals.jl")
include("functions.jl")

# TODO Check if it is consistent with #386
isnan(x::AbstractFlavor) = false  # NaI is always decorated

"""`NaI` not-an-interval: [NaN, NaN]."""
nai(::Type{T}) where T = DecoratedInterval(convert(T, NaN), convert(T, NaN), ill)
nai(::Type{F}) where {T, F<:Interval{T}} = nai(T)
nai(::Interval{T}) where T<:Real = nai(T)
nai(::DecoratedInterval{T}) where T<:Real = nai(T)
nai() = nai(Interval{DefaultBound})

isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)
isnai(x::DecoratedInterval) = isnai(interval(x)) && x.decoration == ill
