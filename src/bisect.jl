const where_bisect = 0.49609375

"""
    bisect(X::Interval, α=0.49609375)

Split the interval `X` at position α; α=0.5 corresponds to the midpoint.
Returns a tuple of the new intervals.
"""
function bisect(X::Interval{T}, α=where_bisect) where {T<:NumTypes}
    @assert 0 ≤ α ≤ 1

    m = scaled_mid(X, α)

    return (unsafe_interval(T, inf(X), m), unsafe_interval(T, m, sup(X)))
end

"""
    mince(x::Interval, n)

Split `x` in `n` intervals of the same diameter, which are returned
as a vector.
"""
function mince(x::Interval{T}, n) where {T<:NumTypes}
    nodes = LinRange(inf(x), sup(x), n+1)
    return [unsafe_interval(T, nodes[i], nodes[i+1]) for i in 1:n]
end
