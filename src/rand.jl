Base.rand(X::Interval{T}) where {T} = X.lo + rand(T) * (X.hi - X.lo)

Base.rand(X::IntervalBox) = rand.(X)


#n::Int is the number of times, rand will get executed

function Base.rand(X::IntervalBox,n::Int)
    z = [rand.(X)]
    for i in 2:n
        z= vcat(z,[rand.(X)])
    end
    return z
end

function Base.rand(X::Interval,n::Int)
    z = rand(X)
    for i in 2:n
        z= vcat(z,[rand(X)])
    end
    return z
end
