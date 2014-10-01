module ValidatedNumerics


import Base:
  in, zero, one, abs, real, show,
  sqrt, exp, log, sin, cos, tan, inv,
  union, intersect, isempty,
  convert, promote_rule,
  BigFloat, string

export
  @interval, Interval
  @round_down, @round_up, @round, @thin_interval,
  diam, mid, mag, mig, hull, isinside


## Default precision:
set_bigfloat_precision(53)


## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = big(a) < big(b)


## Includes:

include("interval_definition.jl")
include("interval_macros.jl")
include("interval_arithmetic.jl")
include("interval_trig.jl")
include("interval_functions.jl")

end # module ValidatedNumerics
