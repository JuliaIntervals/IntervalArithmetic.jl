# This file is part of the IntervalArithmetic.jl package; MIT licensed

+(a::IntervalBox, b::IntervalBox) = IntervalBox( a.v .+ b.v )
+(a::IntervalBox, b::Real) = IntervalBox( a.v .+ b )
+(a::Real, b::IntervalBox) = IntervalBox( a .+ b.v )

-(a::IntervalBox, b::IntervalBox) = IntervalBox( a.v .- b.v )
-(a::IntervalBox, b::Real) = IntervalBox( a.v .- b )
-(a::Real, b::IntervalBox) = IntervalBox( a .- b.v )
-(a::IntervalBox) = IntervalBox( .- a.v )

*(a::IntervalBox, b::Real) = IntervalBox( a.v .* b )
*(a::Real, b::IntervalBox) = IntervalBox( a .* b.v )

/(a::IntervalBox, b::Real) = IntervalBox( a.v ./ b )


# broadcasting:

# wrap decides whether to wrap the result in an IntervalBox or not, based on the return type
wrap(v::SVector{N,T} where {N,T<:Interval}) = IntervalBox(v)
wrap(v) = v

Base.broadcast(f, X::IntervalBox) = wrap(f.(X.v))
Base.broadcast(f, X::IntervalBox, Y::IntervalBox) = wrap(f.(X.v, Y.v))
Base.broadcast(f, X::IntervalBox, y) = wrap(f.(X.v, y))

for op in (:+, :-, :∩, :∪, :⊆, :isinterior, :dot, :setdiff)
    @eval $(op)(a::SVector{N, Interval{T}}, b::IntervalBox{N, T}) where {N, T<:Real} = $(op)(IntervalBox(a), b)
end

for op in (:+, :-, :∩, :∪, :⊆, :isinterior, :dot, :setdiff)
    @eval $(op)(a::IntervalBox{N, T}, b::SVector{N, Interval{T}}) where {N, T<:Real} = $(op)(a, IntervalBox(b))
end

for op in (:+, :-, :∩, :∪, :⊆, :isinterior, :dot, :setdiff)
    @eval $(op)(a::SVector{N, T}, b::IntervalBox{N, <:Real}) where {N, T} = $(op)(IntervalBox(interval.(a)), b)
end

for op in (:+, :-, :∩, :∪, :⊆, :isinterior, :dot, :setdiff)
    @eval $(op)(a::IntervalBox{N, T}, b::SVector{N, <:Real}) where {N, T} = $(op)(a, IntervalBox(interval.(b)))
end


×(a::IntervalBox{N1, T}, b::SVector{N2, Interval{T}}) where {N1, N2, T} = ×(a, IntervalBox(b))

×(a::SVector{N2, Interval{T}}, b::IntervalBox{N1, T}) where {N1, N2, T} = ×(IntervalBox(a), b)
