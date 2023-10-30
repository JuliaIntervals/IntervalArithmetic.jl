# This file contains the functions described as "Absmax functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3



# bare intervals

"""
    abs(a::Interval)

Implement the `abs` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function abs(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    return _unsafe_bareinterval(T, mig(a), mag(a))
end

abs2(a::BareInterval) = nthpow(a, 2)

"""
    min(a::Interval, b::Interval)

Implement the `min` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function min(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    return _unsafe_bareinterval(T, min(inf(a), inf(b)), min(sup(a), sup(b)))
end

min(a::BareInterval, b::BareInterval) = min(promote(a, b)...)

"""
    max(a::Interval, b::Interval)

Implement the `max` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function max(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(b) && return b
    return _unsafe_bareinterval(T, max(inf(a), inf(b)), max(sup(a), sup(b)))
end

max(a::BareInterval, b::BareInterval) = max(promote(a, b)...)



# decorated intervals

for f ∈ (:abs, :abs2)
    @eval $f(a::Interval) = _unsafe_interval($f(bareinterval(a)), decoration(a))
end

for f ∈ (:min, :max)
    @eval function $f(a::Interval, b::Interval)
        r = $f(bareinterval(a), bareinterval(b))
        d = $f(decoration(a), decoration(b)) # $f(decoration(a), decoration(b), decoration(r))
        return _unsafe_interval(r, d)
    end
end
