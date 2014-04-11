# Intervals.jl #

Interval arithmetics on the real line with julia

#### Related Work ####

- [MPFI.jl][1]: Wrapper of [MPFI library][http://perso.ens-lyon.fr/nathalie.revol/software.html] (multiple precision interval arithmetic library based on MPFR) for julia.

#### References ####
- *Validated Numerics: A short introduction to rigurous computations*, W. Tucker, Princeton University Press (2010).
- *Introduction to Interval Analysis*, R.E. Moore, R.B. Kearfott, M.J. Cloud, SIAM (2009).

#### Contributors ####
- Luis Benet, Instituto de Ciencias Físicas, Universidad Nacional Autónoma de México (UNAM)
- David P. Sanders, Facultad de Ciencias, Universidad Nacional Autónoma de México (UNAM)

## Design and implementation ##

`Intervals.jl` is a julia module to perform *validated numerics*, i.e. *rigorous* computations with finite-precision floating-point arithmetic.

The basic constructor is `Interval`, which takes pairs of `Real`-type values as arguments, or alternatively, single values. The idea of including the latter is to produce *thin intervals*, i.e., intervals which consist of a single real value. Yet, if the number is not exactly representable in base 2, rounding-off errors appear due to the finite precision floating-point arithmetic. Incorporating *directed rounding* may thus create intervals whose *diameter* or *width* is strictly positive. Directed rounding is incorporated for any `Real`-type values *except* for `BigFloat`, since this type includes rounding. Direct access to the `RoundDown` and `RoundUp` modes is obtained through the macros `@roundingDown` and `@roundingUp`.

The following provides some examples. 
```julia
julia> using Intervals    ## Default precision is 53, equivalent to Float64

help> Interval
DataType   : Interval (constructor with 5 methods)
  supertype: Real
  fields   : (:lo,:hi)

julia> a = Interval(0.1)
 [9.9999999999999992e-02, 1.0000000000000001e-01] with 53 bits of precision

julia> typeof(a)
Interval (constructor with 5 methods)

julia> Interval(1//10)
 [9.9999999999999992e-02, 1.0000000000000001e-01] with 53 bits of precision

julia> Interval(BigFloat(0.1))
 [1.0000000000000001e-01, 1.0000000000000001e-01] with 53 bits of precision

julia> b1 = Interval(BigFloat("0.1"))
 [1.0000000000000001e-01, 1.0000000000000001e-01] with 53 bits of precision

julia> b2 = Interval( @roundingDown(BigFloat("0.1")), @roundingDown(BigFloat("0.1")) )
 [9.9999999999999992e-02, 9.9999999999999992e-02] with 53 bits of precision

```

Note that all possibilities above yield the same results *except* `Interval(BigFloat(0.1))`, which yields a thin interval, that noticeably *does not* contain the real value 0.1; a way to obtain a non-thin interval using `BigFloat` of strings is illustrated in the last line. It is worth emphasizing that the behavior implemented by the definition of `Interval` above is *not the same* as that implemented by [MPFI][1], which in all cases above
would yield thin intervals; this is the main design difference.

The limits of the interval are accessed with the fields `lo` and `hi`. These fields are of `BigFloat` type. The diameter is obtained using `diam(a)`; note that for non-exactly representable numbers in base 2 (i.e., whose *binary* expansion is infinite) the diameter corresponds to the local `eps` value.
```julia
julia> a.lo
9.9999999999999992e-02 with 53 bits of precision

julia> typeof(a.lo)
BigFloat (constructor with 14 methods)

julia> a.hi.prec ## this displays the precision of the BigFloat number
53

julia> diam(a) == eps(0.1)
true

julia> diam(b1)
0e+00 with 53 bits of precision

julia> diam( Interval(1000.102)) == eps(1000.102)
true

```

The basic operations among intervals (`+`, `-`, `*`, `/`, `^`) are included following the usual definitions, and include consisting *directed rounding*. In particular, in the case `^` we have distinguished for non-integer powers, if they define a thin interval or not. Some simple functions (`exp`, `log`, `sin`, `cos`, `tan`) have been incorporated and more will come with time (and patience).


### Acknowledgements ###
This project was developed in a masters' course in the postgraduate programs in Physics and in Mathematics at UNAM during the second half of 2013. We thank the participants of the course for putting up with the half-baked material and contributing energy and ideas.

Financial support is acknowledged from DGAPA-UNAM PAPIME grants PE-105911 and PE-107114. LB acknowledges support through a *Cátedra Moshinsky* (2013).

[1]: https://github.com/andrioni/MPFI.jl