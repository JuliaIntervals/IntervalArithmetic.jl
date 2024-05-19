# Overview

The basic idea in [interval arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic) is to perform computations with a whole interval of real numbers

```math
[a, b] \bydef \{x \in \mathbb{R}: a \le x \le b \},
```

where ``a, b \in \mathbb{R} \cup \{ \pm \infty \}``; note that despite the above notation, ``[a, b]`` does not contain infinity when ``a`` or ``b`` are infinite.

We define functions on intervals in such a way that the result of the computation is a new interval that is guaranteed to contain the true range of the function.

For instance, by monotonicity, the exponential function is given by

```math
e^{[a, b]} \bydef [e^a, e^b].
```

On the other hand, the squaring function is non-monotone, thus it is given by the following cases

```math
[a, b]^2 \bydef
\begin{cases}
[a^2, b^2], &  0 \le a \le b, \\
[0, \max(a^2, b^2)], & a \le 0 \le b, \\
[b^2, a^2], & a \le b \le 0.
\end{cases}
```

Of course, we must round the lower endpoint down and the upper endpoint up to get a guaranteed enclosure of the true result.

IntervalArithmetic defines such behaviour for a wide set of basic functions, thereby allowing the evaluation of more complex functions such as

```math
f(x) = \sin(3x^2 - 2 \cos(1/x))
```



## Applications

To illustrate the use of interval arithmetic, consider the following:

```@repl intro
using IntervalArithmetic
f(x) = x^2 - 2
x = interval(3, 4)
f(x)
```

Since `f(x)` does not contain `0`, the true range of the function ``f`` over the interval ``[3, 4]`` is guaranteed not to contain ``0``, and hence we obtain the following property.

**Theorem:** ``f`` has no root in the interval ``[3, 4]``.

This theorem has been obtained using floating-point computations! In fact, we can even extend this to semi-infinite intervals:

```@repl intro
f(interval(3, Inf))
```

Therefore, we have excluded the whole unbounded set ``[3, \infty)`` from possibly containing roots of ``f``.

Interval arithmetic is the foundation of more powerful and elaborate methods in the field of computer-assisted proofs (see e.g. [IntervalRootFinding.jl](https://juliaintervals.github.io/IntervalRootFinding.jl)).

The interested reader may refer to the following books:
- R. E. Moore, R. B. Kearfott and M. J. Cloud, [*Introduction to Interval Analysis*](https://doi.org/10.1137/1.9780898717716), Society for Industrial and Applied Mathematics (2009)
- W. Tucker, [*Validated Numerics: A Short Introduction to Rigorous Computations*](https://press.princeton.edu/books/hardcover/9780691147819/validated-numerics), Princeton University Press (2010)



## Compliance with the IEEE standard for interval arithmetic

[IntervalArithmetic.jl](https://juliaintervals.github.io/IntervalArithmetic.jl) complies with the specifications described in the [IEEE standard for interval arithmetic](https://ieeexplore.ieee.org/document/7140721).
However, the reverse-mode of functions are not implemented (see Section 10.5.4).
