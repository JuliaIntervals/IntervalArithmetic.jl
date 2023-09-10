# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""An `IntervalBox` is an `N`-dimensional rectangular box, given
by a Cartesian product of a vector of `N` `Interval`s.
"""
struct IntervalBox{N,T<:NumTypes}
    v::SVector{N,Interval{T}}
end

# IntervalBox(x::Interval) = IntervalBox( SVector(x) )  # single interval treated as tuple with one element

IntervalBox(x::Interval...) = IntervalBox(SVector(x))
IntervalBox(x::SVector) = IntervalBox(interval.(x))
IntervalBox(x::Tuple) = IntervalBox(SVector(x))
IntervalBox(x::Real) = IntervalBox(interval.(x))
IntervalBox(x...) = IntervalBox(x)
IntervalBox(x) = IntervalBox(x...)
IntervalBox(X::IntervalBox, n) = foldl(×, Iterators.repeated(X, n))

# construct from two vectors giving bottom and top corners:
function IntervalBox(los::AbstractVector, his::AbstractVector)
    xs = map(los, his) do lo, hi
        # Allow the creation of the intervals even when the bounds are in the
        # wrong order
        return lo <= hi ? interval(lo, hi) : interval(hi, lo)
    end
    return IntervalBox(xs...)
end

Base.@propagate_inbounds Base.getindex(X::IntervalBox, i) = X.v[i]

setindex(X::IntervalBox, y, i) = IntervalBox( setindex(X.v, y, i) )

# iteration:
iterate(X::IntervalBox) = (X[1], 1)

function iterate(X::IntervalBox{N}, state) where {N}
    (state == N) && return nothing

    return X[state+1], state+1
end

eltype(::Type{IntervalBox{N,T}}) where {N,T<:NumTypes} = Interval{T} # Note that this is defined for the type


eltype(::IntervalBox{N,T}) where {N,T<:NumTypes} = Interval{T}
numtype(::IntervalBox{N,T}) where {N,T<:NumTypes} = T

length(::IntervalBox{N}) where {N} = N



# IntervalBox(xx) = IntervalBox(Interval.(xx))
# IntervalBox(xx::SVector) where {N,T} = IntervalBox(Interval.(xx))


## arithmetic operations
# Note that standard arithmetic operations are implemented automatically by FixedSizeArrays.jl
"""
    mid(X::IntervalBox, α=0.5)

Return a vector of the `mid` of each interval composing the `IntervalBox`.

See `mid(X::Interval, α=0.5)` for more information.
"""
mid(X::IntervalBox) = mid.(X)
scaled_mid(X::IntervalBox, α) = scaled_mid.(X, α)

big(X::IntervalBox) = big.(X)


## set operations
for (op, dotop) in ((:⊆, :.⊆), (:⊂, :.⊂), (:⊃, :.⊃))
    @eval $(op)(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} = all($(dotop)(X, Y))
end

∩(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} = IntervalBox(X.v .∩ Y.v)
∪(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} = IntervalBox(X.v .∪ Y.v)

∈(X::AbstractVector, Y::IntervalBox) = all(X .∈ Y)
∈(X, Y::IntervalBox) = throw(ArgumentError("$X ∈ $Y is not defined"))

# mixing intervals with one-dimensional interval boxes
for op in (:⊆, :⊂, :⊃, :∩, :∪)
    @eval $(op)(a::Interval, X::IntervalBox{1}) = $(op)(a, first(X))
    @eval $(op)(X::IntervalBox{1}, a::Interval) = $(op)(first(X), a)
end

#=
On Julia 0.6 can now write
∩{N,T}(X::IntervalBox{N,T}, Y::IntervalBox{N,T}) = IntervalBox(NTuple{N, Interval{Float64}}( (X[i] ∩ Y[i]) for i in 1:N))
=#


isempty(X::IntervalBox) = any(isempty, X.v)

diam(X::IntervalBox) = maximum(diam.(X.v))

emptyinterval(X::IntervalBox) = IntervalBox(emptyinterval.(X.v))

isinf(X::IntervalBox) = any(isinf.(X))

isinterior(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} = all(isinterior.(X, Y))

contains_zero(X::SVector) = all(contains_zero.(X))
contains_zero(X::IntervalBox) = all(contains_zero.(X))

×(a::Interval...) = IntervalBox(a...)
×(a::Interval, b::IntervalBox) = IntervalBox(a, b.v...)
×(a::IntervalBox, b::Interval) = IntervalBox(a.v..., b)
×(a::IntervalBox, b::IntervalBox) = IntervalBox(a.v..., b.v...)

IntervalBox(x::Interval, ::Val{n}) where {n} = IntervalBox(SVector(ntuple( _ -> x, Val(n) )))

IntervalBox(x::Interval, n::Int) = IntervalBox(x, Val(n))

dot(x::IntervalBox, y::IntervalBox) = dot(x.v, y.v)

==(x::IntervalBox, y::IntervalBox) = all(x.v .== y.v)
≛(x::IntervalBox, y::IntervalBox) = all(x.v .≛ y.v)

"""
    mince(x::IntervalBox, n::Int)

Splits `x` in `n` intervals in each dimension of the same diameter. These
intervals are combined in all possible `IntervalBox`-es, which are returned
as a vector.
"""
@inline mince(x::IntervalBox{N}, n::Int) where {N} = mince(x, ntuple(_ -> n, N))

"""
    mince(x::IntervalBox, ncuts::::NTuple{N,Int})

Splits `x[i]` in `ncuts[i]` intervals . These intervals are
combined in all possible `IntervalBox`-es, which are returned
as a vector.
"""
@inline function mince(x::IntervalBox{N,T}, ncuts::NTuple{N,Int}) where {N,T<:NumTypes}
    minced_intervals = [mince(x[i], ncuts[i]) for i in 1:N]
    minced_boxes = Vector{IntervalBox{N,T}}(undef, prod(ncuts))

    for (k, cut_indices) in enumerate(CartesianIndices(ncuts))
        minced_boxes[k] = IntervalBox([minced_intervals[i][cut_indices[i]] for i in 1:N])
    end
    return minced_boxes
end


hull(a::IntervalBox{N,T}, b::IntervalBox{N,T}) where {N,T<:NumTypes} = IntervalBox(hull.(a[:], b[:]))
hull(a::Vector{IntervalBox{N,T}}) where {N,T<:NumTypes} = hull(a...)

"""
    zero(IntervalBox{N, T})

Return the zero interval box of dimension `N` in the numeric type `T`.
"""
zero(::Type{IntervalBox{N,T}}) where {N,T<:NumTypes} = IntervalBox(zero(Interval{T}), N)
zero(x::IntervalBox) = zero(typeof(x))

"""
    symmetric_box(N, T)

Return the symmetric interval box of dimension `N` in the numeric type `T`,
each side is `Interval(-1, 1)`.
"""
symmetric_box(N, ::Type{T}) where {T<:NumTypes} = IntervalBox(unsafe_interval(T, -one(T), one(T)), N)
