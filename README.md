# IntervalArithmetic.jl #

[![Build Status](https://travis-ci.org/JuliaIntervals/IntervalArithmetic.jl.svg?branch=master)](https://travis-ci.org/JuliaIntervals/IntervalArithmetic.jl)
[![Coverage Status](https://coveralls.io/repos/github/JuliaIntervals/IntervalArithmetic.jl/badge.svg?branch=master)](https://coveralls.io/github/JuliaIntervals/IntervalArithmetic.jl?branch=master)
[![codecov](https://codecov.io/gh/JuliaIntervals/IntervalArithmetic.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaIntervals/IntervalArithmetic.jl)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaIntervals.github.io/IntervalArithmetic.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://JuliaIntervals.github.io/IntervalArithmetic.jl/latest)

[![DOI](https://zenodo.org/badge/87007945.svg)](https://zenodo.org/badge/latestdoi/87007945)


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

## Standard for Interval Arithmetic:  IEEE 1788-2015

The IEEE Std 1788-2015 - IEEE Standard for Interval Arithmetic was [published](https://standards.ieee.org/findstds/standard/1788-2015.html) in June 2015. We are working towards having `IntervalArithmetic.jl` be conformant with this standard.

To do so, we have incorporated tests from the excellent [ITF1788 test suite](https://github.com/oheim/ITF1788), originally written by Marco Nehmeier and Maximilian Kiesner, and converted to a common format and to output tests for Julia by Oliver Heimlich.

## Bibliography

- *Validated Numerics: A Short Introduction to Rigorous Computations*, W. Tucker, Princeton University Press (2010)
- *Introduction to Interval Analysis*, R.E. Moore, R.B. Kearfott & M.J. Cloud, SIAM (2009)

### Related packages
- [MPFI.jl](https://github.com/andrioni/MPFI.jl), a Julia wrapper around the [MPFI C library](http://perso.ens-lyon.fr/nathalie.revol/software.html), a multiple-precision interval arithmetic library based on MPFR
- [Intervals.jl](https://github.com/andrioni/Intervals.jl), an alternative implementation of basic interval functions.
- [Unums.jl](https://github.com/JuliaComputing/Unums.jl), an implementation of interval arithmetic with variable precision ("ubounds")


## History ##
This project was begun during a masters' course in the postgraduate programs in Physics and in Mathematics at UNAM during the second semester of 2013 (in Python), and was reinitiated -- now in Julia -- in the first semester of 2015. We thank the participants of the courses for putting up with the half-baked material and contributing energy and ideas.


## Acknowledgements ##
This project was developed in a masters' course in the postgraduate programs in Physics and in Mathematics at UNAM during the second semester of 2013 and the first semester of 2015. We thank the participants of the courses for putting up with the half-baked material and contributing energy and ideas.

Financial support is acknowledged from DGAPA-UNAM PAPIME grants PE-105911 and PE-107114, and DGAPA-UNAM PAPIIT grant IN-117214. LB acknowledges support through a *Cátedra Marcos Moshinsky* (2013).
DPS acknowledges a sabbatical fellowship from CONACYT and thanks Alan Edelman and the Julia group at MIT for hosting his sabbatical visit.
