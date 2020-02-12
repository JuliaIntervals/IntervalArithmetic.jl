Base.rand(X::Interval{T}) where {T} = X.lo + rand(T) * (X.hi - X.lo)

Base.rand(X::IntervalBox) = rand.(X)
