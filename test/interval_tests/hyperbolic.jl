# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

setprecision(Interval, 128)
setprecision(Interval, Float64)

@testset "Hyperb tests" begin
    @test sinh(emptyinterval()) == emptyinterval()
    @test sinh(Interval(0.5)) == Interval(0.5210953054937473, 0.5210953054937474)
    @test sinh(Interval(0.5, 1.67)) == Interval(0.5210953054937473, 2.5619603657712102)
    @test sinh(Interval(-4.5, 0.1)) == Interval(-45.00301115199179, 0.10016675001984404)
    @test sinh(@biginterval(0.5)) ⊆ sinh(@interval(0.5))


    @test sinh(@biginterval(0.5, 1.67)) ⊆ sinh(@interval(0.5, 1.67))
    @test sinh(@biginterval(1.67, 3.2)) ⊆ sinh(@interval(1.67, 3.2))
    @test sinh(@biginterval(2.1, 5.6)) ⊆ sinh(@interval(2.1, 5.6))
    @test sinh(@biginterval(0.5, 8.5)) ⊆ sinh(@interval(0.5, 8.5))
    @test sinh(@biginterval(-4.5, 0.1)) ⊆ sinh(@interval(-4.5, 0.1))
    @test sinh(@biginterval(1.3, 6.3)) ⊆ sinh(@interval(1.3, 6.3))

    @test cosh(emptyinterval()) == emptyinterval()
    @test cosh(Interval(0.5)) == Interval(1.1276259652063807, 1.127625965206381)
    @test cosh(Interval(0.5, 1.67)) == Interval(1.1276259652063807, 2.750207431409957)
    @test cosh(Interval(-4.5, 0.1)) == Interval(1.0, 45.01412014853003)
    @test cosh(@biginterval(0.5)) ⊆ cosh(@interval(0.5))
    @test cosh(@biginterval(0.5, 1.67)) ⊆ cosh(@interval(0.5, 1.67))
    @test cosh(@biginterval(1.67, 3.2)) ⊆ cosh(@interval(1.67, 3.2))
    @test cosh(@biginterval(2.1, 5.6)) ⊆ cosh(@interval(2.1, 5.6))
    @test cosh(@biginterval(0.5, 8.5)) ⊆ cosh(@interval(0.5, 8.5))
    @test cosh(@biginterval(-4.5, 0.1)) ⊆ cosh(@interval(-4.5, 0.1))
    @test cosh(@biginterval(1.3, 6.3)) ⊆ cosh(@interval(1.3, 6.3))

    @test tanh(emptyinterval()) == emptyinterval()
    @test tanh(Interval(0.5)) == Interval(0.46211715726000974, 0.4621171572600098)
    @test tanh(Interval(0.5, 1.67)) == Interval(0.46211715726000974, 0.9315516846152083)
    @test tanh(Interval(-4.5, 0.1)) == Interval(-0.9997532108480276, 0.09966799462495583)

    @test tanh(@biginterval(0.5)) ⊆ tanh(@interval(0.5))
    @test tanh(@biginterval(0.5, 1.67)) ⊆ tanh(@interval(0.5, 1.67))
    @test tanh(@biginterval(1.67, 3.2)) ⊆ tanh(@interval(1.67, 3.2))
    @test tanh(@biginterval(2.1, 5.6)) ⊆ tanh(@interval(2.1, 5.6))
    @test tanh(@biginterval(0.5, 8.5)) ⊆ tanh(@interval(0.5, 8.5))
    @test tanh(@biginterval(-4.5, 0.1)) ⊆ tanh(@interval(-4.5, 0.1))
    @test tanh(@biginterval(1.3, 6.3)) ⊆ tanh(@interval(1.3, 6.3))

    @test tanh(@interval(0.5))       ⊆ tanh(@interval(Float32, 0.5, 0.5))
    @test tanh(@interval(0.5, 1.67)) ⊆ tanh(@interval(Float32, 0.5, 1.67))
    @test tanh(@interval(1.67, 3.2)) ⊆ tanh(@interval(Float32, 1.67, 3.2))
    @test tanh(@interval(2.1, 5.6))  ⊆ tanh(@interval(Float32, 2.1, 5.6))
    @test tanh(@interval(0.5, 8.5))  ⊆ tanh(@interval(Float32, 0.5, 8.5))
    @test tanh(@interval(-4.5, 0.1)) ⊆ tanh(@interval(Float32, -4.5, 0.1))
    @test tanh(@interval(1.3, 6.3))  ⊆ tanh(@interval(Float32, 1.3, 6.3))

    @test asinh(@biginterval(1)) ⊆ asinh(@interval(1))
    @test asinh(@biginterval(0.9, 2)) ⊆ asinh(@interval(0.9, 2))
    @test asinh(@biginterval(3, 4)) ⊆ asinh(@interval(3, 4))

    @test acosh(@biginterval(1)) ⊆ acosh(@interval(1))
    @test acosh(@biginterval(-2, -0.9)) ⊆ acosh(@interval(-2, -0.9))
    @test acosh(@biginterval(3, 4)) ⊆ acosh(@interval(3, 4))

    for a in ( Interval(17, 19), Interval(0.5, 1.2) )
        @test tanh(a) ⊆ sinh(a)/cosh(a)
    end
end
