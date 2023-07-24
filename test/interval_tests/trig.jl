using Test
using IntervalArithmetic

@testset "rad2deg/deg2rad" begin
    @test rad2deg(interval(π, 2π)) ⊇ interval(180, 360)
    @test deg2rad(interval(180, 360)) ⊇ interval(π, 2interval(π))
end

@testset "sin" begin
    @test sin(interval(0.5)) ≛ interval(0.47942553860420295, 0.47942553860420301)
    @test sin(interval(0.5, 1.67)) ≛ interval(4.7942553860420295e-01, 1.0)
    @test sin(interval(1.67, 3.2)) ≛ interval(-5.8374143427580093e-02, 9.9508334981018021e-01)
    @test_broken sin(interval(2.1, 5.6)) ≛ interval(-1.0, 0.863209366648874)
    @test sin(interval(0.5, 8.5)) ≛ interval(-1.0, 1.0)
    @test sin(interval(Float64, -4.5, 0.1)) ≛ interval(-1.0, 0.9775301176650971)
    @test sin(interval(Float64, 1.3, 6.3)) ≛ interval(-1.0, 1.0)

    @test sin(interval(BigFloat, 0.5, 0.5)) ⊆ sin(interval(0.5))
    @test sin(interval(BigFloat, 0.5, 1.67)) ⊆ sin(interval(0.5, 1.67))
    @test sin(interval(BigFloat, 1.67, 3.2)) ⊆ sin(interval(1.67, 3.2))
    @test sin(interval(BigFloat, 2.1, 5.6)) ⊆ sin(interval(2.1, 5.6))
    @test sin(interval(BigFloat, 0.5, 8.5)) ⊆ sin(interval(0.5, 8.5))
    @test sin(interval(BigFloat, -4.5, 0.1)) ⊆ sin(interval(-4.5, 0.1))
    @test sin(interval(BigFloat, 1.3, 6.3)) ⊆ sin(interval(1.3, 6.3))
end

@testset "cos" begin
    @test cos(interval(0.5)) ≛ interval(0.87758256189037265, 0.87758256189037276)
    @test cos(interval(0.5, 1.67)) ≛ interval(cos(1.67, RoundDown), cos(0.5, RoundUp))
    @test_broken cos(interval(2.1, 5.6)) ≛ interval(-1.0, 0.77556587851025016)
    @test cos(interval(0.5, 8.5)) ≛ interval(-1.0, 1.0)
    @test cos(interval(1.67, 3.2)) ≛ interval(-1.0, -0.09904103659872801)

    @test cos(interval(BigFloat, 0.5, 0.5)) ⊆ cos(interval(0.5))
    @test cos(interval(BigFloat, 0.5, 1.67)) ⊆ cos(interval(0.5, 1.67))
    @test cos(interval(BigFloat, 1.67, 3.2)) ⊆ cos(interval(1.67, 3.2))
    @test cos(interval(BigFloat, 2.1, 5.6)) ⊆ cos(interval(2.1, 5.6))
    @test cos(interval(BigFloat, 0.5, 8.5)) ⊆ cos(interval(0.5, 8.5))
    @test cos(interval(BigFloat, -4.5, 0.1)) ⊆ cos(interval(-4.5, 0.1))
    @test cos(interval(BigFloat, 1.3, 6.3)) ⊆ cos(interval(1.3, 6.3))
end

@testset "sinpi" begin
    @test sinpi(emptyinterval()) ≛ emptyinterval()
    @test sinpi(interval(1, 2)) ⊇ interval(-1 , 0)
    @test sinpi(interval(0.5, 1.5)) ≛ interval(-1 , 1)
    @test sinpi(interval(0.25, 0.75)) ⊇ interval(1/sqrt(2) , 1)
    @test sinpi(interval(-0.25, 0.25)) ⊇ interval(-1/sqrt(2) , 1/sqrt(2))
end

@testset "cospi" begin
    @test cospi(emptyinterval()) ≛ emptyinterval()
    @test cospi(interval(1, 2)) ≛ interval(-1 , 1)
    @test cospi(interval(0.5, 1.5)) ⊇ interval(-1 , 0)
    @test cospi(interval(0.25, 0.75)) ⊇ interval(-1/sqrt(2) , 1/sqrt(2))
    @test cospi(interval(-0.25, 0.25)) ≛ interval(1/sqrt(2) , 1)
end

@testset "sincospi" begin
    x = sincospi(emptyinterval())
    @test (x[1] == emptyinterval()) & (x[2] == emptyinterval())
    x = sincospi(interval(1, 2))
    @test (x[1] ⊇ interval(-1 , 0)) & (x[2] ≛ interval(-1 , 1))
    x = sincospi(interval(0.5, 1.5))
    @test (x[1] ≛ interval(-1 , 1)) & (x[2] ⊇ interval(-1 , 0))
    x = sincospi(interval(0.25, 0.75))
    @test (x[1] ⊇ interval(1/sqrt(2) , 1)) & (x[2] ⊇ interval(-1/sqrt(2) , 1/sqrt(2)))
    x = sincospi(interval(-0.25, 0.25))
    @test (x[1] ⊇ interval(-1/sqrt(2) , 1/sqrt(2))) & (x[2] ≛ interval(1/sqrt(2) , 1))
end

@testset "tan" begin
    @test tan(interval(0.5)) ≛ interval(0.54630248984379048, 0.5463024898437906)
    @test tan(interval(0.5, 1.67)) ≛ entireinterval()
    @test tan(interval(1.67, 3.2)) ≛ interval(-10.047182299210307, 0.05847385445957865)
    @test tan(interval(6.638314112824137, 8.38263151220128)) ≛ entireinterval()  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test tan(interval(BigFloat, 0.5, 0.5)) ⊆ tan(interval(0.5))
    @test tan(interval(BigFloat, 0.5, 1.67)) ≛ entireinterval(BigFloat)
    @test tan(interval(BigFloat, 0.5, 1.67)) ⊆ tan(interval(0.5, 1.67))
    @test tan(interval(BigFloat, 1.67, 3.2)) ⊆ tan(interval(1.67, 3.2))
    @test tan(interval(BigFloat, 2.1, 5.6)) ⊆ tan(interval(2.1, 5.6))
    @test tan(interval(BigFloat, 0.5, 8.5)) ⊆ tan(interval(0.5, 8.5))
    @test tan(interval(BigFloat, -4.5, 0.1)) ⊆ tan(interval(-4.5, 0.1))
    @test tan(interval(BigFloat, 1.3, 6.3)) ⊆ tan(interval(1.3, 6.3))

end

@testset "Inverse trig" begin
    @test asin(interval(1)) ≛ interval(pi)/2
    @test asin(interval(0.9, 2)) ≛ asin(interval(0.9, 1))
    @test asin(interval(3, 4)) ≛ emptyinterval()

    @test asin(interval(BigFloat, 1, 1)) ⊆ asin(interval(1))
    @test asin(interval(BigFloat, 0.9, 2)) ⊆ asin(interval(0.9, 2))
    @test asin(interval(BigFloat, 3, 4)) ⊆ asin(interval(3, 4))

    @test acos(interval(1)) ≛ interval(0., 0.)
    @test acos(interval(-2, -0.9)) ≛ acos(interval(-1, -0.9))
    @test acos(interval(3, 4)) ≛ emptyinterval()

    @test acos(interval(BigFloat, 1, 1)) ⊆ acos(interval(1))
    @test acos(interval(BigFloat, -2, -0.9)) ⊆ acos(interval(-2, -0.9))
    @test acos(interval(BigFloat, 3, 4)) ⊆ acos(interval(3, 4))

    @test atan(interval(-1,1)) ≛
    interval(-interval(Float64, π).hi/4, interval(Float64, π).hi/4)
    @test atan(interval(0)) ≛ interval(0.0, 0.0)
    @test atan(interval(BigFloat, -1, 1)) ⊆ atan(interval(-1, 1))
end

@testset "atan" begin
    @test atan(emptyinterval(), entireinterval()) ≛ emptyinterval()
    @test atan(entireinterval(), emptyinterval()) ≛ emptyinterval()
    @test atan(interval(0.0, 1.0), interval(BigFloat, 0.0, 0.0)) ≛ interval(BigFloat, π)/2
    @test atan(interval(0.0, 1.0), interval(0.0)) ≛ interval(π)/2
    @test atan(interval(-1.0, -0.1), interval(0.0)) ≛ -interval(π)/2
    @test atan(interval(-1.0, 1.0), interval(0.0)) ≛ interval(-0.5, 0.5) * interval(π)
    @test atan(interval(0.0), interval(0.1, 1.0)) ≛ interval(0.0)
    @test atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, 0.1, 1.0)) ⊆
        atan(interval(0.0, 0.1), interval(0.1, 1.0))
    @test atan(interval(0.0, 0.1), interval(0.1, 1.0)) ≛
        interval(0.0, 0.7853981633974484)
    @test atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, 0.1, 1.0)) ⊆
        atan(interval(-0.1, 0.0), interval(0.1, 1.0))
    @test atan(interval(-0.1, 0.0), interval(0.1, 1.0)) ≛
        interval(-0.7853981633974484, 0.0)
    @test atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, 0.1, Inf)) ⊆
        atan(interval(-0.1, -0.1), interval(0.1, Inf))
    @test atan(interval(-0.1, 0.0), interval(0.1, Inf)) ≛
        interval(-0.7853981633974484, 0.0)
    @test atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, -0.1)) ⊆
        atan(interval(0.0, 0.1), interval(-2.0, -0.1))
    @test atan(interval(0.0, 0.1), interval(-2.0, -0.1)) ≛
        interval(2.356194490192345, 3.1415926535897936)
    @test atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, -2.0, -0.1)) ⊆
        atan(interval(-0.1, 0.0), interval(-2.0, -0.1))
    @test atan(interval(-0.1, 0.0), interval(-2.0, -0.1)) ≛
        interval(-1, 1) * interval(π)
    @test atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -Inf, -0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(-Inf, -0.1))
    @test atan(interval(-0.1, 0.1), interval(-Inf, -0.1)) ≛
        interval(-1, 1) * interval(π)

    @test atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)) ⊆
        atan(interval(0.0, 0.0), interval(-2.0, 0.0))
    @test atan(interval(-0.0, 0.0), interval(-2.0, 0.0)) ≛
        interval(3.141592653589793, 3.1415926535897936)
    @test atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)) ⊆
        atan(interval(0.0, 0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.0, 0.1), interval(-0.1, 0.0)) ≛
        interval(1.5707963267948966, 3.1415926535897936)
    @test atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)) ⊆
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.1, -0.1), interval(-0.1, 0.0)) ≛
        interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)) ⊆
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0))
    @test atan(interval(-0.1, 0.1), interval(-2.0, 0.0)) ≛
        interval(-1, 1) * interval(π)

    @test atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)) ⊆
        atan(interval(0.0, 0.0), interval(-2.0, 0.0))
    @test atan(interval(-0.0, 0.0), interval(-2.0, 0.0)) ≛
        interval(3.141592653589793, 3.1415926535897936)
    @test atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)) ⊆
        atan(interval(0.0, 0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.0, 0.1), interval(-0.1, 0.0)) ≛
        interval(1.5707963267948966, 3.1415926535897936)
    @test atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)) ⊆
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0))
    @test atan(interval(-0.1, -0.1), interval(-0.1, 0.0)) ≛
        interval(-2.3561944901923453, -1.5707963267948966)
    @test atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)) ⊆
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0))
    @test atan(interval(-0.1, 0.1), interval(-2.0, 0.0)) ≛
        interval(-1, 1) * interval(π)
    @test atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, 0.1)) ⊆
        atan(interval(0.0, 0.1), interval(-2.0, 0.1))
    @test atan(interval(-0.0, 0.1), interval(-2.0, 0.1)) ≛
        interval(0.0, 3.1415926535897936)
    @test atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.1)) ⊆
        atan(interval(-0.1, -0.1), interval(-0.1, 0.1))
    @test atan(interval(-0.1, -0.1), interval(-0.1, 0.1)) ≛
        interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp))
    @test atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(-2.0, 0.1))
    @test interval(-1, 1) * interval(π) ≛ atan(interval(-0.1, 0.1), interval(-2.0, 0.1))

    @test atan(interval(-0.1, 0.1), interval(0.1, 0.1)) ≛
        interval(-0.7853981633974484, 0.7853981633974484)
    @test atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, 0.1, 0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(0.1, 0.1))
    @test atan(interval(0.0), interval(-0.0, 0.1)) ≛ interval(0.0)
    @test atan(interval(0.0, 0.1), interval(-0.0, 0.1)) ≛
        interval(0.0, 1.5707963267948968)
    @test atan(interval(-0.1, 0.0), interval(0.0, 0.1)) ≛
        interval(-1.5707963267948968, 0.0)
    @test atan(interval(-0.1, 0.1), interval(-0.0, 0.1)) ≛
        interval(-1.5707963267948968, 1.5707963267948968)
    @test atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -0.0, 0.1)) ⊆
        atan(interval(-0.1, 0.1), interval(0.0, 0.1))

    @test atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)) ≛
        interval(-0.78539824f0, 0.78539824f0)
    @test atan(interval(-0.1, 0.1), interval(0.1, 0.1)) ⊆
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1))
    @test atan(interval(Float32, 0.0, 0.0), interval(Float32, -0.0, 0.1)) ≛
        interval(Float32, 0.0, 0.0)
    @test atan(interval(Float32, 0.0, 0.1), interval(Float32, -0.0, 0.1)) ≛
        interval(0.0, 1.5707964f0)
    @test atan(interval(Float32, -0.1, 0.0), interval(Float32, 0.0, 0.1)) ≛
        interval(-1.5707964f0, 0.0)
    @test atan(interval(Float32, -0.1, 0.1), interval(Float32, -0.0, 0.1)) ≛
        interval(-1.5707964f0, 1.5707964f0)
    @test atan(interval(-0.1, 0.1), interval(-0.0, 0.1)) ⊆
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.0, 0.1))
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

    x = interval(prevfloat(Inf), Inf)
    @test sin(x) ≛ interval(-1, 1)
    @test cos(x) ≛ interval(-1, 1)
    @test tan(x) ≛ interval(-Inf, Inf)
end
