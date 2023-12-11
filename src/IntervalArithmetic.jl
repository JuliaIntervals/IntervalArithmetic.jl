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

# convenient alias
const RealOrComplexI{T} = Union{Interval{T},Complex{Interval{T}}}
const ComplexI{T} = Complex{Interval{T}}
    export RealOrComplexI, ComplexI

end
