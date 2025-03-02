"""
    IntervalArithmetic

Library for validated numerics using interval arithmetic, offering tools to
rigorously bound errors in numerical computations by representing values as
intervals and ensuring that computed results contain the true value. It provides
accurate, and efficient methods, ideal for scientific computing,
computer-assisted proofs, and any domain requiring certified numerical results.

Key features:

- **Bound Type**: The default numerical type used to represent the bounds of the
  intervals. The default is `Float64`, but other subtypes of
  [`IntervalArithmetic.BoundTypes`](@ref) can be used to adjust precision.

- **Flavor**: The interval representation that adhere to the IEEE Standard
  1788-2015. By default, it uses the set-based flavor, which excludes infinity
  to be part of an interval. Learn more: [`IntervalArithmetic.Flavor`](@ref).

- **Interval Rounding**: Controls the rounding behavior for interval arithmetic
  operations. By default, the library employs correct rounding to ensure that
  bounds are computed as tightly as possible. Learn more:
  [`IntervalArithmetic.IntervalRounding`](@ref).

- **Power mode**: A performance setting for power operations. The default mode
  uses an efficient algorithm prioritizing fast computation, but it can be
  adjusted for more precise, slower calculations if needed. Learn more:
  [`IntervalArithmetic.PowerMode`](@ref).

- **Matrix Multiplication mode**: A performance setting for matrix
  multiplication operations. The default mode uses an efficient algorithm
  prioritizing fast computation, but it can be changed to use the standard
  definition of matrix multiplication. Learn more:
  [`IntervalArithmetic.MatMulMode`](@ref).

The default behaviors described above can be configured via
[`IntervalArithmetic.configure`](@ref).

**Display Settings**: controls how intervals are displayed. By default,
intervals are shown using the standard mathematical notation ``[a, b]``, along
with decorations and up to 6 significant digits. Learn more:
[`setdisplay`](@ref).

# Usage

```jldoctest
julia> using IntervalArithmetic

julia> x = interval(1.0, 2.0) # create an interval
[1.0, 2.0]_com

julia> x + exp(interval(π)) # perform a rigorous computation
[24.1406, 25.1407]_com
```

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
    flavor == :set_based || return throw(ArgumentError("only the interval flavor `:set_based` is supported and implemented"))
    @eval zero_times_infinity(::Type{T}) where {T<:BoundTypes} = zero_times_infinity(Flavor{$(QuoteNode(flavor))}(), T)
    @eval div_by_thin_zero(x::BareInterval) = div_by_thin_zero(Flavor{$(QuoteNode(flavor))}(), x)
    @eval contains_infinity(x::BareInterval) = contains_infinity(Flavor{$(QuoteNode(flavor))}(), x)
    @eval is_valid_interval(a::Real, b::Real) = is_valid_interval(Flavor{$(QuoteNode(flavor))}(), a, b)
    return flavor
end

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

function configure_power(power::Symbol)
    power ∈ (:slow, :fast) || return throw(ArgumentError("only the power mode `:slow` and `:fast` are available"))

    for f ∈ (:_select_pow, :_select_pown)
        @eval $f(x, y) = $f(PowerMode{$(QuoteNode(power))}(), x, y)
    end

    return power
end

function configure_matmul(matmul::Symbol)
    matmul ∈ (:slow, :fast) || return throw(ArgumentError("only the matrix multiplication mode `:slow` and `:fast` are available"))

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

"""
    configure(; boundtype=Float64, flavor=:set_based, rounding=:correct, power=:fast, matmul=:fast)

Configure the default behavior for:

- **Bound Type**: The default numerical type used to represent the bounds of the
  intervals. The default is `Float64`, but other subtypes of
  [`IntervalArithmetic.BoundTypes`](@ref) can be used to adjust precision.

- **Flavor**: The interval representation that adhere to the IEEE Standard
  1788-2015. By default, it uses the set-based flavor, which excludes infinity
  to be part of an interval. Learn more: [`IntervalArithmetic.Flavor`](@ref).

- **Interval Rounding**: Controls the rounding behavior for interval arithmetic
  operations. By default, the library employs correct rounding to ensure that
  bounds are computed as tightly as possible. Learn more:
  [`IntervalArithmetic.IntervalRounding`](@ref).

- **Power mode**: A performance setting for power operations. The default mode
  uses an efficient algorithm prioritizing fast computation, but it can be
  adjusted for more precise, slower calculations if needed. Learn more:
  [`IntervalArithmetic.PowerMode`](@ref).

- **Matrix Multiplication mode**: A performance setting for matrix
  multiplication operations. The default mode uses an efficient algorithm
  prioritizing fast computation, but it can be changed to use the standard
  definition of matrix multiplication. Learn more:
  [`IntervalArithmetic.MatMulMode`](@ref).
"""
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
