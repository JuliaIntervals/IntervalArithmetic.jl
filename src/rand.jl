using Random

Base.rand(X::Interval{T}) where {T} = X.lo + rand(T) * (X.hi - X.lo)

Base.rand(X::IntervalBox) = rand.(X)


Random.gentype(::Type{Interval{T}}) where {T} = T
Random.rand(rng::AbstractRNG, X::Random.SamplerTrivial{Interval{T}}) where {T} = rand(X[])


# Base.eltype(::Type{IntervalBox{2,Float64}}) = SArray{Tuple{2},Float64,1,2}
# Random.rand(rng::AbstractRNG,X::Random.SamplerTrivial{IntervalBox{2,Float64}}) = rand.(X[])
