# This file contains the functions described as "Hyperbolic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3



# bare intervals

for f ∈ (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(a::BareInterval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function $f(a::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return @round(T, $f(lo), $f(hi))
        end
    end
end

"""
    cosh(a::BareInterval)

Implement the `cosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function cosh(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    return @round(T, cosh(mig(a)), cosh(mag(a)))
end

"""
    coth(a::BareInterval)

Implement the `coth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function coth(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isthinzero(a) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(a)
    if hi > 0 > lo
        return entireinterval(BareInterval{T})
    elseif hi == 0
        return @round(T, typemin(T), coth(lo))
    elseif hi > 0 && lo == 0
        return @round(T, coth(hi), typemax(T))
    else
        res_lo, res_hi = bounds(@round(T, coth(hi), coth(lo)))
        return bareinterval(T, res_lo, res_hi)
    end
end

"""
    sech(a::BareInterval)

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

"""
    csch(a::BareInterval)

Implement the `csch` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function csch(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isthinzero(a) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(a)
    if in_interval(0, a)
        if hi > 0 > lo
            return entireinterval(BareInterval{T})
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
    acosh(a::BareInterval)

Implement the `acosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acosh(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return @round(T, acosh(lo), acosh(hi))
end

"""
    atanh(a::BareInterval)

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

"""
    acoth(a::BareInterval)

Implement the `acoth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function acoth(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    domain_excluded = _unsafe_bareinterval(T, -one(T), one(T))
    isstrictsubset_interval(a, domain_excluded) && return emptyinterval(BareInterval{T})
    !isempty_interval(intersect_interval(a, domain_excluded)) && return entireinterval(BareInterval{T})
    lo, hi = bounds(a)
    res_lo, res_hi = bounds(@round(T, acoth(hi), acoth(lo)))
    return bareinterval(T, res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm
for f ∈ (:tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth)
    @eval function $f(a::BareInterval{Float64})
        isempty_interval(a) && return a
        return BareInterval{Float64}($f(_bigequiv(a)))
    end
end



# decorated intervals

for f ∈ (:sinh, :cosh, :tanh, :asinh)
    @eval function $f(a::Interval)
        r = $f(bareinterval(a))
        d = min(decoration(a), decoration(r))
        return _unsafe_interval(r, d)
    end
end

function atanh(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = atanh(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isstrictsubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d)
end

function acosh(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = bareinterval(a)
    r = acosh(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d)
end
