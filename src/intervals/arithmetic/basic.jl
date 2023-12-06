# This file contains the functions described as "Basic arithmetic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

+(a::BareInterval) = a # not in the IEEE Standard 1788-2015

+(a::Interval) = a

"""
    +(a::BareInterval, b::BareInterval)
    +(a::Interval, b::Interval)

Implement the `add` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function +(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    return @round(T, inf(a) + inf(b), sup(a) + sup(b))
end
+(a::BareInterval, b::BareInterval) = +(promote(a, b)...)

function +(a::Interval, b::Interval)
    r = bareinterval(a) + bareinterval(b)
    d = min(decoration(a), decoration(b), decoration(r))
    t = isguaranteed(a) & isguaranteed(b)
    return _unsafe_interval(r, d, t)
end

"""
    -(a::BareInterval)
    -(a::Interval)

Implement the `neg` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
-(a::BareInterval{T}) where {T<:NumTypes} = _unsafe_bareinterval(T, -sup(a), -inf(a))

-(a::Interval) = _unsafe_interval(-bareinterval(a), decoration(a), isguaranteed(a))

"""
    -(a::BareInterval, b::BareInterval)
    -(a::Interval, b::Interval)

Implement the `sub` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function -(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    return @round(T, inf(a) - sup(b), sup(a) - inf(b))
end
-(a::BareInterval, b::BareInterval) = -(promote(a, b)...)

function -(a::Interval, b::Interval)
    r = bareinterval(a) - bareinterval(b)
    d = min(decoration(a), decoration(b), decoration(r))
    t = isguaranteed(a) & isguaranteed(b)
    return _unsafe_interval(r, d, t)
end

"""
    *(a::BareInterval, b::BareInterval)
    *(a::Interval, b::Interval)

Implement the `mul` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `*` is flavor dependent for some edge cases.
"""
function *(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    isthinzero(a) && return a
    isthinzero(b) && return b
    isbounded(a) && isbounded(b) && return _mult(*, a, b)
    return _mult((x, y, r) -> _unbounded_mult(x, y, r), a, b)
end
*(a::BareInterval, b::BareInterval) = *(promote(a, b)...)

function *(a::Interval, b::Interval)
    r = bareinterval(a) * bareinterval(b)
    d = min(decoration(a), decoration(b), decoration(r))
    t = isguaranteed(a) & isguaranteed(b)
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
    inv(a::BareInterval)
    inv(a::Interval)

Implement the `recip` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `inv` is flavor dependent for some edge cases.
"""
function inv(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    if in_interval(0, a)
        inf(a) < 0 == sup(a) && return @round(T, typemin(T), inv(inf(a)))
        inf(a) == 0 < sup(a) && return @round(T, inv(sup(a)), typemax(T))
        inf(a) < 0 < sup(a) && return entireinterval(BareInterval{T})
        isthinzero(a) && return div_by_thin_zero(_unsafe_bareinterval(T, one(T), one(T)))
    end
    return @round(T, inv(sup(a)), inv(inf(a)))
end

function inv(a::Interval)
    x = bareinterval(a)
    r = inv(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    /(a::BareInterval, b::BareInterval)
    /(a::Interval, b::Interval)

Implement the `div` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `/` is flavor dependent for some edge cases.
"""
function /(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
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
/(a::BareInterval, b::BareInterval) = /(promote(a, b)...)
\(a::BareInterval, b::BareInterval) = /(b, a)

function /(a::Interval, b::Interval)
    x = bareinterval(b)
    r = bareinterval(a) / x
    d = min(decoration(a), decoration(b), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    t = isguaranteed(a) & isguaranteed(b)
    return _unsafe_interval(r, d, t)
end

"""
    //(a::BareInterval, b::BareInterval)
    //(a::Interval, b::Interval)

Implement the rational division; this is semantically equivalent to `a / b`.
"""
//(a::BareInterval, b::BareInterval) = a / b # not in the IEEE Standard 1788-2015

//(a::Interval, b::Interval) = /(a, b)

# Arithmetic operations with intervals yield guaranteed results
for (T, fc) in ((:BareInterval, :(bareinterval)), (:Interval, :(interval)))
    for op in (:+, :-, :*, :/, ://)
        @eval begin
            $(op)(n::Integer, x::$T) = $(op)($fc(n), x)
            $(op)(x::$T, n::Integer) = $(op)(x, $fc(n))
        end
    end
end

"""
    muladd(a::BareInterval, b::BareInterval c::BareInterval)
    muladd(a::Interval, b::Interval c::Interval)

Implement the combined multiply-add; this is semantically equivalent to `a * b + c`
"""
muladd(a::F, b::F, c::F) where {F<:BareInterval} = a * b + c # not in the IEEE Standard 1788-2015
muladd(a::BareInterval, b::BareInterval, c::BareInterval) = muladd(promote(a, b, c)...)

function muladd(a::Interval, b::Interval, c::Interval)
    r = muladd(bareinterval(a), bareinterval(b), bareinterval(c))
    d = min(decoration(a), decoration(b), decoration(c), decoration(r))
    t = isguaranteed(a) & isguaranteed(b) & isguaranteed(c)
    return _unsafe_interval(r, d, t)
end

"""
    fma(a::BareInterval, b::BareInterval, c::BareInterval)
    fma(a::Interval, b::Interval, c::Interval)

Implement the `fma` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function fma(a::BareInterval{T}, b::BareInterval{T}, c::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    isempty_interval(c) && return c

    if isentire_interval(a)
        isthinzero(b) && return c
        return entireinterval(BareInterval{T})
    elseif isentire_interval(b)
        isthinzero(a) && return c
        return entireinterval(BareInterval{T})
    end

    lo = setrounding(T, RoundDown) do
        lo1 = fma(inf(a), inf(b), inf(c))
        lo2 = fma(inf(a), sup(b), inf(c))
        lo3 = fma(sup(a), inf(b), inf(c))
        lo4 = fma(sup(a), sup(b), inf(c))
        return minimum(filter(x -> !isnan(x), (lo1, lo2, lo3, lo4)))
    end

    hi = setrounding(T, RoundUp) do
        hi1 = fma(inf(a), inf(b), sup(c))
        hi2 = fma(inf(a), sup(b), sup(c))
        hi3 = fma(sup(a), inf(b), sup(c))
        hi4 = fma(sup(a), sup(b), sup(c))
        return maximum(filter(x -> !isnan(x), (hi1, hi2, hi3, hi4)))
    end

    return _unsafe_bareinterval(T, lo, hi)
end
fma(a::BareInterval, b::BareInterval, c::BareInterval) = fma(promote(a, b, c)...)

function fma(a::Interval, b::Interval, c::Interval)
    r = fma(bareinterval(a), bareinterval(b), bareinterval(c))
    d = min(decoration(a), decoration(b), decoration(c), decoration(r))
    t = isguaranteed(a) & isguaranteed(b) & isguaranteed(c)
    return _unsafe_interval(r, d, t)
end

"""
    sqrt(a::BareInterval)

Implement the `sqrt` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sqrt(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return @round(T, sqrt(lo), sqrt(hi))
end

function sqrt(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = bareinterval(a)
    r = sqrt(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end
