include("intervals.jl")
include("functions.jl")

isnan(x::AbstractFlavor) = false  # NaI is always decorated
# TODO Deal with NaI
# """`NaI` not-an-interval: [NaN, NaN]."""
# nai(::Type{T}) where T<:Real = Interval{T}(convert(T, NaN), convert(T, NaN))
# nai(x::Interval{T}) where T<:Real = nai(T)
# nai() = nai(precision(Interval)[1])
#
# isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)
