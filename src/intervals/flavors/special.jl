
#= TODO fully flavor dependant stuff to deal with that should not have default
cases
=#
isfinite(x::Interval) = isfinite(x.lo) && isfinite(x.hi)
iszero(x::Interval) = iszero(x.lo) && iszero(x.hi)
