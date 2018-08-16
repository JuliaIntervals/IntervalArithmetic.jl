using IntervalArithmetic
if VERSION < v"0.7.0-DEV.2004"
    using Base.Test
else
    using Test
end

@testset "Complex interval operations" begin
    a = @interval 1im
    b = @interval 4im + 3

    @test typeof(a)== Complex{IntervalArithmetic.Interval{Float64}}
    @test a ==  Interval(0) + Interval(1)*im
    @test a * a == Interval(-1)
    @test a + a == Interval(2)*im
    @test a - a == 0
    @test a / a == 1
    @test a^2 == -1

    @test a ∪ b == (@interval 0 3) + (@interval 1 4)*im
    @test a ∩ b == ∅ + ∅*im
    @test isdisjoint(a,b) == true
end

@testset "Complex functions" begin
    Z = (3 ± 1e-7) + (4 ± 1e-7)*im
    @test sin(Z) == complex(sin(real(Z))*cosh(imag(Z)),sinh(imag(Z))*cos(real(Z)))
    @test exp(-im * Interval(π)) == Interval(-1.0, -0.9999999999999999) - Interval(1.224646799147353e-16, 1.2246467991473532e-16)*im

    @test sqrt(Z) == Interval(1.9999999699999995,2.0000000300000007) + Interval(2.0000000300000007,1.0000000300000005)*im
end
