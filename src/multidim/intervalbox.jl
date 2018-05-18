# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""An `IntervalBox` is an `N`-dimensional rectangular box, given
by a Cartesian product of a vector of `N` `Interval`s.
"""
struct IntervalBox{N,T}
    v::SVector{N, Interval{T}}
end

# IntervalBox(x::Interval) = IntervalBox( SVector(x) )  # single interval treated as tuple with one element

IntervalBox(x::Interval...) = IntervalBox(SVector(x))
IntervalBox(x::Tuple{T}) where {T<:Interval} = IntervalBox(SVector(x))

@propagate_inbounds Base.getindex(X::IntervalBox, i) = X.v[i]

Base.setindex(X::IntervalBox, y, i) = IntervalBox( setindex(X.v, y, i) )

## arithmetic operations
# Note that standard arithmetic operations are implemented automatically by FixedSizeArrays.jl

mid(X::IntervalBox) = mid.(X.v)


## set operations

# TODO: Update to use generator
⊆(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} =
    all(X.v .⊆ Y.v)

∩(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} =
    IntervalBox(X.v .∩ Y.v)
∪(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} =
    IntervalBox(X.v .∪ Y.v)

#=
On Julia 0.6 can now write
∩{N,T}(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) = IntervalBox(NTuple{N, Interval{Float64}}( (X[i] ∩ Y[i]) for i in 1:N))
=#


isempty(X::IntervalBox) = any(isempty, X.v)

diam(X::IntervalBox) = maximum(diam.(X.v))

emptyinterval(X::IntervalBox{N,T}) where {N,T} = IntervalBox(emptyinterval.(X.v))


import Base.×
×(a::Interval...) = IntervalBox(a...)
×(a::Interval, b::IntervalBox) = IntervalBox(a, b.v...)
×(a::IntervalBox, b::Interval) = IntervalBox(a.v..., b)
×(a::IntervalBox, b::IntervalBox) = IntervalBox(a.v..., b.v...)

IntervalBox(x::Interval, ::Type{Val{n}}) where {n} = IntervalBox(SVector(ntuple(i->x, Val{n})))

IntervalBox(x::Interval, n::Int) = IntervalBox(x, Val{n})

dot(x::IntervalBox, y::IntervalBox) = dot(x.v, y.v)
length(x::IntervalBox) = length(x.v)
