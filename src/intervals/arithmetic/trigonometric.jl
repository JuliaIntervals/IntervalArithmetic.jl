# This file contains the functions described as "Trigonometric functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# helper functions

function _big_pi(x::AbstractFloat)
    prec = max(exponent(x), 0) + precision(x) + 64
    return _unsafe_bareinterval(BigFloat, BigFloat(π, RoundDown; precision = prec), BigFloat(π, RoundUp; precision = prec))
end

function _halfpi_ratio(x::AbstractFloat)
    X = _fexact(ldexp, BigFloat(x; precision = precision(x)), 1)
    return _unsafe_bareinterval(BigFloat, X, X) / _big_pi(x)
end

function _quadrant(::typeof(floor), x::T) where {T<:Union{Float16,Float32,Float64}}
    H_LO, H_HI = bounds(_half_pi(T))
    -2H_LO ≤ x ≤ 2H_LO || return floor(BigInt, inf(_halfpi_ratio(x)))
    x ≥ 0 && return ifelse(x ≥ H_HI, 1, 0)
    return ifelse(x < -H_LO, -2, -1)
end

_quadrant(::typeof(floor), x::AbstractFloat) = iszero(x) ? 0 : floor(BigInt, inf(_halfpi_ratio(x)))

function _quadrant(::typeof(ceil), x::T) where {T<:Union{Float16,Float32,Float64}}
    H_LO, H_HI = bounds(_half_pi(T))
    -2H_LO ≤ x ≤ 2H_LO || return ceil(BigInt, sup(_halfpi_ratio(x))) - 1
    x > 0 && return ifelse(x > H_LO, 1, 0)
    iszero(x) && return -1
    return ifelse(x ≤ -H_HI, -2, -1)
end

_quadrant(::typeof(ceil), x::AbstractFloat) = iszero(x) ? -1 : ceil(BigInt, sup(_halfpi_ratio(x))) - 1

_quadrantpi(::typeof(floor), x::T) where {T<:Union{Float16,Float32,Float64}} =
    abs(x) ≤ maxintfloat(T) ? floor(Int64, 2x) : floor(BigInt, _fexact(ldexp, BigFloat(x; precision = precision(x)), 1))
_quadrantpi(::typeof(floor), x::AbstractFloat) = floor(BigInt, _fexact(ldexp, BigFloat(x; precision = precision(x)), 1))

_quadrantpi(::typeof(ceil), x::T) where {T<:Union{Float16,Float32,Float64}} =
    abs(x) ≤ maxintfloat(T) ? ceil(Int64, 2x) - 1 : ceil(BigInt, _fexact(ldexp, BigFloat(x; precision = precision(x)), 1)) - 1
_quadrantpi(::typeof(ceil), x::AbstractFloat) = ceil(BigInt, _fexact(ldexp, BigFloat(x; precision = precision(x)), 1)) - 1

# quadrant of lo, and number (at most 4) of multiples of π/2 (or 1/2) strictly inside (lo, hi)
function _quadrants(quadrant, lo, hi)
    q = quadrant(floor, lo)
    return Int(mod(q, 4)), Int(min(quadrant(ceil, hi) - q, 4))
end

_crosses(q, n, t) = n > mod(t - q - 1, 4)

# not in the IEEE Standard 1788-2015

Base.rad2deg(x::BareInterval{T}) where {T<:NumTypes} = (x * bareinterval(T, 180)) / bareinterval(T, π)
Base.rad2deg(x::Interval{T}) where {T<:NumTypes} = (x * interval(T, 180)) / interval(T, π)

Base.deg2rad(x::BareInterval{T}) where {T<:NumTypes} = (x / bareinterval(T, 180)) * bareinterval(T, π)
Base.deg2rad(x::Interval{T}) where {T<:NumTypes} = (x / interval(T, 180)) * interval(T, π)

Base.sincospi(x::BareInterval) = (sinpi(x), cospi(x))
Base.sincospi(x::Interval) = (sinpi(x), cospi(x))

Base.sind(x::BareInterval{T}) where {T<:NumTypes} = sinpi(x / bareinterval(T, 180))
Base.sind(x::Interval{T}) where {T<:NumTypes} = sinpi(x / interval(T, 180))

Base.cosd(x::BareInterval{T}) where {T<:NumTypes} = cospi(x / bareinterval(T, 180))
Base.cosd(x::Interval{T}) where {T<:NumTypes} = cospi(x / interval(T, 180))

#

"""
    sin(::BareInterval)
    sin(::Interval)

Implement the `sin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sin(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    isthin(x) && return @round(T, sin(lo), sin(lo))
    diam(x) ≥ 2sup(bareinterval(T, π)) && return _unsafe_bareinterval(T, -one(T), one(T))
    q, n = _quadrants(_quadrant, lo, hi)
    hasmax, hasmin = _crosses(q, n, 1), _crosses(q, n, 3)
    hasmax & hasmin && return _unsafe_bareinterval(T, -one(T), one(T))
    hasmax && return @round(T, min(sin(lo), sin(hi)), one(T))
    hasmin && return @round(T, -one(T), max(sin(lo), sin(hi)))
    (q == 0) | (q == 3) && return @round(T, sin(lo), sin(hi))
    return @round(T, sin(hi), sin(lo))
end

Base.sin(x::BareInterval{<:Rational}) = sin(float(x))

function Base.sin(x::Interval)
    @inline r = sin(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.sin(x::Complex{Interval{T}}) where {T<:NumTypes} = complex(sin(real(x)) * cosh(imag(x)), cos(real(x)) * sinh(imag(x)))

# not in the IEEE Standard 1788-2015

if Int == Int32 && VERSION < v"1.10"
    Base.sinpi(x::BareInterval{T}) where {T<:AbstractFloat} = sin(x * bareinterval(T, π))
else
    function Base.sinpi(x::BareInterval{T}) where {T<:AbstractFloat}
        isempty_interval(x) && return x
        lo, hi = bounds(x)
        isthin(x) && return @round(T, sinpi(lo), sinpi(lo))
        diam(x) ≥ 2 && return _unsafe_bareinterval(T, -one(T), one(T))
        q, n = _quadrants(_quadrantpi, lo, hi)
        hasmax, hasmin = _crosses(q, n, 1), _crosses(q, n, 3)
        hasmax & hasmin && return _unsafe_bareinterval(T, -one(T), one(T))
        hasmax && return @round(T, min(sinpi(lo), sinpi(hi)), one(T))
        hasmin && return @round(T, -one(T), max(sinpi(lo), sinpi(hi)))
        (q == 0) | (q == 3) && return @round(T, sinpi(lo), sinpi(hi))
        return @round(T, sinpi(hi), sinpi(lo))
    end
end

Base.sinpi(x::BareInterval{<:Rational}) = sinpi(float(x))

function Base.sinpi(x::Interval)
    r = sinpi(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.sinpi(x::Complex{Interval{T}}) where {T<:NumTypes} =
    complex(sinpi(real(x)) * cosh(imag(x) * interval(T, π)), cospi(real(x)) * sinh(imag(x) * interval(T, π)))

"""
    cos(::BareInterval)
    cos(::Interval)

Implement the `cos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cos(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    isthin(x) && return @round(T, cos(lo), cos(lo))
    diam(x) ≥ 2sup(bareinterval(T, π)) && return _unsafe_bareinterval(T, -one(T), one(T))
    q, n = _quadrants(_quadrant, lo, hi)
    hasmax, hasmin = _crosses(q, n, 0), _crosses(q, n, 2)
    hasmax & hasmin && return _unsafe_bareinterval(T, -one(T), one(T))
    hasmax && return @round(T, min(cos(lo), cos(hi)), one(T))
    hasmin && return @round(T, -one(T), max(cos(lo), cos(hi)))
    (q == 2) | (q == 3) && return @round(T, cos(lo), cos(hi))
    return @round(T, cos(hi), cos(lo))
end

Base.cos(x::BareInterval{<:Rational}) = cos(float(x))

function Base.cos(x::Interval)
    @inline r = cos(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.cos(x::Complex{Interval{T}}) where {T<:NumTypes} = complex(cos(real(x)) * cosh(imag(x)), -sin(real(x)) * sinh(imag(x)))

# not in the IEEE Standard 1788-2015

if Int == Int32 && VERSION < v"1.10"
    Base.cospi(x::BareInterval{T}) where {T<:AbstractFloat} = cos(x * bareinterval(T, π))
else
    function Base.cospi(x::BareInterval{T}) where {T<:AbstractFloat}
        isempty_interval(x) && return x
        lo, hi = bounds(x)
        isthin(x) & !isinteger(lo) & isinteger(_fexact(ldexp, lo, 1)) && return zero(BareInterval{T}) # by-pass rounding to improve accuracy for 32 bit systems
        isthin(x) && return @round(T, cospi(lo), cospi(lo))
        diam(x) ≥ 2 && return _unsafe_bareinterval(T, -one(T), one(T))
        q, n = _quadrants(_quadrantpi, lo, hi)
        hasmax, hasmin = _crosses(q, n, 0), _crosses(q, n, 2)
        hasmax & hasmin && return _unsafe_bareinterval(T, -one(T), one(T))
        hasmax && return @round(T, min(cospi(lo), cospi(hi)), one(T))
        hasmin && return @round(T, -one(T), max(cospi(lo), cospi(hi)))
        (q == 2) | (q == 3) && return @round(T, cospi(lo), cospi(hi))
        return @round(T, cospi(hi), cospi(lo))
    end
end

Base.cospi(x::BareInterval{<:Rational}) = cospi(float(x))

function Base.cospi(x::Interval)
    r = cospi(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.cospi(x::Complex{Interval{T}}) where {T<:NumTypes} =
    complex(cospi(real(x)) * cosh(imag(x) * interval(T, π)), -sinpi(real(x)) * sinh(imag(x) * interval(T, π)))

"""
    tan(::BareInterval)
    tan(::Interval)

Implement the `tan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.tan(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    isthin(x) && return @round(T, tan(lo), tan(lo))
    diam(x) ≥ sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})
    q, n = _quadrants(_quadrant, lo, hi)
    _crosses(q, n, 1) | _crosses(q, n, 3) && return entireinterval(BareInterval{T})
    return @round(T, tan(lo), tan(hi))
end

Base.tan(x::BareInterval{<:Rational}) = tan(float(x))

function Base.tan(x::Interval)
    @inline r = tan(bareinterval(x))
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isbounded(r), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.tan(x::Complex{<:Interval}) = sin(x) / cos(x)

"""
    cot(::BareInterval)
    cot(::Interval)

This function is not part of the IEEE Standard 1788-2015.
"""
function Base.cot(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    isthinzero(x) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(x)
    isthin(x) && return @round(T, cot(lo), cot(lo))
    diam(x) ≥ sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})
    q, n = _quadrants(_quadrant, lo, hi)
    _crosses(q, n, 0) | _crosses(q, n, 2) && return entireinterval(BareInterval{T})
    lo, hi = ifelse(iszero(lo), zero(T), lo), ifelse(iszero(hi), -zero(T), hi)
    return @round(T, cot(hi), cot(lo))
end

Base.cot(x::BareInterval{<:Rational}) = cot(float(x))

function Base.cot(x::Interval)
    @inline r = cot(bareinterval(x))
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isbounded(r), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    sec(::BareInterval)
    sec(::Interval)

This function is not part of the IEEE Standard 1788-2015.
"""
function Base.sec(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    isthin(x) && return @round(T, sec(lo), sec(lo))
    diam(x) ≥ sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})
    q, n = _quadrants(_quadrant, lo, hi)
    _crosses(q, n, 1) | _crosses(q, n, 3) && return entireinterval(BareInterval{T})
    _crosses(q, n, 0) && return @round(T, one(T), max(sec(lo), sec(hi)))
    _crosses(q, n, 2) && return @round(T, min(sec(lo), sec(hi)), -one(T))
    (q == 0) | (q == 1) && return @round(T, sec(lo), sec(hi))
    return @round(T, sec(hi), sec(lo))
end

Base.sec(x::BareInterval{<:Rational}) = sec(float(x))

function Base.sec(x::Interval)
    @inline r = sec(bareinterval(x))
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isbounded(r), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    csc(::BareInterval)
    csc(::Interval)

This function is not part of the IEEE Standard 1788-2015.
"""
function Base.csc(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    isthinzero(x) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(x)
    isthin(x) && return @round(T, csc(lo), csc(lo))
    diam(x) ≥ sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})
    q, n = _quadrants(_quadrant, lo, hi)
    _crosses(q, n, 0) | _crosses(q, n, 2) && return entireinterval(BareInterval{T})
    lo, hi = ifelse(iszero(lo), zero(T), lo), ifelse(iszero(hi), -zero(T), hi)
    _crosses(q, n, 1) && return @round(T, one(T), max(csc(lo), csc(hi)))
    _crosses(q, n, 3) && return @round(T, min(csc(lo), csc(hi)), -one(T))
    (q == 0) | (q == 3) && return @round(T, csc(hi), csc(lo))
    return @round(T, csc(lo), csc(hi))
end

Base.csc(x::BareInterval{<:Rational}) = csc(float(x))

function Base.csc(x::Interval)
    @inline r = csc(bareinterval(x))
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isbounded(r), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    asin(::BareInterval)
    asin(::Interval)

Implement the `asin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.asin(x::BareInterval{T}) where {T<:AbstractFloat}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return @round(T, asin(inf(x)), asin(sup(x)))
end

Base.asin(x::BareInterval{<:Rational}) = asin(float(x))

function Base.asin(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    bx = bareinterval(x)
    r = asin(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.asin(x::Complex{Interval{T}}) where {T<:NumTypes} =
    -interval(T, im)*log(interval(T, im)*x + sqrt(interval(T, 1) - x^2))

"""
    acos(::BareInterval)
    acos(::Interval)

Implement the `acos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acos(x::BareInterval{T}) where {T<:AbstractFloat}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return @round(T, acos(sup(x)), acos(inf(x)))
end

Base.acos(x::BareInterval{<:Rational}) = acos(float(x))

function Base.acos(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    bx = bareinterval(x)
    r = acos(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.acos(x::Complex{Interval{T}}) where {T<:NumTypes} =
    -interval(T, im)*log(x + interval(T, im)*sqrt(interval(T, 1) - x^2))

"""
    atan(::BareInterval)
    atan(::Interval)

Implement the `atan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atan(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    return @round(T, atan(inf(x)), atan(sup(x)))
end

Base.atan(x::BareInterval{<:Rational}) = atan(float(x))

function Base.atan(x::Interval)
    r = atan(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.atan(x::Complex{Interval{T}}) where {T<:NumTypes} =
    -interval(T, im)/interval(T, 2)*log((interval(T, im) - x)/(interval(T, im) + x))

"""
    acot(::BareInterval)
    acot(::Interval)

This function is not part of the IEEE Standard 1788-2015. It uses the convention
`acot(0) = π/2` and the jump at 0 is decorated like the branch cut of the
two-argument `atan` described as `atan2` in the IEEE Standard 1788-2015
(Table 9.1).
"""
function Base.acot(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    if lo < 0 && hi ≥ 0
        HALF_PI_HI = sup(_half_pi(T))
        return _unsafe_bareinterval(T, -HALF_PI_HI, HALF_PI_HI)
    elseif lo == 0
        hi == 0 && return _half_pi(T)
        return @round(T, acot(hi), +sup(_half_pi(T)))
    else
        return @round(T, acot(hi), acot(lo))
    end
end

Base.acot(x::BareInterval{<:Rational}) = acot(float(x))

function Base.acot(x::Interval)
    bx = bareinterval(x)
    r = acot(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(in_interval(0, bx), ifelse(inf(bx) < 0, def, dac), d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    atan(::BareInterval, ::BareInterval)
    atan(::Interval, ::Interval)

Implement the `atan2` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atan(y::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(y) && return y
    isempty_interval(x) && return x

    ylo, yhi = bounds(y)
    xlo, xhi = bounds(x)

    if isthinzero(x)
        isthinzero(y) && return emptyinterval(BareInterval{T})
        ylo ≥ 0 && return _half_pi(T)
        yhi ≤ 0 && return -_half_pi(T)
        return _half_range_atan(T)

    elseif xlo > 0
        isthinzero(y) && return y
        ylo ≥ 0 && return @round(T, atan(ylo, xhi), atan(yhi, xlo)) # refinement lo bound
        yhi ≤ 0 && return @round(T, atan(ylo, xlo), atan(yhi, xhi))
        return @round(T, atan(ylo, xlo), atan(yhi, xlo))

    elseif xhi < 0
        isthinzero(y) && return bareinterval(T, π)
        ylo ≥ 0 && return @round(T, atan(yhi, xhi), atan(ylo, xlo))
        yhi < 0 && return @round(T, atan(yhi, xlo), atan(ylo, xhi))
        return _range_atan(T)

    else
        if iszero(xlo)
            isthinzero(y) && return y
            ylo ≥ 0 && return _unsafe_bareinterval(T, _fround(atan, ylo, xhi, RoundDown), sup(_half_range_atan(T)))
            yhi ≤ 0 && return _unsafe_bareinterval(T, inf(_half_range_atan(T)), _fround(atan, yhi, xhi, RoundUp))
            return _half_range_atan(T)

        elseif iszero(xhi)
            isthinzero(y) && return bareinterval(T, π)
            ylo ≥ 0 && return _unsafe_bareinterval(T, inf(_half_pi(T)), _fround(atan, ylo, xlo, RoundUp))
            yhi < 0 && return _unsafe_bareinterval(T, _fround(atan, yhi, xlo, RoundDown), sup(-_half_pi(T)))
            return _range_atan(T)

        else
            ylo ≥ 0 && return @round(T, atan(ylo, xhi), atan(ylo, xlo))
            yhi < 0 && return @round(T, atan(yhi, xlo), atan(yhi, xhi))
            return _range_atan(T)

        end
    end
end

Base.atan(y::BareInterval{T}, x::BareInterval{T}) where {T<:Rational} = atan(float(y), float(x))

Base.atan(y::BareInterval, x::BareInterval) = atan(promote(y, x)...)

function Base.atan(y::Interval, x::Interval)
    by = bareinterval(y)
    bx = bareinterval(x)
    r = atan(by, bx)
    d = min(decoration(y), decoration(x), decoration(r))
    d = min(d,
            ifelse(in_interval(0, by),
                   ifelse(in_interval(0, bx),
                          trv,
                          ifelse(sup(bx) < 0, ifelse(inf(by) < 0, def, dac), d)),
                   d))
    t = isguaranteed(y) & isguaranteed(x)
    return _unsafe_interval(r, d, t)
end

# helper functions

_unsafe_scale(x::BareInterval{T}, α::T) where {T<:NumTypes} = @round(T, inf(x) * α, sup(x) * α) # assume `α` is postive

_half_pi(::Type{T}) where {T<:NumTypes} = _unsafe_scale(bareinterval(T, π), convert(T, 0.5))

function _range_atan(::Type{T}) where {T<:NumTypes}
    x = sup(bareinterval(T, π))
    return _unsafe_bareinterval(T, -x, x)
end

_half_range_atan(::Type{T}) where {T<:NumTypes} = _unsafe_scale(_range_atan(T), convert(T, 0.5))
