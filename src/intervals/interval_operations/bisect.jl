"""
    bisect(x, α=0.5)
    bisect(x, i, α=0.5)

Split an interval `x` at a relative position `α`, where `α = 0.5` corresponds
to the midpoint.

Split the `i`-th component of a vector `x` at a relative position `α`, where
`α = 0.5` corresponds to the midpoint.
"""
function bisect(x::BareInterval{T}, α::Real = 0.5) where {T<:NumTypes}
    0 ≤ α ≤ 1 || return throw(DomainError(α, "`bisect` only accepts a relative position between 0 and 1"))
    isatomic(x) && return (x, emptyinterval(BareInterval{T}))
    m = mid(x, α)
    return (_unsafe_bareinterval(T, inf(x), m), _unsafe_bareinterval(T, m, sup(x)))
end

function bisect(x::Interval, α::Real = 0.5)
    r₁, r₂ = bisect(bareinterval(x), α)
    d₁, d₂ = min(decoration(x), decoration(r₁)), min(decoration(x), decoration(r₂))
    t = isguaranteed(x)
    return (_unsafe_interval(r₁, d₁, t), _unsafe_interval(r₂, d₂, t))
end

function bisect(x::AbstractVector, i::Integer, α::Real = 0.5)
    x₁ = copy(x)
    x₂ = copy(x)
    x₁[i], x₂[i] = bisect(x[i], α)
    return (x₁, x₂)
end

"""
    mince(x, n)

Split an interval `x` in `n` intervals of the same diameter.

Split the `i`-th component of a vector `x` in `n[i]` intervals of the
same diameter; `n` can be a tuple of integers, or a single integer in which case
the same `n` is used for all the components of `x`.
"""
mince(x::BareInterval{T}, n::Integer) where {T<:NumTypes} = mince!(Vector{BareInterval{T}}(undef, n), x, n)

mince(x::Interval{T}, n::Integer) where {T<:NumTypes} = mince!(Vector{Interval{T}}(undef, n), x, n)

mince(x::AbstractVector, n::NTuple{N,Integer}) where {N} = mince!(Vector{typeof(x)}(undef, prod(n)), x, n)

mince(x::AbstractVector, n::Integer) = mince(x, ntuple(_ -> n, length(x)))

"""
    mince!(v, x, n)

In-place version of [`mince`](@ref).
"""
function mince!(v::AbstractVector{<:BareInterval}, x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    nodes = LinRange(inf(x), sup(x), n+1)
    @inbounds for i ∈ 1:n
        v[i] = _unsafe_bareinterval(T, nodes[i], nodes[i+1])
    end
    return v
end

function mince!(v::AbstractVector{<:Interval}, x::Interval{T}, n::Integer) where {T<:NumTypes}
    nodes = LinRange(inf(x), sup(x), n+1)
    d = decoration(x)
    t = isguaranteed(x)
    @inbounds for i ∈ 1:n
        rᵢ = _unsafe_bareinterval(T, nodes[i], nodes[i+1])
        dᵢ = min(d, decoration(rᵢ))
        v[i] = _unsafe_interval(rᵢ, dᵢ, t)
    end
    return v
end

function mince!(v::AbstractVector, x::AbstractVector, n::NTuple{N,Integer}) where {N}
    len = length(x)
    len == N || return throw(DimensionMismatch("x has length $len, n has length $N"))
    @inbounds minced_intervals = [mince(xᵢ, nᵢ) for (xᵢ, nᵢ) ∈ zip(x, n)]
    resize!(v, prod(n))
    @inbounds for (k, cut_indices) ∈ enumerate(CartesianIndices(n))
        y = similar(x, N)
        @inbounds for (i, j) ∈ enumerate(eachindex(y))
            y[j] = minced_intervals[i][cut_indices[i]]
        end
        v[k] = y
    end
    return v
end

mince!(v::AbstractVector, x::AbstractVector, n::Integer) = mince!(v, x, ntuple(_ -> n, length(x)))
