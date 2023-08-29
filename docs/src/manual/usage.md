## Display modes

There are several useful output representations for intervals, some of which we have already touched on. The display is controlled globally by the `setformat` function, which has
the following options, specified by keyword arguments (type `?setformat` to get help at the REPL):

- `format`: interval output format

    - `:standard`: output of the form `[1.09999, 1.30001]`, rounded to the current number of significant figures

    - `:full`: output of the form `Interval(1.0999999999999999, 1.3)`, as in the `showfull` function

    - `:midpoint`: output in the midpoint-radius form, e.g. `1.2 ± 0.100001`

- `sigfigs`: number of significant figures to show in standard mode

- `decorations` (boolean): whether to show [decorations](decorations.md) or not

```@repl
using IntervalArithmetic
setformat() # default values
a = interval(1.1, pi)
setformat(; sigdigits = 10)
a
setformat(:full)
a
setformat(:midpoint)
a
setformat(; sigdigits = 4)
a
setformat(:standard)
a
```



## Arithmetic operations

Basic arithmetic operations (`+`, `-`, `*`, `/`, `^`) are defined for pairs of intervals in a standard way: the result is the smallest interval containing the result of operating with each element of each interval. More precisely, for two intervals ``X`` and ``Y`` and an operation ``\bigcirc``, we define the operation on the two intervals by

```math
X \bigcirc Y := \{ x \bigcirc y \,:\, x \in X \text{ and } y \in Y \}.
```

For example,

```@repl usage
using IntervalArithmetic
setformat(:full)
X = interval(0, 1)
Y = interval(1, 2)
X + Y
```

Due to the above definition, subtraction of two intervals may give poor enclosures:

```@repl usage
X - X
```



## Elementary functions

The main elementary functions are implemented. The functions for `Interval{Float64}` internally use routines from the correctly-rounded [`CRlibm` library](https://github.com/dpsanders/CRlibm.jl) where possible, i.e. for the following functions defined in that library:
- `exp`, `expm1`
- `log`, `log1p`, `log2`, `log10`
- `sin`, `cos`, `tan`
- `asin`, `acos`, `atan`
- `sinh`, `cosh`

Other functions that are implemented for `Interval{Float64}` internally convert
to an `Interval{BigFloat}`, and then use routines from the `MPFR` library
(`BigFloat` in Julia):
- `^`
- `exp2`, `exp10`
- `atan`, `atanh`

Note, in particular, that in order to obtain correct rounding for the power function (`^`), intervals are converted to and from `BigFloat`; this implies a significant slow-down in this case.

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



## Multi-dimensional intervals

Multi-dimensional (hyper-)boxes are implemented in the
`IntervalBox` type.
These represent Cartesian products of intervals, i.e. rectangles (in 2D),
cuboids (in 3D), etc.

`IntervalBox`es are constructed from an array of `Interval`s; it is
often convenient to use the `..` notation:

```
julia> using IntervalArithmetic

julia> X = IntervalBox(1..3, 2..4)
[1, 3] × [2, 4]

julia> Y = IntervalBox(2.1..2.9, 3.1..4.9)
[2.09999, 2.90001] × [3.09999, 4.90001]
```

Several operations are defined on `IntervalBox`es, for example:

```
julia> X ∩ Y
[2.09999, 2.90001] × [3.09999, 4]

julia> X ⊆ Y
false
```

Given a multi-dimensional function taking several inputs, and interval box can be constructed as follows:

```
julia> f(x, y) = (x + y, x - y)
f (generic function with 1 method)

julia> X = IntervalBox(1..1, 2..2)
[1, 1] × [2, 2]

julia> f(X...)
([3, 3], [-1, -1])

julia> IntervalBox(f(X...))
[3, 3] × [-1, -1]
```
