# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

setprecision(Interval, 128)
setprecision(Interval, Float64)

@testset "sin" begin
    @test sin(@interval(0.5)) == Interval(0.47942553860420295, 0.47942553860420301)
    @test sin(@interval(0.5, 1.67)) == Interval(4.7942553860420295e-01, 1.0)
    @test sin(@interval(1.67, 3.2)) == Interval(-5.8374143427580093e-02, 9.9508334981018021e-01)
    @test sin(@interval(2.1, 5.6)) == Interval(-1.0, 0.863209366648874)
    @test sin(@interval(0.5, 8.5)) == Interval(-1.0, 1.0)
    @test sin(@floatinterval(-4.5, 0.1)) == Interval(-1.0, 0.9775301176650971)
    @test sin(@floatinterval(1.3, 6.3)) == Interval(-1.0, 1.0)

    @test sin(@biginterval(0.5)) ⊆ sin(@interval(0.5))
    @test sin(@biginterval(0.5, 1.67)) ⊆ sin(@interval(0.5, 1.67))
    @test sin(@biginterval(1.67, 3.2)) ⊆ sin(@interval(1.67, 3.2))
    @test sin(@biginterval(2.1, 5.6)) ⊆ sin(@interval(2.1, 5.6))
    @test sin(@biginterval(0.5, 8.5)) ⊆ sin(@interval(0.5, 8.5))
    @test sin(@biginterval(-4.5, 0.1)) ⊆ sin(@interval(-4.5, 0.1))
    @test sin(@biginterval(1.3, 6.3)) ⊆ sin(@interval(1.3, 6.3))
end

@testset "cos" begin
    @test cos(@interval(0.5)) == Interval(0.87758256189037265, 0.87758256189037276)
    @test cos(@interval(0.5, 1.67)) == Interval(-0.09904103659872825, 0.8775825618903728)
    @test cos(@interval(2.1, 5.6)) == Interval(-1.0, 0.77556587851025016)
    @test cos(@interval(0.5, 8.5)) == Interval(-1.0, 1.0)
    @test cos(@interval(1.67, 3.2)) == Interval(-1.0, -0.09904103659872801)

    @test cos(@biginterval(0.5)) ⊆ cos(@interval(0.5))
    @test cos(@biginterval(0.5, 1.67)) ⊆ cos(@interval(0.5, 1.67))
    @test cos(@biginterval(1.67, 3.2)) ⊆ cos(@interval(1.67, 3.2))
    @test cos(@biginterval(2.1, 5.6)) ⊆ cos(@interval(2.1, 5.6))
    @test cos(@biginterval(0.5, 8.5)) ⊆ cos(@interval(0.5, 8.5))
    @test cos(@biginterval(-4.5, 0.1)) ⊆ cos(@interval(-4.5, 0.1))
    @test cos(@biginterval(1.3, 6.3)) ⊆ cos(@interval(1.3, 6.3))
end

@testset "tan" begin
    @test tan(@interval(0.5)) == Interval(0.54630248984379048, 0.5463024898437906)
    @test tan(@interval(0.5, 1.67)) == entireinterval()
    @test tan(@interval(1.67, 3.2)) == Interval(-10.047182299210307, 0.05847385445957865)
    @test tan(Interval(6.638314112824137, 8.38263151220128)) == entireinterval()  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test tan(@biginterval(0.5)) ⊆ tan(@interval(0.5))
    @test tan(@biginterval(0.5, 1.67)) == entireinterval(BigFloat)
    @test tan(@biginterval(0.5, 1.67)) ⊆ tan(@interval(0.5, 1.67))
    @test tan(@biginterval(1.67, 3.2)) ⊆ tan(@interval(1.67, 3.2))
    @test tan(@biginterval(2.1, 5.6)) ⊆ tan(@interval(2.1, 5.6))
    @test tan(@biginterval(0.5, 8.5)) ⊆ tan(@interval(0.5, 8.5))
    @test tan(@biginterval(-4.5, 0.1)) ⊆ tan(@interval(-4.5, 0.1))
    @test tan(@biginterval(1.3, 6.3)) ⊆ tan(@interval(1.3, 6.3))

end

@testset "Inverse trig" begin
    @test asin(@interval(1)) == @interval(pi/2)#pi_interval(Float64)/2
    @test asin(@interval(0.9, 2)) == asin(@interval(0.9, 1))
    @test asin(@interval(3, 4)) == ∅

    @test asin(@biginterval(1)) ⊆ asin(@interval(1))
    @test asin(@biginterval(0.9, 2)) ⊆ asin(@interval(0.9, 2))
    @test asin(@biginterval(3, 4)) ⊆ asin(@interval(3, 4))

    @test acos(@interval(1)) == Interval(0., 0.)
    @test acos(@interval(-2, -0.9)) == acos(@interval(-1, -0.9))
    @test acos(@interval(3, 4)) == ∅

    @test acos(@biginterval(1)) ⊆ acos(@interval(1))
    @test acos(@biginterval(-2, -0.9)) ⊆ acos(@interval(-2, -0.9))
    @test acos(@biginterval(3, 4)) ⊆ acos(@interval(3, 4))

    @test atan(@interval(-1,1)) ==
        Interval(-pi_interval(Float64).hi/4, pi_interval(Float64).hi/4)
    @test atan(@interval(0)) == Interval(0.0, 0.0)
    @test atan(@biginterval(-1, 1)) ⊆ atan(@interval(-1, 1))
end

@testset "atan" begin
    @test atan(∅, entireinterval()) == ∅
    @test atan(entireinterval(), ∅) == ∅
    @test atan(@interval(0.0, 1.0), @biginterval(0.0)) == @biginterval(pi/2)
    @test atan(@interval(0.0, 1.0), @interval(0.0)) == @interval(pi/2)
    @test atan(@interval(-1.0, -0.1), @interval(0.0)) == @interval(-pi/2)
    @test atan(@interval(-1.0, 1.0), @interval(0.0)) == @interval(-pi/2, pi/2)
    @test atan(@interval(0.0), @interval(0.1, 1.0)) == @interval(0.0)
    @test atan(@biginterval(0.0, 0.1), @biginterval(0.1, 1.0)) ⊆
        atan(@interval(0.0, 0.1), @interval(0.1, 1.0))
    @test atan(@interval(0.0, 0.1), @interval(0.1, 1.0)) ==
        Interval(0.0, 0.7853981633974484)
    @test atan(@biginterval(-0.1, 0.0), @biginterval(0.1, 1.0)) ⊆
        atan(@interval(-0.1, 0.0), @interval(0.1, 1.0))
    @test atan(@interval(-0.1, 0.0), @interval(0.1, 1.0)) ==
        Interval(-0.7853981633974484, 0.0)
    @test atan(@biginterval(-0.1, -0.1), @biginterval(0.1, Inf)) ⊆
        atan(@interval(-0.1, -0.1), @interval(0.1, Inf))
    @test atan(@interval(-0.1, 0.0), @interval(0.1, Inf)) ==
        Interval(-0.7853981633974484, 0.0)
    @test atan(@biginterval(0.0, 0.1), @biginterval(-2.0, -0.1)) ⊆
        atan(@interval(0.0, 0.1), @interval(-2.0, -0.1))
    @test atan(@interval(0.0, 0.1), @interval(-2.0, -0.1)) ==
        Interval(2.356194490192345, 3.1415926535897936)
    @test atan(@biginterval(-0.1, 0.0), @biginterval(-2.0, -0.1)) ⊆
        atan(@interval(-0.1, 0.0), @interval(-2.0, -0.1))
    @test atan(@interval(-0.1, 0.0), @interval(-2.0, -0.1)) ==
        @interval(-pi, pi)
    @test atan(@biginterval(-0.1, 0.1), @biginterval(-Inf, -0.1)) ⊆
        atan(@interval(-0.1, 0.1), @interval(-Inf, -0.1))
    @test atan(@interval(-0.1, 0.1), @interval(-Inf, -0.1)) ==
        @interval(-pi, pi)

    @test atan(@biginterval(0.0, 0.0), @biginterval(-2.0, 0.0)) ⊆
        atan(@interval(0.0, 0.0), @interval(-2.0, 0.0))
    @test atan(@interval(-0.0, 0.0), @interval(-2.0, 0.0)) ==
        Interval(3.141592653589793, 3.1415926535897936)
    @test atan(@biginterval(0.0, 0.1), @biginterval(-0.1, 0.0)) ⊆
        atan(@interval(0.0, 0.1), @interval(-0.1, 0.0))
    @test atan(@interval(-0.0, 0.1), @interval(-0.1, 0.0)) ==
        Interval(1.5707963267948966, 3.1415926535897936)
    @test atan(@biginterval(-0.1, -0.1), @biginterval(-0.1, 0.0)) ⊆
        atan(@interval(-0.1, -0.1), @interval(-0.1, 0.0))
    @test atan(@interval(-0.1, -0.1), @interval(-0.1, 0.0)) ==
        Interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(@biginterval(-0.1, 0.1), @biginterval(-2.0, 0.0)) ⊆
        atan(@interval(-0.1, 0.1), @interval(-2.0, 0.0))
    @test atan(@interval(-0.1, 0.1), @interval(-2.0, 0.0)) ==
        @interval(-pi, pi)

    @test atan(@biginterval(0.0, 0.0), @biginterval(-2.0, 0.0)) ⊆
        atan(@interval(0.0, 0.0), @interval(-2.0, 0.0))
    @test atan(@interval(-0.0, 0.0), @interval(-2.0, 0.0)) ==
        Interval(3.141592653589793, 3.1415926535897936)
    @test atan(@biginterval(0.0, 0.1), @biginterval(-0.1, 0.0)) ⊆
        atan(@interval(0.0, 0.1), @interval(-0.1, 0.0))
    @test atan(@interval(-0.0, 0.1), @interval(-0.1, 0.0)) ==
        Interval(1.5707963267948966, 3.1415926535897936)
    @test atan(@biginterval(-0.1, -0.1), @biginterval(-0.1, 0.0)) ⊆
        atan(@interval(-0.1, -0.1), @interval(-0.1, 0.0))
    @test atan(@interval(-0.1, -0.1), @interval(-0.1, 0.0)) ==
        Interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(@biginterval(-0.1, 0.1), @biginterval(-2.0, 0.0)) ⊆
        atan(@interval(-0.1, 0.1), @interval(-2.0, 0.0))
    @test atan(@interval(-0.1, 0.1), @interval(-2.0, 0.0)) ==
        @interval(-pi, pi)
    @test atan(@biginterval(0.0, 0.1), @biginterval(-2.0, 0.1)) ⊆
        atan(@interval(0.0, 0.1), @interval(-2.0, 0.1))
    @test atan(@interval(-0.0, 0.1), @interval(-2.0, 0.1)) ==
        Interval(0.0, 3.1415926535897936)
    @test atan(@biginterval(-0.1, -0.1), @biginterval(-0.1, 0.1)) ⊆
        atan(@interval(-0.1, -0.1), @interval(-0.1, 0.1))
    @test atan(@interval(-0.1, -0.1), @interval(-0.1, 0.1)) ==
        Interval(-2.3561944901923453, -0.7853981633974482)
    @test atan(@biginterval(-0.1, 0.1), @biginterval(-2.0, 0.1)) ⊆
        atan(@interval(-0.1, 0.1), @interval(-2.0, 0.1))
    @test atan(@interval(-0.1, 0.1), @interval(-2.0, 0.1)) ==
        @interval(-pi, pi)

    @test atan(@interval(-0.1, 0.1), @interval(0.1, 0.1)) ==
        Interval(-0.7853981633974484, 0.7853981633974484)
    @test atan(@biginterval(-0.1, 0.1), @biginterval(0.1, 0.1)) ⊆
        atan(@interval(-0.1, 0.1), @interval(0.1, 0.1))
    @test atan(@interval(0.0), @interval(-0.0, 0.1)) == @interval(0.0)
    @test atan(@interval(0.0, 0.1), @interval(-0.0, 0.1)) ==
        Interval(0.0, 1.5707963267948968)
    @test atan(@interval(-0.1, 0.0), @interval(0.0, 0.1)) ==
        Interval(-1.5707963267948968, 0.0)
    @test atan(@interval(-0.1, 0.1), @interval(-0.0, 0.1)) ==
        Interval(-1.5707963267948968, 1.5707963267948968)
    @test atan(@biginterval(-0.1, 0.1), @biginterval(-0.0, 0.1)) ⊆
        atan(@interval(-0.1, 0.1), @interval(0.0, 0.1))
end

@testset "Trig" begin
    for a in ( @interval(17, 19), @interval(0.5, 1.2) )
        @test tan(a) ⊆ sin(a)/cos(a)
    end

    @test sin(Interval(-pi/2, 3pi/2)) == Interval(-1, 1)
    @test cos(Interval(-pi/2, 3pi/2)) == Interval(-1, 1)
end

# @testset "Trig with large arguments" begin
#     x = Interval(2.)^1000   # this is a thin interval
#     @test diam(x) == 0.0
#
#     @test sin(x) == -1..1
#     @test cos(x) == -1..1
#     @test_skip tan(x) == Interval(-0.16125837995065806, -0.16125837995065803)
#
#     x = Interval(prevfloat(∞), ∞)
#     @test sin(x) == -1..1
#     @test cos(x) == -1..1
#     @test tan(x) == -∞..∞
# end
