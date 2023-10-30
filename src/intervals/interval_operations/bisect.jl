# bare intervals

"""
    bisect(x::BareInterval, α=0.49609375)

Split the interval `x` at position `α`, where `α = 0.5` corresponds to the
midpoint.
"""
function bisect(x::BareInterval{T}, α=0.49609375) where {T<:NumTypes}
    0 ≤ α ≤ 1 || return throw(DomainError(α, "bisect only accepts a relative position α between 0 and 1."))
    m = scaled_mid(x, α)
    return (_unsafe_bareinterval(T, inf(x), m), _unsafe_bareinterval(T, m, sup(x)))
end

"""
    mince(x::BareInterval, n)

Split `x` in `n` intervals of the same diameter.
"""
function mince(x::BareInterval{T}, n) where {T<:NumTypes}
    nodes = LinRange(inf(x), sup(x), n+1)
    return [_unsafe_bareinterval(T, nodes[i], nodes[i+1]) for i ∈ 1:n]
end



# decorated intervals

function bisect(x::Interval, α=0.49609375)
    bx = bareinterval(x)
    r1, r2 = bisect(bx, α)
    d1, d2 = min(decoration(x), decoration(r1), dac), min(decoration(x), decoration(r2), trv)
    return (_unsafe_interval(r1, d1), _unsafe_interval(r2, d2))
end

function mince(x::Interval{T}, n) where {T<:NumTypes}
    v = Vector{Interval{T}}(undef, n)
    nodes = LinRange(inf(x), sup(x), n+1)
    d = decoration(x)
    @inbounds for i ∈ 1:n
        rᵢ = _unsafe_bareinterval(T, nodes[i], nodes[i+1])
        dᵢ = min(d, decoration(rᵢ), trv)
        v[i] = _unsafe_interval(rᵢ, dᵢ)
    end
    return v
end
