<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    TeX: { equationNumbers: { autoNumber: "AMS" } }
  });
  MathJax.Hub.Config({
    TeX: { extensions: ["AMSmath.js", "AMSsymbols.js", "autobold.js", "autoload-all.js"] }
  });
  MathJax.Hub.Config({
    tex2jax: {
      inlineMath: [['$','$'], ['\\(','\\)']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML">
</script>

# Basic usage

The basic elements of the package are **intervals**, i.e. sets of real numbers (possibly including $\pm \infty$) of the form

$$[a, b] := \{ a \le x \le b \} \subseteq \mathbb{R}.$$

## Creating intervals
Intervals are created using the `@interval` macro, which takes one or two expressions:
```julia
julia> using ValidatedNumerics

julia> a = @interval(1)
[1.0, 1.0]

julia> typeof(ans)
Interval{Float64} (constructor with 1 method)

julia>

julia> b = @interval(1, 2)
[1.0, 2.0]
```

These return objects of the parametrised type `Interval`, the basic object in the package.

The constructor of the `Interval` type may be used directly, but this is generally not recommended, for the following reason:

```julia
julia> a = Interval(0.1, 0.3)
[0.1, 0.3]

julia> b = @interval(0.1, 0.3)
[0.09999999999999999, 0.30000000000000004]
```

What is going on here?

Due to the way floating-point arithmetic works, the interval
`a` created directly by the constructor *contains neither the true real number 0.1, nor 0.3*.
The `@interval` macro, however, uses [**directed rounding**](rounding.md) to *guarantee*
that the true 0.1 and 0.3 are included in the result.

Behind the scenes, the `@interval` macro rewrites the expression(s) passed to it, replacing the literals (0.1, 1, etc.) by calls to create correctly-rounded intervals, handled by the `convert`
function.

This allows us to write, for example
```julia
julia> @interval sin(0.1) + cos(0.2)
```
and get a result that is equivalent to
```julia
julia> sin(@interval(0.1)) + cos(@interval(0.2))
```

This can also be used with user-defined functions:
```julia
julia> f(x) = 2x
f (generic function with 1 method)

julia> f(@interval(0.1))
[0.19999999999999998, 0.2]

julia> @interval f(0.1)
[0.19999999999999998, 0.2]
```

### $\pi$
You can create correctly-rounded intervals containing $\pi$:
```julia
julia> @interval(pi)
[3.141592653589793, 3.1415926535897936]
```
and embed it in expressions:
```julia
julia> @interval(3*pi/2 + 1)
[5.71238898038469, 5.712388980384691]

julia> @interval 3π/2 + 1
[5.71238898038469, 5.712388980384691]
```

## Examples
Intervals may be constructed using rationals:
```julia
julia> @interval(1//10)
[0.09999999999999999, 0.1]
```

Real literals are handled by internally converting them
to rationals using `rationalize`. This is produces
a result that contains the computer's "best guess" for
the real number the user "had in mind":
```julia
julia> @interval(0.1)
[0.09999999999999999, 0.1]
```
If you know exactly which floating-point number you need and really
want to make a thin interval (i.e., an interval of the form $[a,a]$), you can just
use the `Interval` constructor:
```
julia> Interval(0.1)
[0.1, 0.1]
```

Strings may be used:
```julia
julia> @interval("0.1"*"2")
[0.19999999999999998, 0.2]
```

Strings in the form of intervals may also be used:
```julia
julia> @interval "[1.2, 3.4]"
[1.2, 3.4000000000000004]
```

Intervals can be created from variables:
```julia
julia> a = 3.6
3.6

julia> b = @interval(a)
[3.5999999999999996, 3.6]
```

The upper and lower bounds of the interval may be accessed using the fields
`lo` and `hi`:
```julia
julia> b.lo
3.5999999999999996

julia> b.hi
3.6
```

The diameter (length) of an interval is obtained using `diam(b)`;
for numbers that cannot be represented in base 2
(i.e., whose *binary* expansion is infinite or exceeds the current precision),
 the diameter of newly-created thin intervals corresponds to the local machine epsilon (`eps`) in the `:narrow` interval-rounding mode:

```julia
julia> diam(b)
4.440892098500626e-16

julia> eps(b.lo)
4.440892098500626e-16
```

Starting with v0.3, you can use additional syntax for creating intervals more easily:
the `..` operator,
```julia
julia> 0.1..0.3
[0.09999999999999999, 0.30000000000000004]
```
and the `@I_str` string macro:
```julia
julia> I"3.1"
[3.0999999999999996, 3.1]

julia> I"[3.1, 3.2]"
[3.0999999999999996, 3.2]
```

## Arithmetic

Basic arithmetic operations (`+`, `-`, `*`, `/`, `^`) are defined for pairs of intervals in a standard way (see, e.g., the book by Tucker): the result is the smallest interval containing the result of operating with each element of each interval. That is, for two intervals $X$ and $Y$ and an operation $\circ$, we define the operation on the two intervals by
$$X \circ Y := \{ x \circ y: x \in X \text{ and } y \in Y \}.$$  Again, directed rounding is used if necessary.

For example:
```julia
julia> a = @interval(0.1, 0.3)
[0.09999999999999999, 0.30000000000000004]

julia> b = @interval(0.3, 0.6)
[0.3, 0.6000000000000001]

julia> a + b
[0.39999999999999997, 0.9000000000000001]
```

However, subtraction of two intervals gives an initially unexpected result, due to the above definition:
```julia
julia> a = @interval(0, 1)
[0.0, 1.0]

julia> a - a
[-1.0, 1.0]
```


## Changing the precision
By default, the `@interval` macro creates intervals of `Float64`s.
This may be changed using the `setprecision` function:

```julia
julia> setprecision(Interval, 256)
256

julia> @interval 3π/2 + 1
[5.712388980384689857693965074919254326295754099062658731462416888461724609429262e+00, 5.712388980384689857693965074919254326295754099062658731462416888461724609429401e+00]₂₅₆
```
The subscript `256` at the end denotes the precision.

To change back to `Float64`s, use
```julia
julia> setprecision(Interval, Float64)
Float64

julia> @interval(pi)
[3.141592653589793, 3.1415926535897936]
```

To check which mode is currently set, use
```julia
julia> precision(Interval)
(Float64,256)
```
The result is a tuple of the type (currently `Float64` or `BigFloat`) and the current `BigFloat` precision.

Note that the `BigFloat` precision is set internally by `setprecision(Interval)`.
You should not use `setprecision(BigFloat)` directly,  
since the package carries out additional steps to ensure internal
consistency of operations involving π, in particular
trigonometric functions.


## Elementary functions

The main elementary functions are implemented, acting on both
`Interval{Float64}` and `Interval{BigFloat}`.

The functions that act on `Interval{Float64}` internally use routines the [`CRlibm` library](https://github.com/dpsanders/CRlibm.jl) where possible, i.e. for the following
functions defined in that library:

- `exp`, `expm1`
- `log`, `log1p`, `log2`, `log10`
- `sin`, `cos`, `tan`
- `asin`, `acos`, `atan`
- `sinh`, `cosh`

Other functions that are implemented for `Interval{Float64}` internally convert
to a `Interval{BigFloat}`, which then use routines from the `MPFR` library
(`BigFloat` in Julia):

- `^`
- `exp2`, `exp10`
- `atan2`, `atanh`

Note, in particular, that in order to obtain correct rounding for the power function (`^`),
intervals are converted to and from `BigFloat`; this implies a significant slow-down in this case.

Examples:

```julia
julia> a = @interval(1)
[1.0, 1.0]

julia> sin(a)
[0.8414709848078965, 0.8414709848078966]

julia> cos(cosh(a))
[0.027712143770207736, 0.02771214377020796]
```

```julia
julia> setprecision(Interval, 53)
53

julia> sin(@interval(1))
[8.414709848078965e-01, 8.4147098480789662e-01]₅₃

julia> @interval sin(0.1) + cos(0.2)
[1.0798999944880696e+00, 1.0798999944880701e+00]₅₃
```

```julia
julia> setprecision(Interval, 128)
128

julia> @interval sin(1)
[8.41470984807896506652502321630298999621e-01, 8.414709848078965066525023216302989996239e-01]₁₂₈
```


## Interval rounding modes
By default, the directed rounding used corresponds to using the `RoundDown` and `RoundUp` rounding modes when performing calculations; this gives the narrowest resulting intervals, and is set by

```julia
setrounding(Interval, :narrow)
```

An alternative rounding method is to perform calculations using the (standard) `RoundNearest` rounding mode, and then widen the result by one machine epsilon in each direction using `prevfloat` and `nextfloat`. This is achived by
```julia
setrounding(Interval, :wide)
```
It generally results in wider intervals, but seems to be significantly faster.

The current interval rounding mode may be obtained by
```julia
rounding(Interval)
```
