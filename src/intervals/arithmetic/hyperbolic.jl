# This file contains the functions described as "Hyperbolic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

# Float64 versions of functions missing from CRlibm

for f ∈ (:tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth)
    @eval function Base.$f(a::BareInterval{Float64})
        isempty_interval(a) && return a
        return BareInterval{Float64}($f(_bigequiv(a)))
    end
end

#

for f ∈ (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(::BareInterval)
            $($f)(::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function Base.$f(a::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return @round(T, $f(lo), $f(hi))
        end

        function Base.$f(a::Interval)
            r = $f(bareinterval(a))
            d = min(decoration(a), decoration(r))
            return _unsafe_interval(r, d, isguaranteed(a))
        end
    end
end

"""
    cosh(::BareInterval)
    cosh(::Interval)

Implement the `cosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cosh(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    return @round(T, cosh(mig(a)), cosh(mag(a)))
end

function Base.cosh(a::Interval)
    r = cosh(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    coth(::BareInterval)
    coth(::Interval)

Implement the `coth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.coth(a::BareInterval{T}) where {T<:NumTypes}
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

function Base.coth(a::Interval)
    x = bareinterval(a)
    r = coth(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    sech(::BareInterval)
    sech(::Interval)

Implement the `sech` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sech(a::BareInterval{T}) where {T<:NumTypes}
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

function Base.sech(a::Interval)
    r = sech(bareinterval(a))
    d = min(decoration(a), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    csch(::BareInterval)
    csch(::Interval)

Implement the `csch` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.csch(a::BareInterval{T}) where {T<:NumTypes}
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

function Base.csch(a::Interval)
    x = bareinterval(a)
    r = csch(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(in_interval(0, x), trv, d))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    acosh(::BareInterval)
    acosh(::Interval)

Implement the `acosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acosh(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return @round(T, acosh(lo), acosh(hi))
end

function Base.acosh(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = bareinterval(a)
    r = acosh(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(issubset_interval(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    atanh(::BareInterval)
    atanh(::Interval)

Implement the `atanh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atanh(a::BareInterval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(a, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    res_lo, res_hi = bounds(@round(T, atanh(lo), atanh(hi)))
    return bareinterval(T, res_lo, res_hi)
end

function Base.atanh(a::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = atanh(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isinterior(x, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end

"""
    acoth(::BareInterval)
    acoth(::Interval)

Implement the `acoth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acoth(a::BareInterval{T}) where {T<:NumTypes}
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

function Base.acoth(a::Interval{T}) where {T<:NumTypes}
    singular_domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = bareinterval(a)
    r = acoth(x)
    d = min(decoration(a), decoration(r))
    d = min(d, ifelse(isempty_interval(intersect_interval(x, singular_domain)), d, trv))
    return _unsafe_interval(r, d, isguaranteed(a))
end
