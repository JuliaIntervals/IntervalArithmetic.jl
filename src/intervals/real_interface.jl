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
        function Base.:(==)(x::$T, y::$T) # also returned when calling `≤`, `≥`, `isequal`
            isthin(x) && return sup(x) == y
            isthin(y) && return x == sup(y)
            return throw(ArgumentError("`==` is purposely not supported for intervals. See instead `isequal_interval`"))
        end

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

        Base.intersect(::$T) =
            throw(ArgumentError("`intersect` is purposely not supported for intervals. See instead `intersect_interval`"))

        Base.union!(::BitSet, ::$T) = # needed to resolve ambiguity
            throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
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
Base.union!(::AbstractVector{S}, ::BareInterval, ::Interval, ::Any...) where {S} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))
Base.union!(::AbstractVector{S}, ::Interval, ::BareInterval, ::Any...) where {S} =
    throw(ArgumentError("`union!` is purposely not supported for intervals. See instead `hull`"))


# allow pointwise equality

"""
    ==(::BareInterval, ::Number)
    ==(::Number, ::BareInterval)
    ==(::Interval, ::Number)
    ==(::Number, ::Interval)

Test whether an interval is the singleton of a given number. In other words, the
result is true if and only if the interval contains only that number.

!!! note
    Comparison between intervals is purposely disallowed. Indeed, equality
    between non-singleton intervals has distinct properties, notably ``x = y``
    does not imply ``x - y = 0``. See instead [`isequal_interval`](@ref).
"""
Base.:(==)(x::Union{BareInterval,Interval}, y::Number) = isthin(x, y)
Base.:(==)(x::Number, y::Union{BareInterval,Interval}) = y == x
# needed to resolve ambiguity from irrationals.jl
Base.:(==)(x::Interval, y::AbstractIrrational) = isthin(x, y)
Base.:(==)(x::AbstractIrrational, y::Interval) = y == x
# needed to resolve ambiguity from complex.jl
Base.:(==)(x::Interval, y::Complex) = isreal(y) & (real(y) == x)
Base.:(==)(x::Complex, y::Interval) = y == x

# follows docstring of `Base.iszero`
Base.iszero(x::Union{BareInterval,Interval}) = isthinzero(x)

# follows docstring of `Base.isone`
Base.isone(x::Union{BareInterval,Interval}) = isthinone(x)

# follows docstring of `Base.isinteger`
Base.isinteger(x::Union{BareInterval,Interval}) = isthininteger(x)
