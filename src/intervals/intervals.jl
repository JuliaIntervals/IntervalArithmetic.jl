# The order in which files are included is important,
# since certain things need to be defined before others use them

include("interval_definition.jl")
include("rationalize.jl")
include("interval_parameters.jl")
include("interval_rounding.jl")
include("interval_macros.jl")
include("interval_conversion_promotion.jl")
include("interval_arithmetic.jl")
include("interval_precision.jl")
include("interval_trig.jl")
include("interval_functions.jl")
