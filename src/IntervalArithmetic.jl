"""
    IntervalArithmetic

Library for validated numerics using interval arithmetic.

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

include("display.jl")
    export setdisplay

#

include("symbols.jl")

#

import LinearAlgebra
import OpenBLASConsistentFPCSR_jll # 32-bit systems are not supported

if Int != Int32
    # use the same number of threads as the default BLAS library
    ccall((:openblas_set_num_threads64_, OpenBLASConsistentFPCSR_jll.libopenblas),
        Cint, (Cint,),
        LinearAlgebra.BLAS.get_num_threads())
end

include("matmul.jl")

#

function configure_rounding(rounding::Symbol)
    rounding ∈ (:correct, :none) || return throw(ArgumentError("only the rounding mode `:correct` and `:none` are available"))

    for f ∈ (:add, :sub, :mul, :div)
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x, y, r) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, y, r)
    end

    @eval _pow_round(x, y, r) = _pow_round(IntervalRounding{$(QuoteNode(rounding))}(), x, y, r)

    @eval _inv_round(x, r) = _inv_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)

    @eval _sqrt_round(x, r) = _sqrt_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)

    @eval _rootn_round(x, n, r) = _rootn_round(IntervalRounding{$(QuoteNode(rounding))}(), x, n, r)

    @eval _atan_round(x, y, r) = _atan_round(IntervalRounding{$(QuoteNode(rounding))}(), x, y, r)

    for f ∈ [:cbrt, :exp2, :exp10, :cot, :sec, :csc, :tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh]
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x, r) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)
    end

    for f ∈ (:acot, :acoth)
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x, r) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)
    end

    for f ∈ CRlibm.functions
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x, r) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)
    end

    return rounding
end

function configure(; rounding::Symbol=:correct)
    configure_rounding(rounding)
    return rounding
end

configure()

#

bareinterval(::Type{BigFloat}, a::AbstractIrrational) = _unsafe_bareinterval(BigFloat, a, a)

# Note: generated functions must be defined after all the methods they use
@generated function bareinterval(::Type{T}, a::AbstractIrrational) where {T<:NumTypes}
    x = _unsafe_bareinterval(T, a(), a()) # precompute the interval
    return :($x) # set body of the function to return the precomputed result
end

end
