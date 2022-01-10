# This file is part of the IntervalArithmetic.jl package; MIT licensed

# TODO Use that
# TODO DOcument it too
default_bound() = Float64

# TODO Better doc here
"""
    Interval

An interval for guaranteed computation.
"""
struct Interval{T} <: Real
    lo::T
    hi::T

    function Interval{T}(a, b) where T
        new{T}(T(a, RoundDown), T(b, RoundUp))
    end

    function Interval{T}(a::T, b::T) where T
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
    return Interval{T}(T(a, RoundDown), T(b, RoundUp))
end

#= Interval =#
Interval{T}(x::Interval{T}) where T = x
Interval{T}(x::Interval) where T = atomic(Interval{T}, x)

#= Complex =#
Interval(x::Complex) = Interval(real(x)) + im*Interval(imag(x))

"""
    numtype(x::Interval)

Returns the type of the bounds of the interval.

### Example

```julia
julia> numtype(1..2)
Float64
```
"""
numtype(::Interval{T}) where T = T

@inline _normalisezero(a::Real) = ifelse(iszero(a) && signbit(a), copysign(a, 1), a)

"""
    is_valid_interval(a::Real, b::Real)

Check if `(a, b)` constitute a valid interval.
"""
function is_valid_interval(a::Real, b::Real)
    if isnan(a) || isnan(b)
        return false
    end

    a > b && return false

    # TODO Check if this is necessary
    if a == Inf || b == -Inf
        return false
    end

    return true
end

is_valid_interval(a::Real) = true

"""
    interval(a, b)

`interval(a, b)` checks whether [a, b] is a valid `Interval`, using the
(non-exported) `is_valid_interval` function.
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

# TODO Choose a good name
# NOTE We use a different name in tests for easier refactor
const checked_interval = interval

"Make an interval even if a > b"
function force_interval(a, b)
    a > b && return interval(b, a)  # check == true to check for NaN
    return interval(a, b)
end

"""
    a..b
    ..(a, b)

Create the interval `[a, b]`.

Validity of the interval is checked, but nothing is done to compensate for
the fact that floating point literals are rounded to nearest when parsed.

Use the string macro `I"[a, b]"` to ensure tight enclosure around the number
that is typed in, even when it is not exactly representable as a floating point
number (like `0.1`).
"""
..(a, b) = checked_interval(a, b)

# TODO Document and find ref in the standard
a ± b = checked_interval(-(a, b, RoundDown), +(a, b, RoundUp))
±(a::Interval, b) = Interval(-(a.lo, b, RoundDown), +(a.hi, b, RoundUp))

