# This file is part of the IntervalArithmetic.jl package; MIT licensed


"""
    in(x, a)
    ∈(x, a)

Checks if the number `x` is a member of the interval `a`, treated as a set.
Corresponds to `isMember` in the ITF-1788 Standard.
"""
function in(x::T, a::Interval) where T<:Real
    isinf(x) && return false
    a.lo <= x <= a.hi
end

in(x::Interval, y::Interval) = throw(ArgumentError("$x ∈ $y is not defined"))

in(x::T, a::Complex{<:Interval}) where T<:Real = x ∈ real(a) && 0 ∈ imag(a)
in(x::Complex{T}, a::Complex{<:Interval}) where T<:Real = real(x) ∈ real(a) && imag(x) ∈ imag(a)



"""
    issubset(a,b)
    ⊆(a,b)

Checks if all the points of the interval `a` are within the interval `b`.
"""
function ⊆(a::Interval, b::Interval)
    isempty(a) && return true
    b.lo ≤ a.lo && a.hi ≤ b.hi
end

function ⊂(a::Interval, b::Interval)
    a == b && return false
    a ⊆ b
end

function ⊇(a::Interval, b::Interval)
    b ⊆ a
end

function ⊃(a::Interval, b::Interval)
    b ⊂ a
end

# isinterior
function isinterior(a::Interval, b::Interval)
    isempty(a) && return true
    islessprime(b.lo, a.lo) && islessprime(a.hi, b.hi)
end
const ⪽ = isinterior  # \subsetdot

# Disjoint:
function isdisjoint(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    islessprime(b.hi, a.lo) || islessprime(a.hi, b.lo)
end

function isdisjoint(a::Complex{<:Interval}, b::Complex{<:Interval})
    isdisjoint(real(a),real(b)) || isdisjoint(imag(a),imag(b))
end


# Intersection
"""
    intersect(a, b)
    ∩(a,b)

Returns the intersection of the intervals `a` and `b`, considered as
(extended) sets of real numbers. That is, the set that contains
the points common in `a` and `b`.
"""
function intersect(a::Interval{T}, b::Interval{T}) where T
    isdisjoint(a,b) && return emptyinterval(T)

    Interval(max(a.lo, b.lo), min(a.hi, b.hi))
end
# Specific promotion rule for intersect:
intersect(a::Interval{T}, b::Interval{S}) where {T,S} =
    intersect(promote(a, b)...)

function intersect(a::Complex{Interval{T}},b::Complex{Interval{T}}) where T
    isdisjoint(a,b) && return complex(emptyinterval(T),emptyinterval(T)) # for type stability

    complex(intersect(real(a),real(b)),intersect(imag(a),imag(b)))
end
intersect(a::Interval{Complex{T}}, b::Interval{Complex{S}}) where {T,S} =
    intersect(promote(a, b)...)

"""
    intersect(a::Interval{T}...) where T

Returns the n-ary intersection of its arguments.

This function is applicable to any number of input intervals, as in
`intersect(a1, a2, a3, a4)` where `ai` is an interval.
If your use case needs to splat the input, as in `intersect(a...)`, consider
`reduce(intersect, a)` instead, because you save the cost of splatting.
"""
function intersect(a::Interval{T}...) where T
    low = maximum(broadcast(ai -> ai.lo, a))
    high = minimum(broadcast(ai -> ai.hi, a))

    !is_valid_interval(low, high) && return emptyinterval(T)
    return Interval(low, high)
end

## Hull
"""
    hull(a, b)

Returns the "interval hull" of the intervals `a` and `b`, considered as
(extended) sets of real numbers, i.e. the smallest interval that contains
all of `a` and `b`.
"""
hull(a::Interval, b::Interval) = Interval(min(a.lo, b.lo), max(a.hi, b.hi))
#
# hull{T,S}(a::Interval{T}, b::Interval{S}) = hull(promote(a, b)...)
hull(a::Complex{<:Interval},b::Complex{<:Interval}) =
    complex(hull(real(a),real(b)),hull(imag(a),imag(b)))
hull(a, b...) = reduce(hull, (a, b...))


"""
    union(a, b)
    ∪(a,b)

Returns the union (convex hull) of the intervals `a` and `b`; it is equivalent
to `hull(a,b)`.
"""
union(a::Interval, b::Interval) = hull(a, b)
#
# union(a::Interval, b::Interval) = union(promote(a, b)...)
union(a::Complex{<:Interval},b::Complex{<:Interval}) = hull(a, b)
union(a, b, c...) = reduce(union, (a, b, c...))

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
function setdiff(x::Interval, y::Interval)
    intersection = x ∩ y

    isempty(intersection) && return [x]
    intersection == x && return typeof(x)[]  # x is subset of y; setdiff is empty

    x.lo == intersection.lo && return [Interval(intersection.hi, x.hi)]
    x.hi == intersection.hi && return [Interval(x.lo, intersection.lo)]

    return [Interval(x.lo, y.lo),
            Interval(y.hi, x.hi)]

end
