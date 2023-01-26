# This file is part of the IntervalArithmetic.jl package; MIT licensed

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
    @interval, @biginterval, @floatinterval,
    diam, radius, mid, mag, mig, hull,
    emptyinterval, ∅, ∞, isempty, isinterior, ⪽, nthroot,
    precedes, strictprecedes, ≼, ≺, ⊂, ⊃, ⊇, contains_zero,
    entireinterval, isentire, nai, isnai, isthin, iscommon, isatomic,
    widen, inf, sup, bisect, mince,
    parameters, eps, dist, #numtype,
    midpoint_radius, interval_from_midpoint_radius,
    RoundTiesToEven, RoundTiesToAway,
    cancelminus, cancelplus, isunbounded,
    .., @I_str, ±,
    pow, extended_div,
    setformat, @format

import Base: isdisjoint

export
    setindex   # re-export from StaticArrays for IntervalBox



export showfull

import Base: rounding, setrounding, setprecision



## Multidimensional
export
    IntervalBox, symmetric_box

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

include("plot_recipes/plot_recipes.jl")

include("deprecated.jl")

"""
    Region{T} = Union{Interval{T}, IntervalBox{T}}
"""
const Region{T} = Union{Interval{T}, IntervalBox{T}}


# These definitions has been put there because generated functions must be
# defined after all methods they use.
@generated function Interval{T}(x::AbstractIrrational) where T
    res = atomic(Interval{T}, x())  # Precompute the interval
    return :(return $res)  # Set body of the function to return the precomputed result
end

Interval{BigFloat}(x::AbstractIrrational) = atomic(Interval{BigFloat}, x)
Interval(x::AbstractIrrational) = Interval{Float64}(x)

end # module IntervalArithmetic
