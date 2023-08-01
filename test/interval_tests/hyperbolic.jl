using IntervalArithmetic
using Test

@testset "sinh" begin
    @test equal(sinh(emptyinterval()), emptyinterval())
    @test equal(sinh(interval(0.5)), interval(0.5210953054937473, 0.5210953054937474))
    @test equal(sinh(interval(0.5, 1.67)), interval(0.5210953054937473, 2.5619603657712102))
    @test equal(sinh(interval(-4.5, 0.1)), interval(-45.00301115199179, 0.10016675001984404))
    @test subset(sinh(interval(BigFloat, 0.5, 0.5)), sinh(interval(0.5)))

    @test subset(sinh(interval(BigFloat, 0.5, 1.67)), sinh(interval(0.5, 1.67)))
    @test subset(sinh(interval(BigFloat, 1.67, 3.2)), sinh(interval(1.67, 3.2)))
    @test subset(sinh(interval(BigFloat, 2.1, 5.6)), sinh(interval(2.1, 5.6)))
    @test subset(sinh(interval(BigFloat, 0.5, 8.5)), sinh(interval(0.5, 8.5)))
    @test subset(sinh(interval(BigFloat, -4.5, 0.1)), sinh(interval(-4.5, 0.1)))
    @test subset(sinh(interval(BigFloat, 1.3, 6.3)), sinh(interval(1.3, 6.3)))
end

@testset "cosh" begin
    @test equal(cosh(emptyinterval()), emptyinterval())
    @test equal(cosh(interval(0.5)), interval(1.1276259652063807, 1.127625965206381))
    @test equal(cosh(interval(0.5, 1.67)), interval(1.1276259652063807, 2.750207431409957))
    @test equal(cosh(interval(-4.5, 0.1)), interval(1.0, 45.01412014853003))

    @test subset(cosh(interval(BigFloat, 0.5, 0.5)), cosh(interval(0.5)))
    @test subset(cosh(interval(BigFloat, 0.5, 1.67)), cosh(interval(0.5, 1.67)))
    @test subset(cosh(interval(BigFloat, 1.67, 3.2)), cosh(interval(1.67, 3.2)))
    @test subset(cosh(interval(BigFloat, 2.1, 5.6)), cosh(interval(2.1, 5.6)))
    @test subset(cosh(interval(BigFloat, 0.5, 8.5)), cosh(interval(0.5, 8.5)))
    @test subset(cosh(interval(BigFloat, -4.5, 0.1)), cosh(interval(-4.5, 0.1)))
    @test subset(cosh(interval(BigFloat, 1.3, 6.3)), cosh(interval(1.3, 6.3)))
end

@testset "tanh" begin
    @test equal(tanh(emptyinterval()), emptyinterval())
    @test equal(tanh(interval(0.5)), interval(0.46211715726000974, 0.4621171572600098))
    @test equal(tanh(interval(0.5, 1.67)), interval(0.46211715726000974, 0.9315516846152083))
    @test equal(tanh(interval(-4.5, 0.1)), interval(-0.9997532108480276, 0.09966799462495583))

    @test subset(tanh(interval(BigFloat, 0.5, 0.5)), tanh(interval(0.5)))
    @test subset(tanh(interval(BigFloat, 0.5, 1.67)), tanh(interval(0.5, 1.67)))
    @test subset(tanh(interval(BigFloat, 1.67, 3.2)), tanh(interval(1.67, 3.2)))
    @test subset(tanh(interval(BigFloat, 2.1, 5.6)), tanh(interval(2.1, 5.6)))
    @test subset(tanh(interval(BigFloat, 0.5, 8.5)), tanh(interval(0.5, 8.5)))
    @test subset(tanh(interval(BigFloat, -4.5, 0.1)), tanh(interval(-4.5, 0.1)))
    @test subset(tanh(interval(BigFloat, 1.3, 6.3)), tanh(interval(1.3, 6.3)))

    @test subset(tanh(interval(-4.5, 0.1)), tanh(interval(Float32, -4.5, 0.1)))
    @test subset(tanh(interval(1.3, 6.3)), tanh(interval(Float32, 1.3, 6.3)))

    for a in [ interval(17, 19), interval(0.5, 1.2) ]
        @test subset(tanh(a), sinh(a)/cosh(a))
    end
end

# TODO For reason unkown these tests fail when put in the previous testset
@testset "tanh with Float32" begin
    @test subset(tanh(interval(0.5)), tanh(interval(Float32, 0.5, 0.5)))
    @test subset(tanh(interval(0.5, 1.67)), tanh(interval(Float32, 0.5, 1.67)))
    @test subset(tanh(interval(1.67, 3.2)), tanh(interval(Float32, 1.67, 3.2)))
    @test subset(tanh(interval(2.1, 5.6)), tanh(interval(Float32, 2.1, 5.6)))
    @test subset(tanh(interval(0.5, 8.5)), tanh(interval(Float32, 0.5, 8.5)))
end

@testset "inverse" begin
    @test subset(asinh(interval(BigFloat, 1, 1)), asinh(interval(1)))
    @test subset(asinh(interval(BigFloat, 0.9, 2)), asinh(interval(0.9, 2)))
    @test subset(asinh(interval(BigFloat, 3, 4)), asinh(interval(3, 4)))

    @test subset(acosh(interval(BigFloat, 1, 1)), acosh(interval(1)))
    @test subset(acosh(interval(BigFloat, -2, -0.9)), acosh(interval(-2, -0.9)))
    @test subset(acosh(interval(BigFloat, 3, 4)), acosh(interval(3, 4)))
end
