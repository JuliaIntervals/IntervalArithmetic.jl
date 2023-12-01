# This file contains the functions described as "Trigonometric functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# not in the IEEE Standard 1788-2015

Base.rad2deg(a::BareInterval{T}) where {T<:NumTypes} = (a / bareinterval(T, π)) * bareinterval(T, 180)
Base.rad2deg(a::Interval{T}) where {T<:NumTypes} = (a / interval(T, π)) * interval(T, 180)

Base.deg2rad(a::BareInterval{T}) where {T<:NumTypes} = (a * bareinterval(T, π)) / bareinterval(T, 180)
Base.deg2rad(a::Interval{T}) where {T<:NumTypes} = (a * interval(T, π)) / interval(T, 180)

Base.sincospi(a::BareInterval) = (sinpi(a), cospi(a))
Base.sincospi(a::Interval) = (sinpi(a), cospi(a))

#

_unsafe_scale(a::BareInterval{T}, α::T) where {T<:NumTypes} = @round(T, inf(a) * α, sup(a) * α) # assumes `α` is postive

_half_pi(::Type{T}) where {T<:NumTypes} = _unsafe_scale(bareinterval(T, π), convert(T, 0.5))
_two_pi(::Type{T}) where {T<:NumTypes} = _unsafe_scale(bareinterval(T, π), convert(T, 2))

function _range_atan(::Type{T}) where {T<:NumTypes}
    temp = sup(bareinterval(T, π))
    return _unsafe_bareinterval(T, -temp, temp)
end

_half_range_atan(::Type{T}) where {T<:NumTypes} = _unsafe_scale(_range_atan(T), convert(T, 0.5))

"""
    _find_quadrants(x)

Finds the quadrant(s) corresponding to a given floating-point
number. The quadrants are labelled as 0 for x ∈ [0, π/2], etc.
A tuple of two quadrants is returned.
The minimum or maximum must then be chosen appropriately.

This is a rather indirect way to determine if π/2 and 3π/2 are contained
in the interval; cf. the formula for sine of an interval in
Tucker, *Validated Numerics*.
"""
function _find_quadrants(::Type{T}, x) where {T<:NumTypes}
    temp = _unsafe_bareinterval(T, x, x) / _half_pi(T)
    return floor(inf(temp)), floor(sup(temp))
end

# Quadrant function for Float64 specialized methods
function _quadrant(x::Float64)
    x_mod2pi = rem2pi(x, RoundNearest)  # gives result in [-pi, pi]

    x_mod2pi < -(π/2) && return (2, x_mod2pi)
    x_mod2pi < 0 && return (3, x_mod2pi)
    x_mod2pi ≤ (π/2) && return (0, x_mod2pi)

    return 1, x_mod2pi
end

"""
    sin(a::BareInterval)
    sin(a::Interval)

Implement the `sin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sin(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a

    whole_range = _unsafe_bareinterval(T, -one(T), one(T))

    diam(a) > inf(_two_pi(T)) && return whole_range

    # The following is equivalent to doing temp = a / _half_pi  and
    # taking floor(inf(a)), floor(sup(a))
    alo, ahi = bounds(a)
    lo_quadrant = minimum(_find_quadrants(T, alo))
    hi_quadrant = maximum(_find_quadrants(T, ahi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        ahi - alo > inf(bareinterval(T, π)) && return whole_range  # in same quadrant but separated by almost 2pi
        lo = @round(T, sin(alo), sin(alo))
        hi = @round(T, sin(ahi), sin(ahi))
        return hull(lo, hi)

    elseif lo_quadrant == 3 && hi_quadrant == 0
        return @round(T, sin(alo), sin(ahi))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(T, sin(ahi), sin(alo))

    elseif ( lo_quadrant == 0 || lo_quadrant == 3 ) && ( hi_quadrant == 1 || hi_quadrant == 2 )
        return @round(T, min(sin(alo), sin(ahi)), one(T))

    elseif ( lo_quadrant == 1 || lo_quadrant == 2 ) && ( hi_quadrant == 3 || hi_quadrant == 0 )
        return @round(T, -one(T), max(sin(alo), sin(ahi)))

    else  # if( iszero(lo_quadrant) && hi_quadrant == 3 ) || ( lo_quadrant == 2 && hi_quadrant == 1 )
        return whole_range
    end
end

function Base.sin(a::BareInterval{Float64})
    isempty_interval(a) && return a

    whole_range = _unsafe_bareinterval(Float64, -1.0, 1.0)

    diam(a) > inf(_two_pi(Float64)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant, lo = _quadrant(alo)
    hi_quadrant, hi = _quadrant(ahi)

    lo, hi = alo, ahi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        ahi - alo > inf(bareinterval(Float64, π)) && return whole_range

        if lo_quadrant == 1 || lo_quadrant == 2
            # negative slope
            return @round(Float64, sin(hi), sin(lo))
        else
            return @round(Float64, sin(lo), sin(hi))
        end

    elseif lo_quadrant == 3 && hi_quadrant == 0
        return @round(Float64, sin(lo), sin(hi))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(Float64, sin(hi), sin(lo))

    elseif ( lo_quadrant == 0 || lo_quadrant == 3 ) && ( hi_quadrant == 1 || hi_quadrant == 2 )
        return @round(Float64, min(sin(lo), sin(hi)), 1.0)

    elseif ( lo_quadrant == 1 || lo_quadrant == 2 ) && ( hi_quadrant == 3 || hi_quadrant == 0 )
        return @round(Float64, -1.0, max(sin(lo), sin(hi)))

    else # if ( iszero(lo_quadrant) && hi_quadrant == 3 ) || ( lo_quadrant == 2 && hi_quadrant == 1 )
        return whole_range
    end
end

function Base.sin(a::Interval)
    r = sin(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

Base.sinpi(a::BareInterval{T}) where {T<:NumTypes} = sin(a * bareinterval(T, π)) # not in the IEEE Standard 1788-2015
Base.sinpi(a::Interval{T}) where {T<:NumTypes} = sin(a * interval(T, π))

"""
    cos(a::BareInterval)
    cos(a::Interval)

Implement the `cos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cos(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a

    whole_range = _unsafe_bareinterval(T, -one(T), one(T))

    diam(a) > inf(_two_pi(T)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant = minimum(_find_quadrants(T, alo))
    hi_quadrant = maximum(_find_quadrants(T, ahi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        ahi - alo > inf(bareinterval(T, π)) && return whole_range
        lo = @round(T, cos(alo), cos(alo))
        hi = @round(T, cos(ahi), cos(ahi))
        return hull(lo, hi)

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(T, cos(alo), cos(ahi))

    elseif lo_quadrant == 0 && hi_quadrant == 1
        return @round(T, cos(ahi), cos(alo))

    elseif ( lo_quadrant == 2 || lo_quadrant == 3 ) && ( hi_quadrant == 0 || hi_quadrant == 1 )
        return @round(T, min(cos(alo), cos(ahi)), one(T))

    elseif ( lo_quadrant == 0 || lo_quadrant == 1 ) && ( hi_quadrant == 2 || hi_quadrant == 3 )
        return @round(T, -one(T), max(cos(alo), cos(ahi)))

    else  # if ( lo_quadrant == 3 && hi_quadrant == 2 ) || ( lo_quadrant == 1 && iszero(hi_quadrant) )
        return whole_range
    end
end

function Base.cos(a::BareInterval{Float64})
    isempty_interval(a) && return a

    whole_range = _unsafe_bareinterval(Float64, -1.0, 1.0)

    diam(a) > inf(_two_pi(Float64)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant, lo = _quadrant(alo)
    hi_quadrant, hi = _quadrant(ahi)

    lo, hi = alo, ahi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        ahi - alo > inf(bareinterval(Float64, π)) && return whole_range

        if lo_quadrant == 2 || lo_quadrant == 3
            # positive slope
            return @round(Float64, cos(lo), cos(hi))
        else
            return @round(Float64, cos(hi), cos(lo))
        end

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(Float64, cos(lo), cos(hi))

    elseif lo_quadrant == 0 && hi_quadrant == 1
        return @round(Float64, cos(hi), cos(lo))

    elseif ( lo_quadrant == 2 || lo_quadrant == 3 ) && ( hi_quadrant == 0 || hi_quadrant == 1 )
        return @round(Float64, min(cos(lo), cos(hi)), 1.0)

    elseif ( lo_quadrant == 0 || lo_quadrant == 1 ) && ( hi_quadrant == 2 || hi_quadrant == 3 )
        return @round(Float64, -1.0, max(cos(lo), cos(hi)))

    else #if ( lo_quadrant == 3 && hi_quadrant == 2 ) || ( lo_quadrant == 1 && iszero(hi_quadrant) )
        return whole_range
    end
end

function Base.cos(a::Interval)
    r = cos(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

Base.cospi(a::BareInterval{T}) where {T<:NumTypes} = cos(a * bareinterval(T, π)) # not in the IEEE Standard 1788-2015
Base.cospi(a::Interval{T}) where {T<:NumTypes} = cos(a * interval(T, π))

"""
    tan(a::BareInterval)
    tan(a::Interval)

Implement the `tan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.tan(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a

    diam(a) > inf(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    alo, ahi = bounds(a)
    lo_quadrant = minimum(_find_quadrants(T, alo))
    hi_quadrant = maximum(_find_quadrants(T, ahi))

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        # check if really contains singularity:
        if issubset_interval(_unsafe_scale(_half_pi(T), hi_quadrant), a)
            return entireinterval(BareInterval{T})  # crosses singularity
        end

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant > lo_quadrant
        # must cross singularity
        return entireinterval(BareInterval{T})

    end
    return @round(T, tan(alo), tan(ahi))
end

function Base.tan(a::BareInterval{Float64})
    isempty_interval(a) && return a

    diam(a) > inf(bareinterval(Float64, π)) && return entireinterval(BareInterval{Float64})

    alo, ahi = bounds(a)
    lo_quadrant, lo = _quadrant(alo)
    hi_quadrant, hi = _quadrant(ahi)

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        return entireinterval(BareInterval{Float64})  # crosses singularity

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant
        # must cross singularity
        return entireinterval(BareInterval{Float64})

    end

    return @round(Float64, tan(alo), tan(ahi))
end

function Base.tan(a::Interval)
    r = tan(bareinterval(a))
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isbounded(r), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    cot(a::BareInterval)
    cot(a::Interval)

Implement the `cot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cot(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a

    diam(a) > inf(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    isthinzero(a) && return emptyinterval(BareInterval{T})

    alo, ahi = bounds(a)
    lo_quadrant = minimum(_find_quadrants(T, alo))
    hi_quadrant = maximum(_find_quadrants(T, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(T, cot(ahi), typemax(T))

        return @round(T, cot(ahi), cot(alo))

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant ==2)
        iszero(ahi) && return @round(T, typemin(T), cot(alo))

        return entireinterval(BareInterval{T})

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant == 3)
        return @round(T, cot(ahi), cot(alo))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(T, typemin(T), cot(alo))

        return entireinterval(BareInterval{T})

    else
        return entireinterval(BareInterval{T})
    end
end

Base.cot(a::BareInterval{Float64}) = BareInterval{Float64}(cot(_bigequiv(a)))

"""
    sec(a::BareInterval)

Implement the `sec` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sec(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(BareInterval{T})

    alo, ahi = bounds(a)
    lo_quadrant = minimum(_find_quadrants(T, alo))
    hi_quadrant = maximum(_find_quadrants(T, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        lo = @round(T, sec(alo), sec(alo))
        hi = @round(T, sec(ahi), sec(ahi))
        return hull(lo, hi)

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant ==3)
        return entireinterval(BareInterval{T})

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(T, one(T), max(sec(alo), sec(ahi)))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(T, min(sec(alo), sec(ahi)), -one(T))

    else
        return entireinterval(BareInterval{T})
    end
end

Base.sec(a::BareInterval{Float64}) = BareInterval{Float64}(sec(_bigequiv(a)))

"""
    csc(a::BareInterval)

Implement the `csc` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.csc(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a

    diam(a) > inf(bareinterval(T, π)) && return entireinterval(BareInterval{T})

    isthinzero(a) && return emptyinterval(BareInterval{T})

    alo, ahi = bounds(a)
    lo_quadrant = minimum(_find_quadrants(T, alo))
    hi_quadrant = maximum(_find_quadrants(T, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(T, csc(ahi), typemax(T))

        lo = @round(T, csc(alo), csc(alo))
        hi = @round(T, csc(ahi), csc(ahi))
        return hull(lo, hi)

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant == 2)
        iszero(ahi) && return @round(T, typemin(T), csc(alo))

        return entireinterval(BareInterval{T})

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(T, one(T), max(csc(alo), csc(ahi)))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(T, min(csc(alo), csc(ahi)), -one(T))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(T, typemin(T), -one(T))

        return entireinterval(BareInterval{T})

    else
        return entireinterval(BareInterval{T})
    end
end

Base.csc(a::BareInterval{Float64}) = BareInterval{Float64}(csc(_bigequiv(a)))

"""
    asin(a::BareInterval)
    asin(a::Interval)

Implement the `asin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.asin(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    a = intersect_interval(a, domain)
    isempty_interval(a) && return a
    alo, ahi = bounds(a)
    return @round(T, asin(alo), asin(ahi))
end

function Base.asin(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = asin(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    acos(a::BareInterval)
    acos(a::Interval)

Implement the `acos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acos(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    a = intersect_interval(a, domain)
    isempty_interval(a) && return a
    alo, ahi = bounds(a)
    return @round(T, acos(ahi), acos(alo))
end

function Base.acos(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = acos(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    atan(a::BareInterval)
    atan(a::Interval)

Implement the `atan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atan(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    alo, ahi = bounds(a)
    return @round(T, atan(alo), atan(ahi))
end

function Base.atan(a::Interval)
    r = atan(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

function Base.atan(y::BareInterval{T}, x::BareInterval{S}) where {T<:NumTypes,S<:NumTypes}
    F = BareInterval{promote_type(T, S)}
    (isempty_interval(y) || isempty_interval(x)) && return emptyinterval(F)
    return F(atan(_bigequiv(y), _bigequiv(x)))
end

function Base.atan(y::BareInterval{BigFloat}, x::BareInterval{BigFloat})
    isempty_interval(y) && return y
    isempty_interval(x) && return x

    ylo, yhi = bounds(y)
    xlo, xhi = bounds(x)
    z = zero(BigFloat)

    # Prevent nonsense results when y has a signed zero:
    if iszero(ylo)
        y = _unsafe_bareinterval(BigFloat, z, yhi)
    end

    if iszero(yhi)
        y = _unsafe_bareinterval(BigFloat, ylo, z)
    end

    # Check cases based on x
    if isthinzero(x)
        isthinzero(y) && return emptyinterval(BareInterval{BigFloat})
        ylo ≥ z && return _half_pi(BigFloat)
        yhi ≤ z && return -_half_pi(BigFloat)
        return _half_range_atan(BigFloat)

    elseif xlo > z
        isthinzero(y) && return y
        ylo ≥ z &&
            return @round(BigFloat, atan(ylo, xhi), atan(yhi, xlo)) # refinement lo bound
        yhi ≤ z &&
            return @round(BigFloat, atan(ylo, xlo), atan(yhi, xhi))
        return @round(BigFloat, atan(ylo, xlo), atan(yhi, xlo))

    elseif xhi < z
        isthinzero(y) && return bareinterval(BigFloat, π)
        ylo ≥ z &&
            return @round(BigFloat, atan(yhi, xhi), atan(ylo, xlo))
        yhi < z &&
            return @round(BigFloat, atan(yhi, xlo), atan(ylo, xhi))
        return _range_atan(BigFloat)

    else # z ∈ x
        if iszero(xlo)
            isthinzero(y) && return y
            ylo ≥ z &&
                return _unsafe_bareinterval(BigFloat, atan(ylo, xhi, RoundDown), sup(_half_range_atan(BigFloat)))
            yhi ≤ z &&
                return _unsafe_bareinterval(BigFloat, inf(_half_range_atan(BigFloat)), atan(yhi, xhi, RoundUp))
            return _half_range_atan(BigFloat)

        elseif iszero(xhi)
            isthinzero(y) && return bareinterval(BigFloat, π)
            ylo ≥ z &&
                return _unsafe_bareinterval(BigFloat, inf(_half_pi(BigFloat)), atan(ylo, xlo, RoundUp))
            yhi < z &&
                return _unsafe_bareinterval(BigFloat, atan(yhi, xlo, RoundDown), inf(-_half_pi(BigFloat)))
            return _range_atan(BigFloat)
        else
            ylo ≥ z &&
                return @round(BigFloat, atan(ylo, xhi), atan(ylo, xlo))
            yhi < z &&
                return @round(BigFloat, atan(yhi, xlo), atan(yhi, xhi))
            return _range_atan(BigFloat)
        end
    end
end

function Base.atan(b::Interval, a::Interval)
    y = bareinterval(b)
    x = bareinterval(a)
    r = atan(y, x)
    d = min(decoration(b), decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, y),
            ifelse(in_interval(0, x), trv,
                ifelse(sup(x) < 0, ifelse(inf(y) < 0, def, dac), d)),
        d))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    acot(a::BareInterval)
    acot(a::Interval)

Implement the `acot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acot(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    return BareInterval{T}(@round(BigFloat, acot(_bigequiv(sup(a))), acot(_bigequiv(inf(a)))))
end

# automatically defined for `Interval` since it is a subtype of `Real`
