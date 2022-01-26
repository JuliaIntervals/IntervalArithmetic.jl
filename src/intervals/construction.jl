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

@inline _normalisezero(a::Real) = ifelse(iszero(a) && signbit(a), copysign(a, 1), a)

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
struct Interval{T} <: Real
    lo::T
    hi::T

    function Interval{T}(a, b) where T
        new{T}(_normalisezero(T(a, RoundDown)), _normalisezero(T(b, RoundUp)))
    end

    function Interval{T}(a::T, b::T) where T
        a = _normalisezero(a)
        b = _normalisezero(b)
        new{T}(a, b)
    end
end

#= Outer constructors =#
Interval{T}(a) where T = Interval{T}(a, a)
Interval(a) = Interval(a, a)
Interval(a::Tuple) = Interval(a...)

Interval(a::T, b::S) where {T<:AbstractFloat, S} = Interval{promote_type(T, S)}(a, b)
Interval(a::T, b::S) where {T, S<:AbstractFloat} = Interval{promote_type(T, S)}(a, b)
Interval(a::T, b::S) where {T<:AbstractFloat, S<:AbstractFloat} = Interval{promote_type(T, S)}(a, b)
Interval(a::T, b::T) where {T<:AbstractFloat} = Interval{T}(a, b)

Interval(a::T, b::S) where {T, S} = Interval{promote_type(default_bound(), T, S)}(a, b)
Interval(a::T, b::T) where T = Interval{promote_type(default_bound(), T)}(a, b)

#= Irrational =#
# Single argument Irrational constructor are in IntervalArithmetic.jl
# as generated functions need to be define last.
Interval(a::Irrational, b::T) where {T<:AbstractFloat} = Interval{T}(T(a, RoundDown), b)
Interval(a::T, b::Irrational) where {T<:AbstractFloat} = Interval{T}(a, T(b, RoundUp))

function Interval(a::Irrational, b::Irrational)
    T = default_bound()
    return Interval{T}(a, b)
end

#= Interval =#
Interval{T}(x::Interval{T}) where T = x
Interval{T}(x::Interval) where T = Interval{T}(x.lo, x.hi)

#= Complex =#
Interval(x::Complex) = Interval(real(x)) + im*Interval(imag(x))

# These definitions have been put there because generated functions must be
# defined after all methods they use.
Interval(x::Irrational) = Interval{default_bound()}(x)

@generated function Interval{T}(x::Irrational) where T
    res = Interval{T}(x(), x())  # Precompute the interval
    return :(return $res)  # Set body of the function to return the precomputed result
end

"""
    interval(a, b)

Create an interval, checking whether [a, b] is a valid `Interval`
If so, then an `Interval(a, b)` object is returned;
if not, a warning is printed and the empty interval is returned.
"""
function interval(a::T, b::S) where {T<:Real, S<:Real}
    if !is_valid_interval(a, b)
        @warn "Invalid input, empty interval is returned"
        return emptyinterval(promote_type(T, S))
    end

    return Interval(a, b)
end

interval(a::Real) = interval(a, a)

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
..(a, b) = checked_interval(a, b)

"""
    a ± b

Create the interval `[a - b, a + b]`.

Despite using the center-radius notation for its creation, the interval is
still represented by its bounds internally.
"""
a ± b = checked_interval(-(a, b, RoundDown), +(a, b, RoundUp))
±(a::Interval, b) = Interval(-(a.lo, b, RoundDown), +(a.hi, b, RoundUp))

"""
    atomic(::Type{<:Interval}, x)

Construct the tightest interval of a given type that contains the value `x`.

If `x` is an `AbstractString`, the interval is created by calling `parse`.

If `x` is an `AbstractFloat`, the interval is widen to two eps to be sure
to contain the number that was typed in.

Otherwise it is the same as using the `Interval` constructor directly.
"""
atomic(::Type{F}, x) where {F<:Interval} = F(x)
atomic(::Type{F}, x::AbstractString) where {F<:Interval} = parse(F, x)

function atomic(::Type{F}, x::AbstractFloat) where {T, F<:Interval{T}}
    lo = T(x, RoundDown)
    hi = T(x, RoundUp)
    if x == lo
        lo = prevfloat(lo)
    end
    if x == hi
        hi = nextfloat(hi)
    end
    return Interval(lo, hi)
end

"""
    big53(x::Interval{Float64})

Create an equivalent `BigFloat` interval to a given `Float64` interval.
"""
function big53(a::Interval{Float64})
    return setprecision(BigFloat, 53) do  # precision of Float64
        return Interval{BigFloat}(a)
    end
end

"""
    big53(x::Float64)

Convert `x` to `BigFloat`.
"""
function big53(x::Float64)
    return setprecision(BigFloat, 53) do
        return BigFloat(x)
    end
end

float(x::Interval{T}) where T = atomic(Interval{float(T)}, x)
big(x::Interval) = atomic(Interval{BigFloat}, x)