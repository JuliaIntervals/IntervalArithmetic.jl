# ValidatedNumerics.jl #

[![Build Status](https://travis-ci.org/dpsanders/ValidatedNumerics.jl.svg?branch=master)](https://travis-ci.org/dpsanders/ValidatedNumerics.jl)
[![Coverage Status](https://coveralls.io/repos/dpsanders/ValidatedNumerics.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/dpsanders/ValidatedNumerics.jl?branch=master)
[![codecov](
https://codecov.io/gh/dpsanders/ValidatedNumerics/branch/master/graph/badge.svg)]
(https://codecov.io/gh/dpsamders/ValidatedNumerics)
[![Join the chat at https://gitter.im/dpsanders/ValidatedNumerics.jl](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dpsanders/ValidatedNumerics.jl?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

https://github.com/ipython-contrib/jupyter_contrib_nbextensions`ValidatedNumerics.jl` is a Julia package for performing *Validated Numerics* in Julia, i.e. *rigorous* computations with finite-precision floating-point arithmetic.



## Installation
To install the package, from within Julia do

    julia> Pkg.add("ValidatedNumerics")


## Interval arithmetic
All calculations are carried out using **interval arithmetic**: all quantities are treated as intervals, which are propagated throughout a calculation. The final result is an interval that is *guaranteed* to contain the correct result, starting from the given initial data.

The aim of the package is correctness over speed, although performance considerations are also taken into account

## Documentation
Documentation is available [**here**](http://dpsanders.github.io/ValidatedNumerics.jl/).

## IEEE Standard 1788-2015 - IEEE Standard for Interval Arithmetic
The IEEE Std 1788-2015 - IEEE Standard for Interval Arithmetic was [published](https://standards.ieee.org/findstds/standard/1788-2015.html) in June 2015. We are working towards having `ValidatedNumerics` be conformant with this standard.

To do so, we have incorporated tests from the excellent [ITF1788 test suite](https://github.com/oheim/ITF1788), originally written by Marco Nehmeier and Maximilian Kiesner, and converted to a common format and to output tests for Julia by Oliver Heimlich.

## Bibliography

- *Validated Numerics: A Short Introduction to Rigorous Computations*, W. Tucker, Princeton University Press (2010)
- *Introduction to Interval Analysis*, R.E. Moore, R.B. Kearfott & M.J. Cloud, SIAM (2009)

## Related packages
- [MPFI.jl](https://github.com/andrioni/MPFI.jl), a Julia wrapper around the [MPFI C library](http://perso.ens-lyon.fr/nathalie.revol/software.html), a multiple-precision interval arithmetic library based on MPFR
- [Intervals.jl](https://github.com/andrioni/Intervals.jl), an alternative implementation of basic interval functions.

## Authors
- [Luis Benet](http://www.cicc.unam.mx/~benet/), Instituto de Ciencias Físicas,
Universidad Nacional Autónoma de México (UNAM)
- [David P. Sanders](http://sistemas.fciencias.unam.mx/~dsanders),
Departamento de Física, Facultad de Ciencias, Universidad Nacional Autónoma de México (UNAM)

## Contributors
- Oliver Heimlich
- Nikolay Kryukov
- John Verzani


## History ##
This project was begun during a masters' course in the postgraduate programs in Physics and in Mathematics at UNAM during the second semester of 2013 (in Python -- the [`ValidiPy` package](https://github.com/computo-fc/ValidiPy)), and was reinitiated -- now in Julia -- in the first semester of 2015. We thank the participants of the courses for putting up with the half-baked material and contributing energy and ideas.


## Acknowledgements ##

Financial support is acknowledged from DGAPA-UNAM PAPIME grants PE-105911 and PE-107114, and DGAPA-UNAM PAPIIT grant IN-117214. LB acknowledges support through a *Cátedra Moshinsky* (2013).
