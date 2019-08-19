# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described in sections 9.3 and 9.5 of the
    IEEE Std 1788-2015 (Set operations and Boolean functions of intervals),
    together with some similar functions.
=#

"""
    intersect(a, b)
    ∩(a,b)

Returns the intersection of the intervals `a` and `b`, considered as
(extended) sets of real numbers. That is, the set that contains
the points common in `a` and `b`.

Implement the `intersection` function of the IEEE Std 1788-2015 (section 9.3).
"""
function intersect(a::F, b::F) where {F <: AbstractFlavor}
    isdisjoint(a, b) && return emptyinterval(F)
    return F(max(a.lo, b.lo), min(a.hi, b.hi))
end

intersect(a::F, b::G) where {F <: AbstractFlavor, G <: AbstractFlavor} =
    intersect(promote(a, b)...)

function intersect(a::Complex{F}, b::Complex{F}) where {F <: AbstractFlavor}
    isdisjoint(a, b) && return emptyinterval(Complex{F})
    return complex(intersect(real(a), real(b)), intersect(imag(a), imag(b)))
end

"""
    intersect(a::Interval{T}...) where T

Return the n-ary intersection of its arguments.

This function is applicable to any number of input intervals, as in
`intersect(a1, a2, a3, a4)` where `ai` is an interval.
If your use case needs to splat the input, as in `intersect(a...)`, consider
`reduce(intersect, a)` instead, because you save the cost of splatting.
"""
function intersect(a::F...) where {F <: AbstractFlavor}
    low = maximum(broadcast(ai -> ai.lo, a))
    high = minimum(broadcast(ai -> ai.hi, a))

    !is_valid_interval(low, high) && return emptyinterval(F)
    return Interval(low, high)
end

"""
    hull(a, b)

Return the "interval hull" of the intervals `a` and `b`, considered as
(extended) sets of real numbers, i.e. the smallest interval that contains
all of `a` and `b`.

Implement the `converxHull` function of the IEEE Std 1788-2015 (section 9.3).
"""
hull(a::F, b::F) where {F <: AbstractFlavor} = F(min(a.lo, b.lo), max(a.hi, b.hi))
hull(a::Complex{F},b::Complex{F}) where {F <: AbstractFlavor} =
    complex(hull(real(a), real(b)), hull(imag(a), imag(b)))

"""
    union(a, b)
    ∪(a,b)

Return the union (convex hull) of the intervals `a` and `b`; it is equivalent
to `hull(a,b)`.

Implement the `converxHull` function of the IEEE Std 1788-2015 (section 9.3).
"""
union(a::AbstractFlavor, b::AbstractFlavor) = hull(a, b)
union(a::Complex{<:AbstractFlavor},b::Complex{<:AbstractFlavor}) = hull(a, b)

"""
    isidentical(a, b)

Checks if the intervals `a` and `b` are identical.

Implement the `equal` function of the IEEE Std 1788-2015  (Table 9.3).
"""
function isidentical(a::F, b::F) where {F <: AbstractFlavor}
    isempty(a) && isempty(b) && return true
    a.lo == b.lo && a.hi == b.hi
end

"""
    isdistinct(a, b)

Checks if the intervals `a` and `b` are not identical.
"""
isdistinct(a::F, b::F) where {F <: AbstractFlavor} = !isidentical(a, b)

"""
    in(x, a)
    ∈(x, a)

Checks if the number `x` is a member of the interval `a`, treated as a set.

Implement the `isMember` function of the IEEE Std 1788-2015 (section 10.6.3).
"""
function in(x::Real, a::AbstractFlavor)
    isinf(x) && return false
    a.lo <= x <= a.hi
end

in(x::AbstractFlavor, y::AbstractFlavor) = throw(ArgumentError("$x ∈ $y is not defined"))
in(x::Real, a::Complex{F}) where {F <: AbstractFlavor} = x ∈ real(a) && 0 ∈ imag(a)
in(x::Complex{T}, a::Complex{F}) where {T <: Real, F <: AbstractFlavor} = real(x) ∈ real(a) && imag(x) ∈ imag(a)

"""
    issubset(a,b)
    ⊆(a,b)

Checks if all the points of the interval `a` are within the interval `b`.

Implement the `subset` function of the IEEE Std 1788-2015 (Table 9.3).
"""
function ⊆(a::AbstractFlavor, b::AbstractFlavor)
    isempty(a) && return true
    b.lo ≤ a.lo && a.hi ≤ b.hi
end

function ⊂(a::AbstractFlavor, b::AbstractFlavor)
    isidentical(a, b) && return false
    return a ⊆ b
end

⊇(a::AbstractFlavor, b::AbstractFlavor) = b ⊆ a
⊃(a::AbstractFlavor, b::AbstractFlavor) = b ⊂ a

"""
    isinterior(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `interior` function of the IEEE Std 1788-2015 (Table 9.3).
"""
function isinterior(a::AbstractFlavor, b::AbstractFlavor)
    isempty(a) && return true
    return islessprime(b.lo, a.lo) && islessprime(a.hi, b.hi)
end
const ⪽ = isinterior  # \subsetdot

"""
    isdisjoint(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `disjoint` function of the IEEE Std 1788-2015 (Table 9.3).
"""
function isdisjoint(a::AbstractFlavor, b::AbstractFlavor)
    (isempty(a) || isempty(b)) && return true
    return islessprime(b.hi, a.lo) || islessprime(a.hi, b.lo)
end

function isdisjoint(a::Complex{F}, b::Complex{F}) where {F <: AbstractFlavor}
    return isdisjoint(real(a),real(b)) || isdisjoint(imag(a),imag(b))
end

"""
    setdiff(x::Interval, y::Interval)

Calculate the set difference `x ∖ y`, i.e. the set of values
that are inside the interval `x` but not inside `y`.

Returns an array of intervals.
The array may:

- be empty if `x ⊆ y`;
- contain a single interval, if `y` overlaps `x`
- contain two intervals, if `y` is strictly contained within `x`.
"""
function setdiff(x::F, y::F) where {F <: AbstractFlavor}
    intersection = x ∩ y

    isempty(intersection) && return [x]
    intersection == x && return F[]  # x is subset of y; setdiff is empty

    x.lo == intersection.lo && return [F(intersection.hi, x.hi)]
    x.hi == intersection.hi && return [F(x.lo, intersection.lo)]

    return [F(x.lo, y.lo), F(y.hi, x.hi)]

end
