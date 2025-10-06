# Constructing intervals

The library provides two interval types. The first one is [`BareInterval`](@ref), corresponding to a basic implementation of intervals, stored by their infimum and supremum. The second type is [`Interval`](@ref) and builds on top of bare intervals, with the additional fields `decoration` and `isguaranteed`. See the sections below.

```@repl construction
using IntervalArithmetic
setdisplay(:full) # print the interval in full
bareinterval(1, π) # `bareinterval(Float64, 1, π)`
interval(1, π) # `interval(Float64, 1, π)`, interval decorated with `com` (common)
```

Therefore, we **strongly recommend the use of [`Interval`](@ref) over [`BareInterval`](@ref)** to better track the effect of functions according to the IEEE Standard 1788-2015 specifications. For instance, taking the square root of an interval discards the negative part of the interval, without any notice for bare intervals:

```@repl construction
sqrt(bareinterval(-1, 1)) # `sqrt(bareinterval(0, 1))`
sqrt(interval(-1, 1)) # interval decorated with `trv` (trivial)
```



### Decorations

A *decoration* is a label that indicates the status of a given interval. Decorated intervals provide valuable information on the result of evaluating a function on an initial interval.

Upon the application of a function ``f`` on an interval ``x``, the resulting interval ``f(x)`` has either one of the following decorations:

- `com` (common): ``x`` is a closed, bounded, non-empty subset of the domain of ``f``, ``f`` is continuous on the interval ``x``, and ``f(x)`` is bounded.

- `dac` (defined and continuous): ``x`` is a non-empty subset of the domain of ``f``, and ``f`` is continuous on ``x``.

- `def` (defined): ``x`` is a non-empty subset of the domain of ``f``; in other words, ``f`` is defined at each point of ``x``.

- `trv` (trivial): ``f(x)`` carries no meaningful information.

- `ill` (ill-formed): ``f(x)`` is Not an Interval (NaI).

Each decoration is paired with an integer as follows: `ill = 0`, `trv = 1`, `def = 2`, `dac = 3` and `com = 4`. Then, decorations degrade according to the propagation order `com > dac > def > trv > ill`.

One can specify a decoration when constructing intervals. Otherwise, the interval is initialised with a decoration according to the underlying bare interval:

- `com`: non-empty and bounded.

- `dac`: unbounded.

- `trv`: empty.

- `ill`: NaI.


#### Examples

##### Common

```@repl construction
x = interval(0.5, 3)
sqrt(x)
```

Both input `x` and output `sqrt(x)` are common intervals since they are closed, bounded, non-empty and the square root is continuous over ``[1/2, 3]``.

Observe that these decorations, together with the fact that any element of the interval `sqrt(x)` is also in the interval `x`, imply that the [Schauder Fixed-Point Theorem](https://en.wikipedia.org/wiki/Schauder_fixed-point_theorem) is satisfied. More precisely, this computation proves the existence of a fixed-point of the square root in ``[1/2, 3]`` (in this simple example, ``\sqrt(1) = 1``).

##### Defined and continuous

```@repl construction
x = interval(3, Inf)
sqrt(x)
```

Both the intervals are unbounded, hence the maximum possible decoration is `dac`.

Note that overflows can also produce the decoration `dac`:

```@repl construction
x = interval(floatmax(Float64))
x + interval(1)
```

##### Defined and continuous

```@repl construction
x = interval(-3, 4)
sign(x)
```

The ``\sign`` function is discontinuous at ``0``, but is defined everywhere on the input interval, so the decoration of the result is `def`.

##### Trivial

```@repl construction
x = interval(-3.5, 4)
sqrt(x)
```

The negative part of `x` is discarded before evaluating the square root since its domain is ``[0, \infty)``. The process of discarding parts of an interval that are not in the domain of a function is called *loose evaluation*. This event has been recorded by degrading the decoration of the resulting interval to `trv`, indicating that nothing is known about the relationship between `x` and `sqrt(x)`.

In this case, we know why the decoration was reduced to `trv`. Generally, if this were just a single step in a longer calculation, a resulting decoration `trv` shows only that something like this occured at some step.

For instance,

```@repl construction
f = asin ∘ sqrt
x = interval(-3, 3)
f(x)
y = interval(0, 3)
f(y)
```

In both cases, `asin(sqrt(X))` gives a result with the decoration `trv`; to find out where things went wrong, the function must be analyzed.

```@repl construction
sqrt(x) # `f(x)` has the decoration is `trv` since `x` contains negative values
sqrt(y) # the decoration is `com`
asin(sqrt(y)) # `f(x)` has the decoration is `trv` since `sqrt(y)` contains values stricly greater than `1`
```

This shows that loose evaluation occurred in different parts of `f` for `x` and `y`.

!!! danger
    The decoration `trv` is an indicator of information loss. Often this also reveals that something unexpected occured. Therefore, any interval marked by this decoration may not be trusted and the code may need to be revised.

##### Ill-formed

```@repl construction
interval(2, 1)
interval(NaN)
```

These are all examples of ill-formed intervals,
also known as `NaI`, resulting in the decoration `ill`.

Similarly to the floating point `NaN`,
all boolean operations on an ill-formed interval return `false`.

!!! danger
    The decoration `ill` is an indicator that an error has occured.
    Therefore, when an ill-formed interval is created, a warning is raised.
    Any interval marked by this decoration cannot be trusted and the code needs to be debugged.


### More constructors

The submodule `IntervalArithmetic.Symbols` exports the infix operator `..` and `±` as an alias for `interval`; this submodule must be explicitly imported.

```@repl construction
using IntervalArithmetic.Symbols
0.1 .. 0.2 # interval(0.1, 0.2; format = :infsup)
0.1 ± 0.2 # interval(0.1, 0.2; format = :midpoint)
```

Moreover, one can parse strings into intervals. The various string formats are the following:

- `"[m]"` is equivalent to `interval(m, m)`.

- `"[l, r]"` is equivalent to `interval(l, r)`.

- `"m?r"` is equivalent to `interval(m-r, m+r)`.

- `"m?ren"` is equivalent to `interval((m-r)*1en, (m+r)*1en)`.

- `"m?rd"` is equivalent to `interval(m-r, m)`.

- `"m?ru"` is equivalent to `interval(m, m+r)`.

- `"m?"` is equivalent to `interval(m + 5 precision units, m - 5 precision units)`.

- `"m??"` is equivalent to `interval(-Inf, +Inf)`.

- `"m??d"` is equivalent to `interval(-Inf, m)`.

- `"m??u"` is equivalent to `interval(m, +Inf)`.

- `"[Entire]"`, `"[entire]"` and `"[,]"` are equivalent to `entireinterval()`.

- `"[Empty]"`, `"[empty]"` and `"[]"` are equivalent to `emptyinterval()`.

- `"[nai]"` and any other unsupported string formats are equivalent to `nai()`.

To add a specific decoration, add `"_com"`, `"_dac"`, `"_dec"`, `"_trv"` and `"_ill"` at the end of the string.

!!! danger
    Most real numbers cannot be exactly represented by floating-points. In such cases, the literal expression is rounded at parse time. To construct an interval enclosing the true real number, one must rely on the string constructor mentioned above.

    For instance, consider

    ```@repl construction
    x = 0.1
    ```

    This appears to store the real number ``1/10``  in a variable `x` of type `Float64`. Yet,

    ```@repl construction
    x > 1//10
    ```

    Hence, the floating-point `0.1` is (slightly) greater than the real number ``1/10`` since ``1/10`` **cannot be represented exactly in binary floating-point arithmetic, at any precision**. The true value must be approximated by a floating-point number with fixed precision -- this procedure is called rounding.

    In particular, this implies that `interval(0.1)` **does not** contain the real number ``1/10``. A valid interval containing the real number ``1/10`` can be constructed by

    ```@repl construction
    I"0.1"
    ```
