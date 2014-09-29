# ValidatedNumerics.jl #

This is a package for performing *Validated Numerics* in Julia, i.e. rigorous
computations with finite-precision floating-point arithmetic.
The fundamental tool is interval arithmetic, provided by `Intervals.jl`.


## `Intervals.jl`

Interval arithmetic over the real numbers with Julia.


### Design and implementation ##

Intervals are constructed using `@interval`, which takes pairs of
numerical expressions as arguments, or, alternatively, single expressions
for *thin* intervals.

If the arguments are not exactly representable in finite-precision floating-point
arithmetic, *directed rounding* is used, i.e., the lower bound of the interval
is rounded down, and the upper bound is rounded up. This guarantees that the
resulting interval contains the true desired value.

Directed rounding is available via the macros `@round_down` and `@round_up`,
although the `@interval` macro is usually more appropriate.

The aim of the package is correctness, rather than speed,
and currently, all intervals contain `BigFloat`s, with default precision 53 bits
(the same as standard floating-point arithmetic).



### Examples
```julia
julia> using ValidatedNumerics

help?> Interval
DataType   : Interval (constructor with 4 methods)
  supertype: Number
  fields   : (:lo,:hi)


julia> a = @interval(0.5)
[5e-01, 5e-01] with 53 bits of precision

julia> a = @interval(0.1)
[9.9999999999999992e-02, 1.0000000000000001e-01] with 53 bits of precision

julia> typeof(a)
Interval (constructor with 4 methods)

julia> @interval(1//10)
[9.9999999999999992e-02, 1.0000000000000001e-01] with 53 bits of precision

julia> @interval(0.1, 0.1)
[9.9999999999999992e-02, 1.0000000000000001e-01] with 53 bits of precision


julia> a = BigFloat(0.1)
1.0000000000000001e-01 with 53 bits of precision

julia> @interval(a)
[1.0000000000000001e-01, 1.0000000000000001e-01] with 53 bits of precision


julia> b = BigFloat("0.1")
1.0000000000000001e-01 with 53 bits of precision

julia> @interval(b)
[1.0000000000000001e-01, 1.0000000000000001e-01] with 53 bits of precision

julia> c = Interval(@round_down(BigFloat("0.1")), @round_up(BigFloat("0.1")))
[9.9999999999999992e-02, 1.0000000000000001e-01] with 53 bits of precision

```

The last definition of `c` is equivalent to `c = @interval(0.1)`; the
`@interval` macro performs the hard work for us.

Note that the naive definition of `b` results in an interval that *does not contain*
0.1.

It is worth emphasizing that the behavior implemented by the definition of
`Interval` above is *not the same* as that implemented by [MPFI][1],
which in all cases above would yield thin intervals.
(Using `MPFI`, the behaviour above is obtained with `Interval("0.1")`,
which is not defined in our implementation.) This is the main design difference.

The upper and lower bounds of the interval may be accessed as the fields
`lo` and `hi`, which are `BigFloat`s.

The diameter is obtained using `diam(a)`;
note that for non-exactly representable numbers in base 2
(i.e., whose *binary* expansion is infinite or exceeds the current precision)
 the diameter of newly-created thin intervals corresponds to the local `eps` value.

```julia
julia> a.lo
9.9999999999999992e-02 with 53 bits of precision

julia> typeof(a.lo)
BigFloat (constructor with 15 methods)

julia> a.hi.prec     ## this displays the precision of the BigFloat number
53

julia> diam(a) == eps(0.1)
true

julia> diam( @interval(1000.102)) == eps(1000.102)
true

```

## Operations and functions ##
The basic arithmetic operations among intervals (`+`, `-`, `*`, `/`, `^`)
have been implemented following the usual definitions, in particular using
*directed rounding*. That is, the resulting lower (left) bound is
systematically rounded down, while the upper (right) one is rounded up.
In particular, the implementation for `^` distinguishes whether non-integer
powers define a thin interval or not.

```julia
julia> a = @interval(1.1)
[1.0999999999999999e+00, 1.1000000000000001e+00] with 53 bits of precision

julia> b = @interval(1,2)
[1e+00, 2e+00] with 53 bits of precision

julia> a + b
[2.0999999999999996e+00, 3.1000000000000001e+00] with 53 bits of precision

julia> a - b
[-9.0000000000000013e-01, 1.0000000000000009e-01] with 53 bits of precision

julia> a * b
[1.0999999999999999e+00, 2.2000000000000002e+00] with 53 bits of precision

julia> a / b
[5.4999999999999993e-01, 1.1000000000000001e+00] with 53 bits of precision

julia> b / @interval(-1, 1)
WARNING:
Interval in denominator contains 0.
[-inf, inf] with 53 bits of precision

julia> b / @interval(0, 2)
[5e-01, inf] with 53 bits of precision

julia> c = Interval(-0.1, 0.2)
[-1.0000000000000001e-01, 2.0000000000000001e-01] with 53 bits of precision

julia> c * c
[-2.0000000000000004e-02, 4.0000000000000008e-02] with 53 bits of precision

julia> c^2
[0e+00, 4.0000000000000008e-02] with 53 bits of precision

```

The last result shows that `^` is implemented independently from the product;
this is related to the *dependency problem*.


#### Intervals from expressions

Due to the problems with floating-point calculations, the `@interval` macro
allows the use of expressions which are converted into appropriate intervals:

```julia
julia> a = @interval(0.1, 0.1+pi)
[9.9999999999999992e-02, 3.2415926535897936e+00] with 53 bits of precision

julia> b = @interval( (2-pi)*(2+pi) )
[-5.8696044010893615e+00, -5.8696044010893571e+00] with 53 bits of precision
```

It is also possible to use variables, although this is not recommended, for
the same reason (the values stored in the variables have a defined rounding):

```julia
julia> x = 0.1
0.1

julia> c = @interval(x, 3x)
[9.9999999999999992e-02, 3.0000000000000004e-01] with 53 bits of precision

julia> c = @interval(0.1x, x^pi)
[7.2178415907472697e-04, 1.0000000000000002e-02] with 53 bits of precision

```



#### Elementary functions

Some elementary functions (`exp`, `log`, `sin`, `cos` & `tan`)
have also been implemented, and more will come with time (and patience).

#### Changing the precision
To change the precision, use e.g.
```julia
julia> set_bigfloat_precision(100)
100
```
Intervals will then be created with the new precision.
```
julia> @interval(0.1, 0.2)
[9.9999999999999999999999999999921e-02, 2.0000000000000000000000000000004e-01] with 100 bits of precision
```

#### Intervals with other types

Intervals may be created containing types other than `BigFloat`s by using directly the `Interval` constructor:
```julia
a = Interval(1//2, 3//4)
[1//2, 3//4]

julia> b = Interval(3//7, 9//12)
[3//7, 3//4]

julia> a + b
[13//14, 3//2]

julia> sqrt(a+b)
[9.636241116594314e-01, 1.2247448713915892e+00] with 53 bits of precision
```

#### Related Work ####
- [MPFI.jl][1]: Wrapper of the [MPFI library][http://perso.ens-lyon.fr/nathalie.revol/software.html] (multiple precision interval arithmetic library based on MPFR) for Julia.

#### References ####
- *Validated Numerics: A Short Introduction to Rigurous Computations*, W. Tucker, Princeton University Press (2010)
- *Introduction to Interval Analysis*, R.E. Moore, R.B. Kearfott & M.J. Cloud, SIAM (2009)

#### Authors ####
- Luis Benet, Instituto de Ciencias Físicas, Universidad Nacional Autónoma de México (UNAM)
- [David P. Sanders](http://sistemas.fciencias.unam.mx/~dsanders),
Departamento de Física, Facultad de Ciencias, Universidad Nacional Autónoma de México (UNAM)


#### Acknowledgements ##
This project was developed in a masters' course in the postgraduate programs in Physics and in Mathematics at UNAM during the second half of 2013. We thank the participants of the course for putting up with the half-baked material and contributing energy and ideas.

Financial support is acknowledged from DGAPA-UNAM PAPIME grants PE-105911 and PE-107114, and DGAPA-UNAM PAPIIT grant IN-117214. LB acknowledges support through a *Cátedra Moshinsky* (2013).

[1]: Julia MPFI package: <https://github.com/andrioni/MPFI.jl>
