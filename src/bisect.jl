
const where_bisect = 0.49609375

"""
    bisect(X::Interval, α=0.49609375)

Split the interval `X` at position α; α=0.5 corresponds to the midpoint.
Returns a tuple of the new intervals.
"""
function bisect(X::F, α=where_bisect) where {F<:Interval}
    @assert 0 ≤ α ≤ 1

    m = scaled_mid(X, α)

    return (F(inf(X), m), F(m, sup(X)))
end

"""
    bisect(X::IntervalBox, α=0.49609375)

Bisect the `IntervalBox` `X` at position α ∈ [0,1] along its longest side.
"""
function bisect(X::IntervalBox, α=where_bisect)
    i = argmax(diam.(X))  # find longest side

    return bisect(X, i, α)
end

"""
    bisect(X::IntervalBox, i::Integer, α=0.49609375)

Bisect the `IntervalBox` in side number `i`.
"""
function bisect(X::IntervalBox, i::Integer, α=where_bisect)

    x1, x2 = bisect(X[i], α)

    X1 = setindex(X, x1, i)
    X2 = setindex(X, x2, i)

    return (X1, X2)
end

"""
    mince(x::Interval, n)

Splits `x` in `n` intervals of the same diameter, which are returned
as a vector.
"""
function mince(x::F, n) where {F<:Interval}
    nodes = range(inf(x), sup(x), length = n+1)
    return [F(nodes[i], nodes[i+1]) for i in 1:length(nodes)-1]
end

"""
    mince(x::IntervalBox, n)

Splits `x` in `n` intervals in each dimension of the same diameter. These
intervals are combined in all possible `IntervalBox`-es, which are returned
as a vector.
"""
@generated function mince(x::IntervalBox{N,T}, n) where {N,T}
    quote
        nodes_matrix = Array{Interval{T},2}(undef, n, N)
        for i in 1:N
            nodes_matrix[1:n,i] .= mince(x[i], n)
        end

        nodes = IntervalBox{$N,T}[]
        Base.Cartesian.@nloops $N i _->(1:n) begin
            Base.Cartesian.@nextract $N ival d->nodes_matrix[i_d, d]
            ibox = Base.Cartesian.@ncall $N IntervalBox ival
            push!(nodes, ibox)
        end
        nodes
    end
end
