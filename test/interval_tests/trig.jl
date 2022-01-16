# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

@testset "sin" begin
    @test sin(Interval(0.5)) ≛ Interval(0.47942553860420295, 0.47942553860420301)
    @test sin(Interval(0.5, 1.67)) ≛ Interval(4.7942553860420295e-01, 1.0)
    @test sin(Interval(1.67, 3.2)) ≛ Interval(-5.8374143427580093e-02, 9.9508334981018021e-01)
    @test_broken sin(Interval(2.1, 5.6)) ≛ Interval(-1.0, 0.863209366648874)
    @test sin(Interval(0.5, 8.5)) ≛ Interval(-1.0, 1.0)
    @test sin(Interval{Float64}(-4.5, 0.1)) ≛ Interval(-1.0, 0.9775301176650971)
    @test sin(Interval{Float64}(1.3, 6.3)) ≛ Interval(-1.0, 1.0)

    @test sin(Interval{BigFloat}(0.5)) ⊆ sin(Interval(0.5))
    @test sin(Interval{BigFloat}(0.5, 1.67)) ⊆ sin(Interval(0.5, 1.67))
    @test sin(Interval{BigFloat}(1.67, 3.2)) ⊆ sin(Interval(1.67, 3.2))
    @test sin(Interval{BigFloat}(2.1, 5.6)) ⊆ sin(Interval(2.1, 5.6))
    @test sin(Interval{BigFloat}(0.5, 8.5)) ⊆ sin(Interval(0.5, 8.5))
    @test sin(Interval{BigFloat}(-4.5, 0.1)) ⊆ sin(Interval(-4.5, 0.1))
    @test sin(Interval{BigFloat}(1.3, 6.3)) ⊆ sin(Interval(1.3, 6.3))
end

@testset "cos" begin
    @test cos(Interval(0.5)) ≛ Interval(0.87758256189037265, 0.87758256189037276)
    @test cos(Interval(0.5, 1.67)) ≛ Interval(cos(1.67, RoundDown), cos(0.5, RoundUp))
    @test_broken cos(Interval(2.1, 5.6)) ≛ Interval(-1.0, 0.77556587851025016)
    @test cos(Interval(0.5, 8.5)) ≛ Interval(-1.0, 1.0)
    @test cos(Interval(1.67, 3.2)) ≛ Interval(-1.0, -0.09904103659872801)

    @test cos(Interval{BigFloat}(0.5)) ⊆ cos(Interval(0.5))
    @test cos(Interval{BigFloat}(0.5, 1.67)) ⊆ cos(Interval(0.5, 1.67))
    @test cos(Interval{BigFloat}(1.67, 3.2)) ⊆ cos(Interval(1.67, 3.2))
    @test cos(Interval{BigFloat}(2.1, 5.6)) ⊆ cos(Interval(2.1, 5.6))
    @test cos(Interval{BigFloat}(0.5, 8.5)) ⊆ cos(Interval(0.5, 8.5))
    @test cos(Interval{BigFloat}(-4.5, 0.1)) ⊆ cos(Interval(-4.5, 0.1))
    @test cos(Interval{BigFloat}(1.3, 6.3)) ⊆ cos(Interval(1.3, 6.3))
end

@testset "sinpi" begin
    @test sinpi(∅) ≛ ∅
    @test sinpi(0.5 .. 1.5) ≛ Interval(-1 , 1)
    @test sinpi(1 .. 2) ⊇ Interval(-1 , 0)
    @test sinpi(0.25 .. 0.75) ⊇ Interval(1/sqrt(2) , 1)
    @test sinpi(-0.25 .. 0.25) ⊇ Interval(-1/sqrt(2) , 1/sqrt(2))
end

@testset "cospi" begin
    @test cospi(∅) ≛ ∅
    @test cospi(1 .. 2) ≛ Interval(-1 , 1)
    @test cospi(0.5 .. 1.5) ⊇ Interval(-1 , 0)
    @test cospi(0.25 .. 0.75) ⊇ Interval(-1/sqrt(2) , 1/sqrt(2))
    @test cospi(-0.25 .. 0.25) ≛ Interval(1/sqrt(2) , 1)
end

@testset "tan" begin
    @test tan(Interval(0.5)) ≛ Interval(0.54630248984379048, 0.5463024898437906)
    @test tan(Interval(0.5, 1.67)) ≛ entireinterval()
    @test tan(Interval(1.67, 3.2)) ≛ Interval(-10.047182299210307, 0.05847385445957865)
    @test tan(Interval(6.638314112824137, 8.38263151220128)) ≛ entireinterval()  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test tan(Interval{BigFloat}(0.5)) ⊆ tan(Interval(0.5))
    @test tan(Interval{BigFloat}(0.5, 1.67)) ≛ entireinterval(BigFloat)
    @test tan(Interval{BigFloat}(0.5, 1.67)) ⊆ tan(Interval(0.5, 1.67))
    @test tan(Interval{BigFloat}(1.67, 3.2)) ⊆ tan(Interval(1.67, 3.2))
    @test tan(Interval{BigFloat}(2.1, 5.6)) ⊆ tan(Interval(2.1, 5.6))
    @test tan(Interval{BigFloat}(0.5, 8.5)) ⊆ tan(Interval(0.5, 8.5))
    @test tan(Interval{BigFloat}(-4.5, 0.1)) ⊆ tan(Interval(-4.5, 0.1))
    @test tan(Interval{BigFloat}(1.3, 6.3)) ⊆ tan(Interval(1.3, 6.3))

end

@testset "Inverse trig" begin
    @test asin(Interval(1)) ≛ Interval(pi)/2
    @test asin(Interval(0.9, 2)) ≛ asin(Interval(0.9, 1))
    @test asin(Interval(3, 4)) ≛ ∅

    @test asin(Interval{BigFloat}(1)) ⊆ asin(Interval(1))
    @test asin(Interval{BigFloat}(0.9, 2)) ⊆ asin(Interval(0.9, 2))
    @test asin(Interval{BigFloat}(3, 4)) ⊆ asin(Interval(3, 4))

    @test acos(Interval(1)) ≛ Interval(0., 0.)
    @test acos(Interval(-2, -0.9)) ≛ acos(Interval(-1, -0.9))
    @test acos(Interval(3, 4)) ≛ ∅

    @test acos(Interval{BigFloat}(1)) ⊆ acos(Interval(1))
    @test acos(Interval{BigFloat}(-2, -0.9)) ⊆ acos(Interval(-2, -0.9))
    @test acos(Interval{BigFloat}(3, 4)) ⊆ acos(Interval(3, 4))

    @test atan(Interval(-1,1)) ≛
        Interval(-Interval{Float64}(π).hi/4, Interval{Float64}(π).hi/4)
    @test atan(Interval(0)) ≛ Interval(0.0, 0.0)
    @test atan(Interval{BigFloat}(-1, 1)) ⊆ atan(Interval(-1, 1))
end

@testset "atan" begin
    @test atan(∅, entireinterval()) ≛ ∅
    @test atan(entireinterval(), ∅) ≛ ∅
    @test atan(Interval(0.0, 1.0), Interval{BigFloat}(0.0)) ≛ Interval{BigFloat}(pi)/2
    @test atan(Interval(0.0, 1.0), Interval(0.0)) ≛ Interval(pi)/2
    @test atan(Interval(-1.0, -0.1), Interval(0.0)) ≛ -Interval(pi)/2
    @test atan(Interval(-1.0, 1.0), Interval(0.0)) ≛ (-0.5..0.5) * Interval(pi)
    @test atan(Interval(0.0), Interval(0.1, 1.0)) ≛ Interval(0.0)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(0.1, 1.0)) ⊆
        atan(Interval(0.0, 0.1), Interval(0.1, 1.0))
    @test atan(Interval(0.0, 0.1), Interval(0.1, 1.0)) ≛
        Interval(0.0, 0.7853981633974484)
    @test atan(Interval{BigFloat}(-0.1, 0.0), Interval{BigFloat}(0.1, 1.0)) ⊆
        atan(Interval(-0.1, 0.0), Interval(0.1, 1.0))
    @test atan(Interval(-0.1, 0.0), Interval(0.1, 1.0)) ≛
        Interval(-0.7853981633974484, 0.0)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(0.1, Inf)) ⊆
        atan(Interval(-0.1, -0.1), Interval(0.1, Inf))
    @test atan(Interval(-0.1, 0.0), Interval(0.1, Inf)) ≛
        Interval(-0.7853981633974484, 0.0)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-2.0, -0.1)) ⊆
        atan(Interval(0.0, 0.1), Interval(-2.0, -0.1))
    @test atan(Interval(0.0, 0.1), Interval(-2.0, -0.1)) ≛
        Interval(2.356194490192345, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, 0.0), Interval{BigFloat}(-2.0, -0.1)) ⊆
        atan(Interval(-0.1, 0.0), Interval(-2.0, -0.1))
    @test atan(Interval(-0.1, 0.0), Interval(-2.0, -0.1)) ≛
        (-1..1) * Interval(pi)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-Inf, -0.1)) ⊆
        atan(Interval(-0.1, 0.1), Interval(-Inf, -0.1))
    @test atan(Interval(-0.1, 0.1), Interval(-Inf, -0.1)) ≛
        (-1..1) * Interval(pi)

    @test atan(Interval{BigFloat}(0.0, 0.0), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(Interval(0.0, 0.0), Interval(-2.0, 0.0))
    @test atan(Interval(-0.0, 0.0), Interval(-2.0, 0.0)) ≛
        Interval(3.141592653589793, 3.1415926535897936)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(Interval(0.0, 0.1), Interval(-0.1, 0.0))
    @test atan(Interval(-0.0, 0.1), Interval(-0.1, 0.0)) ≛
        Interval(1.5707963267948966, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(Interval(-0.1, -0.1), Interval(-0.1, 0.0))
    @test atan(Interval(-0.1, -0.1), Interval(-0.1, 0.0)) ≛
        Interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(Interval(-0.1, 0.1), Interval(-2.0, 0.0))
    @test atan(Interval(-0.1, 0.1), Interval(-2.0, 0.0)) ≛
        (-1..1) * Interval(pi)

    @test atan(Interval{BigFloat}(0.0, 0.0), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(Interval(0.0, 0.0), Interval(-2.0, 0.0))
    @test atan(Interval(-0.0, 0.0), Interval(-2.0, 0.0)) ≛
        Interval(3.141592653589793, 3.1415926535897936)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(Interval(0.0, 0.1), Interval(-0.1, 0.0))
    @test atan(Interval(-0.0, 0.1), Interval(-0.1, 0.0)) ≛
        Interval(1.5707963267948966, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(Interval(-0.1, -0.1), Interval(-0.1, 0.0))
    @test atan(Interval(-0.1, -0.1), Interval(-0.1, 0.0)) ≛
        Interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(Interval(-0.1, 0.1), Interval(-2.0, 0.0))
    @test atan(Interval(-0.1, 0.1), Interval(-2.0, 0.0)) ≛
        (-1..1) * Interval(pi)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-2.0, 0.1)) ⊆
        atan(Interval(0.0, 0.1), Interval(-2.0, 0.1))
    @test atan(Interval(-0.0, 0.1), Interval(-2.0, 0.1)) ≛
        Interval(0.0, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(-0.1, 0.1)) ⊆
        atan(Interval(-0.1, -0.1), Interval(-0.1, 0.1))
    @test atan(Interval(-0.1, -0.1), Interval(-0.1, 0.1)) ≛
        Interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp))
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-2.0, 0.1)) ⊆
        atan(Interval(-0.1, 0.1), Interval(-2.0, 0.1))
    @test (-1..1) * Interval(π) ≛ atan(Interval(-0.1, 0.1), Interval(-2.0, 0.1))

    @test atan(Interval(-0.1, 0.1), Interval(0.1, 0.1)) ≛
        Interval(-0.7853981633974484, 0.7853981633974484)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(0.1, 0.1)) ⊆
        atan(Interval(-0.1, 0.1), Interval(0.1, 0.1))
    @test atan(Interval(0.0), Interval(-0.0, 0.1)) ≛ Interval(0.0)
    @test atan(Interval(0.0, 0.1), Interval(-0.0, 0.1)) ≛
        Interval(0.0, 1.5707963267948968)
    @test atan(Interval(-0.1, 0.0), Interval(0.0, 0.1)) ≛
        Interval(-1.5707963267948968, 0.0)
    @test atan(Interval(-0.1, 0.1), Interval(-0.0, 0.1)) ≛
        Interval(-1.5707963267948968, 1.5707963267948968)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-0.0, 0.1)) ⊆
        atan(Interval(-0.1, 0.1), Interval(0.0, 0.1))

    @test atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(0.1, 0.1)) ≛
        Interval(-0.78539824f0, 0.78539824f0)
    @test atan(Interval(-0.1, 0.1), Interval(0.1, 0.1)) ⊆
        atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(0.1, 0.1))
    @test atan(Interval{Float32}(0.0, 0.0), Interval{Float32}(-0.0, 0.1)) ≛
        Interval{Float32}(0.0, 0.0)
    @test atan(Interval{Float32}(0.0, 0.1), Interval{Float32}(-0.0, 0.1)) ≛
        Interval(0.0, 1.5707964f0)
    @test atan(Interval{Float32}(-0.1, 0.0), Interval{Float32}(0.0, 0.1)) ≛
        Interval(-1.5707964f0, 0.0)
    @test atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(-0.0, 0.1)) ≛
        Interval(-1.5707964f0, 1.5707964f0)
    @test atan(Interval(-0.1, 0.1), Interval(-0.0, 0.1)) ⊆
        atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(0.0, 0.1))
end

@testset "Trig" begin
    for a in ( Interval(17, 19), Interval(0.5, 1.2) )
        @test tan(a) ⊆ sin(a)/cos(a)
    end

    @test sin(Interval(-pi/2, 3pi/2)) ≛ Interval(-1, 1)
    @test cos(Interval(-pi/2, 3pi/2)) ≛ Interval(-1, 1)
end

@testset "Trig with large arguments" begin
    x = Interval(2.)^1000   # this is a thin interval
    @test diam(x) == 0.0

    @test sin(x) ≛ Interval(-0.15920170308624246, -0.15920170308624243)
    @test cos(x) ≛ Interval(0.9872460775989135, 0.9872460775989136)
    @test tan(x) ≛ Interval(-0.16125837995065806, -0.16125837995065803)

    x = Interval(prevfloat(∞), ∞)
    @test sin(x) ≛ -1..1
    @test cos(x) ≛ -1..1
    @test tan(x) ≛ -∞..∞
end
