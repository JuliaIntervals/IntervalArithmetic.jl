using Test
using IntervalArithmetic

@testset "removed interval" begin
    @test_throws ArgumentError intersect(interval(1))
    @test_throws ArgumentError intersect(interval(1), 2, [1], 4., 5)
    @test_throws ArgumentError intersect(interval(1), interval(2.), interval(3.))
    @test_throws ArgumentError union(interval(1))
    @test_throws ArgumentError union(interval(1), 2, [1], 4., 5)
    @test_throws ArgumentError union(interval(1), interval(2.), interval(3.))
    @test_throws ArgumentError setdiff(interval(1))
    @test_throws ArgumentError setdiff(interval(1), 2, [1], 4., 5)
    @test_throws ArgumentError setdiff(interval(1), interval(2.), interval(3.))
    @test_throws ArgumentError symdiff(interval(1), interval(2.), interval(3.))
end

@testset "setdiff_interval" begin
    x = interval(2, 4)
    y = interval(3, 5)

    d = setdiff_interval(x, y)

    @test typeof(d) == Vector{Interval{Float64}}
    @test length(d) == 1
    @test d == [interval(2, 3)]
    @test setdiff_interval(y, x) == [interval(4, 5)]

    x = interval(2, 4)
    y = interval(2, 5)

    @test typeof(d) == Vector{Interval{Float64}}
    @test length(setdiff_interval(x, y)) == 0
    @test setdiff_interval(y, x) == [interval(4, 5)]

    x = interval(2, 5)
    y = interval(3, 4)
    @test setdiff_interval(x, y) == [interval(2, 3), interval(4, 5)]
end
