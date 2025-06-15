# The submodule Symbols

IntervalArithmetic includes the submodule Symbols to make coding a bit simpler with respect to the use of some functions of the library. Some examples are provided here.

```@repl
using IntervalArithmetic, IntervalArithmetic.Symbols
a = 0 .. 2
b = 1 ± 0.5
a ≛ a
b ⊑ a
b ⋤ a
∅ ⪽ ℝ
```

The following table summarizes the functions, the usage with the corresponding (unicode) symbols, how to obtain the symbol in Julia, and a brief description of the function.

| Function                           | Symbol    | Julia syntax        | Description                                                 |
|------------------------------------|-----------|---------------------|-------------------------------------------------------------|
| `interval(a, b; format=:infsup)`   | `..(a,b)` |                     | Create interval `[a, b]` using bounds                       |
| `interval(m, r; format=:midpoint)` | `±(m, r)` | `\pm<tab>`          | Create interval `[m - r, m + r]` using midpoint-radius form |
| `isequal_interval(x, y)`           | `≛(x, y)` | `\starequal<tab>`   | Check interval equality                                     |
| `issubset_interval(x, y)`          | `⊑(x, y)` | `\sqsubseteq<tab>`  | Check if `x` is a (non-strict) subset of `y`                |
| `isstrictsubset(x, y)`             | `⋤(x, y)` | `\sqsubsetneq<tab>` | Check if `x` is a strict subset of `y`                      |
| `isinterior(x, y)`                 | `⪽(x, y)` | `\subsetdot<tab>`   | Check if `x` is in the interior of `y`                      |
| `precedes(x, y)`                   | `⪯(x, y)` | `\preceq<tab>`      | Precedes relation                                           |
| `strictprecedes(x, y)`             | `≺(x, y)` | `\prec<tab>`        | Strictly precedes relation                                  |
| `hull(x, y)`                       | `⊔(x, y)` | `\sqcup<tab>`       | Interval hull of `x` and `y`                                |
| `intersect_interval(x, y)`         | `⊓(x, y)` | `\sqcap<tab>`       | Intersection of intervals                                   |
| `emptyinterval()`                  | `∅`       | `\emptyset<tab>`    | Empty interval                                              |
| `entireinterval()`                 | `ℝ`       | `\bbR<tab>`         | Entire real line                                            |
