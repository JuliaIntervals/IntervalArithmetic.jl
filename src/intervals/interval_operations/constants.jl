# This file contains the constants described in Section 10.5.2 of the
# IEEE Standard 1788-2015

"""
    emptyinterval

`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval bound type is used.

Implement the `empty` function of the IEEE Standard 1788-2015 (Section 10.5.2).
"""
emptyinterval(::Type{Interval{T}}) where {T<:NumTypes} = unsafe_interval(T, typemax(T), typemin(T))
emptyinterval(::Type{T}) where {T<:NumTypes} = emptyinterval(Interval{T})
emptyinterval(::Type{<:Real}) = emptyinterval(default_numtype())
emptyinterval() = emptyinterval(default_numtype())
emptyinterval(::Type{Complex{T}}) where {T<:Real} = complex(emptyinterval(T), emptyinterval(T))
emptyinterval(::T) where {T} = emptyinterval(T)


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
entireinterval(::Type{Interval{T}}) where {T<:NumTypes} = unsafe_interval(T, typemin(T), typemax(T))
entireinterval(::Type{T}) where {T<:NumTypes} = entireinterval(Interval{T})
entireinterval(::Type{<:Real}) = entireinterval(default_numtype())
entireinterval() = entireinterval(default_numtype())
entireinterval(::Type{Complex{T}}) where {T<:Real} = complex(entireinterval(T), entireinterval(T))
entireinterval(::T) where {T} = entireinterval(T)
