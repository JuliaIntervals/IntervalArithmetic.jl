"""
    IntervalArithmetic

Library for validated numerics using interval arithmetic.

Learn more: https://github.com/JuliaIntervals/IntervalArithmetic.jl
"""
module IntervalArithmetic

import CRlibm_jll
import RoundingEmulator
import Base.MPFR
using MacroTools: MacroTools, prewalk, postwalk, @capture

#

include("intervals/intervals.jl")
# convenient alias
const RealOrComplexI{T} = Union{Interval{T},Complex{Interval{T}}}
const ComplexI{T} = Complex{Interval{T}}
const RealIntervalType{T} = Union{BareInterval{T},Interval{T}}
    export RealOrComplexI, ComplexI, RealIntervalType

#

include("piecewise.jl")
    export Domain, Constant, Piecewise, domains, discontinuities, pieces

#

include("display.jl")
    export setdisplay

#

include("symbols.jl")

#

import LinearAlgebra

include("matmul.jl")

end
