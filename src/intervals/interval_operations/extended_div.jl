# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the two-output division requested for set-based flavor
    by the IEEE Std 1788-2015 (section 10.5.5).
=#

"""
    extended_div(a::Interval, b::Interval)

Two-output division.

Implement the `mulRevToPair` function of the IEEE Std 1788-2015 (section 10.5.5).
"""
function extended_div(a::F, b::F) where {T<:NumTypes,F<:Interval{T}}
    alo, ahi = bounds(a)
    blo, bhi = bounds(b)
    z = zero(T)
    if 0 < bhi && 0 > blo && 0 ∉ a
        if ahi < 0
            return (a / F(z, bhi), a / F(blo, z))
            # return (F(T(-Inf), ahi / bhi), F(ahi / blo, T(Inf)))
        elseif alo > 0
            return (a / F(blo, z), a / F(z, bhi))
            # return (F(T(-Inf), alo / blo), F(alo / bhi, T(Inf)))
        end

    elseif 0 ∈ a && 0 ∈ b
        return (entireinterval(F), emptyinterval(F))

    else
        return (a / b, emptyinterval(F))
    end
end
