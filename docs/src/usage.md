# Basic usage

The basic elements of the package are **intervals**, i.e. sets of real numbers (possibly including $\pm \infty$) of the form

```math
[a, b] := \{ a \le x \le b \} \subseteq \mathbb{R}.
```

## Creating intervals
Intervals are created using the [`@interval`](@ref) macro, which takes one or two expressions:
```jldoctest usage
julia> using IntervalArithmetic

julia> a = @interval(1)
[1, 1]

julia> typeof(ans)
IntervalArithmetic.Interval{Float64}

julia> b = @interval(1, 2)
[1, 2]
```

The objects returned are of the parameterized type `Interval`, the basic object in the package.
By default, `Interval` objects contain `Float64`s, but the library also allows using other types such as `Rational`s and
`BigFloat`s; for example:
```jldoctest usage
julia> @biginterval(1, 2)
[1, 2]₂₅₆

julia> showall(ans)
Interval(1.000000000000000000000000000000000000000000000000000000000000000000000000000000, 2.000000000000000000000000000000000000000000000000000000000000000000000000000000)
```

The constructor of the `Interval` type may be used directly, but this is generally not recommended, for the following reason:

```jldoctest usage
julia> a = Interval(0.1, 0.3)
[0.1, 0.3]

julia> b = @interval(0.1, 0.3)
[0.0999999, 0.300001]
```

What is going on here?

Due to the way floating-point arithmetic works, the interval
`a` created directly by the constructor turns out to contain
*neither the true real number 0.1, nor 0.3*, since the floating point
number associated to 0.1 is actually rounded up, whereas the
one associated to 0.3 is rounded down.
The [`@interval`](@ref) macro, however, uses [**directed rounding**](rounding.md) to *guarantee*
that the true 0.1 and 0.3 are included in the result.

Behind the scenes, the [`@interval`(@ref)] macro rewrites the expression(s) passed to it, replacing the literals (0.1, 1, etc.) by calls to create correctly-rounded intervals, handled by the `convert`
function.

This allows us to write, for example

```jldoctest usage
julia> @interval sin(0.1) + cos(0.2)
[1.07989, 1.0799]
```
which is equivalent to
```jldoctest usage
julia> sin(@interval(0.1)) + cos(@interval(0.2))
[1.07989, 1.0799]
```

This can be used together with user-defined functions:
```jldoctest usage
julia> f(x) = 2x
f (generic function with 1 method)

julia> f(@interval(0.1))
[0.199999, 0.200001]

julia> @interval f(0.1)
[0.199999, 0.200001]
```

### `\pi`
You can create correctly-rounded intervals containing `\pi`:
```jldoctest usage
julia> @interval(pi)
[3.14159, 3.1416]
```
and embed it in expressions:
```jldoctest usage
julia> @interval(3*pi/2 + 1)
[5.71238, 5.71239]

julia> @interval 3π/2 + 1
[5.71238, 5.71239]
```

## Constructing intervals
Intervals may be constructed using rationals:
```jldoctest usage
julia> @interval(1//10)
[0.0999999, 0.100001]
```

Real literals are handled by internally converting them
to rationals (using the Julia function `rationalize`). This gives
a result that contains the computer's "best guess" for
the real number the user "had in mind":
```jldoctest usage
julia> @interval(0.1)
[0.0999999, 0.100001]
```
If you instead know which exactly-representable floating-point number `a` you need and really
want to make a *thin interval*, i.e., an interval of the form `[a, a]`,
containing precisely one float, then you can
use the `Interval` constructor directly:
```jldoctest usage
julia> a = Interval(0.1)
[0.1, 0.100001]

julia> showall(a)
Interval(0.1, 0.1)
```
Here, the `showall` function shows the internal representation of the interval,
in a reproducible form that may be copied and pasted directly. It uses Julia's
internal function (which, in turn, uses the so-called Grisu algorithm) to show
exactly as many digits are required to give an unambiguous floating-point number.

Strings may be used inside [`@interval`](@ref):
```jldoctest usage
julia> @interval "0.1"*2
[0.199999, 0.200001]

julia> @biginterval "0.1"*2
[0.199999, 0.200001]₂₅₆

julia> showall(ans)
Interval(1.999999999999999999999999999999999999999999999999999999999999999999999999999983e-01, 2.000000000000000000000000000000000000000000000000000000000000000000000000000004e-01)

```

Strings in the form of intervals may also be used:
```jldoctest usage
julia> @interval "[1.2, 3.4]"
[1.19999, 3.40001]
```

Intervals can be created from variables:
```jldoctest usage
julia> a = 3.6
3.6

julia> b = @interval(a)
[3.59999, 3.60001]
```

The upper and lower bounds of the interval may be accessed using the fields
`lo` and `hi`:
```jldoctest usage
julia> b.lo
3.5999999999999996

julia> b.hi
3.6
```

The diameter (length) of an interval is obtained using [`diam(b)`](@ref);
for numbers that cannot be represented exactly in base 2
(i.e., whose *binary* expansion is infinite or exceeds the current precision),
 the diameter of intervals created by [`@interval`](@ref) with a single argument corresponds to the local machine epsilon (`eps`) in the `:narrow` interval-rounding mode:

 ```jldoctest usage
julia> diam(b)
4.440892098500626e-16

julia> eps(b.lo)
4.440892098500626e-16
```

You can use additional syntax for creating intervals more easily.
The for example, the `..` operator is equivalent to using the macro:
```jldoctest usage
julia> 0.1..0.3
[0.0999999, 0.300001]
```
and the `@I_str` string macro:
```jldoctest usage
julia> I"3.1"
[3.09999, 3.10001]

julia> I"[3.1, 3.2]"
[3.09999, 3.20001]
```

You can also use the `±` operator:
```jldoctest usage
julia> 1.5 ± 0.1
[1.39999, 1.60001]
```


## Arithmetic

Basic arithmetic operations (`+`, `-`, `*`, `/`, `^`) are defined for pairs of intervals in a standard way (see, e.g., the book by Tucker): the result is the smallest interval containing the result of operating with each element of each interval. That is, for two intervals `X` and `Y` and an operation `\bigcirc`, we define the operation on the two intervals by
```math
\bigcirc Y := \{ x \bigcirc y: x \in X \text{ and } y \in Y \}.
```
Again, directed rounding is used if necessary.

For example:
```jldoctest usage
julia> a = @interval(0.1, 0.3)
[0.0999999, 0.300001]

julia> b = @interval(0.3, 0.6)
[0.299999, 0.600001]

julia> a + b
[0.399999, 0.900001]
```

However, subtraction of two intervals gives an initially unexpected result, due to the above definition:
```jldoctest usage
julia> a = @interval(0, 1)
[0, 1]

julia> a - a
[-1, 1]
```


## Changing the precision

By default, the [`@interval`](@ref) macro creates intervals of `Float64`s.
This may be changed globally using the `setprecision` function:

```jldoctest usage
julia> @interval 3π/2 + 1
[5.71238, 5.71239]

julia> showall(ans)
Interval(5.71238898038469, 5.712388980384691)

julia> setprecision(Interval, 256)
256

julia> @interval 3π/2 + 1
[5.71238, 5.71239]₂₅₆

julia> showall(ans)
Interval(5.712388980384689857693965074919254326295754099062658731462416888461724609429262, 5.712388980384689857693965074919254326295754099062658731462416888461724609429401)
```
The subscript `256` at the end denotes the precision.

To change back to `Float64`s, use
```jldoctest usage
julia> setprecision(Interval, Float64)
Float64

julia> @interval(pi)
[3.14159, 3.1416]
```

To check which mode is currently set, use
```jldoctest usage
julia> precision(Interval)
(Float64,256)
```
The result is a tuple of the type (currently `Float64` or `BigFloat`) and the current `BigFloat` precision.

Note that the `BigFloat` precision is set internally by `setprecision(Interval)`.
You should *not* use `setprecision(BigFloat)` directly,  
since the package carries out additional steps to ensure internal
consistency of operations involving π, in particular
trigonometric functions.


## Elementary functions

The main elementary functions are implemented, for both
`Interval{Float64}` and `Interval{BigFloat}`.

The functions for `Interval{Float64}` internally use routines from the correctly-rounded [`CRlibm` library](https://github.com/dpsanders/CRlibm.jl) where possible, i.e. for the following functions defined in that library:

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
- `atan2`, `atanh`

Note, in particular, that in order to obtain correct rounding for the power function (`^`),
intervals are converted to and from `BigFloat`; this implies a significant slow-down in this case.

Examples:

```jldoctest usage
julia> a = @interval(1)
[1, 1]

julia> sin(a)
[0.84147, 0.841471]

julia> cos(cosh(a))
[0.0277121, 0.0277122]
```

```jldoctest usage
julia> setprecision(Interval, 53)
53

julia> sin(@interval(1))
[0.84147, 0.841471]₅₃

julia> @interval sin(0.1) + cos(0.2)
[1.07989, 1.0799]₅₃
```

```jldoctest usage
julia> setprecision(Interval, 128)
128

julia> @interval sin(1)
[0.84147, 0.841471]₁₂₈
```


## Interval rounding modes

By default, the directed rounding used corresponds to using the `RoundDown` and `RoundUp` rounding modes when performing calculations; this gives the narrowest resulting intervals, and is set by

```jldoctest usage
julia> setrounding(Interval, :slow)

```

An alternative rounding method is to perform calculations using the (standard) `RoundNearest` rounding mode, and then widen the result by one machine epsilon in each direction using `prevfloat` and `nextfloat`. This is achived by
```
julia> setrounding(Interval, :accurate);

```
It generally results in wider intervals, but seems to be significantly faster.


## Display modes
There are several useful output representations for intervals, some of which we have already touched on. The display is controlled globally by the `setformat` function, which has
the following options, specified by keyword arguments (type `?setformat` to get help at the REPL):

- `format`: interval output format

    - `:standard`: output of the form `[1.09999, 1.30001]`, rounded to the current number of significant figures

    - `:full`: output of the form `Interval(1.0999999999999999, 1.3)`, as in the `showall` function

    - `:midpoint`: output in the midpoint-radius form, e.g. `1.2 ± 0.100001`

- `sigfigs`: number of significant figures to show in standard mode

- `decorations` (boolean): whether to show [decorations](decorations.md) or not

### Examples

```jldoctest usage
julia> setprecision(Interval, Float64)
Float64

julia> a = @interval(1.1, pi)
[1.09999, 3.1416]

julia> setformat(sigfigs=10)
10

julia> a
[1.099999999, 3.141592654]

julia> setformat(:full)
10

julia> a
Interval(1.0999999999999999, 3.1415926535897936)

julia> setformat(:midpoint)
10

julia> a
2.120796327 ± 1.020796327

julia> setformat(:midpoint, sigfigs=4)
4

julia> a
2.121 ± 1.021

julia> setformat(:standard)
4

julia> a
[1.099, 3.142]

julia> setformat(:standard, sigfigs=6)
6
```
