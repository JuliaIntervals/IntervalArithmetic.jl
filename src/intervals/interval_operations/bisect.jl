"""
    bisect(x::BareInterval, α::Real=0.49609375)
    bisect(x::Interval, α::Real=0.49609375)

Split the interval `x` at position `α`, where `α = 0.5` corresponds to the
midpoint.
"""
function bisect(x::BareInterval{T}, α::Real=0.49609375) where {T<:NumTypes}
    0 ≤ α ≤ 1 || return throw(DomainError(α, "bisect only accepts a relative position α between 0 and 1."))
    m = scaled_mid(x, α)
    return (_unsafe_bareinterval(T, inf(x), m), _unsafe_bareinterval(T, m, sup(x)))
end

function bisect(x::Interval, α::Real=0.49609375)
    bx = bareinterval(x)
    r1, r2 = bisect(bx, α)
    d1, d2 = min(decoration(x), decoration(r1), trv), min(decoration(x), decoration(r2), trv)
    t = guarantee(x)
    return (_unsafe_interval(r1, d1, t), _unsafe_interval(r2, d2, t))
end

"""
    mince(x::BareInterval, n::Integer)
    mince(x::Interval, n::Integer)

Split `x` in `n` intervals of the same diameter.
"""
function mince(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    nodes = LinRange(inf(x), sup(x), n+1)
    return [_unsafe_bareinterval(T, nodes[i], nodes[i+1]) for i ∈ 1:n]
end

function mince(x::Interval{T}, n::Integer) where {T<:NumTypes}
    v = Vector{Interval{T}}(undef, n)
    nodes = LinRange(inf(x), sup(x), n+1)
    d = decoration(x)
    t = guarantee(x)
    @inbounds for i ∈ 1:n
        rᵢ = _unsafe_bareinterval(T, nodes[i], nodes[i+1])
        dᵢ = min(d, decoration(rᵢ), trv)
        v[i] = _unsafe_interval(rᵢ, dᵢ, t)
    end
    return v
end
