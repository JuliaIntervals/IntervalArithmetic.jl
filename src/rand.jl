using Random
using Random: GLOBAL_RNG

Base.rand(X::Interval{T}) where {T} = X.lo + rand(T) * (X.hi - X.lo)

Base.rand(X::IntervalBox) = rand.(X)


Random.gentype(::Type{Interval{T}}) where {T} = T
Random.rand(rng::AbstractRNG, X::Random.SamplerTrivial{Interval{T}}) where {T} = rand(X[])

Base.randn(type::Type{<:Interval}) = randn(GLOBAL_RNG, type)
Base.randn(::Type{Interval}) = randn(Interval{Float64})

function Random.randn(rng::AbstractRNG, ::Type{Interval{T}}) where {T}
    x, y = randn(rng, T), randn(rng, T)
    return x < y ? Interval(x, y) : Interval(y, x)
end

function Random.randn(rng::AbstractRNG, ::Type{Interval})
    return randn(rng, Interval{Float64})
end

# Base.eltype(::Type{IntervalBox{2,Float64}}) = SArray{Tuple{2},Float64,1,2}
# Random.rand(rng::AbstractRNG,X::Random.SamplerTrivial{IntervalBox{2,Float64}}) = rand.(X[])
