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

import LinearAlgebra

include("matmul.jl")

#

function configure_boundtype(boundtype::Type{<:BoundTypes})
    @eval promote_boundtype(::Type{T}, ::Type{S}) where {T,S} = promote_type($boundtype, boundtype(T), boundtype(S))

    @eval macro interval(expr)
        return _wrap_interval($boundtype, expr)
    end

    @eval _parse(str::AbstractString) = parse(Interval{$boundtype}, str)

    @eval emptyinterval() = emptyinterval(Interval{$boundtype})

    @eval entireinterval() = entireinterval(Interval{$boundtype})

    @eval nai() = nai(Interval{$boundtype})

    return boundtype
end

function configure_flavor(flavor::Symbol)
    @assert flavor == :set_based

    @eval zero_times_infinity(::Type{T}) where {T<:BoundTypes} = zero_times_infinity(Flavor{$(QuoteNode(flavor))}(), T)

    @eval div_by_thin_zero(x::BareInterval) = div_by_thin_zero(Flavor{$(QuoteNode(flavor))}(), x)

    @eval contains_infinity(x::BareInterval) = contains_infinity(Flavor{$(QuoteNode(flavor))}(), x)

    @eval is_valid_interval(a::Real, b::Real) = is_valid_interval(Flavor{$(QuoteNode(flavor))}(), a, b)

    return flavor
end

function configure_rounding(rounding::Symbol)
    @assert rounding ∈ (:correct, :none)

    for f ∈ (:add, :sub, :mul, :div)
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, y, r)
    end

    @eval _pow_round(x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} = _pow_round(IntervalRounding{$(QuoteNode(rounding))}(), x, y, r)

    @eval _inv_round(x::AbstractFloat, r::RoundingMode) = _inv_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)

    @eval _sqrt_round(x::AbstractFloat, r::RoundingMode) = _sqrt_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)

    @eval _rootn_round(x::AbstractFloat, n::Integer, r::RoundingMode) = _rootn_round(IntervalRounding{$(QuoteNode(rounding))}(), x, n, r)

    @eval _atan_round(x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} = _atan_round(IntervalRounding{$(QuoteNode(rounding))}(), x, y, r)

    for f ∈ [:cbrt, :exp2, :exp10, :cot, :sec, :csc, :tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh]
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x::AbstractFloat, r::RoundingMode) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)
    end

    for f ∈ (:acot, :acoth)
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x::AbstractFloat, r::RoundingMode) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)
    end

    for f ∈ CRlibm.functions
        f_round = Symbol(:_, f, :_round)
        @eval $f_round(x::AbstractFloat, r::RoundingMode) = $f_round(IntervalRounding{$(QuoteNode(rounding))}(), x, r)
    end

    return rounding
end

function configure_power(power::Symbol)
    @assert power ∈ (:slow, :fast)

    for f ∈ (:_select_pow, :_select_pown)
        @eval $f(x, y) = $f(PowerMode{$(QuoteNode(power))}(), x, y)
    end

    return power
end

function configure_matmul(matmul::Symbol)
    @assert matmul ∈ (:slow, :fast)

    for T ∈ (:AbstractVector, :AbstractMatrix) # needed to resolve method ambiguities
        @eval begin
            function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::$T{<:RealOrComplexI}, α::Number, β::Number)
                size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
                return _mul!(MatMulMode{$(QuoteNode(matmul))}(), C, A, B, α, β)
            end

            function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix, B::$T{<:RealOrComplexI}, α::Number, β::Number)
                size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
                return _mul!(MatMulMode{$(QuoteNode(matmul))}(), C, A, B, α, β)
            end

            function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::$T, α::Number, β::Number)
                size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
                return _mul!(MatMulMode{$(QuoteNode(matmul))}(), C, A, B, α, β)
            end
        end
    end

    return matmul
end

function configure(; boundtype::Type{<:BoundTypes}=Float64, flavor::Symbol=:set_based, rounding::Symbol=:correct, power::Symbol=:fast, matmul::Symbol=:fast)
    configure_boundtype(boundtype)

    configure_flavor(flavor)

    configure_rounding(rounding)

    configure_power(power)

    configure_matmul(matmul)

    return boundtype, flavor, rounding, power, matmul
end

configure()

#

bareinterval(::Type{BigFloat}, a::AbstractIrrational) = _unsafe_bareinterval(BigFloat, a, a)

# Note: generated functions must be defined after all the methods they use
@generated function bareinterval(::Type{T}, a::AbstractIrrational) where {T<:BoundTypes}
    x = _unsafe_bareinterval(T, a(), a()) # precompute the interval
    return :($x) # set body of the function to return the precomputed result
end

#

include("symbols.jl")

end
