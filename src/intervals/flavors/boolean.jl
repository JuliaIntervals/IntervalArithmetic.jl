==(x::SetBasedInterval, y::SetBasedInterval) = (x ≛ y)
<(x::SetBasedInterval, y::SetBasedInterval) = isstrictless(x, y)
<=(x::SetBasedInterval, y::SetBasedInterval) = isweaklyless(x, y)