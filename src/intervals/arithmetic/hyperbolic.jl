# This file contains the functions described as "Hyperbolic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3


# Float64 versions of functions missing from CRlibm

for f ∈ (:tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth)
    @eval function $f(a::BareInterval{Float64})
        isempty_interval(a) && return a
        return BareInterval{Float64}($f(_bigequiv(a)))
    end
end

#

for f ∈ (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(a::BareInterval)
            $($f)(a::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function $f(a::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return @round(T, $f(lo), $f(hi))
        end

        function $f(a::Interval)
            r = $f(bareinterval(a))
            d = min(decoration(a), decoration(r))
            return _unsafe_interval(r, d, isguaranteed(a))
        end
    end
end

"""
    cosh(a::BareInterval)
    cosh(a::Interval)

Implement the `cosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function cosh(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    return @round(T, cosh(mig(a)), cosh(mag(a)))
end

function cosh(a::Interval)
    r = cosh(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    coth(a::BareInterval)
    coth(a::Interval)

Implement the `coth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function coth(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isthinzero(a) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(a)
    if lo < 0 < hi
        return entireinterval(BareInterval{T})
    elseif lo == 0
        return @round(T, coth(hi), typemax(T))
    elseif hi == 0
        return @round(T, typemin(T), coth(lo))
    else
        return @round(T, coth(hi), coth(lo))
    end
end

function coth(a::Interval)
    x = bareinterval(a)
    r = coth(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    sech(a::BareInterval)
    sech(a::Interval)

Implement the `sech` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function sech(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    lo, hi = bounds(a)
    if lo ≥ 0 # decreasing function
        return @round(T, sech(hi), sech(lo))
    elseif hi ≤ 0 # increasing function
        return @round(T, sech(lo), sech(hi))
    else
        return @round(T, min(sech(lo), sech(hi)), one(T))
    end
end

function sech(a::Interval)
    r = sech(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    csch(a::BareInterval)
    csch(a::Interval)

Implement the `csch` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function csch(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isthinzero(a) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(a)
    if lo < 0 < hi
        return entireinterval(BareInterval{T})
    elseif lo == 0
        return @round(T, csch(hi), typemax(T))
    elseif hi == 0
        return @round(T, typemin(T), csch(lo))
    else
        return @round(T, csch(hi), csch(lo))
    end
end

function csch(a::Interval)
    x = bareinterval(a)
    r = csch(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    acosh(a::BareInterval)
    acosh(a::Interval)

Implement the `acosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acosh(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return @round(T, acosh(lo), acosh(hi))
end

function acosh(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = bareinterval(a)
    r = acosh(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    atanh(a::BareInterval)
    atanh(a::Interval)

Implement the `atanh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function atanh(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    res_lo, res_hi = bounds(@round(T, atanh(lo), atanh(hi)))
    return bareinterval(T, res_lo, res_hi)
end

function atanh(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = atanh(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isstrictsubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    acoth(a::BareInterval)
    acoth(a::Interval)

Implement the `acoth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acoth(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    singular_domain = _unsafe_bareinterval(T, -one(T), one(T))
    issubset_interval(a, singular_domain) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(a)
    if lo ≤ -1 && 1 ≤ hi
        return entireinterval(BareInterval{T})
    elseif lo < -1 < hi || lo < 1 < hi
        return emptyinterval(BareInterval{T})
    elseif lo == 1
        return @round(T, acoth(hi), typemax(T))
    elseif hi == -1
        return @round(T, typemin(T), acoth(lo))
    else
        return @round(T, acoth(hi), acoth(lo))
    end
end

function acoth(a::Interval{T}) where {T<:NumTypes}
    singular_domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = acoth(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isempty_interval(intersect_interval(x, singular_domain)), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end
