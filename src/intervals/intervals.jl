# This file is part of the IntervalArithmetic.jl package; MIT licensed

# TODO Use that
# TODO DOcument it too
default_bound() = Float64

# TODO Better doc here
"""
    Interval

An interval for guaranteed computation.
"""
struct Interval{T} <: Real
    lo::T
    hi::T

    function Interval{T}(a, b) where T
        new{T}(T(a, RoundDown), T(b, RoundUp))
    end

    function Interval{T}(a::T, b::T) where T
        new{T}(a, b)
    end
end

#= Outer constructors =#
Interval{T}(a) where T = Interval{T}(a, a)
Interval(a) = Interval(a, a)
Interval(a::Tuple) = Interval(a...)

Interval(a::T, b::S) where {T<:AbstractFloat, S} = Interval{promote_type(T, S)}(a, b)
Interval(a::T, b::S) where {T, S<:AbstractFloat} = Interval{promote_type(T, S)}(a, b)
Interval(a::T, b::S) where {T<:AbstractFloat, S<:AbstractFloat} = Interval{promote_type(T, S)}(a, b)
Interval(a::T, b::T) where {T<:AbstractFloat} = Interval{T}(a, b)

Interval(a::T, b::S) where {T, S} = Interval{promote_type(default_bound(), T, S)}(a, b)
Interval(a::T, b::T) where T = Interval{promote_type(default_bound(), T)}(a, b)

#= Integer =#
# Interval(a::T, b::S) where {T<:Integer, S<:Integer} = Interval{default_bound()}(a, b)

#= Irrational =#
# Single argument Irrational constructor are in IntervalArithmetic.jl
# as generated functions need to be define last.
Interval(a::Irrational, b::T) where {T<:AbstractFloat} = Interval{T}(T(a, RoundDown), b)
Interval(a::T, b::Irrational) where {T<:AbstractFloat} = Interval{T}(a, T(b, RoundUp))

function Interval(a::Irrational, b::Irrational)
    T = default_bound()
    return Interval{T}(T(a, RoundDown), T(b, RoundUp))
end

#= Interval =#
Interval{T}(x::Interval{T}) where T = x
Interval{T}(x::Interval) where T = atomic(Interval{T}, x)

#= Complex =#
Interval(x::Complex) = Interval(real(x)) + im*Interval(imag(x))

eltype(::Interval) = Interval
size(::Interval) = (1,)

@inline _normalisezero(a::Real) = ifelse(iszero(a) && signbit(a), copysign(a, 1), a)

"""
    is_valid_interval(a::Real, b::Real)

Check if `(a, b)` constitute a valid interval.
"""
function is_valid_interval(a::Real, b::Real)
    if isnan(a) || isnan(b)
        return false
    end

    a > b && return false

    # TODO Check if this is necessary
    if a == Inf || b == -Inf
        return false
    end

    return true
end

is_valid_interval(a::Real) = true


"""
    interval(a, b)

`interval(a, b)` checks whether [a, b] is a valid `Interval`, using the (non-exported) `is_valid_interval` function. If so, then an `Interval(a, b)` object is returned; if not, a warning is printed and the empty interval is returned.
"""
function interval(a::T, b::S) where {T<:Real, S<:Real}
    if !is_valid_interval(a, b)
        @warn "Invalid input, empty interval is returned"
        return emptyinterval(promote_type(T, S))
    end

    return Interval(a, b)
end

interval(a::Real) = interval(a, a)

# TODO Choose a good name
# NOTE We use a different name in tests for easier refactor
const checked_interval = interval

"Make an interval even if a > b"
function force_interval(a, b)
    a > b && return interval(b, a)  # check == true to check for NaN
    return interval(a, b)
end


## Include files
# Global utilities
include("macros.jl")
include("rounding_macros.jl")
include("rounding.jl")
include("conversion.jl")
include("precision.jl")
include("flavors.jl")

# Arithmetic
include("common/arithmetic/absmax.jl")
include("common/arithmetic/basic.jl")
include("common/arithmetic/hyperbolic.jl")
include("common/arithmetic/integer.jl")
include("common/arithmetic/power.jl")
include("common/arithmetic/signbit.jl")
include("common/arithmetic/trigonometric.jl")

# Other functions
include("common/cancellative.jl")
include("common/constants.jl")
include("common/extended_div.jl")
include("common/boolean.jl")
include("common/misc.jl")
include("common/numeric.jl")
include("common/pointwise_boolean.jl")
include("common/set_operations.jl")
include("common/special.jl")

"""
    a..b
    ..(a, b)

Create the interval `[a, b]` of the default interval type.

See the documentation of `Interval` for more information about the default
interval type.
"""
function ..(a::T, b::S) where {T, S}
    R = promote_type(default_bound(), T, S)
    return checked_interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi)
end

function ..(a::T, b::Irrational{S}) where {T, S}
    R = promote_type(default_bound(), T, Irrational{S})
    return checked_interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi)
end

function ..(a::Irrational{T}, b::S) where {T, S}
    R = promote_type(default_bound(), Irrational{T}, S)
    return checked_interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi)
end

function ..(a::Irrational{T}, b::Irrational{S}) where {T, S}
    R = promote_type(default_bound(), Irrational{T}, Irrational{S})
    return checked_interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi)
end

a ± b = (a-b)..(a+b)
±(a::Interval, b) = (a.lo - b)..(a.hi + b)

"""
    hash(x, h)

Computes the integer hash code for an interval using the method for composite
types used in `AutoHashEquals.jl`

Note that in `IntervalArithmetic.jl`, equality of intervals is given by
`≛` rather than the `==` operator.
"""
hash(x::Interval, h::UInt) = hash(x.hi, hash(x.lo, hash(Interval, h)))
