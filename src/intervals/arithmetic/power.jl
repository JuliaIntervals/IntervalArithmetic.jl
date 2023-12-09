# This file contains the functions described as "Power functions" in Section 9.1
# of the IEEE Standard 1788-2015 and required for set-based flavor in Section
# 10.5.3



# bare intervals

# code inspired by `power_by_squaring(::Any, ::Integer)` in base/intfuncs.jl
Base.@assume_effects :terminates_locally function _positive_power_by_squaring(x::BareInterval, p::Integer)
    if p == 1
        return x
    elseif p == 0
        return one(x)
    elseif p == 2
        return x*x
    end
    t = trailing_zeros(p) + 1
    p >>= t
    while (t -= 1) > 0
        x *= x
    end
    y = x
    while p > 0
        t = trailing_zeros(p) + 1
        p >>= t
        while (t -= 1) >= 0
            x *= x
        end
        y *= x
    end
    return y
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
pown(x::BareInterval{T}, n::Integer) where {T<:NumTypes} = BareInterval{T}(pown(_bigequiv(x), n))

function pown(a::BareInterval{BigFloat}, n::Integer)
    isempty_interval(a) && return a
    iszero(n) && return one(BareInterval{BigFloat})
    n == 1 && return a
    (n < 0 && isthinzero(a)) && return emptyinterval(BareInterval{BigFloat})

    if isodd(n) # odd power
        isentire_interval(a) && return a
        if n > 0
            inf(a) == 0 && return @round(BigFloat, zero(BigFloat), sup(a)^n)
            sup(a) == 0 && return @round(BigFloat, inf(a)^n, zero(BigFloat))
            return @round(BigFloat, inf(a)^n, sup(a)^n)
        else
            if inf(a) ≥ 0
                inf(a) == 0 && return @round(BigFloat, sup(a)^n, typemax(BigFloat))
                return @round(BigFloat, sup(a)^n, inf(a)^n)

            elseif sup(a) ≤ 0
                sup(a) == 0 && return @round(BigFloat, typemin(BigFloat), inf(a)^n)
                return @round(BigFloat, sup(a)^n, inf(a)^n)
            else
                return entireinterval(a)
            end
        end

    else # even power
        if n > 0
            if inf(a) ≥ 0
                return @round(BigFloat, inf(a)^n, sup(a)^n)
            elseif sup(a) ≤ 0
                return @round(BigFloat, sup(a)^n, inf(a)^n)
            else
                return @round(BigFloat, mig(a)^n, mag(a)^n)
            end

        else
            if inf(a) ≥ 0
                return @round(BigFloat, sup(a)^n, inf(a)^n)
            elseif sup(a) ≤ 0
                return @round(BigFloat, inf(a)^n, sup(a)^n)
            else
                return @round(BigFloat, mag(a)^n, mig(a)^n)
            end
        end
    end
end

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
Base.:^(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes} = BareInterval{T}(_bigequiv(x)^y)

Base.:^(x::BareInterval, y::BareInterval) = ^(promote(x, y)...)

function Base.:^(x::BareInterval{BigFloat}, y::BareInterval)
    isempty_interval(y) && return y
    domain = _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return hull(_pow(x, inf(y)), _pow(x, sup(y)))
end

# function _pow(a::BareInterval{T}, x::AbstractFloat) where {T<:Rational}
#     a = unsafe_interval(float(T), inf(a).num/inf(a).den, sup(a).num/sup(a).den)
#     return BareInterval{T}(a^x)
# end

_pow(a::BareInterval{BigFloat}, b::AbstractFloat) = _pow(a, big(b))

function _pow(a::BareInterval{BigFloat}, x::BigFloat)
    domain = _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat))

    if isthinzero(a)
        x > 0 && return zero(BareInterval{BigFloat})
        return emptyinterval(BareInterval{BigFloat})
    end

    isinteger(x) && return pown(a, Integer(x))
    x == 0.5 && return sqrt(a)

    a = intersect_interval(a, domain)
    isempty_interval(a) && return a

    M = typemax(BigFloat)
    MM = typemax(BareInterval{BigFloat})

    lo = @round(BigFloat, inf(a)^x, inf(a)^x)
    lo = (inf(lo) == M) ? MM : lo

    lo1 = @round(BigFloat, inf(a)^x, inf(a)^x)
    lo1 = (inf(lo1) == M) ? MM : lo1

    hi = @round(BigFloat, sup(a)^x, sup(a)^x)
    hi = (inf(hi) == M) ? MM : hi

    hi1 = @round(BigFloat, sup(a)^x, sup(a)^x)
    hi1 = (inf(hi1) == M) ? MM : hi1

    lo = hull(lo, lo1)
    hi = hull(hi, hi1)

    return hull(lo, hi)
end

function _pow(a::BareInterval{BigFloat}, x::Rational{T}) where {T<:Integer}
    p = x.num
    q = x.den

    isempty_interval(a) && return a
    iszero(x) && return one(a)
    x < 0 && return inv(_pow(a, -x))

    if isthinzero(a)
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    isinteger(x) && return pown(a, T(x))

    x == (1//2) && return sqrt(a)

    alo, ahi = bounds(a)

    if ahi < 0
        return emptyinterval(BareInterval{BigFloat})
    end

    if alo < 0 && ahi ≥ 0
        a = intersect_interval(a, _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat)))
    end

    b = rootn(a, q)

    p == 1 && return b

    return pown(b, p)
end

for f ∈ (:exp, :expm1)
    @eval begin
        function Base.$f(a::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            return @round( T, $f(inf(a)), $f(sup(a)) )
        end
    end
end

for f ∈ (:exp2, :exp10, :cbrt)
    @eval begin
        Base.$f(a::BareInterval{T}) where {T<:NumTypes} = BareInterval{T}($f(_bigequiv(a)))  # no CRlibm version

        function Base.$f(a::BareInterval{BigFloat})
            isempty_interval(a) && return a
            return @round( BigFloat, $f(inf(a)), $f(sup(a)) )
        end
    end
end

for f ∈ (:log, :log2, :log10)
    @eval function Base.$f(a::BareInterval{T}) where {T<:NumTypes}
        domain = _unsafe_bareinterval(T, zero(T), typemax(T))
        a = intersect_interval(a, domain)

        isempty_interval(a) | (sup(a) ≤ 0) && return emptyinterval(BareInterval{T})

        return @round( T, $f(inf(a)), $f(sup(a)) )
    end
end

function Base.log1p(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), typemax(T))
    a = intersect_interval(a, domain)

    isempty_interval(a) | (sup(a) ≤ -1) && return emptyinterval(BareInterval{T})

    @round( T, log1p(inf(a)), log1p(sup(a)) )
end

"""
    rootn(a::BareInterval, n::Integer)

Compute the real `n`-th root of `a`.

Implement the `rootn` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function rootn(a::BareInterval{BigFloat}, n::Integer)
    isempty_interval(a) && return a
    n == 1 && return a
    n == 2 && return sqrt(a)
    n == 0 && return emptyinterval(a)
    # n < 0 && isthinzero(a) && return emptyinterval(a)
    n < 0 && return inv(rootn(a, -n))

    alo, ahi = bounds(a)
    ahi < 0 && iseven(n) && return emptyinterval(BareInterval{BigFloat})
    if alo < 0 && ahi ≥ 0 && iseven(n)
        a = intersect_interval(a, _unsafe_bareinterval(BigFloat, zero(BigFloat), typemax(BigFloat)))
        alo, ahi = bounds(a)
    end
    ui = convert(Culong, n)
    low = BigFloat()
    high = BigFloat()
    ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , alo , ui, MPFRRoundDown)
    ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , ahi , ui, MPFRRoundUp)
    return bareinterval(BigFloat, low , high)
end

function rootn(a::BareInterval{T}, n::Integer) where {T<:NumTypes}
    n == 1 && return a
    n == 2 && return sqrt(a)

    abig = _bigequiv(a)
    if n < 0
        issubnormal(mag(a)) && return inv(rootn(a, -n))
        return BareInterval{T}(inv(rootn(abig, -n)))
    end

    b = rootn(abig, n)
    return BareInterval{T}(b)
end

"""
    hypot(x::BareInterval, n::BareInterval)

Compute the hypotenuse.
"""
Base.hypot(x::BareInterval, y::BareInterval) = sqrt(pown(x, 2) + pown(y, 2))

"""
    fastpow(x::BareInterval, n::Integer)

A faster implementation of `x^n`, currently using `power_by_squaring`.
`fastpow(x, n)` will usually return an interval that is slightly larger than that
calculated by `x^n`, but is guaranteed to be a correct
enclosure when using multiplication with correct rounding.
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
    isempty_interval(x) && return x
    isthininteger(y) && return fastpow(x, Integer(sup(y)))
    return exp(y * log(x))
end

fastpow(x::BareInterval{T}, y::S) where {T<:NumTypes,S<:Real} =
    fastpow(x, bareinterval(promote_numtype(T, S), y))



# decorated intervals

# overwrite behaviour for small integer powers from https://github.com/JuliaLang/julia/pull/24240
Base.literal_pow(::typeof(^), x::Interval, ::Val{p}) where {p} = x^p

function pown(x::Interval, n::Integer)
    r = pown(bareinterval(x), n)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(n < 0 && in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

function Base.:^(xx::Interval, qq::Interval)
    x = bareinterval(xx)
    q = bareinterval(qq)
    r = x^q
    d = min(decoration(xx), decoration(qq), decoration(r))
    t = isguaranteed(xx) & isguaranteed(qq)
    if inf(x) > 0 || (inf(x) ≥ 0 && inf(q) > 0) ||
            (isthininteger(q) && inf(q) > 0) ||
            (isthininteger(q) && !in_interval(0, x))
        return _unsafe_interval(r, d, t)
    end
    return _unsafe_interval(r, trv, t)
end
Base.:^(x::Interval, y::Real) = ^(promote(x, y)...)
Base.:^(x::Real, y::Interval) = ^(promote(x, y)...)
# needed to resolve method ambiguities
Base.:^(x::Interval, n::Integer) = x ^ (n//1)
for S ∈ (:Rational, :AbstractFloat)
    @eval function Base.:^(x::Interval{T}, y::$S) where {T<:NumTypes}
        domain = _unsafe_bareinterval(T, zero(T), typemax(T))
        bx = bareinterval(x)
        bx = intersect_interval(bx, domain)
        isempty_interval(x) && return x
        r = BareInterval{T}(_pow(_bigequiv(bx), y))
        d = min(decoration(x), decoration(r))
        if inf(x) > 0 || (inf(x) ≥ 0 && y > 0) ||
                (isinteger(y) && y > 0) ||
                (isinteger(y) && !in_interval(0, x))
            return _unsafe_interval(r, d, false)
        end
        return _unsafe_interval(r, min(d, trv), false)
    end
end

for f ∈ (:exp, :exp2, :exp10, :expm1, :cbrt)
    @eval function Base.$f(xx::Interval)
        x = bareinterval(xx)
        r = $f(x)
        d = min(decoration(r), decoration(xx))
        return _unsafe_interval(r, d, isguaranteed(xx))
    end
end

for f ∈ (:log, :log2, :log10)
    @eval function Base.$f(a::Interval{T}) where {T<:NumTypes}
        domain = _unsafe_bareinterval(T, zero(T), typemax(T))
        x = bareinterval(a)
        r = $f(x)
        d = min(decoration(a), decoration(r))
        d = min(d, ifelse(isinterior(x, domain), d, trv))
        return _unsafe_interval(r, d, isguaranteed(a))
    end
end

function Base.log1p(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), typemax(T))
    x = bareinterval(a)
    r = log1p(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isinterior(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

function rootn(a::Interval{T}, n::Integer) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, ifelse(iseven(n), zero(T), typemin(T)), typemax(T))
    x = bareinterval(a)
    r = rootn(x, n)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

Base.hypot(x::Interval, y::Interval) = sqrt(x^2 + y^2)

function fastpow(xx::Interval, qq::Interval)
    x = bareinterval(xx)
    q = bareinterval(qq)
    r = fastpow(x, q)
    d = min(decoration(xx), decoration(qq), decoration(r))
    t = isguaranteed(xx) & isguaranteed(qq)
    if inf(x) > 0 || (inf(x) ≥ 0 && inf(q) > 0) ||
            (isthininteger(q) && inf(q) > 0) ||
            (isthininteger(q) && !in_interval(0, x))
        return _unsafe_interval(r, d, t)
    end
    return _unsafe_interval(r, trv, t)
end

function fastpow(xx::Interval, q::Real)
    x = bareinterval(xx)
    r = fastpow(x, q)
    d = min(decoration(xx), decoration(r))
    if inf(x) > 0 || (inf(x) ≥ 0 && q > 0) ||
            (isinteger(q) && q > 0) ||
            (isinteger(q) && !in_interval(0, x))
        return _unsafe_interval(r, d, false)
    end
    return _unsafe_interval(r, trv, false)
end
