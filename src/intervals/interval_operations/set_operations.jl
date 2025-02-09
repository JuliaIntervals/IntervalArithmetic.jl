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
    lo = max(inf(x), inf(y))
    hi = min(sup(x), sup(y))
    if lo > hi
        return emptyinterval(BareInterval{T})
    else
        return _unsafe_bareinterval(T, lo, hi)
    end
end
intersect_interval(x::BareInterval, y::BareInterval) = intersect_interval(promote(x, y)...)

function intersect_interval(x::Interval{T}, y::Interval{S}) where {T<:NumTypes,S<:NumTypes}
    isnai(x) | isnai(y) && return nai(promote_type(T, S))
    r = intersect_interval(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y), trv)
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

function hull(x::Interval{T}, y::Interval{S}) where {T<:NumTypes,S<:NumTypes}
    isnai(x) | isnai(y) && return nai(promote_type(T, S))
    r = hull(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y), trv)
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
interiordiff(x::BareInterval, y::BareInterval) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y)

interiordiff(x::Interval, y::Interval) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y)

interiordiff(x::AbstractVector, y::AbstractVector) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y)

"""
    interiordiff(x, y)

In-place version of [`interiordiff`](@ref).
"""
function interiordiff!(v::AbstractVector, x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    if isinterior(x, y)
        empty!(v)
    elseif isdisjoint_interval(x, y)
        resize!(v, 1)
        @inbounds v[begin] = x
    else
        inter = intersect_interval(x, y)
        if issubset_interval(y, x)
            resize!(v, 2)
            @inbounds v[begin] = _unsafe_bareinterval(T, inf(x), inf(inter))
            @inbounds v[end] = _unsafe_bareinterval(T, sup(inter), sup(x))
        elseif isweakless(x, inter)
            resize!(v, 1)
            @inbounds v[begin] = _unsafe_bareinterval(T, inf(x), inf(inter))
        else
            resize!(v, 1)
            @inbounds v[begin] = _unsafe_bareinterval(T, sup(inter), sup(x))
        end
    end
    return v
end
interiordiff!(v::AbstractVector, x::BareInterval, y::BareInterval) = interiordiff!(v, promote(x, y)...)

function interiordiff!(v::AbstractVector, x::Interval{T}, y::Interval{T}) where {T<:NumTypes}
    if isinterior(x, y)
        empty!(v)
    elseif isdisjoint_interval(x, y)
        resize!(v, 1)
        @inbounds v[begin] = x
    else
        d = min(decoration(x), decoration(y))
        t = isguaranteed(x) & isguaranteed(y)
        inter = intersect_interval(x, y)
        if issubset_interval(y, x)
            resize!(v, 2)
            r1 = _unsafe_bareinterval(T, inf(x), inf(inter))
            d1 = min(d, decoration(r1), trv)
            @inbounds v[begin] = _unsafe_interval(r1, d1, t)
            r2 = _unsafe_bareinterval(T, sup(inter), sup(x))
            d2 = min(d, decoration(r2), trv)
            @inbounds v[end] = _unsafe_interval(r2, d2, t)
        elseif isweakless(x, inter)
            resize!(v, 1)
            r1 = _unsafe_bareinterval(T, inf(x), inf(inter))
            d1 = min(d, decoration(r1), trv)
            @inbounds v[begin] = _unsafe_interval(r1, d1, t)
        else
            resize!(v, 1)
            r2 = _unsafe_bareinterval(T, sup(inter), sup(x))
            d2 = min(d, decoration(r2), trv)
            @inbounds v[begin] = _unsafe_interval(r2, d2, t)
        end
    end
    return v
end
interiordiff!(v::AbstractVector, x::Interval, y::Interval) = interiordiff!(v, promote(x, y)...)

function interiordiff!(v::AbstractVector{<:AbstractVector}, x::AbstractVector, y::AbstractVector)
    # start from the total overlap (in all directions); expand each direction in turn

    N = length(x)
    len = length(y)
    N == len || return throw(DimensionMismatch("x has length $N, y has length $len"))

    if any(t -> isdisjoint_interval(t[1], t[2]), zip(x, y))
        resize!(v, 1)
        @inbounds v[begin] = copy(x)
    else
        resize!(v, 2*N)

        offset = 0
        x_bis = copy(x)

        @inbounds for i ∈ eachindex(x, y)
            h₁, h₂, inter = _interiordiff(x[i], y[i])
            u₁ = similar(eltype(v), N)
            u₂ = similar(eltype(v), N)
            @inbounds for j ∈ eachindex(u₁)
                u₁[j] = ifelse(j == i, h₁, x_bis[j])
                u₂[j] = ifelse(j == i, h₂, x_bis[j])
            end
            v[begin+offset] = u₁
            v[begin+1+offset] = u₂
            offset += 2
            x_bis[i] = inter
        end

        filter!(z -> !any(x -> isempty_interval(x) | isnai(x), z), v)
    end

    return v
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

function interval_diff(x::Interval{T}, y::Interval) where {T<:NumTypes}
    isdisjoint_interval(x, y) && return [x]
    issubset_interval(x, y) && return Interval{T}[]

    intersection = intersect_interval(x, y)
    inf(x) == inf(intersection) && return [interval(sup(intersection), sup(x))]
    sup(x) == sup(intersection) && return [interval(inf(x), inf(intersection))]

    return [
        interval(inf(x), inf(intersection)),
        interval(sup(intersection), sup(x))
    ]
end