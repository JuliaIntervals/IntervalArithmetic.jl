using IntervalArithmetic
using Test

@testset "Tests with rational intervals" begin
    a = Interval(1//2, 3//4)
    b = Interval(3//7, 9//12)

    @test a + b ≛ Interval(13//14, 3//2)  # exact

    @test sqrt(a + b) ≛ Interval(0.9636241116594314, 1.2247448713915892)

    X = Interval(1//3)
    @test sqrt(X) ≛ Interval(0.5773502691896257, 0.5773502691896258)
end

@testset "Rounding rational intervals" begin
    X = Interval(big(1)//3)
    Y = Interval(big"5.77350269189625764452e-01", big"5.77350269189625764561e-01")
    @test_broken sqrt(X) ≛ Y
end

@testset "Tests with float intervals" begin
    c = @floatinterval(0.1, 0.2)

    @test isa(@floatinterval(0.1), Interval)
    @test c ≛ Interval(prevfloat(0.1), nextfloat(0.2))

    @test Interval{Float64}(pi) ≛ Interval(3.141592653589793, 3.1415926535897936)
end

@testset "Testing functions of intervals" begin
    f(x) = x + 0.1

    c = @floatinterval(0.1, 0.2)
    @test f(c) ≛ Interval(0.19999999999999998, 0.30000000000000004)

    d = @interval(0.1, 0.2)
    @test_broken f(d) ≛ @biginterval(0.2, 0.3)
end
