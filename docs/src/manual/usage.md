## Display modes

There are several useful output representations for intervals. The display is controlled globally by the [`setdisplay`](@ref) function, which has the following options:

- interval output format:

    - `:infsup`: output of the form `[1.09999, 1.30001]`, rounded to the current number of significant figures.

    - `:full`: output of the form `Interval(1.0999999999999999, 1.3)`, as in the `showfull` function.

    - `:midpoint`: output in the midpoint-radius form, e.g. `1.2 ± 0.100001`.

- `sigfigs :: Int` keyword argument: number of significant figures to show in standard mode.

- `decorations :: Bool` keyword argument: whether to show [decorations](decorations.md) or not.

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



## Arithmetic operations

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



## Elementary functions

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



## Comparisons and set operations

All comparisons and set operations for `Real` have been purposely disallowed to prevent silent errors. For instance, `x == y` does not implies `x - y == 0` for non-singleton intervals.

```@repl usage
interval(1) < interval(2)
precedes(interval(1), interval(2))
issubset(interval(1, 2), interval(2))
issubset_interval(interval(1, 2), interval(2))
intersect(interval(1, 2), interval(2))
intersect_interval(interval(1, 2), interval(2))
```

In particular, `if ... else ... end` statements used for floating-points will generally break with intervals.

One can refer to the following:
- `<`: cannot be used with intervals. See instead [`isstrictless`](@ref) or [`strictprecedes`](@ref).
- `==`: allowed if the arguments are singleton intervals, or if at least one argument is not an interval (equivalent to [`isthin`](@ref)). Otherwise, see [`isequal_interval`](@ref).
- `iszero`, `isone`: allowed (equivalent to [`isthinzero`](@ref) and [`isthinone`](@ref) respectively).
- `isinteger`: cannot be used with intervals. See instead [`isthininteger`](ref).
- `isfinite`: cannot be used with intervals. See instead [`isbounded`](@ref).
- `isnan`: cannot be used with intervals. See instead [`isnai`](@ref).
- `in`: allowed if at least one argument is not an interval and the interval argument is a singleton. Otherwise, see [`in_interval`](@ref).
- `issubset`: cannot be used with intervals. See instead [`issubset_interval`](@ref).
- `isdisjoint`: cannot be used with intervals. See instead [`isdisjoint_interval`](@ref).
- `issetequal`: cannot be used with intervals.
- `isempty`: cannot be used with intervals. See instead [`isempty_interval`](@ref).
- `union`: cannot be used with intervals. See instead [`hull`](@ref).
- `intersect`: cannot be used with intervals. See instead [`intersect_interval`](@ref).
- `setdiff`: cannot be used with intervals. See instead [`interiordiff`](@ref).



## Custom interval bounds type

A `BareInterval{T}` or `Interval{T}` have the restriction `T <: Union{Rational,AbstractFloat}` which is the parametric type for the bounds of the interval. Supposing one wishes to use their own numeric type `MyNumType <: Union{Rational,AbstractFloat}`, they must provide their own arithmetic operations (with correct rounding!).
