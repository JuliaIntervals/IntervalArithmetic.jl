# This file is part of the IntervalArithmetic.jl package; MIT licensed

@testset "sinh" begin
    @test sinh(emptyinterval()) ≛ emptyinterval()
    @test sinh(interval(0.5)) ≛ interval(0.5210953054937473, 0.5210953054937474)
    @test sinh(interval(0.5, 1.67)) ≛ interval(0.5210953054937473, 2.5619603657712102)
    @test sinh(interval(-4.5, 0.1)) ≛ interval(-45.00301115199179, 0.10016675001984404)
    @test sinh(Interval{BigFloat}(0.5, 0.5)) ⊆ sinh(interval(0.5))

    @test sinh(Interval{BigFloat}(0.5, 1.67)) ⊆ sinh(interval(0.5, 1.67))
    @test sinh(Interval{BigFloat}(1.67, 3.2)) ⊆ sinh(interval(1.67, 3.2))
    @test sinh(Interval{BigFloat}(2.1, 5.6)) ⊆ sinh(interval(2.1, 5.6))
    @test sinh(Interval{BigFloat}(0.5, 8.5)) ⊆ sinh(interval(0.5, 8.5))
    @test sinh(Interval{BigFloat}(-4.5, 0.1)) ⊆ sinh(interval(-4.5, 0.1))
    @test sinh(Interval{BigFloat}(1.3, 6.3)) ⊆ sinh(interval(1.3, 6.3))
end

@testset "cosh" begin
    @test cosh(emptyinterval()) ≛ emptyinterval()
    @test cosh(interval(0.5)) ≛ interval(1.1276259652063807, 1.127625965206381)
    @test cosh(interval(0.5, 1.67)) ≛ interval(1.1276259652063807, 2.750207431409957)
    @test cosh(interval(-4.5, 0.1)) ≛ interval(1.0, 45.01412014853003)

    @test cosh(Interval{BigFloat}(0.5, 0.5)) ⊆ cosh(interval(0.5))
    @test cosh(Interval{BigFloat}(0.5, 1.67)) ⊆ cosh(interval(0.5, 1.67))
    @test cosh(Interval{BigFloat}(1.67, 3.2)) ⊆ cosh(interval(1.67, 3.2))
    @test cosh(Interval{BigFloat}(2.1, 5.6)) ⊆ cosh(interval(2.1, 5.6))
    @test cosh(Interval{BigFloat}(0.5, 8.5)) ⊆ cosh(interval(0.5, 8.5))
    @test cosh(Interval{BigFloat}(-4.5, 0.1)) ⊆ cosh(interval(-4.5, 0.1))
    @test cosh(Interval{BigFloat}(1.3, 6.3)) ⊆ cosh(interval(1.3, 6.3))
end

@testset "tanh" begin
    @test tanh(emptyinterval()) ≛ emptyinterval()
    @test tanh(interval(0.5)) ≛ interval(0.46211715726000974, 0.4621171572600098)
    @test tanh(interval(0.5, 1.67)) ≛ interval(0.46211715726000974, 0.9315516846152083)
    @test tanh(interval(-4.5, 0.1)) ≛ interval(-0.9997532108480276, 0.09966799462495583)

    @test tanh(Interval{BigFloat}(0.5, 0.5)) ⊆ tanh(interval(0.5))
    @test tanh(Interval{BigFloat}(0.5, 1.67)) ⊆ tanh(interval(0.5, 1.67))
    @test tanh(Interval{BigFloat}(1.67, 3.2)) ⊆ tanh(interval(1.67, 3.2))
    @test tanh(Interval{BigFloat}(2.1, 5.6)) ⊆ tanh(interval(2.1, 5.6))
    @test tanh(Interval{BigFloat}(0.5, 8.5)) ⊆ tanh(interval(0.5, 8.5))
    @test tanh(Interval{BigFloat}(-4.5, 0.1)) ⊆ tanh(interval(-4.5, 0.1))
    @test tanh(Interval{BigFloat}(1.3, 6.3)) ⊆ tanh(interval(1.3, 6.3))

    @test tanh(interval(-4.5, 0.1)) ⊆ tanh(Interval{Float32}(-4.5, 0.1))
    @test tanh(interval(1.3, 6.3)) ⊆ tanh(Interval{Float32}(1.3, 6.3))

    for a in [ interval(17, 19), interval(0.5, 1.2) ]
        @test tanh(a) ⊆ sinh(a)/cosh(a)
    end
end

# TODO For reason unkown these tests fail when put in the previous testset
@testset "tanh with Float32" begin
    @test tanh(interval(0.5)) ⊆ tanh(Interval{Float32}(0.5, 0.5))
    @test tanh(interval(0.5, 1.67)) ⊆ tanh(Interval{Float32}(0.5, 1.67))
    @test tanh(interval(1.67, 3.2)) ⊆ tanh(Interval{Float32}(1.67, 3.2))
    @test tanh(interval(2.1, 5.6))  ⊆ tanh(Interval{Float32}(2.1, 5.6))
    @test tanh(interval(0.5, 8.5))  ⊆ tanh(Interval{Float32}(0.5, 8.5))
end

@testset "inverse" begin
    @test asinh(Interval{BigFloat}(1, 1)) ⊆ asinh(interval(1))
    @test asinh(Interval{BigFloat}(0.9, 2)) ⊆ asinh(interval(0.9, 2))
    @test asinh(Interval{BigFloat}(3, 4)) ⊆ asinh(interval(3, 4))

    @test acosh(Interval{BigFloat}(1, 1)) ⊆ acosh(interval(1))
    @test acosh(Interval{BigFloat}(-2, -0.9)) ⊆ acosh(interval(-2, -0.9))
    @test acosh(Interval{BigFloat}(3, 4)) ⊆ acosh(interval(3, 4))
end
