# This file contains the functions described as "Basic arithmetic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3, at the exception of the `sqr` function present in the
# power.jl file

+(a::Interval) = a # not in the IEEE Standard 1788-2015

"""
    +(a::Interval, b::Interval)
    +(a::Interval, b::Real)
    +(a::Real, b::Interval)

Implement the `add` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function +(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    isempty(b) && return b
    return @round(T, inf(a) + inf(b), sup(a) + sup(b))
end

+(a::Interval, b::Interval) = +(promote(a, b)...)

function +(a::Interval{T}, b::T) where {T<:NumTypes}
    isempty(a) && return a
    return @round(T, inf(a) + b, sup(a) + b)
end

+(a::Interval{T}, b::Real) where {T<:NumTypes} = a + interval(T, b)

+(a::Real, b::Interval{T}) where {T<:NumTypes} = b + a

"""
    -(a::Interval)

Implement the `neg` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
-(a::Interval{T}) where {T<:NumTypes} = unsafe_interval(T, -sup(a), -inf(a))

"""
    -(a::Interval, b::Interval)
    -(a::Interval, b::Real)
    -(a::Real, b::Interval)

Implement the `sub` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function -(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    isempty(b) && return b
    return @round(T, inf(a) - sup(b), sup(a) - inf(b))
end

-(a::Interval, b::Interval) = -(promote(a, b)...)

function -(a::Interval{T}, b::T) where {T<:NumTypes}
    isempty(a) && return a
    return @round(T, inf(a) - b, sup(a) - b)
end

function -(b::T, a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    return @round(T, b - sup(a), b - inf(a))
end

-(a::Interval{T}, b::Real) where {T<:NumTypes} = a - interval(T, b)

-(a::Real, b::Interval{T}) where {T<:NumTypes} = interval(T, a) - b

"""
    unsafe_scale(a::Interval, α)

Multiply an interval by a positive scalar. For efficiency, does not check that
the constant is positive.
"""
unsafe_scale(a::Interval{T}, α::T) where {T<:NumTypes} = @round(T, inf(a) * α, sup(a) * α)

"""
    *(a::Interval, b::Interval)
    *(a::Interval, b::Real)
    *(a::Real, b::Interval)

Implement the `mul` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of the multiplication is flavor dependent for some edge cases.
"""
function *(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    isempty(b) && return b
    isthinzero(a) && return a
    isthinzero(b) && return b
    isbounded(a) && isbounded(b) && return mult(*, a, b)
    return mult((x, y, r) -> unbounded_mult(T, x, y, r), a, b)
end

*(a::Interval, b::Interval) = *(promote(a, b)...)

function *(a::Interval{T}, b::T) where {T<:NumTypes}
    (isempty(a) || isthinzero(a) || isone(b)) && return a
    if b ≥ 0
        return @round(T, inf(a) * b, sup(a) * b)
    else
        return @round(T, sup(a) * b, inf(a) * b)
    end
end

*(a::Interval{T}, b::Real) where {T<:NumTypes} = a * interval(T, b)

*(a::Real, b::Interval{T}) where {T<:NumTypes} = b * a

# helper functions for multiplication
function unbounded_mult(::Type{T}, x::T, y::T, r::RoundingMode) where {T<:NumTypes}
    iszero(x) && return sign(y) * zero_times_infinity(T)
    iszero(y) && return sign(x) * zero_times_infinity(T)
    return *(x, y, r)
end

function mult(op, a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    if inf(b) ≥ 0
        inf(a) ≥ 0 && return @round(T, op(inf(a), inf(b)), op(sup(a), sup(b)))
        sup(a) ≤ 0 && return @round(T, op(inf(a), sup(b)), op(sup(a), inf(b)))
        return @round(T, inf(a)*sup(b), sup(a)*sup(b)) # 0 ∈ a
    elseif sup(b) ≤ 0
        inf(a) ≥ 0 && return @round(T, op(sup(a), inf(b)), op(inf(a), sup(b)))
        sup(a) ≤ 0 && return @round(T, op(sup(a), sup(b)), op(inf(a), inf(b)))
        return @round(T, sup(a)*inf(b), inf(a)*inf(b)) # 0 ∈ a
    else
        inf(a) > 0 && return @round(T, op(sup(a), inf(b)), op(sup(a), sup(b)))
        sup(a) < 0 && return @round(T, op(inf(a), sup(b)), op(inf(a), inf(b)))
        return @round(T, min( op(inf(a), sup(b)), op(sup(a), inf(b)) ),
                         max( op(inf(a), inf(b)), op(sup(a), sup(b)) ))
    end
end

"""
    /(a::Interval, b::Interval)
    /(a::Interval, b::Real)
    /(a::Real, b::Interval)

Implement the `div` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of the division is flavor dependent for some edge cases.
"""
function /(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    isempty(b) && return b
    isthinzero(b) && return div_by_thin_zero(a)
    if inf(b) > 0 # b strictly positive
        inf(a) ≥ 0 && return @round(T, inf(a)/sup(b), sup(a)/inf(b))
        sup(a) ≤ 0 && return @round(T, inf(a)/inf(b), sup(a)/sup(b))
        return @round(T, inf(a)/inf(b), sup(a)/inf(b)) # 0 ∈ a
    elseif sup(b) < 0 # b strictly negative
        inf(a) ≥ 0 && return @round(T, sup(a)/sup(b), inf(a)/inf(b))
        sup(a) ≤ 0 && return @round(T, sup(a)/inf(b), inf(a)/sup(b))
        return @round(T, sup(a)/sup(b), inf(a)/sup(b)) # 0 ∈ a
    else # 0 ∈ b
        isthinzero(a) && return a
        if iszero(inf(b))
            inf(a) ≥ 0 && return @round(T, inf(a)/sup(b), typemax(T))
            sup(a) ≤ 0 && return @round(T, typemin(T), sup(a)/sup(b))
            return entireinterval(T)
        elseif sup(b) == 0
            inf(a) ≥ 0 && return @round(T, typemin(T), inf(a)/inf(b))
            sup(a) ≤ 0 && return @round(T, sup(a)/inf(b), typemax(T))
            return entireinterval(T)
        else
            return entireinterval(T)
        end
    end
end

/(a::Interval, b::Interval) = /(promote(a, b)...)

function /(a::Interval{T}, b::T) where {T<:NumTypes}
    isempty(a) && return a
    iszero(b) && return div_by_thin_zero(a)
    if b ≥ 0
        return @round(T, inf(a)/b, sup(a)/b)
    else
        return @round(T, sup(a)/b, inf(a)/b)
    end
end

/(a::Interval{T}, b::Real) where {T<:NumTypes} = a / interval(T, b)

/(a::Real, b::Interval{T}) where {T<:NumTypes} = interval(T, a) / b

"""
    inv(a::Interval)

Implement the `recip` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of the division is flavor dependent for some edge cases.
"""
function inv(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    if 0 ∈ a
        inf(a) < 0 == sup(a) && return @round(T, typemin(T), inv(inf(a)))
        inf(a) == 0 < sup(a) && return @round(T, inv(sup(a)), typemax(T))
        inf(a) < 0 < sup(a) && return entireinterval(T)
        isthinzero(a) && return div_by_thin_zero(one(Interval{T}))
    end
    return @round(T, inv(sup(a)), inv(inf(a)))
end

# rational division
//(a::Interval, b::Interval) = a / b

min_ignore_nans(args...) = minimum(filter(x -> !isnan(x), args))

max_ignore_nans(args...) = maximum(filter(x -> !isnan(x), args))



muladd(a::F, b::F, c::F) where {F<:Interval} = a * b + c

muladd(a::Interval, b::Interval, c::Interval) = muladd(promote(a, b, c)...)

muladd(a::Interval{T}, b::Interval{S}, c::Number) where {T<:NumTypes,S<:NumTypes} = muladd(promote(a, b, interval(promote_numtype(T, S), c))...)
muladd(a::Interval{T}, b::Number, c::Interval{S}) where {T<:NumTypes,S<:NumTypes} = muladd(promote(a, interval(promote_numtype(T, S), b), c)...)
muladd(a::Number, b::Interval{T}, c::Interval{S}) where {T<:NumTypes,S<:NumTypes} = muladd(promote(interval(promote_numtype(T, S), a), b, c)...)

muladd(a::Interval{T}, b::Number, c::Number) where {T<:NumTypes} = muladd(a, interval(T, b), interval(T, c))
muladd(a::Number, b::Interval{T}, c::Number) where {T<:NumTypes} = muladd(interval(T, a), b, interval(T, c))
muladd(a::Number, b::Number, c::Interval{T}) where {T<:NumTypes} = muladd(interval(T, a), interval(T, b), c)

"""
    fma(a::Interval, b::Interval, c::Interval)

Fused multiply-add.

Implement the `fma` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function fma(a::Interval{T}, b::Interval{T}, c::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    isempty(b) && return b
    isempty(c) && return c

    if isentire(a)
        isthinzero(b) && return c
        return entireinterval(T)
    elseif isentire(b)
        isthinzero(a) && return c
        return entireinterval(T)
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

    return unsafe_interval(T, lo, hi)
end

fma(a::Interval, b::Interval, c::Interval) = fma(promote(a, b, c)...)

"""
    sqrt(a::Interval)

Square root of an interval.

Implement the `sqrt` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sqrt(a::Interval{T}) where {T<:NumTypes}
    domain = unsafe_interval(T, zero(T), typemax(T))
    x = a ∩ domain
    isempty(x) && return x
    lo, hi = bounds(x)
    return @round(T, sqrt(lo), sqrt(hi)) # `sqrt` is correctly-rounded
end
