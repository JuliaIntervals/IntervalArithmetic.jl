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

It looks like the interval contains the true value 0.1, but from the above discussion we see that, in fact, *it does not*. In order to contain the true value 0.1, the end-points of the interval must be rounded outwards ("directed rounding"): the lower bound is rounded down, and the upper bound is rounded up. 

This rounding is handled by the `@interval`  macro, which generates correctly-rounded intervals:

```julia
julia> a = @interval(0.1)
[0.09999999999999999, 0.1]
```

The true 0.1 is now correctly contained in the intervals, so that any calculations on these intervals will contain the true result of calculating with 0.1. For example, if we define
```julia
julia> f(x) = 2x + 0.2
```
then we can apply the function `f` to the interval `a` to obtain
```julia
julia> f(a)
[0.39999999999999997, 0.4]
```
The result correctly contains the true 0.4.

## More detail
Let's look at the internal representation of the `Float64` number 0.1:

```julia
julia> bits(0.1)
"0011111110111001100110011001100110011001100110011001100110011010"
```
The last 53 bits of these 64 bits correspond to the binary expansion of 0.1, which is
```
0.000110011001100110011001100110011001100...
```
We see that the expansion is periodic; in fact, the binary expansion of 0.1 has an infinite repetition of the sequence of digits `1100`. It is thus *impossible* to represent the decimal 0.1 in binary, with *any* precision.

Julia allows us to get closer to the true value using `BigFloat`s:
```julia
julia> using Compat

julia> @compat parse(BigFloat, "0.1")
1.000000000000000000000000000000000000000000000000000000000000000000000000000002e-01 with 256 bits of precision
```
But the 2 and the end of the decimal expansion is the giveaway that this number is still not exactly 0.1

The true value must be approximated by a floating-point number with fixed precision -- this procedure is called **rounding**. Rounding down may be accomplished simply by truncating the expansion; rounding up is accomplished by incrementing the final binary digit and propagating any resulting changes.