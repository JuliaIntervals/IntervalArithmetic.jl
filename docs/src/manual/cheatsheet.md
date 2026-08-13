# Cheat Sheet

A quick reference for IntervalArithmetic.jl v1.

## Type Hierarchy

| Type | Description | Subtype of `Real`? |
|------|-------------|:------------------:|
| [`BareInterval{T}`](@ref) | Raw interval `[lo, hi]`, no decoration | No |
| [`Interval{T}`](@ref) | Decorated interval with `isguaranteed` flag | Yes |
| [`ExactReal{T}`](@ref) | Wrapper asserting a number is exactly representable | Yes |

`T` must be a `NumTypes = Union{Rational, AbstractFloat}`.

## Creating Intervals

### The `interval` constructor (decorated, the main one)

```jldoctest cheatsheet
julia> setdisplay(:full);

julia> interval(1, 2)
Interval{Float64}(1.0, 2.0, com, true)

julia> interval(Float32, 1, 2)
Interval{Float32}(1.0f0, 2.0f0, com, true)

julia> interval(1)                       # thin (point) interval [1,1]
Interval{Float64}(1.0, 1.0, com, true)

julia> interval(1, 2, def)               # manually set decoration
Interval{Float64}(1.0, 2.0, def, true)

julia> interval(1, 0.5; format=:midpoint)  # midpoint-radius: 1 ± 0.5
Interval{Float64}(0.5, 1.5, com, true)
```

### The `bareinterval` constructor (no decoration)

```jldoctest cheatsheet
julia> bareinterval(1, 2)
BareInterval{Float64}(1.0, 2.0)
```

### String parsing (handles `0.1` correctly!)

```jldoctest cheatsheet
julia> I"0.1"                            # tight enclosure of 0.1
Interval{Float64}(0.09999999999999999, 0.1, com, true)

julia> I"[1, 2]"
Interval{Float64}(1.0, 2.0, com, true)

julia> I"[1, 2]_def"                     # with decoration
Interval{Float64}(1.0, 2.0, def, true)

julia> I"6.42?2"                         # uncertainty notation: [6.40, 6.44]
Interval{Float64}(6.3999999999999995, 6.44, com, true)

julia> I"6.42?2e2"                       # with exponent
Interval{Float64}(640.0, 644.0, com, true)

julia> I"3??u"                           # unbounded: [3, ∞]
Interval{Float64}(3.0, Inf, dac, true)
```

### Symbols: `..` and `±`

Requires `using IntervalArithmetic.Symbols`.

```jldoctest cheatsheet
julia> using IntervalArithmetic.Symbols

julia> 1 .. 2                            # same as interval(1, 2)
Interval{Float64}(1.0, 2.0, com, true)

julia> 1 ± 0.5                           # same as interval(1, 0.5; format=:midpoint)
Interval{Float64}(0.5, 1.5, com, true)
```

### Special intervals

```jldoctest cheatsheet
julia> emptyinterval()
∅_trv

julia> entireinterval()                  # ∞ NOT included (set-based flavor)
Interval{Float64}(-Inf, Inf, dac, true)

julia> nai()                             # Not an Interval
NaI
```

Unicode shortcuts (from `Symbols`): `∅` = `emptyinterval()`, `ℝ` = `entireinterval()`.

## ExactReal and the NG Flag

When a plain `Real` is implicitly converted to `Interval`, the result is **Not Guaranteed** (NG):

```jldoctest cheatsheet
julia> setdisplay(:infsup);

julia> interval(1) + 0                   # NG flag! (0 was converted implicitly)
[1.0, 1.0]_com_NG

julia> interval(1) + exact(0)            # no NG flag
[1.0, 1.0]_com

julia> isguaranteed(interval(1) + 0)
false

julia> isguaranteed(exact(1) + interval(1))
true
```

The [`@exact`](@ref) macro wraps all literals:

```jldoctest cheatsheet
julia> @exact g(x) = 1.5 * x + 0.25;

julia> g(interval(1, 2))                 # no NG
[1.75, 3.25]_com

julia> g(3.0)                            # works with plain numbers too
4.75
```

## Accessing Interval Data

```jldoctest cheatsheet
julia> setdisplay(:full);

julia> x = interval(1, 3);

julia> inf(x)                            # lower bound
1.0

julia> sup(x)                            # upper bound
3.0

julia> bounds(x)                         # (lo, hi) tuple
(1.0, 3.0)

julia> mid(x)                            # midpoint
2.0

julia> mid(x, 0.25)                      # relative: 0=lo, 1=hi
1.5

julia> diam(x)                           # width
2.0

julia> radius(x)                         # half-width
1.0

julia> midradius(x)                      # (mid, radius) tuple
(2.0, 1.0)

julia> mag(x)                            # max(|lo|, |hi|)
3.0

julia> mig(x)                            # min distance from 0
1.0

julia> decoration(x)
com

julia> numtype(x)
Float64

julia> isguaranteed(x)
true

julia> bareinterval(x)                   # strip decoration
BareInterval{Float64}(1.0, 3.0)
```

## Decorations

| Decoration | Value | Meaning |
|:----------:|:-----:|---------|
| `com` | 4 | **Common**: non-empty, bounded, continuous |
| `dac` | 3 | **Defined & continuous**: non-empty, continuous |
| `def` | 2 | **Defined**: non-empty |
| `trv` | 1 | **Trivial**: no useful info |
| `ill` | 0 | **Ill-formed**: NaI |

```jldoctest cheatsheet
julia> decoration(interval(1, 2))        # bounded
com

julia> decoration(entireinterval())      # unbounded but continuous
dac

julia> decoration(sqrt(interval(-1, 4))) # domain issue
trv

julia> decoration(nai())
ill
```

## Arithmetic

All standard arithmetic works with guaranteed outward rounding:

```jldoctest cheatsheet
julia> a, b = interval(1, 2), interval(3, 4);

julia> a + b
Interval{Float64}(4.0, 6.0, com, true)

julia> a - b
Interval{Float64}(-3.0, -1.0, com, true)

julia> a * b
Interval{Float64}(3.0, 8.0, com, true)

julia> a / b
Interval{Float64}(0.25, 0.6666666666666667, com, true)
```

### Powers: four variants

| Function | IEEE 1788? | Domain | Notes |
|----------|:----------:|--------|-------|
| [`pown`](@ref)`(x, n)` | Yes | full real line | exact for integer powers |
| [`pow`](@ref)`(x, y)` | Yes | positive reals | standard power |
| [`fastpown`](@ref)`(x, n)` | No | full real line | faster, maybe wider |
| [`fastpow`](@ref)`(x, y)` | No | positive reals | faster, maybe wider |

`^` dispatches to `fast*` by default (configurable via [`PowerMode`](@ref)).

```jldoctest cheatsheet
julia> interval(-1, 1) ^ interval(3)       # uses fastpown (integer detected)
Interval{Float64}(-1.0, 1.0, com, true)

julia> pown(interval(-1, 1), 3)             # IEEE-compliant pown
Interval{Float64}(-1.0, 1.0, com, true)

julia> rootn(interval(8, 27), 3)            # cube root
Interval{Float64}(2.0, 3.0, com, true)
```

### Standard functions

`sqrt`, `cbrt`, `exp`, `exp2`, `exp10`, `expm1`, `log`, `log2`, `log10`, `log1p`,
`sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `sinh`, `cosh`, `tanh`, etc.

### Extended division

Returns two intervals when dividing by an interval containing zero:

```jldoctest cheatsheet
julia> extended_div(interval(1, 2), interval(-1, 1))
(Interval{Float64}(-Inf, -1.0, dac, true), Interval{Float64}(1.0, Inf, trv, true))
```

### Complex intervals

```jldoctest cheatsheet
julia> z = complex(interval(1, 2), interval(3, 4));

julia> z * z
Interval{Float64}(-14.0, -5.0, com, true) + im*Interval{Float64}(6.0, 16.0, com, true)
```

## Boolean / Comparison Functions

Standard Julia comparisons (`==`, `<`, `in`, `issubset`, `isempty`, etc.) are **deliberately disabled** for intervals. Use the interval-specific versions:

| Don't use | Use instead |
|-----------|-------------|
| `x == y` | [`isequal_interval`](@ref)`(x, y)` |
| `x < y` | [`strictprecedes`](@ref)`(x, y)` |
| `x in y` | [`in_interval`](@ref)`(x, y)` |
| `isempty(x)` | [`isempty_interval`](@ref)`(x)` |
| `issubset(x, y)` | [`issubset_interval`](@ref)`(x, y)` |
| `intersect(x, y)` | [`intersect_interval`](@ref)`(x, y)` |
| `union(x, y)` | [`hull`](@ref)`(x, y)` |
| `setdiff(x, y)` | [`interiordiff`](@ref)`(x, y)` |

```jldoctest cheatsheet
julia> a = interval(1, 3);

julia> isequal_interval(a, interval(1, 3))
true

julia> issubset_interval(a, interval(0, 5))
true

julia> in_interval(2.0, a)
true

julia> isdisjoint_interval(interval(1, 2), interval(3, 4))
true

julia> precedes(interval(1, 2), interval(3, 4))
true

julia> isthin(interval(2))
true

julia> isthinzero(interval(0))
true

julia> isatomic(interval(1, nextfloat(1.0)))
true
```

### Unicode aliases (from `Symbols`)

| Unicode | Tab-completion | Function |
|:-------:|----------------|----------|
| `≛` | `\starequal` | [`isequal_interval`](@ref) |
| `⊑` | `\sqsubseteq` | [`issubset_interval`](@ref) |
| `⋤` | `\sqsubsetneq` | [`isstrictsubset`](@ref) |
| `⪽` | `\subsetdot` | [`isinterior`](@ref) |
| `⪯` | `\precsim` | [`precedes`](@ref) |
| `≺` | `\prec` | [`strictprecedes`](@ref) |
| `⊔` | `\sqcup` | [`hull`](@ref) |
| `⊓` | `\sqcap` | [`intersect_interval`](@ref) |

## Set Operations

```jldoctest cheatsheet
julia> a, b = interval(1, 3), interval(2, 5);

julia> intersect_interval(a, b)              # a ⊓ b
Interval{Float64}(2.0, 3.0, trv, true)

julia> hull(a, b)                            # a ⊔ b, alias: union_interval
Interval{Float64}(1.0, 5.0, trv, true)

julia> interiordiff(interval(1, 5), interval(2, 3))
2-element Vector{Interval{Float64}}:
 Interval{Float64}(1.0, 2.0, trv, true)
 Interval{Float64}(3.0, 5.0, trv, true)
```

## Bisection and Subdivision

```jldoctest cheatsheet
julia> bisect(interval(0, 1))                # split at midpoint
(Interval{Float64}(0.0, 0.5, com, true), Interval{Float64}(0.5, 1.0, com, true))

julia> bisect(interval(0, 1), 0.25)          # split at 25% point
(Interval{Float64}(0.0, 0.25, com, true), Interval{Float64}(0.25, 1.0, com, true))

julia> mince(interval(0, 1), 4)              # split into 4 equal parts
4-element Vector{Interval{Float64}}:
 Interval{Float64}(0.0, 0.25, com, true)
 Interval{Float64}(0.25, 0.5, com, true)
 Interval{Float64}(0.5, 0.75, com, true)
 Interval{Float64}(0.75, 1.0, com, true)
```

For vectors (multi-dimensional):

```jldoctest cheatsheet
julia> box = [interval(0, 1), interval(0, 1)];

julia> bisect(box, 1)                        # split 1st component
(Interval{Float64}[Interval{Float64}(0.0, 0.5, com, true), Interval{Float64}(0.0, 1.0, com, true)], Interval{Float64}[Interval{Float64}(0.5, 1.0, com, true), Interval{Float64}(0.0, 1.0, com, true)])
```

## Display Options

```jldoctest cheatsheet
julia> x = interval(0.1, 0.3);

julia> setdisplay(:infsup); x
[0.1, 0.3]_com

julia> setdisplay(:midpoint); x
(0.2 ± 0.1)_com

julia> setdisplay(:full); x
Interval{Float64}(0.1, 0.3, com, true)

julia> setdisplay(:infsup; decorations=false, sigdigits=3); x
[0.1, 0.3]
```

Options: `format` (`:infsup`, `:midpoint`, `:full`), `decorations` (`Bool`), `ng_flag` (`Bool`), `sigdigits` (`Int ≥ 1`).

```jldoctest cheatsheet
julia> setdisplay(:full);
```

## Configuration

```jldoctest cheatsheet
julia> IntervalArithmetic.configure()
Configuration options:
  - bound type: Float64
  - flavor: set_based
  - interval rounding: correct
  - power mode: fast
  - matrix multiplication mode: fast
```

| Option | Values | Default |
|--------|--------|---------|
| `numtype` | any `NumTypes` | `Float64` |
| `flavor` | `:set_based` | `:set_based` |
| `rounding` | `:correct`, `:ulp`, `:none` | `:correct` |
| `power` | `:fast`, `:slow` | `:fast` |
| `matmul` | `:fast`, `:slow` | `:fast` |

Usage: `IntervalArithmetic.configure(numtype=BigFloat, power=:slow)`

## The `@interval` Macro

Wraps arguments with [`atomic`](@ref IntervalArithmetic.atomic) for safe float handling:

```jldoctest cheatsheet
julia> @interval sin(0.1)
Interval{Float64}(0.09983341664682814, 0.09983341664682817, com, true)
```

## Piecewise Functions

```jldoctest cheatsheet
julia> myabs = Piecewise(
           Domain{:open, :closed}(-Inf, 0) => x -> -x,
           Domain{:open, :open}(0, Inf)    => identity
       );

julia> myabs(-3.5)
3.5

julia> myabs(interval(-2, 3))
Interval{Float64}(0.0, 3.0, def, true)
```

Use [`Constant`](@ref)`(v)` for interval-safe constant pieces.

## Sampling

```julia
sample(interval(1, 10))  # random point from the interval
```

## Package Extensions

Extensions for: **LinearAlgebra** (Rump's algorithm), **ForwardDiff**, **DiffRules**, **RecipesBase** (plotting), **IntervalSets**, **SparseArrays**, **Arblib**, **IrrationalConstants**.

## Common Gotchas

### 1. Float literals are NOT safe

```jldoctest cheatsheet
julia> interval(0.1)                        # does NOT contain 1/10!
Interval{Float64}(0.1, 0.1, com, true)

julia> I"0.1"                               # DOES contain 1/10
Interval{Float64}(0.09999999999999999, 0.1, com, true)

julia> in_interval(1//10, I"0.1")
true
```

### 2. NG propagates forever

```jldoctest cheatsheet
julia> setdisplay(:infsup);

julia> x = interval(1, 2) + 0;              # NG because 0 was implicitly converted

julia> x + interval(3, 4)                   # still NG!
[4.0, 6.0]_com_NG
```

Fix: use `exact(0)` or `@exact`.

### 3. `Inf` is NOT in intervals (set-based flavor)

```jldoctest cheatsheet
julia> in_interval(Inf, entireinterval())
false
```
