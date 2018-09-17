# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""An `IntervalBox` is an `N`-dimensional rectangular box, given
by a Cartesian product of a vector of `N` `Interval`s.
"""
struct IntervalBox{N,T}
    v::SVector{N, Interval{T}}
end

# IntervalBox(x::Interval) = IntervalBox( SVector(x) )  # single interval treated as tuple with one element

IntervalBox(x::Interval...) = IntervalBox(SVector(x))
IntervalBox(x::SVector) = IntervalBox(interval.(x))
IntervalBox(x::Tuple) = IntervalBox(SVector(x))
IntervalBox(x::Real) = IntervalBox(interval.(x))
IntervalBox(x...) = IntervalBox(x)
IntervalBox(x) = IntervalBox(x...)
IntervalBox(X::IntervalBox, n) = foldl(×, Iterators.repeated(X, n))

Base.@propagate_inbounds Base.getindex(X::IntervalBox, i) = X.v[i]

setindex(X::IntervalBox, y, i) = IntervalBox( setindex(X.v, y, i) )

# iteration:

iterate(X::IntervalBox{N,T}) where {N, T} = (X[1], 1)

function iterate(X::IntervalBox{N,T}, state) where {N,T}
    (state == N) && return nothing

    return X[state+1], state+1
end

eltype(::Type{IntervalBox{N,T}}) where {N,T} = Interval{T} # Note that this is defined for the type

length(X::IntervalBox{N,T}) where {N,T} = N



# IntervalBox(xx) = IntervalBox(Interval.(xx))
# IntervalBox(xx::SVector) where {N,T} = IntervalBox(Interval.(xx))


## arithmetic operations
# Note that standard arithmetic operations are implemented automatically by FixedSizeArrays.jl
"""
    mid(X::IntervalBox, α=0.5)

Return a vector of the `mid` of each interval composing the `IntervalBox`.

See `mid(X::Interval, α=0.5)` for more informations.
"""
mid(X::IntervalBox) = mid.(X)
mid(X::IntervalBox, α) = mid.(X, α)

big(X::IntervalBox) = big.(X)


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

isinf(X::IntervalBox) = any(isinf.(X))

isinterior(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) where {N,T} = all(isinterior.(X, Y))

contains_zero(X::SVector) = all(contains_zero.(X))
contains_zero(X::IntervalBox) = all(contains_zero.(X))

×(a::Interval...) = IntervalBox(a...)
×(a::Interval, b::IntervalBox) = IntervalBox(a, b.v...)
×(a::IntervalBox, b::Interval) = IntervalBox(a.v..., b)
×(a::IntervalBox, b::IntervalBox) = IntervalBox(a.v..., b.v...)

IntervalBox(x::Interval, ::Val{n}) where {n} = IntervalBox(SVector(ntuple( _ -> x, Val(n) )))

IntervalBox(x::Interval, n::Int) = IntervalBox(x, Val(n))

dot(x::IntervalBox, y::IntervalBox) = dot(x.v, y.v)
