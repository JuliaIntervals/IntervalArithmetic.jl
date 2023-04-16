# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Trigonometric functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3.
=#

const halfpi = pi / 2.0

half_pi(::Type{Interval{T}}) where {T<:NumTypes} = scale(0.5, interval(T, π))
two_pi(::Type{Interval{T}}) where {T<:NumTypes} = scale(2, interval(T, π))

function range_atan(::Type{F}) where {T,F<:Interval{T}}
    temp = sup(interval(T, π))  # Using F(-π, π) converts -π to Float64 before Interval construction
    return F(-temp, temp)
end

half_range_atan(::Type{F}) where {F<:Interval} = range_atan(F) / 2

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
function find_quadrants(::Type{F}, x) where {F<:Interval}
    temp = F(x, x) / half_pi(F)
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

Implement the `sin` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function sin(a::F) where {T<:NumTypes,F<:Interval{T}}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > inf(two_pi(F)) && return whole_range

    # The following is equiavlent to doing temp = a / half_pi  and
    # taking floor(inf(a)), floor(sup(a))
    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(F, alo))
    hi_quadrant = maximum(find_quadrants(F, ahi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        ahi - alo > inf(interval(T, π)) && return whole_range  # in same quadrant but separated by almost 2pi
        lo = @round(F, sin(alo), sin(alo))
        hi = @round(F, sin(ahi), sin(ahi))
        return hull(lo, hi)

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(F, sin(alo), sin(ahi))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(F, sin(ahi), sin(alo))

    elseif ( iszero(lo_quadrant) || lo_quadrant == 3 ) && ( hi_quadrant == 1 || hi_quadrant == 2 )
        return @round(F, min(sin(alo), sin(ahi)), 1)

    elseif ( lo_quadrant == 1 || lo_quadrant == 2 ) && ( hi_quadrant == 3 || iszero(hi_quadrant) )
        return @round(F, -1, max(sin(alo), sin(ahi)))

    else  # if( iszero(lo_quadrant) && hi_quadrant == 3 ) || ( lo_quadrant == 2 && hi_quadrant == 1 )
        return whole_range
    end
end

function sin(a::F) where {F<:Interval{Float64}}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > inf(two_pi(F)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant, lo = quadrant(alo)
    hi_quadrant, hi = quadrant(ahi)

    lo, hi = alo, ahi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        ahi - alo > inf(interval(Float64, π)) && return whole_range

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

function sinpi(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    w = a * interval(T, π)
    return sin(w)
end

"""
    cos(a::Interval)

Implement the `cos` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function cos(a::F) where {T<:NumTypes,F<:Interval{T}}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > inf(two_pi(F)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(F, alo))
    hi_quadrant = maximum(find_quadrants(F, ahi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        ahi - alo > inf(interval(T, π)) && return whole_range
        lo = @round(F, cos(alo), cos(alo))
        hi = @round(F, cos(ahi), cos(ahi))
        return hull(lo, hi)

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(F, cos(alo), cos(ahi))

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(F, cos(ahi), cos(alo))

    elseif ( lo_quadrant == 2 || lo_quadrant == 3 ) && ( iszero(hi_quadrant) || hi_quadrant == 1 )
        return @round(F, min(cos(alo), cos(ahi)), 1)

    elseif ( iszero(lo_quadrant) || lo_quadrant == 1 ) && ( hi_quadrant == 2 || hi_quadrant == 3 )
        return @round(F, -1, max(cos(alo), cos(ahi)))

    else  # if ( lo_quadrant == 3 && hi_quadrant == 2 ) || ( lo_quadrant == 1 && iszero(hi_quadrant) )
        return whole_range
    end
end

function cos(a::F) where {F<:Interval{Float64}}
    isempty(a) && return a

    whole_range = F(-1, 1)

    diam(a) > inf(two_pi(F)) && return whole_range

    alo, ahi = bounds(a)
    lo_quadrant, lo = quadrant(alo)
    hi_quadrant, hi = quadrant(ahi)

    lo, hi = alo, ahi  # should be able to use the modulo version of a, but doesn't seem to work

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        ahi - alo > inf(interval(Float64, π)) && return whole_range

        if lo_quadrant == 2 || lo_quadrant == 3
            # positive slope
            return @round(F, cos(lo), cos(hi))
        else
            return @round(F, cos(hi), cos(lo))
        end

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(F, cos(lo), cos(hi))

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(F, cos(hi), cos(lo))

    elseif ( lo_quadrant == 2 || lo_quadrant == 3 ) && ( iszero(hi_quadrant) || hi_quadrant == 1 )
        return @round(F, min(cos(lo), cos(hi)), 1)

    elseif ( iszero(lo_quadrant) || lo_quadrant == 1 ) && ( hi_quadrant == 2 || hi_quadrant == 3 )
        return @round(F, -1, max(cos(lo), cos(hi)))

    else #if ( lo_quadrant == 3 && hi_quadrant == 2 ) || ( lo_quadrant == 1 && iszero(hi_quadrant) )
        return whole_range
    end
end

function cospi(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    w = a * interval(T, π)
    return cos(w)
end

"""
    tan(a::Interval)

Implement the `tan` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function tan(a::F) where {T<:NumTypes,F<:Interval{T}}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(a)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(F, alo))
    hi_quadrant = maximum(find_quadrants(F, ahi))

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
    return @round(F, tan(alo), tan(ahi))
end

function tan(a::F) where {F<:Interval{Float64}}
    isempty(a) && return a

    diam(a) > inf(interval(Float64, π)) && return entireinterval(a)

    alo, ahi = bounds(a)
    lo_quadrant, lo = quadrant(alo)
    hi_quadrant, hi = quadrant(ahi)

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if iszero(lo_quadrant_mod) && hi_quadrant_mod == 1
        return entireinterval(a)  # crosses singularity

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant
        # must cross singularity
        return entireinterval(a)

    end

    return @round(F, tan(alo), tan(ahi))
end

"""
    cot(a::Interval)

Implement the `cot` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function cot(a::F) where {T<:NumTypes,F<:Interval{T}}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(a)

    isthinzero(a) && return emptyinterval(a)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(F, alo))
    hi_quadrant = maximum(find_quadrants(F, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(F, cot(ahi), Inf)

        return @round(F, cot(ahi), cot(alo))

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant ==2)
        iszero(ahi) && return @round(F, -Inf, cot(alo))

        return entireinterval(a)

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant == 3)
        return @round(F, cot(ahi), cot(alo))

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(F, -Inf, cot(alo))

        return entireinterval(a)

    else
        return entireinterval(a)
    end
end

cot(a::F) where {F<:Interval{Float64}} = atomic(F, cot(big(a)))

"""
    sec(a::Interval)

Implement the `sec` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function sec(a::F) where {T<:NumTypes,F<:Interval{T}}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(a)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(F, alo))
    hi_quadrant = maximum(find_quadrants(F, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant  # Interval limits in the same quadrant
        lo = @round(F, sec(alo), sec(alo))
        hi = @round(F, sec(ahi), sec(ahi))
        return hull(lo, hi)

    elseif (iszero(lo_quadrant) && hi_quadrant == 1) || (lo_quadrant == 2 && hi_quadrant ==3)
        return entireinterval(a)

    elseif lo_quadrant == 3 && iszero(hi_quadrant)
        return @round(F, 1, max(sec(alo), sec(ahi)))

    elseif lo_quadrant == 1 && hi_quadrant == 2
        return @round(F, min(sec(alo), sec(ahi)), -1)

    else
        return entireinterval(a)
    end
end

sec(a::F) where {F<:Interval{Float64}} = atomic(F, sec(big(a)))

"""
    csc(a::Interval)

Implement the `csc` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function csc(a::F) where {T<:NumTypes,F<:Interval{T}}
    isempty(a) && return a

    diam(a) > inf(interval(T, π)) && return entireinterval(a)

    isthinzero(a) && return emptyinterval(a)

    alo, ahi = bounds(a)
    lo_quadrant = minimum(find_quadrants(F, alo))
    hi_quadrant = maximum(find_quadrants(F, ahi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        iszero(alo) && return @round(F, csc(ahi), Inf)

        lo = @round(F, csc(alo), csc(alo))
        hi = @round(F, csc(ahi), csc(ahi))
        return hull(lo, hi)

    elseif (lo_quadrant == 3 && iszero(hi_quadrant)) || (lo_quadrant == 1 && hi_quadrant ==2)
        iszero(ahi) && return @round(F, -Inf, csc(alo))

        return entireinterval(a)

    elseif iszero(lo_quadrant) && hi_quadrant == 1
        return @round(F, 1, max(csc(alo), csc(ahi)))

    elseif lo_quadrant == 2 && hi_quadrant == 3
        return @round(F, min(csc(alo), csc(ahi)), -1)

    elseif ( lo_quadrant == 2 && iszero(hi_quadrant))
        iszero(ahi) && return @round(F, -Inf, -1)

        return entireinterval(a)

    else
        return entireinterval(a)
    end
end

csc(a::F) where {F<:Interval{Float64}} = atomic(F, csc(big(a)))

"""
    asin(a::Interval)

Implement the `asin` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function asin(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    alo, ahi = bounds(a)
    return @round(F, asin(alo), asin(ahi))
end

"""
    acos(a::Interval)

Implement the `acos` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acos(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    alo, ahi = bounds(a)
    return @round(F, acos(ahi), acos(alo))
end

"""
    atan(a::Interval)

Implement the `atan` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function atan(a::F) where {F<:Interval}
    isempty(a) && return a

    alo, ahi = bounds(a)
    return @round(F, atan(alo), atan(ahi))
end

function atan(y::Interval{T}, x::Interval{S}) where {T<:NumTypes,S<:NumTypes}
    F = Interval{promote_type(T, S)}
    (isempty(y) || isempty(x)) && return emptyinterval(F)
    return F(atan(big(y), big(x)))
end

function atan(y::F, x::F) where {F<:Interval{BigFloat}}
    (isempty(y) || isempty(x)) && return emptyinterval(F)

    ylo, yhi = bounds(y)
    xlo, xhi = bounds(x)
    z = zero(BigFloat)

    # Prevent nonsense results when y has a signed zero:
    if iszero(ylo)
        y = F(0, yhi)
    end

    if iszero(yhi)
        y = F(ylo, 0)
    end

    # Check cases based on x
    if isthinzero(x)
        isthinzero(y) && return emptyinterval(F)
        ylo ≥ z && return half_pi(F)
        yhi ≤ z && return -half_pi(F)
        return half_range_atan(F)

    elseif xlo > z
        isthinzero(y) && return y
        ylo ≥ z &&
            return @round(F, atan(ylo, xhi), atan(yhi, xlo)) # refinement lo bound
        yhi ≤ z &&
            return @round(F, atan(ylo, xlo), atan(yhi, xhi))
        return @round(F, atan(ylo, xlo), atan(yhi, xlo))

    elseif xhi < z
        isthinzero(y) && return interval(BigFloat, π)
        ylo ≥ z &&
            return @round(F, atan(yhi, xhi), atan(ylo, xlo))
        yhi < z &&
            return @round(F, atan(yhi, xlo), atan(ylo, xhi))
        return range_atan(F)

    else # z ∈ x
        if iszero(xlo)
            isthinzero(y) && return y
            ylo ≥ z &&
                return F(atan(ylo, xhi, RoundDown), sup(half_range_atan(F)))
            yhi ≤ z &&
                return F(inf(half_range_atan(F)), atan(yhi, xhi, RoundUp))
            return half_range_atan(F)

        elseif iszero(xhi)
            isthinzero(y) && return interval(BigFloat, π)
            ylo ≥ z &&
                return F(inf(half_pi(F)), atan(ylo, xlo, RoundUp))
            yhi < z &&
                return F(atan(yhi, xlo, RoundDown), inf(-half_pi(F)))
            return range_atan(F)
        else
            ylo ≥ z &&
                return @round(F, atan(ylo, xhi), atan(ylo, xlo))
            yhi < z &&
                return @round(F, atan(yhi, xlo), atan(yhi, xhi))
            return range_atan(F)
        end
    end
end

"""
    acot(a::Interval)

Implement the `acot` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acot(a::F) where {F<:Interval}
    isempty(a) && return a

    return atomic(F, interval(acot(bigequiv(sup(a))), acot(bigequiv(inf(a)))))
    # return atomic(F, @round(Interval{BigFloat}, acot(bigequiv(sup(a))), acot(bigequiv(inf(a)))))
end
