# This file contains the functions described as "Set operations" in Section 9.3
# of the IEEE Std 1788-2015 and required for set-based flavor in Section 10.5.7
# Some other (non required) related functions are also present

"""
    intersect_interval(x, y)

Returns the intersection of the intervals `x` and `y`, considered as (extended)
sets of real numbers. That is, the set that contains the points common in `x`
and `y`.

The result is decorated by at most `trv` (Section 11.7.1).

Implement the `intersection` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
function intersect_interval(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isdisjoint_interval(x, y) && return emptyinterval(BareInterval{T})
    return _unsafe_bareinterval(T, max(inf(x), inf(y)), min(sup(x), sup(y)))
end
intersect_interval(x::BareInterval, y::BareInterval) = intersect_interval(promote(x, y)...)

function intersect_interval(x::Interval, y::Interval)
    r = intersect_interval(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y), decoration(r), trv)
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

intersect_interval(x, y, z, w...) = reduce(intersect_interval, (x, y, z, w...))
intersect_interval(x::Complex, y::Complex) = complex(intersect_interval(real(x), real(y)), intersect_interval(imag(x), imag(y)))
intersect_interval(x::Real, y::Complex) = complex(intersect_interval(x, real(y)), intersect_interval(zero(x), imag(y)))
intersect_interval(x::Complex, y::Real) = complex(intersect_interval(real(x), y), intersect_interval(imag(x), zero(y)))

"""
    hull(x, y)

Return the interval hull of the intervals `x` and `y`, considered as (extended)
sets of real numbers, i.e. the smallest interval that contains all of `x` and
`y`.

The result is decorated by at most `trv` (Section 11.7.1).

Implement the `convexHull` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
function hull(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) & isempty_interval(y) && return x
    return _unsafe_bareinterval(T, min(inf(x), inf(y)), max(sup(x), sup(y)))
end
hull(x::BareInterval, y::BareInterval) = hull(promote(x, y)...)

function hull(x::Interval, y::Interval)
    r = hull(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y), decoration(r), trv)
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

hull(x, y, z, w...) = reduce(hull, (x, y, z, w...))
hull(x::Complex, y::Complex) = complex(hull(real(x), real(y)), hull(imag(x), imag(y)))
hull(x::Real, y::Complex) = complex(hull(x, real(y)), hull(zero(x), imag(y)))
hull(x::Complex, y::Real) = complex(hull(real(x), y), hull(imag(x), zero(y)))

"""
    interiordiff(x, y)

Remove the interior of `y` from `x`. If `x` and `y` are vectors, then they are
treated as multi-dimensional intervals.
"""
function interiordiff(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isinterior(x, y) && return BareInterval{T}[] # or `[emptyinterval(BareInterval{T})]`?
    isdisjoint_interval(x, y) && return [x]
    inter = intersect_interval(x, y)
    issubset_interval(y, x) && return [_unsafe_bareinterval(T, inf(x), inf(inter)), _unsafe_bareinterval(T, sup(inter), sup(x))]
    isweakless(x, inter) && return [_unsafe_bareinterval(T, inf(x), inf(inter))]
    return [_unsafe_bareinterval(T, sup(inter), sup(x))]
end
interiordiff(x::BareInterval, y::BareInterval) = interiordiff(promote(x, y)...)

function interiordiff(x::Interval, y::Interval)
    r = interiordiff(bareinterval(x), bareinterval(y))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval.(r, min.(decoration(x), decoration(y), decoration.(r), trv), t)
end

function interiordiff(x::AbstractVector, y::AbstractVector)
    # start from the total overlap (in all directions); expand each direction in turn

    N = length(x)
    len = length(y)
    N == len || return throw(DimensionMismatch("x has length $N, y has length $len"))

    T = promote_type(typeof(x), typeof(y))

    any(t -> isdisjoint_interval(t[1], t[2]), zip(x, y)) && return T[x]

    result_list = Vector{T}(undef, 2*N)
    offset = 0
    x_bis = copy(x)

    @inbounds for i ∈ eachindex(x, y)
        h₁, h₂, inter = _interiordiff(x[i], y[i])
        u = similar(T, N)
        v = similar(T, N)
        @inbounds for j ∈ eachindex(u)
            u[j] = ifelse(j == i, h₁, x_bis[j])
            v[j] = ifelse(j == i, h₂, x_bis[j])
        end
        result_list[begin+offset] = u
        result_list[begin+1+offset] = v
        offset += 2
        x_bis[i] = inter
    end

    return filter!(z -> !any(x -> isempty_interval(x) | isnai(x), z), result_list)
end

function _interiordiff(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isdisjoint_interval(x, y) && return (x, emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T}))

    inter = intersect_interval(x, y)
    isinterior(x, y) && return (emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T}), inter)
    isequal_interval(x, y) && return (_unsafe_bareinterval(T, inf(x), inf(x)), _unsafe_bareinterval(T, sup(x), sup(x)), inter)

    inf(x) == inf(inter) && return (_unsafe_bareinterval(T, sup(inter), sup(x)), emptyinterval(BareInterval{T}), inter)
    sup(x) == sup(inter) && return (_unsafe_bareinterval(T, inf(x), inf(inter)), emptyinterval(BareInterval{T}), inter)

    return (_unsafe_bareinterval(T, inf(x), inf(y)), _unsafe_bareinterval(T, sup(y), sup(x)), inter)
end
_interiordiff(x::BareInterval, y::BareInterval) = _interiordiff(promote(x, y)...)

function _interiordiff(x::Interval, y::Interval)
    h₁, h₂, inter = _interiordiff(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y), trv)
    t = isguaranteed(x) & isguaranteed(y)
    return (_unsafe_interval(h₁, d, t), _unsafe_interval(h₂, d, t), _unsafe_interval(inter, d, t))
end
