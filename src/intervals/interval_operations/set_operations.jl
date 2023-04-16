# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described in sections 9.3 of the
    IEEE Std 1788-2015 (Set operations) and required for set-based flavor
    in section 10.5.7. Some other related functions are also present.
=#

"""
    intersect(a, b)
    ∩(a,b)

Returns the intersection of the intervals `a` and `b`, considered as
(extended) sets of real numbers. That is, the set that contains
the points common in `a` and `b`.

Implement the `intersection` function of the IEEE Std 1788-2015 (section 9.3).
"""
function intersect(a::F, b::G) where {F<:Interval,G<:Interval}
    isdisjoint(a, b) && return emptyinterval(promote_type(F, G))
    return promote_type(F, G)(max(inf(a), inf(b)), min(sup(a), sup(b)))
end

function intersect(a::Complex{F}, b::Complex{G}) where {F<:Interval,G<:Interval}
    isdisjoint(a, b) && return emptyinterval(Complex{promote_type(F, G)})
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
intersect(a::Interval...) = interval(maximum(inf.(a)), minimum(sup.(a)))

"""
    hull(a, b)

Return the "interval hull" of the intervals `a` and `b`, considered as
(extended) sets of real numbers, i.e. the smallest interval that contains
all of `a` and `b`.

Implement the `converxHull` function of the IEEE Std 1788-2015 (section 9.3).
"""
hull(a::F, b::F) where {F<:Interval} = F(min(inf(a), inf(b)), max(sup(a), sup(b)))
hull(a::F, b::G) where {F<:Interval,G<:Interval} =
    promote_type(F, G)(min(inf(a), inf(b)), max(sup(a), sup(b)))
hull(a::Complex{F}, b::Complex{F}) where {F<:Interval} =
    complex(hull(real(a), real(b)), hull(imag(a), imag(b)))
hull(a...) = reduce(hull, a)
hull(a::Vector{F}) where {F<:Interval} = reduce(hull, a)

"""
    union(a, b)
    ∪(a,b)

Return the union (convex hull) of the intervals `a` and `b`; it is equivalent
to `hull(a,b)`.

Implement the `converxHull` function of the IEEE Std 1788-2015 (section 9.3).
"""
union(a::Interval, b::Interval) = hull(a, b)
union(a::Complex{<:Interval}, b::Complex{<:Interval}) = hull(a, b)

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
function setdiff(x::F, y::F) where {F<:Interval}
    intersection = x ∩ y

    isempty(intersection) && return [x]
    intersection ≛ x && return F[]  # x is subset of y; setdiff is empty

    inf(x) == inf(intersection) && return [F(sup(intersection), sup(x))]
    sup(x) == sup(intersection) && return [F(inf(x), inf(intersection))]

    return [F(inf(x), inf(y)), F(sup(y), sup(x))]

end
