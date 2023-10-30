# bound type mechanism

"""
    NumTypes

Constant for the supported types of interval bounds. This is set to
`Union{Rational,AbstractFloat}`.
"""
const NumTypes = Union{Rational,AbstractFloat}

"""
    default_numtype()

Return the default bound type used in [`promote_numtype`](@ref). By default,
`default_numtype()` is set to `Float64`. It can be modified by redefining the
function, however it should be set to a concrete subtype of [`NumTypes`](@ref).

# Examples
```jldoctest
julia> IntervalArithmetic.default_numtype() = Float32

julia> typeof(interval(1, 2))
Interval{Float32}

julia> typeof(interval(1, big(2)))
Interval{BigFloat}

julia> IntervalArithmetic.default_numtype() = Float64

julia> typeof(interval(1, 2))
Interval{Float64}

julia> typeof(interval(1, big(2)))
Interval{BigFloat}
```
"""
default_numtype() = Float64

"""
    promote_numtype(T, S)

Return the bound type used to construct intervals. The bound type is given by
`promote_type(T, S)` if `T` or `S` is a `Rational` or an `AbstractFloat`; except
when `T` is a `Rational{R}` and `S` is an `AbstractIrrational` (or vice-versa),
in which case the bound type is given by `Rational{promote_type(R, Int64)}`. In
all other cases, the bound type is given by
`promote_type(default_numtype(), T, S)`.
"""
promote_numtype(::Type{T}, ::Type{S}) where {T<:NumTypes,S<:NumTypes} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T<:NumTypes,S} = promote_type(numtype(T), numtype(S))
promote_numtype(::Type{T}, ::Type{S}) where {T,S<:NumTypes} = promote_type(numtype(T), numtype(S))
promote_numtype(::Type{T}, ::Type{S}) where {T,S} = promote_type(default_numtype(), numtype(T), numtype(S))

promote_numtype(::Type{Rational{T}}, ::Type{<:AbstractIrrational}) where {T<:Integer} = Rational{promote_type(T, Int64)}
promote_numtype(::Type{<:AbstractIrrational}, ::Type{Rational{T}}) where {T<:Integer} = Rational{promote_type(T, Int64)}





# bare interval, i.e. interval with no decoration

"""
    BareInterval{T<:NumTypes}

Interval type for guaranteed computation with interval arithmetic according to
the IEEE Standard 1788-2015. Unlike [`Interval`](@ref), this bare interval does
not have decorations.

Fields:
- `lo :: T`
- `hi :: T`

Constructor compliant with the IEEE Standard 1788-2015: [`bareinterval`](@ref).

!!! warning
    The internal constructor `_unsafe_bareinterval` is *not* compliant with the
    IEEE Standard 1788-2015.

See also: [`Interval`](@ref).
"""
struct BareInterval{T<:NumTypes}
    lo :: T
    hi :: T

    # need explicit signatures to avoid method ambiguities

    global _unsafe_bareinterval(::Type{T}, a::T, b::T) where {S<:Integer,T<:Rational{S}} =
        new{T}(_normalisezero(a), _normalisezero(b))
    _unsafe_bareinterval(::Type{T}, a::T, b::T) where {S<:Union{Int8,UInt8},T<:Rational{S}} =
        new{T}(_normalisezero(a), _normalisezero(b))
    _unsafe_bareinterval(::Type{T}, a::T, b::T) where {S<:Union{Int16,UInt16},T<:Rational{S}} =
        new{T}(_normalisezero(a), _normalisezero(b))

    _unsafe_bareinterval(::Type{T}, a::T, b::T) where {T<:AbstractFloat} =
        new{T}(_normalisezero(a), _normalisezero(b))
end

_normalisezero(a) = ifelse(iszero(a), zero(a), a)

_unsafe_bareinterval(::Type{T}, a::Rational, b::Rational) where {S<:Integer,T<:Rational{S}} =
    _unsafe_bareinterval(T, T(a), T(b))
_unsafe_bareinterval(::Type{T}, a::Rational, b::Rational) where {S<:Union{Int8,UInt8},T<:Rational{S}} =
    _unsafe_bareinterval(T, T(a), T(b))
_unsafe_bareinterval(::Type{T}, a::Rational, b::Rational) where {S<:Union{Int16,UInt16},T<:Rational{S}} =
    _unsafe_bareinterval(T, T(a), T(b))
_unsafe_bareinterval(::Type{T}, a::Rational, b) where {S<:Integer,T<:Rational{S}} =
    _unsafe_bareinterval(T, T(a), rationalize(S, nextfloat(float(S)(b, RoundUp))))
_unsafe_bareinterval(::Type{T}, a, b::Rational) where {S<:Integer,T<:Rational{S}} =
    _unsafe_bareinterval(T, rationalize(S, nextfloat(float(S)(a, RoundDown))), T(b))
function _unsafe_bareinterval(::Type{T}, a, b) where {S<:Integer,T<:Rational{S}}
    R = float(S)
    return _unsafe_bareinterval(T, rationalize(S, prevfloat(R(a, RoundDown))), rationalize(S, nextfloat(R(b, RoundUp))))
end
# need the following since `float(Int8) == float(Int16) == Float64`
_unsafe_bareinterval(::Type{T}, a, b) where {S<:Union{Int8,UInt8},T<:Rational{S}} =
    _unsafe_bareinterval(T, rationalize(S, prevfloat(Float16(a, RoundDown))), rationalize(S, nextfloat(Float16(b, RoundUp))))
_unsafe_bareinterval(::Type{T}, a, b) where {S<:Union{Int16,UInt16},T<:Rational{S}} =
    _unsafe_bareinterval(T, rationalize(S, prevfloat(Float32(a, RoundDown))), rationalize(S, nextfloat(Float32(b, RoundUp))))

_unsafe_bareinterval(::Type{T}, a, b) where {T<:AbstractFloat} = _unsafe_bareinterval(T, T(a, RoundDown), T(b, RoundUp))

# by-pass the absence of `BigFloat(..., ROUNDING_MODE)` (cf. base/irrationals.jl)
# for some irrationals defined in MathConstants (cf. base/mathconstants.jl)
for sym ∈ (:(:ℯ), :(:φ))
    @eval begin
        _unsafe_bareinterval(::Type{BigFloat}, a::Irrational{:ℯ}, b::Irrational{$sym}) =
            _unsafe_bareinterval(BigFloat, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
        _unsafe_bareinterval(::Type{BigFloat}, a::Irrational{:φ}, b::Irrational{$sym}) =
            _unsafe_bareinterval(BigFloat, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
        _unsafe_bareinterval(::Type{BigFloat}, a::Irrational{$sym}, b) =
            _unsafe_bareinterval(BigFloat, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(b, RoundUp))
        _unsafe_bareinterval(::Type{BigFloat}, a, b::Irrational{$sym}) =
            _unsafe_bareinterval(BigFloat, BigFloat(a, RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))

        _unsafe_bareinterval(::Type{Rational{BigInt}}, a::Irrational{:ℯ}, b::Irrational{$sym}) =
            _unsafe_bareinterval(Rational{BigInt}, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
        _unsafe_bareinterval(::Type{Rational{BigInt}}, a::Irrational{:φ}, b::Irrational{$sym}) =
            _unsafe_bareinterval(Rational{BigInt}, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
        _unsafe_bareinterval(::Type{Rational{BigInt}}, a::Irrational{$sym}, b) =
            _unsafe_bareinterval(Rational{BigInt}, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(b, RoundUp))
        _unsafe_bareinterval(::Type{Rational{BigInt}}, a, b::Irrational{$sym}) =
            _unsafe_bareinterval(Rational{BigInt}, BigFloat(a, RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
    end
end

BareInterval{T}(x::BareInterval) where {T<:NumTypes} = bareinterval(T, x)

"""
    bareinterval([T<:Union{Rational,AbstractFloat}=default_numtype()], a, b)

Create the bare interval ``[a, b]`` according to the IEEE Standard 1788-2015.
The validity of the interval is checked by [`is_valid_interval`](@ref): if
`true` then a `BareInterval{T}` is constructed, otherwise a warning is printed
and the empty interval is returned.

!!! warning
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. 0.1). In such cases, use the string
    macro [`@I_str`](@ref) to ensure tight enclosure around the typed numbers.

See also: [`interval`](@ref), [`±`](@ref), [`..`](@ref) and [`@I_str`](@ref).

# Examples
```jldoctest
julia> setdisplay(:full);

julia> bareinterval(1//1, π)
BareInterval{Rational{Int64}}(1//1, 85563208//27235615)

julia> bareinterval(Rational{Int32}, 1//1, π)
BareInterval{Rational{Int32}}(1//1, 85563208//27235615)

julia> bareinterval(1, π)
BareInterval{Float64}(1.0, 3.1415926535897936)

julia> bareinterval(BigFloat, 1, π)
BareInterval{BigFloat}(1.0, 3.141592653589793238462643383279502884197169399375105820974944592307816406286233)
```
"""
function bareinterval(::Type{T}, a, b) where {T<:NumTypes}
    lo = inf(a)
    hi = sup(b)
    is_valid_interval(lo, hi) && return _unsafe_bareinterval(T, lo, hi)
    return emptyinterval(BareInterval{T})
end
bareinterval(a, b) = bareinterval(promote_numtype(numtype(a), numtype(b)), a, b)

bareinterval(::Type{T}, a) where {T<:NumTypes} = bareinterval(T, a, a)
bareinterval(a) = bareinterval(promote_numtype(numtype(a), numtype(a)), a)

bareinterval(::Type{T}, a::BareInterval) where {T<:NumTypes} =
    _unsafe_bareinterval(T, inf(a), sup(a)) # assumes valid interval

# some useful extra constructor
bareinterval(::Type{T}, a::Tuple) where {T<:NumTypes} = bareinterval(T, a...)
bareinterval(a::Tuple) = bareinterval(T, a...)

# note: generated functions must be defined after all the methods they use
@generated function bareinterval(::Type{T}, a::AbstractIrrational) where {T<:NumTypes}
    res = _unsafe_bareinterval(T, a(), a()) # precompute the interval
    return :($res) # set body of the function to return the precomputed result
end

# promotion

Base.promote_rule(::Type{BareInterval{T}}, ::Type{BareInterval{S}}) where {T<:NumTypes,S<:NumTypes} =
    BareInterval{promote_numtype(T, S)}

# conversion

Base.convert(::Type{BareInterval{T}}, a::BareInterval) where {T<:NumTypes} =
    bareinterval(T, a)

"""
    atomic(T<:Union{Rational,AbstractFloat}, a)

Create an interval according to the IEEE Standard 1788-2015. The returned
`Interval{T}` always contains the value `a` but its construction depends on its
type. If `a` is an `AbstractString`, then the interval is constructed by calling
[`parse`](@ref). If `a` is an `AbstractFloat`, the interval is widen to two eps
to be sure to contain the number that was typed in. In all other cases, this is
semantically equivalent to `bareinterval(T, a)`.

# Examples
```jldoctest
julia> setdisplay(:full);

julia> IntervalArithmetic.atomic(Float64, 0.1)
Interval{Float64}(0.09999999999999999, 0.10000000000000002)

julia> IntervalArithmetic.atomic(Float64, 0.3)
Interval{Float64}(0.29999999999999993, 0.30000000000000004)
```
"""
atomic(::Type{T}, a) where {T<:NumTypes} = bareinterval(T, a)

atomic(::Type{T}, a::AbstractString) where {T<:NumTypes} = parse(BareInterval{T}, a)

function atomic(::Type{T}, a::AbstractFloat) where {T<:AbstractFloat}
    lo = T(a, RoundDown)
    hi = T(a, RoundUp)
    if a == lo
        lo = prevfloat(lo)
    end
    if a == hi
        hi = nextfloat(hi)
    end
    return _unsafe_bareinterval(T, lo, hi)
end



# decorations

"""
    Decoration

Enumeration constant for the types of interval decorations described in
Section 11.2 of the IEEE Standard 1788-2015:
- `com -> 4`: non-empty, continuous and bounded (common)
- `dac -> 3`: non-empty and continuous (defined and continuous)
- `def -> 2`: non-empty (defined)
- `trv -> 1`: always true (trivial)
- `bad -> 0`: may not be an interval (badly-formed)
- `ill -> -1`: not an interval (ill-formed)

!!! note
    The decoration `bad` is not part of the IEEE Standard 1788-2015. It is a
    specific decoration added to preserve the flexibility of Julia multiple
    dispatch while still warning the user that the computed interval may not be
    rigorous.
"""
@enum Decoration ill=-1 bad=0 trv=1 def=2 dac=3 com=4
# note: `isless`, and hence `<`, `min` and `max`, are automatically defined

function decoration(x::BareInterval)
    isnai(x) && return ill
    isempty_interval(x) && return trv
    isunbounded(x) && return dac
    return com
end





# decorated intervals

"""
    Interval{T<:NumTypes} <: Real

Interval type for guaranteed computation with interval arithmetic according to
the IEEE Standard 1788-2015. This structure combines a [`BareInterval`](@ref)
together with a [`Decoration`](@ref), i.e. a flag that records the status of the
interval when thought of as the result of a previously executed sequence of
functions acting on an initial interval.

Fields:
- `bareinterval :: BareInterval{T}`
- `decoration   :: Decoration`

Constructors compliant with the IEEE Standard 1788-2015:
- [`interval`](@ref)
- [`..`](@ref)
- [`±`](@ref)
- [`@I_str`](@ref)

See also: [`±`](@ref), [`..`](@ref) and [`@I_str`](@ref).
"""
struct Interval{T<:NumTypes} <: Real
    bareinterval :: BareInterval{T}
    decoration   :: Decoration

    global _unsafe_interval(bareinterval::BareInterval{T}, decoration::Decoration) where {T<:NumTypes} =
        new{T}(bareinterval, decoration)
end

bareinterval(x::Interval) = x.bareinterval
bareinterval(::Type{T}, x::Interval) where {T<:NumTypes} = bareinterval(T, bareinterval(x))
decoration(x::Interval) = x.decoration

Interval{T}(a::Union{BareInterval,Interval}, d::Decoration) where {T<:NumTypes} = interval(T, bareinterval(T, a), d)
Interval{T}(a::Union{BareInterval,Interval}) where {T<:NumTypes} = interval(T, bareinterval(T, a))
Interval(a::Union{BareInterval,Interval}, d::Decoration) = interval(bareinterval(a), d)
Interval(a::Union{BareInterval,Interval}) = interval(bareinterval(a))

#

function interval(::Type{T}, a, b, d::Decoration; format::Symbol = :standard) where {T<:NumTypes}
    format === :standard && return _interval_standard(T, a, b, d)
    format === :midpoint && return _interval_midpoint(T, a, b, d)
    return throw(ArgumentError("`format` must be `:standard` or `:midpoint`."))
end
interval(a, b, d::Decoration; format::Symbol = :standard) = interval(promote_numtype(numtype(a), numtype(b)), a, b, d; format = format)

function interval(::Type{T}, a, b; format::Symbol = :standard) where {T<:NumTypes}
    format === :standard && return _interval_standard(T, a, b)
    format === :midpoint && return _interval_midpoint(T, a, b)
    return throw(ArgumentError("`format` must be `:standard` or `:midpoint`."))
end
interval(a, b; format::Symbol = :standard) = interval(promote_numtype(numtype(a), numtype(b)), a, b; format = format)

function interval(::Type{T}, a, d::Decoration; format::Symbol = :standard) where {T<:NumTypes}
    ((format === :standard) | (format === :midpoint)) && return _interval_standard(T, a, a, d)
    return throw(ArgumentError("`format` must be `:standard` or `:midpoint`."))
end
function interval(::Type{T}, x::Union{BareInterval,Interval}, d::Decoration; format::Symbol = :standard) where {T<:NumTypes}
    ((format === :standard) | (format === :midpoint)) && return _unsafe_interval(bareinterval(T, x), min(decoration(x), d)) # assumes valid interval
    return throw(ArgumentError("`format` must be `:standard` or `:midpoint`."))
end
interval(a, d::Decoration; format::Symbol = :standard) = interval(promote_numtype(numtype(a), numtype(a)), a, d; format = format)

function interval(::Type{T}, a; format::Symbol = :standard) where {T<:NumTypes}
    ((format === :standard) | (format === :midpoint)) && return _interval_standard(T, a, a)
    return throw(ArgumentError("`format` must be `:standard` or `:midpoint`."))
end
function interval(::Type{T}, x::Union{BareInterval,Interval}; format::Symbol = :standard) where {T<:NumTypes}
    ((format === :standard) | (format === :midpoint)) && return _unsafe_interval(bareinterval(T, x), decoration(x)) # assumes valid interval
    return throw(ArgumentError("`format` must be `:standard` or `:midpoint`."))
end
interval(a; format::Symbol = :standard) = interval(promote_numtype(numtype(a), numtype(a)), a; format = format)

# some useful extra constructor
interval(::Type{T}, a::Tuple, d::Decoration; format::Symbol = :standard) where {T<:NumTypes} = interval(T, a..., d; format = format)
interval(a::Tuple, d::Decoration; format::Symbol = :standard) = interval(a..., d; format = format)
interval(::Type{T}, a::Tuple; format::Symbol = :standard) where {T<:NumTypes} = interval(T, a...; format = format)
interval(a::Tuple; format::Symbol = :standard) = interval(a...; format = format)

# standard format

function _interval_standard(::Type{T}, a, b, d::Decoration) where {T<:NumTypes}
    lo = inf(a)
    hi = sup(b)
    !is_valid_interval(lo, hi) && return nai(T)
    x = _unsafe_bareinterval(T, lo, hi)
    d = min(decoration(x), d)
    return _unsafe_interval(x, d)
end
function _interval_standard(::Type{T}, a, b) where {T<:NumTypes}
    lo = inf(a)
    hi = sup(b)
    !is_valid_interval(lo, hi) && return nai(T)
    x = _unsafe_bareinterval(T, lo, hi)
    d = decoration(x)
    return _unsafe_interval(x, d)
end

_interval_standard(::Type{T}, a::Complex, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_standard(T, real(a), real(b), d), _interval_standard(T, imag(a), imag(b), d))
_interval_standard(::Type{T}, a::Complex, b, d::Decoration) where {T<:NumTypes} =
    complex(_interval_standard(T, real(a), b, d), _interval_standard(T, imag(a), d))
_interval_standard(::Type{T}, a, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_standard(T, a, real(b), d), _interval_standard(T, imag(b), d))

_interval_standard(::Type{T}, a::Complex, b::Complex) where {T<:NumTypes} =
    complex(_interval_standard(T, real(a), real(b)), _interval_standard(T, imag(a), imag(b)))
_interval_standard(::Type{T}, a::Complex, b) where {T<:NumTypes} =
    complex(_interval_standard(T, real(a), b), _interval_standard(T, imag(a)))
_interval_standard(::Type{T}, a, b::Complex) where {T<:NumTypes} =
    complex(_interval_standard(T, a, real(b)), _interval_standard(T, imag(b)))

# midpoint constructors

function _interval_midpoint(::Type{T}, m, r, d::Decoration) where {T<:NumTypes}
    x = _interval_standard(T, m, m, d)
    return _interval_standard(T, inf(x - r), sup(x + r), d)
end
function _interval_midpoint(::Type{T}, m, r) where {T<:NumTypes}
    x = _interval_standard(T, m, m)
    return _interval_standard(T, inf(x - r), sup(x + r))
end

_interval_midpoint(::Type{T}, m::Complex, r, d::Decoration) where {T<:NumTypes} =
    complex(_interval_midpoint(T, real(m), r, d), _interval_midpoint(T, imag(m), r, d))
_interval_midpoint(::Type{T}, m::Complex, r) where {T<:NumTypes} =
    complex(_interval_midpoint(T, real(m), r), _interval_midpoint(T, imag(m), r))

function _interval_midpoint(::Type{T}, m, r::Complex{<:Interval}, d::Decoration) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m, r::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r))
end

function _interval_midpoint(::Type{T}, m, r::Complex, d::Decoration) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m, r::Complex) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r))
end

function _interval_midpoint(::Type{T}, m::Complex, r::Complex{<:Interval}, d::Decoration) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m::Complex, r::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r))
end

function _interval_midpoint(::Type{T}, m::Complex, r::Complex, d::Decoration) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m::Complex, r::Complex) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero."))
    return _interval_midpoint(T, m, real(r))
end

# promotion

Base.promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:NumTypes,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{Interval{T}}, ::Type{S}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{T}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

# need explicit signatures to avoid method ambiguities
for S ∈ (:Bool, :BigFloat)
    @eval begin
        Base.promote_rule(::Type{Interval{T}}, ::Type{$S}) where {T<:NumTypes} =
            Interval{promote_numtype(T, $S)}
        Base.promote_rule(::Type{$S}, ::Type{Interval{T}}) where {T<:NumTypes} =
            Interval{promote_numtype($S, T)}
    end
end
Base.promote_rule(::Type{Interval{T}}, ::Type{S}) where {T<:NumTypes,S<:AbstractIrrational} =
    Interval{promote_numtype(T, S)}
Base.promote_rule(::Type{T}, ::Type{Interval{S}}) where {T<:AbstractIrrational,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

# conversion

Base.convert(::Type{Interval{T}}, x::Interval) where {T<:NumTypes} = interval(T, x, decoration(x))

function Base.convert(::Type{Interval{T}}, x::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(x)) || return throw(DomainError(x, "imaginary part must be zero."))
    return interval(T, real(x), bad)
end

Base.convert(::Type{Interval{T}}, x::Real) where {T<:NumTypes} = interval(T, x, bad)

function Base.convert(::Type{Interval{T}}, x::Complex) where {T<:NumTypes}
    iszero(imag(x)) || return throw(DomainError(x, "imaginary part must be zero."))
    return interval(T, real(x), bad)
end
