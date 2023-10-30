# This file contains the constants described in Section 10.5.2 of the
# IEEE Standard 1788-2015



# bare intervals

"""
    emptyinterval

`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval bound type is used.

Implement the `empty` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
emptyinterval(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, typemax(T), typemin(T))

"""
    entireinterval

`RR` represent the entire real line [-Inf, Inf].

Depending on the flavor, `-Inf` and `Inf` may or may not be considerd inside this
interval.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval flavor will be used. See the documentation
of `Interval` for more information about the default interval falvor.

Implement the `entire` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
entireinterval(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, typemin(T), typemax(T))



# decorated intervals

emptyinterval(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(emptyinterval(BareInterval{T}), trv)
emptyinterval(::Type{T}) where {T<:NumTypes} = emptyinterval(Interval{T})
emptyinterval() = emptyinterval(default_numtype())
emptyinterval(::Type{Complex{T}}) where {T<:Real} = complex(emptyinterval(T), emptyinterval(T))
emptyinterval(::T) where {T} = emptyinterval(T)

entireinterval(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(entireinterval(BareInterval{T}), dac)
entireinterval(::Type{T}) where {T<:NumTypes} = entireinterval(Interval{T})
entireinterval() = entireinterval(default_numtype())
entireinterval(::Type{Complex{T}}) where {T<:Real} = complex(entireinterval(T), entireinterval(T))
entireinterval(::T) where {T} = entireinterval(T)

nai(::Type{Interval{T}}) where {T<:AbstractFloat} = _unsafe_interval(_unsafe_bareinterval(T, convert(T, NaN), convert(T, NaN)), ill)
# nai(::Type{Interval{T}}) where {S<:Integer,T<:Rational{S}} = _unsafe_interval(_unsafe_bareinterval(T, Base.unsafe_rational(S, 0, 0), Base.unsafe_rational(S, 0, 0)), ill)
# this does not work well since most codes for `Rational` assume the denominator cannot be zero
# e.g. `iszero(Base.unsafe_rational(Int, 0, 0)) == true`
nai(::Type{Interval{T}}) where {T<:Rational} = _unsafe_interval(emptyinterval(BareInterval{T}), ill)
nai(::Type{T}) where {T<:NumTypes} = nai(Interval{T})
nai() = nai(default_numtype())
nai(::Type{Complex{T}}) where {T<:Real} = complex(nai(T), nai(T))
nai(::T) where {T} = nai(T)
