"""
    IntervalArithmetic

Library for validated numerics using interval arithmetic. It provides tools for
performing numerical calculations with guaranteed bounds by representing values
as intervals: computed results enclose the true value. It is well-suited for
computer-assisted proofs, and any context requiring certified numerics.

Learn more: https://github.com/JuliaIntervals/IntervalArithmetic.jl.

## Configuration options

The behavior and performance of the library can be customized through the
following parameters. All defaults can be modified using
[`IntervalArithmetic.configure`](@ref).

- **Bound Type**: The default numerical type used for interval endpoints. The
  default is `Float64`, but any subtype of [`IntervalArithmetic.NumTypes`](@ref)
  may be used to adjust precision, or specific numerical requirements.

- **Flavor**: The interval interpretation according to the IEEE Standard
  1788-2015. The default is the *set-based flavor*, which excludes infinity
  from intervals. Learn more: [`IntervalArithmetic.Flavor`](@ref).

- **Interval Rounding**: The rounding behavior for interval arithmetic
  operations. By default, the library employs *correct rounding* to ensure that
  bounds are computed as tightly as possible. Learn more:
  [`IntervalArithmetic.IntervalRounding`](@ref).

- **Power mode**: The performance setting for computing powers. The default is
  an efficient algorithm prioritizing performance over precision. Learn more:
  [`IntervalArithmetic.PowerMode`](@ref).

- **Matrix Multiplication mode**: The performance setting for computing matrix
  multiplications. The default is an efficient algorithm prioritizing
  performance over precision. Learn more:
  [`IntervalArithmetic.MatMulMode`](@ref).

## Display settings

The display of intervals is controlled by [`setdisplay`](@ref). By default, the
intervals are shown using the standard mathematical notation ``[a, b]``, along
with decorations and up to 6 significant digits.
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

mutable struct ConfigurationOptions
    numtype  :: Type{<:NumTypes}
    flavor   :: Symbol
    rounding :: Symbol
    power    :: Symbol
    matmul   :: Symbol
end

function Base.show(io::IO, ::MIME"text/plain", params::ConfigurationOptions)
    println(io, "Configuration options:")
    println(io, "  - bound type: ", params.numtype)
    println(io, "  - flavor: ", params.flavor)
    println(io, "  - interval rounding: ", params.rounding)
    println(io, "  - power mode: ", params.power)
    print(io, "  - matrix multiplication mode: ", params.matmul)
end

const configuration_options = ConfigurationOptions(Float64, :set_based, :correct, :fast, :fast) # default

function configure_numtype(numtype::Type{<:NumTypes})
    @eval default_numtype() = $numtype
    return numtype
end

function configure_flavor(flavor::Symbol)
    flavor == :set_based || return throw(ArgumentError("only the interval flavor `:set_based` is supported and implemented"))
    @eval default_flavor() = Flavor{$(QuoteNode(flavor))}()
    return flavor
end

function configure_rounding(rounding::Symbol)
    rounding ∈ (:correct, :none) || return throw(ArgumentError("only the rounding mode `:correct` and `:none` are available"))
    @eval default_rounding() = IntervalRounding{$(QuoteNode(rounding))}()
    return rounding
end

function configure_power(power::Symbol)
    power ∈ (:slow, :fast) || return throw(ArgumentError("only the power mode `:slow` and `:fast` are available"))
    @eval default_power() = PowerMode{$(QuoteNode(power))}()
    return power
end

# algorithms are defined in the package extension for LinearAlgebra

"""
    MatMulMode{T}

Matrix multiplication mode type.

Available mode types:
- `:fast` (default): Rump's algorithm.
- `:slow` (always used for high-precision number types, e.g., `BigFloat`): generic algorithm.
"""
struct MatMulMode{T} end

function configure_matmul(matmul)
    matmul ∈ (:slow, :fast) || return throw(ArgumentError("only the matrix multiplication mode `:slow` and `:fast` are available"))
    @eval default_matmul() = MatMulMode{$(QuoteNode(matmul))}()
    return matmul
end

"""
    configure(; numtype=Float64, flavor=:set_based, rounding=:correct, power=:fast, matmul=:fast)

Configure the default behavior for:

- **Bound Type**: The default numerical type used for interval endpoints. The
  default is `Float64`, but any subtype of [`IntervalArithmetic.NumTypes`](@ref)
  may be used to adjust precision, or specific numerical requirements.

- **Flavor**: The interval interpretation according to the IEEE Standard
  1788-2015. The default is the *set-based flavor*, which excludes infinity
  from intervals. Learn more: [`IntervalArithmetic.Flavor`](@ref).

- **Interval Rounding**: The rounding behavior for interval arithmetic
  operations. By default, the library employs *correct rounding* to ensure that
  bounds are computed as tightly as possible. Learn more:
  [`IntervalArithmetic.IntervalRounding`](@ref).

- **Power mode**: The performance setting for computing powers. The default is
  an efficient algorithm prioritizing performance over precision. Learn more:
  [`IntervalArithmetic.PowerMode`](@ref).

- **Matrix Multiplication mode**: The performance setting for computing matrix
  multiplications. The default is an efficient algorithm prioritizing
  performance over precision. Learn more:
  [`IntervalArithmetic.MatMulMode`](@ref).
"""
function configure(; numtype::Type{<:NumTypes}=configuration_options.numtype,
        flavor::Symbol=configuration_options.flavor,
        rounding::Symbol=configuration_options.rounding,
        power::Symbol=configuration_options.power,
        matmul::Symbol=configuration_options.matmul)

    if configuration_options.numtype !== numtype
        configure_numtype(numtype)
        configuration_options.numtype = numtype
    end
    if configuration_options.flavor !== flavor
        configure_flavor(flavor)
        configuration_options.flavor = flavor
    end
    if configuration_options.rounding !== rounding
        configure_rounding(rounding)
        configuration_options.rounding = rounding
    end
    if configuration_options.power !== power
        configure_power(power)
        configuration_options.power = power
    end
    if configuration_options.matmul !== matmul
        configure_matmul(matmul)
        configuration_options.matmul = matmul
    end
    return configuration_options
end

configure_numtype(configuration_options.numtype)
configure_flavor(configuration_options.flavor)
configure_rounding(configuration_options.rounding)
configure_power(configuration_options.power)
configure_matmul(configuration_options.matmul)

#

include("symbols.jl")

# in 1.10, having two standard libraries as package extensions yields circular
# dependencies. We keep LinearAlgebra as a weak dependency and add Random as a
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
