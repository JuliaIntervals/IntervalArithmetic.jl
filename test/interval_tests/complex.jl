using Test
using IntervalArithmetic

@testset "Complex interval operations" begin
    a = interval(1im)
    b = interval(4im + 3)
    c = interval(-1, 4) + interval(0, 2)*im

    @test a ⊂ c
    @test a ⊆ c
    @test a ⪽ c
    @test (b ⊂ c) == false
    @test (b ⊆ c) == false

    @test typeof(a) == Complex{Interval{Float64}}
    @test a ==  interval(0) + interval(1)*im
    @test a * a == interval(-1)
    @test a + a == interval(2)*im
    @test a - a == 0
    @test a / a == 1

    @test 3+2im ∈ c
    @test a ∪ b == interval(0, 3) + interval(1, 4)*im
    @test c ∩ (a ∪ b) == interval(0, 3) + interval(1, 2)*im
    @test a ∩ b == ∅ + ∅*im
    @test isdisjoint(a,b) == true
end

@testset "Complex functions" begin
    Z = (3 ± 1e-7) + (4 ± 1e-7)*im
    @test sin(Z) == complex(sin(real(Z)) * cosh(imag(Z)), sinh(imag(Z)) * cos(real(Z)))
    z = exp(-im * interval(π))
    @test -1 in real(z)
    @test 0 in imag(z)

    sZ = sqrt(Z)
    @test sZ == interval(1.99999996999999951619,2.00000003000000070585) + interval(0.99999996999999984926,1.00000003000000048381)*im
    @test sqrt(-Z) == imag(sZ) - real(sZ)*im

    @test sqrt(interval(-1, 0) + interval(0)*im) .== interval(0, 1)*im
    @test sqrt(interval(-1, 1) + interval(0)*im) .== interval(0, 1) + interval(0, 1)*im
    @test sqrt(interval(-9//32, Inf)*im) .== interval(0, Inf) + interval(-3//8, Inf)*im
end


@testset "Complex powers" begin
    x = (3..3) + 4im
    @test x^2 == -7 + 24im
    @test sqrt(x) ⊆ x^0.5
    @test x^-2 == inv(x)^2

    a = -3.1
    @test x ⊆ (x^a)^(1/a)
end

@testset "abs2 and abs" begin
    x = (0..3) + (0..4)*im
    @test abs2(x) == 0..25
    @test abs(x) == norm(x) == 0..5

    y = (-1..1) + (-2..2)*im
    @test abs(y).lo == 0.0
    @test abs2(y).lo == 0.0
end

@testset "real functions" begin
    x = (0..3) + (0..4)*im
    @test mag(x) == 5
    @test mig(x) == 0
    @test mid(x) == 1.5 + 2im
end
