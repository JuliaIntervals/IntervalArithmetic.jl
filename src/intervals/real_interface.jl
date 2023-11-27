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
numtype(::Type{BareInterval{T}}) where {T<:NumTypes} = T
numtype(::Type{Interval{T}}) where {T<:NumTypes} = T
numtype(::Type{Complex{T}}) where {T<:Real} = numtype(T)
numtype(::Type{T}) where {T} = T
numtype(::T) where {T} = numtype(T)

# standard `Real` functions

for f ∈ (:float, :big)
    @eval begin
        $f(x::BareInterval{T}) where {T<:NumTypes} = BareInterval{$f(T)}(x)
        $f(x::Interval{<:NumTypes}) = _unsafe_interval($f(bareinterval(x)), decoration(x), isguaranteed(x))
    end
end

for f ∈ (:zero, :one)
    @eval begin
        $f(::T) where {T<:BareInterval} = $f(T)
        $f(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, $f(T), $f(T))
        $f(::T) where {T<:Interval} = $f(T)
        $f(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval($f(BareInterval{T}), com, true)
    end
end

typemin(::Type{BareInterval{T}}) where {T<:NumTypes} =
    _unsafe_bareinterval(T, typemin(T), nextfloat(typemin(T)))
typemin(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(typemin(BareInterval{T}), dac, true)

typemax(::Type{BareInterval{T}}) where {T<:NumTypes} =
    _unsafe_bareinterval(T, prevfloat(typemax(T)), typemax(T))
typemax(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(typemax(BareInterval{T}), dac, true)

function eps(a::BareInterval{T}) where {T<:NumTypes}
    x = max(eps(inf(a)), eps(sup(a)))
    return _unsafe_bareinterval(T, x, x)
end
eps(x::Interval) = _unsafe_interval(eps(bareinterval(x)), com, true)
function eps(::Type{BareInterval{T}}) where {T<:NumTypes}
    x = eps(T)
    return _unsafe_bareinterval(T, x, x)
end
eps(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(eps(BareInterval{T}), com, true)

"""
    hash(x, h)

Compute the integer hash code for an interval. Note that equality of intervals
is given by `isequal_interval` rather than the `==` operator.
"""
hash(x::BareInterval, h::UInt) = hash(sup(x), hash(inf(x), hash(BareInterval, h)))
hash(x::Interval, h::UInt) = hash(sup(x), hash(inf(x), hash(Interval, h)))

#

Base.:(==)(::Interval, ::Interval) = # also returned when calling `≤`, `≥`, `isequal`
    throw(ArgumentError("`==` is purposely not supported for intervals. See instead `isequal_interval`."))

Base.:<(::Interval, ::Interval) = # also returned when calling `isless`, `>`
    throw(ArgumentError("`<` is purposely not supported for intervals. See instead `isstrictless`, `strictprecedes`."))

Base.isdisjoint(::Interval, ::Interval) =
    throw(ArgumentError("`isdisjoint` is purposely not supported for intervals. See instead `isdisjoint_interval`."))

Base.issubset(::Interval, ::Interval) =
    throw(ArgumentError("`issubset` is purposely not supported for intervals. See instead `issubset_interval`."))

Base.issetequal(::Interval, ::Interval) =
    throw(ArgumentError("`issetequal` is purposely not supported for intervals. See instead `isequal_interval`."))

Base.in(::Interval, ::Interval) =
    throw(ArgumentError("`in` is purposely not supported for intervals. See instead `in_interval`."))

Base.isempty(::Interval) =
    throw(ArgumentError("`isempty` is purposely not supported for intervals. See instead `isempty_interval`."))

Base.isfinite(::Interval) = # also returned when calling `isinf`
    throw(ArgumentError("`isfinite` is purposely not supported for intervals. See instead `isbounded`."))

Base.isnan(::Interval) =
    throw(ArgumentError("`isnan` is purposely not supported for intervals. See instead `isnai`."))

Base.isinteger(::Interval) =
    throw(ArgumentError("`isinteger` is purposely not supported for intervals. See instead `isthininteger`."))

Base.intersect(::Interval) =
    throw(ArgumentError("`intersect` is purposely not supported for intervals. See instead `intersect_interval`."))

Base.union!(::AbstractSet, ::Interval) = # also returned when calling `intersect`, `symdiff` with intervals
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`."))
Base.union!(::AbstractVector{T}, ::Interval) where {T} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`."))
Base.union!(::AbstractVector{T}, ::Interval, ::Any, ::Any...) where {T} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`."))
Base.union!(::AbstractVector{T}, ::Interval, ::Interval, ::Any...) where {T} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`."))
Base.union!(::AbstractVector{T}, ::Any, ::Interval, ::Any...) where {T} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`."))

Base.setdiff(::Interval) =
    throw(ArgumentError("`setdiff` is purposely not supported for intervals. See instead `setdiff_interval`."))
Base.setdiff!(::AbstractSet, ::Interval) =
    throw(ArgumentError("`setdiff!` is purposely not supported for intervals. See instead `setdiff_interval`."))
