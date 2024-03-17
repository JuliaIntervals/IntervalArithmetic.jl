# This file contains the functions described as "Hyperbolic functions" in
# Section 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor
# in Section 10.5.3

for f ∈ (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(::BareInterval)
            $($f)(::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function Base.$f(x::BareInterval{T}) where {T<:AbstractFloat}
            isempty_interval(x) && return x
            return @round(T, $f(inf(x)), $f(sup(x)))
        end

        Base.$f(x::BareInterval{<:Rational}) = $f(float(x))

        function Base.$f(x::Interval)
            r = $f(bareinterval(x))
            d = min(decoration(x), decoration(r))
            return _unsafe_interval(r, d, isguaranteed(x))
        end
    end
end

Base.sinh(x::Complex{Interval{T}}) where {T<:NumTypes} = (exp(x) - exp(-x)) / interval(T, 2)

Base.tanh(x::Complex{<:Interval}) = sinh(x) / cosh(x)

"""
    cosh(::BareInterval)
    cosh(::Interval)

Implement the `cosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.cosh(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    return @round(T, cosh(mig(x)), cosh(mag(x)))
end

Base.cosh(x::BareInterval{<:Rational}) = cosh(float(x))

function Base.cosh(x::Interval)
    r = cosh(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.cosh(x::Complex{Interval{T}}) where {T<:NumTypes} = (exp(x) + exp(-x)) / interval(T, 2)

"""
    coth(::BareInterval)
    coth(::Interval)

Implement the `coth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.coth(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    isthinzero(x) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(x)
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

Base.coth(x::BareInterval{<:Rational}) = coth(float(x))

function Base.coth(x::Interval)
    bx = bareinterval(x)
    r = coth(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(in_interval(0, bx), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    sech(::BareInterval)
    sech(::Interval)

Implement the `sech` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sech(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    if lo ≥ 0 # decreasing function
        return @round(T, sech(hi), sech(lo))
    elseif hi ≤ 0 # increasing function
        return @round(T, sech(lo), sech(hi))
    else
        return @round(T, min(sech(lo), sech(hi)), one(T))
    end
end

Base.sech(x::BareInterval{<:Rational}) = sech(float(x))

function Base.sech(x::Interval)
    r = sech(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    csch(::BareInterval)
    csch(::Interval)

Implement the `csch` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.csch(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    isthinzero(x) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(x)
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

Base.csch(x::BareInterval{<:Rational}) = csch(float(x))

function Base.csch(x::Interval)
    bx = bareinterval(x)
    r = csch(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(in_interval(0, bx), trv, d))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    acosh(::BareInterval)
    acosh(::Interval)

Implement the `acosh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acosh(x::BareInterval{T}) where {T<:AbstractFloat}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    return @round(T, acosh(inf(x)), acosh(sup(x)))
end

Base.acosh(x::BareInterval{<:Rational}) = acosh(float(x))

function Base.acosh(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, one(T), typemax(T))
    bx = bareinterval(x)
    r = acosh(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(issubset_interval(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    atanh(::BareInterval)
    atanh(::Interval)

Implement the `atanh` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.atanh(x::BareInterval{T}) where {T<:AbstractFloat}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    x = intersect_interval(x, domain)
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    res_lo, res_hi = bounds(@round(T, atanh(lo), atanh(hi)))
    return bareinterval(T, res_lo, res_hi)
end

Base.atanh(x::BareInterval{<:Rational}) = atanh(float(x))

function Base.atanh(x::Interval{T}) where {T<:NumTypes}
    domain = _unsafe_bareinterval(T, -one(T), one(T))
    bx = bareinterval(x)
    r = atanh(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isinterior(bx, domain), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    acoth(::BareInterval)
    acoth(::Interval)

Implement the `acoth` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.acoth(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return x
    singular_domain = _unsafe_bareinterval(T, -one(T), one(T))
    issubset_interval(x, singular_domain) && return emptyinterval(BareInterval{T})
    lo, hi = bounds(x)
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

Base.acoth(x::BareInterval{<:Rational}) = acoth(float(x))

function Base.acoth(x::Interval{T}) where {T<:NumTypes}
    singular_domain = _unsafe_bareinterval(T, -one(T), one(T))
    bx = bareinterval(x)
    r = acoth(bx)
    d = min(decoration(x), decoration(r))
    d = min(d, ifelse(isempty_interval(intersect_interval(bx, singular_domain)), d, trv))
    return _unsafe_interval(r, d, isguaranteed(x))
end
