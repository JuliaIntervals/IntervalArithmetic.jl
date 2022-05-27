# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Basic arithmetic functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3, at the exception of the `sqr` function present in the
    "Power functions" file.
=#

+(a::Interval) = a  # Not in the IEEE standard

"""
    -(a::Interval)

Implement the `neg` function of the IEEE Std 1788-2015 (Table 9.1).
"""
-(a::F) where {F<:Interval} = F(-a.hi, -a.lo)


"""
    +(a::Interval, b::Real)
    +(a::Real, a::Interval)
    +(a::Interval, b::Interval)

Implement the `add` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function +(a::F, b::T) where {T, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    return @round(F, a.lo + b, a.hi + b)
end
+(a::Interval{T}, b::S) where {T, S<:Real} = a + Interval{T}(b)
+(b::Real, a::Interval) = a + b

function +(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return @round(F, a.lo + b.lo, a.hi + b.hi)
end

"""
    -(a::Interval, b::Real)
    -(a::Real, a::Interval)
    -(a::Interval, b::Interval)

Implement the `sub` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function -(a::F, b::T) where {T<:Real, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    return @round(F, a.lo - b, a.hi - b)
end

function -(b::T, a::F) where {T, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    return @round(F, b - a.hi, b - a.lo)
end

function -(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return @round(F, a.lo - b.hi, a.hi - b.lo)
end

-(a::F, b::Real) where {F<:Interval} = a - F(b)
-(a::Real, b::F) where {F<:Interval} = F(a) - b

"""
    scale(α, a::Interval)

Multiply an interval by a positive scalar.

For efficiency, does not check that the constant is positive.
"""
@inline scale(α, a::F) where {F<:Interval} = @round(F, α*a.lo, α*a.hi)

"""
    *(a::Interval, b::Real)
    *(a::Real, a::Interval)
    *(a::Interval, b::Interval)

Implement the `mul` function of the IEEE Std 1788-2015 (Table 9.1).

Note: the behavior of the multiplication is flavor dependent for some edge cases.
"""
function *(x::T, a::F) where {T<:Real, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)
    (isthinzero(a) || iszero(x)) && return zero(F)

    if x ≥ 0.0
        return @round(F, a.lo*x, a.hi*x)
    else
        return @round(F, a.hi*x, a.lo*x)
    end
end

*(x::T, a::F) where {T<:Real, S, F<:Interval{S}} = Interval{S}(x) * a
*(a::F, x::T) where {T<:Real, S, F<:Interval{S}} = x*a

function *(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)

    (isthinzero(a) || isthinzero(b)) && return zero(F)

    (isbounded(a) && isbounded(b)) && return mult(*, a, b)

    return mult((x, y, r) -> unbounded_mult(F, x, y, r), a, b)
end


# Helper functions for multiplication
function unbounded_mult(::Type{F}, x::T, y::T, r::RoundingMode) where {T, F<:Interval{T}}
    iszero(x) && return sign(y)*zero_times_infinity(T)
    iszero(y) && return sign(x)*zero_times_infinity(T)
    return *(x, y, r)
end

function mult(op, a::F, b::F) where {T, F<:Interval{T}}
    if b.lo >= zero(T)
        a.lo >= zero(T) && return @round(F, op(a.lo, b.lo), op(a.hi, b.hi))
        a.hi <= zero(T) && return @round(F, op(a.lo, b.hi), op(a.hi, b.lo))
        return @round(F, a.lo*b.hi, a.hi*b.hi)   # when zero(T) ∈ a
    elseif b.hi <= zero(T)
        a.lo >= zero(T) && return @round(F, op(a.hi, b.lo), op(a.lo, b.hi))
        a.hi <= zero(T) && return @round(F, op(a.hi, b.hi), op(a.lo, b.lo))
        return @round(F, a.hi*b.lo, a.lo*b.lo)   # when zero(T) ∈ a
    else
        a.lo > zero(T) && return @round(F, op(a.hi, b.lo), op(a.hi, b.hi))
        a.hi < zero(T) && return @round(F, op(a.lo, b.hi), op(a.lo, b.lo))
        return @round(F, min( op(a.lo, b.hi), op(a.hi, b.lo) ),
                         max( op(a.lo, b.lo), op(a.hi, b.hi) ))
    end
end

"""
    /(a::Interval, b::Real)
    /(a::Real, a::Interval)
    /(a::Interval, b::Interval)

Implement the `div` function of the IEEE Std 1788-2015 (Table 9.1).

Note: the behavior of the division is flavor dependent for some edge cases.
"""
function /(a::F, x::Real) where {F<:Interval}
    isempty(a) && return emptyinterval(T)
    iszero(x) && return div_by_thin_zero(a)

    if x ≥ 0.0
        return @round(F, a.lo/x, a.hi/x)
    else
        return @round(F, a.hi/x, a.lo/x)
    end
end

/(x::Real, a::Interval) = x*inv(a)

function /(a::F, b::F) where {T, F<:Interval{T}}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    isthinzero(b) && return div_by_thin_zero(a)

    if b.lo > zero(T) # b strictly positive
        a.lo >= zero(T) && return @round(F, a.lo/b.hi, a.hi/b.lo)
        a.hi <= zero(T) && return @round(F, a.lo/b.lo, a.hi/b.hi)
        return @round(F, a.lo/b.lo, a.hi/b.lo)  # zero(T) ∈ a

    elseif b.hi < zero(T) # b strictly negative
        a.lo >= zero(T) && return @round(F, a.hi/b.hi, a.lo/b.lo)
        a.hi <= zero(T) && return @round(F, a.hi/b.lo, a.lo/b.hi)
        return @round(F, a.hi/b.hi, a.lo/b.hi)  # zero(T) ∈ a

    else   # b contains zero, but is not zero(b)
        isthinzero(a) && return a

        if iszero(b.lo)
            a.lo >= zero(T) && return @round(F, a.lo/b.hi, T(Inf))
            a.hi <= zero(T) && return @round(F, T(-Inf), a.hi/b.hi)
            return entireinterval(F)

        elseif iszero(b.hi)
            a.lo >= zero(T) && return @round(F, T(-Inf), a.lo/b.lo)
            a.hi <= zero(T) && return @round(F, a.hi/b.lo, T(Inf))
            return entireinterval(F)

        else
            return entireinterval(F)

        end
    end
end

"""
    inv(a::Interval)

Implement the `recip` function of the IEEE Std 1788-2015 (Table 9.1).

Note: the behavior of this function is flavor dependent for some edge cases.
"""
function inv(a::F) where {T, F<:Interval{T}}
    isempty(a) && return emptyinterval(F)

    if zero(T) ∈ a
        a.lo < zero(T) == a.hi && return @round(F, T(-Inf), inv(a.lo))
        a.lo == zero(T) < a.hi && return @round(F, inv(a.hi), T(Inf))
        a.lo < zero(T) < a.hi && return entireinterval(F)
        isthinzero(a) && return div_by_thin_zero(one(F))
    end

    return @round(F, inv(a.hi), inv(a.lo))
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
        lo1 = fma(a.lo, b.lo, c.lo)
        lo2 = fma(a.lo, b.hi, c.lo)
        lo3 = fma(a.hi, b.lo, c.lo)
        lo4 = fma(a.hi, b.hi, c.lo)
        min_ignore_nans(lo1, lo2, lo3, lo4)
    end

    hi = setrounding(T, RoundUp) do
        hi1 = fma(a.lo, b.lo, c.hi)
        hi2 = fma(a.lo, b.hi, c.hi)
        hi3 = fma(a.hi, b.lo, c.hi)
        hi4 = fma(a.hi, b.hi, c.hi)
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

    return @round(F, sqrt(a.lo), sqrt(a.hi))  # `sqrt` is correctly-rounded
end
