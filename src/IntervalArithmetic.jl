# This file is part of the IntervalArithmetic.jl package; MIT licensed

__precompile__(true)

module IntervalArithmetic

import CRlibm

using StaticArrays
using FastRounding
using SetRounding

using Markdown

using LinearAlgebra
import LinearAlgebra: ×, dot
export ×, dot


import Base:
    +, -, *, /, //, fma,
    <, >, ==, !=, ⊆, ^, <=,
    in, zero, one, eps, typemin, typemax, abs, abs2, real, min, max,
    sqrt, exp, log, sin, cos, tan, inv,
    exp2, exp10, log2, log10,
    asin, acos, atan,
    sinh, cosh, tanh, asinh, acosh, atanh,
    union, intersect, isempty,
    convert, promote_rule, eltype, size,
    BigFloat, float, widen, big,
    ∩, ∪, ⊆, ⊇, eps,
    floor, ceil, trunc, sign, round,
    expm1, log1p,
    precision,
    isfinite, isnan, isinf, iszero,
    show,
    isinteger, setdiff,
    parse, hash

import Base:  # for IntervalBox
    broadcast, length,
    getindex, setindex,
    iterate, eltype

import .Broadcast: broadcasted

export
    AbstractInterval, Interval,
    interval,
    @interval, @biginterval, @floatinterval, @make_interval,
    diam, radius, mid, mag, mig, hull,
    emptyinterval, ∅, ∞, isempty, isinterior, isdisjoint, ⪽,
    precedes, strictprecedes, ≺, ⊂, ⊃, ⊇, contains_zero,
    entireinterval, isentire, nai, isnai, isthin, iscommon, isatomic,
    widen, inf, sup, bisect,
    parameters, eps, dist,
    pi_interval,
    midpoint_radius, interval_from_midpoint_radius,
    RoundTiesToEven, RoundTiesToAway,
    cancelminus, cancelplus, isunbounded,
    .., @I_str, ±,
    pow, extended_div,
    setformat, @format

export
    setindex   # re-export from StaticArrays for IntervalBox


if VERSION < v"1.0-dev"
    import Base.showfull
end

export showfull

import Base: rounding, setrounding, setprecision



## Multidimensional
export
    IntervalBox

## Decorations
export
    @decorated,
    interval_part, decoration, DecoratedInterval,
    com, dac, def, trv, ill

## Union type
export
    Region



function __init__()
    setrounding(BigFloat, RoundNearest)
    if VERSION < v"0.7.0-DEV"
        ## deprecated in 0.7
        setrounding(Float64, RoundNearest)
    end

    setprecision(Interval, 256)  # set up pi
    setprecision(Interval, Float64)
end


## Includes

include("intervals/intervals.jl")
include("multidim/multidim.jl")
include("bisect.jl")
include("decorations/decorations.jl")

include("parsing.jl")
include("display.jl")

include("plot_recipes/plot_recipes.jl")

include("deprecated.jl")

"""
    Region{T} = Union{Interval{T}, IntervalBox{T}}
"""
const Region{T} = Union{Interval{T}, IntervalBox{T}}

end # module IntervalArithmetic
