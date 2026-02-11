using IntervalArithmetic: interval_diff

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

@testset "interiordiff" begin
    x = interval(2, 4)
    y = interval(3, 5)

    @test typeof(interiordiff(x, y)) == Vector{Interval{Float64}}

    @test all(isequal_interval.(interiordiff(x, x), [interval(2), interval(4)]))
    @test all(isequal_interval.(interiordiff(x, emptyinterval(x)), [x]))

    @test all(isequal_interval.(interiordiff(x, y), [interval(2, 3)]))
    @test all(isequal_interval.(interiordiff(y, x), [interval(4, 5)]))

    y = interval(2, 5)

    @test all(isequal_interval.(interiordiff(x, y), [interval(2)]))
    @test all(isequal_interval.(interiordiff(y, x), [interval(2), interval(4, 5)]))

    x = interval(2, 5)
    y = interval(3, 4)
    @test all(isequal_interval.(interiordiff(x, y), [interval(2, 3), interval(4, 5)]))

    x = interval(1, 3)
    z = interval(0, 5)
    @test interiordiff(x, z) == Interval{Float64}[]
    @test all(isequal_interval.(interiordiff(z, x), [interval(0, 1), interval(3, 5)]))
end

@testset "interval_diff" begin
    A, B = interval_diff(interval(1, 10), interval(2, 5))
    @test isequal_interval(A, interval(1, 2))
    @test isequal_interval(B, interval(5, 10))

    @test isequal_interval(
        only(interval_diff(interval(1, 10), interval(1, 5))),
        interval(5, 10)
    )

    @test isequal_interval(
        only(interval_diff(interval(1, 10), interval(7, 12))),
        interval(1, 7)
    )

    @test interval_diff(interval(1, 10), interval(-1, 14)) == []
    @test interval_diff(interval(1, 10), interval(1, 10)) == []
end
