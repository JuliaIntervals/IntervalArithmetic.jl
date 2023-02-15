# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Absmax functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3.
=#
"""
    abs(a::Interval)

Implement the `abs` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function abs(a::F) where {F<:Interval}
    isempty(a) && return emptyinterval(F)
    return F(mig(a), mag(a))
end

abs2(a::Interval) = sqr(a)

"""
    min(a::Interval)

Implement the `min` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function min(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return F(min(inf(a), inf(b)), min(sup(a), sup(b)))
end

"""
    max(a::Interval)

Implement the `max` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function max(a::F, b::F) where {F<:Interval}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return F(max(inf(a), inf(b)), max(sup(a), sup(b)))
end
