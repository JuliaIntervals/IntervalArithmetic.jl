# This file contains the functions described as "Boolean functions of intervals"
# in Section 9.5 of the IEEE Standard 1788-2015 and required for set-based
# flavor in Section 10.5.9
# Some other (non required) related functions are also present, as well as some
# of the "Recommended operations" (Section 10.6.3)
# The requirement for decorated intervals are described in Chapter 12,
# mostly sections 12.12.9 and 12.13.3.

# used internally, equivalent to `<` but with `(Inf < Inf) == true`
_strictlessprime(x::Real, y::Real) = (x < y) | ((isinf(x) | isinf(y)) & (x == y))

"""
    isequal_interval(x, y)

Test whether `x` and `y` are identical.

Implement the `equal` function of the IEEE Standard 1788-2015
(Tables 9.3 and 10.3, and Sections 9.5, 10.5.10 and 12.12.9).
"""
isequal_interval(x::BareInterval, y::BareInterval) = (inf(x) == inf(y)) & (sup(x) == sup(y))

function isequal_interval(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isequal_interval(bareinterval(x), bareinterval(y))
end
isequal_interval(x::Complex{<:Interval}, y::Complex{<:Interval}) = isequal_interval(real(x), real(y)) & isequal_interval(imag(x), imag(y))
isequal_interval(x::Complex{<:Interval}, y::Interval) = isequal_interval(real(x), y) & isthinzero(imag(x))
isequal_interval(x::Interval, y::Complex{<:Interval}) = isequal_interval(x, real(y)) & isthinzero(imag(y))

function isequal_interval(x::AbstractVector, y::AbstractVector)
    n = length(x)
    m = length(y)
    n == m || return throw(DimensionMismatch("dimensions must match: x has length $n, y has length $m"))
    return all(t -> isequal_interval(t[1], t[2]), zip(x, y))
end

isequal_interval(x, y, z, w...) = isequal_interval(x, y) & isequal_interval(y, z, w...)

isequal_interval(x) = Base.Fix2(isequal_interval, x)

"""
    issetequal_interval(x, y)

Return whether the two interval are identical when considered as sets.

Alias of the [`isequal_interval`](@ref) function.
"""
const issetequal_interval = isequal_interval

"""
    issubset_interval(x, y)

Test whether `x` is contained in `y`.

Implement the `subset` function of the IEEE Standard 1788-2015
(Tables 9.3 and 10.3, and Sections 9.5, 10.5.10 and 12.12.9).

See also: [`isstrictsubset`](@ref) and [`isinterior`](@ref).
"""
issubset_interval(x::BareInterval, y::BareInterval) = (inf(y) ≤ inf(x)) & (sup(x) ≤ sup(y))

function issubset_interval(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return issubset_interval(bareinterval(x), bareinterval(y))
end
issubset_interval(x::Complex{<:Interval}, y::Complex{<:Interval}) = issubset_interval(real(x), real(y)) & issubset_interval(imag(x), imag(y))
issubset_interval(x::Complex{<:Interval}, y::Interval) = issubset_interval(real(x), y) & isthinzero(imag(x))
issubset_interval(x::Interval, y::Complex{<:Interval}) = issubset_interval(x, real(y)) & in_interval(0, imag(y))

function issubset_interval(x::AbstractVector, y::AbstractVector)
    n = length(x)
    m = length(y)
    n == m || return throw(DimensionMismatch("dimensions must match: x has length $n, y has length $m"))
    return all(t -> issubset_interval(t[1], t[2]), zip(x, y))
end

issubset_interval(x, y, z, w...) = issubset_interval(x, y) & issubset_interval(y, z, w...)

"""
    isstrictsubset(x, y)

Test whether `x` is a subset of, but not equal to, `y`. If `x` and `y` are
vectors, `x` must be a subset of `y` with at least one of their component being
a strict subset.

See also: [`issubset_interval`](@ref) and [`isinterior`](@ref).
"""
isstrictsubset(x::BareInterval, y::BareInterval) = issubset_interval(x, y) & !isequal_interval(x, y)

isstrictsubset(x::Interval, y::Interval) = issubset_interval(x, y) & !isequal_interval(x, y)
isstrictsubset(x::Complex{<:Interval}, y::Complex{<:Interval}) =
    (isstrictsubset(real(x), real(y)) & issubset_interval(imag(x), imag(y))) | (issubset_interval(real(x), real(y)) & isstrictsubset(imag(x), imag(y)))
isstrictsubset(x::Complex{<:Interval}, y::Interval) = isstrictsubset(real(x), y) & isthinzero(imag(x))
isstrictsubset(x::Interval, y::Complex{<:Interval}) = isstrictsubset(x, real(y)) & in_interval(0, imag(y))

isstrictsubset(x::AbstractVector, y::AbstractVector) = issubset_interval(x, y) & any(t -> isstrictsubset(t[1], t[2]), zip(x, y))

isstrictsubset(x, y, z, w...) = isstrictsubset(x, y) & isstrictsubset(y, z, w...)

isstrictsubset(x) = Base.Fix2(isstrictsubset, x)

"""
    isinterior(x, y)

Test whether `x` is in the interior of `y`.

Implement the `interior` function of the IEEE Standard 1788-2015
(Tables 9.3 and 10.3, and Sections 9.5, 10.5.10 and 12.12.9).

See also: [`issubset_interval`](@ref) and [`isstrictsubset`](@ref).
"""
isinterior(x::BareInterval, y::BareInterval) =
    _strictlessprime(inf(y), inf(x)) & _strictlessprime(sup(x), sup(y))

function isinterior(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isinterior(bareinterval(x), bareinterval(y))
end
isinterior(x::Complex{<:Interval}, y::Complex{<:Interval}) = isinterior(real(x), real(y)) & isinterior(imag(x), imag(y))
isinterior(::Complex{<:Interval}, ::Interval) = false
isinterior(x::Interval, y::Complex{<:Interval}) = isinterior(x, real(y)) & isinterior(zero(x), imag(y))

function isinterior(x::AbstractVector, y::AbstractVector)
    n = length(x)
    m = length(y)
    n == m || return throw(DimensionMismatch("dimensions must match: x has length $n, y has length $m"))
    return all(t -> isinterior(t[1], t[2]), zip(x, y))
end

isinterior(x, y, z, w...) = isinterior(x, y) & isinterior(y, z, w...)

"""
    isdisjoint_interval(x, y, z...)

Test whether the given intervals have no common elements.

Implement the `disjoint` function of the IEEE Standard 1788-2015.
(Tables 9.3 and 10.3, and Sections 9.5, 10.5.10 and 12.12.9).
"""
isdisjoint_interval(x::BareInterval, y::BareInterval) =
    isempty_interval(x) | isempty_interval(y) | _strictlessprime(sup(y), inf(x)) | _strictlessprime(sup(x), inf(y))

function isdisjoint_interval(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isdisjoint_interval(bareinterval(x), bareinterval(y))
end
isdisjoint_interval(x::Complex{<:Interval}, y::Complex{<:Interval}) = isdisjoint_interval(real(x), real(y)) | isdisjoint_interval(imag(x), imag(y))
isdisjoint_interval(x::Complex{<:Interval}, y::Interval) = isdisjoint_interval(real(x), y) | !in_interval(0, imag(x))
isdisjoint_interval(x::Interval, y::Complex{<:Interval}) = isdisjoint_interval(x, real(y)) | !in_interval(0, imag(y))

function isdisjoint_interval(x::AbstractVector, y::AbstractVector)
    n = length(x)
    m = length(y)
    n == m || return throw(DimensionMismatch("dimensions must match: x has length $n, y has length $m"))
    return any(t -> isdisjoint_interval(t[1], t[2]), zip(x, y))
end

isdisjoint_interval(x, y, z, w...) = _isdisjoint_interval(x, y, z, w...)

_isdisjoint_interval(x) = true
_isdisjoint_interval(x, y) = isdisjoint_interval(x, y)
_isdisjoint_interval(x, y, z, w...) = _isdisjoint_interval(x, y) && _isdisjoint_interval(x, z) && _isdisjoint_interval(x, w...) && _isdisjoint_interval(y, z, w...)

"""
    isweakless(x, y)

Test whether `inf(x) ≤ inf(y)` and `sup(x) ≤ sup(y)`, where `<` is replaced by
`≤` for infinite values.

Implement the `less` function of the IEEE Standard 1788-2015
(Table 10.3, and Sections 10.5.10 and 12.12.9).
"""
isweakless(x::BareInterval, y::BareInterval) = (inf(x) ≤ inf(y)) & (sup(x) ≤ sup(y))

function isweakless(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isweakless(bareinterval(x), bareinterval(y))
end

"""
    isstrictless(x, y)

Test whether `inf(x) < inf(y)` and `sup(x) < sup(y)`, where `<` is replaced by
`≤` for infinite values.

Implement the `strictLess` function of the IEEE Standard 1788-2015
(Table 10.3, and Sections 10.5.10 and 12.12.9).
"""
isstrictless(x::BareInterval, y::BareInterval) = # this may be flavor dependent? Should _strictlessprime be < for cset flavor?
    _strictlessprime(inf(x), inf(y)) & _strictlessprime(sup(x), sup(y))

function isstrictless(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return isstrictless(bareinterval(x), bareinterval(y))
end

"""
    precedes(x, y)

Test whether any element of `x` is lesser or equal to every elements of `y`.

Implement the `precedes` function of the IEEE Standard 1788-2015
(Table 10.3, and Sections 10.5.10 and 12.12.9).
"""
precedes(x::BareInterval, y::BareInterval) = sup(x) ≤ inf(y)

function precedes(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return precedes(bareinterval(x), bareinterval(y))
end

"""
    strictprecedes(x, y)

Test whether any element of `x` is strictly lesser than every elements of `y`.

Implement the `strictPrecedes` function of the IEEE Standard 1788-2015
(Table 10.3, and Sections 10.5.10 and 12.12.9).
"""
strictprecedes(x::BareInterval, y::BareInterval) = isempty_interval(x) | isempty_interval(y) | (sup(x) < inf(y))

function strictprecedes(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return false
    return strictprecedes(bareinterval(x), bareinterval(y))
end

"""
    in_interval(x, y)

Test whether `x` is an element of `y`.

Implement the `isMember` function of the IEEE Standard 1788-2015
(Sections 10.6.3 and 12.13.3).
"""
function in_interval(x::Number, y::BareInterval)
    isinf(x) && return contains_infinity(y)
    return inf(y) ≤ x ≤ sup(y)
end
in_interval(x::Complex, y::BareInterval) = in_interval(real(x), y) & iszero(imag(x))
in_interval(x::Interval, y::BareInterval) = throw(MethodError(in_interval, (x, y)))
in_interval(::BareInterval, ::BareInterval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`"))

function in_interval(x::Number, y::Interval)
    isnai(y) && return false
    return in_interval(x, bareinterval(y))
end
in_interval(x::Number, y::Complex{<:Interval}) = in_interval(x, real(y)) & in_interval(0, imag(y))
in_interval(x::Complex, y::Complex{<:Interval}) = in_interval(real(x), real(y)) & in_interval(imag(x), imag(y))
in_interval(::Interval, ::Interval) =
    throw(ArgumentError("`in_interval` is purposely not supported for two interval arguments. See instead `issubset_interval`"))

in_interval(x) = Base.Fix2(in_interval, x)

"""
    isempty_interval(x)

Test whether `x` contains no elements.

Implement the `isEmpty` function of the IEEE Standard 1788-2015
(Sections 10.5.10 and 12.12.9).
"""
isempty_interval(x::BareInterval{T}) where {T<:NumTypes} = (inf(x) == typemax(T)) & (sup(x) == typemin(T))

function isempty_interval(x::Interval)
    isnai(x) && return false
    return isempty_interval(bareinterval(x))
end
isempty_interval(x::Complex{<:Interval}) = isempty_interval(real(x)) | isempty_interval(imag(x))

isempty_interval(x::AbstractVector) = any(isempty_interval, x)

"""
    isentire_interval(x)

Test whether `x` is the entire real line.

Implement the `isEntire` function of the IEEE Standard 1788-2015
(Sections 10.5.10 and 12.12.9).
"""
isentire_interval(x::BareInterval{T}) where {T<:NumTypes} = (inf(x) == typemin(T)) & (sup(x) == typemax(T))

function isentire_interval(x::Interval)
    isnai(x) && return false
    return isentire_interval(bareinterval(x))
end
isentire_interval(x::Complex{<:Interval}) = isentire_interval(real(x)) & isentire_interval(imag(x))

"""
    isnai(x)

Test whether `x` is an NaI (Not an Interval).

Implement the `isNaI` function of the IEEE Standard 1788-2015 (Section 12.12.9).
"""
isnai(::BareInterval) = false

isnai(x::Interval) = decoration(x) == ill
isnai(x::Complex{<:Interval}) = isnai(real(x)) & isnai(imag(x))

"""
    isbounded(x)

Test whether `x` is empty or has finite bounds.
"""
isbounded(x::BareInterval) = (isfinite(inf(x)) & isfinite(sup(x))) | isempty_interval(x)

function isbounded(x::Interval)
    isnai(x) && return false
    return isbounded(bareinterval(x))
end
isbounded(x::Complex{<:Interval}) = isbounded(real(x)) & isbounded(imag(x))

"""
    isunbounded(x)

Test whether `x` is not empty and has infinite bounds.
"""
isunbounded(x::BareInterval) = !isbounded(x)

function isunbounded(x::Interval)
    isnai(x) && return false
    return isunbounded(bareinterval(x))
end
isunbounded(x::Complex{<:Interval}) = isunbounded(real(x)) | isunbounded(imag(x))

"""
    iscommon(x)

Test whether `x` is not empty and bounded.

Implement the `isCommonInterval` function of the IEEE Standard 1788-2015
(Sections 10.6.3 and 12.13.3).

!!! note
    This does not take into consideration the decoration of the interval.
"""
iscommon(x::BareInterval) = !(isentire_interval(x) | isempty_interval(x) | isunbounded(x))

function iscommon(x::Interval)
    isnai(x) && return false
    return iscommon(bareinterval(x))
end
iscommon(x::Complex{<:Interval}) = iscommon(real(x)) & iscommon(imag(x))

"""
    isatomic(x)

Test whether `x` is unable to be split. This occurs if the interval is empty,
or if its lower and upper bounds are equal, or if the bounds are consecutive
floating-point numbers.
"""
isatomic(x::BareInterval{<:AbstractFloat}) = isempty_interval(x) | (inf(x) == sup(x)) | (sup(x) == nextfloat(inf(x)))
isatomic(x::BareInterval{<:Rational}) = isempty_interval(x) | (inf(x) == sup(x))

function isatomic(x::Interval)
    isnai(x) && return false
    return isatomic(bareinterval(x))
end
isatomic(x::Complex{<:Interval}) = isatomic(real(x)) & isatomic(imag(x))

"""
    isthin(x)

Test whether `x` contains only a real.

Implement the `isSingleton` function of the IEEE Standard 1788-2015
(Sections 10.6.3 and 12.13.3).
"""
isthin(x::BareInterval) = inf(x) == sup(x)

function isthin(x::Interval)
    isnai(x) && return false
    return isthin(bareinterval(x))
end
isthin(x::Complex{<:Interval}) = isthin(real(x)) & isthin(imag(x))

"""
    isthin(x, y)

Test whether `x` contains only `y`.
"""
isthin(x::BareInterval, y::Number) = inf(x) == sup(x) == y
isthin(x::BareInterval, y::Complex) = isthin(x, real(y)) & iszero(imag(y))
isthin(::BareInterval, ::Interval) =
    throw(ArgumentError("`isthin` is purposely not supported for intervals. See instead `isequal_interval`"))

function isthin(x::Interval, y::Number)
    isnai(x) && return false
    return isthin(bareinterval(x), y)
end
isthin(x::Complex{<:Interval}, y::Number) = isthin(real(x), y) & isthinzero(imag(x))
isthin(x::Complex{<:Interval}, y::Complex) = isthin(real(x), real(y)) & isthin(imag(x), imag(y))

"""
    isthinzero(x)

Test whether `x` contains only zero.
"""
isthinzero(x::BareInterval) = iszero(inf(x)) & iszero(sup(x))

function isthinzero(x::Interval)
    isnai(x) && return false
    return isthinzero(bareinterval(x))
end
isthinzero(x::Complex{<:Interval}) = isthinzero(real(x)) & isthinzero(imag(x))

"""
    isthinone(x)

Test whether `x` contains only one.
"""
isthinone(x::BareInterval) = isone(inf(x)) & isone(sup(x))

function isthinone(x::Interval)
    isnai(x) && return false
    return isthinone(bareinterval(x))
end
isthinone(x::Complex{<:Interval}) = isthinone(real(x)) & isthinzero(imag(x))

"""
    isthininteger(x)

Test whether `x` contains only an integer.
"""
isthininteger(x::BareInterval) = (inf(x) == sup(x)) & isinteger(inf(x))

function isthininteger(x::Interval)
    isnai(x) && return false
    return isthininteger(bareinterval(x))
end
isthininteger(x::Complex{<:Interval}) = isthininteger(real(x)) & isthinzero(imag(x))
