using ValidatedNumerics
using Base.Test


@test ValidatedNumerics.round_expr(:(a + b), RoundDown) == :($(Expr(:escape, :a)) + $(Expr(:escape, :b)) + $(RoundDown))

@test ValidatedNumerics.round_expr(:(sin(a)), RoundUp) ==
    :( sin( $(Expr(:escape, :a)), $(RoundUp) ) )
