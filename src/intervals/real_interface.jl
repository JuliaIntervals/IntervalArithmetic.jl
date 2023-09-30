"""
    numtype(::T)
    numtype(::Type{T})

Return the type `T` of the bounds of the interval.

# Example
```
julia> IntervalArithmetic.numtype(interval(1, 2))
Float64
```
"""
numtype(::F) where {F} = numtype(F)
numtype(::Type{Interval{T}}) where {T<:NumTypes} = T
numtype(::Type{T}) where {T} = T

# standard `Real` functions

float(x::Interval{T}) where {T<:NumTypes} = Interval{float(T)}(x)
big(x::Interval{T}) where {T<:NumTypes} = Interval{big(T)}(x)

zero(::F) where {F<:Interval} = zero(F)
function zero(::Type{Interval{T}}) where {T<:NumTypes}
    x = zero(T)
    return unsafe_interval(T, x, x)
end

one(::F) where {F<:Interval} = one(F)
function one(::Type{Interval{T}}) where {T<:NumTypes}
    x = one(T)
    return unsafe_interval(T, x, x)
end

typemin(::Type{Interval{T}}) where {T<:NumTypes} = unsafe_interval(T, typemin(T), nextfloat(typemin(T)))
typemax(::Type{Interval{T}}) where {T<:NumTypes} = unsafe_interval(T, prevfloat(typemax(T)), typemax(T))

function eps(a::Interval{T}) where {T<:NumTypes}
    x = max(eps(inf(a)), eps(sup(a)))
    return unsafe_interval(T, x, x)
end
function eps(::Type{Interval{T}}) where {T<:NumTypes}
    x = eps(T)
    return unsafe_interval(T, x, x)
end

"""
    hash(x::Interval, h)

Compute the integer hash code for an interval using the method for composite
types used in `AutoHashEquals.jl`.

Note that in `IntervalArithmetic.jl`, equality of intervals is given by
`isequalinterval` rather than the `==` operator.
The latter is reserved for the pointwise extension of equality to intervals
and uses three-way logic by default.
"""
hash(x::Interval, h::UInt) = hash(sup(x), hash(inf(x), hash(Interval, h)))

# TODO No idea where this comes from and if it is the correct place to put it.
dist(a::Interval, b::Interval) = max(abs(inf(a)-inf(b)), abs(sup(a)-sup(b)))

#

Base.:(==)(::Interval, ::Interval) = # also returned when calling `≤`, `≥`, `isequal`
    throw(ArgumentError("`==` is purposely not supported for intervals. See instead `isequalinterval`."))

Base.:<(::Interval, ::Interval) = # also returned when calling `isless`, `>`
    throw(ArgumentError("`<` is purposely not supported for intervals. See instead `isstrictless`, `strictprecedes`."))

Base.isdisjoint(::Interval, ::Interval) =
    throw(ArgumentError("`isdisjoint` is purposely not supported for intervals. See instead `isdisjointinterval`."))

Base.issubset(::Interval, ::Interval) =
    throw(ArgumentError("`issubset` is purposely not supported for intervals. See instead `isweakinterior`."))

Base.issetequal(::Interval, ::Interval) =
    throw(ArgumentError("`issetequal` is purposely not supported for intervals. See instead `isequalinterval`."))

Base.in(::Interval, ::Interval) =
    throw(ArgumentError("`in` is purposely not supported for intervals. See instead `ismember`."))

Base.isempty(::Interval) =
    throw(ArgumentError("`isempty` is purposely not supported for intervals. See instead `isemptyinterval`."))

Base.isfinite(::Interval) = # also returned when calling `isinf`
    throw(ArgumentError("`isfinite` is purposely not supported for intervals. See instead `isbounded`."))

Base.isnan(::Interval) =
    throw(ArgumentError("`isnan` is purposely not supported for intervals. See instead `isnai`."))

Base.isinteger(::Interval) =
    throw(ArgumentError("`isinteger` is purposely not supported for intervals. See instead `isthininteger`."))
