using IntervalArithmetic
using Test


@testset "`bisect` function" begin
    X = 0..1
    @test bisect(X, 0.5) == (0..0.5, 0.5..1)
    @test bisect(X, 0.25) == (0..0.25, 0.25..1)

    @test bisect(X) == (interval(0.0, 0.49609375), interval(0.49609375, 1.0))

    X = -∞..∞
    @test bisect(X, 0.5) == (-∞..0, 0..∞)
    B = bisect(X, 0.75)
    @test B[1].hi > 0
    @test B[1].hi == B[2].lo
    B = bisect(X, 0.25)
    @test B[1].hi < 0
    @test B[1].hi == B[2].lo

    X = (0..1) × (0..2)
    @test bisect(X, 0.5) == ( (0..1) × (0..1), (0..1) × (1..2) )
    @test bisect(X, 0.25) == ( (0..1) × (0..0.5), (0..1) × (0.5..2) )
    @test bisect(X, 1, 0.5) == ( (0..0.5) × (0..2), (0.5..1) × (0..2) )
    @test bisect(X, 1, 0.25) == ( (0..0.25) × (0..2), (0.25..1) × (0..2) )

    @test bisect(X) ==  (IntervalBox(0..1, interval(0.0, 0.9921875)),
                         IntervalBox(0..1, Interval(0.9921875, 2.0)))

    X = (-∞..∞) × (-∞..∞)
    @test bisect(X, 0.5) == ( (-∞..0) × (-∞..∞), (0..∞) × (-∞..∞))
end
