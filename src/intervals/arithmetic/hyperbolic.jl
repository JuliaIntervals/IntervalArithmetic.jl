# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Hyperbolic functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3.
=#
for f in (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(a::Interval)

        Implement the `$($f)` function of the IEEE Std 1788-2015 (Table 9.1).
        """
        function ($f)(a::F) where {F<:Interval}
            isempty(a) && return a
            return @round(F, ($f)(a.lo), ($f)(a.hi))
        end
    end
end

"""
    cosh(a::Interval)

Implement the `cosh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function cosh(a::F) where {F<:Interval}
    isempty(a) && return a

    return @round(F, cosh(mig(a)), cosh(mag(a)))
end

"""
    coth(a::Interval)

Implement the `coth` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function coth(a::F) where {F<:Interval}
    isempty(a) && return a

    isthinzero(a) && return emptyinterval(a)

    a.hi > 0 > a.lo && return entireinterval(a)

    if iszero(a.hi)
        return @round(F, -Inf, coth(a.lo))

    elseif a.hi > 0 && iszero(a.lo)
        return @round(F, coth(a.hi), Inf)

    end

    res_lo, res_hi = bounds(@round(F, coth(a.hi), coth(a.lo)))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞) for set based intervals
    isinf(res_lo) && isinf(res_hi) && return emptyinterval(a)

    return F(res_lo, res_hi)
end

"""
    sech(a::Interval)

Implement the `sech` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function sech(a::F) where {F<:Interval}
    isempty(a) && return a

    if a.lo ≥ 0
        # decreasing function
        return @round(F, sech(a.hi), sech(a.lo))

    elseif a.hi ≤ 0
        # increasing function
        return @round(F, sech(a.lo), sech(a.hi))

    else
        return @round(F, min(sech(a.lo), sech(a.hi)), 1)
    end
end

"""
    csch(a::Interval)

Implement the `csch` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function csch(a::F) where {F<:Interval}
    isempty(a) && return a

    isthinzero(a) && return emptyinterval(a)

    if 0 ∈ a
        a.hi > 0 > a.lo && return entireinterval(a)

        if a.lo == 0
            return @round(F, csch(a.hi), Inf)
        else
            return @round(F, -Inf, csch(a.lo))
        end
    end

    return @round(F, csch(a.hi), csch(a.lo))
end

"""
    acosh(a::Interval)

Implement the `acosh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acosh(a::F) where {F<:Interval}
    domain = F(1, Inf)
    a = a ∩ domain
    isempty(a) && return a

    return @round(F, acosh(a.lo), acosh(a.hi))
end

"""
    atanh(a::Interval)

Implement the `atanh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function atanh(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    res_lo, res_hi = bounds(@round(F, atanh(a.lo), atanh(a.hi)))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞) for set based intervals
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)

    return F(res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh)
    @eval function ($f)(a::F) where {F<:Interval{Float64}}
        isempty(a) && return a
        return F(($f)(bigequiv(a)) )
    end
end
