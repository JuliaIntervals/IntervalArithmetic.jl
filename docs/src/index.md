# IntervalArithmetic.jl

`IntervalArithmetic.jl` is a Julia package for validated numerics in Julia. All calculations are carried out using [interval arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic) where quantities are treated as intervals. The final result is a rigorous enclosure of the true value.



## Installation

```@repl
using Pkg # Julia v1.8 or above
redirect_stderr(devnull) do # hide
Pkg.add("IntervalArithmetic")
end # hide
```



## Citation

If you use the IntervalArithmetic library in your publication, research, teaching, or other activities, please use the BibTeX template [CITATION.bib](https://github.com/JuliaIntervals/IntervalArithmetic.jl/blob/main/CITATION.bib).



## Related packages

- [MPFI.jl](https://github.com/andrioni/MPFI.jl), a Julia wrapper around the [MPFI C library](http://perso.ens-lyon.fr/nathalie.revol/software.html), a multiple-precision interval arithmetic library based on MPFR
- [Intervals.jl](https://github.com/invenia/Intervals.jl), an alternative implementation of basic interval functions by Invenia Technical Computing



## History

This project began in 2014 during a masters' course in the postgraduate programs of Mathematics and Physics at the Universidad Nacional Autónoma de México. It was initially written in Python, then reinitiated in 2015 and rewritten in Julia. We thank the participants of the courses for their contribution, energy and ideas.


### Support

Financial support is acknowledged from DGAPA-UNAM PAPIME grants PE-105911 and PE-107114, and DGAPA-UNAM PAPIIT grant IN-117214.

Luis Benet acknowledges support from *Cátedra Marcos Moshinsky* (2013).

David P. Sanders acknowledges a sabbatical fellowship from CONACYT and thanks Alan Edelman and the Julia group at MIT for hosting his sabbatical visit.
