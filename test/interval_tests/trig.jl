# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

@testset "sin" begin
    @test sin(interval(0.5)) ≛ interval(0.47942553860420295, 0.47942553860420301)
    @test sin(interval(0.5, 1.67)) ≛ interval(4.7942553860420295e-01, 1.0)
    @test sin(interval(1.67, 3.2)) ≛ interval(-5.8374143427580093e-02, 9.9508334981018021e-01)
    @test_broken sin(interval(2.1, 5.6)) ≛ interval(-1.0, 0.863209366648874)
    @test sin(interval(0.5, 8.5)) ≛ interval(-1.0, 1.0)
    @test sin(Interval{Float64}(-4.5, 0.1)) ≛ interval(-1.0, 0.9775301176650971)
    @test sin(Interval{Float64}(1.3, 6.3)) ≛ interval(-1.0, 1.0)

    @test sin(Interval{BigFloat}(0.5, 0.5)) ⊆ sin(interval(0.5))
    @test sin(Interval{BigFloat}(0.5, 1.67)) ⊆ sin(interval(0.5, 1.67))
    @test sin(Interval{BigFloat}(1.67, 3.2)) ⊆ sin(interval(1.67, 3.2))
    @test sin(Interval{BigFloat}(2.1, 5.6)) ⊆ sin(interval(2.1, 5.6))
    @test sin(Interval{BigFloat}(0.5, 8.5)) ⊆ sin(interval(0.5, 8.5))
    @test sin(Interval{BigFloat}(-4.5, 0.1)) ⊆ sin(interval(-4.5, 0.1))
    @test sin(Interval{BigFloat}(1.3, 6.3)) ⊆ sin(interval(1.3, 6.3))
end

@testset "cos" begin
    @test cos(interval(0.5)) ≛ interval(0.87758256189037265, 0.87758256189037276)
    @test cos(interval(0.5, 1.67)) ≛ interval(cos(1.67, RoundDown), cos(0.5, RoundUp))
    @test_broken cos(interval(2.1, 5.6)) ≛ interval(-1.0, 0.77556587851025016)
    @test cos(interval(0.5, 8.5)) ≛ interval(-1.0, 1.0)
    @test cos(interval(1.67, 3.2)) ≛ interval(-1.0, -0.09904103659872801)

    @test cos(Interval{BigFloat}(0.5, 0.5)) ⊆ cos(interval(0.5))
    @test cos(Interval{BigFloat}(0.5, 1.67)) ⊆ cos(interval(0.5, 1.67))
    @test cos(Interval{BigFloat}(1.67, 3.2)) ⊆ cos(interval(1.67, 3.2))
    @test cos(Interval{BigFloat}(2.1, 5.6)) ⊆ cos(interval(2.1, 5.6))
    @test cos(Interval{BigFloat}(0.5, 8.5)) ⊆ cos(interval(0.5, 8.5))
    @test cos(Interval{BigFloat}(-4.5, 0.1)) ⊆ cos(interval(-4.5, 0.1))
    @test cos(Interval{BigFloat}(1.3, 6.3)) ⊆ cos(interval(1.3, 6.3))
end

@testset "sinpi" begin
    @test sinpi(∅) ≛ ∅
    @test sinpi(0.5 .. 1.5) ≛ interval(-1 , 1)
    @test sinpi(1 .. 2) ⊇ interval(-1 , 0)
    @test sinpi(0.25 .. 0.75) ⊇ interval(1/sqrt(2) , 1)
    @test sinpi(-0.25 .. 0.25) ⊇ interval(-1/sqrt(2) , 1/sqrt(2))
end

@testset "cospi" begin
    @test cospi(∅) ≛ ∅
    @test cospi(1 .. 2) ≛ interval(-1 , 1)
    @test cospi(0.5 .. 1.5) ⊇ interval(-1 , 0)
    @test cospi(0.25 .. 0.75) ⊇ interval(-1/sqrt(2) , 1/sqrt(2))
    @test cospi(-0.25 .. 0.25) ≛ interval(1/sqrt(2) , 1)
end

@testset "tan" begin
    @test tan(interval(0.5)) ≛ interval(0.54630248984379048, 0.5463024898437906)
    @test tan(interval(0.5, 1.67)) ≛ entireinterval()
    @test tan(interval(1.67, 3.2)) ≛ interval(-10.047182299210307, 0.05847385445957865)
    @test tan(interval(6.638314112824137, 8.38263151220128)) ≛ entireinterval()  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test tan(Interval{BigFloat}(0.5, 0.5)) ⊆ tan(interval(0.5))
    @test tan(Interval{BigFloat}(0.5, 1.67)) ≛ entireinterval(BigFloat)
    @test tan(Interval{BigFloat}(0.5, 1.67)) ⊆ tan(interval(0.5, 1.67))
    @test tan(Interval{BigFloat}(1.67, 3.2)) ⊆ tan(interval(1.67, 3.2))
    @test tan(Interval{BigFloat}(2.1, 5.6)) ⊆ tan(interval(2.1, 5.6))
    @test tan(Interval{BigFloat}(0.5, 8.5)) ⊆ tan(interval(0.5, 8.5))
    @test tan(Interval{BigFloat}(-4.5, 0.1)) ⊆ tan(interval(-4.5, 0.1))
    @test tan(Interval{BigFloat}(1.3, 6.3)) ⊆ tan(interval(1.3, 6.3))

end

@testset "Inverse trig" begin
    @test asin(interval(1)) ≛ interval(pi)/2
    @test asin(interval(0.9, 2)) ≛ asin(interval(0.9, 1))
    @test asin(interval(3, 4)) ≛ ∅

    @test asin(Interval{BigFloat}(1, 1)) ⊆ asin(interval(1))
    @test asin(Interval{BigFloat}(0.9, 2)) ⊆ asin(interval(0.9, 2))
    @test asin(Interval{BigFloat}(3, 4)) ⊆ asin(interval(3, 4))

    @test acos(interval(1)) ≛ interval(0., 0.)
    @test acos(interval(-2, -0.9)) ≛ acos(interval(-1, -0.9))
    @test acos(interval(3, 4)) ≛ ∅

    @test acos(Interval{BigFloat}(1, 1)) ⊆ acos(interval(1))
    @test acos(Interval{BigFloat}(-2, -0.9)) ⊆ acos(interval(-2, -0.9))
    @test acos(Interval{BigFloat}(3, 4)) ⊆ acos(interval(3, 4))

    @test atan(interval(-1,1)) ≛
    interval(-interval(Float64, π).hi/4, interval(Float64, π).hi/4)
    @test atan(interval(0)) ≛ interval(0.0, 0.0)
    @test atan(Interval{BigFloat}(-1, 1)) ⊆ atan(interval(-1, 1))
end

@testset "atan" begin
    @test atan(∅, entireinterval()) ≛ ∅
    @test atan(entireinterval(), ∅) ≛ ∅
    @test atan(interval(0.0, 1.0), Interval{BigFloat}(0.0, 0.0)) ≛ interval(BigFloat, pi)/2
    @test atan(interval(0.0, 1.0), interval(0.0)) ≛ interval(pi)/2
    @test atan(interval(-1.0, -0.1), interval(0.0)) ≛ -interval(pi)/2
    @test atan(interval(-1.0, 1.0), interval(0.0)) ≛ (-0.5..0.5) * interval(pi)
    @test atan(interval(0.0), interval(0.1, 1.0)) ≛ interval(0.0)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(0.1, 1.0)) ⊆
        atan(interval(0.0, 0.1), interval(0.1, 1.0))
    @test atan(interval(0.0, 0.1), interval(0.1, 1.0)) ≛
        interval(0.0, 0.7853981633974484)
    @test atan(Interval{BigFloat}(-0.1, 0.0), Interval{BigFloat}(0.1, 1.0)) ⊆
        atan(interval(-0.1, 0.0), interval(0.1, 1.0))
    @test atan(interval(-0.1, 0.0), interval(0.1, 1.0)) ≛
        interval(-0.7853981633974484, 0.0)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(0.1, Inf)) ⊆
        atan(interval(-0.1, -0.1), interval(0.1, Inf))
    @test atan(interval(-0.1, 0.0), interval(0.1, Inf)) ≛
        interval(-0.7853981633974484, 0.0)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-2.0, -0.1)) ⊆
        atan(interval(0.0, 0.1), interval(-2.0, -0.1))
    @test atan(interval(0.0, 0.1), interval(-2.0, -0.1)) ≛
        interval(2.356194490192345, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, 0.0), Interval{BigFloat}(-2.0, -0.1)) ⊆
        atan(interval(-0.1, 0.0), interval(-2.0, -0.1))
    @test atan(interval(-0.1, 0.0), interval(-2.0, -0.1)) ≛
        (-1..1) * interval(pi)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-Inf, -0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(-Inf, -0.1))
    @test atan(interval(-0.1, 0.1), interval(-Inf, -0.1)) ≛
        (-1..1) * interval(pi)

    @test atan(Interval{BigFloat}(0.0, 0.0), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(interval(0.0, 0.0), interval(-2.0, 0.0))
    @test atan(interval(-0.0, 0.0), interval(-2.0, 0.0)) ≛
        interval(3.141592653589793, 3.1415926535897936)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(interval(0.0, 0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.0, 0.1), interval(-0.1, 0.0)) ≛
        interval(1.5707963267948966, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.1, -0.1), interval(-0.1, 0.0)) ≛
        interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0))
    @test atan(interval(-0.1, 0.1), interval(-2.0, 0.0)) ≛
        (-1..1) * interval(pi)

    @test atan(Interval{BigFloat}(0.0, 0.0), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(interval(0.0, 0.0), interval(-2.0, 0.0))
    @test atan(interval(-0.0, 0.0), interval(-2.0, 0.0)) ≛
        interval(3.141592653589793, 3.1415926535897936)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(interval(0.0, 0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.0, 0.1), interval(-0.1, 0.0)) ≛
        interval(1.5707963267948966, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(-0.1, 0.0)) ⊆
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.1, -0.1), interval(-0.1, 0.0)) ≛
        interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-2.0, 0.0)) ⊆
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0))
    @test atan(interval(-0.1, 0.1), interval(-2.0, 0.0)) ≛
        (-1..1) * interval(pi)
    @test atan(Interval{BigFloat}(0.0, 0.1), Interval{BigFloat}(-2.0, 0.1)) ⊆
        atan(interval(0.0, 0.1), interval(-2.0, 0.1))
    @test atan(interval(-0.0, 0.1), interval(-2.0, 0.1)) ≛
        interval(0.0, 3.1415926535897936)
    @test atan(Interval{BigFloat}(-0.1, -0.1), Interval{BigFloat}(-0.1, 0.1)) ⊆
        atan(interval(-0.1, -0.1), interval(-0.1, 0.1))
    @test atan(interval(-0.1, -0.1), interval(-0.1, 0.1)) ≛
        interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp))
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-2.0, 0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(-2.0, 0.1))
    @test (-1..1) * interval(π) ≛ atan(interval(-0.1, 0.1), interval(-2.0, 0.1))

    @test atan(interval(-0.1, 0.1), interval(0.1, 0.1)) ≛
        interval(-0.7853981633974484, 0.7853981633974484)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(0.1, 0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(0.1, 0.1))
    @test atan(interval(0.0), interval(-0.0, 0.1)) ≛ interval(0.0)
    @test atan(interval(0.0, 0.1), interval(-0.0, 0.1)) ≛
        interval(0.0, 1.5707963267948968)
    @test atan(interval(-0.1, 0.0), interval(0.0, 0.1)) ≛
        interval(-1.5707963267948968, 0.0)
    @test atan(interval(-0.1, 0.1), interval(-0.0, 0.1)) ≛
        interval(-1.5707963267948968, 1.5707963267948968)
    @test atan(Interval{BigFloat}(-0.1, 0.1), Interval{BigFloat}(-0.0, 0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(0.0, 0.1))

    @test atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(0.1, 0.1)) ≛
        interval(-0.78539824f0, 0.78539824f0)
    @test atan(interval(-0.1, 0.1), interval(0.1, 0.1)) ⊆
        atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(0.1, 0.1))
    @test atan(Interval{Float32}(0.0, 0.0), Interval{Float32}(-0.0, 0.1)) ≛
        Interval{Float32}(0.0, 0.0)
    @test atan(Interval{Float32}(0.0, 0.1), Interval{Float32}(-0.0, 0.1)) ≛
        interval(0.0, 1.5707964f0)
    @test atan(Interval{Float32}(-0.1, 0.0), Interval{Float32}(0.0, 0.1)) ≛
        interval(-1.5707964f0, 0.0)
    @test atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(-0.0, 0.1)) ≛
        interval(-1.5707964f0, 1.5707964f0)
    @test atan(interval(-0.1, 0.1), interval(-0.0, 0.1)) ⊆
        atan(Interval{Float32}(-0.1, 0.1), Interval{Float32}(0.0, 0.1))
end

@testset "Trig" begin
    for a in ( interval(17, 19), interval(0.5, 1.2) )
        @test tan(a) ⊆ sin(a)/cos(a)
    end

    @test sin(interval(-pi/2, 3pi/2)) ≛ interval(-1, 1)
    @test cos(interval(-pi/2, 3pi/2)) ≛ interval(-1, 1)
end

@testset "Trig with large arguments" begin
    x = interval(2.)^1000   # this is a thin interval
    @test diam(x) == 0.0

    @test sin(x) ≛ interval(-0.15920170308624246, -0.15920170308624243)
    @test cos(x) ≛ interval(0.9872460775989135, 0.9872460775989136)
    @test tan(x) ≛ interval(-0.16125837995065806, -0.16125837995065803)

    x = interval(prevfloat(∞), ∞)
    @test sin(x) ≛ -1..1
    @test cos(x) ≛ -1..1
    @test tan(x) ≛ -∞..∞
end
