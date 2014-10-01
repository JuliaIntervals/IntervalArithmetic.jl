module ValidatedNumerics

# Default precision:
set_bigfloat_precision(53)


## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = big(a) < big(b)


include("Intervals.jl")

include("interval_macros.jl")
include("interval_trig.jl")
include("interval_functions.jl")

end # module
