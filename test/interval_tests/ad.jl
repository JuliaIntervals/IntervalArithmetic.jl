using IntervalArithmetic, ForwardDiff
using Test

@testset "AD" begin
    for F in (Interval, DecoratedInterval)
        @test ForwardDiff.derivative(abs, F(-2.0 .. 2.0)) == F(-1.0 .. 1.0)
        @test ForwardDiff.derivative(abs, F(1.0 .. 2.0)) == F(1.0 .. 1.0)
        @test ForwardDiff.derivative(abs, F(-2.0 .. -1.0)) == F(-1.0 .. -1.0)
        @test ForwardDiff.derivative(abs, F(0.0)) == F(1.0)
        @test ForwardDiff.derivative(abs, F(-2.0 .. 0.0)) == F(-1.0 .. 1.0)
        @test ForwardDiff.derivative(abs, F(0.0 .. 2.0)) == F(1.0)

        # Test proper handeling at abs(0)
        @test ForwardDiff.hessian(t -> abs(t[1])^2, [F(0.0)])[1] == F(2.0)
    end
end