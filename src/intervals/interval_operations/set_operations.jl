# This file contains the functions described as "Set operations" in Section 9.3
# of the IEEE Std 1788-2015 and required for set-based flavor in Section 10.5.7
# Some other (non required) related functions are also present

function set_decoration(dec, xs...)
    if dec == :default
        return min(trv, decoration.(xs)...)
    elseif dec == :auto
        return min(decoration.(xs)...)
    end
    throw(ArgumentError("unknown decoration option $dec. Valid options are :default or :auto, or a decoration."))
end

set_decoration(dec::Decoration, xs...) = dec


"""
    intersect_interval(x, y ; dec = :default)

Returns the intersection of the intervals `x` and `y`, considered as (extended)
sets of real numbers. That is, the set that contains the points common in `x`
and `y`.

The keywork `dec` argument controls the decoration of the result,
it `dec` can be either the decoration of the output,
or a symbol:
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

function intersect_interval(x::Interval{T}, y::Interval{S} ; dec = :default) where {T<:NumTypes,S<:NumTypes}
    isnai(x) | isnai(y) && return nai(promote_type(T, S))
    r = intersect_interval(bareinterval(x), bareinterval(y))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, set_decoration(dec, x, y), t)
end

intersect_interval(x, y, z, w... ; dec = :default) = reduce((a, b) -> intersect_interval(a, b ; dec), (x, y, z, w...))
intersect_interval(x::Complex, y::Complex ; dec = :default) = complex(intersect_interval(real(x), real(y) ; dec), intersect_interval(imag(x), imag(y) ; dec))
intersect_interval(x::Real, y::Complex ; dec = :default) = complex(intersect_interval(x, real(y) ; dec), intersect_interval(zero(x), imag(y) ; dec))
intersect_interval(x::Complex, y::Real ; dec = :default) = complex(intersect_interval(real(x), y ; dec), intersect_interval(imag(x), zero(y) ; dec))

"""
    hull(x, y ; dec = :default)

Return the interval hull of the intervals `x` and `y`, considered as (extended)
sets of real numbers, i.e. the smallest interval that contains all of `x` and
`y`.

The keywork `dec` argument controls the decoration of the result,
it `dec` can be either the decoration of the output,
or a symbol:
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

function hull(x::Interval{T}, y::Interval{S} ; dec = :default) where {T<:NumTypes,S<:NumTypes}
    isnai(x) | isnai(y) && return nai(promote_type(T, S))
    r = hull(bareinterval(x), bareinterval(y))
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, set_decoration(dec, x, y), t)
end

hull(x, y, z, w... ; dec = :default) = reduce((a, b) -> hull(a, b ; dec), (x, y, z, w...))
hull(x::Complex, y::Complex ; dec = :default) = complex(hull(real(x), real(y) ; dec), hull(imag(x), imag(y) ; dec))
hull(x::Real, y::Complex ; dec = :default) = complex(hull(x, real(y) ; dec), hull(zero(x), imag(y) ; dec))
hull(x::Complex, y::Real ; dec = :default) = complex(hull(real(x), y ; dec), hull(imag(x), zero(y) ; dec))

"""
    union_interval(x, y, z...)

Return the union of the intervals.

Alias of the [`hull`](@ref) function.
"""
const union_interval = hull

"""
    interiordiff(x, y ; dec = :default)

Remove the interior of `y` from `x`. If `x` and `y` are vectors, then they are
treated as multi-dimensional intervals.

The keywork `dec` argument controls the decoration of the result,
it `dec` can be either the decoration of the output,
or a symbol:
    - `:default`: if at least one of the input intervals is `ill`,
        then the result is `ill`, otherwise it is `trv` (Section 11.7.1).
    - `:auto`: the ouptut has the minimal decoration of the inputs.
"""
interiordiff(x::BareInterval, y::BareInterval) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y)

interiordiff(x::Interval, y::Interval ; dec = :default) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y ; dec)

interiordiff(x::AbstractVector, y::AbstractVector ; dec = :default) =
    interiordiff!(Vector{promote_type(typeof(x), typeof(y))}(undef, 0), x, y ; dec)

"""
    interiordiff!(x, y)

In-place version of [`interiordiff`](@ref).
"""
function interiordiff!(v::AbstractVector, x::BareInterval{T}, y::BareInterval{T} ; dec = nothing) where {T<:NumTypes}
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
interiordiff!(v::AbstractVector, x::BareInterval, y::BareInterval ; dec = nothing) = interiordiff!(v, promote(x, y)...)

function interiordiff!(v::AbstractVector, x::Interval{T}, y::Interval{T} ; dec = :default) where {T<:NumTypes}
    if isinterior(x, y)
        empty!(v)
    elseif isdisjoint_interval(x, y)
        resize!(v, 1)
        @inbounds v[begin] = x
    else
        t = isguaranteed(x) & isguaranteed(y)
        inter = intersect_interval(x, y)
        if issubset_interval(y, x)
            resize!(v, 2)
            r1 = _unsafe_bareinterval(T, inf(x), inf(inter))
            @inbounds v[begin] = _unsafe_interval(r1, set_decoration(dec, x, y, r1), t)
            r2 = _unsafe_bareinterval(T, sup(inter), sup(x))
            @inbounds v[end] = _unsafe_interval(r2, set_decoration(dec, x, y, r2), t)
        elseif isweakless(x, inter)
            resize!(v, 1)
            r1 = _unsafe_bareinterval(T, inf(x), inf(inter))
            @inbounds v[begin] = _unsafe_interval(r1, set_decoration(dec, x, y, r1), t)
        else
            resize!(v, 1)
            r2 = _unsafe_bareinterval(T, sup(inter), sup(x))
            @inbounds v[begin] = _unsafe_interval(r2, set_decoration(dec, x, y, r2), t)
        end
    end
    return v
end
interiordiff!(v::AbstractVector, x::Interval, y::Interval ; dec = :default) = interiordiff!(v, promote(x, y)... ; dec)

function interiordiff!(v::AbstractVector{<:AbstractVector}, x::AbstractVector, y::AbstractVector ; dec = :default)
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
            h₁, h₂, inter = _interiordiff(x[i], y[i] ; dec)
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

function _interiordiff(x::BareInterval{T}, y::BareInterval{T} ; dec = nothing) where {T<:NumTypes}
    isdisjoint_interval(x, y) && return (x, emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T}))

    inter = intersect_interval(x, y)
    isinterior(x, y) && return (emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T}), inter)
    isequal_interval(x, y) && return (_unsafe_bareinterval(T, inf(x), inf(x)), _unsafe_bareinterval(T, sup(x), sup(x)), inter)

    inf(x) == inf(inter) && return (_unsafe_bareinterval(T, sup(inter), sup(x)), emptyinterval(BareInterval{T}), inter)
    sup(x) == sup(inter) && return (_unsafe_bareinterval(T, inf(x), inf(inter)), emptyinterval(BareInterval{T}), inter)

    return (_unsafe_bareinterval(T, inf(x), inf(y)), _unsafe_bareinterval(T, sup(y), sup(x)), inter)
end
_interiordiff(x::BareInterval, y::BareInterval ; dec = nothing) = _interiordiff(promote(x, y)... ; dec)

function _interiordiff(x::Interval, y::Interval ; dec = :default)
    h₁, h₂, inter = _interiordiff(bareinterval(x), bareinterval(y))
    d = set_decoration(dec, x, y)
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
