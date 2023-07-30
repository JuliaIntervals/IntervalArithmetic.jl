# Construction and composability with numbers
include("construction.jl")
include("real_interface.jl")

# Rounding
include("rounding.jl")
include("rounding_macros.jl")

# Flavors
include("flavors.jl")

# Arithmetic
include("arithmetic/absmax.jl")
include("arithmetic/basic.jl")
include("arithmetic/hyperbolic.jl")
include("arithmetic/integer.jl")
include("arithmetic/power.jl")
include("arithmetic/signbit.jl")
include("arithmetic/trigonometric.jl")

# Other functions
include("interval_operations/cancellative.jl")
include("interval_operations/constants.jl")
include("interval_operations/extended_div.jl")
include("interval_operations/boolean.jl")
include("interval_operations/overlap.jl")
include("interval_operations/numeric.jl")
include("interval_operations/set_operations.jl")
