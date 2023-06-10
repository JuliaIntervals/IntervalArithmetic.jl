# This file contains the functions described as "Set operations" in Section 9.3
# of the IEEE Std 1788-2015 and required for set-based flavor in Section 10.5.7
# Some other related functions are also present

"""
    intersect(a, b)
    ∩(a,b)

Returns the intersection of the intervals `a` and `b`, considered as
(extended) sets of real numbers. That is, the set that contains
the points common in `a` and `b`.

Implement the `intersection` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
function intersect(a::Interval{T}, b::Interval{S}) where {T<:NumTypes,S<:NumTypes}
    R = promote_numtype(T, S)
    isdisjoint(a, b) && return emptyinterval(R)
    return unsafe_interval(R, max(inf(a), inf(b)), min(sup(a), sup(b)))
end

function intersect(a::Complex{Interval{T}}, b::Complex{Interval{S}}) where {T<:NumTypes,S<:NumTypes}
    R = promote_numtype(T, S)
    isdisjoint(a, b) && return emptyinterval(Complex{R})
    a_re, a_im = reim(a)
    b_re, b_im = reim(b)
    x_re = unsafe_interval(R, max(inf(a_re), inf(b_re)), min(sup(a_re), sup(b_re)))
    x_im = unsafe_interval(R, max(inf(a_im), inf(b_im)), min(sup(a_im), sup(b_im)))
    return complex(x_re, x_im)
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

Implement the `converxHull` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
hull(a::Interval{T}, b::Interval{S}) where {T<:NumTypes,S<:NumTypes} =
    unsafe_interval(promote_numtype(T, S), min(inf(a), inf(b)), max(sup(a), sup(b)))
hull(a::Complex{<:Interval}, b::Complex{<:Interval}) =
    complex(hull(real(a), real(b)), hull(imag(a), imag(b)))
hull(a...) = reduce(hull, a)
hull(a::AbstractVector{<:Interval}) = reduce(hull, a)

"""
    union(a, b)
    ∪(a,b)

Return the union (convex hull) of the intervals `a` and `b`; it is equivalent
to `hull(a,b)`.

Implement the `converxHull` function of the IEEE Standard 1788-2015 (Section 9.3).
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
function setdiff(x::Interval{T}, y::Interval{T}) where {T<:NumTypes}
    intersection = x ∩ y

    isempty(intersection) && return [x]
    intersection ≛ x && return Interval{T}[]  # x is subset of y; setdiff is empty

    inf(x) == inf(intersection) && return [unsafe_interval(T, sup(intersection), sup(x))]
    sup(x) == sup(intersection) && return [unsafe_interval(T, inf(x), inf(intersection))]

    return [unsafe_interval(T, inf(x), inf(y)), unsafe_interval(T, sup(y), sup(x))]

end
