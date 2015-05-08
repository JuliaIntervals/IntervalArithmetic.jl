# Why is rounding necessary?

Consider the Julia code

    x = 0.1

This apparently stores the value 0.1 in a variable `x` of type `Float64`.
In fact, however, it stores a *slightly different* number than 0.1, since 0.1 itself *cannot be represented in binary floating point arithmetic, at any precision*.

The value that is actually stored in the variable can be conveniently determined in Julia using arbitrary precision arithmetic (`BigFloat`s):

    julia> big(0.1)

    1.000000000000000055511151231257827021181583404541015625e-01 with 256 bits of precision

So, in fact, the value is slightly greater than 0.1. By default, such calculations are done in round-to-nearest mode (`RoundNearest`); i.e., the nearest representable floating-point number to 0.1 is used.

Suppose now that we created an interval as

    julia> II = Interval(0.1)
    [0.1, 0.1]

It looks like the interval contains the true value 0.1, but from the above discussion we see that, in fact, *it does not*! In order to contain the true value 0.1, the end-points of the interval must be rounded outwards: the lower bound is rounded down, and the upper bound is rounded up. This is all handled by the `@interval` and `@floatinterval` macros, which generate correctly-rounded intervals of `BigFloat`s and `Float64`s, respectively:

```
julia> a = @interval(0.1)
[9.9999999999999992e-02, 1.0000000000000001e-01]₅₃

julia> b = @floatinterval(0.1)
[0.09999999999999999, 0.1]
```
[Note the subscript "53" at the end of the first output, which indicates the precision of the `BigFloat`s contained in the interval.]

We see that the true 0.1 is now correctly contained in the intervals, so that any calculations on these intervals will contain the true result of calculating with 0.1. For example, if we define

    julia> f(x) = 2x + 0.2

then we can apply the function `f` to the interval `c` to obtain

    julia> f(a)
    [3.9999999999999997e-01, 4.0000000000000002e-01]₅₃

The result correctly contains the true 0.4.


### Creating intervals from expressions

The macros `@interval` and `@floatinterval` can also create intervals from expressions, e.g.

```
julia> @interval(2.3*3.4)
[7.8199999999999958e+00, 7.8200000000000021e+00]₅₃
```
Internally, each term in the expression is wrapped in the (non-exported) `make_interval` function; furthermore, floating-point numbers are converted into rationals.
