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

@inline Base.broadcast(f, X::IntervalBox) = wrap(f.(X.v))
@inline Base.broadcast(f, X::IntervalBox, Y::IntervalBox) = wrap(f.(X.v, Y.v))
@inline Base.broadcast(f, X::IntervalBox, y) = wrap(f.(X.v, y))

for op in (:+, :-, :∩, :∪, :⊆, :isinterior, :dot, :setdiff, :×)
    @eval $(op)(a::SVector, b::IntervalBox) = $(op)(IntervalBox(a), b)
end

for op in (:+, :-, :∩, :∪, :⊆, :isinterior, :dot, :setdiff, :×)
    @eval $(op)(a::IntervalBox, b::SVector) = $(op)(a, IntervalBox(b))
end
