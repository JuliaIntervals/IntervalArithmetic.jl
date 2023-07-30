# This file contains the functions described as "Boolean functions of intervals"
# in Section 9.5 of the IEEE Standard 1788-2015 and required for set-based
# flavor in Section 10.5.9
# Some other (non required) related functions are also present, as well as some of
# the "Recommended operations" (Section 10.6.3)

# Equivalent to `<` but with Inf < Inf being true.
function isweaklylessprime(a::Real, b::Real)
    (isinf(a) || isinf(b)) && a == b && return true
    return a < b
end

"""
    ≛(a::Interval, b::Interval)

Checks if the intervals `a` and `b` are identical.

Typed as \\starequal<TAB>.

Implement the `equal` function of the IEEE Standard 1788-2015  (Table 9.3).

The more common `==` operator is reserved for flavor dependent pointwise
equality.

In most case this is equivalent to the built-in `===`.
"""
function ≛(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return true
    return inf(a) == inf(b) && sup(a) == sup(b)
end
Base.:(==)(::Interval, ::Interval) =
    throw(ArgumentError("== is purposely not supported, use ≛ instead"))

"""
    ≛(a::Interval, x::Real)

Check if the interval `a` contains exactly (and only) the number `x`.
"""
≛(a::Interval, x::Real) = inf(a) == sup(a) == x

"""
    ⊆(a,b)

Checks if all the points of the interval `a` are within the interval `b`.

Typed with \\subseteq<TAB>.

Implement the `subset` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function issubset(a::Interval, b::Interval)
    isempty(a) && return true
    return inf(b) ≤ inf(a) && sup(a) ≤ sup(b)
end

"""
    ⊂(a,b)

Checks if `a` is a strict subset of interval `b`.

Typed with \\subset<TAB>.
"""
function ⊂(a::Interval, b::Interval)
    a ≛ b && return false
    return a ⊆ b
end

⊃(a::Interval, b::Interval) = b ⊂ a

"""
    isweaklyless(a, b)

Checks if the interval `a` is weakly less than interval `b`.

Note that this is not equivalent as saying every element of `a` is less than
any element of `b`.

Implement the `less` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function isweaklyless(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    return (inf(a) ≤ inf(b)) && (sup(a) ≤ sup(b))
end

"""
    precedes(a, b)

Checks if the interval `a` is to the left of interval `b`.

Implement the `precedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function precedes(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    return sup(a) ≤ inf(b)
end

"""
    isinterior(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `interior` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isinterior(a::Interval, b::Interval)
    isempty(a) && return true
    return isweaklylessprime(inf(b), inf(a)) && isweaklylessprime(sup(a), sup(b))
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
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    return isweaklylessprime(inf(a), inf(b)) && isweaklylessprime(sup(a), sup(b))
end

"""
    strictprecedes(a, b)

Checks if the interval `a` is strictly to the left of interval `b`.

Implement the `strictPrecedes` function of the IEEE Standard 1788-2015 (Table 10.3).
"""
function strictprecedes(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    return sup(a) < inf(b)
end

"""
    isdisjoint(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `disjoint` function of the IEEE Standard 1788-2015 (Table 9.3).
"""
function isdisjoint(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    return isweaklylessprime(sup(b), inf(a)) || isweaklylessprime(sup(a), inf(b))
end

function isdisjoint(a::Complex{F}, b::Complex{F}) where {F<:Interval}
    return isdisjoint(real(a), real(b)) || isdisjoint(imag(a), imag(b))
end

"""
    in(x, a)
    ∈(x, a)

Checks if the number `x` is a member of the interval `a`, treated as a set.

Implement the `isMember` function of the IEEE Standard 1788-2015 (section 10.6.3).
"""
function in(x::Real, a::Interval)
    isinf(x) && return contains_infinity(a)
    return inf(a) ≤ x ≤ sup(a)
end

in(x::Interval, y::Interval) = throw(ArgumentError("$x ∈ $y is not defined, maybe you meant `⊂`"))
in(x::Real, a::Complex{<:Interval}) = x ∈ real(a) && 0 ∈ imag(a)
in(x::Complex, a::Complex{<:Interval}) = real(x) ∈ real(a) && imag(x) ∈ imag(a)

contains_zero(x::Interval{T}) where {T<:NumTypes} = zero(T) ∈ x

isempty(x::Interval{T}) where {T<:NumTypes} = (inf(x) == typemax(T)) && (sup(x) == typemin(T))
isentire(x::Interval{T}) where {T<:NumTypes} = (inf(x) == typemin(T)) && (sup(x) == typemax(T))
isbounded(x::Interval) = (isfinite(inf(x)) && isfinite(sup(x))) || isempty(x)
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
iscommon(x::Interval) = !(isentire(x) || isempty(x) || isunbounded(x))

"""
    isatomic(x::Interval)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower
bound or the bounds are consecutive floating point numbers.
"""
isatomic(x::Interval) = isempty(x) || (inf(x) == sup(x)) || (sup(x) == nextfloat(inf(x)))

"""
    isthinzero(x)

Return whether the interval only contains zero.
"""
isthinzero(x::Interval) = iszero(inf(x)) && iszero(sup(x))

"""
    isthininteger(x)

Return whether the inverval only contains a single integer.
"""
isthininteger(x::Interval) = (inf(x) == sup(x)) && isinteger(inf(x))
