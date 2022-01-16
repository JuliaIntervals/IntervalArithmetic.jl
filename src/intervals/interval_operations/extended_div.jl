# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the two-output division requested for set-based flavor
    by the IEEE Std 1788-2015 (section 10.5.5).
=#

"""
    extended_div(a::Interval, b::Interval)

Two-output division.

Implement the `mulRevToPair` function of the IEEE Std 1788-2015 (section 10.5.5).
"""
function extended_div(a::F, b::F) where {T, F<:Interval{T}}
    if 0 < b.hi && 0 > b.lo && 0 ∉ a
        if a.hi < 0
            return (F(T(-Inf), a.hi / b.hi), F(a.hi / b.lo, T(Inf)))

        elseif a.lo > 0
            return (F(T(-Inf), a.lo / b.lo), F(a.lo / b.hi, T(Inf)))

        end
    elseif 0 ∈ a && 0 ∈ b
        return (entireinterval(F), emptyinterval(F))
    else
        return (a / b, emptyinterval(F))
    end
end