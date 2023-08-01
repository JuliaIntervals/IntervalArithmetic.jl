using Test
using IntervalArithmetic

@testset "setdiffinterval" begin
    x = interval(2, 4)
    y = interval(3, 5)

    d = setdiffinterval(x, y)

    @test typeof(d) == Vector{Interval{Float64}}
    @test length(d) == 1
    @test d == [interval(2, 3)]
    @test setdiffinterval(y, x) == [interval(4, 5)]

    x = interval(2, 4)
    y = interval(2, 5)

    @test typeof(d) == Vector{Interval{Float64}}
    @test length(setdiffinterval(x, y)) == 0
    @test setdiffinterval(y, x) == [interval(4, 5)]

    x = interval(2, 5)
    y = interval(3, 4)
    @test setdiffinterval(x, y) == [interval(2, 3), interval(4, 5)]

end
