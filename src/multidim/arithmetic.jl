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
