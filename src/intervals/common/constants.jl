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
argument given, the default interval flavor will be used. See the documentation
of `Interval` for more information about the default interval falvor.

Implement the `empty` function of the IEEE Std 1788-2015 (section 10.5.2).
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

Implement the `entire` function of the IEEE Std 1788-2015 (section 10.5.2).
"""
RR(::Type{F}) where {T, F <: AbstractFlavor{T}} = F(-Inf, Inf)
RR(::F) where {T, F <: AbstractFlavor{T}} = RR(F)

RR(::Type{T}) where T = Interval{T}(-Inf, Inf)
RR() = RR(Float64)

function entireinterval(args...)
    @warn "entireinterval is deprecated. Use RR or ℝ instead."
    return RR(args...)
end