==(x::SetBasedFlavoredInterval, y::SetBasedFlavoredInterval) = (x ≛ y)
<(x::SetBasedFlavoredInterval, y::SetBasedFlavoredInterval) = isstrictless(x, y)
<=(x::SetBasedFlavoredInterval, y::SetBasedFlavoredInterval) = isweaklyless(x, y)