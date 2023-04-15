# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described in section 9.2 of the IEEE Std
    1788-2015 (Cancellative addition and subtraction) and required for set-based
    flavor in section 10.5.6.
=#

"""
    cancelminus(a, b)

Return the unique interval `c` such that `b + c = a`.

Implement the `cancelMinus` function of the IEEE Std 1788-2015 (section 9.2).
"""
function cancelminus(a::F, b::F) where {F<:Interval}
    (isempty(a) && (isempty(b) || !isunbounded(b))) && return emptyinterval(F)

    (isunbounded(a) || isunbounded(b) || isempty(b)) && return entireinterval(F)

    diam(a) < diam(b) && return entireinterval(F)

    c_lo, c_hi = bounds(@round(F, inf(a) - inf(b), sup(a) - sup(b)))
    c_lo > c_hi && return entireinterval(F)

    # Corner case 2 (page 62), involving unbounded c
    c_lo == Inf && return F(prevfloat(c_lo), c_hi)
    c_hi == -Inf && return F(c_lo, nextfloat(c_hi))

    c = F(c_lo, c_hi)
    isunbounded(c) && return c

    # Corner case 1 (page 62) involving finite precision for diam(a) and diam(b)
    a_lo, a_hi = bounds(@round(F, inf(b) + c_lo, sup(b) + c_hi))
    (diam(a) == diam(b)) && (nextfloat(sup(a)) < a_hi || prevfloat(inf(a)) > a_lo) && return entireinterval(F)

    return c
end
cancelminus(a::Interval, b::Interval) = cancelminus(promote(a, b)...)

"""
    cancelplus(a, b)

Return the unique interval `c` such that `b - c = a`.

Equivalent to `cancelminus(a, -b)`.

Implement the `cancelPlus` function of the IEEE Std 1788-2015 (section 9.2).
"""
cancelplus(a::Interval, b::Interval) = cancelminus(a, -b)
