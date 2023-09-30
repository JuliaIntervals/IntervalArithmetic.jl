using Test
using IntervalArithmetic
import IntervalArithmetic: unsafe_interval

@testset "Tests with rational intervals" begin
    a = interval(Rational{Int}, 1//2, 3//4)
    b = interval(Rational{Int}, 3//7, 9//12)

    @test isequalinterval(a + b, interval(Rational{Int}, 13//14, 3//2))  # exact

    @test isequalinterval(sqrt(a + b), unsafe_interval(Rational{Int64}, 137482504//142672337, 46099201//37639840))

    X = interval(1//3)
    @test isequalinterval(sqrt(X), unsafe_interval(Rational{Int64}, 29354524//50843527, 50843527//88063572))
end

@testset "Rounding rational intervals" begin
    X = interval(big(1)//3)
    Y = interval(big"5.77350269189625764452e-01", big"5.77350269189625764561e-01")
    @test_broken isequalinterval(sqrt(X), Y)
end

@testset "Tests with float intervals" begin
    c = I"[0.1, 0.2]"

    @test isa(I"0.1", Interval)
    @test isweakinterior(c, interval(prevfloat(0.1), nextfloat(0.2)))

    @test isequalinterval(interval(Float64, pi), interval(3.141592653589793, 3.1415926535897936))
end

@testset "Testing functions of intervals" begin
    f(x) = x + 0.1

    c = I"[0.1, 0.2]"
    @test isequalinterval(f(c), interval(0.19999999999999998, 0.30000000000000004))
end
