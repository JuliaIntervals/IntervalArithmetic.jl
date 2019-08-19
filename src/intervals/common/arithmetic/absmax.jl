# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Absmax functions"
    in the IEEE Std 1788-2015 (sections 9.1).
=#
"""
    abs(a::AbstractFlavor)

Corresponds to the IEEE Std 1788-2015 `abs` function (Table 9.1).
"""
function abs(a::F) where {F<:AbstractFlavor}
    isempty(a) && return emptyinterval(F)
    return F(mig(a), mag(a))
end

abs2(a::AbstractFlavor) = sqr(a)

"""
    min(a::AbstractFlavor)

Corresponds to the IEEE Std 1788-2015 `min` function (Table 9.1).
"""
function min(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return F( min(a.lo, b.lo), min(a.hi, b.hi))
end

"""
    max(a::AbstractFlavor)

Corresponds to the IEEE Std 1788-2015 `max` function (Table 9.1).
"""
function max(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return emptyinterval(F)
    return F( max(a.lo, b.lo), max(a.hi, b.hi))
end