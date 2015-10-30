# This file is part of the ValidatedNumerics.jl package; MIT licensed

VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

module ValidatedNumerics


(VERSION < v"0.4-") && using Docile

using Compat
#using FactCheck

using CRlibm
set_rounding(BigFloat, RoundNearest)
set_rounding(Float64, RoundNearest)

import Base:
    +, -, *, /, //, fma,
    <, >, ==, !=, ⊆, ^, <=,
    in, zero, one, abs, real, show, min, max,
    sqrt, exp, log, sin, cos, tan, inv,
    exp2, exp10, log2, log10,
    asin, acos, atan, atan2,
    sinh, cosh, tanh, asinh, acosh, atanh,
    union, intersect, isempty,
    convert, promote_rule, eltype,
    BigFloat, float,
    set_rounding, widen,
    ⊆, eps,
    floor, ceil, trunc, sign, round


export
    Interval,
    @interval, @biginterval, @floatinterval, @make_interval,
    get_interval_rounding, set_interval_rounding,
    diam, radius, mid, mag, mig, hull, isinside,
    emptyinterval, ∅, isempty, interior, isdisjoint, ⪽,
    precedes, strictprecedes, ≺,
    entireinterval, isentire, nai, isnai, isthin, iscommon,
    widen, infimum, supremum,
    set_interval_precision, get_interval_precision,
    with_interval_precision,
    parameters, eps, dist, roughly,
    pi_interval,
    midpoint_radius, interval_from_midpoint_radius,
    RoundTiesToEven, RoundTiesToAway,
    cancelminus, cancelplus, isunbounded

## Root finding
export
    newton, krawczyk,
    differentiate, D, # should these be exported?
    Root, is_unique,
    find_roots,
    find_roots_midpoint

function __init__()
    set_interval_precision(256)  # set up pi
    set_interval_precision(Float64)
end


## Includes

include("misc.jl")
include("intervals/intervals.jl")
include("root_finding/root_finding.jl")



end # module ValidatedNumerics
