# This file is part of the ValidatedNumerics.jl package; MIT licensed

half_pi(::Type{Float64})  = @floatinterval(pi/2)
two_pi(::Type{Float64})   = @floatinterval(2pi)
half_pi(::Type{BigFloat}) = @biginterval(pi/2)
two_pi(::Type{BigFloat})  = @biginterval(2pi)
half_pi{T<:AbstractFloat}(x::T) = half_pi(T)

pi_interval{T<:Real}(::Type{T}) = get_pi(Float64)
range_atan2{T<:Real}(::Type{T}) = Interval(-pi_interval(T).hi, pi_interval(T).hi)
half_range_atan2(::Type{Float64}) = @floatinterval(-pi/2, pi/2)
half_range_atan2(::Type{BigFloat}) = @biginterval(-pi/2, pi/2)
pos_range_atan2{T<:Real}(::Type{T}) = Interval(zero(T), pi_interval(T).hi)

@doc doc"""Finds the quadrant(s) corresponding to a given floating-point
number. The quadrants are labelled as 0 for x ∈ [0, π/2], etc.
For numbers very near a boundary of the quadrant, a tuple of two quadrants
is returned. The minimum or maximum must then be chosen appropriately.

This is a rather indirect way to determine if π/2 and 3π/2 are contained
in the interval; cf. the formula for sine of an interval in
Tucker, *Validated Numerics*.""" ->

function find_quadrants(x::AbstractFloat)
    temp = x / half_pi(x)
    (floor(Int, temp.lo), floor(Int, temp.hi))
end

function sin(a::Interval{Float64})
    isempty(a) && return a
    T = Float64

    whole_range = Interval(-one(T), one(T))

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        a.hi - a.lo > get_pi(T).lo && return whole_range  # in same quadrant but separated by almost 2pi
        lo = Interval(sin(a.lo, RoundDown), sin(a.lo, RoundUp))
        hi = Interval(sin(a.hi, RoundDown), sin(a.hi, RoundUp))
        return hull(lo, hi)

    elseif lo_quadrant==3 && hi_quadrant==0
        return Interval(sin(a.lo, RoundDown), sin(a.hi, RoundUp))

    elseif lo_quadrant==1 && hi_quadrant==2
        return Interval(sin(a.hi, RoundDown), sin(a.lo, RoundUp))

    elseif ( lo_quadrant == 0 || lo_quadrant==3 ) && ( hi_quadrant==1 || hi_quadrant==2 )
        return Interval(min(sin(a.lo, RoundDown), sin(a.hi, RoundDown)), one(T))

    elseif ( lo_quadrant == 1 || lo_quadrant==2 ) && ( hi_quadrant==3 || hi_quadrant==0 )
        return Interval(-one(T), max(sin(a.lo, RoundUp), sin(a.hi, RoundUp)))

    else#if( lo_quadrant == 0 && hi_quadrant==3 ) || ( lo_quadrant == 2 && hi_quadrant==1 )
        return whole_range
    end
end

function sin(a::Interval{BigFloat})
    isempty(a) && return a
    T = BigFloat

    whole_range = Interval(-one(T), one(T))

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        a.hi - a.lo > get_pi(T).lo && return whole_range  # in same quadrant but separated by almost 2pi
        lo = @controlled_round(T, sin(a.lo), sin(a.lo))
        hi = @controlled_round(T, sin(a.hi), sin(a.hi))
        return hull(lo, hi)

    elseif lo_quadrant==3 && hi_quadrant==0
        return @controlled_round(T, sin(a.lo), sin(a.hi))

    elseif lo_quadrant==1 && hi_quadrant==2
        return @controlled_round(T, sin(a.hi), sin(a.lo))

    elseif ( lo_quadrant == 0 || lo_quadrant==3 ) && ( hi_quadrant==1 || hi_quadrant==2 )
        return @controlled_round(T, min(sin(a.lo), sin(a.hi)), one(T))

    elseif ( lo_quadrant == 1 || lo_quadrant==2 ) && ( hi_quadrant==3 || hi_quadrant==0 )
        return @controlled_round(T, -one(T), max(sin(a.lo), sin(a.hi)))

    else#if ( lo_quadrant == 0 && hi_quadrant==3 ) || ( lo_quadrant == 2 && hi_quadrant==1 )
        return whole_range
    end
end


function cos(a::Interval{Float64})
    isempty(a) && return a
    T = Float64

    whole_range = Interval(-one(T), one(T))

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        a.hi - a.lo > get_pi(T).lo && return whole_range
        lo = Interval(cos(a.lo, RoundDown), cos(a.lo, RoundUp))
        hi = Interval(cos(a.hi, RoundDown), cos(a.hi, RoundUp))
        return hull(lo, hi)

    elseif lo_quadrant == 2 && hi_quadrant==3
        return Interval(cos(a.lo, RoundDown), cos(a.hi, RoundUp))

    elseif lo_quadrant == 0 && hi_quadrant==1
        return Interval(cos(a.hi, RoundDown), cos(a.lo, RoundUp))

    elseif ( lo_quadrant == 2 || lo_quadrant==3 ) && ( hi_quadrant==0 || hi_quadrant==1 )
        return Interval(min(cos(a.lo, RoundDown), cos(a.hi, RoundDown)), one(T))

    elseif ( lo_quadrant == 0 || lo_quadrant==1 ) && ( hi_quadrant==2 || hi_quadrant==3 )
        return Interval(-one(T), max(cos(a.lo, RoundUp), cos(a.hi, RoundUp)))

    else#if ( lo_quadrant == 3 && hi_quadrant==2 ) || ( lo_quadrant == 1 && hi_quadrant==0 )
        return whole_range
    end
end

function cos(a::Interval{BigFloat})
    isempty(a) && return a
    T = BigFloat

    whole_range = Interval(-one(T), one(T))

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant = mod(lo_quadrant, 4)
    hi_quadrant = mod(hi_quadrant, 4)

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant # Interval limits in the same quadrant
        a.hi - a.lo > get_pi(T).lo && return whole_range
        lo = @controlled_round(T, cos(a.lo), cos(a.lo))
        hi = @controlled_round(T, cos(a.hi), cos(a.hi))
        return hull(lo, hi)

    elseif lo_quadrant == 2 && hi_quadrant==3
        return @controlled_round(T, cos(a.lo), cos(a.hi))

    elseif lo_quadrant == 0 && hi_quadrant==1
        return @controlled_round(T, cos(a.hi), cos(a.lo))

    elseif ( lo_quadrant == 2 || lo_quadrant==3 ) && ( hi_quadrant==0 || hi_quadrant==1 )
        return @controlled_round(T, min(cos(a.lo), cos(a.hi)), one(T))

    elseif ( lo_quadrant == 0 || lo_quadrant==1 ) && ( hi_quadrant==2 || hi_quadrant==3 )
        return @controlled_round(T, -one(T), max(cos(a.lo), cos(a.hi)))

    else#if ( lo_quadrant == 3 && hi_quadrant==2 ) || ( lo_quadrant == 1 && hi_quadrant==0 )
        return whole_range
    end
end


function tan(a::Interval{Float64})
    isempty(a) && return a
    T = Float64

    diam(a) > get_pi(T).lo && return entireinterval(a)

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if lo_quadrant_mod == 0 && hi_quadrant_mod == 1
        (half_pi(T) ⊆ a || -half_pi(T) ⊆ a) && return entireinterval(a)
    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant > lo_quadrant
        hi_quadrant == lo_quadrant+2 && return entireinterval(a)
    end

    return Interval(tan(a.lo, RoundDown), tan(a.hi, RoundUp))
end

function tan(a::Interval{BigFloat})
    isempty(a) && return a
    T = BigFloat

    diam(a) > get_pi(T).lo && return entireinterval(a)

    lo_quadrant = minimum(find_quadrants(a.lo))
    hi_quadrant = maximum(find_quadrants(a.hi))

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if lo_quadrant_mod == 0 && hi_quadrant_mod == 1
        (half_pi(T) ⊆ a || -half_pi(T) ⊆ a) && return entireinterval(a)
    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant > lo_quadrant
        hi_quadrant == lo_quadrant+2 && return entireinterval(a)
    end

    return @controlled_round(T, tan(a.lo), tan(a.hi))
end


function asin(a::Interval{Float64})
    T = Float64

    domain = Interval(-one(T), one(T))

    a = a ∩ domain

    isempty(a) && return a

    Interval(asin(a.lo, RoundDown), asin(a.hi, RoundUp))
end

function asin(a::Interval{BigFloat})
    T = BigFloat

    domain = Interval(-one(T), one(T))

    a = a ∩ domain

    isempty(a) && return a

    @controlled_round(T, asin(a.lo), asin(a.hi))
end


function acos(a::Interval{Float64})
    T = Float64

    domain = Interval(-one(T), one(T))

    a = a ∩ domain

    isempty(a) && return a

    Interval(acos(a.hi, RoundDown), acos(a.lo, RoundUp))
end

function acos(a::Interval{BigFloat})
    T = BigFloat

    domain = Interval(-one(T), one(T))

    a = a ∩ domain

    isempty(a) && return a

    @controlled_round(T, acos(a.hi), acos(a.lo))
end


function atan(a::Interval{Float64})
    isempty(a) && return a

    Interval(atan(a.lo, RoundDown), atan(a.hi, RoundUp))
end

function atan(a::Interval{BigFloat})
    isempty(a) && return a

    @controlled_round(BigFloat, atan(a.lo), atan(a.hi))
end


atan2{T<:Real, S<:Real}(y::Interval{T}, x::Interval{S}) = atan2(promote(y, x)...)

function atan2(y::Interval{Float64}, x::Interval{Float64})
    (isempty(y) || isempty(x)) && return emptyinterval(Float64)
    res = with_bigfloat_precision(53) do
        atan2( Interval(big(y.lo), big(y.hi)), Interval(big(x.lo), big(x.hi)))
    end
    float(res)
end

function atan2(y::Interval{BigFloat}, x::Interval{BigFloat})
    (isempty(y) || isempty(x)) && return emptyinterval(BigFloat)

    T = BigFloat

    # Prevents some non-sense results whenever y has a zero signed
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
            return @round(T, atan2(y.lo, x.hi), atan2(y.hi, x.lo)) # refinement lo bound
        y.hi ≤ zero(T) &&
            return @round(T, atan2(y.lo, x.lo), atan2(y.hi, x.hi))
        return @round(T, atan2(y.lo, x.lo), atan2(y.hi, x.lo))

    elseif x.hi < zero(T)

        y == zero(y) && return pi_interval(T)
        y.lo ≥ zero(T) &&
            return @round(T, atan2(y.hi, x.hi), atan2(y.lo, x.lo))
        y.hi < zero(T) &&
            return @round(T, atan2(y.hi, x.lo), atan2(y.lo, x.hi))
        return range_atan2(T)

    else # zero(T) ∈ x

        if x.lo == zero(T)
            y == zero(y) && return y
            y.lo ≥ zero(T) &&
                return @round(T, atan2(y.lo, x.hi), half_range_atan2(T).hi)
            y.hi ≤ zero(T) &&
                return @round(T, half_range_atan2(T).lo, atan2(y.hi, x.hi))
            return half_range_atan2(T)
        elseif x.hi == zero(T)
            y == zero(y) && return pi_interval(T)
            y.lo ≥ zero(T) &&
                return @round(T, big(pi)/2, atan2(y.lo, x.lo))
            y.hi < zero(T) &&
                return @round(T, atan2(y.hi, x.lo), big(-pi)/2)
            return range_atan2(T)
        else
            y.lo ≥ zero(T) &&
                return @round(T, atan2(y.lo, x.hi), atan2(y.lo, x.lo))
            y.hi < zero(T) &&
                return @round(T, atan2(y.hi, x.lo), atan2(y.hi, x.hi))
            return range_atan2(T)
        end

    end
end
