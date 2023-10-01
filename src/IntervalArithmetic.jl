module IntervalArithmetic

import CRlibm
import FastRounding
import RoundingEmulator

using Markdown
using SetRounding
using EnumX

import Base:
    +, -, *, /, //, muladd, fma,
    ^, sqrt, exp, log, exp2, exp10, log2, log10, inv, cbrt, hypot,
    zero, one, eps, typemin, typemax, abs, abs2, min, max,
    rad2deg, deg2rad,
    sin, cos, tan, cot, csc, sec, asin, acos, atan, acot, sinpi, cospi, sincospi,
    sinh, cosh, tanh, coth, csch, sech, asinh, acosh, atanh, acoth,
    float, big,
    floor, ceil, trunc, sign, round, copysign, flipsign, signbit,
    expm1, log1p,
    precision,
    abs, abs2,
    show,
    parse, hash

import Base.MPFR: MPFRRoundingMode
import Base.MPFR: MPFRRoundUp, MPFRRoundDown, MPFRRoundNearest, MPFRRoundToZero, MPFRRoundFromZero

function __init__()
    setrounding(BigFloat, RoundNearest)
end

function Base.setrounding(f::Function, ::Type{Rational{T}}, rounding_mode::RoundingMode) where {T<:Integer}
    return setrounding(f, float(Rational{T}), rounding_mode)
end

#

include("intervals/intervals.jl")
export Interval, interval, ±, @I_str,
    diam, radius, mid, midradius, scaled_mid, mag, mig, hull,
    emptyinterval, isemptyinterval,
    isequalinterval,
    ismember,
    isweakinterior, isstrictinterior,
    weakprecedes, strictprecedes,
    isweakless, isstrictless,
    contains_zero,
    isthinzero, isthin,
    isbounded, isunbounded,
    isdisjointinterval, intersectinterval, setdiffinterval,
    entireinterval, isentireinterval, nai, isnai, iscommon, isatomic,
    inf, sup, bounds, mince,
    dist,
    RoundTiesToEven, RoundTiesToAway,
    IntervalRounding,
    cancelminus, cancelplus,
    pow, extended_div, nthroot,
    overlap, Overlap

include("bisect.jl")
export bisect

include("decorations/decorations.jl")
export decoration, DecoratedInterval, com, dac, def, trv, ill

include("rand.jl")

include("parsing.jl")

include("display.jl")
export setformat

include("symbols.jl")

end
