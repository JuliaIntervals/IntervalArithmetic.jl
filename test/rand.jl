using IntervalArithmetic
using Test
using StaticArrays

@testset "rand tests" begin

    X = 3..4
    for i in 1:100
        @test rand(X) ∈ X
    end

    Y = IntervalBox(3..4, 5..6)
    for i in 1:100
        @test rand(Y) ∈ Y
    end

    for T in (Float32, Float64, BigFloat)
        X = Interval{T}(3, 4)
        @test rand(X) isa T

        Y = IntervalBox(X, X)
        @test rand(Y) isa SVector{2,T}
    end

end
