# IntervalArithmetic.jl

IntervalArithmetic.jl is a Julia package for validated numerics in Julia. All calculations are carried out using [interval arithmetic](https://en.wikipedia.org/wiki/Interval_arithmetic) where quantities are treated as intervals. The final result is a rigorous enclosure of the true value.



## Installation

```@repl
using Pkg # Julia v1.10 or above
redirect_stderr(devnull) do # hide
Pkg.add("IntervalArithmetic")
end # hide
```



## Citation

If you use the IntervalArithmetic library in your publication, research, teaching, or other activities, please use the BibTeX template [CITATION.bib](https://github.com/JuliaIntervals/IntervalArithmetic.jl/blob/main/CITATION.bib).
