Constructing an interval is the most basic operation in the library. The [`interval`](@ref) constructor is the standard way to create an interval.

```@repl construction
using IntervalArithmetic
setdisplay(:full) # print the interval in full
interval(0.1) # interval(Float64, 0.1)
interval(0.1, 0.2) # interval(Float64, 0.1, 0.2)
interval(3.1f0) # interval(Float32, 3.1f0)
interval(π) # interval(Float64, π)
interval(BigFloat, π)
interval(Inf) # not valid since infinity is not part of an interval
interval(3, 2) # not valid since the lower bound is strictly greater than the upper bound
```

The above intervals came with a decoration. Decorations are flags, or labels, attached to intervals to indicate the status of a given interval. Decorated intervals provide valuable information on the result of evaluating a function on an initial interval.

Suppose that a decorated interval $(X, d)$ is the result of evaluating a function $f$, or the composition of a sequence of functions, on an initial decorated interval $(X_0, d_0)$. The meaning of the resulting decoration $d$ is as follows:
- `com` (common): $X$ is a closed, bounded, non-empty subset of the domain of $f$; $f$ is continuous on the interval $X$; and the resulting interval $f(X)$ is bounded.
- `dac` (defined and continuous): $X$ is a non-empty subset of $\mathrm{Dom}(f)$, and $f$ is continuous on $X$.
- `def` (defined): $X$ is a non-empty subset of $\mathrm{Dom}(f)$, i.e. $f$ is defined at each point of $X$.
- `trv` (trivial): always true; gives no information
- `ill` (ill-formed): NaI (Not an Interval) (an error occurred), e.g. $\mathrm{Dom}(f) = \emptyset$.
Decorations follow the ordering `com > dac > def > trv > ill`.

When constructing intervals, if no decoration is explicitly specified, then it is initialised with a decoration according to the underlying bare interval:
- `com`: if the interval is non-empty and bounded
- `dac`: if the interval is unbounded
- `trv`: if the interval is empty
- `ill`: if the interval is a NaI

An explicit decoration may be provided for advanced use.

```@repl construction
x = interval(1, 2, dac)
interval(x, def)
```

The submodule `IntervalArithmetic.Symbols` exports the infix operator `..` and `±` as an alias for `interval`.

```@repl construction
using IntervalArithmetic.Symbols
0.1 .. 0.2 # interval(0.1, 0.2; format = :standard)
0.1 ± 0.2 # interval(0.1, 0.2; format = :midpoint)
```

The various string formats are as follows:
- no string parameter, `"Empty"` and `"[Empty]"` returns `emptyinterval()`
- `"entire"`, `"[entire]"` and `"[,]"` returns `entireinterval()`
- `"[nai]"` returns a `NaI`
- `"[m]"` returns `interval(m, m)`
- `"[l, r]"` returns `interval(l, r)`
- `"m?r"` returns `interval(m-r, m+r)`
- `"m?ren"` returns `interval((m-r)*1en, (m+r)*1en)`
- `"m?rd"` returns `interval(m-r, m)`
- `"m?ru"` returns `interval(m, m+r)`
- `"m?"` returns `interval(m + 5 precision units, m - 5 precision units)`
- `"m??"` returns `interval(-Inf, +Inf)`
- `"m??d"` returns `interval(-Inf, m)`
- `"m??u"` returns `Interval(m, +Inf)`
To add a specific decoration, add `"_dec"` at the end of the string.

!!! warning
    Most real numbers cannot be exactly represented by floating-points. In such cases, the literal expression is rounded at parse time. To construct an interval enclosing the true real number, one must rely on the string constructor mentioned above.

    For instance, consider

    ```@repl construction
    x = 0.1
    ```

    This appears to store the real number ``1/10`` in a variable `x` of type `Float64`. Yet,

    ```@repl construction
    x > 1//10
    ```

    Hence, the floating-point `0.1` is (slightly) greater than the real number ``1/10`` since ``1/10`` *cannot be represented exactly in binary floating-point arithmetic, at any precision*. The true value must be approximated by a floating-point number with fixed precision -- this procedure is called rounding.

    In particular, this implies that `interval(0.1)` *does not* contain the real number ``1/10``. A valid interval containing the real number ``1/10`` can be constructed by

    ```@repl construction
    I"0.1"
    ```



## More on decorations

```
julia> X1 = Interval(0.5, 3)
[0.5, 3]_com

julia> sqrt(X1)
[0.707106, 1.73206]_com
```
In this case, both input and output are "common" intervals, meaning that they are closed and bounded, and that the resulting function is continuous over the input interval, so that fixed-point theorems may be applied. Since `sqrt(X1) ⊆ X1`, we know that there must be a fixed point of the function inside the interval `X1` (in this case, `sqrt(1) == 1`).

```
julia> X2 = Interval(3, ∞)
[3, ∞]_dac

julia> sqrt(X2)
[1.73205, ∞]_dac
```
Since the intervals are unbounded here, the maximum decoration possible is `dac`.

```
julia> X3 = Interval(-3, 4)
[-3, 4]_com

julia> sign(X3)
[-1, 1]_def
```
The `sign` function is discontinuous at 0, but is defined everywhere on the input interval, so the decoration is `def`.

```
julia> X4 = Interval(-3.5, 4.1)
[-3.5, 4.1]_com

julia> sqrt(X4)
[0, 2.02485]_trv
```
The negative part of `X` is discarded by the `sqrt` function, since its domain is `[0,∞]`. (This process of discarding parts of the input interval that are not in the domain is called "loose evaluation".) The fact that this occurred is, however, recorded by the resulting decoration, `trv`, indicating a loss of information: "nothing is known" about the relationship between the output interval and the input.


In this case, we know why the decoration was reduced to `trv`. But if this were just a single step in a longer calculation, a resulting `trv` decoration shows only that something like this happened *at some step*. For example:

```
julia> X5 = Interval(-3, 3)
[-3, 3]_com

julia> asin(sqrt(X5))
[0, 1.5708]_trv

julia> X6 = Interval(0, 3)
[0, 3]_com

julia> asin(sqrt(X6))
[0, 1.5708]_trv
```
In both cases, `asin(sqrt(X))` gives a result with a `trv` decoration, but
we do not know at which step this happened, unless we break down the function into its constituent parts:
```
julia> sqrt(X5)
[0, 1.73206]_trv

julia> sqrt(X6)
[0, 1.73206]_com
```
This shows that loose evaluation occurred in different parts of the expression in the two different cases.

In general, the `trv` decoration is thus used only to signal that "something unexpected" happened during the calculation. Often this is later used to split up the original interval into pieces and reevaluate the function on each piece to refine the information that is obtained about the function.
