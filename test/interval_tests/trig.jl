using Test
using IntervalArithmetic

@testset "rad2deg/deg2rad" begin
    @test supset(rad2deg(interval(π, 2π)), interval(180, 360))
    @test supset(deg2rad(interval(180, 360)), interval(π, 2interval(π)))
end

@testset "sin" begin
    @test equal(sin(interval(0.5)), interval(0.47942553860420295, 0.47942553860420301))
    @test equal(sin(interval(0.5, 1.67)), interval(4.7942553860420295e-01, 1.0))
    @test equal(sin(interval(1.67, 3.2)), interval(-5.8374143427580093e-02, 9.9508334981018021e-01))
    @test_broken equal(sin(interval(2.1, 5.6)), interval(-1.0, 0.863209366648874))
    @test equal(sin(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test equal(sin(interval(Float64, -4.5, 0.1)), interval(-1.0, 0.9775301176650971))
    @test equal(sin(interval(Float64, 1.3, 6.3)), interval(-1.0, 1.0))

    @test subset(sin(interval(BigFloat, 0.5, 0.5)), sin(interval(0.5)))
    @test subset(sin(interval(BigFloat, 0.5, 1.67)), sin(interval(0.5, 1.67)))
    @test subset(sin(interval(BigFloat, 1.67, 3.2)), sin(interval(1.67, 3.2)))
    @test subset(sin(interval(BigFloat, 2.1, 5.6)), sin(interval(2.1, 5.6)))
    @test subset(sin(interval(BigFloat, 0.5, 8.5)), sin(interval(0.5, 8.5)))
    @test subset(sin(interval(BigFloat, -4.5, 0.1)), sin(interval(-4.5, 0.1)))
    @test subset(sin(interval(BigFloat, 1.3, 6.3)), sin(interval(1.3, 6.3)))
end

@testset "cos" begin
    @test equal(cos(interval(0.5)), interval(0.87758256189037265, 0.87758256189037276))
    @test equal(cos(interval(0.5, 1.67)), interval(cos(1.67, RoundDown), cos(0.5, RoundUp)))
    @test_broken equal(cos(interval(2.1, 5.6)), interval(-1.0, 0.77556587851025016))
    @test equal(cos(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test equal(cos(interval(1.67, 3.2)), interval(-1.0, -0.09904103659872801))

    @test subset(cos(interval(BigFloat, 0.5, 0.5)), cos(interval(0.5)))
    @test subset(cos(interval(BigFloat, 0.5, 1.67)), cos(interval(0.5, 1.67)))
    @test subset(cos(interval(BigFloat, 1.67, 3.2)), cos(interval(1.67, 3.2)))
    @test subset(cos(interval(BigFloat, 2.1, 5.6)), cos(interval(2.1, 5.6)))
    @test subset(cos(interval(BigFloat, 0.5, 8.5)), cos(interval(0.5, 8.5)))
    @test subset(cos(interval(BigFloat, -4.5, 0.1)), cos(interval(-4.5, 0.1)))
    @test subset(cos(interval(BigFloat, 1.3, 6.3)), cos(interval(1.3, 6.3)))
end

@testset "sinpi" begin
    @test equal(sinpi(emptyinterval()), emptyinterval())
    @test supset(sinpi(interval(1, 2)), interval(-1 , 0))
    @test equal(sinpi(interval(0.5, 1.5)), interval(-1 , 1))
    @test supset(sinpi(interval(0.25, 0.75)), interval(1/sqrt(2) , 1))
    @test supset(sinpi(interval(-0.25, 0.25)), interval(-1/sqrt(2) , 1/sqrt(2)))
end

@testset "cospi" begin
    @test equal(cospi(emptyinterval()), emptyinterval())
    @test equal(cospi(interval(1, 2)), interval(-1 , 1))
    @test supset(cospi(interval(0.5, 1.5)), interval(-1 , 0))
    @test supset(cospi(interval(0.25, 0.75)), interval(-1/sqrt(2) , 1/sqrt(2)))
    @test equal(cospi(interval(-0.25, 0.25)), interval(1/sqrt(2) , 1))
end

@testset "sincospi" begin
    x = sincospi(emptyinterval())
    @test equal(x[1], emptyinterval()) & equal(x[2], emptyinterval())
    x = sincospi(interval(1, 2))
    @test supset(x[1], interval(-1 , 0)) & equal(x[2], interval(-1 , 1))
    x = sincospi(interval(0.5, 1.5))
    @test equal(x[1], interval(-1 , 1)) & supset(x[2], interval(-1 , 0))
    x = sincospi(interval(0.25, 0.75))
    @test supset(x[1], interval(1/sqrt(2) , 1)) & supset(x[2], interval(-1/sqrt(2) , 1/sqrt(2)))
    x = sincospi(interval(-0.25, 0.25))
    @test supset(x[1], interval(-1/sqrt(2) , 1/sqrt(2))) & equal(x[2], interval(1/sqrt(2) , 1))
end

@testset "tan" begin
    @test equal(tan(interval(0.5)), interval(0.54630248984379048, 0.5463024898437906))
    @test equal(tan(interval(0.5, 1.67)), entireinterval())
    @test equal(tan(interval(1.67, 3.2)), interval(-10.047182299210307, 0.05847385445957865))
    @test equal(tan(interval(6.638314112824137, 8.38263151220128)), entireinterval())  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test subset(tan(interval(BigFloat, 0.5, 0.5)), tan(interval(0.5)))
    @test equal(tan(interval(BigFloat, 0.5, 1.67)), entireinterval(BigFloat))
    @test subset(tan(interval(BigFloat, 0.5, 1.67)), tan(interval(0.5, 1.67)))
    @test subset(tan(interval(BigFloat, 1.67, 3.2)), tan(interval(1.67, 3.2)))
    @test subset(tan(interval(BigFloat, 2.1, 5.6)), tan(interval(2.1, 5.6)))
    @test subset(tan(interval(BigFloat, 0.5, 8.5)), tan(interval(0.5, 8.5)))
    @test subset(tan(interval(BigFloat, -4.5, 0.1)), tan(interval(-4.5, 0.1)))
    @test subset(tan(interval(BigFloat, 1.3, 6.3)), tan(interval(1.3, 6.3)))

end

@testset "Inverse trig" begin
    @test equal(asin(interval(1)), interval(pi)/2)
    @test equal(asin(interval(0.9, 2)), asin(interval(0.9, 1)))
    @test equal(asin(interval(3, 4)), emptyinterval())

    @test subset(asin(interval(BigFloat, 1, 1)), asin(interval(1)))
    @test subset(asin(interval(BigFloat, 0.9, 2)), asin(interval(0.9, 2)))
    @test subset(asin(interval(BigFloat, 3, 4)), asin(interval(3, 4)))

    @test equal(acos(interval(1)), interval(0., 0.))
    @test equal(acos(interval(-2, -0.9)), acos(interval(-1, -0.9)))
    @test equal(acos(interval(3, 4)), emptyinterval())

    @test subset(acos(interval(BigFloat, 1, 1)), acos(interval(1)))
    @test subset(acos(interval(BigFloat, -2, -0.9)), acos(interval(-2, -0.9)))
    @test subset(acos(interval(BigFloat, 3, 4)), acos(interval(3, 4)))

    @test equal(atan(interval(-1,1)),
        interval(-interval(Float64, π).hi/4, interval(Float64, π).hi/4))
    @test equal(atan(interval(0)), interval(0.0, 0.0))
    @test subset(atan(interval(BigFloat, -1, 1)), atan(interval(-1, 1)))
end

@testset "atan" begin
    @test equal(atan(emptyinterval(), entireinterval()), emptyinterval())
    @test equal(atan(entireinterval(), emptyinterval()), emptyinterval())
    @test equal(atan(interval(0.0, 1.0), interval(BigFloat, 0.0, 0.0)), interval(BigFloat, π)/2)
    @test equal(atan(interval(0.0, 1.0), interval(0.0)), interval(π)/2)
    @test equal(atan(interval(-1.0, -0.1), interval(0.0)), -interval(π)/2)
    @test equal(atan(interval(-1.0, 1.0), interval(0.0)), interval(-0.5, 0.5) * interval(π))
    @test equal(atan(interval(0.0), interval(0.1, 1.0)), interval(0.0))
    @test subset(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, 0.1, 1.0)),
        atan(interval(0.0, 0.1), interval(0.1, 1.0)))
    @test equal(atan(interval(0.0, 0.1), interval(0.1, 1.0)),
        interval(0.0, 0.7853981633974484))
    @test subset(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, 0.1, 1.0)),
        atan(interval(-0.1, 0.0), interval(0.1, 1.0)))
    @test equal(atan(interval(-0.1, 0.0), interval(0.1, 1.0)),
        interval(-0.7853981633974484, 0.0))
    @test subset(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, 0.1, Inf)),
        atan(interval(-0.1, -0.1), interval(0.1, Inf)))
    @test equal(atan(interval(-0.1, 0.0), interval(0.1, Inf)),
        interval(-0.7853981633974484, 0.0))
    @test subset(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, -0.1)),
        atan(interval(0.0, 0.1), interval(-2.0, -0.1)))
    @test equal(atan(interval(0.0, 0.1), interval(-2.0, -0.1)),
        interval(2.356194490192345, 3.1415926535897936))
    @test subset(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, -2.0, -0.1)),
        atan(interval(-0.1, 0.0), interval(-2.0, -0.1)))
    @test equal(atan(interval(-0.1, 0.0), interval(-2.0, -0.1)),
        interval(-1, 1) * interval(π))
    @test subset(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -Inf, -0.1)),
        atan(interval(-0.1, 0.1), interval(-Inf, -0.1)))
    @test equal(atan(interval(-0.1, 0.1), interval(-Inf, -0.1)),
        interval(-1, 1) * interval(π))

    @test subset(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)),
        atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test equal(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)),
        interval(3.141592653589793, 3.1415926535897936))
    @test subset(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test equal(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)),
        interval(1.5707963267948966, 3.1415926535897936))
    @test subset(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test equal(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)),
        interval(-2.3561944901923453, -1.5707963267948966))
    @test subset(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test equal(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)),
        interval(-1, 1) * interval(π))

    @test subset(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)),
        atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test equal(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)),
        interval(3.141592653589793, 3.1415926535897936))
    @test subset(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test equal(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)),
        interval(1.5707963267948966, 3.1415926535897936))
    @test subset(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test equal(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)),
        interval(-2.3561944901923453, -1.5707963267948966))
    @test subset(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test equal(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)),
        interval(-1, 1) * interval(π))
    @test subset(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, 0.1)),
        atan(interval(0.0, 0.1), interval(-2.0, 0.1)))
    @test equal(atan(interval(-0.0, 0.1), interval(-2.0, 0.1)),
        interval(0.0, 3.1415926535897936))
    @test subset(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.1)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.1)))
    @test equal(atan(interval(-0.1, -0.1), interval(-0.1, 0.1)),
        interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp)))
    @test subset(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.1)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))
    @test equal(interval(-1, 1) * interval(π), atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))

    @test equal(atan(interval(-0.1, 0.1), interval(0.1, 0.1)),
        interval(-0.7853981633974484, 0.7853981633974484))
    @test subset(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, 0.1, 0.1)),
        atan(interval(-0.1, 0.1), interval(0.1, 0.1)))
    @test equal(atan(interval(0.0), interval(-0.0, 0.1)), interval(0.0))
    @test equal(atan(interval(0.0, 0.1), interval(-0.0, 0.1)),
        interval(0.0, 1.5707963267948968))
    @test equal(atan(interval(-0.1, 0.0), interval(0.0, 0.1)),
        interval(-1.5707963267948968, 0.0))
    @test equal(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)),
        interval(-1.5707963267948968, 1.5707963267948968))
    @test subset(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -0.0, 0.1)),
        atan(interval(-0.1, 0.1), interval(0.0, 0.1)))

    @test equal(atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)),
        interval(-0.78539824f0, 0.78539824f0))
    @test subset(atan(interval(-0.1, 0.1), interval(0.1, 0.1)),
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)))
    @test equal(atan(interval(Float32, 0.0, 0.0), interval(Float32, -0.0, 0.1)),
        interval(Float32, 0.0, 0.0))
    @test equal(atan(interval(Float32, 0.0, 0.1), interval(Float32, -0.0, 0.1)),
        interval(0.0, 1.5707964f0))
    @test equal(atan(interval(Float32, -0.1, 0.0), interval(Float32, 0.0, 0.1)),
        interval(-1.5707964f0, 0.0))
    @test equal(atan(interval(Float32, -0.1, 0.1), interval(Float32, -0.0, 0.1)),
        interval(-1.5707964f0, 1.5707964f0))
    @test subset(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)),
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.0, 0.1)))
end

@testset "Trig" begin
    for a in ( interval(17, 19), interval(0.5, 1.2) )
        @test subset(tan(a), sin(a)/cos(a))
    end

    @test equal(sin(interval(-pi/2, 3pi/2)), interval(-1, 1))
    @test equal(cos(interval(-pi/2, 3pi/2)), interval(-1, 1))
end

@testset "Trig with large arguments" begin
    x = interval(2.)^1000   # this is a thin interval
    @test diam(x) == 0.0

    @test equal(sin(x), interval(-0.15920170308624246, -0.15920170308624243))
    @test equal(cos(x), interval(0.9872460775989135, 0.9872460775989136))
    @test equal(tan(x), interval(-0.16125837995065806, -0.16125837995065803))

    x = interval(prevfloat(Inf), Inf)
    @test equal(sin(x), interval(-1, 1))
    @test equal(cos(x), interval(-1, 1))
    @test equal(tan(x), interval(-Inf, Inf))
end
