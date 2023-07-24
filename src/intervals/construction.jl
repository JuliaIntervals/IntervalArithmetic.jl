# allowed bound types for an interval
const NumTypes = Union{Rational,AbstractFloat}

"""
    Interval{T<:NumTypes} <: Real

Interval type for guaranteed computation with interval arithmetic according to
the IEEE Standard 1788-2015.

Fields:
- `lo::T`
- `hi::T`

Constructors compliant with the IEEE Standard 1788-2015:
- [`interval`](@ref)
- [`..`](@ref)
- [`±`](@ref)
- [`@I_str`](@ref)

!!! warning
    The internal constructor `unsafe_interval` is *not* compliant with the
    IEEE Standard 1788-2015.

See also: [`interval`](@ref), [`±`](@ref), [`..`](@ref) and [`@I_str`](@ref).
"""
struct Interval{T<:NumTypes} <: Real
    lo::T
    hi::T

    # need explicit signatures to avoid method ambiguities

    global unsafe_interval(::Type{T}, a::T, b::T) where {S<:Integer,T<:Rational{S}} =
        new{T}(_normalisezero(a), _normalisezero(b))

    unsafe_interval(::Type{T}, a::T, b::T) where {T<:AbstractFloat} =
        new{T}(_normalisezero(a), _normalisezero(b))
end

_normalisezero(a) = ifelse(iszero(a), zero(a), a) # required by the IEEE Standard 1788-2015

Interval{T}(x::Interval) where {T<:NumTypes} = interval(T, inf(x), sup(x))

unsafe_interval(::Type{T}, a::Rational, b::Rational) where {S<:Integer,T<:Rational{S}} =
    unsafe_interval(T, T(a), T(b))
unsafe_interval(::Type{T}, a::Rational, b) where {S<:Integer,T<:Rational{S}} =
    unsafe_interval(T, T(a), rationalize(S, nextfloat(float(S)(b, RoundUp))))
unsafe_interval(::Type{T}, a, b::Rational) where {S<:Integer,T<:Rational{S}} =
    unsafe_interval(T, rationalize(S, nextfloat(float(S)(a, RoundDown))), T(b))
function unsafe_interval(::Type{T}, a, b) where {S<:Integer,T<:Rational{S}}
    R = float(S)
    return unsafe_interval(T, rationalize(S, prevfloat(R(a, RoundDown))), rationalize(S, nextfloat(R(b, RoundUp))))
end

unsafe_interval(::Type{T}, a, b) where {T<:AbstractFloat} = unsafe_interval(T, T(a, RoundDown), T(b, RoundUp))

# bound type mechanism

"""
    default_numtype()

Return the default bound type used in [`promote_numtype`](@ref). By default,
`default_numtype()` is set to `Float64`. It can be modified by redefining the
function, however it should be set to a concrete subtype of `Rational` or
`AbstractFloat`.

# Examples
```jldoctest
julia> IntervalArithmetic.default_numtype()
Float64

julia> typeof(interval(1, 2))
Interval{Float64}

julia> typeof(interval(1, big(2)))
Interval{BigFloat}

julia> IntervalArithmetic.default_numtype() = Float32

julia> typeof(interval(1, 2))
Interval{Float32}

julia> typeof(interval(1, big(2)))
Interval{BigFloat}
```
"""
default_numtype() = Float64

"""
    promote_numtype(T, S)

Return the bound type used to construct intervals. The bound type is given by
`promote_type(T, S)` if `T` or `S` is a `Rational` or an `AbstractFloat`;
except when `T` is a `Rational{R}` and `S` is an `AbstractIrrational`
(or vice-versa), in which case the bound type is given by
`Rational{promote_type(R, Int64)}`. In all other cases, the bound type is given
by `promote_type(default_numtype(), T, S)`.
"""
promote_numtype(::Type{T}, ::Type{S}) where {T<:NumTypes,S<:NumTypes} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T<:NumTypes,S} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T,S<:NumTypes} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T,S} = promote_type(default_numtype(), T, S)
promote_numtype(::Type{Rational{T}}, ::Type{<:AbstractIrrational}) where {T<:Integer} = Rational{promote_type(T, Int64)}
promote_numtype(::Type{<:AbstractIrrational}, ::Type{Rational{T}}) where {T<:Integer} = Rational{promote_type(T, Int64)}

# promotion

Base.promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:NumTypes,S<:NumTypes} =
    Interval{promote_type(T, S)}

# constructors

"""
    interval([T<:Union{Rational,AbstractFloat}=default_numtype()], a, b)

Create the interval ``[a, b]`` according to the IEEE Standard 1788-2015. The
validity of the interval is checked by [`is_valid_interval`](@ref): if `true`
then an `Interval{T}` is constructed, otherwise a warning is printed and the
empty interval is returned.

!!! warning
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. 0.1). In such cases, use the string
    macro [`@I_str`](@ref) to ensure tight enclosure around the typed numbers.

See also: [`±`](@ref), [`..`](@ref) and [`@I_str`](@ref).

# Examples
```jldoctest
julia> setformat(:full);

julia> interval(1//1, π)
Interval{Rational{Int64}}(1//1, 85563208//27235615)

julia> interval(Rational{Int32}, 1//1, π)
Interval{Rational{Int32}}(1//1, 85563208//27235615)

julia> interval(1, π)
Interval{Float64}(1.0, 3.1415926535897936)

julia> interval(BigFloat, 1, π)
Interval{BigFloat}(1.0, 3.141592653589793238462643383279502884197169399375105820974944592307816406286233)
```
"""
function interval(::Type{T}, a, b) where {T<:NumTypes}
    lo = inf(a)
    hi = sup(b)
    is_valid_interval(T, lo, hi) && return unsafe_interval(T, lo, hi)
    @warn "invalid input, empty interval is returned"
    return emptyinterval(T)
end

interval(a, b) = interval(promote_numtype(numtype(a), numtype(b)), a, b)

# `is_valid_interval(a, a)` may not be true
interval(::Type{T}, a) where {T<:NumTypes} = interval(T, a, a)
interval(a) = interval(promote_numtype(numtype(a), numtype(a)), a)

# complex
interval(::Type{T}, a::Complex, b::Complex) where {T<:NumTypes} = complex(interval(T, real(a), real(b)), interval(T, imag(a), imag(b)))
interval(a::Complex, b::Complex) = complex(interval(real(a), real(b)), interval(imag(a), imag(b)))
interval(::Type{T}, a::Complex, b) where {T<:NumTypes} = complex(interval(T, real(a), b), interval(T, imag(a)))
interval(a::Complex, b) = complex(interval(real(a), b), interval(imag(a)))
interval(::Type{T}, a, b::Complex) where {T<:NumTypes} = complex(interval(T, a, real(b)), interval(T, imag(b)))
interval(a, b::Complex) = complex(interval(a, real(b)), interval(imag(b)))
interval(::Type{T}, a::Complex) where {T<:NumTypes} = complex(interval(T, real(a)), interval(T, imag(a)))
interval(a::Complex) = complex(interval(real(a)), interval(imag(a)))

# some useful extra constructor
interval(a::Tuple) = interval(a...)

# irrational
# by-pass the absence of `BigFloat(..., ROUNDING_MODE)` (cf. base/irrationals.jl)
# for some irrationals defined in MathConstants (cf. base/mathconstants.jl)
for sym ∈ (:(:ℯ), :(:φ))
    @eval begin
        unsafe_interval(::Type{BigFloat}, a::Irrational{:ℯ}, b::Irrational{$sym}) =
            unsafe_interval(BigFloat, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
        unsafe_interval(::Type{BigFloat}, a::Irrational{:φ}, b::Irrational{$sym}) =
            unsafe_interval(BigFloat, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
        unsafe_interval(::Type{BigFloat}, a::Irrational{$sym}, b) =
            unsafe_interval(BigFloat, BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(b, RoundUp))
        unsafe_interval(::Type{BigFloat}, a, b::Irrational{$sym}) =
            unsafe_interval(BigFloat, BigFloat(a, RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
    end
end
# the following function is put here because generated functions must be defined
# after all the methods they use
@generated function interval(::Type{T}, a::AbstractIrrational) where {T<:NumTypes}
    res = unsafe_interval(T, a(), a()) # precompute the interval
    return :($res) # set body of the function to return the precomputed result
end

"""
    ±(m, r)
    m ± r

Create the interval ``[m - r, m + r]`` according to the IEEE Standard 1788-2015.
Despite using the midpoint-radius notation, the returned interval is still an
`Interval` represented by its bounds.

!!! warning
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. 0.1). In such cases, use the string
    macro [`@I_str`](@ref) to ensure tight enclosure around the typed numbers.

See also: [`interval`](@ref), [`..`](@ref) and [`@I_str`](@ref).

# Examples
```jldoctest
julia> setformat(:full);

julia> 0 ± π
Interval{Float64}(-3.1415926535897936, 3.1415926535897936)

julia> 0//1 ± π
Interval{Rational{Int64}}(-85563208//27235615, 85563208//27235615)
```
"""
function ±(m, r)
    x = interval(m)
    return interval(inf(x - r), sup(x + r))
end
±(m::Complex, r) = complex(±(real(m), r), ±(imag(m), r))
±(::Any, r::Complex) = throw(DomainError(r, "± does not accept complex radius. Try ±(m, real(r))."))
±(::Complex, r::Complex) = throw(DomainError(r, "± does not accept complex radius. Try ±(m, real(r))."))

#

"""
    atomic(T<:Union{Rational,AbstractFloat}, a)

Create an interval according to the IEEE Standard 1788-2015. The returned
`Interval{T}` always contains the value `a` but its construction depends on its
type. If `a` is an `AbstractString`, then the interval is constructed by calling
[`parse`](@ref). If `a` is an `AbstractFloat`, the interval is widen to two eps
to be sure to contain the number that was typed in. In all other cases, this is
semantically equivalent to `interval(T, a)`.

# Examples
```jldoctest
julia> setformat(:full);

julia> IntervalArithmetic.atomic(Float64, 0.1)
Interval{Float64}(0.09999999999999999, 0.10000000000000002)

julia> IntervalArithmetic.atomic(Float64, 0.1)
Interval{Float64}(0.29999999999999993, 0.30000000000000004)
```
"""
atomic(::Type{T}, a) where {T<:NumTypes} = interval(T, a)

atomic(::Type{T}, a::AbstractString) where {T<:NumTypes} = parse(Interval{T}, a)

function atomic(::Type{T}, a::AbstractFloat) where {T<:AbstractFloat}
    lo = T(a, RoundDown)
    hi = T(a, RoundUp)
    if a == lo
        lo = prevfloat(lo)
    end
    if a == hi
        hi = nextfloat(hi)
    end
    return unsafe_interval(T, lo, hi)
end

# prevents multiple threads from calling setprecision() concurrently; it is used
# in `bigequiv`
const precision_lock = ReentrantLock()

"""
    bigequiv(x::Interval)
    bigequiv(x::Union{Rational,AbstractFloat})

Create a `BigFloat` equivalent with the same underlying precision as `x`.
"""
function bigequiv(x::Interval{T}) where {T<:NumTypes}
    lock(precision_lock) do
        setprecision(precision(float(T))) do
            return Interval{BigFloat}(x)
        end
    end
end

function bigequiv(x::T) where {T<:NumTypes}
    lock(precision_lock) do
        setprecision(precision(float(T))) do
            return BigFloat(x)
        end
    end
end
