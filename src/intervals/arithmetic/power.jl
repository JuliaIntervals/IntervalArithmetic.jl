# This file contains the functions described as "Power functions" in Section 9.1
# of the IEEE Standard 1788-2015 and required for set-based flavor in Section
# 10.5.3

"""
    ^(x, y)

Compute the power of the positive real part of `x` by `y`. In particular, even
if `y` is a thin integer, this is not equivalent to `pown(x, sup(y))`.

Implement the `pow` function of the IEEE Standard 1788-2015 (Table 9.1).

See also: [`pown`](@ref).

# Examples

```jldoctest
julia> bareinterval(2, 3) ^ bareinterval(2)
[4.0, 9.0]

julia> interval(-1, 1) ^ interval(3)
[0.0, 1.0]_com

julia> interval(-1, 1) ^ interval(-3)
[1.0, ∞)_trv
```
"""
Base.:^(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes} = # no CRlibm version
    BareInterval{T}(_bigequiv(x)^y)

Base.:^(x::BareInterval, y::BareInterval) = ^(promote(x, y)...)

function Base.:^(x::BareInterval{BigFloat}, y::BareInterval)
    isempty_interval(y) && return y
    domain = _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return hull(_pow(x, inf(y)), _pow(x, sup(y)))
end

function Base.:^(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r = bx^by
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse((in_interval(0, bx) & (inf(by) ≤ 0)) | ((inf(bx) < 0) & !isthininteger(by)), trv, d))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

# overwrite behaviour for small integer powers from https://github.com/JuliaLang/julia/pull/24240
Base.literal_pow(::typeof(^), x::Interval, ::Val{n}) where {n} = x^n

Base.:^(x::Interval, n::Integer) = ^(promote(x, n)...)

# helper functions for power

_pow(x::BareInterval{BigFloat}, y::AbstractFloat) = _pow(x, big(y))

function _pow(x::BareInterval{BigFloat}, y::BigFloat)
    domain = _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat))

    if isthinzero(x)
        y > 0 && return zero(BareInterval{BigFloat})
        return emptyinterval(BareInterval{BigFloat})
    end

    isinteger(y) && return pown(x, Integer(y))
    y == 0.5 && return sqrt(x)

    x = intersect_interval(x, domain)
    isempty_interval(x) && return x

    M = typemax(BigFloat)
    MM = typemax(BareInterval{BigFloat})

    lo = @round(BigFloat, inf(x)^y, inf(x)^y)
    lo = (inf(lo) == M) ? MM : lo

    lo1 = @round(BigFloat, inf(x)^y, inf(x)^y)
    lo1 = (inf(lo1) == M) ? MM : lo1

    hi = @round(BigFloat, sup(x)^y, sup(x)^y)
    hi = (inf(hi) == M) ? MM : hi

    hi1 = @round(BigFloat, sup(x)^y, sup(x)^y)
    hi1 = (inf(hi1) == M) ? MM : hi1

    lo = hull(lo, lo1)
    hi = hull(hi, hi1)

    return hull(lo, hi)
end

function _pow(x::BareInterval{BigFloat}, y::Rational{T}) where {T<:Integer}
    p = y.num
    q = y.den

    isempty_interval(x) && return x
    iszero(y) && return one(x)
    y < 0 && return inv(_pow(x, -y))

    if isthinzero(x)
        y > zero(y) && return zero(x)
        return emptyinterval(x)
    end

    isinteger(y) && return pown(x, T(y))

    y == (1//2) && return sqrt(x)

    lo, hi = bounds(x)

    if lo < 0
        return emptyinterval(BareInterval{BigFloat})
    end

    if lo < 0 && hi ≥ 0
        x = intersect_interval(x, _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat)))
    end

    return pown(rootn(x, q), ifelse(p == 1, q, p))
end

"""
    pown(x, n)

Implement the `pown` function of the IEEE Standard 1788-2015 (Table 9.1).

# Examples

```jldoctest
julia> pown(bareinterval(2, 3), 2)
[4.0, 9.0]

julia> pown(interval(-1, 1), 3)
[-1.0, 1.0]_com

julia> pown(interval(-1, 1), -3)
(-∞, ∞)_trv
```
"""
pown(x::BareInterval{T}, n::Integer) where {T<:NumTypes} = # no CRlibm version
    BareInterval{T}(pown(_bigequiv(x), n))

function pown(x::BareInterval{BigFloat}, n::Integer)
    isempty_interval(x) && return x
    iszero(n) && return one(BareInterval{BigFloat})
    n == 1 && return x
    (n < 0) & isthinzero(x) && return emptyinterval(BareInterval{BigFloat})

    if isodd(n)
        isentire_interval(x) && return x
        if n > 0
            inf(x) == 0 && return @round(BigFloat, zero(BigFloat), sup(x)^n)
            sup(x) == 0 && return @round(BigFloat, inf(x)^n, zero(BigFloat))
            return @round(BigFloat, inf(x)^n, sup(x)^n)
        else
            if inf(x) ≥ 0
                inf(x) == 0 && return @round(BigFloat, sup(x)^n, typemax(BigFloat))
                return @round(BigFloat, sup(x)^n, inf(x)^n)
            elseif sup(x) ≤ 0
                sup(x) == 0 && return @round(BigFloat, typemin(BigFloat), inf(x)^n)
                return @round(BigFloat, sup(x)^n, inf(x)^n)
            else
                return entireinterval(x)
            end
        end
    else
        if n > 0
            if inf(x) ≥ 0
                return @round(BigFloat, inf(x)^n, sup(x)^n)
            elseif sup(x) ≤ 0
                return @round(BigFloat, sup(x)^n, inf(x)^n)
            else
                return @round(BigFloat, mig(x)^n, mag(x)^n)
            end
        else
            if inf(x) ≥ 0
                return @round(BigFloat, sup(x)^n, inf(x)^n)
            elseif sup(x) ≤ 0
                return @round(BigFloat, inf(x)^n, sup(x)^n)
            else
                return @round(BigFloat, mag(x)^n, mig(x)^n)
            end
        end
    end
end

function pown(x::Interval, n::Integer)
    r = pown(bareinterval(x), n)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse((n < 0) & in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    rootn(x::BareInterval, n::Integer)

Compute the real `n`-th root of `x`.

Implement the `rootn` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function rootn(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    isempty_interval(x) && return x
    n == 0 && return emptyinterval(BareInterval{T})
    n == 1 && return x
    n == 2 && return sqrt(x)
    n > 0 && return BareInterval{T}(rootn(_bigequiv(x), n))
    issubnormal(mag(x)) && return inv(rootn(x, -n))
    return BareInterval{T}(inv(rootn(_bigequiv(x), -n)))
end

function rootn(x::BareInterval{BigFloat}, n::Integer)
    isempty_interval(x) && return x
    n == 0 && return emptyinterval(BareInterval{BigFloat})
    n == 1 && return x
    n == 2 && return sqrt(x)
    n < 0 && return inv(rootn(x, -n))

    domain = _unsafe_bareinterval(BigFloat, ifelse(iseven(n), zero(BigFloat), typemin(BigFloat)), typemax(BigFloat))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x

    # no CRlibm version
    lo, hi = bounds(x)
    ui = convert(Culong, n)
    low = BigFloat()
    high = BigFloat()
    ccall((:mpfr_rootn_ui, :libmpfr), Int32, (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode), low, lo, ui, MPFRRoundDown)
    ccall((:mpfr_rootn_ui, :libmpfr), Int32, (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode), high, hi, ui, MPFRRoundUp)
    return _unsafe_bareinterval(BigFloat, low, high)
end

function rootn(x::Interval{T}, n::Integer) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, ifelse(iseven(n), zero(T), typemin(T)), typemax(T))
    bx = bareinterval(x)
    r = rootn(bx, n)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end


"""
    hypot(x, y)

Compute the hypotenuse; this is semantically equivalent to
`sqrt(pown(x, 2) + pown(y, 2))`.
"""
Base.hypot(x::BareInterval, y::BareInterval) = sqrt(pown(x, 2) + pown(y, 2))

Base.hypot(x::Interval, y::Interval) = sqrt(x^2 + y^2)

"""
    fastpow(x, n)

A faster implementation of `x^n`; the returned interval may be slightly large
than `x^n`.
"""
function fastpow(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    n < 0 && return inv(fastpow(x, -n))
    isempty_interval(x) && return x
    if iseven(n) && in_interval(0, x)
        xmig = mig(x)
        xmag = mag(x)
        return hull(zero(x),
                _positive_power_by_squaring(_unsafe_bareinterval(T, xmig, xmig), n),
                _positive_power_by_squaring(_unsafe_bareinterval(T, xmag, xmag), n))
    else
        xinf = inf(x)
        xsup = sup(x)
        return hull(_positive_power_by_squaring(_unsafe_bareinterval(T, xinf, xinf), n),
                    _positive_power_by_squaring(_unsafe_bareinterval(T, xsup, xsup), n))
    end
end

function fastpow(x::BareInterval, y::BareInterval)
    isthininteger(y) && return fastpow(x, Integer(sup(y)))
    return exp(y * log(x))
end

fastpow(x::BareInterval{T}, y::S) where {T<:NumTypes,S<:Real} =
    fastpow(x, bareinterval(promote_numtype(T, S), y))

function fastpow(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r = fastpow(bx, by)
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse((in_interval(0, bx) & (inf(by) ≤ 0)) | ((inf(bx) < 0) & !isthininteger(by)), trv, d))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

function fastpow(x::Interval, y::Real)
    bx = bareinterval(x)
    r = fastpow(bx, y)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse((in_interval(0, bx) & (y ≤ 0)) | ((inf(bx) < 0) & !isinteger(y)), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

# helper function for fast power

# code inspired by `power_by_squaring(::Any, ::Integer)` in base/intfuncs.jl
Base.@assume_effects :terminates_locally function _positive_power_by_squaring(x::BareInterval, n::Integer)
    if n == 1
        return x
    elseif n == 0
        return one(x)
    elseif n == 2
        return x*x
    end
    t = trailing_zeros(n) + 1
    n >>= t
    while (t -= 1) > 0
        x *= x
    end
    y = x
    while n > 0
        t = trailing_zeros(n) + 1
        n >>= t
        while (t -= 1) >= 0
            x *= x
        end
        y *= x
    end
    return y
end

#

for f ∈ (:exp, :expm1)
    @eval begin
        function Base.$f(x::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(x) && return x
            return @round(T, $f(inf(x)), $f(sup(x)))
        end
    end
end

for f ∈ (:exp2, :exp10, :cbrt) # no CRlibm version
    @eval begin
        Base.$f(x::BareInterval{T}) where {T<:NumTypes} = BareInterval{T}($f(_bigequiv(x)))

        function Base.$f(x::BareInterval{BigFloat})
            isempty_interval(x) && return x
            return @round(BigFloat, $f(inf(x)), $f(sup(x)) )
        end
    end
end

for f ∈ (:exp, :exp2, :exp10, :expm1, :cbrt)
    @eval function Base.$f(x::Interval)
        bx = bareinterval(x)
        r = $f(bx)
        d = min(decoration(r), decoration(x))
        return _unsafe_interval(r, d, isguaranteed(x))
    end
end

#

for f ∈ (:log, :log2, :log10)
    @eval begin
        function Base.$f(x::BareInterval{T}) where {T<:NumTypes}
            domain = _unsafe_bareinterval(T, zero(T), typemax(T))
            x = intersect_interval(x, domain)
            isempty_interval(x) | (sup(x) == 0) && return emptyinterval(BareInterval{T})
            return @round(T, $f(inf(x)), $f(sup(x)))
        end

        function Base.$f(x::Interval{T}) where {T<:NumTypes}
            domain = _unsafe_bareinterval(T, zero(T), typemax(T))
            bx = bareinterval(x)
            r = $f(bx)
            d = min(decoration(x), decoration(r))
            d = min(d, ifelse(isinterior(bx, domain), d, trv))
            return _unsafe_interval(r, d, isguaranteed(x))
        end
    end
end

function Base.log1p(x::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) | (sup(x) == -1) && return emptyinterval(BareInterval{T})
    return @round(T, log1p(inf(x)), log1p(sup(x)))
end

function Base.log1p(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), typemax(T))
    bx = bareinterval(x)
    r = log1p(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isinterior(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end
