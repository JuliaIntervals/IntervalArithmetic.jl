using IntervalArithmetic, ForwardDiff
using Test

@testset "AD" begin
    @test ForwardDiff.derivative(abs, -2.0 .. 2.0) == -1.0 .. 1.0
    @test ForwardDiff.derivative(abs, 1.0 .. 2.0) == 1.0 .. 1.0
    @test ForwardDiff.derivative(abs, -2.0 .. -1.0) == -1.0 .. -1.0
    @test ForwardDiff.derivative(abs, Interval(0.0)) == Interval(1.0)
    @test ForwardDiff.derivative(abs, -2.0 .. 0.0) == -1.0 .. 1.0
    @test ForwardDiff.derivative(abs, 0.0 .. 2.0) == Interval(1.0)

    # Test proper handeling at abs(0)
    @test ForwardDiff.hessian(t -> abs(t[1])^2, [Interval(0.0)])[1] == Interval(2.0)
end