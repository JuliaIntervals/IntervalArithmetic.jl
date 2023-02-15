# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Basic arithmetic functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3, at the exception of the `sqr` function present in the
    "Power functions" file.
=#

+(a::Interval) = a  # Not in the IEEE standard

"""
    +(a::Interval, b::Real)
    +(a::Real, b::Interval)
    +(a::Interval, b::Interval)

Implement the `add` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function +(a::F, b::T) where {T, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    return @round(F, inf(a) + b, sup(a) + b)
end
+(a::Interval{T}, b::Real) where {T} = a + interval(T, b)
+(a::Real, b::Interval{T}) where {T} = b + a

function +(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return @round(F, inf(a) + inf(b), sup(a) + sup(b))
end
+(a::Interval, b::Interval) = +(promote(a, b)...)

"""
    -(a::Interval)

Implement the `neg` function of the IEEE Std 1788-2015 (Table 9.1).
"""
-(a::F) where {F<:Interval} = F(-sup(a), -inf(a))

"""
    -(a::Interval, b::Real)
    -(a::Real, b::Interval)
    -(a::Interval, b::Interval)

Implement the `sub` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function -(a::F, b::T) where {T<:Real, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    return @round(F, inf(a) - b, sup(a) - b)
end
function -(b::T, a::F) where {T, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    return @round(F, b - sup(a), b - inf(a))
end
-(a::Interval{T}, b::Real) where {T} = a - interval(T, b)
-(a::Real, b::Interval{T}) where {T} = interval(T, a) - b

function -(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return @round(F, inf(a) - sup(b), sup(a) - inf(b))
end
-(a::Interval, b::Interval) = -(promote(a, b)...)

"""
    scale(α, a::Interval)

Multiply an interval by a positive scalar.

For efficiency, does not check that the constant is positive.
"""
@inline scale(α, a::F) where {F<:Interval} = @round(F, α*inf(a), α*sup(a))

"""
    *(a::Interval, b::Real)
    *(a::Real, b::Interval)
    *(a::Interval, b::Interval)

Implement the `mul` function of the IEEE Std 1788-2015 (Table 9.1).

Note: the behavior of the multiplication is flavor dependent for some edge cases.
"""
function *(a::F, b::T) where {T<:Real, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    (isthinzero(a) || iszero(b)) && return zero(F)

    if b ≥ 0.0
        return @round(F, inf(a)*b, sup(a)*b)
    else
        return @round(F, sup(a)*b, inf(a)*b)
    end
end
*(a::Interval{T}, b::Real) where {T} = a * interval(T, b)
*(a::Real, b::Interval{T}) where {T} = b * a

function *(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    (isthinzero(a) || isthinzero(b)) && return zero(F)
    (isbounded(a) && isbounded(b)) && return mult(*, a, b)
    return mult((x, y, r) -> unbounded_mult(F, x, y, r), a, b)
end
*(a::Interval, b::Interval) = *(promote(a, b)...)

# Helper functions for multiplication
function unbounded_mult(::Type{F}, x::T, y::T, r::RoundingMode) where {T, F<:Interval{T}}
    iszero(x) && return sign(y) * zero_times_infinity(T)
    iszero(y) && return sign(x) * zero_times_infinity(T)
    return *(x, y, r)
end

function mult(op, a::F, b::F) where {T, F<:Interval{T}}
    if inf(b) >= zero(T)
        inf(a) >= zero(T) && return @round(F, op(inf(a), inf(b)), op(sup(a), sup(b)))
        sup(a) <= zero(T) && return @round(F, op(inf(a), sup(b)), op(sup(a), inf(b)))
        return @round(F, inf(a)*sup(b), sup(a)*sup(b))   # zero(T) ∈ a
    elseif sup(b) <= zero(T)
        inf(a) >= zero(T) && return @round(F, op(sup(a), inf(b)), op(inf(a), sup(b)))
        sup(a) <= zero(T) && return @round(F, op(sup(a), sup(b)), op(inf(a), inf(b)))
        return @round(F, sup(a)*inf(b), inf(a)*inf(b))   # zero(T) ∈ a
    else
        inf(a) > zero(T) && return @round(F, op(sup(a), inf(b)), op(sup(a), sup(b)))
        sup(a) < zero(T) && return @round(F, op(inf(a), sup(b)), op(inf(a), inf(b)))
        return @round(F, min( op(inf(a), sup(b)), op(sup(a), inf(b)) ),
                         max( op(inf(a), inf(b)), op(sup(a), sup(b)) ))
    end
end

"""
    /(a::Interval, b::Real)
    /(a::Real, b::Interval)
    /(a::Interval, b::Interval)

Implement the `div` function of the IEEE Std 1788-2015 (Table 9.1).

Note: the behavior of the division is flavor dependent for some edge cases.
"""
function /(a::F, b::Real) where {F<:Interval}
    isempty(a) && return emptyinterval(T)
    iszero(b) && return div_by_thin_zero(a)

    if b ≥ 0
        return @round(F, inf(a)/b, sup(a)/b)
    else
        return @round(F, sup(a)/b, inf(a)/b)
    end
end

/(a::Real, b::Interval) = a * inv(b)

function /(a::F, b::F) where {T, F<:Interval{T}}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    isthinzero(b) && return div_by_thin_zero(a)

    if inf(b) > zero(T) # b strictly positive
        inf(a) >= zero(T) && return @round(F, inf(a)/sup(b), sup(a)/inf(b))
        sup(a) <= zero(T) && return @round(F, inf(a)/inf(b), sup(a)/sup(b))
        return @round(F, inf(a)/inf(b), sup(a)/inf(b))  # zero(T) ∈ a

    elseif sup(b) < zero(T) # b strictly negative
        inf(a) >= zero(T) && return @round(F, sup(a)/sup(b), inf(a)/inf(b))
        sup(a) <= zero(T) && return @round(F, sup(a)/inf(b), inf(a)/sup(b))
        return @round(F, sup(a)/sup(b), inf(a)/sup(b))  # zero(T) ∈ a

    else   # b contains zero, but is not zero(b)
        isthinzero(a) && return a

        if iszero(inf(b))
            inf(a) >= zero(T) && return @round(F, inf(a)/sup(b), T(Inf))
            sup(a) <= zero(T) && return @round(F, T(-Inf), sup(a)/sup(b))
            return entireinterval(F)

        elseif iszero(sup(b))
            inf(a) >= zero(T) && return @round(F, T(-Inf), inf(a)/inf(b))
            sup(a) <= zero(T) && return @round(F, sup(a)/inf(b), T(Inf))
            return entireinterval(F)

        else
            return entireinterval(F)

        end
    end
end
/(a::Interval, b::Interval) = /(promote(a, b)...)

"""
    inv(a::Interval)

Implement the `recip` function of the IEEE Std 1788-2015 (Table 9.1).

Note: the behavior of this function is flavor dependent for some edge cases.
"""
function inv(a::F) where {T, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)

    if zero(T) ∈ a
        inf(a) < zero(T) == sup(a) && return @round(F, T(-Inf), inv(inf(a)))
        inf(a) == zero(T) < sup(a) && return @round(F, inv(sup(a)), T(Inf))
        inf(a) < zero(T) < sup(a) && return entireinterval(F)
        isthinzero(a) && return div_by_thin_zero(one(F))
    end

    return @round(F, inv(sup(a)), inv(inf(a)))
end

# Rational division
//(a::Interval, b::Interval) = a / b

function min_ignore_nans(args...)
    min(Iterators.filter(x->!isnan(x), args)...)
end

function max_ignore_nans(args...)
    max(Iterators.filter(x->!isnan(x), args)...)
end

"""
    fma(a::Interval, b::Interval, c::Interval)

Fused multiply-add.

Implement the `fma` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function fma(a::F, b::F, c::F) where {T, F<:Interval{T}}
    (isempty(a) || isempty(b) || isempty(c)) && return emptyinterval(F)

    if isentire(a)
        isthinzero(b) && return c
        return entireinterval(F)
    elseif isentire(b)
        isthinzero(a) && return c
        return entireinterval(F)
    end

    lo = setrounding(T, RoundDown) do
        lo1 = fma(inf(a), inf(b), inf(c))
        lo2 = fma(inf(a), sup(b), inf(c))
        lo3 = fma(sup(a), inf(b), inf(c))
        lo4 = fma(sup(a), sup(b), inf(c))
        min_ignore_nans(lo1, lo2, lo3, lo4)
    end

    hi = setrounding(T, RoundUp) do
        hi1 = fma(inf(a), inf(b), sup(c))
        hi2 = fma(inf(a), sup(b), sup(c))
        hi3 = fma(sup(a), inf(b), sup(c))
        hi4 = fma(sup(a), sup(b), sup(c))
        max_ignore_nans(hi1, hi2, hi3, hi4)
    end

    return F(lo, hi)
end

"""
    sqrt(a::Interval)

Square root of an interval.

Implement the `sqrt` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function sqrt(a::F) where {F<:Interval}
    domain = F(0, Inf)
    a = a ∩ domain

    isempty(a) && return a

    return @round(F, sqrt(inf(a)), sqrt(sup(a)))  # `sqrt` is correctly-rounded
end
