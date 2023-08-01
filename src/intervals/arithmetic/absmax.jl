# This file contains the functions described as "Absmax functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3

"""
    abs(a::Interval)

Implement the `abs` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function abs(a::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    return unsafe_interval(T, mig(a), mag(a))
end

abs2(a::Interval) = sqr(a)

"""
    min(a::Interval, b::Interval)

Implement the `min` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function min(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    isemptyinterval(b) && return b
    return unsafe_interval(T, min(inf(a), inf(b)), min(sup(a), sup(b)))
end

min(a::Interval, b::Interval) = min(promote(a, b)...)

"""
    max(a::Interval, b::Interval)

Implement the `max` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function max(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    isemptyinterval(a) && return a
    isemptyinterval(b) && return b
    return unsafe_interval(T, max(inf(a), inf(b)), max(sup(a), sup(b)))
end

max(a::Interval, b::Interval) = max(promote(a, b)...)
