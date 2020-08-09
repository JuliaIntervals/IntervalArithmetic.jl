# TODO define the flavor dependent symbols ==, <, <=

# TODO implement the edge cases for vasious flavors, this one is the set-based (IEEE)
"""
    zero_times_infinity(::Type{AbstractFlavor})

Return the result of zero times positive infinity for the given flavor.
"""
zero_times_infinity(::Type{F}) where {T, F<:SetBasedFlavoredInterval{T}} = zero(T)


"""
    inv_of_zero(F)

Inverse of the interval containing only `0`.
"""
inv_of_zero(::Type{F}) where {F<:SetBasedFlavoredInterval} = emptyinterval(F)

"""
    div_zero_by(F, x)

Division of exactly `0` by `x`.
"""
div_zero_by(::Type{F}, x) where {F<:SetBasedFlavoredInterval} = zero(F)
