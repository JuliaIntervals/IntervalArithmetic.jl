# Manipulating intervals



### Display modes

There are several useful output representations for intervals. The display is controlled globally by the [`setdisplay`](@ref) function, which has the following options:

- interval output format:

    - `:infsup`: output of the form `[1.09999, 1.30001]`, rounded to the current number of significant figures.

    - `:full`: output of the form `Interval(1.0999999999999999, 1.3)`, as in the `showfull` function.

    - `:midpoint`: output in the midpoint-radius form, e.g. `1.2 ± 0.100001`.

- `sigdigits :: Int` keyword argument: number of significant digits to show in standard mode.

- `decorations :: Bool` keyword argument: whether to show decorations or not.

```@repl
using IntervalArithmetic
a = interval(1.1, pi) # default display
setdisplay(; sigdigits = 10)
a
setdisplay(:full)
a
setdisplay(:midpoint)
a
setdisplay(; sigdigits = 4)
a
setdisplay(:infsup)
a
```



### Arithmetic operations

Basic arithmetic operations (`+`, `-`, `*`, `/`, `^`) are defined for pairs of intervals in a standard way: the result is the smallest interval containing the result of operating with each element of each interval. More precisely, for two intervals ``X`` and ``Y`` and an operation ``\bigcirc``, we define the operation on the two intervals by

```math
X \bigcirc Y \bydef \{ x \bigcirc y \,:\, x \in X \text{ and } y \in Y \}.
```

For example,

```@repl usage
using IntervalArithmetic
setdisplay(:full)
X = interval(0, 1)
Y = interval(1, 2)
X + Y
```

Due to the above definition, subtraction of two intervals may give poor enclosures:

```@repl usage
X - X
```



### Elementary functions

The main elementary functions are implemented. The functions for `Interval{Float64}` internally use routines from the correctly-rounded [CRlibm library](https://github.com/dpsanders/CRlibm.jl) where possible, i.e. for the following functions defined in that library:
- `exp`, `expm1`
- `log`, `log1p`, `log2`, `log10`
- `sin`, `cos`, `tan`
- `asin`, `acos`, `atan`
- `sinh`, `cosh`

Other functions that are implemented for `Interval{Float64}` internally convert
to an `Interval{BigFloat}`, and then use routines from the MPFR library
(`BigFloat` in Julia):
- `^`
- `exp2`, `exp10`
- `atan`, `atanh`

In particular, in order to obtain correct rounding for the power function (`^`), intervals are converted to and from `BigFloat`; this implies a significant slow-down in this case.

For example,

```@repl usage
X = interval(1)
sin(X)
cos(cosh(X))
setprecision(BigFloat, 53)
Y = big(X)
sin(Y)
cos(cosh(Y))
setprecision(BigFloat, 128)
sin(Y)
```



### Comparisons

If the result of a comparison can be established with guarantee,
it will be return, otherwise, an error is thrown.

```@repl usage
interval(1) < interval(2)
interval(1, 5) < interval(7, 9)
interval(1, 5) < interval(4.99, 9)
interval(1.23) == interval(1.23)
interval(1.23) == interval(4.99, 9)
interval(1.23) == interval(1.2, 1.3)
```

In particular, `if ... else ... end` statements used for floating-points will often break with intervals.

See [Philosophy](@ref) for more details and why this choice was made.



### Set operations

Set operations are all disallowed and error on intervals to avoid ambiguities.
To perform set operations on intervals, use the `*_interval` equivalent explicitly,
e.g. `issubset_interval` instead of `issubset`.


```@repl usage
issubset(interval(1, 2), interval(2))
issubset_interval(interval(1, 2), interval(2))
intersect(interval(1, 2), interval(2))
intersect_interval(interval(1, 2), interval(2))
```

See [Philosophy](@ref) for more details and why this choice was made.



### Piecewise functions

Since intervals don't play well with `if ... else ... end` statement,
we provide a utility to define function by pieces:

```@repl usage
myabs = Piecewise(
    Domain{:open, :closed}(-Inf, 0) => x -> -x,
    Domain{:open, :open}(0, Inf) => identity
)
myabs(-1.23)
myabs(interval(-1, 23))
```

The resulting function work with both standard numbers and intervals,
and deal properly with the decorations of intervals.



### Custom interval bounds type

A `BareInterval{T}` or `Interval{T}` have the restriction `T <: Union{Rational,AbstractFloat}` which is the parametric type for the bounds of the interval. Supposing one wishes to use their own numeric type `MyNumType <: Union{Rational,AbstractFloat}`, they must provide their own arithmetic operations (with correct rounding!).
