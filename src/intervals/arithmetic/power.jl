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
    unless `isthininteger(y)` is true in which case it is semantically
    equivalent to `fastpown(x, sup(y))`.
- `:slow`: `x ^ y` is semantically equivalent to `pow(x, y)`, unless
    `isthininteger(y)` is true in which case it is semantically equivalent to
    `pown(x, sup(y))`.
"""
struct PowerMode{T} end

#

"""
    ^(x::BareInterval, y::BareInterval)
    ^(x::Interval, y::Interval)

Compute the power of `x` by `y`. Unless `y` is an integer, the positive real
part of `x^y` is returned. This function is not in the IEEE Standard 1788-2015.
Its behaviour depends on the current [`PowerMode`](@ref).

See also: [`pow`](@ref), [`pown`](@ref), [`fastpow`](@ref) and
[`fastpown`](@ref).

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> bareinterval(2, 3) ^ bareinterval(2)
BareInterval{Float64}(4.0, 9.0)

julia> interval(-1, 1) ^ interval(3)
Interval{Float64}(-1.0, 1.0, com, true)

julia> interval(-1, 1) ^ interval(-3)
Interval{Float64}(-Inf, Inf, trv, true)
```
"""
function Base.:^(x::BareInterval, y::BareInterval)
    isthininteger(y) || return _select_pow(x, y)
    return _select_pown(x, Integer(sup(y)))
end

function Base.:^(x::Interval, y::Interval)
    isthininteger(y) || return _select_pow(x, y)
    r = _select_pown(x, Integer(sup(y)))
    d = min(decoration(r), decoration(y))
    t = isguaranteed(r) & isguaranteed(y)
    return _unsafe_interval(bareinterval(r), d, t)
end

Base.:^(x::Interval, n::Integer) = ^(x, n//one(n))
Base.:^(x::Interval, y::Rational) = ^(x, convert(Interval{typeof(y)}, y))

function Base.:^(x::Complex{<:Interval}, y::Complex{<:Interval})
    if isthinzero(imag(x)) && isthininteger(y)
        r = real(x) ^ real(y)
        d = min(decoration(x), decoration(y), decoration(r))
        t = isguaranteed(x) & isguaranteed(y)
        return complex(_unsafe_interval(bareinterval(real(r)), d, t), _unsafe_interval(bareinterval(imag(r)), d, t))
    else
        isthininteger(y) && return exp(y * _log_no_branch_cut(x))
        return exp(y * log(x))
    end
end

function _log_no_branch_cut(z::Complex{<:Interval})
    x, y = reim(z)
    by = bareinterval(y)
    bx = bareinterval(x)
    r = atan(by, bx)
    d = min(decoration(y), decoration(x), decoration(r))
    d = min(d,
            ifelse(in_interval(0, by),
                   ifelse(in_interval(0, bx), trv, d),
                   d))
    t = isguaranteed(y) & isguaranteed(x)
    angle = _unsafe_interval(r, d, t)
    return complex(log(abs(z)), angle)
end

# needed to avoid method errors
Base.:^(x::Complex{<:Interval}, y::Interval) = ^(promote(x, y)...)
Base.:^(x::Interval, y::Complex{<:Interval}) = ^(promote(x, y)...)

# overwrite behaviour for small integer powers from https://github.com/JuliaLang/julia/pull/24240
Base.literal_pow(::typeof(^), x::Interval, ::Val{n}) where {n} = _select_pown(x, n)
Base.literal_pow(::typeof(^), x::Complex{<:Interval}, ::Val{n}) where {n} = ^(x, interval(n))

# helper functions for power

_select_pow(x, y) = _select_pow(default_power(), x, y)
_select_pown(x, y) = _select_pown(default_power(), x, y)

_select_pow(::PowerMode{:fast}, x, y) = fastpow(x, y)
_select_pown(::PowerMode{:fast}, x, y) = fastpown(x, y)
_select_pow(::PowerMode{:slow}, x, y) = pow(x, y)
_select_pown(::PowerMode{:slow}, x, y) = pown(x, y)

"""
    pow(x, y)

Compute the power of the positive real part of `x` by `y`. In particular, even
if `y` is a thin integer, this is not equivalent to `pown(x, sup(y))`.

Implement the `pow` function of the IEEE Standard 1788-2015 (Table 9.1).

See also: [`fastpow`](@ref), [`pown`](@ref) and [`fastpown`](@ref).

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> pow(bareinterval(2, 3), bareinterval(2))
BareInterval{Float64}(4.0, 9.0)

julia> pow(interval(-1, 1), interval(3))
Interval{Float64}(0.0, 1.0, trv, true)

julia> pow(interval(-1, 1), interval(-3))
Interval{Float64}(1.0, Inf, trv, true)
```
"""
pow(x, y)
for U ∈ (:AbstractFloat, :Rational) # needed to resolve ambiguity
    @eval function pow(x::BareInterval{T}, y::BareInterval{T}) where {T<:$U}
        isempty_interval(y) && return y
        domain = _unsafe_bareinterval(T, zero(T), typemax(T))
        x = intersect_interval(x, domain)
        isempty_interval(x) && return x
        isthin(y) && return _thin_pow(x, sup(y))
        return hull(_thin_pow(x, inf(y)), _thin_pow(x, sup(y)))
    end
end
pow(x::BareInterval, y::BareInterval) = pow(promote(x, y)...)
# specialize on rational to improve exactness
function pow(x::BareInterval{T}, y::BareInterval{S}) where {T<:NumTypes,S<:Rational}
    R = promote_numtype(T, S)
    isempty_interval(y) && return emptyinterval(BareInterval{R})
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return emptyinterval(BareInterval{R})
    isthin(y) && return BareInterval{R}(_thin_pow(x, sup(y)))
    return BareInterval{R}(hull(_thin_pow(x, inf(y)), _thin_pow(x, sup(y))))
end

pow(x::BareInterval, y::Real) = pow(x, bareinterval(y))
pow(x::BareInterval, n::Integer) = pow(x, n//one(n))

function pow(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r = pow(bx, by)
    d = min(decoration(x), decoration(y), decoration(r))
    d = min(d, ifelse((inf(bx) > 0) | ((inf(bx) == 0) & (inf(by) > 0)), d, trv))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

pow(x::Interval, y::Real) = pow(x, interval(y))
pow(x::Interval, n::Integer) = pow(x, n//one(n))

# helper function for `pow`

for U ∈ (:AbstractFloat, :Rational) # needed to resolve ambiguity
    @eval function _thin_pow(x::BareInterval{T}, y::T) where {T<:$U}
        # assume `inf(x) ≥ 0` and `!isempty_interval(x)`
        if sup(x) == 0 # isthinzero(x)
            y > 0 && return x
            return emptyinterval(BareInterval{T})
        else
            isinteger(y) && return pown(x, Integer(y))
            y == 0.5 && return sqrt(x)
            lo = @round(T, inf(x)^y, inf(x)^y)
            hi = @round(T, sup(x)^y, sup(x)^y)
            return hull(lo, hi)
        end
    end

    @eval function _thin_pow(x::BareInterval{T}, y::Rational{S}) where {T<:$U,S<:Integer}
        # assume `inf(x) ≥ 0` and `!isempty_interval(x)`
        if sup(x) == 0 # isthinzero(x)
            y > 0 && return x
            return emptyinterval(BareInterval{T})
        else
            isinteger(y) && return pown(x, S(y))
            return pown(rootn(x, denominator(y)), numerator(y))
        end
    end
end

"""
    pown(x, n)

Implement the `pown` function of the IEEE Standard 1788-2015 (Table 9.1).

See also: [`fastpown`](@ref), [`pow`](@ref) and [`fastpow`](@ref).

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> pown(bareinterval(2, 3), 2)
BareInterval{Float64}(4.0, 9.0)

julia> pown(interval(-1, 1), 3)
Interval{Float64}(-1.0, 1.0, com, true)

julia> pown(interval(-1, 1), -3)
Interval{Float64}(-Inf, Inf, trv, true)
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
function rootn(x::BareInterval{T}, n::Integer) where {T<:AbstractFloat}
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

rootn(x::BareInterval{<:Rational}) = rootn(float(x))

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

Compute the hypotenuse.

Implement the `hypot` function of the IEEE Standard 1788-2015 (Table 10.5).
"""
Base.hypot(x::BareInterval, y::BareInterval) = sqrt(_select_pown(x, 2) + _select_pown(y, 2))

Base.hypot(x::Interval, y::Interval) = sqrt(_select_pown(x, 2) + _select_pown(y, 2))

"""
    fastpow(x, y)

A faster implementation of `pow(x, y)`, at the cost of maybe returning a larger
interval.

See also: [`pow`](@ref), [`pown`](@ref) and [`fastpown`](@ref).
"""
function fastpow(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(y) && return y
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    if sup(x) == 0 # isthinzero(x)
        sup(y) > 0 && return x
        return emptyinterval(BareInterval{T})
    elseif isthininteger(y)
        n = Integer(sup(y))
        n < 0 && return inv(_positive_power_by_squaring(x, -n))
        return _positive_power_by_squaring(x, n)
    else
        return exp(y * log(x))
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

"""
    fastpown(x, n)

A faster implementation of `pown(x, n)`, at the cost of maybe returning a larger
interval.

See also: [`pown`](@ref), [`pow`](@ref) and [`fastpow`](@ref).
"""
function fastpown(x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    isempty_interval(x) && return x
    n < 0 && return inv(fastpown(x, -n))
    range = _unsafe_bareinterval(T, ifelse(iseven(n), zero(T), typemin(T)), typemax(T))
    return intersect_interval(_positive_power_by_squaring(x, n), range)
end

function fastpown(x::Interval, n::Integer)
    r = fastpown(bareinterval(x), n)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse((n < 0) & in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

# helper function for `fastpow` and `fastpown`

# code inspired by `power_by_squaring(::Any, ::Integer)` in base/intfuncs.jl
Base.@assume_effects :terminates_locally function _positive_power_by_squaring(x, n)
    n == 0 && return one(x)
    n == 1 && return x
    n == 2 && return x*x
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

for f ∈ (:cbrt, :exp, :exp2, :exp10, :expm1)
    @eval begin
        function Base.$f(x::BareInterval{T}) where {T<:AbstractFloat}
            isempty_interval(x) && return x
            return @round(T, $f(inf(x)), $f(sup(x)))
        end

        Base.$f(x::BareInterval{<:Rational}) = $f(float(x))

        function Base.$f(x::Interval)
            r = $f(bareinterval(x))
            d = min(decoration(x), decoration(r))
            return _unsafe_interval(r, d, isguaranteed(x))
        end
    end
end

Base.exp(x::Complex{<:Interval}) = exp(real(x)) * cis(imag(x))

Base.exp2(x::Complex{<:Interval}) = exp2(real(x)) * cis(imag(x) * log(interval(numtype(x), 2)))

Base.exp10(x::Complex{<:Interval}) = exp10(real(x)) * cis(imag(x) * log(interval(numtype(x), 10)))

Base.expm1(x::Complex{<:Interval}) = exp(x) - interval(numtype(x), 1)

#

for f ∈ (:log, :log2, :log10)
    @eval begin
        function Base.$f(x::BareInterval{T}) where {T<:AbstractFloat}
            domain = _unsafe_bareinterval(T, zero(T), typemax(T))
            x = intersect_interval(x, domain)
            isempty_interval(x) | (sup(x) == 0) && return emptyinterval(BareInterval{T})
            return @round(T, $f(inf(x)), $f(sup(x)))
        end

        Base.$f(x::BareInterval{<:Rational}) = $f(float(x))

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

Base.log(x::Complex{<:Interval}) = complex(log(abs(x)), angle(x))

Base.log2(x::Complex{<:Interval}) = complex(log2(abs(x)), angle(x)/log(interval(numtype(x), 2)))

Base.log10(x::Complex{<:Interval}) = complex(log10(abs(x)), angle(x)/log(interval(numtype(x), 10)))

function Base.log1p(x::BareInterval{T}) where {T<:AbstractFloat}
    domain = _unsafe_bareinterval(T, -one(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) | (sup(x) == -1) && return emptyinterval(BareInterval{T})
    return @round(T, log1p(inf(x)), log1p(sup(x)))
end

Base.log1p(x::BareInterval{<:Rational}) = log1p(float(x))

function Base.log1p(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), typemax(T))
    bx = bareinterval(x)
    r = log1p(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isinterior(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.log1p(x::Complex{<:Interval}) = log(interval(numtype(x), 1) + x)
