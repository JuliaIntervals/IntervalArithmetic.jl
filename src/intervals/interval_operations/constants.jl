# This file contains the constants described in Section 10.5.2 of the
# IEEE Standard 1788-2015

"""
    emptyinterval

Create an empty interval. This interval is an exception to the fact that the
lower bound is larger than the upper one.

Implement the `empty` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
emptyinterval(::Type{BareInterval{T}}) where {T<:AbstractFloat} = _unsafe_bareinterval(T, convert(T, NaN), convert(T, NaN))
emptyinterval(::Type{BareInterval{T}}) where {T<:Rational} = _unsafe_bareinterval(T, typemax(T), typemin(T))
# note: `using Base.unsafe_rational(Int, 0, 0)` as an equivalent to `NaN` for `Rational`
# does not work well since most codes for `Rational` assume that the denominator cannot be zero
# e.g. `iszero(Base.unsafe_rational(Int, 0, 0)) == true`

emptyinterval(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(emptyinterval(BareInterval{T}), trv, true)
emptyinterval(::Type{T}=default_numtype()) where {T<:NumTypes} = emptyinterval(Interval{T})
emptyinterval(::Type{Complex{T}}) where {T<:Real} = complex(emptyinterval(T), emptyinterval(T))
emptyinterval(::T) where {T} = emptyinterval(T)

"""
    entireinterval

Create an interval representing the entire real line. Depending on the flavor,
`-Inf` and `Inf` may or may not be considerd inside this interval.

Implement the `entire` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
entireinterval(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, typemin(T), typemax(T))

entireinterval(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(entireinterval(BareInterval{T}), dac, true)
entireinterval(::Type{T}=default_numtype()) where {T<:NumTypes} = entireinterval(Interval{T})
entireinterval(::Type{Complex{T}}) where {T<:Real} = complex(entireinterval(T), entireinterval(T))
entireinterval(::T) where {T} = entireinterval(T)

"""
    nai

Create an NaI.
"""
nai(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(emptyinterval(BareInterval{T}), ill, true)
nai(::Type{T}=default_numtype()) where {T<:NumTypes} = nai(Interval{T})
nai(::Type{Complex{T}}) where {T<:Real} = complex(nai(T), nai(T))
nai(::T) where {T} = nai(T)
