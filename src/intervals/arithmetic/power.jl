# This file contains the functions described as "Power functions" in Section 9.1
# of the IEEE Standard 1788-2015 and required for set-based flavor in Section
# 10.5.3
# Some of the "Recommended operations" (Section 10.6.1) are also present

# power mechanism used in `^`

"""
    PowerMode

Power mode type for `^`.

Available mode types:
- `:fast` (default): `x ^ y` is semantically equivalent to `fastpow(x, y)`,
unless `isthininteger(y)` is true in which case it is semantically equivalent to
`fastpown(x, sup(y))`.
- `:slow`: `x ^ y` is semantically equivalent to `pow(x, y)`, unless
`isthininteger(y)` is true in which case it is semantically equivalent to
`pown(x, sup(y))`.
"""
struct PowerMode{T} end

power_mode() = PowerMode{:fast}()

"""
    ^(x::BareInterval, y::BareInterval)
    ^(x::Interval, y::Interval)

Compute the power of the positive real part of `x` by `y`. This function is not
in the IEEE Standard 1788-2015. Its behaviour depend on the current
[`PowerMode`](@ref).

See also: [`pow`](@ref) and [`pown`](@ref).

# Examples

```jldoctest
julia> setdisplay(:full);

julia> bareinterval(2, 3) ^ bareinterval(2)
BareInterval{Float64}(4.0, 9.0)

julia> interval(-1, 1) ^ interval(3)
Interval{Float64}(-1.0, 1.0, com)

julia> interval(-1, 1) ^ interval(-3)
Interval{Float64}(-Inf, Inf, trv)
```
"""
function Base.:^(x::BareInterval, y::BareInterval)
    isthininteger(y) && return _select_pown(power_mode(), x, Integer(sup(y)))
    return _select_pow(power_mode(), x, y)
end

function Base.:^(x::Interval, y::Interval)
    isthininteger(y) || return _select_pow(power_mode(), x, y)
    r = _select_pown(power_mode(), x, Integer(sup(y)))
    d = min(decoration(r), decoration(y))
    t = isguaranteed(r) & isguaranteed(y)
    return _unsafe_interval(bareinterval(r), d, t)
end

Base.:^(n::Integer, y::Interval) = ^(n//one(n), y)
Base.:^(x::Interval, n::Integer) = ^(x, n//one(n))
Base.:^(x::Rational, y::Interval) = ^(convert(Interval{typeof(x)}, x), y)
Base.:^(x::Interval, y::Rational) = ^(x, convert(Interval{typeof(y)}, y))

# overwrite behaviour for small integer powers from https://github.com/JuliaLang/julia/pull/24240
Base.literal_pow(::typeof(^), x::Interval, ::Val{n}) where {n} = x^n

# helper functions for power

_select_pow(::PowerMode{:fast}, x, y) = fastpow(x, y)
_select_pown(::PowerMode{:fast}, x, y) = fastpown(x, y)
_select_pow(::PowerMode{:slow}, x, y) = pow(x, y)
_select_pown(::PowerMode{:slow}, x, y) = pown(x, y)

"""
    pow(x, y)

Compute the power of the positive real part of `x` by `y`. In particular, even
if `y` is a thin integer, this is not equivalent to `pown(x, sup(y))`.

Implement the `pow` function of the IEEE Standard 1788-2015 (Table 9.1).

See also: [`pown`](@ref).

# Examples

```jldoctest
julia> setdisplay(:full);

julia> pow(bareinterval(2, 3), bareinterval(2))
BareInterval{Float64}(4.0, 9.0)

julia> pow(interval(-1, 1), interval(3))
Interval{Float64}(0.0, 1.0, trv)

julia> pow(interval(-1, 1), interval(-3))
Interval{Float64}(1.0, Inf, trv)
```
"""
function pow(x::BareInterval{T}, y::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(y) && return y
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    isthin(y) && return _pow(x, sup(y))
    return hull(_pow(x, inf(y)), _pow(x, sup(y)))
end
function pow(x::BareInterval{T}, y::BareInterval{T}) where {T<:Rational}
    isempty_interval(y) && return y
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    isthin(y) && return _pow(x, sup(y))
    return hull(_pow(x, inf(y)), _pow(x, sup(y)))
end
pow(x::BareInterval{<:AbstractFloat}, y::BareInterval{<:AbstractFloat}) = pow(promote(x, y)...)
pow(x::BareInterval{<:Rational}, y::BareInterval{<:Rational}) = pow(promote(x, y)...)
pow(x::BareInterval{<:Rational}, y::BareInterval{<:AbstractFloat}) = pow(promote(x, y)...)
# specialize on rational to improve exactness
function pow(x::BareInterval{T}, y::BareInterval{S}) where {T<:NumTypes,S<:Rational}
    R = promote_numtype(T, S)
    isempty_interval(y) && return emptyinterval(BareInterval{R})
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return emptyinterval(BareInterval{R})
    isthin(y) && return BareInterval{R}(_pow(x, sup(y)))
    return BareInterval{R}(hull(_pow(x, inf(y)), _pow(x, sup(y))))
end

pow(n::Integer, y::BareInterval) = pow(n//one(n), y)
pow(x::BareInterval, n::Integer) = pow(x, n//one(n))
pow(x::Real, y::BareInterval) = pow(bareinterval(x), y)
pow(x::BareInterval, y::Real) = pow(x, bareinterval(y))

function pow(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r = pow(bx, by)
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse((inf(bx) > 0) | ((inf(bx) == 0) & (inf(by) > 0)), d, trv))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

pow(n::Integer, y::Interval) = pow(n//one(n), y)
pow(x::Interval, n::Integer) = pow(x, n//one(n))
pow(x::Real, y::Interval) = pow(interval(x), y)
pow(x::Interval, y::Real) = pow(x, interval(y))

# helper functions for power

function _pow(x::BareInterval{T}, y::T) where {T<:NumTypes}
    # assume `inf(x) ≥ 0` and `!isempty_interval(x)`
    if sup(x) == 0
        y > 0 && return x # zero(x)
        return emptyinterval(BareInterval{T})
    else
        isinteger(y) && return pown(x, Integer(y))
        y == 0.5 && return sqrt(x)
        lo = @round(T, inf(x)^y, inf(x)^y)
        hi = @round(T, sup(x)^y, sup(x)^y)
        return hull(lo, hi)
    end
end

function _pow(x::BareInterval{T}, y::Rational{S}) where {T<:NumTypes,S<:Integer}
    # assume `inf(x) ≥ 0` and `!isempty_interval(x)`
    if sup(x) == 0
        y > 0 && return x # zero(x)
        return emptyinterval(BareInterval{T})
    else
        isinteger(y) && return pown(x, S(y))
        y == (1//2) && return sqrt(x)
        return pown(rootn(x, y.den), y.num)
    end
end

"""
    pown(x, n)

Implement the `pown` function of the IEEE Standard 1788-2015 (Table 9.1).

# Examples

```jldoctest
julia> setdisplay(:full);

julia> pown(bareinterval(2, 3), 2)
BareInterval{Float64}(4.0, 9.0)

julia> pown(interval(-1, 1), 3)
Interval{Float64}(-1.0, 1.0, com)

julia> pown(interval(-1, 1), -3)
Interval{Float64}(-Inf, Inf, trv)
```
"""
function pown(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    isempty_interval(x) && return x
    n == 0 && return one(BareInterval{T})
    n == 1 && return x
    (n < 0) & isthinzero(x) && return emptyinterval(BareInterval{T})
    if isodd(n)
        isentire_interval(x) && return x
        if n > 0
            inf(x) == 0 && return @round(T, zero(T), sup(x)^n)
            sup(x) == 0 && return @round(T, inf(x)^n, zero(T))
            return @round(T, inf(x)^n, sup(x)^n)
        else
            if inf(x) ≥ 0
                inf(x) == 0 && return @round(T, sup(x)^n, typemax(T))
                return @round(T, sup(x)^n, inf(x)^n)
            elseif sup(x) ≤ 0
                sup(x) == 0 && return @round(T, typemin(T), inf(x)^n)
                return @round(T, sup(x)^n, inf(x)^n)
            else
                return entireinterval(BareInterval{T})
            end
        end
    else
        if n > 0
            if inf(x) ≥ 0
                return @round(T, inf(x)^n, sup(x)^n)
            elseif sup(x) ≤ 0
                return @round(T, sup(x)^n, inf(x)^n)
            else
                return @round(T, mig(x)^n, mag(x)^n)
            end
        else
            if inf(x) ≥ 0
                return @round(T, sup(x)^n, inf(x)^n)
            elseif sup(x) ≤ 0
                return @round(T, inf(x)^n, sup(x)^n)
            else
                return @round(T, mag(x)^n, mig(x)^n)
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
    n < 0 && return inv(rootn(x, -n))

    domain = _unsafe_bareinterval(T, ifelse(iseven(n), zero(T), typemin(T)), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x

    return @round(T, rootn(inf(x), n), rootn(sup(x), n))
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

Compute the hypotenuse; this relies on `^` internally.

Implement the `hypot` function of the IEEE Standard 1788-2015 (Table 10.5).
"""
Base.hypot(x::BareInterval, y::BareInterval) = sqrt(pown(x, 2) + pown(y, 2))

Base.hypot(x::Interval, y::Interval) = sqrt(pown(x, 2) + pown(y, 2))

"""
    fastpow(x, y)

A faster implementation of `pow(x, y)`, at the cost of maybe returning a
slightly larger interval.
"""
function fastpow(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(y) && return y
    isthininteger(y) && return fastpow(x, Integer(sup(y)))
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    if sup(x) == 0
        sup(y) > 0 && return x # zero(x)
        return emptyinterval(BareInterval{T})
    else
        return exp(y * log(x))
    end
end

function fastpow(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    n < 0 && return inv(fastpow(x, -n))
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    if sup(x) == 0
        n > 0 && return x # zero(x)
        return emptyinterval(BareInterval{T}) # n == 0
    else
        return _positive_power_by_squaring(x, n)
    end
end

fastpow(x::BareInterval, y::BareInterval) = fastpow(promote(x, y)...)
fastpow(x::BareInterval, y::Real) = fastpow(x, bareinterval(y))

function fastpow(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r = fastpow(bx, by)
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse((inf(bx) > 0) | ((inf(bx) == 0) & (inf(by) > 0)), d, trv))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

fastpow(x::Interval, y::Real) = fastpow(x, interval(y))

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

"""
    fastpown(x, n)

A faster implementation of `pown(x, y)`, at the cost of maybe returning a
slightly larger interval.
"""
function fastpown(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    isempty_interval(x) && return x
    n == 0 && return one(BareInterval{T})
    n == 1 && return x
    if n < 0
        isthinzero(x) && return emptyinterval(BareInterval{T})
        return inv(fastpown(x, -n))
    else
        range = _unsafe_bareinterval(T, ifelse(iseven(n), zero(T), typemin(T)), typemax(T))
        return intersect_interval(_positive_power_by_squaring(x, n), range)
    end
end

function fastpown(x::Interval, n::Integer)
    r = fastpown(bareinterval(x), n)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse((n < 0) & in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

#

for f ∈ (:cbrt, :exp, :exp2, :exp10, :expm1)
    @eval begin
        function Base.$f(x::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(x) && return x
            return @round(T, $f(inf(x)), $f(sup(x)))
        end

        function Base.$f(x::Interval)
            bx = bareinterval(x)
            r = $f(bx)
            d = min(decoration(r), decoration(x))
            return _unsafe_interval(r, d, isguaranteed(x))
        end
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
