module ValidatedNumerics


import Base:
    in, zero, one, abs, real, show,
    sqrt, exp, log, sin, cos, tan, inv,
    union, intersect, isempty,
    convert, promote_rule,
    BigFloat,
    set_rounding

export
    @interval, Interval,
    @round_down, @round_up, @round, @thin_interval,
    diam, mid, mag, mig, hull, isinside,
    empty_interval, ∅, isempty, ⊊,
    differentiate, D,  # should these be exported?
    floatinterval, @floatinterval,
    find_roots

## Root finding
export
    newton, krawczyk


## Default precision:
set_bigfloat_precision(53)


## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = float(a) < float(b)


## Includes:

include("intervals/intervals.jl")
include("root_finding/root_finding.jl")

end # module ValidatedNumerics
