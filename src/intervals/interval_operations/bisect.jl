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
    m = _relpoint(x, α)
    return (_unsafe_bareinterval(T, inf(x), m), _unsafe_bareinterval(T, m, sup(x)))
end

function bisect(x::Interval, α::Real = 0.5)
    bx = bareinterval(x)
    r₁, r₂ = bisect(bx, α)
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

# helper functions for bisection

function _relpoint(x::BareInterval{T}, α::Real) where {T<:AbstractFloat}
    α == 0.5 && return mid(x)
    isempty_interval(x) && return convert(T, NaN)
    if isentire_interval(x)
        α > 0.5 && return prevfloat(typemax(T))
        return nextfloat(typemin(T))
    else
        lo, hi = bounds(x)
        lo == typemin(T) && return nextfloat(lo) # cf. Section 12.12.8
        hi == typemax(T) && return prevfloat(hi) # cf. Section 12.12.8
        β = convert(T, α)
        midpoint = β * (hi - lo) + lo
        isfinite(midpoint) && return _normalisezero(midpoint)
        return _normalisezero((1 - β) * lo + β * hi)
    end
end
function _relpoint(x::BareInterval{T}, α::Real) where {T<:Rational}
    α == 0.5 && return mid(x)
    isempty_interval(x) && return throw(ArgumentError("cannot compute the midpoint of empty intervals; cannot return a `Rational` NaN"))
    if isentire_interval(x)
        α > 0.5 && return prevfloat(typemax(T))
        return nextfloat(typemin(T))
    else
        lo, hi = bounds(x)
        lo == typemin(T) && return nextfloat(lo) # cf. Section 12.12.8
        hi == typemax(T) && return prevfloat(hi) # cf. Section 12.12.8
        β = convert(T, α)
        midpoint = β * (hi - lo) + lo
        isfinite(midpoint) && return _normalisezero(midpoint)
        return _normalisezero((1 - β) * lo + β * hi)
    end
end

"""
    mince(x, n)

Split an interval `x` in `n` intervals of the same diameter.

Split the `i`-th component of a vector `x` in `n[i]` intervals of the
same diameter; `n` can be a tuple of integers, or a single integer in which case
the same `n` is used for all the components of `x`.
"""
function mince(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    nodes = LinRange(inf(x), sup(x), n+1)
    return [_unsafe_bareinterval(T, nodes[i], nodes[i+1]) for i ∈ 1:n]
end

function mince(x::Interval{T}, n::Integer) where {T<:NumTypes}
    v = Vector{Interval{T}}(undef, n)
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

mince(x::AbstractVector, n::Integer) = mince(x, ntuple(_ -> n, length(x)))

mince(x::AbstractVector, n::NTuple{N,Integer}) where {N} = mince!(Vector{typeof(x)}(undef, prod(n)), x, n)

"""
    mince!(v, x, n)

In-place version of [`mince`](@ref).
"""
mince!(v::AbstractVector, x::AbstractVector, n::Integer) = mince!(v, x, ntuple(_ -> n, length(x)))

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
