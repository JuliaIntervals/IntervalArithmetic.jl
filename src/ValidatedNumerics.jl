# This file is part of the ValidatedNumerics.jl package; MIT licensed

__precompile__(true)

module ValidatedNumerics

import CRlibm
using Compat
using StaticArrays
using ForwardDiff

import Base:
    +, -, *, /, //, fma,
    <, >, ==, !=, ⊆, ^, <=,
    in, zero, one, abs, real, min, max,
    sqrt, exp, log, sin, cos, tan, inv,
    exp2, exp10, log2, log10,
    asin, acos, atan, atan2,
    sinh, cosh, tanh, asinh, acosh, atanh,
    union, intersect, isempty,
    convert, promote_rule, eltype,
    BigFloat, float, widen, big,
    ∩, ∪, ⊆, eps,
    floor, ceil, trunc, sign, round,
    expm1, log1p,
    precision,
    isfinite, isnan,
    show, showall,
    isinteger, setdiff,
    parse

export
    Interval, AbstractInterval,
    @interval, @biginterval, @floatinterval, @make_interval,
    diam, radius, mid, mag, mig, hull,
    emptyinterval, ∅, ∞, isempty, isinterior, isdisjoint, ⪽,
    precedes, strictprecedes, ≺,
    entireinterval, isentire, nai, isnai, isthin, iscommon,
    widen, infimum, supremum,
    parameters, eps, dist,
    pi_interval,
    midpoint_radius, interval_from_midpoint_radius,
    RoundTiesToEven, RoundTiesToAway,
    cancelminus, cancelplus, isunbounded,
    .., @I_str, ±,
    pow,
    setformat, @format

export
    setindex   # re-export from StaticArrays for IntervalBox

export RootFinding


import Base: rounding, setrounding, setprecision



## Multidimensional
export
    IntervalBox, @intervalbox

## Decorations
export
    @decorated,
    interval_part, decoration, DecoratedInterval,
    com, dac, def, trv, ill




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

include("parsing.jl")
include("display.jl")

include("root_finding/root_finding.jl")

include("plot_recipes/plot_recipes.jl")

include("deprecated.jl")


end # module ValidatedNumerics
