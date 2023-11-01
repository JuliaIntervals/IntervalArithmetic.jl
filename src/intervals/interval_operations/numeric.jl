# This file contains the functions described as "Numeric functions" in Section 9.4
# of the IEEE Std 1788-2015 and required for set-based flavor in Section 10.5.9
# Some other (non required) related functions are also present
# By default the behavior mimics the required one for the set-based flavor, as
# defined in the standard (sections 10.5.9 and 12.12.8 for the functions in
# this file)



# bare intervals

"""
    inf(a::Interval)

Infimum of an interval. For a zero `AbstractFloat` lower bound, a negative zero
is returned.

Implement the `inf` function of the IEEE Standard 1788-2015 (Table 9.2 and
Section 12.12.8).
"""
inf(a::BareInterval{T}) where {T<:AbstractFloat} = ifelse(isnan(a.lo), typemax(T), ifelse(iszero(a.lo), copysign(a.lo, -1), a.lo))
inf(a::BareInterval{<:Rational}) = a.lo

"""
    sup(a::Interval)

Supremum of an interval.

Implement the `sup` function of the IEEE Standard 1788-2015 (Table 9.2).
"""
sup(a::BareInterval{T}) where {T<:AbstractFloat} = ifelse(isnan(a.hi), typemin(T), a.hi)
sup(a::BareInterval{<:Rational}) = a.hi

"""
    bounds(a::Interval)

Bounds of an interval as a tuple. This is semantically equivalent to
`(a.lo, sup(a))`. In particular, this function does not normalize the lower
bound.
"""
bounds(a::BareInterval{T}) where {T<:AbstractFloat} = (ifelse(isnan(a.lo), typemax(T), a.lo), a.hi)
bounds(a::BareInterval{<:Rational}) = (inf(a), sup(a))

"""
    mid(a::Interval)

Find the midpoint of the interval `a`.

Implement the `mid` function of the IEEE Standard 1788-2015 (Table 9.2).
"""
function mid(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return convert(T, NaN)
    isentire_interval(a) && return zero(T)

    inf(a) == typemin(T) && return nextfloat(inf(a))  # IEEE-1788 section 12.12.8
    sup(a) == typemax(T) && return prevfloat(sup(a))  # IEEE-1788 section 12.12.8

    midpoint = (inf(a) + sup(a)) / 2
    isfinite(midpoint) && return _normalisezero(midpoint)
    # Fallback in case of overflow: sup(a) + inf(a) == +∞ or sup(a) + inf(a) == -∞.
    # This case can not be the default one as it does not pass several
    # IEEE1788-2015 tests for small floats.
    return _normalisezero(inf(a) / 2 + sup(a) / 2)
end

function mid(a::BareInterval{T}) where {T<:Rational}
    isempty_interval(a) && return throw(ArgumentError("cannot compute the mid of empty intervals; cannot return a `Rational` NaN."))
    isentire_interval(a) && return zero(T)

    inf(a) == typemin(T) && return nextfloat(inf(a))  # IEEE-1788 section 12.12.8
    sup(a) == typemax(T) && return prevfloat(sup(a))  # IEEE-1788 section 12.12.8

    midpoint = (inf(a) + sup(a)) / 2
    isfinite(midpoint) && return _normalisezero(midpoint)
    # Fallback in case of overflow: sup(a) + inf(a) == +∞ or sup(a) + inf(a) == -∞.
    # This case can not be the default one as it does not pass several
    # IEEE1788-2015 tests for small floats.
    return _normalisezero(inf(a) / 2 + sup(a) / 2)
end

"""
    scaled_mid(a::Interval, α)

Find an intermediate point at a relative position `α` in the interval `a`
instead.

Assume 0 ≤ α ≤ 1.

Note that `scaled_mid(a, 0.5)` does not equal `mid(a)` for unbounded set-based
intervals.
"""
function scaled_mid(a::BareInterval{T}, α) where {T<:NumTypes}
    0 ≤ α ≤ 1 || return throw(DomainError(α, "scaled_mid requires 0 ≤ α ≤ 1"))
    isempty_interval(a) && return convert(T, NaN)

    lo = (inf(a) == typemin(T) ? nextfloat(inf(a)) : inf(a))
    hi = (sup(a) == typemax(T) ? prevfloat(sup(a)) : sup(a))

    β = convert(T, α)

    midpoint = β * (hi - lo) + lo
    isfinite(midpoint) && return midpoint
    # Fallback in case of overflow: hi - lo == +∞.
    # This case can not be the default one as it does not pass several
    # IEEE1788-2015 tests for small floats.
    return (1 - β) * lo + β * hi
end

"""
    diam(a::Interval)

Return the diameter (length) of the interval `a`.

Implement the `wid` function of the IEEE Standard 1788-2015 (Table 9.2).
"""
function diam(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return convert(T, NaN)
    return -(sup(a), inf(a), RoundUp)  # IEEE1788 section 12.12.8
end

"""
    radius(a::Interval)

Return the radius of the interval `a`, such that `a ⊆ m ± radius`, where
`m = mid(a)` is the midpoint.

Implement the `rad` function of the IEEE Standard 1788-2015 (Table 9.2).
"""
function radius(a::BareInterval)
    _, r = midradius(a)
    return r
end

"""
midradius(a::Interval)

Return the midpoint of an interval `a` together with its radius.

Function required by the IEEE Standard 1788-2015 in Section 10.5.9 for the
set-based flavor.
"""
function midradius(a::BareInterval{T}) where {T<:NumTypes}
    m = mid(a)
    return m, max(m - inf(a), sup(a) - m)
end

"""
    mag(a::Interval)

Magnitude of an interval. Return `NaN` for empty intervals.

Implement the `mag` function of the IEEE Standard 1788-2015 (Table 9.2).
"""
function mag(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return convert(T, NaN)
    return max(abs(inf(a)), abs(sup(a)))
end

"""
    mig(a::Interval)

Mignitude of an interval. Return `NaN` for empty intervals.

Implement the `mig` function of the IEEE Standard 1788-2015 (Table 9.2).
"""
function mig(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return convert(T, NaN)
    in_interval(0, a) && return zero(T)
    return min(abs(inf(a)), abs(sup(a)))
end

dist(a::BareInterval, b::BareInterval) = max(abs(inf(a)-inf(b)), abs(sup(a)-sup(b)))



# decorated intervals

# `inf`, `sup` and `bounds` must return `NaN` for NaI, cf. Section 12.12.8

function inf(a::Interval{T}) where {T<:AbstractFloat}
    isnai(a) && return convert(T, NaN)
    return inf(bareinterval(a))
end
inf(a::Interval{<:Rational}) = inf(bareinterval(a))

function sup(a::Interval{T}) where {T<:AbstractFloat}
    isnai(a) && return convert(T, NaN)
    return sup(bareinterval(a))
end
sup(a::Interval{<:Rational}) = sup(bareinterval(a))

function bounds(a::Interval{T}) where {T<:AbstractFloat}
    isnai(a) && return (convert(T, NaN), convert(T, NaN))
    return bounds(bareinterval(a))
end
bounds(x::Interval{<:Rational}) = bounds(bareinterval(x))

for f ∈ (:mid, :diam, :radius, :midradius, :mag, :mig)
    @eval $f(x::Interval)= $f(bareinterval(x))
end

scaled_mid(x::Interval, α) = scaled_mid(bareinterval(x), α)

dist(x::Interval, y::Interval) = dist(bareinterval(x), bareinterval(y))



# extension

inf(x::Real) = x

sup(x::Real) = x

bounds(x::Real) = (x, x)

mid(x::Real) = x
mid(z::Complex) = complex(mid(real(z)), mid(imag(z)))

diam(x::Real) = zero(x)
diam(z::Complex) = max(diam(real(z)), diam(imag(z)))

radius(x::Real) = zero(x)
radius(z::Complex) = max(radius(real(z)), radius(imag(z)))

midradius(x::Real) = (mid(x), radius(x))
midradius(z::Complex) = (mid(z), radius(z))

mag(x::Real) = abs(x)
mag(z::Complex) = sup(abs(z))

mig(x::Real) = abs(x)
mig(z::Complex) = inf(abs(z))
