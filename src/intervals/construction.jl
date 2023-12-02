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
not have decorations, is not a subtype of `Real` and errors on operations mixing
`BareInterval` and `Number`.

Fields:
- `lo :: T`
- `hi :: T`

Constructor compliant with the IEEE Standard 1788-2015: [`bareinterval`](@ref).

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

"""
    _unsafe_bareinterval(T<:NumTypes, lo, hi)

Internal constructor which assumes that `is_valid_interval(lo, hi) == true`.

!!! danger
    This constructor is **not** compliant with the IEEE Standard 1788-2015.
    Since misuse of this function can deeply corrupt code, its usage is
    **strongly discouraged** in favour of [`bareinterval`](@ref).
"""
_unsafe_bareinterval

_normalisezero(a) = ifelse(iszero(a), zero(a), a)
# used only to construct intervals
_inf(a::BareInterval) = a.lo
_sup(a::BareInterval) = a.hi
_inf(a::Real) = a
_sup(a::Real) = a
#

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
`true` then a `BareInterval{T}` is constructed, otherwise an empty interval is
returned.

!!! danger
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. `0.1`). In such cases, parse the
    string containing the desired value to ensure its tight enclosure.

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
    lo = _inf(a)
    hi = _sup(b)
    is_valid_interval(lo, hi) && return _unsafe_bareinterval(T, lo, hi)
    @warn "invalid interval, empty interval is returned"
    return emptyinterval(BareInterval{T})
end
bareinterval(a, b) = bareinterval(promote_numtype(numtype(a), numtype(b)), a, b)

bareinterval(::Type{T}, a) where {T<:NumTypes} = bareinterval(T, a, a)
bareinterval(a) = bareinterval(promote_numtype(numtype(a), numtype(a)), a)

bareinterval(::Type{T}, a::BareInterval) where {T<:NumTypes} =
    _unsafe_bareinterval(T, _inf(a), _sup(a)) # assumes valid interval

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





# decorations

"""
    Decoration

Enumeration constant for the types of interval decorations described in
Section 11.2 of the IEEE Standard 1788-2015:
- `com -> 4` (common): non-empty, continuous and bounded interval.
- `dac -> 3` (defined and continuous): non-empty and continuous interval.
- `def -> 2` (defined): non-empty interval.
- `trv -> 1` (trivial): meaningless interval.
- `ill -> 0` (ill-formed): not an interval (NaI).
"""
@enum Decoration begin
    ill = 0
    trv
    def
    dac
    com
end
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
together with a [`Decoration`](@ref).

Fields:
- `bareinterval :: BareInterval{T}`
- `decoration   :: Decoration`
- `isguaranteed :: Bool`

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
    isguaranteed :: Bool

    global _unsafe_interval(bareinterval::BareInterval{T}, decoration::Decoration, isguaranteed::Bool) where {T<:NumTypes} =
        new{T}(bareinterval, decoration, isguaranteed)
end

"""
    _unsafe_interval(bareinterval::BareInterval, decoration::Decoration, isguaranteed::Bool)

Internal constructor which assumes that `bareinterval` and its decoration
`decoration` are compliant with the IEEE Standard 1788-2015.

!!! danger
    This constructor is **not** compliant with the IEEE Standard 1788-2015.
    Since misuse of this function can deeply corrupt code, its usage is
    **strongly discouraged** in favour of [`interval`](@ref).
"""
_unsafe_interval

# used only to construct intervals
_inf(a::Interval) = a.bareinterval.lo
_sup(a::Interval) = a.bareinterval.hi
#

function bareinterval(x::Interval)
    decoration(x) == ill && @warn "interval part of NaI"
    return x.bareinterval
end
bareinterval(::Type{T}, x::Interval) where {T<:NumTypes} = bareinterval(T, bareinterval(x))
decoration(x::Interval) = x.decoration

"""
    isguaranteed(x::BareInterval)
    isguaranteed(x::Interval)
    isguaranteed(x::Complex{<:Interval})

Test whether the interval is not guaranteed to encompass all possible numerical
errors. This happens whenever an [`Interval`](@ref) is constructed using
`convert(::Type{<:Interval}, ::Real)`, which may occur implicitly when mixing
intervals and `Real` types.

Since conversion between `BareInterval` and `Number` is prohibited, this implies
that `isguaranteed(::BareInterval) == true`.

In the case of a complex interval `x`, this is semantically equivalent to
`isguaranteed(real(x)) & isguaranteed(imag(x))`.

# Examples

```jldoctest
julia> isguaranteed(bareinterval(1))
true

julia> isguaranteed(interval(1))
true

julia> isguaranteed(convert(Interval{Float64}, 1))
false

julia> isguaranteed(interval(1) + 0)
false
```
"""
isguaranteed(x::Interval) = x.isguaranteed
isguaranteed(::BareInterval) = true
isguaranteed(x::Complex{<:Interval}) = isguaranteed(real(x)) & isguaranteed(imag(x))

Interval{T}(x::Union{BareInterval,Interval}, d::Decoration) where {T<:NumTypes} = interval(T, bareinterval(T, x), d)
Interval{T}(x::Union{BareInterval,Interval}) where {T<:NumTypes} = interval(T, bareinterval(T, x))
Interval(x::Union{BareInterval,Interval}, d::Decoration) = interval(bareinterval(x), d)
Interval(x::Union{BareInterval,Interval}) = interval(bareinterval(x))

#

"""
    interval([T<:Union{Rational,AbstractFloat}=default_numtype()], a, b, [d::Decoration])

Create the interval ``[a, b]`` according to the IEEE Standard 1788-2015. The
validity of the interval is checked by [`is_valid_interval`](@ref): if `true`
then an `Interval{T}` is constructed, otherwise an NaI (Not an Interval) is
returned.

!!! danger
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. `0.1`). In such cases, parse the
    string containing the desired value to ensure its tight enclosure.

See also: [`±`](@ref), [`..`](@ref) and [`@I_str`](@ref).

# Examples

```jldoctest
julia> setdisplay(:full);

julia> interval(1//1, π)
Interval{Rational{Int64}}(1//1, 85563208//27235615, com)

julia> interval(Rational{Int32}, 1//1, π)
Interval{Rational{Int32}}(1//1, 85563208//27235615, com)

julia> interval(1, π)
Interval{Float64}(1.0, 3.1415926535897936, com)

julia> interval(BigFloat, 1, π)
Interval{BigFloat}(1.0, 3.141592653589793238462643383279502884197169399375105820974944592307816406286233, com)
```
"""
function interval(::Type{T}, a, b, d::Decoration; format::Symbol = :infsup) where {T<:NumTypes}
    format === :infsup && return _interval_infsup(T, a, b, d)
    format === :midpoint && return _interval_midpoint(T, a, b, d)
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
interval(a, b, d::Decoration; format::Symbol = :infsup) = interval(promote_numtype(numtype(a), numtype(b)), a, b, d; format = format)

function interval(::Type{T}, a, b; format::Symbol = :infsup) where {T<:NumTypes}
    format === :infsup && return _interval_infsup(T, a, b)
    format === :midpoint && return _interval_midpoint(T, a, b)
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
interval(a, b; format::Symbol = :infsup) = interval(promote_numtype(numtype(a), numtype(b)), a, b; format = format)

function interval(::Type{T}, a, d::Decoration; format::Symbol = :infsup) where {T<:NumTypes}
    (format === :infsup) | (format === :midpoint) && return _interval_infsup(T, a, a, d)
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
function interval(::Type{T}, x::BareInterval, d::Decoration; format::Symbol = :infsup) where {T<:NumTypes}
    if d == ill
        @warn "invalid interval, NaI is returned"
        return nai(T)
    else
        (format === :infsup) | (format === :midpoint) && return _unsafe_interval(bareinterval(T, x), min(decoration(x), d), isguaranteed(x)) # assumes valid interval
        return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
    end
end
function interval(::Type{T}, x::Interval, d::Decoration; format::Symbol = :infsup) where {T<:NumTypes}
    if d == ill
        @warn "invalid interval, NaI is returned"
        return nai(T)
    else
        # use `x.bareinterval` to not print a warning if `x` is an NaI
        (format === :infsup) | (format === :midpoint) && return _unsafe_interval(bareinterval(T, x.bareinterval), min(decoration(x), d), isguaranteed(x)) # assumes valid interval
        return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
    end
end
interval(a, d::Decoration; format::Symbol = :infsup) = interval(promote_numtype(numtype(a), numtype(a)), a, d; format = format)

function interval(::Type{T}, a; format::Symbol = :infsup) where {T<:NumTypes}
    (format === :infsup) | (format === :midpoint) && return _interval_infsup(T, a, a)
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
function interval(::Type{T}, x::BareInterval; format::Symbol = :infsup) where {T<:NumTypes}
    (format === :infsup) | (format === :midpoint) && return _unsafe_interval(bareinterval(T, x), decoration(x), isguaranteed(x)) # assumes valid interval
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
function interval(::Type{T}, x::Interval; format::Symbol = :infsup) where {T<:NumTypes}
    # use `x.bareinterval` to not print warning if `x` is an NaI
    (format === :infsup) | (format === :midpoint) && return _unsafe_interval(bareinterval(T, x.bareinterval), decoration(x), isguaranteed(x)) # assumes valid interval
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
interval(a; format::Symbol = :infsup) = interval(promote_numtype(numtype(a), numtype(a)), a; format = format)

# some useful extra constructor
interval(::Type{T}, a::Tuple, d::Decoration; format::Symbol = :infsup) where {T<:NumTypes} = interval(T, a..., d; format = format)
interval(a::Tuple, d::Decoration; format::Symbol = :infsup) = interval(a..., d; format = format)
interval(::Type{T}, a::Tuple; format::Symbol = :infsup) where {T<:NumTypes} = interval(T, a...; format = format)
interval(a::Tuple; format::Symbol = :infsup) = interval(a...; format = format)
interval(A::AbstractArray; format::Symbol = :infsup) = interval.(A; format = format)

# standard format

"""
    _interval_infsup(T<:NumTypes, a, b, [d::Decoration])

Internal constructor for intervals described by their lower and upper bounds,
i.e. of the form ``[a, b]``.
"""
function _interval_infsup(::Type{T}, a, b, d::Decoration) where {T<:NumTypes}
    lo = _inf(a)
    hi = _sup(b)
    if !is_valid_interval(lo, hi) || d == ill
        @warn "invalid interval, NaI is returned"
        return nai(T)
    else
        x = _unsafe_bareinterval(T, lo, hi)
        return _unsafe_interval(x, min(decoration(x), d), true)
    end
end
function _interval_infsup(::Type{T}, a, b) where {T<:NumTypes}
    lo = _inf(a)
    hi = _sup(b)
    if !is_valid_interval(lo, hi)
        @warn "invalid interval, NaI is returned"
        return nai(T)
    else
        x = _unsafe_bareinterval(T, lo, hi)
        return _unsafe_interval(x, decoration(x), true)
    end
end

_interval_infsup(::Type{T}, a::Complex, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b), d), _interval_infsup(T, imag(a), imag(b), d))
_interval_infsup(::Type{T}, a::Complex, b, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), b, d), _interval_infsup(T, imag(a), d))
_interval_infsup(::Type{T}, a, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, a, real(b), d), _interval_infsup(T, imag(b), d))

_interval_infsup(::Type{T}, a::Complex, b::Complex) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b)), _interval_infsup(T, imag(a), imag(b)))
_interval_infsup(::Type{T}, a::Complex, b) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), b), _interval_infsup(T, imag(a)))
_interval_infsup(::Type{T}, a, b::Complex) where {T<:NumTypes} =
    complex(_interval_infsup(T, a, real(b)), _interval_infsup(T, imag(b)))

# midpoint constructors

"""
    _interval_midpoint(T<:NumTypes, m, r, [d::Decoration])

Internal constructor for intervals described by their midpoint and radius,
i.e. of the form ``m \\pm r`.
"""
function _interval_midpoint(::Type{T}, m, r, d::Decoration) where {T<:NumTypes}
    x = _interval_infsup(T, m, m, d)
    return _interval_infsup(T, _inf(x - r), _sup(x + r), d)
end
function _interval_midpoint(::Type{T}, m, r) where {T<:NumTypes}
    x = _interval_infsup(T, m, m)
    return _interval_infsup(T, _inf(x - r), _sup(x + r))
end

_interval_midpoint(::Type{T}, m::Complex, r, d::Decoration) where {T<:NumTypes} =
    complex(_interval_midpoint(T, real(m), r, d), _interval_midpoint(T, imag(m), r, d))
_interval_midpoint(::Type{T}, m::Complex, r) where {T<:NumTypes} =
    complex(_interval_midpoint(T, real(m), r), _interval_midpoint(T, imag(m), r))

function _interval_midpoint(::Type{T}, m, r::Complex{<:Interval}, d::Decoration) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m, r::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r))
end

function _interval_midpoint(::Type{T}, m, r::Complex, d::Decoration) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m, r::Complex) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r))
end

function _interval_midpoint(::Type{T}, m::Complex, r::Complex{<:Interval}, d::Decoration) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m::Complex, r::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r))
end

function _interval_midpoint(::Type{T}, m::Complex, r::Complex, d::Decoration) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end
function _interval_midpoint(::Type{T}, m::Complex, r::Complex) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
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

Base.convert(::Type{Interval{T}}, x::Interval) where {T<:NumTypes} = interval(T, x)

function Base.convert(::Type{Interval{T}}, x::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(x)) || return throw(DomainError(x, "imaginary part must be zero"))
    return convert(Interval{T}, real(x))
end

function Base.convert(::Type{Interval{T}}, x::Real) where {T<:NumTypes}
    y = interval(T, x)
    return _unsafe_interval(bareinterval(y), decoration(y), false)
end

function Base.convert(::Type{Interval{T}}, x::Complex) where {T<:NumTypes}
    iszero(imag(x)) || return throw(DomainError(x, "imaginary part must be zero"))
    return convert(Interval{T}, real(x))
end
