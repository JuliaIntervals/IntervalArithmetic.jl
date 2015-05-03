module ValidatedNumerics

(VERSION < v"0.4-") && using Docile

using Compat

@compat round
@compat parsefloat
@compat ifloor

if VERSION < v"0.4.0-dev+4539"
    typealias AbstractString String
    Base.parse(::Type{BigFloat}, s::AbstractString) = BigFloat(s)
end

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
    diam, mid, mag, mig, hull, isinside,
    emptyinterval, ∅, isempty, ⊊,
    widen,
    findroots

## Root finding
export
    newton, krawczyk,
    differentiate, D, # should these be exported?
    Root

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
