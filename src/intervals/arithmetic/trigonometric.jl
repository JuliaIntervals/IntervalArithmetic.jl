# This file contains the functions described as "Trigonometric functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# needed to prevent stack overflow

rad2deg(x::Interval) = (x / π) * 180

deg2rad(x::Interval) = (x * π) / 180

sincospi(x::Interval) = (sinpi(x), cospi(x))

#

const halfpi = π / 2

half_pi(::Type{T}) where {T<:NumTypes} = unsafe_scale(convert(T, 0.5), interval(T, π))
two_pi(::Type{T}) where {T<:NumTypes} = unsafe_scale(convert(T, 2), interval(T, π))

function range_atan(::Type{T}) where {T<:NumTypes}
    temp = sup(interval(T, π))
    return unsafe_interval(T, -temp, temp)
end

half_range_atan(::Type{T}) where {T<:NumTypes} = range_atan(T) / 2

"""
    find_quadrants(x)

Finds the quadrant(s) corresponding to a given floating-point
number. The quadrants are labelled as 0 for x ∈ [0, π/2], etc.
A tuple of two quadrants is returned.
The minimum or maximum must then be chosen appropriately.

This is a rather indirect way to determine if π/2 and 3π/2 are contained
in the interval; cf. the formula for sine of an interval in
Tucker, *Validated Numerics*.
"""
function find_quadrants(::Type{T}, x) where {T<:NumTypes}
    temp = unsafe_interval(T, x, x) / half_pi(T)
    return floor(inf(temp)), floor(sup(temp))
end

# Quadrant function for Float64 specialized methods
function quadrant(x::Float64)
    x_mod2pi = rem2pi(x, RoundNearest)  # gives result in [-pi, pi]

    x_mod2pi < -halfpi && return (2, x_mod2pi)
    x_mod2pi < 0 && return (3, x_mod2pi)
    x_mod2pi <= halfpi && return (0, x_mod2pi)

    return 1, x_mod2pi
end

"""
    sin(a::Interval)

Implement the `sin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sin(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a

    whole_range = unsafe_interval(T, -one(T), one(T))

    diam(a) > inf(two_pi(T)) && return whole_range

    # The following is equiavlent to doing temp = a / half_pi  and
    # taking floor(inf(a)), floor(sup(a))
    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(T, alo))
    hi_quadrant = maximum(find_quadrants(T, ahi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        ahi - alo > inf(interval(T, π)) && return whole_range  # in same quadrant but separated by almost 2pi
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

function sin(a::Interval{Float64})
    isempty(a) && return a

    whole_range = unsafe_interval(Float64, -1.0, 1.0)

    diam(a) > inf(two_pi(Float64)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant, lo = quadrant(alo)
    hi_quadrant, hi = quadrant(ahi)

    lo, hi = alo, ahi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        ahi - alo > inf(interval(Float64, π)) && return whole_range

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

    else #if( iszero(lo_quadrant) && hi_quadrant == 3 ) || ( lo_quadrant == 2 && hi_quadrant == 1 )
        return whole_range
    end
end

sinpi(a::Interval) = sin(a * π)

"""
    cos(a::Interval)

Implement the `cos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function cos(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a

    whole_range = unsafe_interval(T, -one(T), one(T))

    diam(a) > inf(two_pi(T)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(T, alo))
    hi_quadrant = maximum(find_quadrants(T, ahi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        ahi - alo > inf(interval(T, π)) && return whole_range
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

function cos(a::Interval{Float64})
    isempty(a) && return a

    whole_range = unsafe_interval(Float64, -1.0, 1.0)

    diam(a) > inf(two_pi(Float64)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant, lo = quadrant(alo)
    hi_quadrant, hi = quadrant(ahi)

    lo, hi = alo, ahi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        ahi - alo > inf(interval(Float64, π)) && return whole_range

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

cospi(a::Interval) = cos(a * π)

"""
    tan(a::Interval)

Implement the `tan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function tan(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(T)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(T, alo))
    hi_quadrant = maximum(find_quadrants(T, ahi))

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        # check if really contains singularity:
        if hi_quadrant * half_pi(T) ⊆ a
            return entireinterval(T)  # crosses singularity
        end

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant > lo_quadrant
        # must cross singularity
        return entireinterval(T)

    end
    return @round(T, tan(alo), tan(ahi))
end

function tan(a::Interval{Float64})
    isempty(a) && return a

    diam(a) > inf(interval(Float64, π)) && return entireinterval(Float64)

    alo, ahi = bounds(a)
    lo_quadrant, lo = quadrant(alo)
    hi_quadrant, hi = quadrant(ahi)

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        return entireinterval(Float64)  # crosses singularity

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant
        # must cross singularity
        return entireinterval(Float64)

    end

    return @round(Float64, tan(alo), tan(ahi))
end

"""
    cot(a::Interval)

Implement the `cot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function cot(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(T)

    isthinzero(a) && return emptyinterval(T)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(T, alo))
    hi_quadrant = maximum(find_quadrants(T, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(T, cot(ahi), typemax(T))

        return @round(T, cot(ahi), cot(alo))

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant ==2)
        iszero(ahi) && return @round(T, typemin(T), cot(alo))

        return entireinterval(T)

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant == 3)
        return @round(T, cot(ahi), cot(alo))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(T, typemin(T), cot(alo))

        return entireinterval(T)

    else
        return entireinterval(T)
    end
end

cot(a::Interval{Float64}) = atomic(Float64, cot(big(a)))

"""
    sec(a::Interval)

Implement the `sec` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sec(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(T)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(T, alo))
    hi_quadrant = maximum(find_quadrants(T, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        lo = @round(T, sec(alo), sec(alo))
        hi = @round(T, sec(ahi), sec(ahi))
        return hull(lo, hi)

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant ==3)
        return entireinterval(T)

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(T, one(T), max(sec(alo), sec(ahi)))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(T, min(sec(alo), sec(ahi)), -one(T))

    else
        return entireinterval(T)
    end
end

sec(a::Interval{Float64}) = atomic(Float64, sec(big(a)))

"""
    csc(a::Interval)

Implement the `csc` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function csc(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(T)

    isthinzero(a) && return emptyinterval(T)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(T, alo))
    hi_quadrant = maximum(find_quadrants(T, ahi))

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

        return entireinterval(T)

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(T, one(T), max(csc(alo), csc(ahi)))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(T, min(csc(alo), csc(ahi)), -one(T))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(T, typemin(T), -one(T))

        return entireinterval(T)

    else
        return entireinterval(T)
    end
end

csc(a::Interval{Float64}) = atomic(Float64, csc(big(a)))

"""
    asin(a::Interval)

Implement the `asin` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function asin(a::Interval{T}) where {T<:NumTypes}
    domain = unsafe_interval(T, -one(T), one(T))
    a = a ∩ domain
    isempty(a) && return a
    alo, ahi = bounds(a)
    return @round(T, asin(alo), asin(ahi))
end

"""
    acos(a::Interval)

Implement the `acos` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acos(a::Interval{T}) where {T<:NumTypes}
    domain = unsafe_interval(T, -one(T), one(T))
    a = a ∩ domain
    isempty(a) && return a
    alo, ahi = bounds(a)
    return @round(T, acos(ahi), acos(alo))
end

"""
    atan(a::Interval)

Implement the `atan` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function atan(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    alo, ahi = bounds(a)
    return @round(T, atan(alo), atan(ahi))
end

function atan(y::Interval{T}, x::Interval{S}) where {T<:NumTypes,S<:NumTypes}
    F = Interval{promote_type(T, S)}
    (isempty(y) || isempty(x)) && return emptyinterval(F)
    return F(atan(big(y), big(x)))
end

function atan(y::Interval{BigFloat}, x::Interval{BigFloat})
    isempty(y) && return y
    isempty(x) && return x

    ylo, yhi = bounds(y)
    xlo, xhi = bounds(x)
    z = zero(BigFloat)

    # Prevent nonsense results when y has a signed zero:
    if iszero(ylo)
        y = unsafe_interval(BigFloat, z, yhi)
    end

    if iszero(yhi)
        y = unsafe_interval(BigFloat, ylo, z)
    end

    # Check cases based on x
    if isthinzero(x)
        isthinzero(y) && return emptyinterval(BigFloat)
        ylo ≥ z && return half_pi(BigFloat)
        yhi ≤ z && return -half_pi(BigFloat)
        return half_range_atan(BigFloat)

    elseif xlo > z
        isthinzero(y) && return y
        ylo ≥ z &&
            return @round(BigFloat, atan(ylo, xhi), atan(yhi, xlo)) # refinement lo bound
        yhi ≤ z &&
            return @round(BigFloat, atan(ylo, xlo), atan(yhi, xhi))
        return @round(BigFloat, atan(ylo, xlo), atan(yhi, xlo))

    elseif xhi < z
        isthinzero(y) && return interval(BigFloat, π)
        ylo ≥ z &&
            return @round(BigFloat, atan(yhi, xhi), atan(ylo, xlo))
        yhi < z &&
            return @round(BigFloat, atan(yhi, xlo), atan(ylo, xhi))
        return range_atan(BigFloat)

    else # z ∈ x
        if iszero(xlo)
            isthinzero(y) && return y
            ylo ≥ z &&
                return unsafe_interval(BigFloat, atan(ylo, xhi, RoundDown), sup(half_range_atan(BigFloat)))
            yhi ≤ z &&
                return unsafe_interval(BigFloat, inf(half_range_atan(BigFloat)), atan(yhi, xhi, RoundUp))
            return half_range_atan(BigFloat)

        elseif iszero(xhi)
            isthinzero(y) && return interval(BigFloat, π)
            ylo ≥ z &&
                return unsafe_interval(BigFloat, inf(half_pi(BigFloat)), atan(ylo, xlo, RoundUp))
            yhi < z &&
                return unsafe_interval(BigFloat, atan(yhi, xlo, RoundDown), inf(-half_pi(BigFloat)))
            return range_atan(BigFloat)
        else
            ylo ≥ z &&
                return @round(BigFloat, atan(ylo, xhi), atan(ylo, xlo))
            yhi < z &&
                return @round(BigFloat, atan(yhi, xlo), atan(yhi, xhi))
            return range_atan(BigFloat)
        end
    end
end

"""
    acot(a::Interval)

Implement the `acot` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acot(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    return atomic(T, interval(acot(bigequiv(sup(a))), acot(bigequiv(inf(a)))))
    # return atomic(T, @round(Interval{BigFloat}, acot(bigequiv(sup(a))), acot(bigequiv(inf(a)))))
end
