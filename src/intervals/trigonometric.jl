# This file is part of the IntervalArithmetic.jl package; MIT licensed

half_pi(::Type{T}) where T = pi_interval(T) / 2
half_pi(x::T) where T<:AbstractFloat = half_pi(T)

two_pi(::Type{T})  where T = pi_interval(T) * 2

range_atan2(::Type{T}) where {T<:Real} = Interval(-(pi_interval(T).hi), pi_interval(T).hi)
half_range_atan2(::Type{T}) where {T} = (temp = half_pi(T); Interval(-(temp.hi), temp.hi) )
pos_range_atan2(::Type{T}) where {T<:Real} = Interval(zero(T), pi_interval(T).hi)


doc"""Finds the quadrant(s) corresponding to a given floating-point
number. The quadrants are labelled as 0 for x ∈ [0, π/2], etc.
For numbers very near a boundary of the quadrant, a tuple of two quadrants
is returned. The minimum or maximum must then be chosen appropriately.

This is a rather indirect way to determine if π/2 and 3π/2 are contained
in the interval; cf. the formula for sine of an interval in
Tucker, *Validated Numerics*."""

function find_quadrants(x::AbstractFloat)
    temp = x / half_pi(x)
    (floor(temp.lo), floor(temp.hi))
end

function sin(a::Interval{T}) where T
    isempty(a) && return a

    whole_range = Interval{T}(-1, 1)

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return whole_range
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        a.hi - a.lo > pi_interval(T).lo && return whole_range  # in same quadrant but separated by almost 2pi
        lo = @round(sin(a.lo), sin(a.lo)) # Interval(sin(a.lo, RoundDown), sin(a.lo, RoundUp))
        hi = @round(sin(a.hi), sin(a.hi)) # Interval(sin(a.hi, RoundDown), sin(a.hi, RoundUp))
        return hull(lo, hi)

    elseif lo_quadrant==3 && hi_quadrant==0
        return @round(sin(a.lo), sin(a.hi)) # Interval(sin(a.lo, RoundDown), sin(a.hi, RoundUp))

    elseif lo_quadrant==1 && hi_quadrant==2
        return @round(sin(a.hi), sin(a.lo)) # Interval(sin(a.hi, RoundDown), sin(a.lo, RoundUp))

    elseif ( lo_quadrant == 0 || lo_quadrant==3 ) && ( hi_quadrant==1 || hi_quadrant==2 )
        return @round(min(sin(a.lo), sin(a.hi)), 1)
        # Interval(min(sin(a.lo, RoundDown), sin(a.hi, RoundDown)), one(T))

    elseif ( lo_quadrant == 1 || lo_quadrant==2 ) && ( hi_quadrant==3 || hi_quadrant==0 )
        return @round(-1, max(sin(a.lo), sin(a.hi)))
        # Interval(-one(T), max(sin(a.lo, RoundUp), sin(a.hi, RoundUp)))

    else #if( lo_quadrant == 0 && hi_quadrant==3 ) || ( lo_quadrant == 2 && hi_quadrant==1 )
        return whole_range
    end
end


function cos(a::Interval{T}) where T
    isempty(a) && return a

    whole_range = Interval(-one(T), one(T))

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    if hi_quadrant - lo_quadrant > 4  # close to limits
        return Interval(-one(T), one(T))
    end

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        a.hi - a.lo > pi_interval(T).lo && return whole_range
        lo = @round(cos(a.lo), cos(a.lo))
        hi = @round(cos(a.hi), cos(a.hi))
        return hull(lo, hi)

    elseif lo_quadrant == 2 && hi_quadrant==3
        return @round(cos(a.lo), cos(a.hi))

    elseif lo_quadrant == 0 && hi_quadrant==1
        return @round(cos(a.hi), cos(a.lo))

    elseif ( lo_quadrant == 2 || lo_quadrant==3 ) && ( hi_quadrant==0 || hi_quadrant==1 )
        return @round(min(cos(a.lo), cos(a.hi)), 1)

    elseif ( lo_quadrant == 0 || lo_quadrant==1 ) && ( hi_quadrant==2 || hi_quadrant==3 )
        return @round(-1, max(cos(a.lo), cos(a.hi)))

    else#if ( lo_quadrant == 3 && hi_quadrant==2 ) || ( lo_quadrant == 1 && hi_quadrant==0 )
        return whole_range
    end
end


function tan(a::Interval{T}) where T
    isempty(a) && return a

    diam(a) > pi_interval(T).lo && return entireinterval(a)

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if lo_quadrant_mod == 0 && hi_quadrant_mod == 1
        # check if really contains singularity:
        if hi_quadrant * half_pi(T) ⊆ a
            return entireinterval(a)  # crosses singularity
        end

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant > lo_quadrant
        # must cross singularity
        return entireinterval(a)

    end

    # @show a.lo, a.hi
    # @show tan(a.lo), tan(a.hi)

    return @round(tan(a.lo), tan(a.hi))
end

function asin(a::Interval{T}) where T

    domain = Interval(-one(T), one(T))
    a = a ∩ domain

    isempty(a) && return a

    return @round(asin(a.lo), asin(a.hi))
end

function acos(a::Interval{T}) where T

    domain = Interval(-one(T), one(T))
    a = a ∩ domain

    isempty(a) && return a

    return @round(acos(a.hi), acos(a.lo))
end


function atan(a::Interval{T}) where T
    isempty(a) && return a

    return @round(atan(a.lo), atan(a.hi))
end


#atan2{T<:Real, S<:Real}(y::Interval{T}, x::Interval{S}) = atan2(promote(y, x)...)

function atan2(y::Interval{Float64}, x::Interval{Float64})
    (isempty(y) || isempty(x)) && return emptyinterval(Float64)

    convert(Interval{Float64}, atan2(big53(y), big53(x)))
end



function atan2(y::Interval{BigFloat}, x::Interval{BigFloat})
    (isempty(y) || isempty(x)) && return emptyinterval(BigFloat)

    T = BigFloat

    # Prevent nonsense results when y has a signed zero:
    if y.lo == zero(T)
        y = Interval(zero(T), y.hi)
    end
    if y.hi == zero(T)
        y = Interval(y.lo, zero(T))
    end

    # Check cases based on x
    if x == zero(x)

        y == zero(y) && return emptyinterval(T)
        y.lo ≥ zero(T) && return half_pi(T)
        y.hi ≤ zero(T) && return -half_pi(T)
        return half_range_atan2(T)

    elseif x.lo > zero(T)

        y == zero(y) && return y
        y.lo ≥ zero(T) &&
            return @round(atan2(y.lo, x.hi), atan2(y.hi, x.lo)) # refinement lo bound
        y.hi ≤ zero(T) &&
            return @round(atan2(y.lo, x.lo), atan2(y.hi, x.hi))
        return @round(atan2(y.lo, x.lo), atan2(y.hi, x.lo))

    elseif x.hi < zero(T)

        y == zero(y) && return pi_interval(T)
        y.lo ≥ zero(T) &&
            return @round(atan2(y.hi, x.hi), atan2(y.lo, x.lo))
        y.hi < zero(T) &&
            return @round(atan2(y.hi, x.lo), atan2(y.lo, x.hi))
        return range_atan2(T)

    else # zero(T) ∈ x

        if x.lo == zero(T)
            y == zero(y) && return y

            y.lo ≥ zero(T) && return @round(atan2(y.lo, x.hi), half_range_atan2(BigFloat).hi)

            y.hi ≤ zero(T) && return @round(half_range_atan2(BigFloat).lo, atan2(y.hi, x.hi))
            return half_range_atan2(T)

        elseif x.hi == zero(T)
            y == zero(y) && return pi_interval(T)
            y.lo ≥ zero(T) && return @round(half_pi(BigFloat).lo, atan2(y.lo, x.lo))
            y.hi < zero(T) && return @round(atan2(y.hi, x.lo), -(half_pi(BigFloat).lo))
            return range_atan2(T)
        else
            y.lo ≥ zero(T) &&
                return @round(atan2(y.lo, x.hi), atan2(y.lo, x.lo))
            y.hi < zero(T) &&
                return @round(atan2(y.hi, x.lo), atan2(y.hi, x.hi))
            return range_atan2(T)
        end

    end
end
