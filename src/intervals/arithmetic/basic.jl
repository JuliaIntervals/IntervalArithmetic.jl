# This file contains the functions described as "Basic arithmetic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3



# bare intervals

+(a::BareInterval) = a # not in the IEEE Standard 1788-2015

"""
    +(a::BareInterval, b::BareInterval)

Implement the `add` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function +(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    return @round(T, inf(a) + inf(b), sup(a) + sup(b))
end

+(a::BareInterval, b::BareInterval) = +(promote(a, b)...)

"""
    -(a::BareInterval)

Implement the `neg` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
-(a::BareInterval{T}) where {T<:NumTypes} = _unsafe_bareinterval(T, -sup(a), -inf(a))

"""
    -(a::BareInterval, b::BareInterval)

Implement the `sub` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function -(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    return @round(T, inf(a) - sup(b), sup(a) - inf(b))
end

-(a::BareInterval, b::BareInterval) = -(promote(a, b)...)

"""
    _unsafe_scale(a::BareInterval, α)

Multiply an interval by a positive scalar. For efficiency, does not check that
the constant is positive.
"""
_unsafe_scale(a::BareInterval{T}, α::T) where {T<:NumTypes} = @round(T, inf(a) * α, sup(a) * α)

"""
    *(a::BareInterval, b::BareInterval)

Implement the `mul` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `*` is flavor dependent for some edge cases.
"""
function *(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    isthinzero(a) && return a
    isthinzero(b) && return b
    isbounded(a) && isbounded(b) && return mult(*, a, b)
    return mult((x, y, r) -> unbounded_mult(T, x, y, r), a, b)
end

*(a::BareInterval, b::BareInterval) = *(promote(a, b)...)

# helper functions for multiplication

function unbounded_mult(::Type{T}, x::T, y::T, r::RoundingMode) where {T<:NumTypes}
    iszero(x) && return sign(y) * zero_times_infinity(T)
    iszero(y) && return sign(x) * zero_times_infinity(T)
    return *(x, y, r)
end

function mult(op, a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
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
    /(a::BareInterval, b::BareInterval)

Implement the `div` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `/` is flavor dependent for some edge cases.
"""
function /(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
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
            return entireinterval(BareInterval{T})
        elseif sup(b) == 0
            inf(a) ≥ 0 && return @round(T, typemin(T), inf(a)/inf(b))
            sup(a) ≤ 0 && return @round(T, sup(a)/inf(b), typemax(T))
            return entireinterval(BareInterval{T})
        else
            return entireinterval(BareInterval{T})
        end
    end
end

/(a::BareInterval, b::BareInterval) = /(promote(a, b)...)

"""
    inv(a::BareInterval)

Implement the `recip` function of the IEEE Standard 1788-2015 (Table 9.1).

!!! note
    The behavior of `inv` is flavor dependent for some edge cases.
"""
function inv(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    if in_interval(0, a)
        inf(a) < 0 == sup(a) && return @round(T, typemin(T), inv(inf(a)))
        inf(a) == 0 < sup(a) && return @round(T, inv(sup(a)), typemax(T))
        inf(a) < 0 < sup(a) && return entireinterval(BareInterval{T})
        isthinzero(a) && return div_by_thin_zero(_unsafe_bareinterval(T, one(T), one(T)))
    end
    return @round(T, inv(sup(a)), inv(inf(a)))
end

# rational division

//(a::BareInterval, b::BareInterval) = a / b

#

muladd(a::F, b::F, c::F) where {F<:BareInterval} = a * b + c

muladd(a::BareInterval, b::BareInterval, c::BareInterval) = muladd(promote(a, b, c)...)

"""
    fma(a::BareInterval, b::BareInterval, c::BareInterval)

Implement the `fma` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function fma(a::BareInterval{T}, b::BareInterval{T}, c::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    isempty_interval(c) && return c

    if isentire_interval(a)
        isthinzero(b) && return c
        return entireinterval(BareInterval{T})
    elseif isentire_interval(b)
        isthinzero(a) && return c
        return entireinterval(BareInterval{T})
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

    return _unsafe_bareinterval(T, lo, hi)
end

fma(a::BareInterval, b::BareInterval, c::BareInterval) = fma(promote(a, b, c)...)

min_ignore_nans(args...) = minimum(filter(x -> !isnan(x), args))

max_ignore_nans(args...) = maximum(filter(x -> !isnan(x), args))

"""
    sqrt(a::BareInterval)

Implement the `sqrt` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sqrt(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return @round(T, sqrt(lo), sqrt(hi))
end



# decorated intervals

+(a::Interval) = a

-(a::Interval) = _unsafe_interval(-bareinterval(a), decoration(a), guarantee(a))

for f ∈ (:+, :-, :*)
    @eval begin
        function $f(a::Interval, b::Interval)
            r = $f(bareinterval(a), bareinterval(b))
            d = min(decoration(a), decoration(b), decoration(r))
            t = guarantee(a) & guarantee(b)
            return _unsafe_interval(r, d, t)
        end
        $f(a::Real, b::Interval) = $f(promote(a, b)...)
        $f(a::Interval, b::Real) = $f(promote(a, b)...)
    end
end

function /(a::Interval, b::Interval)
    x = bareinterval(b)
    r = bareinterval(a) / x
    d = min(decoration(a), decoration(b), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    t = guarantee(a) & guarantee(b)
    return _unsafe_interval(r, d, t)
end
/(a::Real, b::Interval) = /(promote(a, b)...)
/(a::Interval, b::Real) = /(promote(a, b)...)

//(a::Interval, b::Interval) = /(a, b)
//(a::Real, b::Interval) = //(promote(a, b)...)
//(a::Interval, b::Real) = //(promote(a, b)...)

function inv(a::Interval)
    x = bareinterval(a)
    r = inv(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, guarantee(a))
end

for f ∈ (:muladd, :fma)
    @eval begin
        function $f(a::Interval, b::Interval, c::Interval)
            r = $f(bareinterval(a), bareinterval(b), bareinterval(c))
            d = min(decoration(a), decoration(b), decoration(c), decoration(r))
            t = guarantee(a) & guarantee(b) & guarantee(c)
            return _unsafe_interval(r, d, t)
        end
        $f(a::Interval, b::Interval, c::Real) = $f(promote(a, b, c)...)
        $f(a::Interval, b::Real, c::Interval) = $f(promote(a, b, c)...)
        $f(a::Real, b::Interval, c::Interval) = $f(promote(a, b, c)...)
        $f(a::Interval, b::Real, c::Real) = $f(promote(a, b, c)...)
        $f(a::Real, b::Interval, c::Real) = $f(promote(a, b, c)...)
        $f(a::Real, b::Real, c::Interval) = $f(promote(a, b, c)...)
    end
end

function sqrt(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, zero(T), typemax(T))
    x = bareinterval(a)
    r = sqrt(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, guarantee(a))
end
