# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""An `IntervalBox` is an `N`-dimensional rectangular box, given
by a Cartesian product of `N` `Interval`s.
"""
struct IntervalBox{N,T} <: StaticVector{N, Interval{T}}
    data::NTuple{N,Interval{T}}
end

# StaticArrays.Size{N,T}(::Type{IntervalBox{N,T}}) = StaticArrays.Size(N) # @pure not needed, I think...
Base.@propagate_inbounds Base.getindex(a::IntervalBox, i::Int) = a.data[i]


IntervalBox(x::Interval) = IntervalBox( (x,) )  # single interval treated as tuple with one element


## arithmetic operations
# Note that standard arithmetic operations are implemented automatically by FixedSizeArrays.jl
"""
    mid(X::IntervalBox, α=0.5)

Return a vector of the `mid` of each interval composing the `IntervalBox`.

See `mid(X::Interval, α=0.5)` for more informations.
"""
mid(X::IntervalBox{T}, α) where T = mid.(X, α)
mid(X::IntervalBox{T}) where T = mid.(X)


## set operations

# TODO: Update to use generator
⊆(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} =
    all(X .⊆ Y)

∩(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} =
    IntervalBox(X .∩ Y)
∪(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} =
    IntervalBox(X .∪ Y)

#=
On Julia 0.6 can now write
∩{N,T}(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) = IntervalBox(NTuple{N, Interval{Float64}}( (X[i] ∩ Y[i]) for i in 1:N))
=#


isempty(X::IntervalBox) = any(isempty, X)

diam(X::IntervalBox) = maximum(diam.(X))

emptyinterval(X::IntervalBox{N,T}) where {N,T} = IntervalBox(emptyinterval.(X))


import Base.×
×(a::Interval...) = IntervalBox(a...)
×(a::Interval, b::IntervalBox) = IntervalBox(a, b...)
×(a::IntervalBox, b::Interval) = IntervalBox(a..., b)
×(a::IntervalBox, b::IntervalBox) = IntervalBox(a..., b...)

IntervalBox(x::Interval, ::Type{Val{n}}) where {n} = IntervalBox(SVector(ntuple(i->x, Val{n})))

IntervalBox(x::Interval, n::Int) = IntervalBox(x, Val{n})
