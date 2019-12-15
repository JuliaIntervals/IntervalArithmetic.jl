include("intervals.jl")
include("functions.jl")

isnan(x::AbstractFlavor) = false  # NaI is always decorated

# TODO adapt for each flavor
"""`NaI` not-an-interval: [NaN, NaN]."""
nai(::Type{T}) where T = Interval{T}(convert(T, NaN), convert(T, NaN))
nai(::Type{Interval{T}}) where {T <: Real} = nai(T)
nai(::Interval{T}) where {T <: Real} = nai(T)
nai() = nai(Interval{DefaultBound})

isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)
