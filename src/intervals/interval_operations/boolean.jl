# This file contains the functions described as "Boolean functions of intervals"
# in Section 9.5 of the IEEE Standard 1788-2015 and required for set-based
# flavor in Section 10.5.9
# Some other (non required) related functions are also present, as well as some of
# the "Recommended operations" (Section 10.6.3)

# Equivalent to `<` but with Inf < Inf being true.
function _strictlessprime(a::Real, b::Real)
    (isinf(a) || isinf(b)) && a == b && return true
    return a < b
end

"""
    isequal_interval(a, b)

Check if the intervals `a` and `b` are identical.

Implement the `equal` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isequal_interval(a::BareInterval, b::BareInterval)
    isempty_interval(a) && isempty_interval(b) && return true
    return inf(a) == inf(b) && sup(a) == sup(b)
end

"""
    issubset_interval(a, b)

Check if all the points of the interval `a` are within the interval `b`.

Implement the `subset` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function issubset_interval(a::BareInterval, b::BareInterval)
    isempty_interval(a) && return true
    return inf(b) ≤ inf(a) && sup(a) ≤ sup(b)
end

"""
    isstrictsubset_interval(a, b)

Check if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `interior` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isstrictsubset_interval(a::BareInterval, b::BareInterval)
    isempty_interval(a) && return true
    return _strictlessprime(inf(b), inf(a)) && _strictlessprime(sup(a), sup(b))
end

"""
    isweakless(a, b)

Check if the interval `a` is weakly less than interval `b`. This is not
equivalent as saying every element of `a` is less than any element of `b`.

Implement the `less` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function isweakless(a::BareInterval, b::BareInterval)
    isempty_interval(a) && isempty_interval(b) && return true
    (isempty_interval(a) || isempty_interval(b)) && return false
    return (inf(a) ≤ inf(b)) && (sup(a) ≤ sup(b))
end

"""
    isstrictless(a, b)

Check if `inf(a) < inf(b)` and `sup(a) < sup(b)`, where `<` is replaced by `≤`
for infinite values.

Implement the `strictLess` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
isstrictless(a::BareInterval, b::BareInterval) =
    _strictlessprime(inf(a), inf(b)) && _strictlessprime(sup(a), sup(b))

"""
    precedes(a, b)

Check if the interval `a` is to the left of interval `b`.

Implement the `precedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function precedes(a::BareInterval, b::BareInterval)
    (isempty_interval(a) || isempty_interval(b)) && return true
    return sup(a) ≤ inf(b)
end

"""
    strictprecedes(a, b)

Check if the interval `a` is strictly to the left of interval `b`.

Implement the `strictPrecedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function strictprecedes(a::BareInterval, b::BareInterval)
    (isempty_interval(a) || isempty_interval(b)) && return true
    return sup(a) < inf(b)
end

"""
    isdisjoint_interval(a, b)

Check if none of the points of the interval `a` are within the interval `b`.

Implement the `disjoint` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isdisjoint_interval(a::BareInterval, b::BareInterval)
    (isempty_interval(a) || isempty_interval(b)) && return true
    return _strictlessprime(sup(b), inf(a)) || _strictlessprime(sup(a), inf(b))
end

"""
    in_interval(x, a)

Check if the number `x` is a member of the interval `a`.

Implement the `isMember` function of the IEEE Standard 1788-2015 (section 10.6.3).
"""
function in_interval(x::Real, a::BareInterval)
    isinf(x) && return contains_infinity(a)
    return inf(a) ≤ x ≤ sup(a)
end

in_interval(::BareInterval, ::BareInterval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`."))

isempty_interval(x::BareInterval{T}) where {T<:NumTypes} = (inf(x) == typemax(T)) && (sup(x) == typemin(T))
isentire_interval(x::BareInterval{T}) where {T<:NumTypes} = (inf(x) == typemin(T)) && (sup(x) == typemax(T))
isbounded(x::BareInterval) = (isfinite(inf(x)) && isfinite(sup(x))) || isempty_interval(x)
isunbounded(x::BareInterval) = !isbounded(x)

"""
    isthin(x)

Check if `x` is the set consisting of a single exactly
representable float. Any float which is not exactly representable
does *not* yield a thin interval. Corresponds to `isSingleton` of
the standard.
"""
isthin(x::BareInterval) = inf(x) == sup(x)

"""
    iscommon(x)

Check if `x` is a **common interval**, i.e. a non-empty,
bounded, real interval.
"""
iscommon(x::BareInterval) = !(isentire_interval(x) || isempty_interval(x) || isunbounded(x))

"""
    isatomic(x)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower
bound or the bounds are consecutive floating point numbers.
"""
isatomic(x::BareInterval) = isempty_interval(x) || (inf(x) == sup(x)) || (sup(x) == nextfloat(inf(x)))

"""
    isthinzero(x)

Return whether the interval only contains zero.
"""
isthinzero(x::BareInterval) = iszero(inf(x)) & iszero(sup(x))

"""
    isthin(x, y)

Check if the interval `x` contains exactly (and only) the number `y`.
"""
isthin(x::BareInterval, y::Real) = inf(x) == sup(x) == y

"""
    isthininteger(x)

Return whether the inverval only contains a single integer.
"""
isthininteger(x::BareInterval) = (inf(x) == sup(x)) & isinteger(inf(x))


isnai(::BareInterval) = false



# decorated intervals

for f ∈ (:isempty_interval, :isentire_interval, :isunbounded, :isbounded, :isthin, :isatomic, :iscommon)
    @eval function $f(x::Interval)
        isnai(x) && return false
        return $f(bareinterval(x))
    end
end

function isthinzero(a::Interval)
    isnai(a) && return false
    return isthinzero(bareinterval(a))
end

function isthin(a::Interval, x::Real)
    isnai(a) && return false
    return isthin(bareinterval(a), x)
end

for f ∈ (:issubset_interval, :isstrictsubset_interval, :isdisjoint_interval,
        :precedes, :strictprecedes, :isweakless, :isstrictless,
        :isequal_interval)
    @eval function $f(x::Interval, y::Interval)
        (isnai(x) | isnai(y)) && return false
        return $f(bareinterval(x), bareinterval(y))
    end
end

function in_interval(x::Real, a::Interval)
    isnai(a) && return false
    return in_interval(x, bareinterval(a))
end

# iscommon(x::Interval) = decoration(x) == com

isnai(x::Interval) = decoration(x) == ill



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
