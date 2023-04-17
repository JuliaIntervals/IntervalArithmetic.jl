"""
    IntervalArithmetic.default_bound()

Return the default bound for intervals.

Can be redefined to change the default behavior for constructors that do
not explicitly take the bound type as an argument, like `..`.

Intervals only support bounds that are `AbstractFloat`.

In general, what happens is that if none of the bounds is an `AbstractFloat`
they get promoted to the default bound.
Otherwise the constructors promote the two bounds to a common type and use
that one as bound type.

Example
=======
julia> IntervalArithmetic.default_bound()
Float64

julia> typeof(1..2)  # Both bounds are Int, so they get promoted to the default
Interval{Float64}

julia> typeof(1..2f0)  # One of the bound is Float32, so the bounds promote to it
Interval{Float32}

julia> IntervalArithmetic.default_bound() = Float32  # New default

julia> typeof(1..2)  # Both bounds are Int, so they get promoted to the default
Interval{Float32}

julia> typeof(1..2.0)  # One of the bound is Float64, so the bounds promote to it
Interval{Float64}
"""
default_bound() = Float64

const NumTypes = Union{Rational,AbstractFloat} # allowed types for the bounds of an interval

# Produce the type of the bounds of an interval when not explicitly imposed
promote_numtype(::Type{T}, ::Type{S}) where {T<:NumTypes,S<:NumTypes} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T<:NumTypes,S} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T,S<:NumTypes} = promote_type(T, S)
promote_numtype(::Type{T}, ::Type{S}) where {T,S} = promote_type(default_bound(), T, S)

@inline _normalisezero(a::Real) = ifelse(iszero(a), zero(a), a)

"""
    Interval

An interval for guaranteed computation.

For the most part, it can be used as a drop-in replacement for real numbers.

The computation is guaranteed in the sense that the image of the input
interval is guaranteed to lie inside the returned interval.

The validity of the interval is *not* tested by this bare constructor.
For a constructor that complies with the requirement of a constructor
according to the IEEE Std 1788-2015, use one of the other convenience
constructors:
- `checked_interval(a, b)` Explicitly checked interval.
- `a..b` Better looking alias of `checked_interval`.
- `m ± r` Midpoint radius representation.
- `@interval(expr)` Convenience macro replacing all number literal in `expr`
    by intervals.
- `I"desc"` Parse the string `"desc"` according to the standard, allowing
    more flexible syntax and guaranteeing that the typed decimal numbers
    are included in the interval even if they can not be represented as
    floating point numbers.
"""
struct Interval{T<:NumTypes} <: Real
    lo::T
    hi::T

    Interval{T}(a::T, b::T) where {S<:Integer,T<:Rational{S}} = new{T}(_normalisezero(a), _normalisezero(b))
    Interval{T}(a::T, b::T) where {T<:AbstractFloat} = new{T}(_normalisezero(a), _normalisezero(b))
end

function Interval{T}(a, b) where {S<:Integer,T<:Rational{S}}
    R = float(S)
    return Interval{T}(rationalize(S, prevfloat(R(a, RoundDown))), rationalize(S, nextfloat(R(b, RoundUp))))
end

Interval{T}(a, b) where {T<:AbstractFloat} = Interval{T}(T(a, RoundDown), T(b, RoundUp))

Interval{T}(x::Interval) where {T<:NumTypes} = Interval{T}(inf(x), sup(x))

# promotion

Base.promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:NumTypes,S<:NumTypes} =
    Interval{promote_type(T, S)}

"""
    interval(::Type{T}, a, b)

Create an interval, checking whether [a, b] is a valid `Interval`
If so, then an `Interval{T}(a, b)` object is returned;
if not, a warning is printed and the empty interval is returned.
"""
function interval(::Type{T}, a, b) where {T<:NumTypes}
    is_valid_interval(a, b) && return Interval{T}(a, b)
    @warn "Invalid input, empty interval is returned"
    return emptyinterval(T)
end
interval(a::T, b::S) where {T, S} = interval(promote_numtype(T, S), a, b)

# Real: `is_valid_interval(a, a) != true`
interval(::Type{T}, a::Real) where {T<:NumTypes} = interval(T, a, a)
interval(a) = interval(a, a)
# Prevent ambiguity error between `interval(a::T, b::S) where {T, S<:AbstractFloat}`
# and `interval(::Type{T}, a::Real) where {T}`
interval(::Type{T}, a::AbstractFloat) where {T<:NumTypes} = interval(T, a, a)

# Interval: check the validity of the interval
interval(::Type{T}, a::Interval) where {T<:NumTypes} = interval(T, inf(a), sup(a))
interval(a::Interval) = interval(inf(a), sup(a))

# Complex
interval(::Type{T}, a::Complex) where {T<:NumTypes} = complex(interval(T, real(a)), interval(T, imag(a)))
interval(a::Complex) = complex(interval(real(a)), interval(imag(a)))
interval(::Type{T}, a::Complex, b::Complex) where {T<:NumTypes} = complex(interval(T, real(a), real(b)), interval(T, imag(a), imag(b)))
interval(a::Complex, b::Complex) = complex(interval(real(a), real(b)), interval(imag(a), imag(b)))
interval(::Type{T}, a::Complex, b::Real) where {T<:NumTypes} = complex(interval(T, real(a), b), interval(T, imag(a)))
interval(a::Complex, b::Real) = complex(interval(real(a), b), interval(imag(a)))
interval(::Type{T}, a::Real, b::Complex) where {T<:NumTypes} = complex(interval(T, a, real(b)), interval(T, imag(b)))
interval(a::Real, b::Complex) = complex(interval(a, real(b)), interval(imag(b)))

# Irrational
# By-pass the absence of `BigFloat(..., ROUNDING_MODE)` (cf. base/irrationals.jl)
# for some irrationals defined in MathConstants (cf. base/mathconstants.jl)
for sym ∈ (:ℯ, :φ)
    Interval{BigFloat}(a::Irrational{sym}, b::Irrational{sym}) =
        Interval{BigFloat}(BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
    Interval{BigFloat}(a::Irrational{sym}, b) =
        Interval{BigFloat}(BigFloat(Float64(a, RoundDown), RoundDown), BigFloat(b, RoundUp))
    Interval{BigFloat}(a, b::Irrational{sym}) =
        Interval{BigFloat}(BigFloat(a, RoundDown), BigFloat(Float64(b, RoundUp), RoundUp))
end
# The following function is put here because generated functions must be defined
# after all the methods they use
@generated function interval(::Type{T}, a::Irrational) where {T<:NumTypes}
    res = Interval{T}(a(), a())  # Precompute the interval
    return :($res)  # Set body of the function to return the precomputed result
end
interval(a::Irrational) = interval(default_bound(), a)

# Some useful extra constructor
interval(a::Tuple) = interval(a...)

const checked_interval = interval

"""
    a..b
    ..(a, b)

Create the interval `[a, b]`.

Validity of the interval is checked, but nothing is done to compensate for
the fact that floating point literals are rounded to nearest when parsed.

Use the string macro `I"[a, b]"` to ensure tight enclosure around the number
that is typed in, even when it is not exactly representable as a floating point
number (like `0.1`).

Example
=======
julia> dump(0.1 .. 0.3)
Interval{Float64}
  lo: Float64 0.1
  hi: Float64 0.3

julia> dump(I"[0.1,0.3]"
  lo: Float64 0.09999999999999999
  hi: Float64 0.30000000000000004

julia> dump(0.2 ± 0.1)
Interval{Float64}
  lo: Float64 0.1
  hi: Float64 0.30000000000000004

julia> dump(±(I"[0.2]", 0.1))
Interval{Float64}
  lo: Float64 0.09999999999999998
  hi: Float64 0.30000000000000004
"""
const .. = interval

"""
    a ± b

Create the interval `[a - b, a + b]`.

Despite using the center-radius notation for its creation, the interval is
still represented by its bounds internally.
"""
±(a, b) = interval(-(a, b, RoundDown), +(a, b, RoundUp))
±(a::Interval, b) = interval(-(inf(a), b, RoundDown), +(sup(a), b, RoundUp))

"""
    atomic(::Type{<:Interval}, x)

Construct the tightest interval of a given type that contains the value `x`.

If `x` is an `AbstractString`, the interval is created by calling `parse`.

If `x` is an `AbstractFloat`, the interval is widen to two eps to be sure
to contain the number that was typed in.

Otherwise it is the same as using the `Interval` constructor directly.
"""
atomic(::Type{Interval{T}}, x) where {T<:NumTypes} = interval(T, x)
atomic(::Type{Interval{T}}, x::AbstractString) where {T<:NumTypes} = parse(Interval{T}, x)

atomic(::Type{Interval{T}}, x::AbstractFloat) where {T<:Rational} = Interval{T}(lo, hi)
function atomic(::Type{Interval{T}}, x::AbstractFloat) where {T<:AbstractFloat}
    lo = T(x, RoundDown)
    hi = T(x, RoundUp)
    if x == lo
        lo = prevfloat(lo)
    end
    if x == hi
        hi = nextfloat(hi)
    end
    return Interval{T}(lo, hi)
end

# NOTE: prevents multiple threads from calling setprecision() concurrently;
# it is used in `bigequiv`
const precision_lock = ReentrantLock()

"""
    bigequiv(x::Interval)

Create an equivalent `BigFloat` interval to a given interval.
"""
function bigequiv(a::Interval{T}) where {T<:NumTypes}
    lock(precision_lock) do
        setprecision(precision(float(T))) do  # precision of T
            return Interval{BigFloat}(a)
        end
    end
end

"""
    bigequiv(x::AbstractFloat)

Convert `x` to an equivalent `BigFloat`, with the same underlying precision of `x`.
"""
function bigequiv(x::AbstractFloat)
    lock(precision_lock) do
        setprecision(precision(x)) do
            return BigFloat(x)
        end
    end
end

float(x::Interval{T}) where {T<:NumTypes} = atomic(Interval{float(T)}, x)
big(x::Interval) = atomic(Interval{BigFloat}, x)
