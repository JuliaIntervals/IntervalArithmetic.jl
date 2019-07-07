# NaI: not-an-interval
"""`NaI` not-an-interval: [NaN, NaN],ill"""
nai(::Type{T}) where T<:Real = DecoratedInterval{T}(Interval(convert(T, NaN), convert(T, NaN)), ill)
nai(x::Interval{T}) where T<:Real = nai(T)
nai() = nai(precision(Interval)[1])

function isnai(x::DecoratedInterval)
    return x.decoration == ill
end
