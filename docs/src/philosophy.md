# Philosophy

The goal of the `Interval` type is to be directly used to replace floating point
numbers in arbitrary julia code, such that, in any calculation,
the resulting interval is guaranteed to bound the true image of the starting
intervals.

So, essentially, we would like `Interval` to act as numbers.
And the julia ecosystem has evolved to use `Real` as the default supertype
for numerical types that are not complex.
Therefore, to ensure the widest compatiblity,
our `Interval` type must be a subtype of `Real`.

Mathematically, for any function `f(x::Real)`,
we want the following to hold
(note that it holds for **all** real numbers in `X`,
even those that cannot be represented as floating point numbers):
```math
f(x) \in f(X), \qquad \forall x \in X.
```
The interval-valued function `f(X)` is called
the _pointwise extension_ of `f(x)` (which is defined on real numbers).

At first glance, this is reasonable:
all arithmetic operations are well-defined for both real numbers and intervals,
therefore we can use multiple dispatch to define the interval behavior of
operations such has `+`, `/`, `sin` or `log`.
Then a code written for `Real`s can be used as is with `Interval`s.

However, being a `Real` means way more than just being compatible with
arithmetic operations.
`Real`s are also expected to

1. Be compatible with any other `Number` through promotion.
2. Support comparison operations, such as `==` or `<`.
3. Act as a container of a single element,
   e.g. `collect(x)` returns a 0-dimensional array containing `x`.

Each of those points lead to specific design choices for `IntervalArithmetic.jl`,
choices that we detail below.



## Compatibility with other `Number`s

In julia it is expected that `1 + 2.2` silently promoted the integer `1`
to a `Float64` to be able to perform the addition.
Following this logic, it means that `0.1 + interval(2.2, 2.3)` should
silently promote `0.1` to an interval.

However, in this case we cannot guarantee that `0.1` is known exactly,
because we do not know how it was produced in the first place
(it could be contain numerical inaccuracy from another computation from example).
Following the julia convention is thus in contradiction with providing
guaranteed result.

In this case, we choose to be mostly silent,
the information that a non-interval of unknown origin is recorded in the `NG` flag,
but the calculation is not interrupted, and no warning is printed.
If an interval is flagged with `NG` it means that it was produced through
promotion of real numbers from unknown origin, for example
```julia
julia> X = interval(1, 2)
[1.0, 2.0]_com  # The interval is guaranteed because it was explicitly created

julia> X + 0.1
[1.1, 2.1]_com_NG  # The NG flag appears, because 0.1 is not provably exact
```

For convenience, we provide the [`ExactReal`](@ref) and [`@exact`](@ref) macro
to allow explicitly marking a number as being exact,
and not produce the `NG` flag when mixed with intervals.

Note that this still assume that all interval inputs are correct.
Please see the [contructors page](@ref "Constructing intervals") for more information
about potential caveats.


## Comparison operators

We can extend the definition of the pointwise extension of a function `f` for two real numbers
`x` and `y`, and their respective intervals `X` and `Y`, as
```math
f(x, y) \in f(X, Y), \qquad \forall x \in X, y \in Y.
```

With this in mind, an operation such as `==` can easily be defined for intervals

1. If the intervals are disjoints (`X ∩ Y === ∅`), then `X == Y` is `[false]`.
2. If the intervals both contain a single floating point number,
   and that element is the same for both,
   `X == Y` is `[true]`.
3. Otherwise, we can not conclude anything, and `X == Y` must be `[false, true]`.

Not that we use intervals for all outputs, because, according to our definition,
the true result must be contained in the returned interval.
However, this is not convenient, as any `if` statement would error when used
with an interval.
Instead, we have opted to return respectively `false` and `true`
for cases 1 and 2, and to immediately error otherwise.

In this way, we can return a more informative error,
but we only error when the result is ambiguous.

This has a clear cost, however, in that some expected behaviors do not hold.
For example, an `Interval` is not equal to itself.

```julia
julia> X = interval(1, 2)
[1.0, 2.0]_com

julia> X == X
ERROR: ArgumentError: `==` is purposely not supported when the intervals are overlapping. See instead `isequal_interval`
Stacktrace:
 [1] ==(x::Interval{Float64}, y::Interval{Float64})
   @ IntervalArithmetic C:\Users\Kolaru\.julia\packages\IntervalArithmetic\XjBhk\src\intervals\real_interface.jl:86
 [2] top-level scope
   @ REPL[6]:1.
```



## Intervals as sets

We have taken the perspective to always let `Interval`s act as if they were numbers.

But they are also sets of numbers,
and it would be nice to use all set operations defined in julia on them.

However, `Real` are also sets. For example, the following is valid

```julia
julia> 3 in 3
true
```

Then what should `3 in interval(2, 6)` do?

For interval as a set, it is clearly `true`.
But for intervals as a subtype of `Real` this is equivalent to
```julia
3 == interval(2, 6)
```
which must either be false (they are not the same things),
or error as the result can not be established.

To be safe, we decided to go one step further and disable
**all** set operations from julia `Base` on intervals.
These operations can instead be performed with the specific `*_interval` function,
for example `in_interval` as a replacement for `in`.

`setdiff` is an exception,
as we can not meaningfully define the set difference of two intervals,
because our intervals are always closed,
while the result of `setdiff` can be open.


## `hash`

The function `hash` is the only case where we do not define the value of
a function based on its interval extension.

`hash` return a single hash, and not an interval bounding the image
of the function.

```julia
julia> hash(interval(1, 2))
0xda823f68b9653b1a

julia> hash(1.2) in hash(interval(-10, 10))
false
```

This is justified as `hash` is not a mathematical function,
and julia requires that `hash` returns a `UInt`.

# Summary

| | Functions | Behavior | Note |
| :---- | :---- | :---- | :---- |
| Arithmetic operations | `+`, `-`, `*`, `/`, `^` | Interval extension | Produce the `NG` flag when mixed with non-interval |
| Other numeric function | `sin`, `exp`, `sqrt`, etc. | Interval extension |  |
| Boolean operations | `==`, `<`, `<=`, `iszero`, `isnan`, `isinteger`, `isfinite` | Error if the result can not be guaranteed to be either `true` or `false` | See [`isequal_interval`](@ref) to test equality of intervals, and [`isbounded`](@ref) to test the finiteness of the elements |
| Set operations | `in`, `issubset`, `isdisjoint`, `issetequal`, `isempty`, `union`, `intersect` | Always error | Use the `*_interval` function instead (e.g. [`in_interval`](@ref))
| Exceptions | `≈`, `setdiff` | Always error | No meaningful interval extension |
| Hash | `hash` | Hash the interval as a julia object | |
