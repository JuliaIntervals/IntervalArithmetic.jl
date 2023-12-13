module IntervalArithmetic

import CRlibm
import RoundingEmulator
import Base.MPFR

function __init__()
    setrounding(BigFloat, RoundNearest)
end

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
