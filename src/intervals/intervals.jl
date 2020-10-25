# This file is part of the IntervalArithmetic.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

if haskey(ENV, "IA_VALID")
    const validity_check = true
else
    const validity_check = false
end


if haskey(ENV, "IA_DEFAULT_BOUND_TYPE")
    @eval quote
        const DefaultBound = $(ENV["IA_DEFAULT_BOUND_TYPE"])
    end
else
    const DefaultBound = Float64
end


"""
    AbstractFlavor <: Real

Supertype of all interval flavors (*interval Flavor* is the IEEE-Standard term
for a type of interval).
"""
abstract type AbstractFlavor{T} <: Real end

eltype(::F) where {F<:AbstractFlavor} = F
size(::AbstractFlavor) = (1,)

struct SetBasedInterval{T} <: AbstractFlavor{T}
    lo :: T
    hi :: T

    function SetBasedInterval{T}(a::T, b::T) where {T}
        if validity_check && !is_valid_interval(a, b)
            throw(ArgumentError("Interval of form [$a, $b] not allowed. Must have a ≤ b to construct interval(a, b)."))
        else
            return new(a, b)
        end
    end
end

function (::Type{F})(args... ; check=false) where {F<:AbstractFlavor}
    if check && !is_valid_interval(args...)
        throw(ArgumentError("Interval of form [$a, $b] not allowed. Must have a ≤ b to construct interval(a, b)."))
    else
        return F(args...)
    end
end

#= Outer constructors =#
(::Type{F})(a::T) where {F<:AbstractFlavor, T} = F(a, a)
(::Type{F})(a::Tuple) where {F<:AbstractFlavor} = F(a...)
(::Type{F})(a::T, b::T) where {F<:AbstractFlavor, T} = F{T}(a, b)
(::Type{F})(a::T, b::S) where {F<:AbstractFlavor, T, S} = F(promote(a, b)...)

#= Concrete constructors for Interval, to effectively deal only with Float64,
   BigFloat or Rational{Integer} intervals.
=#
(::Type{F})(a::T, b::T) where {F<:AbstractFlavor, T<:Integer} = F(float(a), float(b))
(::Type{F})(a::S, b::S) where {T, F<:AbstractFlavor{T}, S<:Integer} = F(convert(T, a), convert(T, b))
(::Type{F})(x::AbstractFlavor) where {F<:AbstractFlavor} = F(x.lo, x.hi)
(::Type{F})(x::F) where {T, F<:AbstractFlavor{T}} = x
(::Type{F})(x) where {T, F<:AbstractFlavor{T}} = F(convert(T, x))
(::Type{F})(x::G) where {T, F<:AbstractFlavor{T}, G<:AbstractFlavor} = atomic(F, x)

(::Type{F})(x::Complex) where {F<:AbstractFlavor} = F(real(x)) + im*F(imag(x))

# Constructors for Irrational
# Single argument Irrational constructor are in IntervalArithmetic.jl
# as generated functions need to be define last.
(::Type{F})(a::Irrational, b::Irrational) where {T, F<:AbstractFlavor{T}} = F(T(a, RoundDown), T(b, RoundUp))
(::Type{F})(a::Irrational, b::Real) where {T, F<:AbstractFlavor{T}} = F(T(a, RoundDown), b)
(::Type{F})(a::Real, b::Irrational) where {T, F<:AbstractFlavor{T}} = F(a, T(b, RoundUp))

(::Type{F})(a::Irrational, b::Irrational) where {F<:AbstractFlavor} = F{DefaultBound}(a, b)
(::Type{F})(a::Irrational, b::Real) where {F<:AbstractFlavor} = F{DefaultBound}(a, b)
(::Type{F})(a::Real, b::Irrational) where {F<:AbstractFlavor} = F{DefaultBound}(a, b)

# Flavor without parametrization, allows reparametrization
# TODO Find a way to do the following in a generic way
flavortype(::Type{SetBasedInterval{T}}) where T = SetBasedInterval

"""
    reparametrize(F::Type{AbstractFlavor}, ::Type{T})

Return the type corresponding to flavor `F` with bounds of type `T`.
"""
reparametrize(::Type{F}, ::Type{T}) where {F<:AbstractFlavor, T} = flavortype(F){T}

const supported_flavors = (SetBasedInterval,)

if haskey(ENV, "IA_DEFAULT_FLAVOR")
    @eval quote
        const Interval = $(ENV["IA_DEFAULT_FLAVOR"])
    end
else
    const Interval = SetBasedInterval
end


@doc """
    Interval

Default type of interval, currently set to `$Interval`.

To change this set the environnment variable `ENV["IA_DEFAULT_FLAVOR"]` to a
`Symbol` matching the desired flavor name. Then rebuild the package
(`build IntervalArithmetic` in a REPL in pkg mode).
""" Interval

"""
    is_valid_interval(a::Real, b::Real)

Check if `(a, b)` constitute a valid interval.
"""
function is_valid_interval(a::Real, b::Real)
    if isnan(a) || isnan(b)
        return false
    end

    if a > b
        if isinf(a) && isinf(b)
            return true  # empty interval = [∞,-∞]
        else
            return false
        end
    end

    # TODO Check if this is necessary
    if a == Inf || b == -Inf
        return false
    end

    return true
end

is_valid_interval(a::Real) = true


"""
    interval(a, b)

`interval(a, b)` checks whether [a, b] is a valid `Interval`, which is the case
if `-∞ <= a <= b <= ∞`, using the (non-exported) `is_valid_interval` function.
If so, then an `Interval(a, b)` object is returned; if not, then an error is thrown.
"""
interval(a::Real, b::Real) = Interval(a, b, check=true)

interval(a::Real) = interval(a, a)

"Make an interval even if a > b"
function force_interval(a, b)
    a > b && return interval(b, a)  # check == true to check for NaN
    return interval(a, b)
end


## Include files
include("macros.jl")
include("rounding_macros.jl")
include("rounding.jl")
include("conversion.jl")
include("precision.jl")

include("common/arithmetic/absmax.jl")
include("common/arithmetic/basic.jl")
include("common/arithmetic/hyperbolic.jl")
include("common/arithmetic/integer.jl")
include("common/arithmetic/power.jl")
include("common/arithmetic/signbit.jl")
include("common/arithmetic/trigonometric.jl")

include("common/boolean.jl")
include("common/cancellative.jl")
include("common/constants.jl")
include("common/extended_div.jl")
include("common/misc.jl")
include("common/numeric.jl")
include("common/set_operations.jl")
include("common/special.jl")

include("flavors/arithmetic.jl")
include("flavors/boolean.jl")
include("flavors/special.jl")

"""
    a..b
    ..(a, b)

Create the interval `[a, b]` of the default interval type.

See the documentation of `Interval` for more information about the default
interval type.
"""
function ..(a::T, b::S) where {T, S}
    R = promote_type(T, S)
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

function ..(a::T, b::Irrational{S}) where {T, S}
    R = promote_type(T, Irrational{S})
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

function ..(a::Irrational{T}, b::S) where {T, S}
    R = promote_type(Irrational{T}, S)
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

function ..(a::Irrational{T}, b::Irrational{S}) where {T, S}
    R = promote_type(Irrational{T}, Irrational{S})
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

a ± b = (a-b)..(a+b)
±(a::AbstractFlavor, b) = (a.lo - b)..(a.hi + b)

"""
    hash(x, h)

Computes the integer hash code for an interval using the method for composite
types used in `AutoHashEquals.jl`

Note that in `IntervalArithmetic.jl`, equality of interval is given by
`≛` rather than the `==` operator.
"""
hash(x::F, h::UInt) where {F<:AbstractFlavor} = hash(x.hi, hash(x.lo, hash(flavortype(F), h)))
