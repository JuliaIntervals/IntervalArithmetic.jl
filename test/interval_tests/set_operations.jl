using Test
using IntervalArithmetic

@testset "setdiff" begin
    x = interval(2, 4)
    y = interval(3, 5)

    d = setdiff(x, y)

    @test typeof(d) == Vector{Interval{Float64}}
    @test length(d) == 1
    @test d == [interval(2, 3)]
    @test setdiff(y, x) == [interval(4, 5)]

    x = interval(2, 4)
    y = interval(2, 5)

    @test typeof(d) == Vector{Interval{Float64}}
    @test length(setdiff(x, y)) == 0
    @test setdiff(y, x) == [interval(4, 5)]

    x = interval(2, 5)
    y = interval(3, 4)
    @test setdiff(x, y) == [interval(2, 3), interval(4, 5)]

    # X = IntervalBox(2..4, 3..5)
    # Y = IntervalBox(3..5, 4..6)
    # @test setdiff(X, Y) == IntervalBox(2..3, 3..4)
end
