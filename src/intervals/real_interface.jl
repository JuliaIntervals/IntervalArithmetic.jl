"""
    numtype(T)

Return the bounds type of the interval.

# Examples

```jldoctest
julia> IntervalArithmetic.numtype(interval(1, 2))
Float64

julia> IntervalArithmetic.numtype(interval(Float32, 1, 2))
Float32
```
"""
numtype(::Type{BareInterval{T}}) where {T<:NumTypes} = T
numtype(::Type{Interval{T}}) where {T<:NumTypes} = T
numtype(::Type{Complex{T}}) where {T<:Real} = numtype(T)
numtype(::Type{T}) where {T} = T
numtype(::T) where {T} = numtype(T)

# standard `Real` functions

for f ∈ (:float, :big)
    @eval begin
        Base.$f(x::BareInterval{T}) where {T<:NumTypes} = BareInterval{$f(T)}(x)
        Base.$f(x::Interval{<:NumTypes}) = _unsafe_interval($f(bareinterval(x)), decoration(x), isguaranteed(x))
    end
end

for f ∈ (:zero, :one)
    @eval begin
        Base.$f(::T) where {T<:BareInterval} = $f(T)
        Base.$f(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, $f(T), $f(T))
        Base.$f(::T) where {T<:Interval} = $f(T)
        Base.$f(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval($f(BareInterval{T}), com, true)
    end
end

Base.typemin(::Type{BareInterval{T}}) where {T<:NumTypes} =
    _unsafe_bareinterval(T, typemin(T), nextfloat(typemin(T)))
Base.typemin(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(typemin(BareInterval{T}), dac, true)

Base.typemax(::Type{BareInterval{T}}) where {T<:NumTypes} =
    _unsafe_bareinterval(T, prevfloat(typemax(T)), typemax(T))
Base.typemax(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(typemax(BareInterval{T}), dac, true)

function Base.eps(a::BareInterval{T}) where {T<:NumTypes}
    x = max(eps(inf(a)), eps(sup(a)))
    return _unsafe_bareinterval(T, x, x)
end
Base.eps(x::Interval) = _unsafe_interval(eps(bareinterval(x)), com, true)
function Base.eps(::Type{BareInterval{T}}) where {T<:NumTypes}
    x = eps(T)
    return _unsafe_bareinterval(T, x, x)
end
Base.eps(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(eps(BareInterval{T}), com, true)

"""
    hash(x::BareInterval, h::UInt)
    hash(x::Interval, h::UInt)

Compute the integer hash code for an interval. Note that equality of intervals
is given by [`isequal_interval`](@ref) rather than the `==` operator.
"""
Base.hash(x::BareInterval, h::UInt) = hash(sup(x), hash(inf(x), hash(BareInterval, h)))
Base.hash(x::Interval, h::UInt) = hash(sup(x), hash(inf(x), hash(Interval, h)))

#

for T ∈ (:BareInterval, :Interval)
    @eval begin
        Base.:(==)(::$T, ::$T) = # also returned when calling `≤`, `≥`, `isequal`
            throw(ArgumentError("`==` is purposely not supported for intervals. See instead `isequal_interval`"))

        Base.:<(::$T, ::$T) = # also returned when calling `isless`, `>`
            throw(ArgumentError("`<` is purposely not supported for intervals. See instead `isstrictless`, `strictprecedes`"))

        Base.isdisjoint(::$T, ::$T) =
            throw(ArgumentError("`isdisjoint` is purposely not supported for intervals. See instead `isdisjoint_interval`"))

        Base.issubset(::$T, ::$T) =
            throw(ArgumentError("`issubset` is purposely not supported for intervals. See instead `issubset_interval`"))

        Base.issetequal(::$T, ::$T) =
            throw(ArgumentError("`issetequal` is purposely not supported for intervals. See instead `isequal_interval`"))

        Base.in(::$T, ::$T) =
            throw(ArgumentError("`in` is purposely not supported for intervals. See instead `in_interval`"))

        Base.isempty(::$T) =
            throw(ArgumentError("`isempty` is purposely not supported for intervals. See instead `isempty_interval`"))

        Base.isfinite(::$T) = # also returned when calling `isinf`
            throw(ArgumentError("`isfinite` is purposely not supported for intervals. See instead `isbounded`"))

        Base.isnan(::$T) =
            throw(ArgumentError("`isnan` is purposely not supported for intervals. See instead `isnai`"))

        Base.isinteger(::$T) =
            throw(ArgumentError("`isinteger` is purposely not supported for intervals. See instead `isthininteger`"))

        Base.intersect(::$T) =
            throw(ArgumentError("`intersect` is purposely not supported for intervals. See instead `intersect_interval`"))

        Base.union!(::AbstractSet, ::$T) = # also returned when calling `intersect`, `symdiff` with intervals
            throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
        Base.union!(::AbstractVector{S}, ::$T) where {S} =
            throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
        Base.union!(::AbstractVector{S}, ::$T, ::Any, ::Any...) where {S} =
            throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
        Base.union!(::AbstractVector{S}, ::$T, ::$T, ::Any...) where {S} =
            throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
        Base.union!(::AbstractVector{S}, ::Any, ::$T, ::Any...) where {S} =
            throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))

        Base.setdiff(::$T) =
            throw(ArgumentError("`setdiff` is purposely not supported for intervals. See instead `interiordiff`"))
        Base.setdiff!(::AbstractSet, ::$T) =
            throw(ArgumentError("`setdiff!` is purposely not supported for intervals. See instead `interiordiff`"))
    end
end
