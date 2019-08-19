# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described in section 9.2 of the IEEE Std
    1788-2015 (Cancellative addition and subtraction).
=#

"""
    cancelminus(a, b)

Return the unique interval `c` such that `b + c = a`.

Implement the `cancelMinus` function of the IEEE Std 1788-2015 (section 9.2).
"""
function cancelminus(a::F, b::F) where {F<:AbstractFlavor}
    (isempty(a) && (isempty(b) || !isunbounded(b))) && return emptyinterval(F)

    (isunbounded(a) || isunbounded(b) || isempty(b)) && return RR(F)

    diam(a) < diam(b) && return RR(F)

    c_lo = @round_down(a.lo - b.lo)
    c_hi = @round_up(a.hi - b.hi)

    c_lo > c_hi && return RR(F)

    c_lo == Inf && return F(prevfloat(c_lo), c_hi)
    c_hi == -Inf && return F(c_lo, nextfloat(c_hi))

    a_lo = @round_down(b.lo + c_lo)
    a_hi = @round_up(b.hi + c_hi)

    if a_lo ≤ a.lo ≤ a.hi ≤ a_hi
        if nextfloat(a.hi) < a_hi || prevfloat(a.lo) > a_hi
            return RR(F)
        else
            return F(c_lo, c_hi)
        end
     end

    return RR(F)
end
cancelminus(a::AbstractFlavor, b::AbstractFlavor) = cancelminus(promote(a, b)...)

"""
    cancelplus(a, b)

Return the unique interval `c` such that `b - c = a`.

Equivalent to `cancelminus(a, −b)`.

Implement the `cancelPlus` function of the IEEE Std 1788-2015 (section 9.2).
"""
cancelplus(a::AbstractFlavor, b::AbstractFlavor) = cancelminus(a, -b)