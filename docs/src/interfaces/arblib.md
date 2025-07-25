# Arblib.jl

[Arblib.jl](https://github.com/kalmarek/Arblib.jl/) is a Julia package for rigorous numerics based on ball arithmetic. It provides a thin and efficient wrapper around the parts of the C library [FLINT](https://flintlib.org/) that are concerned with real and complex numbers.

The purpose of the Arblib package extension is to make conversions between the types defined in IntervalArithmetic and Arblib straightforward. This allows for easy switching between the two packages, depending on which one suits a specific part of a computation best.

Some of the things that Arblib excels at are:
1. Fast high precision computations, including linear algebra routines.
2. A large library of special functions.
3. [Support for mutable arithmetic](https://kalmarek.github.io/Arblib.jl/stable/interface-mutable/).
4. [Taylor series expansions](https://kalmarek.github.io/Arblib.jl/stable/interface-series/).

Some of the things that IntervalArithmetic excels at are:
1. Fast computations at `Float32` and `Float64` precision.
2. Computations with wide intervals (FLINT is in general not optimized for this, though the situation is improving).
3. Built-in safety features, such as decorations (see [Decorations](@ref)) and the "NG" flag (see ["NG" label](@ref)).



## Conversion between `Interval` and Arblib types

The fundamental types in Arblib are `Arb` and `Acb`, corresponding to real and complex balls respectively. Conversion between `Interval` and `Arb`, as well as between `Complex{<:Interval}` and `Acb`, is done through the standard constructors. If no type is specified when calling `interval`, it defaults to `Interval{BigFloat}` for `Arb` and `Complex{Interval{BigFloat}}` for `Acb`.

```@repl 1
using IntervalArithmetic, Arblib

x = interval(π)
Arb(x)

y = Arb(π)
interval(y) # Defaults to BigFloat
interval(Float64, y) # Other type can be explicitly specified

z = complex(interval(2), interval(1 // 3))
Acb(z)

w = Acb(2, 1 // 3)
interval(w)
interval(Float64, w)
```



## Linear algebra

To use the optimized linear algebra routines from FLINT, the matrices should be converted to `ArbMatrix` or `AcbMatrix` (depending on
whether they are real or complex). Basic methods can then be used directly:

```@repl
using IntervalArithmetic, Arblib, LinearAlgebra

A = interval.(BigFloat, [1 2; 3 4])

B = ArbMatrix(A)

B * B

inv(B)

B \ B

eigvals(AcbMatrix(B)) # Eigenvalues are only supported for AcbMatrix
```

Full documentation about supported methods can be found in the FLINT documentation for [arb_mat](https://flintlib.org/doc/arb_mat.html) and
[acb_mat](https://flintlib.org/doc/acb_mat.html). Note that many of these methods are not wrapped in Arblib, but most of them can be used through a [low level wrapper](https://kalmarek.github.io/Arblib.jl/stable/wrapper-methods/).



## Special functions

Arblib wraps a large number of the special functions from [SpecialFunctions.jl](https://github.com/JuliaMath/SpecialFunctions.jl).

``` @repl
using IntervalArithmetic, Arblib, SpecialFunctions

x = interval(BigFloat, 2)

interval(besselj0(Arb(x))) # Convert to Arb and then back

interval(gamma(Arb(x)))

interval(zeta(Arb(x)))
```

Note that FLINT implements several special functions that are not in SpecialFunctions.jl, such as the [confluent hypergeometric functions](https://flintlib.org/doc/acb_hypgeom.html#confluent-hypergeometric-functions) and the [Lerch transcendent](https://flintlib.org/doc/acb_dirichlet.html#lerch-transcendent); they can be used through the [low-level wrapper](https://kalmarek.github.io/Arblib.jl/stable/wrapper-methods/):

``` @repl
using IntervalArithmetic, Arblib

z = interval(BigFloat, 2 + 3im)
s = interval(BigFloat, 2)
a = interval(BigFloat, 4)

interval(Arblib.dirichlet_lerch_phi!(Acb(), Acb(z), Acb(s), Acb(a)))
```
