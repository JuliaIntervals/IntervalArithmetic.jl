# This file contains the functions described as
# "Cancellative addition and subtraction" in Section 9.2 of the
# IEEE Standard 1788-2015 and required for set-based flavor in Section 10.5.6

"""
    cancelminus(a, b)

Return the unique interval `c` such that `b + c = a`.

Implement the `cancelMinus` function of the IEEE Standard 1788-2015 (Section 9.2).
"""
function cancelminus(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    (isempty_interval(a) && (isempty_interval(b) || !isunbounded(b))) && return emptyinterval(T)

    (isunbounded(a) || isunbounded(b) || isempty_interval(b)) && return entireinterval(T)

    diam(a) < diam(b) && return entireinterval(T)

    c_lo, c_hi = bounds(@round(T, inf(a) - inf(b), sup(a) - sup(b)))
    c_lo > c_hi && return entireinterval(T)

    # Corner case 2 (page 62), involving unbounded c
    c_lo == typemax(T) && return unsafe_interval(T, prevfloat(c_lo), c_hi)
    c_hi == typemin(T) && return unsafe_interval(T, c_lo, nextfloat(c_hi))

    c = unsafe_interval(T, c_lo, c_hi)
    isunbounded(c) && return c

    # Corner case 1 (page 62) involving finite precision for diam(a) and diam(b)
    a_lo, a_hi = bounds(@round(T, inf(b) + c_lo, sup(b) + c_hi))
    (diam(a) == diam(b)) && (nextfloat(sup(a)) < a_hi || prevfloat(inf(a)) > a_lo) && return entireinterval(T)

    return c
end
cancelminus(a::Interval, b::Interval) = cancelminus(promote(a, b)...)

"""
    cancelplus(a, b)

Return the unique interval `c` such that `b - c = a`.

Equivalent to `cancelminus(a, -b)`.

Implement the `cancelPlus` function of the IEEE Standard 1788-2015 (Section 9.2).
"""
cancelplus(a::Interval, b::Interval) = cancelminus(a, -b)
