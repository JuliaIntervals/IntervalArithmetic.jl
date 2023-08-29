# Constructing intervals

Constructing an interval is the most basic operation in the library. The [`interval`](@ref) constructor is the standard way to create an interval. It accepts one or two values, and an optional bound type.

```@repl construction
using IntervalArithmetic
setformat(:full) # print the interval in full
interval(0.1) # interval(Float64, 0.1)
interval(0.1, 0.2) # interval(Float64, 0.1, 0.2)
interval(3.1f0) # interval(Float32, 3.1f0)
interval(π) # interval(Float64, π)
interval(BigFloat, π)
interval(Inf) # not valid since infinity is not part of an interval
interval(3, 2) # not valid since the lower bound is strictly greater than the upper bound
```

The submodule `IntervalArithmetic.Symbols` exports the infix operator `..` as an alias for `interval`.

```@repl construction
using IntervalArithmetic.Symbols
0.1..0.2 # interval(0.1, 0.2)
```

The [`±`](@ref) (`\pm<tab>`) infix operator creates the interval from the midpoint and the radius.

```@repl construction
0 ± 1
```

The various string formats are as follows:
- No string parameter or `Empty` string ("[Empty]") returns an empty interval.
- `entire` ("[entire]") and "[,]" string returns entireinterval
- "[nai]" returns `Nai{Type}`
- "[m]" returns `Interval(m,m)`
- "[l, r]" returns `Interval(l, r)`
- "m?r" returns `Interval(m-r, m+r)`
- "m?ren" returns `Interval((m-r)en, (m+r)en)`
- "m?ru" or "m?rd" returns `Interval(m, m+r)` or `Interval(m-r, m)` respectively
- "m?" returns `Interval(m + 5 precision units, m - 5 precision units)`
- "m??" returns `Interval(-Inf, +Inf)`
- "m??u" or "m??d" returns `Interval(m, +Inf)` or `Interval(-Inf, m) respectively`

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
