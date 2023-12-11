# This file contains the functions described as "Numeric functions" in Section
# 9.4 of the IEEE Std 1788-2015 and required for set-based flavor in Section
# 10.5.9
# See also Section 12.12.8

"""
    inf(x)

Lower bound, or infimum, of `x`. For a zero `AbstractFloat` lower bound, a
negative zero is returned.

Implement the `inf` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`sup`](@ref), [`bounds`](@ref), [`mid`](@ref), [`diam`](@ref),
[`radius`](@ref) and [`midradius`](@ref).
"""
inf(x::BareInterval{T}) where {T<:AbstractFloat} = ifelse(isnan(x.lo), typemax(T), ifelse(iszero(x.lo), copysign(x.lo, -1), x.lo))
inf(x::BareInterval{<:Rational}) = x.lo

function inf(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return inf(bareinterval(x))
end
function inf(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the infimum of an NaI; cannot return a `Rational` NaN"))
    return inf(bareinterval(x))
end

inf(x::Real) = inf(interval(x))

"""
    sup(x)

Upper bound, or supremum, of `x`.

Implement the `sup` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`inf`](@ref), [`bounds`](@ref), [`mid`](@ref), [`diam`](@ref),
[`radius`](@ref) and [`midradius`](@ref).
"""
sup(x::BareInterval{T}) where {T<:AbstractFloat} = ifelse(isnan(x.hi), typemin(T), x.hi)
sup(x::BareInterval{<:Rational}) = x.hi

function sup(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return sup(bareinterval(x))
end
function sup(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the supremum of an NaI; cannot return a `Rational` NaN"))
    return sup(bareinterval(x))
end

sup(x::Real) = sup(interval(x))

"""
    bounds(x)

Bounds of `x` given as a tuple. Unlike [`inf`](@ref), this function does
not normalize the infimum of the interval.

See also: [`inf`](@ref), [`sup`](@ref), [`mid`](@ref), [`diam`](@ref),
[`radius`](@ref) and [`midradius`](@ref).
"""
bounds(x::BareInterval{T}) where {T<:AbstractFloat} = (ifelse(isnan(x.lo), typemax(T), x.lo), x.hi)
bounds(x::BareInterval{<:Rational}) = (inf(x), sup(x))

function bounds(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return (convert(T, NaN), convert(T, NaN))
    return bounds(bareinterval(x))
end
function bounds(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the bounds of an NaI; cannot return a `Rational` NaN"))
    return bounds(bareinterval(x))
end

bounds(x::Real) = bounds(interval(x))

"""
    mid(x)

Midpoint of `x`.

Implement the `mid` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`inf`](@ref), [`sup`](@ref), [`bounds`](@ref), [`diam`](@ref),
[`radius`](@ref) and [`midradius`](@ref).
"""
function mid(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return convert(T, NaN)
    isentire_interval(x) && return zero(T)
    lo, hi = bounds(x)
    lo == typemin(T) && return nextfloat(lo) # cf. Section 12.12.8
    hi == typemax(T) && return prevfloat(hi) # cf. Section 12.12.8
    midpoint = (lo + hi) / 2
    isfinite(midpoint) && return _normalisezero(midpoint)
    # fallback in case of overflow
    # cannot be the default, since it does not pass several IEEE 1788-2015 tests for small floats
    return _normalisezero(lo / 2 + hi / 2)
end
function mid(x::BareInterval{T}) where {T<:Rational}
    isempty_interval(x) && return throw(ArgumentError("cannot compute the midpoint of empty intervals; cannot return a `Rational` NaN"))
    isentire_interval(x) && return zero(T)
    lo, hi = bounds(x)
    lo == typemin(T) && return nextfloat(lo) # cf. Section 12.12.8
    hi == typemax(T) && return prevfloat(hi) # cf. Section 12.12.8
    midpoint = (lo + hi) / 2
    isfinite(midpoint) && return _normalisezero(midpoint)
    # fallback in case of overflow
    # cannot be the default, since it does not pass several IEEE 1788-2015 tests for small floats
    return _normalisezero(lo / 2 + hi / 2)
end

function mid(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return mid(bareinterval(x))
end
function mid(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the midpoint of an NaI; cannot return a `Rational` NaN"))
    return mid(bareinterval(x))
end

mid(x::Real) = mid(interval(x))
mid(x::Complex) = complex(mid(real(x)), mid(imag(x)))

"""
    diam(x)

Diameter of `x`. If `x` is complex, then the diameter is the maximum diameter
between its real and imaginary parts.

Implement the `wid` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`inf`](@ref), [`sup`](@ref), [`bounds`](@ref), [`mid`](@ref),
[`radius`](@ref) and [`midradius`](@ref).
"""
function diam(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return convert(T, NaN)
    return _sub_round(sup(x), inf(x), RoundUp) # cf. Section 12.12.8
end
function diam(x::BareInterval{<:Rational})
    isempty_interval(x) && return throw(ArgumentError("cannot compute the diameter of empty intervals; cannot return a `Rational` NaN"))
    return _sub_round(sup(x), inf(x), RoundUp) # cf. Section 12.12.8
end

function diam(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return diam(bareinterval(x))
end
function diam(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the diameter of an NaI; cannot return a `Rational` NaN"))
    return diam(bareinterval(x))
end

diam(x::Real) = diam(interval(x))
diam(x::Complex) = max(diam(real(x)), diam(imag(x)))

"""
    radius(x)

Radius of `x`, such that `issubset_interval(x, mid(x) ± radius(x))`. If `x` is
complex, then the radius is the maximum radius between its real and imaginary
parts.

Implement the `rad` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`inf`](@ref), [`sup`](@ref), [`bounds`](@ref), [`mid`](@ref),
[`diam`](@ref) and [`midradius`](@ref).
"""
function radius(x::BareInterval)
    _, r = midradius(x)
    return r
end

function radius(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return radius(bareinterval(x))
end
function radius(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the radius of an NaI; cannot return a `Rational` NaN"))
    return radius(bareinterval(x))
end

radius(x::Real) = radius(interval(x))
radius(x::Complex) = max(radius(real(x)), radius(imag(x)))

"""
    midradius(x)

Midpoint and radius of `x`.

Function required by the IEEE Standard 1788-2015 in Section 10.5.9 for the
set-based flavor.

See also: [`inf`](@ref), [`sup`](@ref), [`bounds`](@ref), [`mid`](@ref),
[`mid`](@ref) and [`radius`](@ref).
"""
function midradius(x::BareInterval)
    m = mid(x)
    return m, max(m - inf(x), sup(x) - m)
end

function midradius(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return (convert(T, NaN), convert(T, NaN))
    return midradius(bareinterval(x))
end
function midradius(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the midpoint and radius of an NaI; cannot return a `Rational` NaN"))
    return midradius(bareinterval(x))
end

midradius(x::Real) = midradius(interval(x))
midradius(x::Complex) = (mid(x), radius(x))

"""
    mag(x)

Magnitude of `x`.

Implement the `mag` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`mig`](@ref).
"""
function mag(x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) && return convert(T, NaN)
    return max(abs(inf(x)), abs(sup(x)))
end
function mag(x::BareInterval{<:Rational})
    isempty_interval(x) && return throw(ArgumentError("cannot compute the magnitude of empty intervals; cannot return a `Rational` NaN"))
    return max(abs(inf(x)), abs(sup(x)))
end

function mag(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return mag(bareinterval(x))
end
function mag(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the magnitude of an NaI; cannot return a `Rational` NaN"))
    return mag(bareinterval(x))
end

mag(x::Real) = mag(interval(x))
mag(x::Complex) = max(mag(real(x)), mag(imag(x)))

"""
    mig(x)

Mignitude of `x`.

Implement the `mig` function of the IEEE Standard 1788-2015 (Table 9.2).

See also: [`mag`](@ref).
"""
function mig(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return convert(T, NaN)
    in_interval(0, x) && return zero(T)
    return min(abs(inf(x)), abs(sup(x)))
end
function mig(x::BareInterval{T}) where {T<:Rational}
    isempty_interval(x) && return throw(ArgumentError("cannot compute the mignitude of empty intervals; cannot return a `Rational` NaN"))
    in_interval(0, x) && return zero(T)
    return min(abs(inf(x)), abs(sup(x)))
end

function mig(x::Interval{T}) where {T<:AbstractFloat}
    isnai(x) && return convert(T, NaN)
    return mig(bareinterval(x))
end
function mig(x::Interval{<:Rational})
    isnai(x) && return throw(ArgumentError("cannot compute the mignitude of an NaI; cannot return a `Rational` NaN"))
    return mig(bareinterval(x))
end

mig(x::Real) = mig(interval(x))
mig(x::Complex) = min(mig(real(x)), mig(imag(x)))

"""
    dist(x, y)

Distance between `x` and `y`.
"""
function dist(x::BareInterval{T}, y::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(x) | isempty_interval(y) && return convert(T, NaN)
    return max(abs(inf(x) - inf(y)), abs(sup(x) - sup(y)))
end
function dist(x::BareInterval{T}, y::BareInterval{T}) where {T<:Rational}
    isempty_interval(x) | isempty_interval(y) && return throw(ArgumentError("cannot compute the distance of empty intervals; cannot return a `Rational` NaN"))
    return max(abs(inf(x) - inf(y)), abs(sup(x) - sup(y)))
end
dist(x::BareInterval, y::BareInterval) = dist(promote(x, y)...)

function dist(x::Interval{T}, y::Interval{T}) where {T<:AbstractFloat}
    isnai(x) | isnai(y) && return convert(T, NaN)
    return dist(bareinterval(x), bareinterval(y))
end
function dist(x::Interval{T}, y::Interval{T}) where {T<:Rational}
    isnai(x) | isnai(y) && return throw(ArgumentError("cannot compute the distance of an NaI; cannot return a `Rational` NaN"))
    return dist(bareinterval(x), bareinterval(y))
end
dist(x::Interval, y::Interval) = dist(promote(x, y)...)
