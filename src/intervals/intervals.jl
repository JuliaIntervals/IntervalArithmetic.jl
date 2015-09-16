# This file is part of the ValidatedNumerics.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

## Interval type

immutable Interval{T<:Real} <: Real
    lo :: T
    hi :: T

    function Interval(a::Real, b::Real)
        # The following exception is needed to define emptyintervals as [∞,-∞]
        (isinf(a) && isinf(b)) && return new(a,b)

        if a > b
            a, b = b, a
        end
        new(a, b)
    end
end


## Outer constructors

Interval{T<:Real}(a::T, b::T) = Interval{T}(a, b)
Interval{T<:Real}(a::T) = Interval(a, a)
Interval(a::Tuple) = Interval(a...)
Interval{T<:Real, S<:Real}(a::T, b::S) = Interval(promote(a,b)...)

## Concrete constructors for Interval, to effectively deal only with Float64,
# BigFloat or Rational{Integer} intervals.
Interval{T<:Integer}(a::T, b::T) = Interval{Float64}(a,b)
Interval{T<:Irrational}(a::T, b::T) = Interval{Float64}(a,b)
## The following is type unstable
# Interval{T<:Integer}(a::T, b::T) = Interval{get_interval_precision()[1]}(a,b)
# Interval{T<:Irrational}(a::T, b::T) = Interval{get_interval_precision()[1]}(a,b)

eltype{T<:Real}(x::Interval{T}) = T


## Include files
include("special_intervals.jl")
include("printing.jl")
include("rationalize.jl")
include("parameters.jl")
include("rounding.jl")
include("macro_definitions.jl")
include("conversion_promotion.jl")
include("arithmetic.jl")
include("precision.jl")
include("trigonometric_functions.jl")
include("functions.jl")
