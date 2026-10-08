# Configuration options

```@meta
CurrentModule = IntervalArithmetic
```

The IntervalArithmetic.jl package provides a [`configure`](@ref) function (not exported) that allows users to fine-tune certain aspects of the package’s behavior. This is particularly useful for controlling trade-offs between computational speed and rigor.

!!! warning
    The [`configure`](@ref) function redefines methods that alter the internal behavior of IntervalArithmetic. This persists across the current Julia session and affects all subsequent interval arithmetic computations.

    A new configuration takes effect in code that starts running after `configure` returns to the Julia prompt. Code that is already running keeps using the previous configuration (see the section on world age in the Julia manual).
    In particular, calling `configure` from a function leaves the old behavior intact while the rest of the function runs. Use `Base.invokelatest` to call into the new configuration from the same function.

    Each change invalidates every compiled method that depends on the modified option, so configuration changes may trigger recompilation delays before using the new configuration.

Each keyword argument sets a specific configuration option:
- `numtype`: control the default numerical type used to represent the bounds of the intervals.
- `flavor`: control the flavor type of the intervals.
- `rounding`: control the rounding type.
- `power`: control the implementation used for the interval power operation, that is, the computation of `x^n` where `x` is an interval and `n` is a number. The choice of power implementation has implications for both performance and accuracy.
- `matmul`: control the matrix multiplication algorithm.
- `nthreads`: control the number of threads used by the `:fast` matrix multiplication algorithm.

```@repl
using IntervalArithmetic
x = interval(π)
IntervalArithmetic.configure(; power = :slow)
radius(x^3)
IntervalArithmetic.configure(; power = :fast) # default
radius(x^3)
```

```@docs
IntervalArithmetic.configure
IntervalArithmetic.NumTypes
IntervalArithmetic.Flavor
IntervalArithmetic.IntervalRounding
IntervalArithmetic.PowerMode
IntervalArithmetic.MatMulMode
IntervalArithmetic.default_threads
```
