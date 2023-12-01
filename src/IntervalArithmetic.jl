module IntervalArithmetic

import CRlibm
import FastRounding
import RoundingEmulator

using SetRounding

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

include("display.jl")
    export setdisplay

include("symbols.jl")

end
