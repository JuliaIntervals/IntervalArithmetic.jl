# Configuration options

The IntervalArithmetic.jl package provides a [`configure`](@ref) function (not exported) that allows users to fine-tune certain aspects of the package’s behavior. This is particularly useful for controlling trade-offs between computational speed and rigor.

!!! warning
    The [`configure`](@ref) function redefines methods that alter the internal behavior of IntervalArithmetic. This persists across the current Julia session and affect all subsequent interval arithmetic computations.

Each keyword argument sets a specific configuration option:
- `numtype`: control the default numerical type used to represent the bounds of the intervals.
- `flavor`: control the flavor type of the intervals.
- `rounding`: control the rounding type.
- `power`: control the implementation used for the interval power operation, that is, the computation of `x^n` where `x` is an interval and `n` is a number. The choice of power implementation has implications for both performance and accuracy.
- `matmul`: control the matrix multiplication algorithm.

```@repl
using IntervalArithmetic
x = interval(π)
IntervalArithmetic.configure(; power = :slow)
radius(x^3)
IntervalArithmetic.configure(; power = :fast) # default
radius(x^3)
```
