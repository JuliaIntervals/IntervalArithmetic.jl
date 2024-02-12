module IntervalArithmetic

import CRlibm_jll
import RoundingEmulator
import Base.MPFR
import MacroTools: postwalk

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
