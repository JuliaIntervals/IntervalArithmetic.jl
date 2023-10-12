using Random

Base.rand(X::Interval{T}) where {T<:NumTypes} = inf(X) + rand(T) * (sup(X) - inf(X))

Random.gentype(::Type{Interval{T}}) where {T<:NumTypes} = T

Random.rand(::AbstractRNG, X::Random.SamplerTrivial{Interval{T}}) where {T<:NumTypes} = rand(X[])
