# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Numeric functions" in the
    IEEE-1788 standard (sections 9.4) and required for set-based flavor
    in section 10.5.9. Some other (non required) related functions are also
    present.

    By default the behavior mimics the required one for the set-based flavor, as
    defined in the standard (sections 10.5.9 and 12.12.8 for the functions in
    this file).
=#

"""
    inf(a::AbstractFlavor)

Infimum of an interval.

Implement the `inf` function of the IEEE Std 1788-2015 (Table 9.2).
"""
inf(a::AbstractFlavor) = a.lo

"""
    sup(a::AbstractFlavor)

Supremum of an interval.

Implement the `sup` function of the IEEE Std 1788-2015 (Table 9.2).
"""
sup(a::AbstractFlavor) = a.hi

"""
    mid(a::Interval)

Find the midpoint of interval `a`.

Implement the `mid` function of the IEEE Std 1788-2015 (Table 9.2).
"""
function mid(a::F) where {T, F<:AbstractFlavor{T}}
    isempty(a) && return convert(T, NaN)
    isentire(a) && return zero(T)

    a.lo == -∞ && return nextfloat(a.lo)  # IEEE-1788 section 12.12.8
    a.hi == +∞ && return prevfloat(a.hi)  # IEEE-1788 section 12.12.8

    midpoint = (a.lo + a.hi) / 2
    isfinite(midpoint) && return midpoint
    #= Fallback in case of overflow: a.hi + a.lo == +∞ or a.hi + a.lo == -∞.
       This case can not be the default one as it does not pass several
       IEEE1788-2015 tests for small floats.
    =#
    return a.lo / 2 + a.hi / 2
end

mid(a::F) where {T, R<:Rational{T}, F<:AbstractFlavor{R}} = (1//2) * (a.lo + a.hi)

"""
    scaled_mid(a::AbstractFlavor, α)

Find an intermediate  point at a relative position `α` in the interval `a`
instead.
    
Assume 0 ≤ α ≤ 1.

Note that `scaled_mid(a, 0.5)` does not equal `mid(a)` for unbounded set-based
intervals.
"""
function scaled_mid(a::F, α) where {T, F<:AbstractFlavor{T}}
    isempty(a) && return convert(T, NaN)

    lo = (a.lo == -∞ ? nextfloat(a.lo) : a.lo)
    hi = (a.hi == +∞ ? prevfloat(a.hi) : a.hi)

    β = convert(T, α)

    midpoint = β * (hi - lo) + lo
    isfinite(midpoint) && return midpoint
    #= Fallback in case of overflow: hi - lo == +∞.
       This case can not be the default one as it does not pass several
       IEEE1788-2015 tests for small floats.
    =#
    return (1 - β) * lo + β * hi
end

"""
    diam(a::AbstractFlavor)

Return the diameter (length) of the interval `a`.

Implement the `wid` function of the IEEE Std 1788-2015 (Table 9.2).
"""
function diam(a::F) where {T, F<:AbstractFlavor{T}}
    isempty(a) && return convert(T, NaN)
    @round_up(a.hi - a.lo)  # IEEE1788 section 12.12.8
end

"""
    radius(a::AbstractFlavor)

Return the radius of the interval `a`, such that `a ⊆ m ± radius`, where
`m = mid(a)` is the midpoint.

Implement the `rad` function of the IEEE Std 1788-2015 (Table 9.2).
"""
function radius(a::AbstractFlavor)
    m, r = midpoint_radius(a)
    return r
end

"""
midpoint_radius(a::AbstractFlavor)

Return the midpoint of an interval `a` together with its radius.

Function required by the  IEEE Std 1788-2015 in section 10.5.9 for the set-based
flavor.
"""
function midpoint_radius(a::F) where {T, F<:AbstractFlavor{T}}
    isempty(a) && return convert(T, NaN), convert(T, NaN)
    m = mid(a)
    return m, max(m - a.lo, a.hi - m)
end


"""
    mag(a::AbstractFlavor)

Magnitude of an interval. Return `NaN` for empty intervals.

Implement the `mag` function of the IEEE Std 1788-2015 (Table 9.2).
"""
function mag(a::F) where {T, F<:AbstractFlavor{T}}
    isempty(a) && return convert(T, NaN)
    max( abs(a.lo), abs(a.hi) )
end

"""
    mig(a::AbstractFlavor)

Mignitude of an interval. Return `NaN` for empty intervals.

Implement the `mig` function of the IEEE Std 1788-2015 (Table 9.2).
"""
function mig(a::F) where {T, F<:AbstractFlavor{T}}
    isempty(a) && return convert(T, NaN)
    contains_zero(a) && return zero(T)
    min( abs(a.lo), abs(a.hi) )
end
