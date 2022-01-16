# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the constants described in sections 10.5.2 of the
    IEEE Std 1788-2015.
=#

"""
    `emptyinterval()`

`emptyinterval`s are represented as the interval [∞, -∞]; note
that this interval is an exception to the fact that the lower bound is
larger than the upper one.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval bound type is used.

Implement the `empty` function of the IEEE Std 1788-2015 (section 10.5.2).
"""
emptyinterval(::Type{F}) where {F<:Interval} = F(Inf, -Inf)
emptyinterval(::F) where {F<:Interval} = emptyinterval(F)
emptyinterval(::Type{Complex{F}}) where {F<:Interval} = complex(emptyinterval(F), emptyinterval(F))

# TODO Here the restriction should be any allowed bound type. Using
# AbstractFloat for simplicity for now
emptyinterval(::Type{T}) where {T<:AbstractFloat} = emptyinterval(Interval{T})
emptyinterval(::Type{<:Real}) = emptyinterval(default_bound())
emptyinterval() = emptyinterval(default_bound())


"""
    entireinterval()

`RR` represent the entire real line [-Inf, Inf].

Depending on the flavor, `-Inf` and `Inf` may or may not be considerd inside this
interval.

Note that if the type of the returned interval can not be inferred from the
argument given, the default interval flavor will be used. See the documentation
of `Interval` for more information about the default interval falvor.

Implement the `entire` function of the IEEE Std 1788-2015 (section 10.5.2).
"""
entireinterval(::Type{F}) where {T, F<:Interval{T}} = F(-Inf, Inf)
entireinterval(::F) where {F<:Interval} = entireinterval(F)
entireinterval(::Type{T}) where T = Interval{T}(-Inf, Inf)
entireinterval() = entireinterval(default_bound())
