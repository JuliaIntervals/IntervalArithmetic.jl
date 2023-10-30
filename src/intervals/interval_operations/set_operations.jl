# This file contains the functions described as "Set operations" in Section 9.3
# of the IEEE Std 1788-2015 and required for set-based flavor in Section 10.5.7
# Some other related functions are also present



# bare intervals

"""
    intersect_interval(a, b)

Returns the intersect_interval of the intervals `a` and `b`, considered as
(extended) sets of real numbers. That is, the set that contains
the points common in `a` and `b`.

Implement the `intersection` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
function intersect_interval(a::BareInterval{T}, b::BareInterval{S}) where {T<:NumTypes,S<:NumTypes}
    R = promote_numtype(T, S)
    isdisjoint_interval(a, b) && return emptyinterval(BareInterval{R})
    return _unsafe_bareinterval(R, max(inf(a), inf(b)), min(sup(a), sup(b)))
end

"""
    hull(a, b)

Return the "interval hull" of the intervals `a` and `b`, considered as
(extended) sets of real numbers, i.e. the smallest interval that contains
all of `a` and `b`.

Implement the `convexHull` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
hull(a::BareInterval{T}, b::BareInterval{S}) where {T<:NumTypes,S<:NumTypes} =
    _unsafe_bareinterval(promote_numtype(T, S), min(inf(a), inf(b)), max(sup(a), sup(b)))

"""
    setdiff_interval(x::BareInterval, y::BareInterval)

Calculate the set difference `x ∖ y`, i.e. the set of values
that are inside the interval `x` but not inside `y`.

Returns an array of intervals.
The array may:

- be empty if `x ⊆ y`;
- contain a single interval, if `y` overlaps `x`
- contain two intervals, if `y` is strictly contained within `x`.
"""
function setdiff_interval(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    inter = intersect_interval(x, y)

    isempty_interval(inter) && return [x]
    isequal_interval(inter, x) && return BareInterval{T}[]  # x is subset of y; setdiff is empty

    inf(x) == inf(inter) && return [_unsafe_bareinterval(T, sup(inter), sup(x))]
    sup(x) == sup(inter) && return [_unsafe_bareinterval(T, inf(x), inf(inter))]

    return [_unsafe_bareinterval(T, inf(x), inf(y)), _unsafe_bareinterval(T, sup(y), sup(x))]
end



# decorated intervals

for f ∈ (:intersect_interval, :hull)
    @eval begin
        """
            $($f)(x, y)

        Decorated interval extension; the result is decorated by at most `trv`,
        following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
        """
        function $f(x::Interval, y::Interval)
            r = $f(bareinterval(x), bareinterval(y))
            d = min(decoration(x), decoration(y), decoration(r), trv)
            return _unsafe_interval(r, d)
        end
    end
end

function setdiff_interval(x::Interval, y::Interval)
    r = setdiff_interval(bareinterval(x), bareinterval(y))
    return _unsafe_interval.(r, min.(decoration(x), decoration(y), decoration.(r), trv))
end



# extension

for f ∈ (:intersect_interval, :hull)
    @eval begin
        $f(x, y, z, w...) = reduce($f, (x, y, z, w...))
        $f(x::Complex, y::Complex) = complex($f(real(x), real(y)), $f(imag(x), imag(y)))
        $f(x::Real, y::Complex) = complex($f(x, real(y)), $f(zero(x), imag(y)))
        $f(x::Complex, y::Real) = complex($f(real(x), y), $f(imag(x), zero(y)))
    end
end
