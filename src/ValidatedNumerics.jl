# This file is part of the ValidatedNumerics.jl package; MIT licensed

__precompile__(true)

module ValidatedNumerics

using CRlibm
using Compat
using FixedSizeArrays

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
    BigFloat, float, widen, big,
    ∩, ⊆, eps,
    floor, ceil, trunc, sign, round,
    expm1, log1p,
    precision,
    isfinite, isnan

export
    @I_str

export
    Interval, AbstractInterval,
    @interval, @biginterval, @floatinterval, @make_interval,
    diam, radius, mid, mag, mig, hull,
    emptyinterval, ∅, ∞, isempty, interior, isdisjoint, ⪽,
    precedes, strictprecedes, ≺,
    entireinterval, isentire, nai, isnai, isthin, iscommon,
    widen, infimum, supremum,
    parameters, eps, dist, roughly,
    pi_interval,
    midpoint_radius, interval_from_midpoint_radius,
    RoundTiesToEven, RoundTiesToAway,
    cancelminus, cancelplus, isunbounded,
    .., @I_str

if VERSION >= v"0.5.0-dev+1182"
    import Base: rounding, setrounding, setprecision
else
    import Compat:
        rounding, setrounding, setprecision

    export rounding, setrounding, setprecision  # reexport
end


## Multidimensional
export
    IntervalBox, @intervalbox

## Decorations
export
    @decorated,
    interval_part, decoration, DecoratedInterval,
    com, dac, def, trv, ill

## Root finding
export
    newton, krawczyk,
    derivative, jacobian,  # reexport derivative from ForwardDiff
    Root, is_unique,
    find_roots,
    find_roots_midpoint

function __init__()
    setrounding(BigFloat, RoundNearest)
    setrounding(Float64, RoundNearest)

    setprecision(Interval, 256)  # set up pi
    setprecision(Interval, Float64)
end


## Includes

include("intervals/intervals.jl")
include("multidim/multidim.jl")
include("decorations/decorations.jl")
include("decorations/functions.jl")

include("root_finding/root_finding.jl")

# notation I"[3,4]"
macro I_str(ex)
    @interval ex
end


end # module ValidatedNumerics
