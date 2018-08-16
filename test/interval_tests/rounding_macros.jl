using IntervalArithmetic
using Test

@test IntervalArithmetic.round_expr(:(a + b), RoundDown) == :($(Expr(:escape, :a)) + $(Expr(:escape, :b)) + $(RoundDown))

@test IntervalArithmetic.round_expr(:(sin(a)), RoundUp) ==
    :( sin( $(Expr(:escape, :a)), $(RoundUp) ) )
