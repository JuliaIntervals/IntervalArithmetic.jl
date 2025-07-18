"""
    numtype(T)

Return the bound type of the interval.

# Examples

```jldoctest
julia> numtype(interval(1, 2))
Float64

julia> numtype(interval(Float32, 1, 2))
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
        Base.$f(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, $f(T), $f(T))
        Base.$f(::BareInterval{T}) where {T<:NumTypes} = $f(BareInterval{T})

        Base.$f(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval($f(BareInterval{T}), com, true)
        Base.$f(x::Interval{T}) where {T<:NumTypes} = _unsafe_interval($f(BareInterval{T}), com, isguaranteed(x))
    end
end

Base.zero(::Type{Complex{Interval{T}}}) where {T<:NumTypes} = complex(zero(Interval{T}), zero(Interval{T}))
Base.zero(x::Complex{<:Interval}) = complex(zero(real(x)), zero(imag(x)))

Base.one(::Type{Complex{Interval{T}}}) where {T<:NumTypes} = complex(one(Interval{T}), zero(Interval{T}))
Base.one(x::Complex{<:Interval}) = complex(one(real(x)), zero(imag(x)))

Base.typemin(::Type{BareInterval{T}}) where {T<:NumTypes} =
    _unsafe_bareinterval(T, typemin(T), nextfloat(typemin(T)))
Base.typemin(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(typemin(BareInterval{T}), dac, true)

Base.typemax(::Type{BareInterval{T}}) where {T<:NumTypes} =
    _unsafe_bareinterval(T, prevfloat(typemax(T)), typemax(T))
Base.typemax(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(typemax(BareInterval{T}), dac, true)

function Base.eps(::Type{BareInterval{T}}) where {T<:NumTypes}
    x = eps(T)
    return _unsafe_bareinterval(T, x, x)
end
function Base.eps(x::BareInterval{T}) where {T<:NumTypes}
    y = max(eps(inf(x)), eps(sup(x)))
    return _unsafe_bareinterval(T, y, y)
end
Base.eps(::Type{Interval{T}}) where {T<:NumTypes} =
    _unsafe_interval(eps(BareInterval{T}), com, true)
Base.eps(x::Interval) = _unsafe_interval(eps(bareinterval(x)), com, isguaranteed(x))

"""
    hash(x::BareInterval, h::UInt)
    hash(x::Interval, h::UInt)

Compute the integer hash code for an interval. Note that equality of intervals
is given by [`isequal_interval`](@ref) rather than the `==` operator.
"""
Base.hash(x::BareInterval, h::UInt) = hash(sup(x), hash(inf(x), hash(BareInterval, h)))
Base.hash(x::Interval, h::UInt) = hash(sup(x), hash(inf(x), hash(Interval, h)))

#

function Base.:(==)(x::Interval, y::Interval) # also returned when calling `≤`, `≥`, `isequal`
    isthin(x) & isthin(y) && return isequal_interval(x, y)
    isdisjoint_interval(x, y) && return false
    return throw(ArgumentError("`==` is purposely not supported for overlapping non-thin intervals. See instead `isequal_interval`"))
end

function Base.:<(x::Interval, y::Interval)
    strictprecedes(x, y) && return true
    strictprecedes(y, x) && return false
    isthin(x) & isthin(y) && return !isequal_interval(x, y)
    return throw(ArgumentError("`<` is purposely not supported for overlapping intervals. See instead `strictprecedes`"))
end

function Base.isfinite(x::Interval) # also returned when calling `isinf`
    isbounded(x) && return true
    return throw(ArgumentError("`isfinite` is purposely not supported for intervals containing infinite bounds. See instead `isbounded`"))
end

Base.isnan(x::Interval) = isnai(x)

Base.isinteger(x::Interval) = !isthin(x) & !isdisjoint_interval(x, floor(x), ceil(x)) ? throw(ArgumentError("`isinteger` is purposely not supported for a non-thin interval containing at least one integer. See instead `isthininteger`")) : isthininteger(x)

# disallowed

Base.in(::Interval, ::Interval) =
    throw(ArgumentError("`in` is purposely not supported for intervals. See instead `in_interval`"))

Base.isempty(::Interval) =
    throw(ArgumentError("`isempty` is purposely not supported for intervals. See instead `isempty_interval`"))

Base.isapprox(::Interval, ::Interval) =
    throw(ArgumentError("`isapprox` is purposely not supported for intervals"))

Base.isdisjoint(::Interval, ::Interval) =
    throw(ArgumentError("`isdisjoint` is purposely not supported for intervals. See instead `isdisjoint_interval`"))
Base.issubset(::Interval, ::Interval) =
    throw(ArgumentError("`issubset` is purposely not supported for intervals. See instead `issubset_interval`"))
Base.issetequal(::Interval, ::Interval) =
    throw(ArgumentError("`issetequal` is purposely not supported for intervals. See instead `isequal_interval`"))
Base.intersect(::Interval, ::Interval...) =
    throw(ArgumentError("`intersect` is purposely not supported for intervals. See instead `intersect_interval`"))

Base.union!(::BitSet, ::Interval) = # needed to resolve ambiguity
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
Base.union!(::AbstractSet, ::Interval) = # also returned when calling `intersect`, `symdiff` with intervals
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
Base.union!(::AbstractVector{S}, ::Interval) where {S} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
Base.union!(::AbstractVector{S}, ::Interval, ::Any, ::Any...) where {S} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
Base.union!(::AbstractVector{S}, ::Interval, ::Interval, ::Any...) where {S} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
Base.union!(::AbstractVector{S}, ::Any, ::Interval, ::Any...) where {S} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))

Base.setdiff(::Interval) =
    throw(ArgumentError("`setdiff` is purposely not supported for intervals. See instead `interiordiff`"))
Base.setdiff!(::AbstractSet, ::Interval) =
    throw(ArgumentError("`setdiff!` is purposely not supported for intervals. See instead `interiordiff`"))
