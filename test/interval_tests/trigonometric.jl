@testset "rad2deg/deg2rad" begin
    @test issubset_interval(interval(180, 360), rad2deg(interval(π, 2π)))
    @test issubset_interval(interval(π, interval(2)*interval(π)), deg2rad(interval(180, 360)))
end

@testset "sin" begin
    @test isequal_interval(sin(interval(0.5)), interval(0.47942553860420295, 0.47942553860420301))
    @test isequal_interval(sin(interval(0.5, 1.67)), interval(4.7942553860420295e-01, 1.0))
    @test isequal_interval(sin(interval(1.67, 3.2)), interval(-5.8374143427580093e-02, 9.9508334981018021e-01))
    @test isequal_interval(sin(interval(2.1, 5.6)), interval(-1.0, 0.8632093666488738))
    @test isequal_interval(sin(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test isequal_interval(sin(interval(Float64, -4.5, 0.1)), interval(-1.0, 0.9775301176650971))
    @test isequal_interval(sin(interval(Float64, 1.3, 6.3)), interval(-1.0, 1.0))

    @test issubset_interval(sin(interval(BigFloat, 0.5, 0.5)), sin(interval(0.5)))
    @test issubset_interval(sin(interval(BigFloat, 0.5, 1.67)), sin(interval(0.5, 1.67)))
    @test issubset_interval(sin(interval(BigFloat, 1.67, 3.2)), sin(interval(1.67, 3.2)))
    @test issubset_interval(sin(interval(BigFloat, 2.1, 5.6)), sin(interval(2.1, 5.6)))
    @test issubset_interval(sin(interval(BigFloat, 0.5, 8.5)), sin(interval(0.5, 8.5)))
    @test issubset_interval(sin(interval(BigFloat, -4.5, 0.1)), sin(interval(-4.5, 0.1)))
    @test issubset_interval(sin(interval(BigFloat, 1.3, 6.3)), sin(interval(1.3, 6.3)))

    #

    z = interval(3, 1e-7; format = :midpoint) + interval(4, 1e-7; format = :midpoint) * interval(im)
    @test issubset_interval(sin(z), complex(sin(real(z)) * cosh(imag(z)), sinh(imag(z)) * cos(real(z))))
end

@testset "cos" begin
    @test isequal_interval(cos(interval(0.5)), interval(0.87758256189037265, 0.87758256189037276))
    @test isequal_interval(cos(interval(2.1, 5.6)), interval(-1.0, 0.7755658785102496))
    @test isequal_interval(cos(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test isequal_interval(cos(interval(1.67, 3.2)), interval(-1.0, -0.09904103659872801))

    @test issubset_interval(cos(interval(BigFloat, 0.5, 0.5)), cos(interval(0.5)))
    @test issubset_interval(cos(interval(BigFloat, 0.5, 1.67)), cos(interval(0.5, 1.67)))
    @test issubset_interval(cos(interval(BigFloat, 1.67, 3.2)), cos(interval(1.67, 3.2)))
    @test issubset_interval(cos(interval(BigFloat, 2.1, 5.6)), cos(interval(2.1, 5.6)))
    @test issubset_interval(cos(interval(BigFloat, 0.5, 8.5)), cos(interval(0.5, 8.5)))
    @test issubset_interval(cos(interval(BigFloat, -4.5, 0.1)), cos(interval(-4.5, 0.1)))
    @test issubset_interval(cos(interval(BigFloat, 1.3, 6.3)), cos(interval(1.3, 6.3)))

    k = [interval(0.0,0.0625), interval(0.0625,0.125), interval(0.0,0.125)]
    x = (k[1] * 4 + k[2] * 4 + k[3] * 4)
    @test isequal_interval(cos(2 * π * x), interval(-1, 1))
    @test isequal_interval(cospi(2x), interval(-1, 1))
end

@testset "sinpi" begin
    @test isempty_interval(sinpi(emptyinterval()))
    @test issubset_interval(interval(-1 , 0), sinpi(interval(1, 2)))
    @test isequal_interval(sinpi(interval(0.5, 1.5)), interval(-1 , 1))
    @test issubset_interval(interval(1/sqrt(2) , 1), sinpi(interval(0.25, 0.75)))
    @test issubset_interval(interval(-1/sqrt(2) , 1/sqrt(2)), sinpi(interval(-0.25, 0.25)))
    if Int == Int32 && VERSION < v"1.10"
        @test in_interval(0, sinpi(interval(1.0)))
        @test in_interval(0, sinpi(interval(2.0)))
        @test in_interval(1, sinpi(interval(0.5)))
        @test in_interval(-1, sinpi(interval(1.5)))
    else
        @test isthin(sinpi(interval(1.0)), 0)
        @test isthin(sinpi(interval(2.0)), 0)
        @test isthin(sinpi(interval(0.5)), 1)
        @test isthin(sinpi(interval(1.5)), -1)
    end
end

@testset "sind" begin
    @test isempty_interval(sind(emptyinterval()))
    @test issubset_interval(interval(-1 , 0), sind(interval(180, 360)))
    @test isequal_interval(sind(interval(90, 270)), interval(-1 , 1))
    @test issubset_interval(interval(1/sqrt(2) , 1), sind(interval(45, 135)))
    @test issubset_interval(interval(-1/sqrt(2) , 1/sqrt(2)), sind(interval(-45, 45)))
    if Int == Int32 && VERSION < v"1.10"
        @test in_interval(0, sind(interval(180)))
        @test in_interval(0, sind(interval(360)))
        @test in_interval(1, sind(interval(90)))
        @test in_interval(-1, sind(interval(270)))
    else
        @test isthin(sind(interval(180)), 0)
        @test isthin(sind(interval(360)), 0)
        @test isthin(sind(interval(90)), 1)
        @test isthin(sind(interval(270)), -1)
    end
end

@testset "cospi" begin
    @test isempty_interval(cospi(emptyinterval()))
    @test isequal_interval(cospi(interval(1, 2)), interval(-1 , 1))
    @test issubset_interval(interval(-1 , 0), cospi(interval(0.5, 1.5)))
    @test issubset_interval(interval(-1/sqrt(2) , 1/sqrt(2)), cospi(interval(0.25, 0.75)))
    @test isequal_interval(cospi(interval(-0.25, 0.25)), interval(1/sqrt(2) , 1))
    if Int == Int32 && VERSION < v"1.10"
        @test in_interval(-1, cospi(interval(1.0)))
        @test in_interval(1, cospi(interval(2.0)))
        @test in_interval(0, cospi(interval(0.5)))
        @test in_interval(0, cospi(interval(1.5)))
    else
        @test isthin(cospi(interval(1.0)), -1)
        @test isthin(cospi(interval(2.0)), 1)
        @test isthin(cospi(interval(0.5)), 0)
        @test isthin(cospi(interval(1.5)), 0)
    end
end

@testset "cosd" begin
    @test isempty_interval(cosd(emptyinterval()))
    @test isequal_interval(cosd(interval(180, 360)), interval(-1 , 1))
    @test issubset_interval(interval(-1 , 0), cosd(interval(90, 270)))
    @test issubset_interval(interval(-1/sqrt(2) , 1/sqrt(2)), cosd(interval(45, 135)))
    @test isequal_interval(cosd(interval(-45, 45)), interval(1/sqrt(2) , 1))
    if Int == Int32 && VERSION < v"1.10"
        @test in_interval(-1, cosd(interval(180)))
        @test in_interval(1, cosd(interval(360)))
        @test in_interval(0, cosd(interval(90)))
        @test in_interval(0, cosd(interval(270)))
    else
        @test isthin(cosd(interval(180)), -1)
        @test isthin(cosd(interval(360)), 1)
        @test isthin(cosd(interval(90)), 0)
        @test isthin(cosd(interval(270)), 0)
    end
end

@testset "sincospi" begin
    x = sincospi(emptyinterval())
    @test isempty_interval(x[1]) & isempty_interval(x[2])
    x = sincospi(interval(1, 2))
    @test issubset_interval(interval(-1, 0), x[1]) & isequal_interval(x[2], interval(-1, 1))
    x = sincospi(interval(0.5, 1.5))
    @test isequal_interval(x[1], interval(-1, 1)) & issubset_interval(interval(-1, 0), x[2])
    x = sincospi(interval(0.25, 0.75))
    @test issubset_interval(interval(1/sqrt(2), 1), x[1]) & issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), x[2])
    x = sincospi(interval(-0.25, 0.25))
    @test issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), x[1]) & isequal_interval(x[2], interval(1/sqrt(2), 1))
end

@testset "sincosd" begin
    x = sincosd(emptyinterval())
    @test isempty_interval(x[1]) & isempty_interval(x[2])
    x = sincosd(interval(180, 380))
    @test issubset_interval(interval(-1, 0), x[1]) & isequal_interval(x[2], interval(-1, 1))
    x = sincosd(interval(90, 270))
    @test isequal_interval(x[1], interval(-1, 1)) & issubset_interval(interval(-1, 0), x[2])
    x = sincosd(interval(45, 135))
    @test issubset_interval(interval(1/sqrt(2), 1), x[1]) & issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), x[2])
    x = sincosd(interval(-45, 45))
    @test issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), x[1]) & isequal_interval(x[2], interval(1/sqrt(2), 1))
end

@testset "tan" begin
    @test isequal_interval(tan(interval(0.5)), interval(0.54630248984379048, 0.5463024898437906))
    @test isequal_interval(tan(interval(0.5, 1.67)), entireinterval())
    @test isequal_interval(tan(interval(1.67, 3.2)), interval(-10.047182299210307, 0.05847385445957865))
    @test isequal_interval(tan(interval(6.638314112824137, 8.38263151220128)), entireinterval())  # https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/20

    @test issubset_interval(tan(interval(BigFloat, 0.5, 0.5)), tan(interval(0.5)))
    @test isequal_interval(tan(interval(BigFloat, 0.5, 1.67)), entireinterval(BigFloat))
    @test issubset_interval(tan(interval(BigFloat, 0.5, 1.67)), tan(interval(0.5, 1.67)))
    @test issubset_interval(tan(interval(BigFloat, 1.67, 3.2)), tan(interval(1.67, 3.2)))
    @test issubset_interval(tan(interval(BigFloat, 2.1, 5.6)), tan(interval(2.1, 5.6)))
    @test issubset_interval(tan(interval(BigFloat, 0.5, 8.5)), tan(interval(0.5, 8.5)))
    @test issubset_interval(tan(interval(BigFloat, -4.5, 0.1)), tan(interval(-4.5, 0.1)))
    @test issubset_interval(tan(interval(BigFloat, 1.3, 6.3)), tan(interval(1.3, 6.3)))

end

@testset "Inverse trig" begin
    @test isequal_interval(asin(interval(1)), interval(π)/interval(2))
    @test isequal_interval(asin(interval(0.9, 2)), asin(interval(0.9, 1)))
    @test isequal_interval(asin(interval(3, 4)), emptyinterval())

    @test issubset_interval(asin(interval(BigFloat, 1, 1)), asin(interval(1)))
    @test issubset_interval(asin(interval(BigFloat, 0.9, 2)), asin(interval(0.9, 2)))
    @test issubset_interval(asin(interval(BigFloat, 3, 4)), asin(interval(3, 4)))

    @test isequal_interval(acos(interval(1)), interval(0., 0.))
    @test isequal_interval(acos(interval(-2, -0.9)), acos(interval(-1, -0.9)))
    @test isequal_interval(acos(interval(3, 4)), emptyinterval())

    @test issubset_interval(acos(interval(BigFloat, 1, 1)), acos(interval(1)))
    @test issubset_interval(acos(interval(BigFloat, -2, -0.9)), acos(interval(-2, -0.9)))
    @test issubset_interval(acos(interval(BigFloat, 3, 4)), acos(interval(3, 4)))

    @test isequal_interval(atan(interval(-1,1)),
        interval(-interval(sup(interval(Float64, π)))/interval(4), interval(sup(interval(Float64, π)))/interval(4)))
    @test isequal_interval(atan(interval(0)), interval(0.0, 0.0))
    @test issubset_interval(atan(interval(BigFloat, -1, 1)), atan(interval(-1, 1)))
end

@testset "atan" begin
    @test isequal_interval(atan(emptyinterval(), entireinterval()), emptyinterval())
    @test isequal_interval(atan(entireinterval(), emptyinterval()), emptyinterval())
    @test isequal_interval(atan(interval(0.0, 1.0), interval(BigFloat, 0.0, 0.0)), interval(BigFloat, π)/interval(2))
    @test isequal_interval(atan(interval(0.0, 1.0), interval(0.0)), interval(π)/interval(2))
    @test isequal_interval(atan(interval(-1.0, -0.1), interval(0.0)), -interval(π)/interval(2))
    @test isequal_interval(atan(interval(-1.0, 1.0), interval(0.0)), interval(-0.5, 0.5) * interval(π))
    @test isequal_interval(atan(interval(0.0), interval(0.1, 1.0)), interval(0.0))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, 0.1, 1.0)),
        atan(interval(0.0, 0.1), interval(0.1, 1.0)))
    @test isequal_interval(atan(interval(0.0, 0.1), interval(0.1, 1.0)),
        interval(0.0, 0.7853981633974484))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, 0.1, 1.0)),
        atan(interval(-0.1, 0.0), interval(0.1, 1.0)))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(0.1, 1.0)),
        interval(-0.7853981633974484, 0.0))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, 0.1, Inf)),
        atan(interval(-0.1, -0.1), interval(0.1, Inf)))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(0.1, Inf)),
        interval(-0.7853981633974484, 0.0))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, -0.1)),
        atan(interval(0.0, 0.1), interval(-2.0, -0.1)))
    @test isequal_interval(atan(interval(0.0, 0.1), interval(-2.0, -0.1)),
        interval(2.356194490192345, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, -2.0, -0.1)),
        atan(interval(-0.1, 0.0), interval(-2.0, -0.1)))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(-2.0, -0.1)),
        interval(-1, 1) * interval(π))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -Inf, -0.1)),
        atan(interval(-0.1, 0.1), interval(-Inf, -0.1)))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-Inf, -0.1)),
        interval(-1, 1) * interval(π))

    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)),
        atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test isequal_interval(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)),
        interval(3.141592653589793, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test isequal_interval(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)),
        interval(1.5707963267948966, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test isequal_interval(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)),
        interval(-2.3561944901923453, -1.5707963267948966))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)),
        interval(-1, 1) * interval(π))

    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)),
        atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test isequal_interval(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)),
        interval(3.141592653589793, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test isequal_interval(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)),
        interval(1.5707963267948966, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test isequal_interval(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)),
        interval(-2.3561944901923453, -1.5707963267948966))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)),
        interval(-1, 1) * interval(π))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, 0.1)),
        atan(interval(0.0, 0.1), interval(-2.0, 0.1)))
    @test isequal_interval(atan(interval(-0.0, 0.1), interval(-2.0, 0.1)),
        interval(0.0, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.1)),
        atan(interval(-0.1, -0.1), interval(-0.1, 0.1)))
    @test isequal_interval(atan(interval(-0.1, -0.1), interval(-0.1, 0.1)),
        interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp)))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.1)),
        atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))
    @test isequal_interval(interval(-1, 1) * interval(π), atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))

    @test isequal_interval(atan(interval(-0.1, 0.1), interval(0.1, 0.1)),
        interval(-0.7853981633974484, 0.7853981633974484))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, 0.1, 0.1)),
        atan(interval(-0.1, 0.1), interval(0.1, 0.1)))
    @test isequal_interval(atan(interval(0.0), interval(-0.0, 0.1)), interval(0.0))
    @test isequal_interval(atan(interval(0.0, 0.1), interval(-0.0, 0.1)),
        interval(0.0, 1.5707963267948968))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(0.0, 0.1)),
        interval(-1.5707963267948968, 0.0))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)),
        interval(-1.5707963267948968, 1.5707963267948968))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -0.0, 0.1)),
        atan(interval(-0.1, 0.1), interval(0.0, 0.1)))

    @test isequal_interval(atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)),
        interval(-0.78539824f0, 0.78539824f0))
    @test issubset_interval(atan(interval(-0.1, 0.1), interval(0.1, 0.1)),
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)))
    @test isequal_interval(atan(interval(Float32, 0.0, 0.0), interval(Float32, -0.0, 0.1)),
        interval(Float32, 0.0, 0.0))
    @test isequal_interval(atan(interval(Float32, 0.0, 0.1), interval(Float32, -0.0, 0.1)),
        interval(0.0, 1.5707964f0))
    @test isequal_interval(atan(interval(Float32, -0.1, 0.0), interval(Float32, 0.0, 0.1)),
        interval(-1.5707964f0, 0.0))
    @test isequal_interval(atan(interval(Float32, -0.1, 0.1), interval(Float32, -0.0, 0.1)),
        interval(-1.5707964f0, 1.5707964f0))
    @test issubset_interval(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)),
        atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.0, 0.1)))
end

@testset "Trig" begin
    for a in ( interval(17, 19), interval(0.5, 1.2) )
        @test issubset_interval(tan(a), sin(a)/cos(a))
    end

    @test isequal_interval(sin(interval(-pi/2, 3pi/2)), interval(-1, 1))
    @test isequal_interval(cos(interval(-pi/2, 3pi/2)), interval(-1, 1))
end

@testset "Trig with large arguments" begin
    x = pown(interval(2.), 1000)
    @test diam(x) == 0.0

    @test isequal_interval(sin(x), interval(-0.15920170308624246, -0.15920170308624243))
    @test isequal_interval(cos(x), interval(0.9872460775989135, 0.9872460775989136))
    @test isequal_interval(tan(x), interval(-0.16125837995065806, -0.16125837995065803))

    x = interval(prevfloat(Inf), Inf)
    @test isequal_interval(sin(x), interval(-1, 1))
    @test isequal_interval(cos(x), interval(-1, 1))
    @test isequal_interval(tan(x), interval(-Inf, Inf))
end
