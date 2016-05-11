# Why is rounding necessary?

What happens when we write the following Julia code?
```
julia> x = 0.1
0.1
```

This appears to store the value `0.1` in a variable `x` of type `Float64`.
In fact, however, it stores a *slightly different* number, since `0.1` *cannot be represented exactly in binary floating point arithmetic, at any precision*.

The true value that is actually stored in the variable can be conveniently determined in Julia using arbitrary-precision arithmetic with `BigFloat`s:

```
julia> big(0.1)
1.000000000000000055511151231257827021181583404541015625000000000000000000000000e-01
```

So, in fact, the Julia float `0.1` refers to a real number that is slightly greater than 0.1. By default, such calculations are done in round-to-nearest mode (`RoundNearest`); i.e., the nearest representable floating-point number to 0.1 is used.

[Recall that to get a `BigFloat` that is as close as possible to the true 0.1, you can use a special string macro:

```
julia> big"0.1"
1.000000000000000000000000000000000000000000000000000000000000000000000000000002e-01
```
]

Suppose that we create a thin interval, containing just the floating-point number `0.1`:
```
julia> II = Interval(0.1)
[0.1, 0.100001]

julia> showall(II)
Interval(0.1, 0.1)
```

It looks like `II` contains (the true) 0.1, but from the above discussion we see that *it does not*. In order to contain 0.1, the end-points of the interval must be rounded outwards ("directed rounding"): the lower bound is rounded down, and the upper bound is rounded up.

This rounding is handled by the `@interval`  macro, which generates correctly-rounded intervals:

```julia
julia> a = @interval(0.1)
[0.0999999, 0.100001]
```

The true 0.1 is now correctly contained in the intervals, so that any calculations on these intervals will contain the true result of calculating with 0.1. For example, if we define
```julia
julia> f(x) = 2x + 0.2
```
then we can apply the function `f` to the interval `a` to obtain

```julia
julia> f(a)
[0.399999, 0.400001]

julia> showall(f(a))
Interval(0.39999999999999997, 0.4)
```
The result correctly contains the true 0.4.

## More detail: the internal representation
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

The true value must be approximated by a floating-point number with fixed precision -- this procedure is called **rounding**. For positive numbers, rounding down may be accomplished simply by truncating the expansion; rounding up is accomplished by incrementing the final binary digit and propagating any resulting changes.
