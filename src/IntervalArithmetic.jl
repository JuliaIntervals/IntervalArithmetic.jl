module IntervalArithmetic

import CRlibm
import FastRounding
import RoundingEmulator

using SetRounding
using EnumX

import Base:
    +, -, *, /, \, inv, //, muladd, fma, sqrt,
    sinh, cosh, tanh, coth, csch, sech, asinh, acosh, atanh, acoth,
    rad2deg, deg2rad, sin, cos, tan, cot, csc, sec, asin, acos, atan, acot, sinpi, cospi, sincospi,
    exp, log, exp2, exp10, log2, log10, cbrt, hypot, ^,
    zero, one, eps, typemin, typemax, abs, abs2, min, max,
    float, big,
    floor, ceil, trunc, sign, round, copysign, flipsign,
    expm1, log1p,
    precision,
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
export BareInterval, bareinterval, Interval, interval, decoration, @I_str,
    isguaranteed, diam, radius, mid, midradius, scaled_mid, mag, mig, hull,
    emptyinterval, isempty_interval,
    isequal_interval,
    in_interval,
    issubset_interval, isstrictsubset_interval,
    precedes, strictprecedes,
    isweakless, isstrictless,
    isthinzero, isthin,
    isbounded, isunbounded,
    isdisjoint_interval, intersect_interval, setdiff_interval,
    entireinterval, isentire_interval, nai, isnai, iscommon, isatomic,
    inf, sup, bounds, mince,
    dist,
    IntervalRounding,
    cancelminus, cancelplus,
    fastpow, extended_div, nthroot, nthpow,
    bisect,
    overlap, Overlap

include("rand.jl")

include("display.jl")
export setdisplay

include("symbols.jl")

end
