using IntervalArithmetic
using Test

@testset "Complex interval operations" begin
    a = @interval 1im
    b = @interval 4im + 3
    c = (@interval -1 4) + (@interval 0 2)*im

    @test typeof(a) == Complex{IntervalArithmetic.Interval{Float64}}
    @test a ==  Interval(0) + Interval(1)*im
    @test a * a == Interval(-1)
    @test a + a == Interval(2)*im
    @test a - a == 0
    @test a / a == 1

    @test 3+2im ∈ c
    @test a ∪ b == (@interval 0 3) + (@interval 1 4)*im
    @test c ∩ (a ∪ b) == (@interval 0 3) + (@interval 1 2)*im
    @test a ∩ b == ∅ + ∅*im
    @test isdisjoint(a,b) == true
end

@testset "Complex functions" begin
    Z = (3 ± 1e-7) + (4 ± 1e-7)*im
    @test sin(Z) == complex(sin(real(Z)) * cosh(imag(Z)), sinh(imag(Z)) * cos(real(Z)))
    @test exp(-im * Interval(π)) == Interval(-1.0, -0.9999999999999999) - Interval(1.224646799147353e-16, 1.2246467991473532e-16)*im

    sZ = sqrt(Z)
    @test sZ == Interval(1.99999996999999951619,2.00000003000000070585) + Interval(0.99999996999999984926,1.00000003000000048381)*im
    @test sqrt(-Z) == imag(sZ) - real(sZ)*im

    @test sqrt((@interval -1 0) + (@interval 0)*im) .== (@interval 0 1)*im
    @test sqrt((@interval -1 1) + (@interval 0)*im) .== (@interval 0 1) + (@interval 0 1)*im
    @test sqrt((@interval -9//32 Inf)*im + (@interval 0)) .== (@interval 0 Inf) + (@interval -3//8 Inf)*im
end


@testset "Complex powers" begin
    x = (3..3) + 4im
    @test x^2 == -7 + 24im
    @test sqrt(x) ⊆ x^0.5
    @test x^-2 == inv(x)^2

    a = -3.1
    @test x ⊆ (x^a)^(1/a)
end
