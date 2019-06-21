# TODO define the flavor dependent symbols ==, <, <=

# TODO implement the edge cases for vasious flavors, this one is the set-based (IEEE)
"""
    checked_mult(a, b, r::RoundingMode)

Multiplication `a*b` with the special case `0*Inf` giving `0`.
"""
function checked_mult(a::T, b::T, r::RoundingMode) where T
    if (a == 0 && isinf(b)) || (isinf(a) && b == 0)
        return zero(T)
    end

    return *(a, b, r)
end

"""
    div_by_zero(F, a::AbstractFlavor)

Division of the interval `a` by exactly `0`.
"""
div_by_zero(::Type{F}, a::F) where {F <: SetBasedFlavoredInterval} = emptyinterval(F)

"""
    div_zero_by(F, x)

Division of exactly `0` by `x`.
"""
div_by_zero(::Type{F}, x) where {F <: SetBasedFlavoredInterval} = zero(F)
