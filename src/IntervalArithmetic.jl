"""
    IntervalArithmetic

Library for validated numerics using interval arithmetic.

Default settings:
- interval flavor (cf. the IEEE Standard 1788-2015): `default_flavor() = Flavor{:set_based}()`
- interval bound type: `default_boundtype() = Float64`
- interval rounding: `default_rounding() = IntervalRounding{:correct}()`
- power mode: `power_mode() = PowerMode{:fast}()`
- matrix multiplication mode: `matmul_mode() = MatMulMode{:fast}()`
- display of intervals: `setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)`

Learn more: https://github.com/JuliaIntervals/IntervalArithmetic.jl
"""
module IntervalArithmetic

import RoundingEmulator, CRlibm, Base.MPFR
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

#

function configure(; flavor::Symbol=:set_based, rounding::Symbol=:correct, power::Symbol=:fast, matmul::Symbol=:fast)
    configure_flavor(flavor)

    configure_rounding(rounding)

    configure_power(power)

    configure_matmul(matmul)

    return flavor, rounding, power, matmul
end

configure()

#

bareinterval(::Type{BigFloat}, a::AbstractIrrational) = _unsafe_bareinterval(BigFloat, a, a)

# Note: generated functions must be defined after all the methods they use
@generated function bareinterval(::Type{T}, a::AbstractIrrational) where {T<:BoundTypes}
    x = _unsafe_bareinterval(T, a(), a()) # precompute the interval
    return :($x) # set body of the function to return the precomputed result
end

end
