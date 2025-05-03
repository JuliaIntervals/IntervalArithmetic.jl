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
  [`IntervalArithmetic.NumTypes`](@ref) can be used to adjust precision.

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

```julia
using IntervalArithmetic

# Create an interval
x = interval(1.0, 2.0)

# Perform a rigorous computation
x + exp(interval(π))
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

include("display.jl")
    export setdisplay

#

# by-pass `similar` methods defined in array.jl
# note: written in this form to avoid by-passing the default behaviour for `Union{}`
# Base.similar(a::Array{Interval{T},1})          where {T<:NumTypes} = zeros(Interval{T}, size(a, 1))
# Base.similar(a::Array{Complex{Interval{T}},1}) where {T<:NumTypes} = zeros(Complex{Interval{T}}, size(a, 1))

# Base.similar(a::Array{<:Any,1}, S::Type{Interval{T}})          where {T<:NumTypes} = zeros(S, size(a, 1))
# Base.similar(a::Array{<:Any,1}, S::Type{Complex{Interval{T}}}) where {T<:NumTypes} = zeros(S, size(a, 1))

# Base.similar(a::Array{Interval{T},2})          where {T<:NumTypes} = zeros(Interval{T}, size(a, 1), size(a, 2))
# Base.similar(a::Array{Complex{Interval{T}},2}) where {T<:NumTypes} = zeros(Complex{Interval{T}}, size(a, 1), size(a, 2))

# Base.similar(a::Array{<:Any,2}, S::Type{Interval{T}})          where {T<:NumTypes} = zeros(S, size(a, 1), size(a, 2))
# Base.similar(a::Array{<:Any,2}, S::Type{Complex{Interval{T}}}) where {T<:NumTypes} = zeros(S, size(a, 1), size(a, 2))

# Base.similar(::Array{Interval{T}},          m::Int) where {T<:NumTypes} = zeros(Interval{T}, m)
# Base.similar(::Array{Complex{Interval{T}}}, m::Int) where {T<:NumTypes} = zeros(Complex{Interval{T}}, m)

# Base.similar(::Array{Interval{T}},          dims::Dims) where {T<:NumTypes} = zeros(Interval{T}, dims)
# Base.similar(::Array{Complex{Interval{T}}}, dims::Dims) where {T<:NumTypes} = zeros(Complex{Interval{T}}, dims)

# Base.similar(::Array, S::Type{Interval{T}},          dims::Dims) where {T<:NumTypes} = zeros(S, dims)
# Base.similar(::Array, S::Type{Complex{Interval{T}}}, dims::Dims) where {T<:NumTypes} = zeros(S, dims)

#

function configure_numtype(numtype::Type{<:NumTypes})
    @eval promote_numtype(::Type{T}, ::Type{S}) where {T,S} = promote_type($numtype, numtype(T), numtype(S))
    @eval macro interval(expr)
        return _wrap_interval($numtype, expr)
    end
    @eval _parse(str::AbstractString) = parse(Interval{$numtype}, str)
    @eval emptyinterval() = emptyinterval(Interval{$numtype})
    @eval entireinterval() = entireinterval(Interval{$numtype})
    @eval nai() = nai(Interval{$numtype})
    return numtype
end

function configure_flavor(flavor::Symbol)
    flavor == :set_based || return throw(ArgumentError("only the interval flavor `:set_based` is supported and implemented"))
    @eval zero_times_infinity(::Type{T}) where {T<:NumTypes} = zero_times_infinity(Flavor{$(QuoteNode(flavor))}(), T)
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

# define the functions for matmul here to be able to access them

function configure_matmul(matmul)
    matmul ∈ (:slow, :fast) || return throw(ArgumentError("only the matrix multiplication mode `:slow` and `:fast` are available"))
    return matmul
end

"""
    MatMulMode

Matrix multiplication mode type.

Available mode types:
- `:slow` (default): generic algorithm.
- `:fast` : Rump's algorithm.
"""
struct MatMulMode{T} end

_mul!() = error("This function requires LinearAlgebra to be loaded")

"""
    configure(; numtype=Float64, flavor=:set_based, rounding=:correct, power=:fast, matmul=:fast)

Configure the default behavior for:

- **Bound Type**: The default numerical type used to represent the bounds of the
  intervals. The default is `Float64`, but other subtypes of
  [`IntervalArithmetic.NumTypes`](@ref) can be used to adjust precision.

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
function configure(; numtype::Type{<:NumTypes}=Float64, flavor::Symbol=:set_based, rounding::Symbol=:correct, power::Symbol=:fast, matmul::Symbol=:slow)
    configure_numtype(numtype)
    configure_flavor(flavor)
    configure_rounding(rounding)
    configure_power(power)
    configure_matmul(matmul)
    return numtype, flavor, rounding, power, matmul
end

configure()

#

include("symbols.jl")

# in 1.10, having two standard libraries as package extensions yields circular
# dependencies. We keep LinearAlgebra as a weak dependcy and add Random as a
# dependency (cf. https://github.com/JuliaLang/julia/issues/52511)

import Random

Random.rand(rng::Random.AbstractRNG, ::Random.SamplerType{Interval{T}}) where {T<:IntervalArithmetic.NumTypes} =
    interval(rand(rng, T))

sample(x::Interval) = sample(Random.default_rng(), x)

function sample(rng::Random.AbstractRNG, x::Interval{T}) where {T<:NumTypes}
    lo, hi = bounds(x)
    β = rand(rng, float(T))
    lo = ifelse(lo == typemin(T), _value_min(T), lo)
    hi = ifelse(hi == typemax(T), _value_max(T), hi)
    val = convert(T, (1 - β) * lo + β * hi)
    val = ifelse(val < lo, lo, val)
    val = ifelse(val > hi, hi, val)
    return val
end

_value_min(::Type{T}) where {T<:AbstractFloat} = floatmin(T)
_value_max(::Type{T}) where {T<:AbstractFloat} = floatmax(T)

_value_min(::Type{Rational{T}}) where {T<:Integer} = convert(Rational{T}, typemin(T))
_value_max(::Type{Rational{T}}) where {T<:Integer} = convert(Rational{T}, typemax(T))

    export sample

#

bareinterval(::Type{BigFloat}, a::AbstractIrrational) = _unsafe_bareinterval(BigFloat, a, a)

# Note: generated functions must be defined after all the methods they use
@generated function bareinterval(::Type{T}, a::AbstractIrrational) where {T<:NumTypes}
    x = _unsafe_bareinterval(T, a(), a()) # precompute the interval
    return :($x) # set body of the function to return the precomputed result
end

end
