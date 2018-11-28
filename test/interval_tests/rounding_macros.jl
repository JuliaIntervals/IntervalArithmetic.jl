using IntervalArithmetic
using Test

@test IntervalArithmetic.round_expr(:(a + b), RoundDown) == :(($(Expr(:escape, :+)))($(Expr(:escape, :a)), $(Expr(:escape, :b)), RoundingMode{:Down}()))

@test IntervalArithmetic.round_expr(:(sin(a)), RoundUp) ==
    :(sin($(Expr(:escape, :a)), RoundingMode{:Up}()))
