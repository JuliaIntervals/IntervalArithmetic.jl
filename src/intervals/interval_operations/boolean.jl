# This file contains the functions described as "Boolean functions of intervals"
# in Section 9.5 of the IEEE Standard 1788-2015 and required for set-based
# flavor in Section 10.5.9
# Some other (non required) related functions are also present, as well as some of
# the "Recommended operations" (Section 10.6.3)

# equivalent to `<` but with `(Inf < Inf) == true`
function _strictlessprime(x::Real, y::Real)
    (isinf(x) || isinf(y)) && x == y && return true
    return x < y
end

"""
    isequal_interval(x::BareInterval, y::BareInterval)
    isequal_interval(x::Interval, y::Interval)

Test whether `x` and `y` are identical.

Implement the `equal` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
isequal_interval(x::BareInterval, y::BareInterval) = (inf(x) == inf(y)) & (sup(x) == sup(y))

function isequal_interval(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return isequal_interval(bareinterval(x), bareinterval(y))
end

"""
    issubset_interval(x::BareInterval, y::BareInterval)
    issubset_interval(x::Interval, y::Interval)

Test whether `x` is contained in `y`.

Implement the `subset` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
issubset_interval(x::BareInterval, y::BareInterval) =
    (inf(y) ≤ inf(x)) & (sup(x) ≤ sup(y))

function issubset_interval(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return issubset_interval(bareinterval(x), bareinterval(y))
end

"""
    isstrictsubset_interval(x::BareInterval, y::BareInterval)
    isstrictsubset_interval(x::Interval, y::Interval)


Test whether `x` is in the interior of `y`.

Implement the `interior` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
isstrictsubset_interval(x::BareInterval, y::BareInterval) =
    _strictlessprime(inf(y), inf(x)) & _strictlessprime(sup(x), sup(y))

function isstrictsubset_interval(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return isstrictsubset_interval(bareinterval(x), bareinterval(y))
end

"""
    isweakless(x::BareInterval, y::BareInterval)
    isweakless(x::Interval, y::Interval)

Test whether `inf(x) ≤ inf(y)` and `sup(x) ≤ sup(y)`, where `<` is replaced by
`≤` for infinite values.

Implement the `less` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
isweakless(x::BareInterval, y::BareInterval) =
    (inf(x) ≤ inf(y)) & (sup(x) ≤ sup(y))

function isweakless(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return isweakless(bareinterval(x), bareinterval(y))
end

"""
    isstrictless(x::BareInterval, y::BareInterval)
    isstrictless(x::Interval, y::Interval)

Test whether `inf(x) < inf(y)` and `sup(x) < sup(y)`, where `<` is replaced by
`≤` for infinite values.

Implement the `strictLess` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
isstrictless(x::BareInterval, y::BareInterval) =
    _strictlessprime(inf(x), inf(y)) & _strictlessprime(sup(x), sup(y))

function isstrictless(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return isstrictless(bareinterval(x), bareinterval(y))
end

"""
    precedes(x::BareInterval, y::BareInterval)
    precedes(x::Interval, y::Interval)

Test whether any element of `x` is lesser or equal to every elements of `y`.

Implement the `precedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
precedes(x::BareInterval, y::BareInterval) = sup(x) ≤ inf(y)

function precedes(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return precedes(bareinterval(x), bareinterval(y))
end

"""
    strictprecedes(x::BareInterval, y::BareInterval)
    strictprecedes(x::Interval, y::Interval)

Test whether any element of `x` is strictly lesser than every elements of `y`.

Implement the `strictPrecedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function strictprecedes(x::BareInterval, y::BareInterval)
    (isempty_interval(x) | isempty_interval(y)) && return true
    return sup(x) < inf(y)
end

function strictprecedes(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return strictprecedes(bareinterval(x), bareinterval(y))
end

"""
    isdisjoint_interval(x::BareInterval, y::BareInterval)
    isdisjoint_interval(x::Interval, y::Interval)

Test whether `x` and `y` have no common elements.

Implement the `disjoint` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isdisjoint_interval(a::BareInterval, b::BareInterval)
    (isempty_interval(a) | isempty_interval(b)) && return true
    return _strictlessprime(sup(b), inf(a)) | _strictlessprime(sup(a), inf(b))
end

function isdisjoint_interval(x::Interval, y::Interval)
    (isnai(x) | isnai(y)) && return false
    return isdisjoint_interval(bareinterval(x), bareinterval(y))
end

"""
    in_interval(x::Real, y::BareInterval)
    in_interval(x::Real, y::Interval)

Test whether `x` is an element of `y`.

Implement the `isMember` function of the IEEE Standard 1788-2015 (Section 10.6.3).
"""
function in_interval(x::Real, y::BareInterval)
    isinf(x) && return contains_infinity(y)
    return inf(y) ≤ x ≤ sup(y)
end

function in_interval(x::Real, y::Interval)
    isnai(y) && return false
    return in_interval(x, bareinterval(y))
end

in_interval(::BareInterval, ::BareInterval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`."))

in_interval(::Interval, ::Interval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`."))

"""
    isempty_interval(x::BareInterval)
    isempty_interval(x::Interval)

Test whether `x` contains no elements.

Implement the `isEmpty` function of the IEEE Standard 1788-2015 (Section 10.6.3).
"""
isempty_interval(x::BareInterval{T}) where {T<:NumTypes} =
    (inf(x) == typemax(T)) & (sup(x) == typemin(T))

function isempty_interval(x::Interval)
    isnai(x) && return false
    return isempty_interval(bareinterval(x))
end

"""
    isentire_interval(x::BareInterval)
    isentire_interval(x::Interval)

Test whether `x` is the entire real line.

Implement the `isEntire` function of the IEEE Standard 1788-2015 (Section 10.6.3).
"""
isentire_interval(x::BareInterval{T}) where {T<:NumTypes} =
    (inf(x) == typemin(T)) & (sup(x) == typemax(T))

function isentire_interval(x::Interval)
    isnai(x) && return false
    return isentire_interval(bareinterval(x))
end

"""
    isbounded(x::BareInterval)
    isbounded(x::Interval)

Test whether `x` is empty or has finite bounds.
"""
isbounded(x::BareInterval) = (isfinite(inf(x)) & isfinite(sup(x))) | isempty_interval(x)

function isbounded(x::Interval)
    isnai(x) && return false
    return isbounded(bareinterval(x))
end

"""
    isbounded(x::BareInterval)
    isbounded(x::Interval)

Test whether `x` is not empty and has infinite bounds.
"""
isunbounded(x::BareInterval) = !isbounded(x)

function isunbounded(x::Interval)
    isnai(x) && return false
    return isunbounded(bareinterval(x))
end

"""
    isnai(x::BareInterval)
    isnai(x::Interval)

Test whether `x` is an NaI.
"""
isnai(::BareInterval) = false

isnai(x::Interval) = decoration(x) == ill

"""
    iscommon(x::BareInterval)
    iscommon(x::Interval)

Test whether `x` is non-empty and bounded.
"""
iscommon(x::BareInterval) = !(isentire_interval(x) | isempty_interval(x) | isunbounded(x))

function iscommon(x::Interval)
    isnai(x) && return false
    return iscommon(bareinterval(x))
end

"""
    isatomic(x::BareInterval)
    isatomic(x::Interval)

Test whether `x` is unable to be split. This occurs when the interval is empty,
or when the upper bound equals the lower bound or the bounds are consecutive
floating-point numbers.
"""
isatomic(x::BareInterval) = isempty_interval(x) | (inf(x) == sup(x)) | (sup(x) == nextfloat(inf(x)))

function isatomic(x::Interval)
    isnai(x) && return false
    return isatomic(bareinterval(x))
end

"""
    isthin(x::BareInterval)
    isthin(x::Interval)

Test whether `x` contains only a real.

Implement the `isSingleton` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
isthin(x::BareInterval) = inf(x) == sup(x)

function isthin(x::Interval)
    isnai(x) && return false
    return isthin(bareinterval(x))
end

"""
    isthin(x::BareInterval, y::Number)
    isthin(x::Interval, y::Number)

Test whether `x` contains only `y`.
"""
isthin(x::BareInterval, y::Number) = inf(x) == sup(x) == y

function isthin(x::Interval, y::Number)
    isnai(x) && return false
    return isthin(bareinterval(x), y)
end

"""
    isthinzero(x::BareInterval)
    isthinzero(x::Interval)

Test whether `x` contains only zero.
"""
isthinzero(x::BareInterval) = iszero(inf(x)) & iszero(sup(x))

function isthinzero(x::Interval)
    isnai(x) && return false
    return isthinzero(bareinterval(x))
end

"""
    isthininteger(x::BareInterval)
    isthininteger(x::Interval)

Test whether `x` contains only an integer.
"""
isthininteger(x::BareInterval) = (inf(x) == sup(x)) & isinteger(inf(x))

function isthininteger(x::Interval)
    isnai(x) && return false
    return isthininteger(bareinterval(x))
end



# extension

isequal_interval(x, y, z, w...) = isequal_interval(x, y) & isequal_interval(y, z, w...)
isequal_interval(x::Complex, y::Complex) = isequal_interval(real(x), real(y)) & isequal_interval(imag(x), imag(y))
isequal_interval(x::Complex, y::Real) = isequal_interval(real(x), y) & isthinzero(imag(x))
isequal_interval(x::Real, y::Complex) = isequal_interval(x, real(y)) & isthinzero(imag(y))

isdisjoint_interval(x::Complex, y::Complex) =
    isdisjoint_interval(real(x), real(y)) | isdisjoint_interval(imag(x), imag(y))

in_interval(x::Complex, y::Complex) = in_interval(real(x), real(y)) & in_interval(imag(x), imag(y))
in_interval(x::Complex, y::Real) = in_interval(real(x), y) & in_interval(imag(x), 0)
in_interval(x::Real, y::Complex) = in_interval(x, real(y)) & in_interval(0, imag(y))
