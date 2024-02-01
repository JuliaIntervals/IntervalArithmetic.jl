# This file contains the functions described as "Boolean functions of intervals"
# in Section 9.5 of the IEEE Standard 1788-2015 and required for set-based
# flavor in Section 10.5.9
# Some other (non required) related functions are also present, as well as some
# of the "Recommended operations" (Section 10.6.3)

#

_strictlessprime(x::Real, y::Real) = _strictlessprime(default_flavor(), x, y)
_strictlessprime(::Flavor{:set_based}, x::Real, y::Real) =
    (x < y) | ((isinf(x) | isinf(y)) & (x == y)) # equivalent to `<` but with `(Inf < Inf) == true`

#

"""
    isequal_interval(x, y)

Test whether `x` and `y` are identical.

Implement the `equal` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
isequal_interval(x::BareInterval, y::BareInterval) = (inf(x) == inf(y)) & (sup(x) == sup(y))

function isequal_interval(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isequal_interval(bareinterval(x), bareinterval(y))
end

isequal_interval(x, y, z, w...) = isequal_interval(x, y) & isequal_interval(y, z, w...)
isequal_interval(x::Complex, y::Complex) = isequal_interval(real(x), real(y)) & isequal_interval(imag(x), imag(y))
isequal_interval(x::Complex, y::Real) = isequal_interval(real(x), y) & isthinzero(imag(x))
isequal_interval(x::Real, y::Complex) = isequal_interval(x, real(y)) & isthinzero(imag(y))

isequal_interval(x) = Base.Fix2(isequal_interval, x)

isequal_interval(x::Number, y::Number) = isequal_interval(interval(x), interval(y))

"""
    issubset_interval(x, y)

Test whether `x` is contained in `y`.

Implement the `subset` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
issubset_interval(x::BareInterval, y::BareInterval) = (inf(y) ≤ inf(x)) & (sup(x) ≤ sup(y))

function issubset_interval(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return issubset_interval(bareinterval(x), bareinterval(y))
end

issubset_interval(x, y, z, w...) = issubset_interval(x, y) & issubset_interval(y, z, w...)
issubset_interval(x::Complex, y::Complex) = issubset_interval(real(x), real(y)) & issubset_interval(imag(x), imag(y))
issubset_interval(x::Complex, y::Real) = issubset_interval(real(x), y) & isthinzero(imag(x))
issubset_interval(x::Real, y::Complex) = issubset_interval(x, real(y)) & in_interval(0, imag(y))

issubset_interval(x::Number, y::Number) = issubset_interval(interval(x), interval(y))

"""
    isinterior(x, y)

Test whether `x` is in the interior of `y`.

Implement the `interior` function of the IEEE Standard 1788-2015 (Table 9.3).

See also: [`isstrictsubset`](@ref).
"""
isinterior(x::BareInterval, y::BareInterval) =
    _strictlessprime(inf(y), inf(x)) & _strictlessprime(sup(x), sup(y))

function isinterior(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isinterior(bareinterval(x), bareinterval(y))
end

function isinterior(x::AbstractVector, y::AbstractVector)
    n = length(x)
    m = length(y)
    n == m || return throw(DimensionMismatch("dimensions must match: x has length $n, y has length $m"))
    return all(t -> isinterior(t[1], t[2]), zip(x, y))
end

isinterior(x, y, z, w...) = isinterior(x, y) & isinterior(y, z, w...)
isinterior(x::Complex, y::Complex) =
    (isinterior(real(x), real(y)) & issubset_interval(imag(x), imag(y))) |
    (issubset_interval(real(x), real(y)) & isinterior(imag(x), imag(y)))
isinterior(x::Complex, y::Real) = isinterior(real(x), y) & isthinzero(imag(x))
isinterior(x::Real, y::Complex) = isinterior(x, real(y)) & in_interval(0, imag(y))

isinterior(x::Number, y::Number) = isinterior(interval(x), interval(y))

"""
    isstrictsubset(x, y)

Test whether `x` is a strict subset of `y`. If `x` and `y` are intervals, this
is semantically equivalent to `isinterior(x, y)`. If `x` and `y` are vectors, at
least one component of `x` must be in the interior of `y`.

See also: [`isinterior`](@ref).
"""
isstrictsubset(x::BareInterval, y::BareInterval) = isinterior(x, y)

isstrictsubset(x::Interval, y::Interval) = isinterior(x, y)

isstrictsubset(x::AbstractVector, y::AbstractVector) = isinterior(x, y) & any(t -> isinterior(t[1], t[2]), zip(x, y))

isstrictsubset(x, y, z, w...) = isstrictsubset(x, y) & isstrictsubset(y, z, w...)
isstrictsubset(x::Complex, y::Complex) =
    (isstrictsubset(real(x), real(y)) & issubset_interval(imag(x), imag(y))) |
    (issubset_interval(real(x), real(y)) & isstrictsubset(imag(x), imag(y)))
isstrictsubset(x::Complex, y::Real) = isstrictsubset(real(x), y) & isthinzero(imag(x))
isstrictsubset(x::Real, y::Complex) = isstrictsubset(x, real(y)) & in_interval(0, imag(y))

isstrictsubset(x::Number, y::Number) = isstrictsubset(interval(x), interval(y))

"""
    isweakless(x, y)

Test whether `inf(x) ≤ inf(y)` and `sup(x) ≤ sup(y)`, where `<` is replaced by
`≤` for infinite values.

Implement the `less` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
isweakless(x::BareInterval, y::BareInterval) = (inf(x) ≤ inf(y)) & (sup(x) ≤ sup(y))

function isweakless(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isweakless(bareinterval(x), bareinterval(y))
end

isweakless(x::Number, y::Number) = isweakless(interval(x), interval(y))

"""
    isstrictless(x, y)

Test whether `inf(x) < inf(y)` and `sup(x) < sup(y)`, where `<` is replaced by
`≤` for infinite values.

Implement the `strictLess` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
isstrictless(x::BareInterval, y::BareInterval) =
    _strictlessprime(inf(x), inf(y)) & _strictlessprime(sup(x), sup(y))

function isstrictless(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isstrictless(bareinterval(x), bareinterval(y))
end

isstrictless(x::Number, y::Number) = isstrictless(interval(x), interval(y))

"""
    precedes(x, y)

Test whether any element of `x` is lesser or equal to every elements of `y`.

Implement the `precedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
precedes(x::BareInterval, y::BareInterval) = sup(x) ≤ inf(y)

function precedes(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return precedes(bareinterval(x), bareinterval(y))
end

precedes(x::Number, y::Number) = precedes(interval(x), interval(y))

"""
    strictprecedes(x, y)

Test whether any element of `x` is strictly lesser than every elements of `y`.

Implement the `strictPrecedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
strictprecedes(x::BareInterval, y::BareInterval) = isempty_interval(x) | isempty_interval(y) | (sup(x) < inf(y))

function strictprecedes(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return strictprecedes(bareinterval(x), bareinterval(y))
end

strictprecedes(x::Number, y::Number) = strictprecedes(interval(x), interval(y))

"""
    isdisjoint_interval(x, y)

Test whether `x` and `y` have no common elements.

Implement the `disjoint` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
isdisjoint_interval(a::BareInterval, b::BareInterval) =
    isempty_interval(a) | isempty_interval(b) | _strictlessprime(sup(b), inf(a)) | _strictlessprime(sup(a), inf(b))

function isdisjoint_interval(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isdisjoint_interval(bareinterval(x), bareinterval(y))
end

isdisjoint_interval(x::Complex, y::Complex) =
    isdisjoint_interval(real(x), real(y)) | isdisjoint_interval(imag(x), imag(y))

isdisjoint_interval(x::Number, y::Number) = isdisjoint_interval(interval(x), interval(y))

"""
    in_interval(x, y)

Test whether `x` is an element of `y`.

Implement the `isMember` function of the IEEE Standard 1788-2015 (Section 10.6.3).
"""
function in_interval(x::Number, y::BareInterval)
    isinf(x) && return contains_infinity(y)
    return inf(y) ≤ x ≤ sup(y)
end
in_interval(x::Complex, y::BareInterval) = in_interval(real(x), y) & iszero(imag(x))

function in_interval(x::Number, y::Interval)
    isnai(y) && return false
    return in_interval(x, bareinterval(y))
end

in_interval(::BareInterval, ::BareInterval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`"))

in_interval(::Interval, ::Interval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`"))

in_interval(x::Complex, y::Complex) = in_interval(real(x), real(y)) & in_interval(imag(x), imag(y))
in_interval(x::Complex, y::Number) = in_interval(real(x), y) & iszero(imag(x))
in_interval(x::Number, y::Complex) = in_interval(x, real(y)) & in_interval(0, imag(y))

in_interval(x) = Base.Fix2(in_interval, x)

in_interval(x::Number, y::Number) = in_interval(interval(x), interval(y))

"""
    isempty_interval(x)

Test whether `x` contains no elements.

Implement the `isEmpty` function of the IEEE Standard 1788-2015 (Section 10.6.3).
"""
isempty_interval(x::BareInterval{T}) where {T<:NumTypes} = (inf(x) == typemax(T)) & (sup(x) == typemin(T))

function isempty_interval(x::Interval)
    isnai(x) && return false
    return isempty_interval(bareinterval(x))
end

isempty_interval(x::Complex) = isempty_interval(real(x)) & isempty_interval(imag(x))

isempty_interval(x::Number) = isempty_interval(interval(x))

"""
    isentire_interval(x)

Test whether `x` is the entire real line.

Implement the `isEntire` function of the IEEE Standard 1788-2015 (Section 10.6.3).
"""
isentire_interval(x::BareInterval{T}) where {T<:NumTypes} = (inf(x) == typemin(T)) & (sup(x) == typemax(T))

function isentire_interval(x::Interval)
    isnai(x) && return false
    return isentire_interval(bareinterval(x))
end

isentire_interval(x::Complex) = isentire_interval(real(x)) & isentire_interval(imag(x))

isentire_interval(::Number) = false

"""
    isnai(x)

Test whether `x` is an NaI (Not an Interval).
"""
isnai(::BareInterval) = false

isnai(x::Interval) = decoration(x) == ill

isnai(x::Complex) = isnai(real(x)) & isnai(imag(x))

isnai(x::Number) = isnai(interval(x))

"""
    isbounded(x)

Test whether `x` is empty or has finite bounds.
"""
isbounded(x::BareInterval) = (isfinite(inf(x)) & isfinite(sup(x))) | isempty_interval(x)

function isbounded(x::Interval)
    isnai(x) && return false
    return isbounded(bareinterval(x))
end

isbounded(x::Complex) = isbounded(real(x)) & isbounded(imag(x))

isbounded(x::Number) = isbounded(interval(x))

"""
    isunbounded(x)

Test whether `x` is not empty and has infinite bounds.
"""
isunbounded(x::BareInterval) = !isbounded(x)

function isunbounded(x::Interval)
    isnai(x) && return false
    return isunbounded(bareinterval(x))
end

isunbounded(x::Complex) = isunbounded(real(x)) | isunbounded(imag(x))

isunbounded(x::Number) = isunbounded(interval(x))

"""
    iscommon(x)

Test whether `x` is not empty and bounded.

!!! note
    This is does not take into consideration the decoration of the interval.
"""
iscommon(x::BareInterval) = !(isentire_interval(x) | isempty_interval(x) | isunbounded(x))

function iscommon(x::Interval)
    isnai(x) && return false
    return iscommon(bareinterval(x))
end

iscommon(x::Complex) = iscommon(real(x)) & iscommon(imag(x))

iscommon(x::Number) = iscommon(interval(x))

"""
    isatomic(x)

Test whether `x` is unable to be split. This occurs if the interval is empty,
or if its lower and upper bounds are equal, or if the bounds are consecutive
floating-point numbers.
"""
isatomic(x::BareInterval{<:AbstractFloat}) = isempty_interval(x) | (inf(x) == sup(x)) | (sup(x) == nextfloat(inf(x)))
isatomic(x::BareInterval{<:Rational}) = isempty_interval(x) | (inf(x) == sup(x))

function isatomic(x::Interval)
    isnai(x) && return false
    return isatomic(bareinterval(x))
end

isatomic(x::Complex) = isatomic(real(x)) & isatomic(imag(x))

isatomic(x::Number) = isatomic(interval(x))

"""
    isthin(x)

Test whether `x` contains only a real.

Implement the `isSingleton` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
isthin(x::BareInterval) = inf(x) == sup(x)

function isthin(x::Interval)
    isnai(x) && return false
    return isthin(bareinterval(x))
end

isthin(x::Complex) = isthin(real(x)) & isthin(imag(x))

isthin(x::Number) = isthin(interval(x))

"""
    isthin(x, y)

Test whether `x` contains only `y`.
"""
isthin(x::BareInterval, y::Number) = inf(x) == sup(x) == y
isthin(x::BareInterval, y::Complex) = isthin(x, real(y)) & iszero(imag(y))

function isthin(x::Interval, y::Number)
    isnai(x) && return false
    return isthin(bareinterval(x), y)
end

isthin(x::Complex, y::Complex) = isthin(real(x), real(y)) & isthin(imag(x), imag(y))
isthin(x::Complex, y::Number) = isthin(real(x), real(y)) & isthinzero(imag(x))
isthin(x::Number, y::Complex) = isthin(real(x), real(y)) & iszero(imag(y))

isthin(x::BareInterval, y::Interval) = throw(MethodError(isthin, (x, y)))

isthin(x::Number, y::Number) = isthin(interval(x), y)

"""
    isthinzero(x)

Test whether `x` contains only zero.
"""
isthinzero(x::BareInterval) = iszero(inf(x)) & iszero(sup(x))

function isthinzero(x::Interval)
    isnai(x) && return false
    return isthinzero(bareinterval(x))
end

isthinzero(x::Complex) = isthinzero(real(x)) & isthinzero(imag(x))

isthinzero(x::Number) = isthinzero(interval(x))

"""
    isthinone(x)

Test whether `x` contains only one.
"""
isthinone(x::BareInterval) = isone(inf(x)) & isone(sup(x))

function isthinone(x::Interval)
    isnai(x) && return false
    return isthinone(bareinterval(x))
end

isthinone(x::Complex) = isthinone(real(x)) & isthinzero(imag(x))

isthinone(x::Number) = isthinone(interval(x))

"""
    isthininteger(x)

Test whether `x` contains only an integer.
"""
isthininteger(x::BareInterval) = (inf(x) == sup(x)) & isinteger(inf(x))

function isthininteger(x::Interval)
    isnai(x) && return false
    return isthininteger(bareinterval(x))
end

isthininteger(x::Complex) = isthininteger(real(x)) & isthinzero(imag(x))

isthininteger(x::Number) = isthininteger(interval(x))
