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
    isequalinterval(a::Interval, b::Interval)

Checks if the intervals `a` and `b` are identical.

Typed as \\starequal<TAB>.

Implement the `equal` function of the IEEE Standard 1788-2015  (Table 9.3).

The more common `==` operator is reserved for flavor dependent pointwise
equality.

In most case this is equivalent to the built-in `===`.
"""
function isequalinterval(a::Interval, b::Interval)
    isemptyinterval(a) && isemptyinterval(b) && return true
    return inf(a) == inf(b) && sup(a) == sup(b)
end

"""
    isweakinterior(a, b)

Checks if all the points of the interval `a` are within the interval `b`.

Typed with \\subseteq<TAB>.

Implement the `subset` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isweakinterior(a::Interval, b::Interval)
    isemptyinterval(a) && return true
    return inf(b) ≤ inf(a) && sup(a) ≤ sup(b)
end

"""
    isstrictinterior(a, b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `interior` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isstrictinterior(a::Interval, b::Interval)
    isemptyinterval(a) && return true
    return _strictlessprime(inf(b), inf(a)) && _strictlessprime(sup(a), sup(b))
end

"""
    isweakless(a, b)

Checks if the interval `a` is weakly less than interval `b`.

Note that this is not equivalent as saying every element of `a` is less than
any element of `b`.

Implement the `less` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function isweakless(a::Interval, b::Interval)
    isemptyinterval(a) && isemptyinterval(b) && return true
    (isemptyinterval(a) || isemptyinterval(b)) && return false
    return (inf(a) ≤ inf(b)) && (sup(a) ≤ sup(b))
end

"""
    isstrictless(a, b)

Checks if the interval `a` is strictly less than interval `b`, which is true
if `inf(a) < inf(b)` and `sup(a) < sup(b)`.

For variants in the definition of "strictly less than" for intervals see
`strictprecedes` and `<`.

Implement the `strictLess` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function isstrictless(a::Interval, b::Interval)
    isemptyinterval(a) && isemptyinterval(b) && return true
    (isemptyinterval(a) || isemptyinterval(b)) && return false
    return _strictlessprime(inf(a), inf(b)) && _strictlessprime(sup(a), sup(b))
end

"""
    weakprecedes(a, b)

Checks if the interval `a` is to the left of interval `b`.

Implement the `precedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function weakprecedes(a::Interval, b::Interval)
    (isemptyinterval(a) || isemptyinterval(b)) && return true
    return sup(a) ≤ inf(b)
end

"""
    strictprecedes(a, b)

Checks if the interval `a` is strictly to the left of interval `b`.

Implement the `strictPrecedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function strictprecedes(a::Interval, b::Interval)
    (isemptyinterval(a) || isemptyinterval(b)) && return true
    return sup(a) < inf(b)
end

"""
    isdisjointinterval(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `disjoint` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isdisjointinterval(a::Interval, b::Interval)
    (isemptyinterval(a) || isemptyinterval(b)) && return true
    return _strictlessprime(sup(b), inf(a)) || _strictlessprime(sup(a), inf(b))
end

function isdisjointinterval(a::Complex{F}, b::Complex{F}) where {F<:Interval}
    return isdisjointinterval(real(a), real(b)) || isdisjointinterval(imag(a), imag(b))
end

"""
    ismember(x, a)

Checks if the number `x` is a member of the interval `a`, treated as a set.

Implement the `isMember` function of the IEEE Standard 1788-2015 (section 10.6.3).
"""
function ismember(x::Real, a::Interval)
    isinf(x) && return contains_infinity(a)
    return inf(a) ≤ x ≤ sup(a)
end

ismember(::Interval, ::Interval) =
    throw(ArgumentError("`ismember` is purposely not supported for two interval arguments. See instead `isweakinterior`."))
ismember(x::Real, a::Complex{<:Interval}) = ismember(x, real(a)) && ismember(0, imag(a))
ismember(x::Complex, a::Complex{<:Interval}) = ismember(real(x), real(a)) && ismember(imag(x), imag(a))

contains_zero(x::Interval{T}) where {T<:NumTypes} = ismember(zero(T), x)

isemptyinterval(x::Interval{T}) where {T<:NumTypes} = (inf(x) == typemax(T)) && (sup(x) == typemin(T))
isentireinterval(x::Interval{T}) where {T<:NumTypes} = (inf(x) == typemin(T)) && (sup(x) == typemax(T))
isbounded(x::Interval) = (isfinite(inf(x)) && isfinite(sup(x))) || isemptyinterval(x)
isunbounded(x::Interval) = !isbounded(x)

"""
    isthin(x)

Checks if `x` is the set consisting of a single exactly
representable float. Any float which is not exactly representable
does *not* yield a thin interval. Corresponds to `isSingleton` of
the standard.
"""
isthin(x::Interval) = inf(x) == sup(x)

"""
    iscommon(x)

Checks if `x` is a **common interval**, i.e. a non-empty,
bounded, real interval.
"""
iscommon(x::Interval) = !(isentireinterval(x) || isemptyinterval(x) || isunbounded(x))

"""
    isatomic(x::Interval)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower
bound or the bounds are consecutive floating point numbers.
"""
isatomic(x::Interval) = isemptyinterval(x) || (inf(x) == sup(x)) || (sup(x) == nextfloat(inf(x)))

"""
    isthinzero(x)

Return whether the interval only contains zero.
"""
isthinzero(x::Interval) = iszero(inf(x)) && iszero(sup(x))

"""
    isthin(a::Interval, x::Number)

Check if the interval `a` contains exactly (and only) the number `x`.
"""
isthin(a::Interval, x::Real) = inf(a) == sup(a) == x

"""
    isthininteger(x)

Return whether the inverval only contains a single integer.
"""
isthininteger(x::Interval) = (inf(x) == sup(x)) && isinteger(inf(x))
