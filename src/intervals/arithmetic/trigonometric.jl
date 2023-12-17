# This file contains the functions described as "Trigonometric functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# helper functions

_quadrant_down(x::T) where {T<:Rational} = _quadrant(float(T)(x, RoundDown))
_quadrant_down(x::T) where {T<:AbstractFloat} = _quadrant(x)

_quadrant_up(x::T) where {T<:Rational} = _quadrant(float(T)(x, RoundUp))
_quadrant_up(x::T) where {T<:AbstractFloat} = _quadrant(x)

function _quadrant(x::T) where {T<:AbstractFloat}
    x_mod2pi = rem2pi(x, RoundNearest)
    -2x_mod2pi > π && return 2 # [-π, -π/2)
    x_mod2pi < 0 && return 3 # [-π/2, 0)
    2x_mod2pi < π && return 0 # [0, π/2)
    return 1 # [π/2, π]
end

function _quadrantpi(x::T) where {T<:NumTypes} # for `sinpi` and `cospi`
    x_mod2 = rem(x, 2)
    -2x_mod2 > 1 && return 2 # [-π, -π/2)
    x_mod2 < 0 && return 3 # [-π/2, 0)
    2x_mod2 < 1 && return 0 # [0, π/2)
    return 1 # [π/2, π]
end

# not in the IEEE Standard 1788-2015

Base.rad2deg(x::BareInterval{T}) where {T<:NumTypes} = (x / bareinterval(T, π)) * bareinterval(T, 180)
Base.rad2deg(x::Interval{T}) where {T<:NumTypes} = (x / interval(T, π)) * interval(T, 180)

Base.deg2rad(x::BareInterval{T}) where {T<:NumTypes} = (x * bareinterval(T, π)) / bareinterval(T, 180)
Base.deg2rad(x::Interval{T}) where {T<:NumTypes} = (x * interval(T, π)) / interval(T, 180)

Base.sincospi(x::BareInterval) = (sinpi(x), cospi(x))
Base.sincospi(x::Interval) = (sinpi(x), cospi(x))

#

"""
    sin(::BareInterval)
    sin(::Interval)

Implement the `sin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sin(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    d = diam(x)
    inf_two_pi = _mul_round(convert(T, 2), inf(bareinterval(T, π)), RoundDown)
    d ≥ inf_two_pi && return _unsafe_bareinterval(T, -one(T), one(T))

    lo, hi = bounds(x)

    lo_quadrant = _quadrant_down(lo)
    hi_quadrant = _quadrant_up(hi)

    if lo_quadrant == hi_quadrant
        d ≥ π && return _unsafe_bareinterval(T, -one(T), one(T))
        (lo_quadrant == 1) | (lo_quadrant == 2) && return @round(T, sin(hi), sin(lo)) # decreasing
        return @round(T, sin(lo), sin(hi))

    elseif lo_quadrant == 3 && hi_quadrant == 0
        return @round(T, sin(lo), sin(hi)) # increasing

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(T, sin(hi), sin(lo)) # decreasing

    elseif (lo_quadrant == 0 || lo_quadrant == 3) && (hi_quadrant == 1 || hi_quadrant == 2)
        return @round(T, min(sin(lo), sin(hi)), one(T))

    elseif (lo_quadrant == 1 || lo_quadrant == 2) && (hi_quadrant == 3 || hi_quadrant == 0)
        return @round(T, -one(T), max(sin(lo), sin(hi)))

    else # (lo_quadrant == 0 && hi_quadrant == 3) || (lo_quadrant == 2 && hi_quadrant == 1)
        return _unsafe_bareinterval(T, -one(T), one(T))

    end
end

function Base.sin(x::Interval)
    r = sin(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

# not in the IEEE Standard 1788-2015

function Base.sinpi(x::BareInterval{T}) where {T<:NumTypes}
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

function Base.sinpi(x::Interval)
    r = sinpi(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    cos(::BareInterval)
    cos(::Interval)

Implement the `cos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cos(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    d = diam(x)
    inf_two_pi = _mul_round(convert(T, 2), inf(bareinterval(T, π)), RoundDown)
    d ≥ inf_two_pi && return _unsafe_bareinterval(T, -one(T), one(T))

    lo, hi = bounds(x)

    lo_quadrant = _quadrant_down(lo)
    hi_quadrant = _quadrant_up(hi)

    if lo_quadrant == hi_quadrant
        d ≥ π && return _unsafe_bareinterval(T, -one(T), one(T))
        (lo_quadrant == 2) | (lo_quadrant == 3) && return @round(T, cos(lo), cos(hi)) # increasing
        return @round(T, cos(hi), cos(lo))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(T, cos(lo), cos(hi))

    elseif lo_quadrant == 0 && hi_quadrant == 1
        return @round(T, cos(hi), cos(lo))

    elseif (lo_quadrant == 2 || lo_quadrant == 3) && (hi_quadrant == 0 || hi_quadrant == 1)
        return @round(T, min(cos(lo), cos(hi)), one(T))

    elseif (lo_quadrant == 0 || lo_quadrant == 1) && (hi_quadrant == 2 || hi_quadrant == 3)
        return @round(T, -one(T), max(cos(lo), cos(hi)))

    else # (lo_quadrant == 3 && hi_quadrant == 2) || (lo_quadrant == 1 && hi_quadrant == 0)
        return _unsafe_bareinterval(T, -one(T), one(T))

    end
end

function Base.cos(x::Interval)
    r = cos(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

# not in the IEEE Standard 1788-2015

function Base.cospi(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    d = diam(x)
    d ≥ 2 && return _unsafe_bareinterval(T, -one(T), one(T))

    lo, hi = bounds(x)

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

function Base.cospi(x::Interval)
    r = cospi(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    tan(::BareInterval)
    tan(::Interval)

Implement the `tan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.tan(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    diam(x) > π && return entireinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant_down(lo)
    hi_quadrant = _quadrant_up(hi)
    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if (lo_quadrant_mod == 0 && hi_quadrant_mod == 1) || (lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant)
        return entireinterval(BareInterval{T}) # cross singularity

    else
        return @round(T, tan(lo), tan(hi))

    end
end

function Base.tan(x::Interval)
    r = tan(bareinterval(x))
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isbounded(r), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    cot(::BareInterval)
    cot(::Interval)

Implement the `cot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cot(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    diam(x) > π && return entireinterval(BareInterval{T})

    isthinzero(x) && return emptyinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant_down(lo)
    hi_quadrant = _quadrant_up(hi)

    if (lo_quadrant == 2 || lo_quadrant == 3) && hi == 0
        return @round(T, typemin(T), cot(lo)) # singularity from the left

    elseif (lo_quadrant == hi_quadrant) || (lo_quadrant == 0 && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant == 3)
        return @round(T, cot(hi), cot(lo))

    else
        return entireinterval(BareInterval{T}) # cross singularity

    end
end

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    sec(::BareInterval)
    sec(::Interval)

Implement the `sec` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sec(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    diam(x) > π && return entireinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant_down(lo)
    hi_quadrant = _quadrant_up(hi)

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

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    csc(::BareInterval)
    csc(::Interval)

Implement the `csc` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.csc(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x

    diam(x) > π && return entireinterval(BareInterval{T})

    isthinzero(x) && return emptyinterval(BareInterval{T})

    lo, hi = bounds(x)

    lo_quadrant = _quadrant_down(lo)
    hi_quadrant = _quadrant_up(hi)

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

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    asin(::BareInterval)
    asin(::Interval)

Implement the `asin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.asin(x::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return @round(T, asin(inf(x)), asin(sup(x)))
end

function Base.asin(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    bx = bareinterval(x)
    r = asin(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    acos(::BareInterval)
    acos(::Interval)

Implement the `acos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acos(x::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return @round(T, acos(sup(x)), acos(inf(x)))
end

function Base.acos(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    bx = bareinterval(x)
    r = acos(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    atan(::BareInterval)
    atan(::Interval)

Implement the `atan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atan(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    return @round(T, atan(inf(x)), atan(sup(x)))
end

function Base.atan(x::Interval)
    r = atan(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    acot(::BareInterval)
    acot(::Interval)

Implement the `acot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acot(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    return @round(T, acot(sup(x)), acot(inf(x)))
end

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    atan(::BareInterval, ::BareInterval)
    atan(::Interval, ::Interval)

Implement the `atan2` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atan(y::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
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
            ylo ≥ 0 && return _unsafe_bareinterval(T, _atan_round(ylo, xhi, RoundDown), sup(_half_range_atan(T)))
            yhi ≤ 0 && return _unsafe_bareinterval(T, inf(_half_range_atan(T)), _atan_round(yhi, xhi, RoundUp))
            return _half_range_atan(T)

        elseif iszero(xhi)
            isthinzero(y) && return bareinterval(T, π)
            ylo ≥ 0 && return _unsafe_bareinterval(T, inf(_half_pi(T)), _atan_round(ylo, xlo, RoundUp))
            yhi < 0 && return _unsafe_bareinterval(T, _atan_round(yhi, xlo, RoundDown), sup(-_half_pi(T)))
            return _range_atan(T)

        else
            ylo ≥ 0 && return @round(T, atan(ylo, xhi), atan(ylo, xlo))
            yhi < 0 && return @round(T, atan(yhi, xlo), atan(yhi, xhi))
            return _range_atan(T)

        end
    end
end

Base.atan(y::BareInterval, x::BareInterval) = atan(promote(y, x)...)

function Base.atan(y::Interval, x::Interval)
    by = bareinterval(y)
    bx = bareinterval(x)
    r = atan(by, bx)
    d = min(decoration(y), decoration(x), decoration(r))
    d = min(d,
            ifelse(in_interval(0, by),
                ifelse(in_interval(0, bx), trv,
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
