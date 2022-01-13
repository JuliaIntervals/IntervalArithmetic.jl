#= This file contains the function that must be defined on Intervals
    so that they behave like Real in julia.
=#

real(a::Interval) = a

zero(a::F) where {T<:Real, F<:Interval{T}} = F(zero(T))
zero(::Type{F}) where {T<:Real, F<:Interval{T}} = F(zero(T))

one(a::F) where {T<:Real, F<:Interval{T}} = F(one(T))
one(::Type{F}) where {T<:Real, F<:Interval{T}} = F(one(T))

typemin(::Type{F}) where {T<:Real, F<:Interval{T}} = F(typemin(T), nextfloat(typemin(T)))
typemax(::Type{F}) where {T<:Real, F<:Interval{T}} = F(prevfloat(typemax(T)), typemax(T))
typemin(::Type{F}) where {T<:Integer, F<:Interval{T}} = F(typemin(T))
typemax(::Type{F}) where {T<:Integer, F<:Interval{T}} = F(typemax(T))

size(::Interval) = (1,)
eltype(::F) where {F<:Interval} = F

"""
    numtype(x::Interval)

Returns the type of the bounds of the interval.

### Example

```julia
julia> numtype(1..2)
Float64
```
"""
numtype(::Interval{T}) where T = T

eps(a::F) where {F<:Interval} = F(max(eps(a.lo), eps(a.hi)))
eps(::Type{F}) where {T, F<:Interval{T}} = F(eps(T))

"""
    hash(x::Interval, h)

Computes the integer hash code for an interval using the method for composite
types used in `AutoHashEquals.jl`

Note that in `IntervalArithmetic.jl`, equality of intervals is given by
`≛` rather than the `==` operator.
The latter is reserved for the pointwise extension of equality to intervals
and uses three-way logic by default.
"""
hash(x::Interval, h::UInt) = hash(x.hi, hash(x.lo, hash(Interval, h)))

# TODO No idea what this comes from. Need to check the standard for this.
dist(a::Interval, b::Interval) = max(abs(a.lo-b.lo), abs(a.hi-b.hi))

