using Test
using IntervalArithmetic

@testset "rad2deg/deg2rad" begin
    @test isweakinterior(interval(180, 360), rad2deg(interval(π, 2π)))
    @test isweakinterior(interval(π, 2interval(π)), deg2rad(interval(180, 360)))
end

@testset "sin" begin
    @test isequalinterval(sin(interval(0.5)), interval(0.47942553860420295, 0.47942553860420301))
    @test isequalinterval(sin(interval(0.5, 1.67)), interval(4.7942553860420295e-01, 1.0))
    @test isequalinterval(sin(interval(1.67, 3.2)), interval(-5.8374143427580093e-02, 9.9508334981018021e-01))
    @test_broken isequalinterval(sin(interval(2.1, 5.6)), interval(-1.0, 0.863209366648874))
    @test isequalinterval(sin(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test isequalinterval(sin(interval(Float64, -4.5, 0.1)), interval(-1.0, 0.9775301176650971))
    @test isequalinterval(sin(interval(Float64, 1.3, 6.3)), interval(-1.0, 1.0))

    @test isweakinterior(sin(interval(BigFloat, 0.5, 0.5)), sin(interval(0.5)))
    @test isweakinterior(sin(interval(BigFloat, 0.5, 1.67)), sin(interval(0.5, 1.67)))
    @test isweakinterior(sin(interval(BigFloat, 1.67, 3.2)), sin(interval(1.67, 3.2)))
    @test isweakinterior(sin(interval(BigFloat, 2.1, 5.6)), sin(interval(2.1, 5.6)))
    @test isweakinterior(sin(interval(BigFloat, 0.5, 8.5)), sin(interval(0.5, 8.5)))
    @test isweakinterior(sin(interval(BigFloat, -4.5, 0.1)), sin(interval(-4.5, 0.1)))
    @test isweakinterior(sin(interval(BigFloat, 1.3, 6.3)), sin(interval(1.3, 6.3)))
end

@testset "cos" begin
    @test isequalinterval(cos(interval(0.5)), interval(0.87758256189037265, 0.87758256189037276))
    @test isequalinterval(cos(interval(0.5, 1.67)), interval(cos(1.67, RoundDown), cos(0.5, RoundUp)))
    @test_broken isequalinterval(cos(interval(2.1, 5.6)), interval(-1.0, 0.77556587851025016))
    @test isequalinterval(cos(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test isequalinterval(cos(interval(1.67, 3.2)), interval(-1.0, -0.09904103659872801))

    @test isweakinterior(cos(interval(BigFloat, 0.5, 0.5)), cos(interval(0.5)))
    @test isweakinterior(cos(interval(BigFloat, 0.5, 1.67)), cos(interval(0.5, 1.67)))
    @test isweakinterior(cos(interval(BigFloat, 1.67, 3.2)), cos(interval(1.67, 3.2)))
    @test isweakinterior(cos(interval(BigFloat, 2.1, 5.6)), cos(interval(2.1, 5.6)))
    @test isweakinterior(cos(interval(BigFloat, 0.5, 8.5)), cos(interval(0.5, 8.5)))
    @test isweakinterior(cos(interval(BigFloat, -4.5, 0.1)), cos(interval(-4.5, 0.1)))
    @test isweakinterior(cos(interval(BigFloat, 1.3, 6.3)), cos(interval(1.3, 6.3)))
end

@testset "sinpi" begin
    @test isequalinterval(sinpi(emptyinterval()), emptyinterval())
    @test isweakinterior(interval(-1 , 0), sinpi(interval(1, 2)))
    @test isequalinterval(sinpi(interval(0.5, 1.5)), interval(-1 , 1))
    @test isweakinterior(interval(1/sqrt(2) , 1), sinpi(interval(0.25, 0.75)))
    @test isweakinterior(interval(-1/sqrt(2) , 1/sqrt(2)), sinpi(interval(-0.25, 0.25)))
end

@testset "cospi" begin
    @test isequalinterval(cospi(emptyinterval()), emptyinterval())
    @test isequalinterval(cospi(interval(1, 2)), interval(-1 , 1))
    @test isweakinterior(interval(-1 , 0), cospi(interval(0.5, 1.5)))
    @test isweakinterior(interval(-1/sqrt(2) , 1/sqrt(2)), cospi(interval(0.25, 0.75)))
    @test isequalinterval(cospi(interval(-0.25, 0.25)), interval(1/sqrt(2) , 1))
end

@testset "sincospi" begin
    x = sincospi(emptyinterval())
    @test isequalinterval(x[1], emptyinterval()) & isequalinterval(x[2], emptyinterval())
    x = sincospi(interval(1, 2))
    @test isweakinterior(interval(-1, 0), x[1]) & isequalinterval(x[2], interval(-1, 1))
    x = sincospi(interval(0.5, 1.5))
    @test isequalinterval(x[1], interval(-1, 1)) & isweakinterior(interval(-1, 0), x[2])
    x = sincospi(interval(0.25, 0.75))
    @test isweakinterior(interval(1/sqrt(2), 1), x[1]) & isweakinterior(interval(-1/sqrt(2), 1/sqrt(2)), x[2])
    x = sincospi(interval(-0.25, 0.25))
    @test isweakinterior(interval(-1/sqrt(2), 1/sqrt(2)), x[1]) & isequalinterval(x[2], interval(1/sqrt(2), 1))
end

@testset "tan" begin
    @test isequalinterval(tan(interval(0.5)), interval(0.54630248984379048, 0.5463024898437906))
    @test isequalinterval(tan(interval(0.5, 1.67)), entireinterval())
    @test isequalinterval(tan(interval(1.67, 3.2)), interval(-10.047182299210307, 0.05847385445957865))
    @test isequalinterval(tan(interval(6.638314112824137, 8.38263151220128)), entireinterval())  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test isweakinterior(tan(interval(BigFloat, 0.5, 0.5)), tan(interval(0.5)))
    @test isequalinterval(tan(interval(BigFloat, 0.5, 1.67)), entireinterval(BigFloat))
    @test isweakinterior(tan(interval(BigFloat, 0.5, 1.67)), tan(interval(0.5, 1.67)))
    @test isweakinterior(tan(interval(BigFloat, 1.67, 3.2)), tan(interval(1.67, 3.2)))
    @test isweakinterior(tan(interval(BigFloat, 2.1, 5.6)), tan(interval(2.1, 5.6)))
    @test isweakinterior(tan(interval(BigFloat, 0.5, 8.5)), tan(interval(0.5, 8.5)))
    @test isweakinterior(tan(interval(BigFloat, -4.5, 0.1)), tan(interval(-4.5, 0.1)))
    @test isweakinterior(tan(interval(BigFloat, 1.3, 6.3)), tan(interval(1.3, 6.3)))

end

@testset "Inverse trig" begin
    @test isequalinterval(asin(interval(1)), interval(pi)/2)
    @test isequalinterval(asin(interval(0.9, 2)), asin(interval(0.9, 1)))
    @test isequalinterval(asin(interval(3, 4)), emptyinterval())

    @test isweakinterior(asin(interval(BigFloat, 1, 1)), asin(interval(1)))
    @test isweakinterior(asin(interval(BigFloat, 0.9, 2)), asin(interval(0.9, 2)))
    @test isweakinterior(asin(interval(BigFloat, 3, 4)), asin(interval(3, 4)))

    @test isequalinterval(acos(interval(1)), interval(0., 0.))
    @test isequalinterval(acos(interval(-2, -0.9)), acos(interval(-1, -0.9)))
    @test isequalinterval(acos(interval(3, 4)), emptyinterval())

    @test isweakinterior(acos(interval(BigFloat, 1, 1)), acos(interval(1)))
    @test isweakinterior(acos(interval(BigFloat, -2, -0.9)), acos(interval(-2, -0.9)))
    @test isweakinterior(acos(interval(BigFloat, 3, 4)), acos(interval(3, 4)))

    @test isequalinterval(atan(interval(-1,1)),
        interval(-interval(Float64, π).hi/4, interval(Float64, π).hi/4))
    @test isequalinterval(atan(interval(0)), interval(0.0, 0.0))
    @test isweakinterior(atan(interval(BigFloat, -1, 1)), atan(interval(-1, 1)))
end

@testset "atan" begin
    @test isequalinterval(atan(emptyinterval(), entireinterval()), emptyinterval())
    @test isequalinterval(atan(entireinterval(), emptyinterval()), emptyinterval())
    @test isequalinterval(atan(interval(0.0, 1.0), interval(BigFloat, 0.0, 0.0)), interval(BigFloat, π)/2)
    @test isequalinterval(atan(interval(0.0, 1.0), interval(0.0)), interval(π)/2)
    @test isequalinterval(atan(interval(-1.0, -0.1), interval(0.0)), -interval(π)/2)
    @test isequalinterval(atan(interval(-1.0, 1.0), interval(0.0)), interval(-0.5, 0.5) * interval(π))
    @test isequalinterval(atan(interval(0.0), interval(0.1, 1.0)), interval(0.0))
    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, 0.1, 1.0)),
        atan(interval(0.0, 0.1), interval(0.1, 1.0)))
    @test isequalinterval(atan(interval(0.0, 0.1), interval(0.1, 1.0)),
        interval(0.0, 0.7853981633974484))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, 0.1, 1.0)),
        atan(interval(-0.1, 0.0), interval(0.1, 1.0)))
    @test isequalinterval(atan(interval(-0.1, 0.0), interval(0.1, 1.0)),
        interval(-0.7853981633974484, 0.0))
    @test isweakinterior(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, 0.1, Inf)),
        atan(interval(-0.1, -0.1), interval(0.1, Inf)))
    @test isequalinterval(atan(interval(-0.1, 0.0), interval(0.1, Inf)),
        interval(-0.7853981633974484, 0.0))
    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, -0.1)),
        atan(interval(0.0, 0.1), interval(-2.0, -0.1)))
    @test isequalinterval(atan(interval(0.0, 0.1), interval(-2.0, -0.1)),
        interval(2.356194490192345, 3.1415926535897936))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, -2.0, -0.1)),
        atan(interval(-0.1, 0.0), interval(-2.0, -0.1)))
    @test isequalinterval(atan(interval(-0.1, 0.0), interval(-2.0, -0.1)),
        interval(-1, 1) * interval(π))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -Inf, -0.1)),
        atan(interval(-0.1, 0.1), interval(-Inf, -0.1)))
    @test isequalinterval(atan(interval(-0.1, 0.1), interval(-Inf, -0.1)),
        interval(-1, 1) * interval(π))

    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)),
        atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)),
        interval(3.141592653589793, 3.1415926535897936))
    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test isequalinterval(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)),
        interval(1.5707963267948966, 3.1415926535897936))
    @test isweakinterior(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test isequalinterval(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)),
        interval(-2.3561944901923453, -1.5707963267948966))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test isequalinterval(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)),
        interval(-1, 1) * interval(π))

    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)),
        atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)),
        interval(3.141592653589793, 3.1415926535897936))
    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test isequalinterval(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)),
        interval(1.5707963267948966, 3.1415926535897936))
    @test isweakinterior(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test isequalinterval(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)),
        interval(-2.3561944901923453, -1.5707963267948966))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test isequalinterval(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)),
        interval(-1, 1) * interval(π))
    @test isweakinterior(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, 0.1)),
        atan(interval(0.0, 0.1), interval(-2.0, 0.1)))
    @test isequalinterval(atan(interval(-0.0, 0.1), interval(-2.0, 0.1)),
        interval(0.0, 3.1415926535897936))
    @test isweakinterior(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.1)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.1)))
    @test isequalinterval(atan(interval(-0.1, -0.1), interval(-0.1, 0.1)),
        interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp)))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.1)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))
    @test isequalinterval(interval(-1, 1) * interval(π), atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))

    @test isequalinterval(atan(interval(-0.1, 0.1), interval(0.1, 0.1)),
        interval(-0.7853981633974484, 0.7853981633974484))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, 0.1, 0.1)),
        atan(interval(-0.1, 0.1), interval(0.1, 0.1)))
    @test isequalinterval(atan(interval(0.0), interval(-0.0, 0.1)), interval(0.0))
    @test isequalinterval(atan(interval(0.0, 0.1), interval(-0.0, 0.1)),
        interval(0.0, 1.5707963267948968))
    @test isequalinterval(atan(interval(-0.1, 0.0), interval(0.0, 0.1)),
        interval(-1.5707963267948968, 0.0))
    @test isequalinterval(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)),
        interval(-1.5707963267948968, 1.5707963267948968))
    @test isweakinterior(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -0.0, 0.1)),
        atan(interval(-0.1, 0.1), interval(0.0, 0.1)))

    @test isequalinterval(atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)),
        interval(-0.78539824f0, 0.78539824f0))
    @test isweakinterior(atan(interval(-0.1, 0.1), interval(0.1, 0.1)),
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)))
    @test isequalinterval(atan(interval(Float32, 0.0, 0.0), interval(Float32, -0.0, 0.1)),
        interval(Float32, 0.0, 0.0))
    @test isequalinterval(atan(interval(Float32, 0.0, 0.1), interval(Float32, -0.0, 0.1)),
        interval(0.0, 1.5707964f0))
    @test isequalinterval(atan(interval(Float32, -0.1, 0.0), interval(Float32, 0.0, 0.1)),
        interval(-1.5707964f0, 0.0))
    @test isequalinterval(atan(interval(Float32, -0.1, 0.1), interval(Float32, -0.0, 0.1)),
        interval(-1.5707964f0, 1.5707964f0))
    @test isweakinterior(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)),
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.0, 0.1)))
end

@testset "Trig" begin
    for a in ( interval(17, 19), interval(0.5, 1.2) )
        @test isweakinterior(tan(a), sin(a)/cos(a))
    end

    @test isequalinterval(sin(interval(-pi/2, 3pi/2)), interval(-1, 1))
    @test isequalinterval(cos(interval(-pi/2, 3pi/2)), interval(-1, 1))
end

@testset "Trig with large arguments" begin
    x = interval(2.)^1000   # this is a thin interval
    @test diam(x) == 0.0

    @test isequalinterval(sin(x), interval(-0.15920170308624246, -0.15920170308624243))
    @test isequalinterval(cos(x), interval(0.9872460775989135, 0.9872460775989136))
    @test isequalinterval(tan(x), interval(-0.16125837995065806, -0.16125837995065803))

    x = interval(prevfloat(Inf), Inf)
    @test isequalinterval(sin(x), interval(-1, 1))
    @test isequalinterval(cos(x), interval(-1, 1))
    @test isequalinterval(tan(x), interval(-Inf, Inf))
end
