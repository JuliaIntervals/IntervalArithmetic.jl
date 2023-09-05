# This file contains the functions described as "Hyperbolic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

for f in (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(a::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function ($f)(a::Interval{T}) where {T<:NumTypes}
            isemptyinterval(a) && return a
            lo, hi = bounds(a)
            return @round(T, ($f)(lo), ($f)(hi))
        end
    end
end

"""
    cosh(a::Interval)

Implement the `cosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function cosh(a::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    return @round(T, cosh(mig(a)), cosh(mag(a)))
end

"""
    coth(a::Interval)

Implement the `coth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function coth(a::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    isthinzero(a) && return emptyinterval(T)
    lo, hi = bounds(a)
    if hi > 0 > lo
        return entireinterval(T)
    elseif hi == 0
        return @round(T, typemin(T), coth(lo))
    elseif hi > 0 && lo == 0
        return @round(T, coth(hi), typemax(T))
    else
        res_lo, res_hi = bounds(@round(T, coth(hi), coth(lo)))
        return interval(T, res_lo, res_hi)
    end
end

"""
    sech(a::Interval)

Implement the `sech` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sech(a::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    lo, hi = bounds(a)
    if lo ≥ 0 # decreasing function
        return @round(T, sech(hi), sech(lo))
    elseif hi ≤ 0 # increasing function
        return @round(T, sech(lo), sech(hi))
    else
        return @round(T, min(sech(lo), sech(hi)), one(T))
    end
end

"""
    csch(a::Interval)

Implement the `csch` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function csch(a::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    isthinzero(a) && return emptyinterval(T)
    lo, hi = bounds(a)
    if ismember(0, a)
        if hi > 0 > lo
            return entireinterval(T)
        elseif lo == 0
            return @round(T, csch(hi), typemax(T))
        else
            return @round(T, typemin(T), csch(lo))
        end
    else
        return @round(T, csch(hi), csch(lo))
    end
end

"""
    acosh(a::Interval)

Implement the `acosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acosh(a::Interval{T}) where {T<:NumTypes}
    domain = unsafe_interval(T, one(T), typemax(T))
    x = intersectinterval(a, domain)
    isemptyinterval(x) && return x
    lo, hi = bounds(x)
    return @round(T, acosh(lo), acosh(hi))
end

"""
    atanh(a::Interval)

Implement the `atanh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function atanh(a::Interval{T}) where {T<:NumTypes}
    domain = unsafe_interval(T, -one(T), one(T))
    x = intersectinterval(a, domain)
    isemptyinterval(x) && return x
    lo, hi = bounds(x)
    res_lo, res_hi = bounds(@round(T, atanh(lo), atanh(hi)))
    return interval(T, res_lo, res_hi)
end

"""
    acoth(a::Interval)

Implement the `acoth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acoth(a::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    domain_excluded = unsafe_interval(T, -one(T), one(T))
    interior(a, domain_excluded) && return emptyinterval(T)
    !isemptyinterval(intersectinterval(a, domain_excluded)) && return entireinterval(T)
    lo, hi = bounds(a)
    res_lo, res_hi = bounds(@round(T, acoth(hi), acoth(lo)))
    return interval(T, res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm
for f in (:tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth)
    @eval function ($f)(a::Interval{Float64})
        isemptyinterval(a) && return a
        return Interval{Float64}(($f)(bigequiv(a)))
    end
end
