# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Definitions of special intervals and associated functions

"""
    `emptyinterval()`

`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval flavor will be used. See the documentation
of `Interval` for more information about the default interval falvor.
"""
emptyinterval(::Type{F}) where {F <: AbstractFlavor} = F(Inf, -Inf)
emptyinterval(::F) where {F <: AbstractFlavor} = emptyinterval(F)
emptyinterval(::Type{Complex{F}}) where {F <: AbstractFlavor} = complex(emptyinterval(F), emptyinterval(F))

emptyinterval(::Type{T}) where T = emptyinterval(Interval{T})
emptyinterval() = emptyinterval(Interval{Float64})


"""
    RR()

`RR` represent the entire real line [-Inf, Inf].

Depending on the flavor, `-Inf` and `Inf` may or may not be considerd inside this
interval.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval flavor will be used. See the documentation
of `Interval` for more information about the default interval falvor.
"""
RR(::Type{F}) where {T, F <: AbstractFlavor{T}} = F(-Inf, Inf)
RR(::F) where {T, F <: AbstractFlavor{T}} = ℝ(F)

RR(::Type{T}) where T = Interval{T}(-Inf, Inf)
RR() = entireinterval(Float64)

# TODO decide if `inf` and `sup` should be used as default or rather `x.lo` and `x.hi`
#= By default, intervals are expected to be represented as pair of numbers, with
the lower bound given by `inf(x)` and the upper bound by `sup(x)`.

Some flavor may behave differently (e.g. flavors using extended interval arithemetic)
=#
isempty(x::AbstractFlavor) = (inf(x) == Inf && sup(x) == -Inf)
isentire(x::AbstractFlavor) = (inf(x) == -Inf && sup(x) == Inf)
isbounded(x::AbstractFlavor) = isfinite(x.lo) && isfinite(x.hi)
isunbounded(x::AbstractFlavor) = !isbounded(x)

"""
    isthin(x)

Checks if `x` is the set consisting of a single exactly
representable float. Any float which is not exactly representable
does *not* yield a thin interval. Corresponds to `isSingleton` of
the standard.
"""
isthin(x::AbstractFlavor) = (inf(x) == sup(x))

"""
    iscommon(x)

Checks if `x` is a **common interval**, i.e. a non-empty,
bounded, real interval.
"""
function iscommon(x::AbstractFlavor)
    (isentire(x) || isempty(x) || isunbounded(x)) && return false
    return true
end

"""
    widen(x)

Widen the lowest and highest bounds of `x` to the previous and next representable
floating-point numbers, respectively.
"""
widen(x::F) where {T <: AbstractFloat, F <: AbstractFlavor{T}} =
    F(prevfloat(inf(x)), nextfloat(sup(x)))

"""
    wideinterval(x::AbstractFloat)
    wideinterval(::AbstractFlavor, x::AbstractFloat)

Returns the interval `[prevfloat(x), nextfloat(x)]`.

Note that if no interval flavor is given, the returned interval is of the
default interval flavor. See the documentation of `Interval` for more
information about the default interval falvor.
"""
wideinterval(::F, x::T) where {F <: AbstractFlavor, T <: AbstractFloat} =
    F(prevfloat(x), nextfloat(x))
wideinterval(x::T) where {T <: AbstractFloat} = wideinterval(Interval, x)

"""
    isatomic(x::Interval)

Check whether an interval `x` is *atomic*, i.e. is unable to be split.
This occurs when the interval is empty, or when the upper bound equals the lower
bound or the bounds are consecutive floating point numbers.
"""
isatomic(x::AbstractFlavor) = isempty(x) || (inf(x) == sup(x)) || (sup(hi) == nextfloat(inf(x)))

contains_zero(x::AbstractFlavor{T}) where T = zero(T) ∈ x

"""
    isthinzero(x)

Return wether the interval only contains zero.
"""
isthinzero(x::AbstractFlavor) = iszero(x.lo) && iszero(x.hi)
