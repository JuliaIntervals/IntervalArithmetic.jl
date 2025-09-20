# This file contains the functions described as "Set operations" in Section 9.3
# of the IEEE Std 1788-2015 and required for set-based flavor in Section 10.5.7
# Some other (non required) related functions are also present

_set_decoration(x::Interval, d::Decoration) = setdecoration(x, d)

function _set_decoration(x::Interval, d::Symbol)
    d === :auto    && return x
    d === :default && return setdecoration(x, min(trv, decoration(x)))
    return throw(ArgumentError("decoration option must be `:default`, `:auto` or a specific decoration"))
end

"""
    intersect_interval(x, y; dec = :default)

Returns the intersection of the intervals `x` and `y`, considered as (extended)
sets of real numbers. That is, the set that contains the points common in `x`
and `y`.

The keywork `dec` argument controls the decoration of the result. It can be
either a specific decoration, or one of two following options:
    - `:default`: if at least one of the input intervals is `ill`,
        then the result is `ill`, otherwise it is `trv` (Section 11.7.1).
    - `:auto`: the ouptut has the minimal decoration of the inputs.

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

function intersect_interval(x::Interval{T}, y::Interval{S}; dec = :default) where {T<:NumTypes,S<:NumTypes}
    isnai(x) | isnai(y) && return nai(promote_type(T, S))
    r = intersect_interval(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y))
    t = isguaranteed(x) & isguaranteed(y)
    return _set_decoration(_unsafe_interval(r, d, t), dec)
end

intersect_interval(x, y, z, w...; dec = :default) =
    reduce((a, b) -> intersect_interval(a, b; dec = dec), (x, y, z, w...))
intersect_interval(x::Complex, y::Complex; dec = :default) =
    complex(intersect_interval(real(x), real(y); dec = dec), intersect_interval(imag(x), imag(y); dec = dec))
intersect_interval(x::Real, y::Complex; dec = :default) =
    complex(intersect_interval(x, real(y); dec = dec), intersect_interval(zero(x), imag(y); dec = dec))
intersect_interval(x::Complex, y::Real; dec = :default) =
    complex(intersect_interval(real(x), y; dec = dec), intersect_interval(imag(x), zero(y); dec = dec))

"""
    hull(x, y; dec = :default)

Return the interval hull of the intervals `x` and `y`, considered as (extended)
sets of real numbers, i.e. the smallest interval that contains all of `x` and
`y`.

The keywork `dec` argument controls the decoration of the result. It can be
either a specific decoration, or one of two following options:
    - `:default`: if at least one of the input intervals is `ill`,
        then the result is `ill`, otherwise it is `trv` (Section 11.7.1).
    - `:auto`: the ouptut has the minimal decoration of the inputs.

Implement the `convexHull` function of the IEEE Standard 1788-2015 (Section 9.3).
"""
function hull(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) & isempty_interval(y) && return x
    return _unsafe_bareinterval(T, min(inf(x), inf(y)), max(sup(x), sup(y)))
end
hull(x::BareInterval, y::BareInterval) = hull(promote(x, y)...)

function hull(x::Interval{T}, y::Interval{S}; dec = :default) where {T<:NumTypes,S<:NumTypes}
    isnai(x) | isnai(y) && return nai(promote_type(T, S))
    r = hull(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y))
    t = isguaranteed(x) & isguaranteed(y)
    return _set_decoration(_unsafe_interval(r, d, t), dec)
end

hull(x, y, z, w...; dec = :default) =
    reduce((a, b) -> hull(a, b; dec = dec), (x, y, z, w...))
hull(x::Complex, y::Complex; dec = :default) =
    complex(hull(real(x), real(y); dec = dec), hull(imag(x), imag(y); dec = dec))
hull(x::Real, y::Complex; dec = :default) =
    complex(hull(x, real(y); dec = dec), hull(zero(x), imag(y); dec = dec))
hull(x::Complex, y::Real; dec = :default) =
    complex(hull(real(x), y; dec = dec), hull(imag(x), zero(y); dec = dec))

"""
    union_interval(x, y, z...)

Alias of [`hull`](@ref).
"""
const union_interval = hull

"""
    interiordiff(x, y; dec = :default)

Remove the interior of `y` from `x`. If `x` and `y` are vectors, then they are
treated as multi-dimensional intervals.

The keywork `dec` argument controls the decoration of the result. It can be
either a specific decoration, or one of two following options:
    - `:default`: if at least one of the input intervals is `ill`,
        then the result is `ill`, otherwise it is `trv` (Section 11.7.1).
    - `:auto`: the ouptut has the minimal decoration of the inputs.
"""
interiordiff(x::BareInterval, y::BareInterval) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y)

interiordiff(x::AbstractVector{<:BareInterval}, y::AbstractVector{<:BareInterval}) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y)

interiordiff(x::Interval, y::Interval; dec = :default) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y; dec = dec)

interiordiff(x::AbstractVector{<:Interval}, y::AbstractVector{<:Interval}; dec = :default) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y; dec = dec)

"""
    interiordiff!(x, y; dec = :default)

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
interiordiff!(v::AbstractVector{<:AbstractVector}, x::AbstractVector{<:BareInterval}, y::AbstractVector{<:BareInterval}) =
    _interiordiff!(v, x, y, nothing)

function interiordiff!(v::AbstractVector, x::Interval{T}, y::Interval{T}; dec = :default) where {T<:NumTypes}
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
            @inbounds v[begin] = _set_decoration(_unsafe_interval(r1, d, t), dec)
            r2 = _unsafe_bareinterval(T, sup(inter), sup(x))
            @inbounds v[end] = _set_decoration(_unsafe_interval(r2, d, t), dec)
        elseif isweakless(x, inter)
            resize!(v, 1)
            r1 = _unsafe_bareinterval(T, inf(x), inf(inter))
            @inbounds v[begin] = _set_decoration(_unsafe_interval(r1, d, t), dec)
        else
            resize!(v, 1)
            r2 = _unsafe_bareinterval(T, sup(inter), sup(x))
            @inbounds v[begin] = _set_decoration(_unsafe_interval(r2, d, t), dec)
        end
    end
    return v
end
interiordiff!(v::AbstractVector, x::Interval, y::Interval; dec = :default) = interiordiff!(v, promote(x, y)...; dec = dec)
interiordiff!(v::AbstractVector{<:AbstractVector}, x::AbstractVector{<:Interval}, y::AbstractVector{<:Interval}; dec = :default) =
    _interiordiff!(v, x, y, dec)

function _interiordiff!(v::AbstractVector{<:AbstractVector}, x::AbstractVector, y::AbstractVector, dec)
    # start from the total overlap (in all directions); expand each direction in turn

    N = length(x)
    len = length(y)
    N == len || return throw(DimensionMismatch("x has length $N, y has length $len"))

    if any(t -> isdisjoint_interval(t[1], t[2]), zip(x, y))
        resize!(v, 1)
        @inbounds v[begin] = copy(x)
    else
        resize!(v, 2N)

        offset = 0
        x_bis = copy(x)

        @inbounds for i ∈ eachindex(x, y)
            h₁, h₂, inter = _interiordiff(x[i], y[i], dec)
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

function _interiordiff(x::BareInterval{T}, y::BareInterval{T}, ::Nothing) where {T<:NumTypes}
    isdisjoint_interval(x, y) && return (x, emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T}))

    inter = intersect_interval(x, y)
    isinterior(x, y) && return (emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T}), inter)
    isequal_interval(x, y) && return (_unsafe_bareinterval(T, inf(x), inf(x)), _unsafe_bareinterval(T, sup(x), sup(x)), inter)

    inf(x) == inf(inter) && return (_unsafe_bareinterval(T, sup(inter), sup(x)), emptyinterval(BareInterval{T}), inter)
    sup(x) == sup(inter) && return (_unsafe_bareinterval(T, inf(x), inf(inter)), emptyinterval(BareInterval{T}), inter)

    return (_unsafe_bareinterval(T, inf(x), inf(y)), _unsafe_bareinterval(T, sup(y), sup(x)), inter)
end
_interiordiff(x::BareInterval, y::BareInterval, dec::Nothing) = _interiordiff(promote(x, y)..., dec)

function _interiordiff(x::Interval, y::Interval, dec)
    h₁, h₂, inter = _interiordiff(bareinterval(x), bareinterval(y), nothing)
    d = min(decoration(x), decoration(y))
    t = isguaranteed(x) & isguaranteed(y)
    return (_set_decoration(_unsafe_interval(h₁, d, t), dec), _set_decoration(_unsafe_interval(h₂, d, t), dec), _set_decoration(_unsafe_interval(inter, d, t), dec))
end

#

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
