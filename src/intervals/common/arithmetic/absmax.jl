# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Absmax functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3.
=#
"""
    abs(a::AbstractFlavor)

Implement the `abs` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function abs(a::F) where {F<:AbstractFlavor}
    isempty(a) && return emptyinterval(F)
    return F(mig(a), mag(a))
end

abs2(a::AbstractFlavor) = sqr(a)

"""
    min(a::AbstractFlavor)

Implement the `min` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function min(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return F( min(a.lo, b.lo), min(a.hi, b.hi))
end

"""
    max(a::AbstractFlavor)

Implement the `max` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function max(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return F( max(a.lo, b.lo), max(a.hi, b.hi))
end