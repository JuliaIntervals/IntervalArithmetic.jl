# This file is part of the ValidatedNumerics.jl package; MIT licensed

include("construction.jl")
include("consistency.jl")
include("numeric.jl")
include("trig.jl")
include("hyperbolic.jl")
include("non_BigFloat.jl")
include("linear_algebra.jl")
include("loops.jl")
include("complex.jl")
include("parsing.jl")
include("rounding_macros.jl")

if VERSION >= v"0.6.0-dev.1671"  # PR https://github.com/JuliaLang/julia/pull/17057 fixing issue #265
    include("rounding.jl")
end
