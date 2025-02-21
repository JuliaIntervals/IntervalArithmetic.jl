"""
    IntervalArithmetic

Library for validated numerics using interval arithmetic.

Default settings:
- interval flavor (cf. the IEEE Standard 1788-2015): `default_flavor() = Flavor{:set_based}()`
- interval rounding: `interval_rounding() = IntervalRounding{:tight}()`
- power mode: `power_mode() = PowerMode{:fast}()`
- matrix multiplication mode: `matmul_mode() = MatMulMode{:fast}()`
- display of intervals: `setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)`

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

import Printf

include("display.jl")
    export setdisplay

#

include("symbols.jl")

#

import LinearAlgebra

include("matmul.jl")

end
