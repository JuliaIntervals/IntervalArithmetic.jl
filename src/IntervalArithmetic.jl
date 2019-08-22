# This file is part of the IntervalArithmetic.jl package; MIT licensed

__precompile__(true)

module IntervalArithmetic

import CRlibm

using StaticArrays
using FastRounding
using SetRounding
using RoundingEmulator

using Markdown

using LinearAlgebra
import LinearAlgebra: ×, dot, norm
export ×, dot


import Base:
    +, -, *, /, //, fma,
    <, >, ==, !=, ⊆, ^, <=,
    in, zero, one, eps, typemin, typemax, abs, abs2, real, min, max,
    sqrt, exp, log, sin, cos, tan, cot, inv, cbrt, csc, hypot, sec, 
    exp2, exp10, log2, log10,
    asin, acos, atan,
    sinh, cosh, tanh, coth, csch, sech, asinh, acosh, atanh, sinpi, cospi,
    union, intersect, isempty,
    convert, promote_rule, eltype, size,
    BigFloat, float, widen, big,
    ∩, ∪, ⊆, ⊇, ∈, eps,
    floor, ceil, trunc, sign, round, copysign, flipsign, signbit,
    expm1, log1p,
    precision,
    isfinite, isnan, isinf, iszero,
    abs, abs2,
    show,
    isinteger, setdiff,
    parse, hash

import Base:  # for IntervalBox
    broadcast, length,
    getindex, setindex,
    iterate, eltype

import Base.MPFR: MPFRRoundingMode
import Base.MPFR: MPFRRoundUp, MPFRRoundDown, MPFRRoundNearest, MPFRRoundToZero, MPFRRoundFromZero

import .Broadcast: broadcasted

export
    AbstractInterval, Interval,
    interval,
    @interval, @biginterval, @floatinterval, @make_interval,
    diam, radius, mid, mag, mig, hull,
    emptyinterval, ∅, ∞, isempty, isinterior, isdisjoint, ⪽,
    precedes, strictprecedes, ≺, ⊂, ⊃, ⊇, contains_zero,
    RR, isentire, nai, isnai, isthin, iscommon, isatomic,
    widen, inf, sup, bisect,
    parameters, eps, dist,
    midpoint_radius, interval_from_midpoint_radius,
    RoundTiesToEven, RoundTiesToAway,
    cancelminus, cancelplus, isunbounded,
    .., @I_str, ±,
    pow, extended_div,
    setformat, @format

if VERSION >= v"1.5.0-DEV.124"
    import Base: isdisjoint
else
    export isdisjoint
end


export
    setindex   # re-export from StaticArrays for IntervalBox



export showfull

import Base: rounding, setrounding, setprecision



## Multidimensional
export
    IntervalBox

## Decorations
export
    @decorated,
    interval, decoration, DecoratedInterval,
    com, dac, def, trv, ill

## Union type
export
    Region



function __init__()
    setrounding(BigFloat, RoundNearest)


    setprecision(Interval, 256)  # set up pi
    setprecision(Interval, Float64)
end


## Includes

include("intervals/intervals.jl")

include("multidim/multidim.jl")
include("bisect.jl")
include("decorations/decorations.jl")

include("rand.jl")
include("parsing.jl")
include("display.jl")
include("symbols.jl")

include("plot_recipes/plot_recipes.jl")

"""
    Region{T} = Union{Interval{T}, IntervalBox{T}}
"""
const Region{T} = Union{Interval{T}, IntervalBox{T}}


# These definitions has been put there because generated functions must be
# defined after all methods they use.
@generated function Interval{T}(x::Irrational) where T
    res = atomic(Interval{T}, x())  # Precompute the interval
    return :(return $res)  # Set body of the function to return the precomputed result
end

Interval{BigFloat}(x::Irrational) = atomic(Interval{BigFloat}, x)
Interval(x::Irrational) = Interval{Float64}(x)

end # module IntervalArithmetic
