==(x::SetBasedFlavoredInterval, y::SetBasedFlavoredInterval) = isidentical(x, y)
<(x::SetBasedFlavoredInterval, y::SetBasedFlavoredInterval) = isstrictless(x, y)
<=(x::SetBasedFlavoredInterval, y::SetBasedFlavoredInterval) = isless(x, y)