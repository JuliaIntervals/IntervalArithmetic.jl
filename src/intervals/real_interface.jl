# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=
Description:

This file contains the functions that must be defined on `Interval`s so that
they behave like `Real` in julia.
=#

zero(::F) where {F<:Interval} = zero(F)
function zero(::Type{F}) where {T<:Real, F<:Interval{T}}
    x = zero(T)
    return F(x, x)
end

one(::F) where {F<:Interval} = one(F)
function one(::Type{F}) where {T<:Real, F<:Interval{T}}
    x = one(T)
    return F(x, x)
end

typemin(::Type{F}) where {T<:Real, F<:Interval{T}} = F(typemin(T), nextfloat(typemin(T)))
typemax(::Type{F}) where {T<:Real, F<:Interval{T}} = F(prevfloat(typemax(T)), typemax(T))
# No support for bounds of type integers
# typemin(::Type{F}) where {T<:Integer, F<:Interval{T}} = interval(T, typemin(T))
# typemax(::Type{F}) where {T<:Integer, F<:Interval{T}} = interval(T, typemax(T))

"""
    numtype(::Interval{T}) where {T}

Return the type `T` of the bounds of the interval.

# Example

```julia
julia> numtype(1..2)
Float64
```
"""
numtype(::Interval{T}) where {T} = T

function eps(a::F) where {F<:Interval}
    x = max(eps(inf(a)), eps(sup(a)))
    return F(x, x)
end
function eps(::Type{F}) where {T, F<:Interval{T}}
    x = eps(T)
    return F(x, x)
end

"""
    hash(x::Interval, h)

Compute the integer hash code for an interval using the method for composite
types used in `AutoHashEquals.jl`.

Note that in `IntervalArithmetic.jl`, equality of intervals is given by
`≛` rather than the `==` operator.
The latter is reserved for the pointwise extension of equality to intervals
and uses three-way logic by default.
"""
hash(x::Interval, h::UInt) = hash(sup(x), hash(inf(x), hash(Interval, h)))

# TODO No idea where this comes from and if it is the correct place to put it.
dist(a::Interval, b::Interval) = max(abs(inf(a)-inf(b)), abs(sup(a)-sup(b)))
