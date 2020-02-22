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

# construct from two vectors giving bottom and top corners:
IntervalBox(lo::AbstractVector, hi::AbstractVector) where {N,T} = IntervalBox(force_interval.(lo, hi))

IntervalBox(lo::SVector{N,T}, hi::SVector{N,T}) where {N,T} = IntervalBox(force_interval.(lo, hi))


Base.@propagate_inbounds Base.getindex(X::IntervalBox, i) = X.v[i]

setindex(X::IntervalBox, y, i) = IntervalBox( setindex(X.v, y, i) )

# iteration:

iterate(X::IntervalBox{N,T}) where {N, T} = (X[1], 1)

function iterate(X::IntervalBox{N,T}, state) where {N,T}
    (state == N) && return nothing

    return X[state+1], state+1
end

eltype(::Type{IntervalBox{N,T}}) where {N,T} = Interval{T} # Note that this is defined for the type


Base.eltype(x::IntervalBox{T}) where {T<:Real} = T

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
for (op, dotop) in ((:⊆, :.⊆), (:⊂, :.⊂), (:⊃, :.⊃))
    @eval $(op)(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} = all($(dotop)(X, Y))
end

∩(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} =
    IntervalBox(X.v .∩ Y.v)
∪(X::IntervalBox{N}, Y::IntervalBox{N}) where {N} =
    IntervalBox(X.v .∪ Y.v)

∈(X::AbstractVector, Y::IntervalBox{N,T}) where {N,T} = all(X .∈ Y)
∈(X, Y::IntervalBox{N,T}) where {N,T} = throw(ArgumentError("$X ∈ $Y is not defined"))


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

Base.:(==)(x::IntervalBox, y::IntervalBox) = x.v == y.v


"""
    mince(x::IntervalBox, n)

Splits `x` in `n` intervals in each dimension of the same diameter. These
intervals are combined in all possible `IntervalBox`-es, which are returned
as a vector.
"""
@generated function mince(x::IntervalBox{N,T}, n) where {N,T}
    quote
        nodes_matrix = Array{Interval{T},2}(undef, n, N)
        for i in 1:N
            nodes_matrix[1:n,i] .= mince(x[i], n)
        end

        nodes = IntervalBox{$N,T}[]
        Base.Cartesian.@nloops $N i _->(1:n) begin
            Base.Cartesian.@nextract $N ival d->nodes_matrix[i_d, d]
            ibox = Base.Cartesian.@ncall $N IntervalBox ival
            push!(nodes, ibox)
        end
        nodes
    end
end

hull(a::IntervalBox{N,T}, b::IntervalBox{N,T}) where {N,T} = IntervalBox(hull.(a[:], b[:]))
hull(a::Vector{IntervalBox{N,T}}) where {N,T} = hull(a...)
