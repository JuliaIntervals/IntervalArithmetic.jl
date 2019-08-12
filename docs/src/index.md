# IntervalArithmetic.jl #

`IntervalArithmetic.jl` is a Julia package for performing *Validated Numerics* in Julia, i.e. *rigorous* computations with finite-precision floating-point arithmetic.

All calculations are carried out using **interval arithmetic**: all quantities are treated as intervals, which are propagated throughout a calculation. The final result is an interval that is *guaranteed* to contain the correct result, starting from the given initial data.

The aim of the package is correctness over speed, although performance considerations are also taken into account.


### Authors
- [Luis Benet](http://www.cicc.unam.mx/~benet/), Instituto de Ciencias Físicas, Universidad Nacional Autónoma de México (UNAM)
- [David P. Sanders](http://sistemas.fciencias.unam.mx/~dsanders), Departamento de Física, Facultad de Ciencias, Universidad Nacional Autónoma de México (UNAM)

### Contributors
- Oliver Heimlich
- Nikolay Kryukov
- John Verzani


## Installation
To install the package, from within Julia do

```julia
julia> Pkg.add("IntervalArithmetic")
```

## Contents

```@contents
Pages = ["usage.md",
    "intro.md",
    "decorations.md",
    "multidim.md",
    "rounding.md",
    "api.md",
    "input_output.md"
    ]
```

## Bibliography

- *Validated Numerics: A Short Introduction to Rigorous Computations*, W. Tucker, Princeton University Press (2010)
- *Introduction to Interval Analysis*, R.E. Moore, R.B. Kearfott & M.J. Cloud, SIAM (2009)

### Related packages
- [MPFI.jl](https://github.com/andrioni/MPFI.jl), a Julia wrapper around the [MPFI C library](http://perso.ens-lyon.fr/nathalie.revol/software.html), a multiple-precision interval arithmetic library based on MPFR
- [Intervals.jl](https://github.com/andrioni/Intervals.jl), an alternative implementation of basic interval functions.
- [Unums.jl](https://github.com/JuliaComputing/Unums.jl), an implementation of interval arithmetic with variable precision ("ubounds")


## Acknowledgements ##
This project was developed in a masters' course in the postgraduate programs in Physics and in Mathematics at UNAM during the second semester of 2013 and the first semester of 2015. We thank the participants of the courses for putting up with the half-baked material and contributing energy and ideas.

Financial support is acknowledged from DGAPA-UNAM PAPIME grants PE-105911 and PE-107114, and DGAPA-UNAM PAPIIT grant IN-117214. LB acknowledges support through a *Cátedra Marcos Moshinsky* (2013).
DPS acknowledges a sabbatical fellowship from CONACYT and thanks Alan Edelman and the Julia group at MIT for hosting his sabbatical visit.
