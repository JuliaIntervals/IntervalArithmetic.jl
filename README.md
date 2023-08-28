# IntervalArithmetic.jl

[![Build Status](https://github.com/JuliaIntervals/IntervalArithmetic.jl/workflows/CI/badge.svg)](https://github.com/JuliaIntervals/IntervalArithmetic.jl/actions/workflows/CI.yml)
[![coverage](https://codecov.io/gh/JuliaIntervals/IntervalArithmetic.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaIntervals/IntervalArithmetic.jl)

[![DOI](https://zenodo.org/badge/87007945.svg)](https://zenodo.org/badge/latestdoi/87007945)

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaintervals.github.io/IntervalArithmetic.jl/stable)

`IntervalArithmetic.jl` is a Julia package for validated numerics in Julia. All calculations are carried out using [interval arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic) where quantities are treated as intervals. The final result is a rigorous enclosure of the true value.

We are working towards having the IntervalArithmetic library be conformant with the [IEEE 1788-2015 Standard for Interval Arithmetic](https://standards.ieee.org/findstds/standard/1788-2015.html). To do so, we have incorporated tests from the [ITF1788 test suite](https://github.com/JuliaIntervals/ITF1788.jl).

The IntervalArithmetic library is part of the [JuliaInterval organisation](https://juliaintervals.github.io).

## Documentation

The official documentation is available online: https://juliaintervals.github.io/IntervalArithmetic.jl/stable.

## Installation

The IntervalArithmetic.jl package requires to [install Julia](https://julialang.org/downloads/) (v1.8 or above).

Then, start Julia and execute the following command in the REPL:

```julia
using Pkg; Pkg.add("IntervalArithmetic")
```

## Citation

If you use the IntervalArithmetic library in your publication, research, teaching, or other activities, please use the BibTeX template [CITATION.bib](https://github.com/JuliaIntervals/IntervalArithmetic.jl/blob/main/CITATION.bib).
