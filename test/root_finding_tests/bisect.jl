using ValidatedNumerics, ValidatedNumerics.RootFinding
using Base.Test


@testset "Bisection tests" begin
    X = 0..1
    @test bisect(X) == (0..0.5, 0.5..1)
    @test bisect(X, 0.25) == (0..0.25, 0.25..1)

    X = -∞..∞
    @test bisect(X) == (-∞..0, 0..∞)
    @test bisect(X, 0.75) == (-∞..0, 0..∞)

    X = 1..∞
    @test bisect(X) == (Interval(1, prevfloat(∞)), Interval(prevfloat(∞), ∞))

    X = (0..1) × (0..2)
    @test bisect(X) == ( (0..1) × (0..1), (0..1) × (1..2) )
    @test bisect(X, 0.25) == ( (0..1) × (0..0.5), (0..1) × (0.5..2) )
    @test bisect(X, 1, 0.5) == ( (0..0.5) × (0..2), (0.5..1) × (0..2) )
    @test bisect(X, 1, 0.25) == ( (0..0.25) × (0..2), (0.25..1) × (0..2) )

    X = (-∞..∞) × (-∞..∞)
    @test bisect(X) == ( (-∞..0) × (-∞..∞), (0..∞) × (-∞..∞))
end
