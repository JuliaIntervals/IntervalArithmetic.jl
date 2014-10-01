module ValidatedNumerics

# Default precision:
set_bigfloat_precision(53)



include("Intervals.jl")

include("interval_trig.jl")
include("interval_functions.jl")

end # module
