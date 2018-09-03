# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

setprecision(Interval, Float64)

@testset "setdiff" begin
    x = 2..4
    y = 3..5

    d = setdiff(x, y)

    @test typeof(d) ==Vector{Interval{Float64}}
    @test length(d) ==1
    @test d ==[2..3]
    @test setdiff(y, x) ==[4..5]

    x = 2..4
    y = 2..5

    @test typeof(d) ==Vector{Interval{Float64}}
    @test length(setdiff(x, y)) ==0
    @test setdiff(y, x) ==[4..5]

    x = 2..5
    y = 3..4
    @test setdiff(x, y) ==[2..3, 4..5]

#    X = IntervalBox(2..4, 3..5)
#    Y = IntervalBox(3..5, 4..6)

    #@test setdiff(X, Y) ==IntervalBox(2..3, 3..4)
end
