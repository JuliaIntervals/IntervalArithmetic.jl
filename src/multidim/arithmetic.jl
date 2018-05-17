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

Base.broadcast(f, X::IntervalBox) = IntervalBox(f.(X.v))
Base.broadcast(f, X::IntervalBox, Y::IntervalBox) = IntervalBox( f.(X.v, Y.v) )
