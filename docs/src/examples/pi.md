In this example, we compute rigorous bounds on ``\pi`` using interval arithmetic[^1], via the [`IntervalArithmetic.jl`](https://github.com/JuliaIntervals/IntervalArithmetic.jl) package.

[^1]: W. Tucker, [*Validated Numerics: A Short Introduction to Rigorous Computations*](https://press.princeton.edu/books/hardcover/9780691147819/validated-numerics), Princeton University Press, 2011.

There are many ways to calculate ``\pi``. For illustrative purposes, we will use the following sum

```math
S \bydef \sum_{n=1}^\infty \frac{1}{n^2}.
```

According to the [Basel Problem](https://en.wikipedia.org/wiki/Basel_problem), the exact value is ``S = \frac{\pi^2}{6}``. Thus, if we can calculate a rigorous enclosure of ``S``, then we can deduce a rigorous enclosure of ``\pi``.

First, we split ``S`` into a finite and infinite part, ``S = S_N + T_N``, where

```math
S_N \bydef \sum_{n=1}^N \frac{1}{n^2}, \qquad
T_N \bydef S - S_N = \sum_{n=N+1}^\infty \frac{1}{n^2}.
```

Using integrals from below and above, we obtain ``\frac{1}{N+1} \le T_N \le \frac{1}{N}``. It remains to compute rigorous bounds for ``S_N``, which can be found by calculating the sum using interval arithmetic:

```@example pi
using IntervalArithmetic

function forward_sum(N)
    S_N = interval(0)

    for i ∈ 1:N
        S_N += interval(1) / interval(i) ^ interval(2)
    end

    T_N = interval(1) / interval(N, N+1)

    S = S_N + T_N

    return sqrt(interval(6) * S)
end

pi_interval = forward_sum(10^6)

midradius(pi_interval)
```

The above computation shows that the midpoint of the computed interval is correct to about 10 decimal places. We can also verify directly that ``\pi`` is indeed contained in the interval:

```@example pi
in_interval(π, pi_interval)
```

Lastly, let us note that, due to floating-point arithmetic, computing the sum in the opposite direction yields a more accurate answer:

```@example pi
function backward_sum(N)
    S_N = interval(0)

    for i ∈ N:-1:1
        S_N += interval(1) / interval(i) ^ interval(2)
    end

    T_N = interval(1) / interval(N, N+1)

    S = S_N + T_N

    return sqrt(interval(6) * S)
end

improved_pi_interval = backward_sum(10^6)

midradius(improved_pi_interval)
```
