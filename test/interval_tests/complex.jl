using IntervalArithmetic
using Base.Test

@testset "Complex interval operations" begin
    a = @interval 1im
    @test typeof(a)== Complex{IntervalArithmetic.Interval{Float64}}
    @test a ==  Interval(0) + Interval(1)*im
    @test a * a == Interval(-1)
    @test a + a == Interval(2)*im
    @test a - a == 0
    @test a / a == 1
    @test a^2 == -1
end

@testset "Complex functions" begin
    Z = (3 ± 1e-7) + (4 ± 1e-7)*im
    @test sin(Z) == Interval(3.853734949309744, 3.8537411265295507) - Interval(27.016810169394066, 27.016816346613883)*im

    @test exp(-im * Interval(π)) == Interval(-1.0, -0.9999999999999999) - Interval(1.224646799147353e-16, 1.2246467991473532e-16)*im
end
