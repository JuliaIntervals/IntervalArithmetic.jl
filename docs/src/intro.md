# Introduction to Interval Arithmetic

The basic idea in Interval Arithmetic is to calculate with entire *sets* of real numbers, of which the simplest type are closed intervals
$[a,b] := \{x \in \mathbb{R}: a \le x \le b \}$.

We define arithmetic operations and functions to act on intervals, in such a way that the result of the calculation is a new interval that is guaranteed to contain the true range of the function.

For example, for monotone functions like `exp`, we define
```
exp([a, b]) := [exp(a), exp(b)]
```
For non-monotone functions, like the squaring function, it is more complicated:
```
[a, b]^2 := [a^2, b^2]  if 0 < a < b
          = [0, max(a^2, b^2)]  if a < 0 < b
          = [b^2, a^2] if a < b < 0
```
We also have to round the lower endpoint down and the upper endpoint up to get guaranteed containment of the true result, since we are using floating-point arithmetic.

For more information on how different functions behave in Interval Arithmetic, refer to [Interval Arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic)

Once we have done this for all basic functions, we can define a complicated Julia function like
```
f(x) = sin(3x^2 - 2 cos(1/x))
```
and feed an interval in. Since at each step of the process, the result is an interval that is guaranteed to contain the range, the whole function has the same property.

For example,
```
using IntervalArithmetic

julia> using IntervalArithmetic

julia> f(x) = x^2 - 2
f (generic function with 1 method)

julia> X = 3..4
[3, 4]

julia> f(X)
[7, 14]
```
Since `f(X)` does not contain 0, the true range of the function $f$ over the set $X$ is guaranteed not to contain 0, and hence we have

**Theorem:** The function $f$ has no root in the interval $[3,4]$.

This theorem has been obtained using *just floating-point calculations*!

Further, we can even extend this to semi-infinite intervals:
```
julia> f(3..∞)
[7, ∞]
```
Thus we have *excluded the entire domain [3, ∞) from possibly containing roots of $f$.*

To move beyond just excluding regions and to actually guaranteeing existence and uniqueness for smooth functions, we use an interval version of the Newton method, which is described a bit [here](https://juliaintervals.github.io/IntervalRootFinding.jl/latest/).
