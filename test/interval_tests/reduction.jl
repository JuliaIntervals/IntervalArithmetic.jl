using IntervalArithmetic
using Test

setprecision(Interval, Float64)
setprecision(256)
@testset "Reduction Test" begin
    @test vector_sum([1.0, 2.0, 3.0], RoundNearest) == 6.0
    @test isnan(vector_sum([1.0, 2.0, NaN, 3.0], RoundNearest))
    @test isnan(vector_sum([1.0, -Inf, 2.0, Inf, 3.0], RoundNearest))
    @test vector_sumAbs([1.0, -2.0, 3.0], RoundNearest) == 6.0
    @test isnan(vector_sumAbs([1.0, -2.0, NaN, 3.0], RoundNearest))
    @test vector_sumAbs([1.0, -Inf, 2.0, Inf, 3.0], RoundNearest) == Inf
    @test vector_sumSquare([1.0, 2.0, 3.0], RoundNearest) == 14.0
    @test isnan(vector_sumSquare([1.0, 2.0, NaN, 3.0], RoundNearest))
    @test vector_sumSquare([1.0, -Inf, 2.0, Inf, 3.0], RoundNearest) == Inf
    @test vector_dot([1.0, 2.0, 3.0], [1.0, 2.0, 3.0], RoundNearest) == 14.0
    @test vector_dot([0x10000000000001p0, 0x1p104], [0x0fffffffffffffp0, -1.0], RoundNearest) == -1.0
    @test isnan(vector_dot([1.0, 2.0, NaN, 3.0], [1.0, 2.0, 3.0, 4.0], RoundNearest))
    @test isnan(vector_dot([1.0, 2.0, 3.0, 4.0], [1.0, 2.0, NaN, 3.0], RoundNearest))
    @test vector_sum([sqrt(big(3)), 5^(1/3)], RoundDown) == 3.442026754245574
    @test vector_sum([sqrt(big(3)), 5^(1/3)], RoundUp) == 3.4420267542455742
end
