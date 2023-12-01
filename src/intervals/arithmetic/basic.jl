# This file contains the functions described as "Basic arithmetic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

Base.:+(x::BareInterval) = x # not in the IEEE Standard 1788-2015

Base.:+(x::Interval) = x

"""
    +(x::BareInterval, y::BareInterval)
    +(x::Interval, y::Interval)

Implement the `add` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.:+(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    isempty_interval(y) && return y
    return @round(T, inf(x) + inf(y), sup(x) + sup(y))
end
Base.:+(x::BareInterval, y::BareInterval) = +(promote(x, y)...)

function Base.:+(x::Interval, y::Interval)
    r = bareinterval(x) + bareinterval(y)
    d = min(decoration(x), decoration(y), decoration(r))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

"""
    -(x::BareInterval)
    -(x::Interval)

Implement the `neg` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.:-(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    return _unsafe_bareinterval(T, -sup(x), -inf(x))
end

Base.:-(x::Interval) = _unsafe_interval(-bareinterval(x), decoration(x), isguaranteed(x))

"""
    -(x::BareInterval, y::BareInterval)
    -(x::Interval, y::Interval)

Implement the `sub` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.:-(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    isempty_interval(y) && return y
    return @round(T, inf(x) - sup(y), sup(x) - inf(y))
end
Base.:-(x::BareInterval, y::BareInterval) = -(promote(x, y)...)

function Base.:-(x::Interval, y::Interval)
    r = bareinterval(x) - bareinterval(y)
    d = min(decoration(x), decoration(y), decoration(r))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

"""
    *(x::BareInterval, y::BareInterval)
    *(x::Interval, y::Interval)

Implement the `mul` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `*` is flavor dependent for some edge cases.
"""
function Base.:*(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    isempty_interval(y) && return y
    isthinzero(x) && return x
    isthinzero(y) && return y
    isbounded(x) & isbounded(y) && return _mult(*, x, y)
    return _mult((x, y, r) -> _unbounded_mult(x, y, r), x, y)
end
Base.:*(x::BareInterval, y::BareInterval) = *(promote(x, y)...)

function Base.:*(x::Interval, y::Interval)
    r = bareinterval(x) * bareinterval(y)
    d = min(decoration(x), decoration(y), decoration(r))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

# helper functions for multiplication

function _unbounded_mult(x::T, y::T, r::RoundingMode) where {T<:NumTypes}
    iszero(x) && return sign(y) * zero_times_infinity(T)
    iszero(y) && return sign(x) * zero_times_infinity(T)
    return *(x, y, r)
end

function _mult(op, a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    if inf(b) ≥ 0
        inf(a) ≥ 0 && return @round(T, op(inf(a), inf(b)), op(sup(a), sup(b)))
        sup(a) ≤ 0 && return @round(T, op(inf(a), sup(b)), op(sup(a), inf(b)))
        return @round(T, inf(a)*sup(b), sup(a)*sup(b)) # 0 ∈ a
    elseif sup(b) ≤ 0
        inf(a) ≥ 0 && return @round(T, op(sup(a), inf(b)), op(inf(a), sup(b)))
        sup(a) ≤ 0 && return @round(T, op(sup(a), sup(b)), op(inf(a), inf(b)))
        return @round(T, sup(a)*inf(b), inf(a)*inf(b)) # 0 ∈ a
    else
        inf(a) > 0 && return @round(T, op(sup(a), inf(b)), op(sup(a), sup(b)))
        sup(a) < 0 && return @round(T, op(inf(a), sup(b)), op(inf(a), inf(b)))
        return @round(T, min( op(inf(a), sup(b)), op(sup(a), inf(b)) ),
                         max( op(inf(a), inf(b)), op(sup(a), sup(b)) ))
    end
end

"""
    inv(x::BareInterval)
    inv(x::Interval)

Implement the `recip` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `inv` is flavor dependent for some edge cases.
"""
function Base.inv(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    if in_interval(0, x)
        inf(x) < 0 == sup(x) && return @round(T, typemin(T), inv(inf(x)))
        inf(x) == 0 < sup(x) && return @round(T, inv(sup(x)), typemax(T))
        inf(x) < 0 < sup(x) && return entireinterval(BareInterval{T})
        isthinzero(x) && return div_by_thin_zero(_unsafe_bareinterval(T, one(T), one(T)))
    end
    return @round(T, inv(sup(x)), inv(inf(x)))
end

function Base.inv(x::Interval)
    bx = bareinterval(x)
    r = inv(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(in_interval(0, bx), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    /(x::BareInterval, y::BareInterval)
    /(x::Interval, y::Interval)

Implement the `div` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `/` is flavor dependent for some edge cases.
"""
function Base.:/(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    isthinzero(b) && return div_by_thin_zero(a)
    if inf(b) > 0 # b strictly positive
        inf(a) ≥ 0 && return @round(T, inf(a)/sup(b), sup(a)/inf(b))
        sup(a) ≤ 0 && return @round(T, inf(a)/inf(b), sup(a)/sup(b))
        return @round(T, inf(a)/inf(b), sup(a)/inf(b)) # 0 ∈ a
    elseif sup(b) < 0 # b strictly negative
        inf(a) ≥ 0 && return @round(T, sup(a)/sup(b), inf(a)/inf(b))
        sup(a) ≤ 0 && return @round(T, sup(a)/inf(b), inf(a)/sup(b))
        return @round(T, sup(a)/sup(b), inf(a)/sup(b)) # 0 ∈ a
    else # 0 ∈ b
        isthinzero(a) && return a
        if iszero(inf(b))
            inf(a) ≥ 0 && return @round(T, inf(a)/sup(b), typemax(T))
            sup(a) ≤ 0 && return @round(T, typemin(T), sup(a)/sup(b))
            return entireinterval(BareInterval{T})
        elseif sup(b) == 0
            inf(a) ≥ 0 && return @round(T, typemin(T), inf(a)/inf(b))
            sup(a) ≤ 0 && return @round(T, sup(a)/inf(b), typemax(T))
            return entireinterval(BareInterval{T})
        else
            return entireinterval(BareInterval{T})
        end
    end
end
Base.:/(x::BareInterval, y::BareInterval) = /(promote(x, y)...)

function Base.:/(x::Interval, y::Interval)
    by = bareinterval(y)
    r = bareinterval(x) / by
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse(in_interval(0, by), trv, d))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

Base.:\(x::BareInterval, y::BareInterval) = /(y, x)

"""
    //(x::BareInterval, y::BareInterval)
    //(x::Interval, y::Interval)

Implement the rational division; this is semantically equivalent to `x / y`.
"""
Base.://(x::BareInterval, y::BareInterval) = /(x, y) # not in the IEEE Standard 1788-2015

Base.://(x::Interval, y::Interval) = /(x, y)

"""
    muladd(x::BareInterval, y::BareInterval z::BareInterval)
    muladd(x::Interval, y::Interval z::Interval)

Implement the combined multiply-add; this is semantically equivalent to `x * y + z`.
"""
Base.muladd(x::BareInterval{T}, y::BareInterval{T}, z::BareInterval{T}) where {T<:NumTypes} = x * y + z # not in the IEEE Standard 1788-2015
Base.muladd(x::BareInterval, y::BareInterval, z::BareInterval) = muladd(promote(x, y, z)...)

function Base.muladd(x::Interval, y::Interval, z::Interval)
    r = muladd(bareinterval(x), bareinterval(y), bareinterval(z))
    d = min(decoration(x), decoration(y), decoration(z), decoration(r))
    t = isguaranteed(x) & isguaranteed(y) & isguaranteed(z)
    return _unsafe_interval(r, d, t)
end

"""
    fma(x::BareInterval, y::BareInterval, z::BareInterval)
    fma(x::Interval, y::Interval, z::Interval)

Implement the `fma` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.fma(x::BareInterval{T}, y::BareInterval{T}, z::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    isempty_interval(y) && return y
    isempty_interval(z) && return z

    if isentire_interval(x)
        isthinzero(y) && return z
        return entireinterval(BareInterval{T})
    elseif isentire_interval(y)
        isthinzero(x) && return z
        return entireinterval(BareInterval{T})
    end

    lo = setrounding(T, RoundDown) do
        lo1 = fma(inf(x), inf(y), inf(z))
        lo2 = fma(inf(x), sup(y), inf(z))
        lo3 = fma(sup(x), inf(y), inf(z))
        lo4 = fma(sup(x), sup(y), inf(z))
        return minimum(filter(x -> !isnan(x), (lo1, lo2, lo3, lo4)))
    end

    hi = setrounding(T, RoundUp) do
        hi1 = fma(inf(x), inf(y), sup(z))
        hi2 = fma(inf(x), sup(y), sup(z))
        hi3 = fma(sup(x), inf(y), sup(z))
        hi4 = fma(sup(x), sup(y), sup(z))
        return maximum(filter(x -> !isnan(x), (hi1, hi2, hi3, hi4)))
    end

    return _unsafe_bareinterval(T, lo, hi)
end
Base.fma(x::BareInterval, y::BareInterval, z::BareInterval) = fma(promote(x, y, z)...)

function Base.fma(x::Interval, y::Interval, z::Interval)
    r = fma(bareinterval(x), bareinterval(y), bareinterval(z))
    d = min(decoration(x), decoration(y), decoration(z), decoration(r))
    t = isguaranteed(x) & isguaranteed(y) & isguaranteed(z)
    return _unsafe_interval(r, d, t)
end

"""
    sqrt(x::BareInterval)
    sqrt(x::Interval)

Implement the `sqrt` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sqrt(x::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return @round(T, sqrt(lo), sqrt(hi))
end

function Base.sqrt(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    bx = bareinterval(x)
    r = sqrt(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end
