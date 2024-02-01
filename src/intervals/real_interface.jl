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

for T ∈ (:BareInterval, :Interval)
    @eval begin
        Base.isdisjoint(::$T, ::$T) = throw(ArgumentError("`isdisjoint` is purposely not supported for intervals. See instead `isdisjoint_interval`"))

        Base.issubset(::$T, ::$T) = throw(ArgumentError("`issubset` is purposely not supported for intervals. See instead `issubset_interval`"))

        Base.issetequal(::$T, ::$T) = throw(ArgumentError("`issetequal` is purposely not supported for intervals. See instead `isequal_interval`"))

        Base.in(::$T, ::$T) = throw(ArgumentError("`in` is purposely not supported for intervals. See instead `in_interval`"))

        Base.isempty(::$T) = throw(ArgumentError("`isempty` is purposely not supported for intervals. See instead `isempty_interval`"))

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

# allow pointwise equality

"""
    ==(::BareInterval, ::Number)
    ==(::Number, ::BareInterval)
    ==(::Interval, ::Number)
    ==(::Number, ::Interval)

Equivalent to `isthin`, but throws an error whenever the input interval is not
thin.

!!! note
    Comparison between intervals is purposely disallowed. Indeed, equality
    between non-singleton intervals has distinct properties, notably ``x = y``
    does not imply ``x - y = 0``. See instead [`isequal_interval`](@ref).

See also: [`isthin`](@ref).
"""
function Base.:(==)(x::Union{BareInterval,Interval}, y::Union{BareInterval,Interval}) # also returned when calling `≤`, `≥`, `isequal`
    isthin(y) || return throw(ArgumentError("`==` is only supported for thin intervals. See instead `isequal_interval`"))
    # `y` is not empty, nor an NaI
    return x == sup(y)
end
function Base.:(==)(x::Union{BareInterval,Interval}, y::Number)
    isthin(x) || return throw(ArgumentError("`==` is only supported between thin intervals and numbers. See instead `isequal_interval`"))
    # `x` is not empty, nor an NaI
    return sup(x) == y
end
Base.:(==)(x::Number, y::Union{BareInterval,Interval}) = y == x
function Base.:(==)(x::Union{BareInterval,Interval}, y::Complex)
    isthin(x) || return throw(ArgumentError("`==` is only supported between thin intervals and numbers. See instead `isequal_interval`"))
    # `x` is not empty, nor an NaI
    return sup(x) == y
end
Base.:(==)(x::Complex, y::Union{BareInterval,Interval}) = y == x

Base.:(==)(x::BareInterval, y::Interval) = throw(MethodError(==, (x, y)))
Base.:(==)(x::Interval, y::BareInterval) = throw(MethodError(==, (x, y)))
Base.:(==)(x::BareInterval, y::Complex{<:Interval}) = throw(MethodError(==, (x, y)))
Base.:(==)(x::Complex{<:Interval}, y::BareInterval) = throw(MethodError(==, (x, y)))

"""
    <(::BareInterval, ::Real)
    <(::Real, ::BareInterval)
    <(::Interval, ::Real)
    <(::Real, ::Interval)

Equivalent to `strictprecedes`, but throws an error whenever the input interval
is not thin.

!!! note
    Comparison between intervals is purposely disallowed. Indeed, equality
    between non-singleton intervals has distinct properties, notably ``x < y``
    does not imply ``x - y < 0``. See instead [`isequal_interval`](@ref).

See also: [`strictprecedes`](@ref).
"""
function Base.:<(x::Union{BareInterval,Interval}, y::Union{BareInterval,Interval}) # also returned when calling `isless`, `>`
    isthin(y) || return throw(ArgumentError("`<` is only supported for thin intervals. See instead `isstrictless`, `strictprecedes`"))
    # `y` is not empty, nor an NaI
    return x < sup(y)
end
function Base.:<(x::Union{BareInterval,Interval}, y::Real)
    isthin(x) || return throw(ArgumentError("`<` is only supported between thin intervals and numbers. See instead `isequal_interval`"))
    # `x` is not empty, nor an NaI
    return sup(x) < y
end
function Base.:<(x::Real, y::Union{BareInterval,Interval})
    isthin(y) || return throw(ArgumentError("`<` is only supported between thin intervals and numbers. See instead `isequal_interval`"))
    # `y` is not empty, nor an NaI
    return x < sup(y)
end

Base.:<(x::BareInterval, y::Interval) = throw(MethodError(<, (x, y)))
Base.:<(x::Interval, y::BareInterval) = throw(MethodError(<, (x, y)))

"""
    isnan(::BareInterval)
    isnan(::Interval)

Return `false`, but throws an error whenever the input interval is not thin.

See also: [`isbounded`](@ref).
"""
function Base.isnan(x::Union{BareInterval,Interval})
    isthin(x) || return throw(ArgumentError("`isnan` is only supported for thin intervals. See instead `isnai`"))
    # `x` is not empty, nor an NaI
    return false
end

"""
    isfinite(::BareInterval)
    isfinite(::Interval)

Equivalent to `isbounded`, but throws an error whenever the input interval is
not thin.

See also: [`isbounded`](@ref).
"""
function Base.isfinite(x::Union{BareInterval,Interval}) # also returned when calling `isinf`
    isthin(x) || return throw(ArgumentError("`isfinite` is only supported for thin intervals. See instead `isbounded`"))
    # `x` is not empty, nor an NaI
    return isfinite(sup(x))
end

"""
    iszero(::BareInterval)
    iszero(::Interval)

Equivalent to `isthinzero`, but throws an error whenever the input interval is
not thin.

See also: [`isthinzero`](@ref).
"""
function Base.iszero(x::Union{BareInterval,Interval})
    isthin(x) || return throw(ArgumentError("`iszero` is only supported for thin intervals. See instead `isthinzero`"))
    # `x` is not empty, nor an NaI
    return iszero(sup(x))
end

"""
    isone(::BareInterval)
    isone(::Interval)

Equivalent to `isthinone`, but throws an error whenever the input interval is
not thin.

See also: [`isthinone`](@ref).
"""
function Base.isone(x::Union{BareInterval,Interval})
    isthin(x) || return throw(ArgumentError("`isone` is only supported for thin intervals. See instead `isthinone`"))
    # `x` is not empty, nor an NaI
    return isone(sup(x))
end

"""
    isinteger(::BareInterval)
    isinteger(::Interval)

Equivalent to `isthininteger`, but throws an error whenever the input interval is
not thin.

See also: [`isthininteger`](@ref).
"""
function Base.isinteger(x::Union{BareInterval,Interval})
    isthin(x) || return throw(ArgumentError("`isinteger` is only supported for thin intervals. See instead `isthininteger`"))
    # `x` is not empty, nor an NaI
    return isinteger(sup(x))
end
