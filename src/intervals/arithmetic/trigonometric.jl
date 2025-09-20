# This file contains the functions described as "Trigonometric functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# helper functions

_big_pi(::T) where {T<:AbstractFloat} =
    _unsafe_bareinterval(BigFloat, BigFloat(π, RoundDown; precision = 256), BigFloat(π, RoundUp; precision = 256))

_big_pi(x::BigFloat) =
    _unsafe_bareinterval(BigFloat, BigFloat(π, RoundDown; precision = precision(x)+32), BigFloat(π, RoundUp; precision = precision(x)+32))

function _quadrant(f, x::T) where {T<:AbstractFloat}
    PI = bareinterval(T, π)
    PI_LO, PI_HI = bounds(PI)
    x2 = 2x # should be exact for floats
    if abs(x) ≤ PI_LO # (-π, π)
        x2 ≤ -PI_HI && return 2       # (-π, -π/2)
        x2 < -PI_LO && return f(2, 3) # (-π, -π/2) or [-π/2, 0)
        x2 <  0     && return 3       # [-π/2, 0)
        x2 ≤  PI_LO && return 0       # [0, π/2)
        x2 <  PI_HI && return f(0, 1) # [0, π/2) or [π/2, π)
        return 1 # [π/2, π)
    else
        k = bareinterval(BigFloat, x2) / _big_pi(x)
        fk = floor(k)
        lfk, hfk = bounds(fk)
        return Int(mod(f(lfk, hfk), 4))
    end
end

function _quadrantpi(x::AbstractFloat) # used in `sinpi` and `cospi`
    r = rem(x, 2) # [-2, 2], should be exact for floats
    2r < -3 && return 0 # [-2π, -3π/2)
    r  < -1 && return 1 # [-3π/2, -π)
    2r < -1 && return 2 # [-π, -π/2)
    r  <  0 && return 3 # [-π/2, 0)
    2r <  1 && return 0 # [0, π/2)
    r  <  1 && return 1 # [π/2, π)
    2r <  3 && return 2 # [π, 3π/2)
    return 3 # [3π/2, 2π]
end

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

    PI_HI = sup(bareinterval(T, π))
    d = diam(x)
    d ≥ 2PI_HI && return _unsafe_bareinterval(T, -one(T), one(T))

    lo, hi = bounds(x)

    lo_quadrant = _quadrant(min, lo)
    hi_quadrant = _quadrant(max, hi)

    if lo_quadrant == hi_quadrant
        d ≥ PI_HI && return _unsafe_bareinterval(T, -one(T), one(T)) # diameter ≥ 2π
        (lo_quadrant == 1) | (lo_quadrant == 2) && return @round(T, sin(hi), sin(lo)) # decreasing
        return @round(T, sin(lo), sin(hi))

    elseif lo_quadrant == 3 && hi_quadrant == 0
        d ≥ PI_HI && return _unsafe_bareinterval(T, -one(T), one(T)) # diameter ≥ 3π/2
        return @round(T, sin(lo), sin(hi)) # increasing

    elseif lo_quadrant == 1 && hi_quadrant == 2
        d ≥ PI_HI && return _unsafe_bareinterval(T, -one(T), one(T)) # diameter ≥ 3π/2
        return @round(T, sin(hi), sin(lo)) # decreasing

    elseif (lo_quadrant == 0 || lo_quadrant == 3) && (hi_quadrant == 1 || hi_quadrant == 2)
        return @round(T, min(sin(lo), sin(hi)), one(T))

    elseif (lo_quadrant == 1 || lo_quadrant == 2) && (hi_quadrant == 3 || hi_quadrant == 0)
        return @round(T, -one(T), max(sin(lo), sin(hi)))

    else # (lo_quadrant == 0 && hi_quadrant == 3) || (lo_quadrant == 2 && hi_quadrant == 1)
        return _unsafe_bareinterval(T, -one(T), one(T))

    end
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

        d = diam(x)
        d ≥ 2 && return _unsafe_bareinterval(T, -one(T), one(T))

        lo, hi = bounds(x)

        lo_quadrant = _quadrantpi(lo)
        hi_quadrant = _quadrantpi(hi)

        if lo_quadrant == hi_quadrant
            d ≥ 1 && return _unsafe_bareinterval(T, -one(T), one(T))
            (lo_quadrant == 1) | (lo_quadrant == 2) && return @round(T, sinpi(hi), sinpi(lo)) # decreasing
            return @round(T, sinpi(lo), sinpi(hi))

        elseif lo_quadrant == 3 && hi_quadrant == 0
            return @round(T, sinpi(lo), sinpi(hi)) # increasing

        elseif lo_quadrant == 1 && hi_quadrant == 2
            return @round(T, sinpi(hi), sinpi(lo)) # decreasing

        elseif (lo_quadrant == 0 || lo_quadrant == 3) && (hi_quadrant == 1 || hi_quadrant == 2)
            return @round(T, min(sinpi(lo), sinpi(hi)), one(T))

        elseif (lo_quadrant == 1 || lo_quadrant == 2) && (hi_quadrant == 3 || hi_quadrant == 0)
            return @round(T, -one(T), max(sinpi(lo), sinpi(hi)))

        else # (lo_quadrant == 0 && hi_quadrant == 3) || (lo_quadrant == 2 && hi_quadrant == 1)
            return _unsafe_bareinterval(T, -one(T), one(T))

        end
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

    PI_HI = sup(bareinterval(T, π))
    d = diam(x)
    d ≥ 2PI_HI && return _unsafe_bareinterval(T, -one(T), one(T))

    lo, hi = bounds(x)

    lo_quadrant = _quadrant(min, lo)
    hi_quadrant = _quadrant(max, hi)

    if lo_quadrant == hi_quadrant
        d ≥ PI_HI && return _unsafe_bareinterval(T, -one(T), one(T)) # diameter ≥ 2π
        (lo_quadrant == 2) | (lo_quadrant == 3) && return @round(T, cos(lo), cos(hi)) # increasing
        return @round(T, cos(hi), cos(lo))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        d ≥ PI_HI && return _unsafe_bareinterval(T, -one(T), one(T)) # diameter ≥ 3π/2
        return @round(T, cos(lo), cos(hi))

    elseif lo_quadrant == 0 && hi_quadrant == 1
        d ≥ PI_HI && return _unsafe_bareinterval(T, -one(T), one(T)) # diameter ≥ 3π/2
        return @round(T, cos(hi), cos(lo))

    elseif (lo_quadrant == 2 || lo_quadrant == 3) && (hi_quadrant == 0 || hi_quadrant == 1)
        return @round(T, min(cos(lo), cos(hi)), one(T))

    elseif (lo_quadrant == 0 || lo_quadrant == 1) && (hi_quadrant == 2 || hi_quadrant == 3)
        return @round(T, -one(T), max(cos(lo), cos(hi)))

    else # (lo_quadrant == 3 && hi_quadrant == 2) || (lo_quadrant == 1 && hi_quadrant == 0)
        return _unsafe_bareinterval(T, -one(T), one(T))

    end
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

        d = diam(x)
        d ≥ 2 && return _unsafe_bareinterval(T, -one(T), one(T))

        lo, hi = bounds(x)

        isthin(x) & !isinteger(lo) & isinteger(2lo) && return zero(BareInterval{T}) # by-pass rounding to improve accuracy for 32 bit systems

        lo_quadrant = _quadrantpi(lo)
        hi_quadrant = _quadrantpi(hi)

        if lo_quadrant == hi_quadrant
            d ≥ 1 && return _unsafe_bareinterval(T, -one(T), one(T))
            (lo_quadrant == 2) | (lo_quadrant == 3) && return @round(T, cospi(lo), cospi(hi)) # increasing
            return @round(T, cospi(hi), cospi(lo))

        elseif lo_quadrant == 2 && hi_quadrant == 3
            return @round(T, cospi(lo), cospi(hi))

        elseif lo_quadrant == 0 && hi_quadrant == 1
            return @round(T, cospi(hi), cospi(lo))

        elseif (lo_quadrant == 2 || lo_quadrant == 3) && (hi_quadrant == 0 || hi_quadrant == 1)
            return @round(T, min(cospi(lo), cospi(hi)), one(T))

        elseif (lo_quadrant == 0 || lo_quadrant == 1) && (hi_quadrant == 2 || hi_quadrant == 3)
            return @round(T, -one(T), max(cospi(lo), cospi(hi)))

        else # (lo_quadrant == 3 && hi_quadrant == 2) || (lo_quadrant == 1 && hi_quadrant == 0)
            return _unsafe_bareinterval(T, -one(T), one(T))

        end
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

    diam(x) > sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant(min, lo)
    hi_quadrant = _quadrant(max, hi)
    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if (lo_quadrant_mod == 0 && hi_quadrant_mod == 1) || (lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant)
        return entireinterval(BareInterval{T}) # cross singularity

    else
        return @round(T, tan(lo), tan(hi))

    end
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

Implement the `cot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cot(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x

    diam(x) > sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    isthinzero(x) && return emptyinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant(min, lo)
    hi_quadrant = _quadrant(max, hi)

    if (lo_quadrant == 2 || lo_quadrant == 3) && hi == 0
        return @round(T, typemin(T), cot(lo)) # singularity from the left

    elseif (lo_quadrant == hi_quadrant) || (lo_quadrant == 0 && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant == 3)
        return @round(T, cot(hi), cot(lo))

    else
        return entireinterval(BareInterval{T}) # cross singularity

    end
end

Base.cot(x::BareInterval{<:Rational}) = cot(float(x))

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    sec(::BareInterval)
    sec(::Interval)

Implement the `sec` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sec(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x

    diam(x) > sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant(min, lo)
    hi_quadrant = _quadrant(max, hi)

    if lo_quadrant == hi_quadrant
        (lo_quadrant == 0) | (lo_quadrant == 1) && return @round(T, sec(lo), sec(hi)) # increasing
        return @round(T, sec(hi), sec(lo))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(T, min(sec(lo), sec(hi)), -one(T))

    elseif lo_quadrant == 3 && hi_quadrant == 0
        return @round(T, one(T), max(sec(lo), sec(hi)))

    else
        return entireinterval(BareInterval{T})

    end
end

Base.sec(x::BareInterval{<:Rational}) = sec(float(x))

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    csc(::BareInterval)
    csc(::Interval)

Implement the `csc` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.csc(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x

    diam(x) > sup(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    isthinzero(x) && return emptyinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant(min, lo)
    hi_quadrant = _quadrant(max, hi)

    if (lo_quadrant == 2 || lo_quadrant == 3) && hi == 0
        # singularity from the left
        lo_quadrant == 2 && return @round(T, typemin(T), -one(T))
        return @round(T, typemin(T), csc(lo))

    elseif lo_quadrant == hi_quadrant
        (lo_quadrant == 0) | (lo_quadrant == 3) && return @round(T, csc(hi), csc(lo)) # decreasing
        return @round(T, csc(lo), csc(hi))

    elseif lo_quadrant == 0 && hi_quadrant == 1
        return @round(T, one(T), max(csc(lo), csc(hi)))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(T, min(csc(lo), csc(hi)), -one(T))

    else
        return entireinterval(BareInterval{T})

    end
end

Base.csc(x::BareInterval{<:Rational}) = csc(float(x))

# automatically defined for `Interval` since it is a subtype of `Real`

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

Implement the `acot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acot(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    return @round(T, acot(sup(x)), acot(inf(x)))
end

Base.acot(x::BareInterval{<:Rational}) = acot(float(x))

# automatically defined for `Interval` since it is a subtype of `Real`

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
                          ifelse(sup(bx) < 0, ifelse(inf(by) < 0, def, d), d)),
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
