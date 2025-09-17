# This file contains the constants described in Section 10.5.2 of the
# IEEE Standard 1788-2015

"""
    emptyinterval(T=[default_numtype()])

Create an empty interval. This interval is an exception to the fact that the
lower bound is larger than the upper one.

Implement the `empty` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
emptyinterval(::Type{BareInterval{T}}) where {T<:AbstractFloat} = _unsafe_bareinterval(T, convert(T, NaN), convert(T, NaN))
# note: `using Base.unsafe_rational(Int, 0, 0)` as an equivalent to `NaN` for `Rational`
# does not work well since most codes for `Rational` assume that the denominator cannot be zero
# e.g. `iszero(Base.unsafe_rational(Int, 0, 0)) == true`
emptyinterval(::Type{BareInterval{T}}) where {T<:Rational} = _unsafe_bareinterval(T, typemax(T), typemin(T))
emptyinterval(::BareInterval{T}) where {T<:NumTypes} = emptyinterval(BareInterval{T})

emptyinterval(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(emptyinterval(BareInterval{T}), trv, true)
emptyinterval(x::Interval{T}) where {T} = _unsafe_interval(emptyinterval(BareInterval{T}), trv, isguaranteed(x))

emptyinterval(::Type{Complex{T}}) where {T<:Interval} = complex(emptyinterval(T), emptyinterval(T))
emptyinterval(x::Complex{<:Interval}) = complex(emptyinterval(real(x)), emptyinterval(imag(x)))

emptyinterval(::Type{T}) where {T<:NumTypes} = emptyinterval(Interval{T})
emptyinterval(::T) where {T<:NumTypes} = emptyinterval(T)

emptyinterval(::Type{Complex{T}}) where {T<:NumTypes} = complex(emptyinterval(T), emptyinterval(T))
emptyinterval(::Complex{T}) where {T<:NumTypes} = emptyinterval(Complex{T})

emptyinterval() = emptyinterval(Interval{default_numtype()})

"""
    entireinterval(T=[default_numtype()])

Create an interval representing the entire real line, or the entire complex
plane if `T` is complex.

!!! note
    Depending on the flavor, infinity may or may not be considered part of the
    interval.

Implement the `entire` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
entireinterval(::Type{BareInterval{T}}) where {T<:NumTypes} = _unsafe_bareinterval(T, typemin(T), typemax(T))
entireinterval(::BareInterval{T}) where {T<:NumTypes} = entireinterval(BareInterval{T})

entireinterval(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(entireinterval(BareInterval{T}), dac, true)
entireinterval(x::Interval{T}) where {T} = _unsafe_interval(entireinterval(BareInterval{T}), dac, isguaranteed(x))

entireinterval(::Type{Complex{T}}) where {T<:Interval} = complex(entireinterval(T), entireinterval(T))
entireinterval(x::Complex{<:Interval}) = complex(entireinterval(real(x)), entireinterval(imag(x)))

entireinterval(::Type{T}) where {T<:NumTypes} = entireinterval(Interval{T})
entireinterval(::T) where {T<:NumTypes} = entireinterval(T)

entireinterval(::Type{Complex{T}}) where {T<:NumTypes} = complex(entireinterval(T), entireinterval(T))
entireinterval(::Complex{T}) where {T<:NumTypes} = entireinterval(Complex{T})

entireinterval() = entireinterval(Interval{default_numtype()})

"""
    nai(T=[default_numtype()])

Create an NaI (Not an Interval).
"""
nai(::Type{Interval{T}}) where {T<:NumTypes} = _unsafe_interval(emptyinterval(BareInterval{T}), ill, true)
nai(x::Interval{T}) where {T} = _unsafe_interval(emptyinterval(BareInterval{T}), ill, isguaranteed(x))

nai(::Type{Complex{T}}) where {T<:Interval} = complex(nai(T), nai(T))
nai(x::Complex{<:Interval}) = complex(nai(real(x)), nai(imag(x)))

nai(::Type{T}) where {T<:NumTypes} = nai(Interval{T})
nai(::T) where {T<:NumTypes} = nai(T)

nai(::Type{Complex{T}}) where {T<:NumTypes} = complex(nai(T), nai(T))
nai(::Complex{T}) where {T<:NumTypes} = nai(Complex{T})

nai() = nai(Interval{default_numtype()})
