module ValidatedNumerics

(VERSION < v"0.4-") && using Docile

using Compat

import Base:
    in, zero, one, abs, real, show,
    sqrt, exp, log, sin, cos, tan, inv,
    union, intersect, isempty,
    convert, promote_rule, eltype,
    BigFloat, float,
    set_rounding, widen,
    ⊆

export
    Interval, @interval, @floatinterval,
    get_interval_rounding, set_interval_rounding,
    diam, mid, mag, mig, hull, isinside,
    emptyinterval, ∅, isempty, ⊊,
    widen

## Root finding
export
    newton, krawczyk,
    differentiate, D, # should these be exported?
    Root,
    find_roots

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
