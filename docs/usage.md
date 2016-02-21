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

Behind the scenes, the `@interval` macro rewrites the expression(s) passed to it, replacing the literals (0.1, 1, etc.) by calls to create correctly-rounded intervals, handled internally by the `make_interval` function.

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

Reals are converted to rationals:
```julia
julia> @interval(0.1)
[0.09999999999999999, 0.1]
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
[3.5999999999999996, 3.6000000000000005]
```

The upper and lower bounds of the interval may be accessed using the fields
`lo` and `hi`:
```julia
julia> b.lo
3.5999999999999996

julia> b.hi
3.6000000000000005
```

The diameter (length) of an interval is obtained using `diam(b)`;
for numbers that cannot be represented in base 2
(i.e., whose *binary* expansion is infinite or exceeds the current precision),
 the diameter of newly-created thin intervals corresponds to the local machine epsilon (`eps`) in the `:narrow` interval rounding mode:

```julia
julia> diam(b)
8.881784197001252e-16

```

## Arithmetic

Basic arithmetic operations (`+`, `-`, `*`, `/`, `^`) are defined for pairs of intervals in a standard way (see, e.g., the book by Tucker): the result is the smallest interval containing the result of operating with each element of each interval. That is, for two intervals $X$ and $Y$ and an operation $\circ$, we define the operation on the two intervals by
$$X \circ Y := \{ x \circ y: x \in X \text{ and } y \in Y \}.$$  Again, directed rounding is used if necessary.

For example:
```julia
julia> a = @interval(0.1, 0.3)
[0.09999999999999999, 0.30000000000000004]

julia> b = @interval(0.3, 0.6)
[0.29999999999999993, 0.6000000000000001]

julia> a + b
[0.3999999999999999, 0.9000000000000001]
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
This may be changed using the `set_interval_precision` function:

```julia
julia> set_interval_precision(256)
256

julia> @interval 3π/2 + 1
[5.712388980384689857693965074919254326295754099062658731462416888461724609429262e+00, 5.712388980384689857693965074919254326295754099062658731462416888461724609429401e+00]₂₅₆
```
The subscript `256` at the end denotes the precision.

To change back to `Float64`s, use
```julia
julia> set_interval_precision(Float64)
Float64

julia> @interval(pi)
[3.141592653589793, 3.1415926535897936]
```

To check which mode is currently set, use
```julia
julia> get_interval_precision()
(Float64,-1)
```
The result is a tuple of the type (currently `Float64` or `BigFloat`) and the precision (relevant only for `BigFloat`s).

NB: The standard Julia function `setprecision` is used internally by `set_interval_precision`, but it should not be used directly, since `set_interval_precision` carries out additional steps to ensure internal consistency of certain interval operations.

## Elementary functions

The main elementary functions are defined, acting on interval arguments.
Currently, `exp`, `log`, `sin`, `cos` and `tan` are implemented, e.g.
```
julia> sin(@interval(1))
[0.8414709848078965, 0.8414709848078965]
```
Again, the result should contain the result of applying the function to each real number contained in the interval.

**However**, as can be seen from the above result, currently **directed rounding is *not* implemented** for elementary functions of `Float64`s. [We are aiming to incorporate this functionality in v0.2 via the [`crlibm` package](http://lipforge.ens-lyon.fr/www/crlibm/).]

Currently, this may be correctly calculated by using `BigFloat`s with a precision of 53 bits (the same as that of `Float64`s):

```julia
julia> set_interval_precision(53)
53

julia> sin(@interval(1))
[8.414709848078965e-01, 8.4147098480789662e-01]₅₃

julia> @interval sin(0.1) + cos(0.2)
[1.0798999944880696e+00, 1.0798999944880701e+00]₅₃
```

Note, however, that calculations with `BigFloat`s are carried out in software, and so are slower than operating with  `Float64`s directly.

## Interval rounding modes
By default, the directed rounding used corresponds to using the `RoundDown` and `RoundUp` rounding modes when performing calculations; this gives the narrowest resulting intervals, and is set by

```julia
set_interval_rounding(:narrow)
```

An alternative rounding method is to perform calculations using the (standard) `RoundNearest` rounding mode, and then widen the result by one machine epsilon in each direction using `prevfloat` and `nextfloat`. This is achived by
```julia
set_interval_rounding(:wide)
```
It generally results in wider intervals, but seems to be significantly faster.

The current interval rounding mode may be obtained by
```julia
get_interval_rounding()
```
