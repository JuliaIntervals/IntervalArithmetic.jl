# Basic usage

Intervals are created using the `@floatinterval` and `@interval` macros, which take one or two arguments.

```
julia> using ValidatedNumerics

julia> a = @floatinterval(1)
[1.0, 1.0]

julia> typeof(ans)
Interval{Float64} (constructor with 1 method)

julia> b = @interval(1, 2)
[1e+00, 2e+00]₅₃

julia> typeof(ans)
Interval{BigFloat} (constructor with 1 method)
```

These return objects of type `Interval`, parametrized by the respective type.

The constructor may be used directly, but this is not recommended, for the following reason (which is why the macros are made available):

```
julia> a = Interval(0.1, 0.3)
[0.1, 0.2]

julia> b = @floatinterval(0.1, 0.3)
[0.09999999999999999, 0.30000000000000004]
```
Due to the way floating-point arithmetic works, the interval `a` *does not contain either the true real number 0.1, or 0.3*. The macros use **directed rounding** to *guarantee* that the true 0.1 and 0.3 *are* included in the result.


## Arithmetic

Basic arithmetic operations on intervals are defined in a standard way (see, e.g. the book by Tucker). Examples:

TODO

## Elementary functions

Some elementary functions, currently `exp`, `log`, `sin`, `cos` and `tan` are defined for intervals.
