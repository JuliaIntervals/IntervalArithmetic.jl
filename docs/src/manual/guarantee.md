# Guaranteed intervals

A *guaranteed interval* is a concept distinct from decorations (see [Decorations](@ref Decorations)) and not specified in the IEEE 1788-2015 standard. It is introduced to accommodate Julia’s flexible system of type conversion and promotion, while retaining reliability in computations.



### "NG" label

An interval `x` constructed via [`interval`](@ref) satisfies `isguaranteed(x) == true`. However, if a call to `convert(::Type{<:Interval}, ::Real)` occurs, then the resulting interval `x` satisfies `isguaranteed(x) == false`, receiving the "NG" (not guaranteed) label.

For instance, consider the following examples:

```@repl guarantee
using IntervalArithmetic
setdisplay(; sigdigits = 6)
convert(Interval{Float64}, 1.) # considered "not guaranteed" as this call can be done implicitly
interval(1) # considered "guaranteed" as the user explicitly constructed the interval
```

In contrast, a [`BareInterval`](@ref) can only be constructed via [`bareinterval`](@ref), it is not a subtype of `Real`, and there are no allowed conversion with `Number`. Thus, this interval type is always guaranteed.

!!! danger
    A user interested in validated numerics should **always** track down the source of an "NG" label.



### Exact numbers

When typing Julia code, it is combersome to manually wrap all numerical numbers with [`interval`](@ref). Also, we sometimes want to use the same function for both floating-point arithmetic (maybe to check have a fast quick checks) and interval arithmetic. Then, we would want the typed-in numerical numbers to convert automatically to the appropriate numerical type depending on the context. To this end, the [`ExactReal`](@ref) structure marks any `Real` number as a user exactly typed-in value.

For instance, consider the following examples:

```@repl guarantee
interval(1)
interval(1) + exact(1)
@exact 2interval(1) + 1 + exp(im * interval(1))
@exact foo(x) = 2x + 1 + exp(im * x)
foo(1.)
foo(interval(1))
```
