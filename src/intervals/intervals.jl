# This file is part of the ValidatedNumerics.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

## Interval type

immutable Interval{T<:Real} <: Real
    lo :: T
    hi :: T

    function Interval(a::Real, b::Real)
        if a > b
            a, b = b, a
        end
        new(a, b)
    end
end


## Outer constructors

Interval{T<:Real}(a::T, b::T) = Interval{T}(a, b)
Interval{T<:Real}(a::T) = Interval(a, a)
Interval(a::Real) = Interval(a, a)
Interval(a::Tuple) = Interval(a...)
Interval{T<:Real, S<:Real}(a::T, b::S) = Interval(promote(a,b)...)

eltype{T<:Real}(x::Interval{T}) = T


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
