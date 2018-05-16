# This file is part of the IntervalArithmetic.jl package; MIT licensed

+(a::IntervalBox, b::IntervalBox) = IntervalBox( a .+ b )
+(a::IntervalBox, b::Real) = IntervalBox( a .+ b )
+(a::Real, b::IntervalBox) = IntervalBox( a .+ b )

-(a::IntervalBox, b::IntervalBox) = IntervalBox( a .- b )
-(a::IntervalBox, b::Real) = IntervalBox( a .- b )
-(a::Real, b::IntervalBox) = IntervalBox( a .- b )
-(a::IntervalBox) = IntervalBox( .- a )

*(a::IntervalBox, b::IntervalBox) = IntervalBox( a .* b )
*(a::Real, b::IntervalBox) = IntervalBox( a .* b )
*(a::IntervalBox, b::Real) = IntervalBox( a .* b )

/(a::IntervalBox, b::IntervalBox) = IntervalBox( a ./ b )
/(a::IntervalBox, b::Real) = IntervalBox( a ./ b )
/(a::Real, b::IntervalBox) = IntervalBox( a .* inv(b) )

^(a::IntervalBox, r::Real) = IntervalBox( a .^ r )
^(a::IntervalBox, n::Int) = IntervalBox( a .^ n )

funcs = (:exp, :expm1, :exp2, :exp10, :log, :log2, :log10, :log1p,
        :sqrt, :pow, :sin, :cos, :tan, :asin, :acos, :atan, :atan2,
        :sinh, :cosh, :tanh, :asinh, :acosh, :atanh, :inv)

for fn in funcs
    @eval $(fn)(a::IntervalBox) = IntervalBox( @. $(fn)(a) )
end
