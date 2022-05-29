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
            return @round(F, ($f)(inf(a)), ($f)(sup(a)))
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

    alo, ahi = bounds(a)
    ahi > 0 > alo && return entireinterval(a)

    if iszero(ahi)
        return @round(F, -Inf, coth(alo))

    elseif ahi > 0 && iszero(alo)
        return @round(F, coth(ahi), Inf)

    end

    res_lo, res_hi = bounds(@round(F, coth(ahi), coth(alo)))

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

    alo, ahi = bounds(a)
    if alo ≥ 0
        # decreasing function
        return @round(F, sech(ahi), sech(alo))

    elseif ahi ≤ 0
        # increasing function
        return @round(F, sech(alo), sech(ahi))

    else
        return @round(F, min(sech(alo), sech(ahi)), 1)
    end
end

"""
    csch(a::Interval)

Implement the `csch` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function csch(a::F) where {F<:Interval}
    isempty(a) && return a

    isthinzero(a) && return emptyinterval(a)

    alo, ahi = bounds(a)

    if 0 ∈ a
        ahi > 0 > alo && return entireinterval(a)

        if alo == 0
            return @round(F, csch(ahi), Inf)
        else
            return @round(F, -Inf, csch(alo))
        end
    end

    return @round(F, csch(ahi), csch(alo))
end

"""
    acosh(a::Interval)

Implement the `acosh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acosh(a::F) where {F<:Interval}
    domain = F(1, Inf)
    a = a ∩ domain
    isempty(a) && return a

    alo, ahi = bounds(a)
    return @round(F, acosh(alo), acosh(ahi))
end

"""
    atanh(a::Interval)

Implement the `atanh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function atanh(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    alo, ahi = bounds(a)
    res_lo, res_hi = bounds(@round(F, atanh(alo), atanh(ahi)))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞) for set based intervals
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)

    return F(res_lo, res_hi)
end

"""
    acoth(a::Interval)

Implement the `acoth` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acoth(a::F) where {F<:Interval}
    isempty(a) && return a

    domain_excluded = F(-1, 1)

    a ⪽ domain_excluded && return emptyinterval(a)

    !isempty(a ∩ domain_excluded) && return entireinterval(F)

    alo, ahi = bounds(a)
    res_lo, res_hi = bounds(@round(F, acoth(ahi), acoth(alo)))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞) for set based intervals
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)

    return F(res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth)
    @eval function ($f)(a::F) where {F<:Interval{Float64}}
        isempty(a) && return a
        return F(($f)(bigequiv(a)) )
    end
end
