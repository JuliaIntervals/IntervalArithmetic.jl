# This file is part of the IntervalArithmetic.jl package; MIT licensed


# hard code this for efficiency:
const one_over_half_pi_interval = inv(0.5 * pi_interval(Float64))

"""
Multiply an interval by a positive constant.
For efficiency, does not check that the constant is positive.
"""
multiply_by_positive_constant(α, x::Interval) = @round(α*x.lo, α*x.hi)

half_pi(::Type{Float64}) = multiply_by_positive_constant(0.5, pi_interval(Float64))
half_pi(::Type{T}) where {T} = 0.5 * pi_interval(T)
half_pi(x::T) where {T<:AbstractFloat} = half_pi(T)

two_pi(::Type{Float64}) = multiply_by_positive_constant(2.0, pi_interval(Float64))
two_pi(::Type{T}) where {T} = 2 * pi_interval(T)

range_atan(::Type{T}) where {T<:Real} = Interval(-(pi_interval(T).hi), pi_interval(T).hi)
half_range_atan(::Type{T}) where {T} = (temp = half_pi(T); Interval(-(temp.hi), temp.hi) )
pos_range_atan(::Type{T}) where {T<:Real} = Interval(zero(T), pi_interval(T).hi)

const halfpi = pi / 2.0

"""Finds the quadrant(s) corresponding to a given floating-point
number. The quadrants are labelled as 0 for x ∈ [0, π/2], etc.
For numbers very near a boundary of the quadrant, a tuple of two quadrants
is returned. The minimum or maximum must then be chosen appropriately.

This is a rather indirect way to determine if π/2 and 3π/2 are contained
in the interval; cf. the formula for sine of an interval in
Tucker, *Validated Numerics*.
"""
# function find_quadrants(x::T) where {T}
#     temp = atomic(Interval{T}, x) / half_pi(x)
#
#     return SVector(floor(temp.lo), floor(temp.hi))
# end
#
# function find_quadrants(x::Float64)
#     temp = multiply_by_positive_constant(x, one_over_half_pi_interval)
#     # x / half_pi(Float64)
#
#     return SVector(floor(temp.lo), floor(temp.hi))
# end

function quadrant(x::Float64)
    x_mod2pi = rem2pi(x, RoundNearest)  # gives result in [-pi, pi]

    x_mod2pi < -halfpi && return (2, x_mod2pi)
    x_mod2pi < 0 && return (3, x_mod2pi)
    x_mod2pi < halfpi && return (0, x_mod2pi)

    return 1, x_mod2pi
end


function sin(a::Interval{T}) where T
    isempty(a) && return a

    whole_range = Interval{T}(-1, 1)

    diam(a) > two_pi(T).lo && return whole_range

    lo_quadrant, lo = quadrant(a.lo)
    hi_quadrant, hi = quadrant(a.hi)

    lo, hi = a.lo, a.hi  # don't use the modulo version of a

    # Different cases depending on the two quadrants:
    if lo_quadrant == hi_quadrant
        a.hi - a.lo > pi_interval(T).lo && return whole_range  #

        if lo_quadrant == 1 || lo_quadrant == 2
            # negative slope
            return @round(sin(hi), sin(lo))
        else
            return @round(sin(lo), sin(hi))
        end

    elseif lo_quadrant==3 && hi_quadrant==0
        return @round(sin(lo), sin(hi))

    elseif lo_quadrant==1 && hi_quadrant==2
        return @round(sin(hi), sin(lo))

    elseif ( lo_quadrant == 0 || lo_quadrant==3 ) && ( hi_quadrant==1 || hi_quadrant==2 )
        return @round(min(sin(lo), sin(hi)), 1)

    elseif ( lo_quadrant == 1 || lo_quadrant==2 ) && ( hi_quadrant==3 || hi_quadrant==0 )
        return @round(-1, max(sin(lo), sin(hi)))

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

function find_quadrants_tan(x::T) where {T}
    temp = atomic(Interval{T}, x) / half_pi(x)

    return SVector(floor(temp.lo), floor(temp.hi))
end

function tan(a::Interval{T}) where T
    isempty(a) && return a

    diam(a) > pi_interval(T).lo && return entireinterval(a)

    lo_quadrant, lo = quadrant(a.lo)
    hi_quadrant, hi = quadrant(a.hi)

    lo_quadrant_mod = mod(lo_quadrant, 2)
    hi_quadrant_mod = mod(hi_quadrant, 2)

    if lo_quadrant_mod == 0 && hi_quadrant_mod == 1
        return entireinterval(a)  # crosses singularity

    elseif lo_quadrant_mod == hi_quadrant_mod && hi_quadrant != lo_quadrant
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


#atan{T<:Real, S<:Real}(y::Interval{T}, x::Interval{S}) = atan(promote(y, x)...)

function atan(y::Interval{Float64}, x::Interval{Float64})
    (isempty(y) || isempty(x)) && return emptyinterval(Float64)

    atomic(Interval{Float64}, atan(big53(y), big53(x)))
end


function atan(y::Interval{BigFloat}, x::Interval{BigFloat})
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
        return half_range_atan(T)

    elseif x.lo > zero(T)

        y == zero(y) && return y
        y.lo ≥ zero(T) &&
            return @round(atan(y.lo, x.hi), atan(y.hi, x.lo)) # refinement lo bound
        y.hi ≤ zero(T) &&
            return @round(atan(y.lo, x.lo), atan(y.hi, x.hi))
        return @round(atan(y.lo, x.lo), atan(y.hi, x.lo))

    elseif x.hi < zero(T)

        y == zero(y) && return pi_interval(T)
        y.lo ≥ zero(T) &&
            return @round(atan(y.hi, x.hi), atan(y.lo, x.lo))
        y.hi < zero(T) &&
            return @round(atan(y.hi, x.lo), atan(y.lo, x.hi))
        return range_atan(T)

    else # zero(T) ∈ x

        if x.lo == zero(T)
            y == zero(y) && return y

            y.lo ≥ zero(T) && return @round(atan(y.lo, x.hi), half_range_atan(BigFloat).hi)

            y.hi ≤ zero(T) && return @round(half_range_atan(BigFloat).lo, atan(y.hi, x.hi))
            return half_range_atan(T)

        elseif x.hi == zero(T)
            y == zero(y) && return pi_interval(T)
            y.lo ≥ zero(T) && return @round(half_pi(BigFloat).lo, atan(y.lo, x.lo))
            y.hi < zero(T) && return @round(atan(y.hi, x.lo), -(half_pi(BigFloat).lo))
            return range_atan(T)
        else
            y.lo ≥ zero(T) &&
                return @round(atan(y.lo, x.hi), atan(y.lo, x.lo))
            y.hi < zero(T) &&
                return @round(atan(y.hi, x.lo), atan(y.hi, x.hi))
            return range_atan(T)
        end

    end
end
