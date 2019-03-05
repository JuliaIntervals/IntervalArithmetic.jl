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

Base.size(X::IntervalBox{2,Float64}) = (2,)
#
@inline broadcasted(f, X::IntervalBox) = wrap(f.(X.v))
@inline broadcasted(f, X::IntervalBox, Y::IntervalBox) = wrap(f.(X.v, Y.v))
@inline broadcasted(f, X::IntervalBox, y) = wrap(f.(X.v, y))
@inline broadcasted(f, x, Y::IntervalBox) = wrap(f.(x, Y.v))
 # for literal_pow:
@inline broadcasted(f, x, y, Z::IntervalBox) = wrap(f.(x, y, Z.v))
@inline broadcasted(f, x, Y::IntervalBox, z) = wrap(f.(x, Y.v, z))

for op in (:+, :-, :∩, :∪, :⊆, :⊂, :⊃, :isinterior, :dot, :setdiff, :×)
    @eval $(op)(a::SVector, b::IntervalBox) = $(op)(IntervalBox(a), b)
    @eval $(op)(a::IntervalBox, b::SVector) = $(op)(a, IntervalBox(b))
end


# multiplication by a matrix

*(A::AbstractMatrix, X::IntervalBox) = IntervalBox(A * X.v)
