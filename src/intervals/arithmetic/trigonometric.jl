# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Trigonometric functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3.
=#

const halfpi = pi / 2.0

half_pi(::Type{F}) where {F<:Interval} = scale(0.5, F(π))
two_pi(::Type{F}) where {F<:Interval} = scale(2, F(π))

function range_atan(::Type{F}) where {F<:Interval}
    temp = F(π)  # Using F(-π, π) converts -π to Float64 before Interval construction
    return F(-temp.hi, temp.hi)
end

half_range_atan(::Type{F}) where {F<:Interval} = range_atan(F) / 2

"""
    find_quadrants(x)

Finds the quadrant(s) corresponding to a given floating-point
number. The quadrants are labelled as 0 for x ∈ [0, π/2], etc.
For numbers very near a boundary of the quadrant, a tuple of two quadrants
is returned. The minimum or maximum must then be chosen appropriately.

This is a rather indirect way to determine if π/2 and 3π/2 are contained
in the interval; cf. the formula for sine of an interval in
Tucker, *Validated Numerics*.
"""
function find_quadrants(::Type{F}, x) where {F<:Interval}
    temp = F(x) / half_pi(F)
    return floor(temp.lo), floor(temp.hi)
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

Implement the `sin` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function sin(a::F) where {F<:Interval}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > two_pi(F).lo && return whole_range

    # The following is equiavlent to doing temp = a / half_pi  and
    # taking floor(a.lo), floor(a.hi)
    lo_quadrant = minimum(find_quadrants(F, a.lo))
    hi_quadrant = maximum(find_quadrants(F, a.hi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        a.hi - a.lo > F(π).lo && return whole_range  # in same quadrant but separated by almost 2pi
        lo = @round(F, sin(a.lo), sin(a.lo))
        hi = @round(F, sin(a.hi), sin(a.hi))
        return hull(lo, hi)

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(F, sin(a.lo), sin(a.hi))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(F, sin(a.hi), sin(a.lo))

    elseif ( iszero(lo_quadrant) || lo_quadrant == 3 ) && ( hi_quadrant == 1 || hi_quadrant == 2 )
        return @round(F, min(sin(a.lo), sin(a.hi)), 1)

    elseif ( lo_quadrant == 1 || lo_quadrant == 2 ) && ( hi_quadrant == 3 || iszero(hi_quadrant) )
        return @round(F, -1, max(sin(a.lo), sin(a.hi)))

    else  # if( iszero(lo_quadrant) && hi_quadrant == 3 ) || ( lo_quadrant == 2 && hi_quadrant == 1 )
        return whole_range
    end
end

function sin(a::F) where {F<:Interval{Float64}}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > two_pi(F).lo && return whole_range

    lo_quadrant, lo = quadrant(a.lo)
    hi_quadrant, hi = quadrant(a.hi)

    lo, hi = a.lo, a.hi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        a.hi - a.lo > F(π).lo && return whole_range  #

        if lo_quadrant == 1 || lo_quadrant == 2
            # negative slope
            return @round(F, sin(hi), sin(lo))
        else
            return @round(F, sin(lo), sin(hi))
        end

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(F, sin(lo), sin(hi))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(F, sin(hi), sin(lo))

    elseif ( iszero(lo_quadrant) || lo_quadrant == 3 ) && ( hi_quadrant == 1 || hi_quadrant == 2 )
        return @round(F, min(sin(lo), sin(hi)), 1)

    elseif ( lo_quadrant == 1 || lo_quadrant == 2 ) && ( hi_quadrant == 3 || iszero(hi_quadrant) )
        return @round(F, -1, max(sin(lo), sin(hi)))

    else #if( iszero(lo_quadrant) && hi_quadrant == 3 ) || ( lo_quadrant == 2 && hi_quadrant == 1 )
        return whole_range
    end
end

function sinpi(a::Interval{T}) where T
    isempty(a) && return a
    w = a * Interval{T}(π)
    return(sin(w))
end

"""
    cos(a::Interval)

Implement the `cos` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function cos(a::F) where {F<:Interval}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > two_pi(F).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(F, a.lo))
    hi_quadrant = maximum(find_quadrants(F, a.hi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        a.hi - a.lo > F(π).lo && return whole_range
        lo = @round(F, cos(a.lo), cos(a.lo))
        hi = @round(F, cos(a.hi), cos(a.hi))
        return hull(lo, hi)

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(F, cos(a.lo), cos(a.hi))

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(F, cos(a.hi), cos(a.lo))

    elseif ( lo_quadrant == 2 || lo_quadrant == 3 ) && ( iszero(hi_quadrant) || hi_quadrant == 1 )
        return @round(F, min(cos(a.lo), cos(a.hi)), 1)

    elseif ( iszero(lo_quadrant) || lo_quadrant == 1 ) && ( hi_quadrant == 2 || hi_quadrant == 3 )
        return @round(F, -1, max(cos(a.lo), cos(a.hi)))

    else  # if ( lo_quadrant == 3 && hi_quadrant == 2 ) || ( lo_quadrant == 1 && iszero(hi_quadrant) )
        return whole_range
    end
end

function cos(a::F) where {F<:Interval{Float64}}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > two_pi(F).lo && return whole_range

    lo_quadrant, lo = quadrant(a.lo)
    hi_quadrant, hi = quadrant(a.hi)

    lo, hi = a.lo, a.hi

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        a.hi - a.lo > F(π).lo && return whole_range

        if lo_quadrant == 2 || lo_quadrant == 3
            # positive slope
            return @round(F, cos(lo), cos(hi))
        else
            return @round(F, cos(hi), cos(lo))
        end

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(F, cos(a.lo), cos(a.hi))

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(F, cos(a.hi), cos(a.lo))

    elseif ( lo_quadrant == 2 || lo_quadrant == 3 ) && ( iszero(hi_quadrant) || hi_quadrant == 1 )
        return @round(F, min(cos(a.lo), cos(a.hi)), 1)

    elseif ( iszero(lo_quadrant) || lo_quadrant == 1 ) && ( hi_quadrant == 2 || hi_quadrant == 3 )
        return @round(F, -1, max(cos(a.lo), cos(a.hi)))

    else #if ( lo_quadrant == 3 && hi_quadrant == 2 ) || ( lo_quadrant == 1 && iszero(hi_quadrant) )
        return whole_range
    end
end

function cospi(a::Interval{T}) where T
    isempty(a) && return a
    w = a * Interval{T}(π)
    return(cos(w))
end

"""
    tan(a::Interval)

Implement the `tan` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function tan(a::F) where {F<:Interval}
    isempty(a) && return a

    diam(a) > F(π).lo && return entireinterval(a)

    lo_quadrant = minimum(find_quadrants(F, a.lo))
    hi_quadrant = maximum(find_quadrants(F, a.hi))

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        # check if really contains singularity:
        if hi_quadrant * half_pi(F) ⊆ a
            return entireinterval(F)  # crosses singularity
        end

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant > lo_quadrant
        # must cross singularity
        return entireinterval(F)

    end
    return @round(F, tan(a.lo), tan(a.hi))
end

function tan(a::F) where {F<:Interval{Float64}}
    isempty(a) && return a

    diam(a) > F(π).lo && return entireinterval(a)

    lo_quadrant, lo = quadrant(a.lo)
    hi_quadrant, hi = quadrant(a.hi)

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        return entireinterval(a)  # crosses singularity

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant
        # must cross singularity
        return entireinterval(a)

    end

    return @round(F, tan(a.lo), tan(a.hi))
end

"""
    asin(a::Interval)

Implement the `asin` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function asin(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    return @round(F, asin(a.lo), asin(a.hi))
end

"""
    acos(a::Interval)

Implement the `acos` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acos(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    return @round(F, acos(a.hi), acos(a.lo))
end

"""
    atan(a::Interval)

Implement the `atan` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function atan(a::F) where {F<:Interval}
    isempty(a) && return a

    return @round(F, atan(a.lo), atan(a.hi))
end

function atan(y::Interval{T}, x::Interval{S}) where {T, S}
    F = Interval{promote_type(T, S)}
    (isempty(y) || isempty(x)) && return emptyinterval(F)
    return F(atan(big(y), big(x)))
end

function atan(y::Interval{BigFloat}, x::Interval{BigFloat})
    F = Interval{BigFloat}
    T = BigFloat

    (isempty(y) || isempty(x)) && return emptyinterval(F)

    # Prevent nonsense results when y has a signed zero:
    if iszero(y.lo)
        y = F(0, y.hi)
    end

    if iszero(y.hi)
        y = F(y.lo, 0)
    end

    # Check cases based on x
    if isthinzero(x)
        isthinzero(y) && return emptyinterval(F)
        y.lo ≥ zero(T) && return half_pi(F)
        y.hi ≤ zero(T) && return -half_pi(F)
        return half_range_atan(F)

    elseif x.lo > zero(T)
        isthinzero(y) && return y
        y.lo ≥ zero(T) &&
            return @round(F, atan(y.lo, x.hi), atan(y.hi, x.lo)) # refinement lo bound
        y.hi ≤ zero(T) &&
            return @round(F, atan(y.lo, x.lo), atan(y.hi, x.hi))
        return @round(F, atan(y.lo, x.lo), atan(y.hi, x.lo))

    elseif x.hi < zero(T)
        isthinzero(y) && return F(π)
        y.lo ≥ zero(T) &&
            return @round(F, atan(y.hi, x.hi), atan(y.lo, x.lo))
        y.hi < zero(T) &&
            return @round(F, atan(y.hi, x.lo), atan(y.lo, x.hi))
        return range_atan(F)

    else # zero(T) ∈ x
        if iszero(x.lo)
            isthinzero(y) && return y
            y.lo ≥ zero(T) && return @round(F, atan(y.lo, x.hi), half_range_atan(F).hi)
            y.hi ≤ zero(T) && return @round(F, half_range_atan(F).lo, atan(y.hi, x.hi))
            return half_range_atan(F)

        elseif iszero(x.hi)
            isthinzero(y) && return F(π)
            y.lo ≥ zero(T) && return @round(F, half_pi(F).lo, atan(y.lo, x.lo))
            y.hi < zero(T) && return @round(F, atan(y.hi, x.lo), -(half_pi(F).lo))
            return range_atan(F)
        else
            y.lo ≥ zero(T) &&
                return @round(F, atan(y.lo, x.hi), atan(y.lo, x.lo))
            y.hi < zero(T) &&
                return @round(F, atan(y.hi, x.lo), atan(y.hi, x.hi))
            return range_atan(F)
        end
    end
end
