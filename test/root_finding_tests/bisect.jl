using ValidatedNumerics, ValidatedNumerics.RootFinding
using Base.Test


@testset "Bisection tests" begin
    x = Interval(0, 1)

    @test bisect(x) == (0..0.5, 0.5..1)
    @test bisect(x, 0.25) == (0..0.25, 0.25..1)


    X = (0..1) × (0..2)
    @test bisect(X) == ( (0..1) × (0..1), (0..1) × (1..2) )
    @test bisect(X, 0.25) == ( (0..1) × (0..0.5), (0..1) × (0.5..2) )
    @test bisect(X, 1, 0.5) == ( (0..0.5) × (0..2), (0.5..1) × (0..2) )
    @test bisect(X, 1, 0.25) == ( (0..0.25) × (0..2), (0.25..1) × (0..2) )
end
