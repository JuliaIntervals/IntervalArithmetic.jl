# This file contains the functions described as "Trigonometric functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# not in the IEEE Standard 1788-2015

Base.rad2deg(x::BareInterval{T}) where {T<:NumTypes} = (x / bareinterval(T, π)) * bareinterval(T, 180)
Base.rad2deg(x::Interval{T}) where {T<:NumTypes} = (x / interval(T, π)) * interval(T, 180)

Base.deg2rad(x::BareInterval{T}) where {T<:NumTypes} = (x * bareinterval(T, π)) / bareinterval(T, 180)
Base.deg2rad(x::Interval{T}) where {T<:NumTypes} = (x * interval(T, π)) / interval(T, 180)

Base.sincospi(x::BareInterval) = (sinpi(x), cospi(x))
Base.sincospi(x::Interval) = (sinpi(x), cospi(x))

Base.sinpi(x::BareInterval{T}) where {T<:NumTypes} = sin(x * bareinterval(T, π))
Base.sinpi(x::Interval{T}) where {T<:NumTypes} = sin(x * interval(T, π))

Base.cospi(x::BareInterval{T}) where {T<:NumTypes} = cos(x * bareinterval(T, π))
Base.cospi(x::Interval{T}) where {T<:NumTypes} = cos(x * interval(T, π))

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
    sin(::BareInterval)
    sin(::Interval)

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

"""
    cos(::BareInterval)
    cos(::Interval)

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

function Base.cos(x::Interval)
    r = cos(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    tan(::BareInterval)
    tan(::Interval)

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
    lo_quadrant, _ = _quadrant(alo)
    hi_quadrant, _ = _quadrant(ahi)

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
    cot(::BareInterval)
    cot(::Interval)

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

function Base.cot(a::BareInterval{Float64})
    isempty_interval(a) && return a

    diam(a) > inf(bareinterval(Float64, π)) && return entireinterval(BareInterval{Float64})

    isthinzero(a) && return emptyinterval(BareInterval{Float64})

    alo, ahi = bounds(a)
    lo_quadrant, _ = _quadrant(alo)
    hi_quadrant, _ = _quadrant(ahi)

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(Float64, cot(ahi), typemax(Float64))

        return @round(Float64, cot(ahi), cot(alo))

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant ==2)
        iszero(ahi) && return @round(Float64, typemin(Float64), cot(alo))

        return entireinterval(BareInterval{Float64})

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant == 3)
        return @round(Float64, cot(ahi), cot(alo))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(Float64, typemin(Float64), cot(alo))

        return entireinterval(BareInterval{Float64})

    else
        return entireinterval(BareInterval{Float64})
    end
end

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    sec(::BareInterval)
    sec(::Interval)

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

function Base.sec(a::BareInterval{Float64})
    isempty_interval(a) && return a

    diam(a) > inf(interval(Float64, π)) && return entireinterval(BareInterval{Float64})

    alo, ahi = bounds(a)
    lo_quadrant, _ = _quadrant(alo)
    hi_quadrant, _ = _quadrant(ahi)

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        lo = @round(Float64, sec(alo), sec(alo))
        hi = @round(Float64, sec(ahi), sec(ahi))
        return hull(lo, hi)

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant ==3)
        return entireinterval(BareInterval{Float64})

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(Float64, one(Float64), max(sec(alo), sec(ahi)))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(Float64, min(sec(alo), sec(ahi)), -one(Float64))

    else
        return entireinterval(BareInterval{Float64})
    end
end

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    csc(::BareInterval)
    csc(::Interval)

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

function Base.csc(a::BareInterval{Float64})
    isempty_interval(a) && return a

    diam(a) > inf(bareinterval(Float64, π)) && return entireinterval(BareInterval{Float64})

    isthinzero(a) && return emptyinterval(BareInterval{Float64})

    alo, ahi = bounds(a)
    lo_quadrant, _ = _quadrant(alo)
    hi_quadrant, _ = _quadrant(ahi)

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(Float64, csc(ahi), typemax(Float64))

        lo = @round(Float64, csc(alo), csc(alo))
        hi = @round(Float64, csc(ahi), csc(ahi))
        return hull(lo, hi)

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant == 2)
        iszero(ahi) && return @round(Float64, typemin(Float64), csc(alo))

        return entireinterval(BareInterval{Float64})

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(Float64, one(Float64), max(csc(alo), csc(ahi)))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(Float64, min(csc(alo), csc(ahi)), -one(Float64))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(Float64, typemin(Float64), -one(Float64))

        return entireinterval(BareInterval{Float64})

    else
        return entireinterval(BareInterval{Float64})
    end
end

# automatically defined for `Interval` since it is a subtype of `Real`

"""
    asin(::BareInterval)
    asin(::Interval)

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
    acos(::BareInterval)
    acos(::Interval)

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

function Base.atan(y::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(y) && return y
    isempty_interval(x) && return x

    ylo, yhi = bounds(y)
    xlo, xhi = bounds(x)
    z = zero(T)

    # Prevent nonsense results when y has a signed zero:
    if iszero(ylo)
        y = _unsafe_bareinterval(T, z, yhi)
    end

    if iszero(yhi)
        y = _unsafe_bareinterval(T, ylo, z)
    end

    # Check cases based on x
    if isthinzero(x)
        isthinzero(y) && return emptyinterval(BareInterval{T})
        ylo ≥ z && return _half_pi(T)
        yhi ≤ z && return -_half_pi(T)
        return _half_range_atan(T)

    elseif xlo > z
        isthinzero(y) && return y
        ylo ≥ z &&
            return @round(T, atan(ylo, xhi), atan(yhi, xlo)) # refinement lo bound
        yhi ≤ z &&
            return @round(T, atan(ylo, xlo), atan(yhi, xhi))
        return @round(T, atan(ylo, xlo), atan(yhi, xlo))

    elseif xhi < z
        isthinzero(y) && return bareinterval(T, π)
        ylo ≥ z &&
            return @round(T, atan(yhi, xhi), atan(ylo, xlo))
        yhi < z &&
            return @round(T, atan(yhi, xlo), atan(ylo, xhi))
        return _range_atan(T)

    else # z ∈ x
        if iszero(xlo)
            isthinzero(y) && return y
            ylo ≥ z &&
                return _unsafe_bareinterval(T, _atan_round(ylo, xhi, RoundDown), sup(_half_range_atan(T)))
            yhi ≤ z &&
                return _unsafe_bareinterval(T, inf(_half_range_atan(T)), _atan_round(yhi, xhi, RoundUp))
            return _half_range_atan(T)

        elseif iszero(xhi)
            isthinzero(y) && return bareinterval(T, π)
            ylo ≥ z &&
                return _unsafe_bareinterval(T, inf(_half_pi(T)), _atan_round(ylo, xlo, RoundUp))
            yhi < z &&
                return _unsafe_bareinterval(T, _atan_round(yhi, xlo, RoundDown), sup(-_half_pi(T)))
            return _range_atan(T)
        else
            ylo ≥ z &&
                return @round(T, atan(ylo, xhi), atan(ylo, xlo))
            yhi < z &&
                return @round(T, atan(yhi, xlo), atan(yhi, xhi))
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
    d = min(d, ifelse(in_interval(0, by),
            ifelse(in_interval(0, bx), trv,
                ifelse(sup(bx) < 0, ifelse(inf(by) < 0, def, dac), d)),
        d))
    t = isguaranteed(y) & isguaranteed(x)
    return _unsafe_interval(r, d, t)
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
