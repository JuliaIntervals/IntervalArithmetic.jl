# This file is part of the IntervalArithmetic.jl package; MIT licensed

+(a::IntervalBox, b::IntervalBox) = IntervalBox( a.v .+ b.v )
+(a::IntervalBox, b::Real) = IntervalBox( a.v .+ b )
+(a::Real, b::IntervalBox) = IntervalBox( a .+ b.v )

-(a::IntervalBox, b::IntervalBox) = IntervalBox( a.v .- b.v )
-(a::IntervalBox, b::Real) = IntervalBox( a.v .- b )
-(a::Real, b::IntervalBox) = IntervalBox( a .- b.v )
-(a::IntervalBox) = IntervalBox( .- a.v )

broadcast(::typeof(*), a::IntervalBox, b::IntervalBox) = IntervalBox( a.v .* b.v )
*(a::IntervalBox, b::Real) = IntervalBox( a.v .* b )
*(a::Real, b::IntervalBox) = IntervalBox( a .* b.v )

broadcast(::typeof(/), a::IntervalBox, b::IntervalBox) = IntervalBox( a.v ./ b.v )
/(a::IntervalBox, b::Real) = IntervalBox( a.v ./ b )
broadcast(::typeof(/), a::Real, b::IntervalBox) = IntervalBox( a ./ b.v )

broadcast(::typeof(^), a::IntervalBox, r::Real) = IntervalBox( a.v .^ r )

funcs = (:exp, :expm1, :exp2, :exp10, :log, :log2, :log10, :log1p,
        :sqrt, :pow, :sin, :cos, :tan, :asin, :acos, :atan, :atan2,
        :sinh, :cosh, :tanh, :asinh, :acosh, :atanh, :inv)

for fn in funcs
    @eval broadcast(::typeof($(fn)), a::IntervalBox) = IntervalBox( $(fn).(a.v) )
end
