# bound type mechanism

"""
    NumTypes

Constant for the supported types of interval bounds. This is set to
`Union{Rational,AbstractFloat}`.
"""
const NumTypes = Union{Rational,AbstractFloat}

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
_unsafe_bareinterval(::Type{T}, a, b) where {T<:NumTypes} =
    _unsafe_bareinterval(T, _round(T, a, RoundDown), _round(T, b, RoundUp))

_normalisezero(a) = ifelse(iszero(a), zero(a), a)
# used only to construct intervals; needed to avoid `inf` and `sup` normalization
_inf(x::BareInterval) = x.lo
_sup(x::BareInterval) = x.hi
_inf(x::Real) = x
_sup(x::Real) = x
#

_round(::Type{T}, a, r::RoundingMode) where {T<:NumTypes} = __round(T, a, r)
# irrationals
_round(::Type{<:NumTypes}, ::AbstractIrrational, ::RoundingMode) = throw(ArgumentError("only irrationals from MathConstants are supported"))
for irr ∈ (:(:π), :(:γ), :(:catalan)) # irrationals supported by MPFR
    @eval _round(::Type{T}, a::Irrational{$irr}, r::RoundingMode) where {T<:NumTypes} =
        __round(T, BigFloat(a, r), r)
end
# irrationals not supported by MPFR, use their exact formula ℯ = exp(1), φ = (1+sqrt(5))/2
_round(::Type{T}, ::Irrational{:ℯ}, r::RoundingMode{:Down}) where {T<:NumTypes} =
    __round(T, inf(exp(bareinterval(BigFloat, 1))), r)
_round(::Type{T}, ::Irrational{:ℯ}, r::RoundingMode{:Up}) where {T<:NumTypes} =
    __round(T, sup(exp(bareinterval(BigFloat, 1))), r)
_round(::Type{T}, ::Irrational{:φ}, r::RoundingMode{:Down}) where {T<:NumTypes} =
    __round(T, inf((bareinterval(BigFloat, 1) + sqrt(bareinterval(BigFloat, 5))) / bareinterval(BigFloat, 2)), r)
_round(::Type{T}, ::Irrational{:φ}, r::RoundingMode{:Up}) where {T<:NumTypes} =
    __round(T, sup((bareinterval(BigFloat, 1) + sqrt(bareinterval(BigFloat, 5))) / bareinterval(BigFloat, 2)), r)
# floats
__round(::Type{T}, a, r::RoundingMode) where {T<:AbstractFloat} = T(a, r)
# rationals
__round(::Type{T}, a::Rational, ::RoundingMode{:Down}) where {S<:Integer,T<:Rational{S}} = T(a)
__round(::Type{T}, a::Rational, ::RoundingMode{:Up}) where {S<:Integer,T<:Rational{S}} = T(a)
__round(::Type{T}, a, r::RoundingMode{:Down}) where {S<:Integer,T<:Rational{S}} =
    rationalize(S, prevfloat(__float(S)(a, r)))
__round(::Type{T}, a, r::RoundingMode{:Up}) where {S<:Integer,T<:Rational{S}} =
    rationalize(S, nextfloat(__float(S)(a, r)))
# need the following since `float(Int8) == float(Int16) == Float64`
__float(::Type{T}) where {T<:Integer} = float(T)
__float(::Type{T}) where {T<:Union{Int8,UInt8}} = Float16
__float(::Type{T}) where {T<:Union{Int16,UInt16}} = Float32

BareInterval{T}(x::BareInterval) where {T<:NumTypes} = convert(BareInterval{T}, x)

"""
    bareinterval(T, a, b)

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
julia> using IntervalArithmetic

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
function bareinterval(::Type{T}, a, b) where {T}
    lo = _inf(_value(a))
    hi = _sup(_value(b))
    is_valid_interval(lo, hi) && return _unsafe_bareinterval(T, lo, hi)
    @warn "ill-formed bare interval [a, b] with a = $a, b = $b. Empty interval is returned"
    return emptyinterval(BareInterval{T})
end
bareinterval(a, b) = bareinterval(promote_numtype(numtype(a), numtype(b)), a, b)

bareinterval(::Type{T}, a) where {T} = bareinterval(T, a, a)
bareinterval(a) = bareinterval(promote_numtype(numtype(a), numtype(a)), a)

bareinterval(::Type{T}, a::BareInterval) where {T} =
    _unsafe_bareinterval(T, _inf(a), _sup(a)) # assumes valid interval

_value(a) = a # convenient hook, used in exact_literals.jl

# some useful extra constructor
bareinterval(::Type{T}, a::Tuple) where {T} = bareinterval(T, a...)
bareinterval(a::Tuple) = bareinterval(a...)

# promotion

Base.promote_rule(::Type{BareInterval{T}}, ::Type{BareInterval{S}}) where {T<:NumTypes,S<:NumTypes} =
    BareInterval{promote_numtype(T, S)}

# conversion

Base.convert(::Type{BareInterval{T}}, x::BareInterval) where {T<:NumTypes} =
    bareinterval(T, x)





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
_inf(x::Interval) = x.bareinterval.lo
_sup(x::Interval) = x.bareinterval.hi
#

function bareinterval(x::Interval)
    decoration(x) == ill && @warn "interval part of NaI"
    return x.bareinterval
end
bareinterval(::Type{T}, x::Interval) where {T} = bareinterval(T, bareinterval(x))
decoration(x::Interval) = x.decoration
decoration(x::Complex{<:Interval}) = min(decoration(real(x)), decoration(imag(x)))

"""
    setdecoration(x::Interval, d::Decoration)

Return the interval `bareinterval(x)` with decoration `d`, with the following
exceptions:
- if `d == ill`, then the output is an NaI
- if `isempty_interval(bareinterval(x))` and `d != ill`, then the output has
decoration `trv`
- if `isunbounded(bareinterval(x))` and `d == com`, then the output has
decoration `dac`

!!! danger
    Since misuse of this function can deeply corrupt code, its usage is
    **strongly discouraged**.

Implement the `setDec` function of the IEEE Standard 1788-2015 (Section 11.5.2).
"""
function setdecoration(x::Interval{T}, d::Decoration) where {T<:NumTypes}
    d == ill && return nai(T)
    bx = bareinterval(x)
    isempty_interval(bx) && return _unsafe_interval(bx, trv, isguaranteed(x))
    (isunbounded(bx) & (d == com)) && return _unsafe_interval(bx, dac, isguaranteed(x))
    return _unsafe_interval(bx, d, isguaranteed(x))
end

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
julia> using IntervalArithmetic

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

isguaranteed(::Number) = false

#

"""
    interval([T,] a, b, d = com; format = :infsup)

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
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> interval(1//1, π)
Interval{Rational{Int64}}(1//1, 85563208//27235615, com, true)

julia> interval(Rational{Int32}, 1//1, π)
Interval{Rational{Int32}}(1//1, 85563208//27235615, com, true)

julia> interval(1, π)
Interval{Float64}(1.0, 3.1415926535897936, com, true)

julia> interval(BigFloat, 1, π)
Interval{BigFloat}(1.0, 3.141592653589793238462643383279502884197169399375105820974944592307816406286233, com, true)
```
"""
function interval(::Type{T}, a, b, d::Decoration = com; format::Symbol = :infsup) where {T}
    format === :infsup && return _interval_infsup(T, _value(a), _value(b), d)
    format === :midpoint && return _interval_midpoint(T, _value(a), _value(b), d)
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
interval(a, b, d::Decoration = com; format::Symbol = :infsup) = interval(promote_numtype(_infer_numtype(a), _infer_numtype(b)), a, b, d; format = format)

function interval(::Type{T}, a, d::Decoration = com; format::Symbol = :infsup) where {T}
    (format === :infsup) | (format === :midpoint) && return _interval_infsup(T, _value(a), _value(a), d)
    return throw(ArgumentError("`format` must be `:infsup` or `:midpoint`"))
end
interval(a, d::Decoration = com; format::Symbol = :infsup) = interval(promote_numtype(_infer_numtype(a), _infer_numtype(a)), a, d; format = format)

interval(T::Type, d::Decoration; format::Symbol = :infsup) = throw(MethodError(interval, (T, d))) # needed to resolve ambiguity

_infer_numtype(a) = numtype(a)

# standard format

"""
    _interval_infsup(T<:NumTypes, a, b, d::Decoration)

Internal constructor for intervals described by their lower and upper bounds,
i.e. of the form ``[a, b]``.
"""
function _interval_infsup(::Type{T}, a, b, d::Decoration) where {T<:NumTypes}
    lo = _inf(a)
    hi = _sup(b)
    if !is_valid_interval(lo, hi) || d == ill
        @warn "ill-formed interval [a, b] with a = $a, b = $b and decoration d = $d. NaI is returned"
        return nai(T)
    else
        x = _unsafe_bareinterval(T, lo, hi)
        return _unsafe_interval(x, min(decoration(x), d), true)
    end
end

# needed for special warnings and propagation of `isguaranteed`
function _interval_infsup(::Type{T}, x::Union{BareInterval,Interval}, y::Union{BareInterval,Interval}, d::Decoration) where {T<:NumTypes}
    lo = _inf(x)
    hi = _sup(y)
    t = isguaranteed(x) & isguaranteed(y)
    if d == ill
        @warn "invalid interval, NaI is returned"
        return _unsafe_interval(nai(T).bareinterval, ill, t)
    elseif isempty_interval(x) && isempty_interval(y)
        return _unsafe_interval(emptyinterval(BareInterval{T}), trv, t)
    elseif !is_valid_interval(lo, hi)
        @warn "invalid interval, NaI is returned"
        return _unsafe_interval(nai(T).bareinterval, ill, t)
    else
        z = _unsafe_bareinterval(T, lo, hi)
        return _unsafe_interval(z, min(decoration(x), decoration(y), decoration(z), d), t)
    end
end
function _interval_infsup(::Type{T}, x::Union{BareInterval,Interval}, y, d::Decoration) where {T<:NumTypes}
    lo = _inf(x)
    hi = _sup(y)
    if !is_valid_interval(lo, hi) || d == ill
        @warn "invalid interval, NaI is returned"
        return nai(T)
    else
        z = _unsafe_bareinterval(T, lo, hi)
        return _unsafe_interval(z, min(decoration(x), decoration(z), d), isguaranteed(x))
    end
end
function _interval_infsup(::Type{T}, x, y::Union{BareInterval,Interval}, d::Decoration) where {T<:NumTypes}
    lo = _inf(x)
    hi = _sup(y)
    if !is_valid_interval(lo, hi) || d == ill
        @warn "invalid interval, NaI is returned"
        return nai(T)
    else
        z = _unsafe_bareinterval(T, lo, hi)
        return _unsafe_interval(z, min(decoration(y), decoration(z), d), isguaranteed(y))
    end
end

_interval_infsup(::Type{T}, a::Complex, b::Union{BareInterval,Interval}, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b), d), _interval_infsup(T, imag(a), imag(b), d))
_interval_infsup(::Type{T}, a::Union{BareInterval,Interval}, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b), d), _interval_infsup(T, imag(a), imag(b), d))

_interval_infsup(::Type{T}, a::Complex, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b), d), _interval_infsup(T, imag(a), imag(b), d))
_interval_infsup(::Type{T}, a::Complex, b, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b), d), _interval_infsup(T, imag(a), imag(b), d))
_interval_infsup(::Type{T}, a, b::Complex, d::Decoration) where {T<:NumTypes} =
    complex(_interval_infsup(T, real(a), real(b), d), _interval_infsup(T, imag(a), imag(b), d))

# some useful extra constructor

_infer_numtype(A::AbstractArray) = numtype(eltype(A))

_interval_infsup(::Type{T}, A::AbstractArray, B::AbstractArray, d::Decoration) where {T<:NumTypes} = _interval_infsup.(T, A, B, d)

# midpoint constructors

"""
    _interval_midpoint(T<:NumTypes, m, r, d::Decoration)

Internal constructor for intervals described by their midpoint and radius, i.e.
of the form ``m \\pm r``.
"""
function _interval_midpoint(::Type{T}, m, r, d::Decoration) where {T<:NumTypes}
    x = _interval_infsup(T, m, m, d)
    r = _interval_infsup(T, r, r, d)
    precedes(zero(r), r) && return _interval_infsup(T, x - r, x + r, d)
    return throw(DomainError(r, "must be positive"))
end

_interval_midpoint(::Type{T}, m::Complex, r, d::Decoration) where {T<:NumTypes} =
    complex(_interval_midpoint(T, real(m), r, d), _interval_midpoint(T, imag(m), r, d))

function _interval_midpoint(::Type{T}, m, r::Complex{<:Interval}, d::Decoration) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end

function _interval_midpoint(::Type{T}, m, r::Complex, d::Decoration) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end

function _interval_midpoint(::Type{T}, m::Complex, r::Complex{<:Interval}, d::Decoration) where {T<:NumTypes}
    isthinzero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
end

function _interval_midpoint(::Type{T}, m::Complex, r::Complex, d::Decoration) where {T<:NumTypes}
    iszero(imag(r)) || return throw(DomainError(r, "imaginary part must be zero"))
    return _interval_midpoint(T, m, real(r), d)
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

Interval{T}(x::Real) where {T<:NumTypes} = convert(Interval{T}, x)
Interval(x::Real) = Interval{promote_numtype(numtype(x), numtype(x))}(x)
Interval{T}(x::Interval) where {T<:NumTypes} = convert(Interval{T}, x) # needed to resolve method ambiguity

Base.convert(::Type{Interval{T}}, x::Interval) where {T<:NumTypes} = interval(T, x)

function Base.convert(::Type{Interval{T}}, x::Complex{<:Interval}) where {T<:NumTypes}
    isthinzero(imag(x)) || return throw(DomainError(x, "imaginary part must be zero"))
    return convert(Interval{T}, real(x))
end

Base.convert(::Type{Complex{Interval{T}}}, x::Interval) where {T<:NumTypes} =
    complex(interval(T, x))

# always guaranteed since an `AbstractIrrational` is a defined fixed constant
Base.convert(::Type{Interval{T}}, x::AbstractIrrational) where {T<:NumTypes} =
    interval(T, x)
Base.convert(::Type{Complex{Interval{T}}}, x::AbstractIrrational) where {T<:NumTypes} =
    complex(interval(T, x))

function Base.convert(::Type{Interval{T}}, x::Real) where {T<:NumTypes}
    y = interval(T, x)
    return _unsafe_interval(bareinterval(y), decoration(y), false)
end

function Base.convert(::Type{Interval{T}}, x::Complex) where {T<:NumTypes}
    iszero(imag(x)) || return throw(DomainError(x, "imaginary part must be zero"))
    return convert(Interval{T}, real(x))
end

"""
    atomic(T<:Union{Rational,AbstractFloat}, x)

Create an interval according to the IEEE Standard 1788-2015. The returned
`Interval{T}` always contains the value `x`; this is semantically equivalent
to `parse(Interval{T}, string(x))` if `x` is a `Number`.

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> x = IntervalArithmetic.atomic(Float64, 0.1)
Interval{Float64}(0.09999999999999999, 0.1, com, true)

julia> in_interval(1//10, IntervalArithmetic.atomic(Float64, 0.1))
true

julia> IntervalArithmetic.atomic(Float64, 0.3)
Interval{Float64}(0.3, 0.30000000000000004, com, true)

julia> in_interval(3//10, IntervalArithmetic.atomic(Float64, 0.3))
true
```
"""
atomic(::Type{T}, x::AbstractString) where {T<:NumTypes} = parse(Interval{T}, x)
atomic(::Type{T}, x::Interval) where {T<:NumTypes} = interval(T, x)
atomic(::Type{T}, x::Integer) where {T<:NumTypes} = interval(T, x)
atomic(::Type{T}, x::AbstractIrrational) where {T<:NumTypes} = interval(T, x)
function atomic(::Type{T}, x::Number) where {T<:NumTypes}
    str = string(x)
    return interval(T, _parse_num(T, str, RoundDown), _parse_num(T, str, RoundUp))
end
atomic(x) = atomic(default_numtype(), x)





# macro

"""
    @interval([T], expr)
    @interval([T], expr1, expr2)

Walk through an expression and wrap each argument of functions with the internal
constructor [`atomic`](@ref).

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> @interval sin(1) # Float64 is the default bound type
Interval{Float64}(0.8414709848078965, 0.8414709848078966, com, true)

julia> @interval Float32 sin(1)
Interval{Float32}(0.84147096f0, 0.841471f0, com, true)

julia> @interval Float64 sin(1) exp(1)
Interval{Float64}(0.8414709848078965, 2.7182818284590455, com, true)
```
"""
macro interval(expr)
    return _wrap_interval(expr)
end

macro interval(expr1, expr2)
    x = _wrap_interval(expr1)
    y = _wrap_interval(expr1, expr2)
    return :(interval($x, $y))
end

macro interval(T, expr1, expr2)
    x = _wrap_interval(T, expr1)
    y = _wrap_interval(T, expr2)
    return :(interval($x, $y))
end

_atomic(x, y) = hull(atomic(x), atomic(y); dec = :auto) # use `hull` in case `atomic(x)` is larger than `atomic(y)`
_atomic(T::Type, x) = atomic(T, x)
_atomic(::Type, T::Type) = T

_wrap_interval(x) = _wrap_interval(default_numtype(), x)

_wrap_interval(T, x) = :(_atomic($(esc(T)), $x))

_wrap_interval(T, x::Symbol) = :(_atomic($(esc(T)), $(esc(x))))

function _wrap_interval(T, expr::Expr)
    if expr.head ∈ (:(.), :ref, :macrocall) # a.i, or a[i], or BigInt
        return :(_atomic($(esc(T)), $(esc(expr))))
    end

    new_expr = copy(expr)

    first = 1 # where to start processing arguments

    if expr.head === :call
        first = 2 # skip operator
        if expr.args[1] ∉ (:+, :-, :*, :/, :^)
            new_expr.args[1] = :($(esc(expr.args[1]))) # escape functions
        end
    end

    for (i, arg) ∈ enumerate(expr.args)
        if i ≥ first
            new_expr.args[i] = _wrap_interval(T, arg)
        end
    end

    return new_expr
end
