module IntervalArithmetic

import CRlibm
import RoundingEmulator
import Base.MPFR

using SetRounding

function __init__()
    setrounding(BigFloat, RoundNearest)
end

Base.setrounding(f::Function, ::Type{Rational{T}}, rounding_mode::RoundingMode) where {T<:Integer} =
    setrounding(f, float(Rational{T}), rounding_mode)

#

include("intervals/intervals.jl")

include("display.jl")
    export setdisplay

include("symbols.jl")

end
