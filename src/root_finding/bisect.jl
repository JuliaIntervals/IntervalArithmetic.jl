
doc"""
    bisect(X::Interval, α=0.5)

Split the interval `X` at position α; α=0.5 corresponds to the midpoint.
Returns a tuple of the new intervals.
"""
function bisect(X::Interval, α=0.5)
    m = (1-α) * X.lo + α * X.hi
    return ( Interval(X.lo, m), Interval(m, X.hi) )
end

doc"""
    bisect(X::IntervalBox, α=0.5)

Bisect the `IntervalBox` in its longest side.
"""
function bisect(X::IntervalBox, α=0.5)
    i = findmax([diam(x) for x in X])[2]  # find longest side

    return bisect(X, i, α)
end

doc"""
    bisect(X::IntervalBox, i::Integer, α=0.5)

Bisect the `IntervalBox` in side number `i`.
"""
function bisect(X::IntervalBox, i::Integer, α=0.5)

    x1, x2 = bisect(X[i], α)

    X1 = setindex(X, x1, i)
    X2 = setindex(X, x2, i)

    return (X1, X2)
end
