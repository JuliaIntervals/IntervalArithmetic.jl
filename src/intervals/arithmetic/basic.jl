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
    @inline r = bareinterval(x) + bareinterval(y)
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
    @inline r = bareinterval(x) - bareinterval(y)
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
    return _mult(_unbounded_mul, x, y)
end
Base.:*(x::BareInterval, y::BareInterval) = *(promote(x, y)...)

function Base.:*(x::Interval, y::Interval)
    @inline r = bareinterval(x) * bareinterval(y)
    d = min(decoration(x), decoration(y), decoration(r))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

# helper functions for multiplication

function _unbounded_mul(x::T, y::T, r::RoundingMode) where {T<:NumTypes}
    iszero(x) && return sign(y) * zero_times_infinity(T)
    iszero(y) && return sign(x) * zero_times_infinity(T)
    return _fround(*, x, y, r)
end

for f ∈ (:_unbounded_mul, :*)
    @eval function _mult(::typeof($f), x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
        if inf(y) ≥ 0
            inf(x) ≥ 0 && return @round(T, $f(inf(x), inf(y)), $f(sup(x), sup(y)))
            sup(x) ≤ 0 && return @round(T, $f(inf(x), sup(y)), $f(sup(x), inf(y)))
            return @round(T, inf(x)*sup(y), sup(x)*sup(y))
        elseif sup(y) ≤ 0
            inf(x) ≥ 0 && return @round(T, $f(sup(x), inf(y)), $f(inf(x), sup(y)))
            sup(x) ≤ 0 && return @round(T, $f(sup(x), sup(y)), $f(inf(x), inf(y)))
            return @round(T, sup(x)*inf(y), inf(x)*inf(y))
        else
            inf(x) > 0 && return @round(T, $f(sup(x), inf(y)), $f(sup(x), sup(y)))
            sup(x) < 0 && return @round(T, $f(inf(x), sup(y)), $f(inf(x), inf(y)))
            return @round(T, min( $f(inf(x), sup(y)), $f(sup(x), inf(y)) ),
                             max( $f(inf(x), inf(y)), $f(sup(x), sup(y)) ))
        end
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
        # isthinzero(x)
        return div_by_thin_zero(_unsafe_bareinterval(T, one(T), one(T)))
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

function Base.inv(x::Complex{<:Interval})
    d = abs2(x)
    return complex(real(x) / d, -imag(x) / d)
end

"""
    /(x::BareInterval, y::BareInterval)
    /(x::Interval, y::Interval)

Implement the `div` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `/` is flavor dependent for some edge cases.
"""
function Base.:/(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    isempty_interval(y) && return y
    isthinzero(y) && return div_by_thin_zero(x)
    if inf(y) > 0
        inf(x) ≥ 0 && return @round(T, inf(x)/sup(y), sup(x)/inf(y))
        sup(x) ≤ 0 && return @round(T, inf(x)/inf(y), sup(x)/sup(y))
        return @round(T, inf(x)/inf(y), sup(x)/inf(y))
    elseif sup(y) < 0
        inf(x) ≥ 0 && return @round(T, sup(x)/sup(y), inf(x)/inf(y))
        sup(x) ≤ 0 && return @round(T, sup(x)/inf(y), inf(x)/sup(y))
        return @round(T, sup(x)/sup(y), inf(x)/sup(y))
    else
        isthinzero(x) && return x
        if iszero(inf(y))
            inf(x) ≥ 0 && return @round(T, inf(x)/sup(y), typemax(T))
            sup(x) ≤ 0 && return @round(T, typemin(T), sup(x)/sup(y))
            return entireinterval(BareInterval{T})
        elseif sup(y) == 0
            inf(x) ≥ 0 && return @round(T, typemin(T), inf(x)/inf(y))
            sup(x) ≤ 0 && return @round(T, sup(x)/inf(y), typemax(T))
            return entireinterval(BareInterval{T})
        else
            return entireinterval(BareInterval{T})
        end
    end
end
Base.:/(x::BareInterval, y::BareInterval) = /(promote(x, y)...)

function Base.:/(x::Interval, y::Interval)
    by = bareinterval(y)
    @inline r = bareinterval(x) / by
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse(in_interval(0, by), trv, d))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

Base.:/(x::Complex{<:Interval}, y::Complex{<:Interval}) = x * inv(y)
Base.:/(x::Complex{<:Interval}, y::Interval) = x * inv(y)
Base.:/(x::Interval, y::Complex{<:Interval}) = x * inv(y)

Base.:\(x::BareInterval, y::BareInterval) = /(y, x)

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
Base.fma(x::BareInterval{T}, y::BareInterval{T}, z::BareInterval{T}) where {T<:NumTypes} = x * y + z
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
function Base.sqrt(x::BareInterval{T}) where {T<:AbstractFloat}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return @round(T, sqrt(inf(x)), sqrt(sup(x)))
end

Base.sqrt(x::BareInterval{<:Rational}) = sqrt(float(x))

function Base.sqrt(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    bx = bareinterval(x)
    r = sqrt(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.sqrt(x::Complex{Interval{T}}) where {T<:NumTypes} = x ^ interval(1//2)
