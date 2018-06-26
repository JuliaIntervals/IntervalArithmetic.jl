using IntervalArithmetic
if VERSION < v"0.7.0-DEV.2004"
    using Base.Test
else
    using Test
end

@test IntervalArithmetic.round_expr(:(a + b), RoundDown) == :($(Expr(:escape, :a)) + $(Expr(:escape, :b)) + $(RoundDown))

@test IntervalArithmetic.round_expr(:(sin(a)), RoundUp) ==
    :( sin( $(Expr(:escape, :a)), $(RoundUp) ) )
