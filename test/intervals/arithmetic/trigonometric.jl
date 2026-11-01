using Test
using IntervalArithmetic
using Logging

@testset "helper functions" begin
    @test IntervalArithmetic._quadrant(min, 0.0) == 0
    @test IntervalArithmetic._quadrant(min, 1.0) == 0
    @test IntervalArithmetic._quadrant(min, 2.0) == 1
    @test IntervalArithmetic._quadrant(min, -1.0) == 3
    @test IntervalArithmetic._quadrant(min, -2.0) == 2
    @test IntervalArithmetic._quadrant(min, 100.0) == 3
    @test IntervalArithmetic._quadrant(max, 100.0) == 3
    Logging.with_logger(Logging.NullLogger()) do
        @test_throws InexactError IntervalArithmetic._quadrant(min, Inf)
    end

    for x ∈ (1.5707963267948966, 1.5707963267948968, 3.141592653589793, 3.1415926535897936, -1.5707963267948966, -3.141592653589793)
        @test IntervalArithmetic._quadrant(min, x) ≤ IntervalArithmetic._quadrant(max, x)
    end

    for (x, q) ∈ ((0.0, 0), (0.4, 0), (0.6, 1), (1.2, 2), (1.6, 3), (-0.4, 3), (-0.6, 2), (-1.2, 1), (-1.6, 0), (2.0, 0), (-2.0, 0))
        @test IntervalArithmetic._quadrantpi(x) == q
    end

    bp = IntervalArithmetic._big_pi(1.0)
    @test bp isa BareInterval{BigFloat}
    @test precision(inf(bp)) == 256
    @test inf(bp) < π < sup(bp)
    bp = IntervalArithmetic._big_pi(BigFloat(1))
    @test precision(inf(bp)) == precision(BigFloat(1)) + 32

    @test bounds(IntervalArithmetic._unsafe_scale(bareinterval(1.0, 2.0), 0.5)) == (0.5, 1.0)
    r = IntervalArithmetic._unsafe_scale(bareinterval(3.0), 0.1)
    @test inf(r) < sup(r)
    @test inf(r) ≤ big(3.0) * big(0.1) ≤ sup(r)

    @test bounds(IntervalArithmetic._half_pi(Float64)) == (1.5707963267948966, 1.5707963267948968)
    @test in_interval(big(π) / 2, IntervalArithmetic._half_pi(Float64))
    @test bounds(IntervalArithmetic._range_atan(Float64)) == (-3.1415926535897936, 3.1415926535897936)
    @test bounds(IntervalArithmetic._half_range_atan(Float64)) == (-1.5707963267948968, 1.5707963267948968)
end

@testset "rad2deg and deg2rad" begin
    @test isequal_interval(rad2deg(bareinterval(Float64, π)), bareinterval(179.99999999999991, 180.00000000000006))
    r = rad2deg(interval(Float64, π))
    @test isequal_interval(r, interval(179.99999999999991, 180.00000000000006))
    @test decoration(r) == com
    @test isequal_interval(deg2rad(bareinterval(180.0)), bareinterval(3.141592653589793, 3.1415926535897936))
    @test in_interval(big(π), deg2rad(bareinterval(180.0)))
    @test decoration(deg2rad(interval(180.0))) == com

    @test isempty_interval(rad2deg(emptyinterval(BareInterval{Float64})))
    @test isempty_interval(deg2rad(emptyinterval()))
    r = @test_logs (:warn,) (:warn,) rad2deg(nai(Float64))
    @test isnai(r)
    @test numtype(rad2deg(bareinterval(Float32, 1))) === Float32
    @test numtype(deg2rad(bareinterval(BigFloat, 180))) === BigFloat

    @test issubset_interval(interval(180, 360), rad2deg(interval(π, 2π)))
    @test issubset_interval(interval(π, interval(2) * interval(π)), deg2rad(interval(180, 360)))
end

@testset "sin" begin
    @test isthinzero(sin(bareinterval(0.0)))
    @test isequal_interval(sin(bareinterval(0.0, 0.5)), bareinterval(0.0, 0.479425538604203))
    @test isequal_interval(sin(bareinterval(0.5, 1.67)), bareinterval(0.47942553860420295, 1.0))
    @test isequal_interval(sin(bareinterval(-0.5, 0.5)), bareinterval(-0.479425538604203, 0.479425538604203))
    @test isequal_interval(sin(bareinterval(2.0, 3.0)), bareinterval(0.1411200080598672, 0.9092974268256817))
    @test isequal_interval(sin(bareinterval(2.0, 4.0)), bareinterval(-0.7568024953079283, 0.9092974268256817))
    @test isequal_interval(sin(bareinterval(0.5, 6.0)), bareinterval(-1.0, 1.0))
    @test isequal_interval(sin(entireinterval(BareInterval{Float64})), bareinterval(-1.0, 1.0))
    @test isequal_interval(sin(bareinterval(-10.0, 10.0)), bareinterval(-1.0, 1.0))
    @test isempty_interval(sin(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(sin(bareinterval(1e10)), bareinterval(-0.48750602508751073, -0.4875060250875107))
    @test numtype(sin(bareinterval(1//2))) === Float64

    r = sin(interval(0.0, 1.0))
    @test isequal_interval(r, interval(0.0, 0.8414709848078966))
    @test decoration(r) == com
    @test decoration(sin(interval(1.0, 2.0, def))) == def
    @test isguaranteed(sin(interval(1.0)))
    @test !isguaranteed(sin(convert(Interval{Float64}, 1)))

    @test isequal_interval(sin(interval(0.5)), interval(0.47942553860420295, 0.47942553860420301))
    @test isequal_interval(sin(interval(0.5, 1.67)), interval(4.7942553860420295e-01, 1.0))
    @test isequal_interval(sin(interval(1.67, 3.2)), interval(-5.8374143427580093e-02, 9.9508334981018021e-01))
    @test isequal_interval(sin(interval(2.1, 5.6)), interval(-1.0, 0.8632093666488738))
    @test isequal_interval(sin(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test isequal_interval(sin(interval(Float64, -4.5, 0.1)), interval(-1.0, 0.9775301176650971))
    @test isequal_interval(sin(interval(Float64, 1.3, 6.3)), interval(-1.0, 1.0))

    for lo_hi ∈ ((0.5, 0.5), (0.5, 1.67), (1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(sin(interval(BigFloat, lo_hi...)), sin(interval(lo_hi...)))
    end

    z = interval(3, 1e-7; format = :midpoint) + interval(4, 1e-7; format = :midpoint) * interval(im)
    @test issubset_interval(sin(z), complex(sin(real(z)) * cosh(imag(z)), sinh(imag(z)) * cos(real(z))))
    @test isthinzero(sin(complex(interval(0.0), interval(0.0))))
    w = complex(interval(0.1), interval(0.2))
    @test isequal_interval(sin(w), complex(sin(real(w)) * cosh(imag(w)), cos(real(w)) * sinh(imag(w))))
end

@testset "sinpi" begin
    @test isthinzero(sinpi(bareinterval(0.0)))
    @test isthinzero(sinpi(bareinterval(1.0)))
    @test isthin(sinpi(bareinterval(0.5)), 1.0)
    @test isequal_interval(sinpi(bareinterval(-3.0, 3.0)), bareinterval(-1.0, 1.0))
    @test isempty_interval(sinpi(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(sinpi(entireinterval(BareInterval{Float64})), bareinterval(-1.0, 1.0))
    @test numtype(sinpi(bareinterval(1//2))) === Float64

    @test isempty_interval(sinpi(emptyinterval()))
    @test issubset_interval(interval(-1, 0), sinpi(interval(1, 2)))
    @test isequal_interval(sinpi(interval(0.5, 1.5)), interval(-1, 1))
    @test issubset_interval(interval(1/sqrt(2), 1), sinpi(interval(0.25, 0.75)))
    @test issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), sinpi(interval(-0.25, 0.25)))
    @test isthin(sinpi(interval(1.0)), 0)
    @test isthin(sinpi(interval(2.0)), 0)
    @test isthin(sinpi(interval(0.5)), 1)
    @test isthin(sinpi(interval(1.5)), -1)

    z = complex(interval(0.25), interval(0.5))
    @test isequal_interval(sinpi(z), complex(sinpi(real(z)) * cosh(imag(z) * interval(Float64, π)), cospi(real(z)) * sinh(imag(z) * interval(Float64, π))))
end

@testset "cos" begin
    @test isthin(cos(bareinterval(0.0)), 1.0)
    @test isequal_interval(cos(bareinterval(0.0, 0.5)), bareinterval(0.8775825618903726, 1.0))
    @test isequal_interval(cos(entireinterval(BareInterval{Float64})), bareinterval(-1.0, 1.0))
    @test isempty_interval(cos(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(cos(bareinterval(1e300)), bareinterval(-0.5753861119575491, -0.575386111957549))
    @test isequal_interval(cos(bareinterval(-2.0, 2.5)), bareinterval(-0.8011436155469338, 1.0))
    @test isequal_interval(cos(bareinterval(-1.0, 3.5)), bareinterval(-1.0, 1.0))
    @test numtype(cos(bareinterval(1//2))) === Float64

    @test isequal_interval(cos(interval(0.5)), interval(0.87758256189037265, 0.87758256189037276))
    @test isequal_interval(cos(interval(2.1, 5.6)), interval(-1.0, 0.7755658785102496))
    @test isequal_interval(cos(interval(0.5, 8.5)), interval(-1.0, 1.0))
    @test isequal_interval(cos(interval(1.67, 3.2)), interval(-1.0, -0.09904103659872801))
    @test decoration(cos(interval(0.0, 0.5))) == com
    @test isguaranteed(cos(interval(1.0)))

    for lo_hi ∈ ((0.5, 0.5), (0.5, 1.67), (1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(cos(interval(BigFloat, lo_hi...)), cos(interval(lo_hi...)))
    end

    k = [interval(0.0, 0.0625), interval(0.0625, 0.125), interval(0.0, 0.125)]
    x = k[1] * 4 + k[2] * 4 + k[3] * 4
    @test isequal_interval(cos(2 * π * x), interval(-1, 1))
    @test isequal_interval(cospi(2x), interval(-1, 1))

    w = complex(interval(0.1), interval(0.2))
    @test isequal_interval(cos(w), complex(cos(real(w)) * cosh(imag(w)), -sin(real(w)) * sinh(imag(w))))
end

@testset "cospi" begin
    @test isthin(cospi(bareinterval(0.0)), 1.0)
    @test isthin(cospi(bareinterval(1.0)), -1.0)
    @test isthinzero(cospi(bareinterval(0.5)))
    @test isthinzero(cospi(bareinterval(1.5)))
    @test isempty_interval(cospi(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(cospi(entireinterval(BareInterval{Float64})), bareinterval(-1.0, 1.0))
    @test numtype(cospi(bareinterval(1//2))) === Float64

    @test isempty_interval(cospi(emptyinterval()))
    @test isequal_interval(cospi(interval(1, 2)), interval(-1, 1))
    @test issubset_interval(interval(-1, 0), cospi(interval(0.5, 1.5)))
    @test issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), cospi(interval(0.25, 0.75)))
    @test isequal_interval(cospi(interval(-0.25, 0.25)), interval(1/sqrt(2), 1))
    @test isthin(cospi(interval(1.0)), -1)
    @test isthin(cospi(interval(2.0)), 1)
    @test isthin(cospi(interval(0.5)), 0)
    @test isthin(cospi(interval(1.5)), 0)
    @test decoration(cospi(interval(0.25, 0.5))) == com
    @test isguaranteed(cospi(interval(0.25)))

    z = complex(interval(0.25), interval(0.5))
    @test isequal_interval(cospi(z), complex(cospi(real(z)) * cosh(imag(z) * interval(Float64, π)), -sinpi(real(z)) * sinh(imag(z) * interval(Float64, π))))
end

@testset "sind, cosd, sincospi and sincosd" begin
    @test isequal_interval(sind(bareinterval(90.0)), bareinterval(1.0))
    @test isequal_interval(cosd(bareinterval(0.0)), bareinterval(1.0))
    r = sind(interval(90.0))
    @test isequal_interval(r, interval(1.0))
    @test decoration(r) == com
    r = cosd(interval(180.0))
    @test isequal_interval(r, interval(-1.0))
    @test decoration(r) == com

    @test isempty_interval(sind(emptyinterval()))
    @test issubset_interval(interval(-1, 0), sind(interval(180, 360)))
    @test isequal_interval(sind(interval(90, 270)), interval(-1, 1))
    @test issubset_interval(interval(1/sqrt(2), 1), sind(interval(45, 135)))
    @test issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), sind(interval(-45, 45)))
    @test isthin(sind(interval(180)), 0)
    @test isthin(sind(interval(360)), 0)
    @test isthin(sind(interval(90)), 1)
    @test isthin(sind(interval(270)), -1)

    @test isempty_interval(cosd(emptyinterval()))
    @test isequal_interval(cosd(interval(180, 360)), interval(-1, 1))
    @test issubset_interval(interval(-1, 0), cosd(interval(90, 270)))
    @test issubset_interval(interval(-1/sqrt(2), 1/sqrt(2)), cosd(interval(45, 135)))
    @test isequal_interval(cosd(interval(-45, 45)), interval(1/sqrt(2), 1))
    @test isthin(cosd(interval(180)), -1)
    @test isthin(cosd(interval(360)), 1)
    @test isthin(cosd(interval(90)), 0)
    @test isthin(cosd(interval(270)), 0)

    x = sincospi(bareinterval(0.5))
    @test isequal_interval(x[1], bareinterval(1.0))
    @test isequal_interval(x[2], bareinterval(0.0))
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
    for y ∈ (bareinterval(0.25, 0.75), interval(0.25, 0.75))
        x = sincospi(y)
        @test isequal_interval(x[1], sinpi(y))
        @test isequal_interval(x[2], cospi(y))
    end

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
    @test isthinzero(tan(bareinterval(0.0)))
    @test isequal_interval(tan(bareinterval(0.0, 1.0)), bareinterval(0.0, 1.5574077246549023))
    @test isentire_interval(tan(entireinterval(BareInterval{Float64})))
    @test isentire_interval(tan(bareinterval(1.0, 2.0)))
    @test isentire_interval(tan(bareinterval(1.5, 1.6)))
    @test isentire_interval(tan(bareinterval(1.57, 1.58)))
    @test isequal_interval(tan(bareinterval(1e10)), bareinterval(-0.5583496378112419, -0.5583496378112418))
    @test isempty_interval(tan(emptyinterval(BareInterval{Float64})))
    @test numtype(tan(bareinterval(1//2))) === Float64

    r = tan(interval(1.0, 2.0))
    @test isentire_interval(r)
    @test decoration(r) == trv
    @test decoration(tan(interval(0.0, 1.0))) == com
    r = tan(interval(1.0, Inf))
    @test isentire_interval(r)
    @test decoration(r) == trv
    @test isguaranteed(tan(interval(1.0)))

    @test isequal_interval(tan(interval(0.5)), interval(0.54630248984379048, 0.5463024898437906))
    @test isequal_interval(tan(interval(0.5, 1.67)), entireinterval())
    @test isequal_interval(tan(interval(1.67, 3.2)), interval(-10.047182299210307, 0.05847385445957865))
    @test isequal_interval(tan(interval(6.638314112824137, 8.38263151220128)), entireinterval())
    @test isentire_interval(tan(bareinterval(-3.1415926535897936, 0.0)))

    @test issubset_interval(tan(interval(BigFloat, 0.5, 0.5)), tan(interval(0.5)))
    @test isequal_interval(tan(interval(BigFloat, 0.5, 1.67)), entireinterval(BigFloat))
    @test issubset_interval(tan(interval(BigFloat, 0.5, 1.67)), tan(interval(0.5, 1.67)))
    for lo_hi ∈ ((1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(tan(interval(BigFloat, lo_hi...)), tan(interval(lo_hi...)))
    end

    w = complex(interval(0.1), interval(0.2))
    @test isequal_interval(tan(w), sin(w) / cos(w))
end

@testset "cot, sec and csc" begin
    @test isempty_interval(cot(bareinterval(0.0)))
    @test isequal_interval(cot(bareinterval(0.5, 1.0)), bareinterval(0.6420926159343306, 1.830487721712452))
    @test isequal_interval(cot(bareinterval(-1.0, 0.0)), bareinterval(-Inf, -0.6420926159343306))
    @test isequal_interval(cot(bareinterval(2.0, 3.0)), bareinterval(-7.015252551434534, -0.4576575543602857))
    @test isentire_interval(cot(bareinterval(3.0, 3.5)))
    @test isentire_interval(cot(bareinterval(-3.1415926535897936, 0.0)))
    @test isentire_interval(cot(entireinterval(BareInterval{Float64})))
    @test isempty_interval(cot(emptyinterval(BareInterval{Float64})))
    @test numtype(cot(bareinterval(1//2))) === Float64
    # cot(::Interval) falls back to 1/tan defined by Base, hence the slightly wider bound
    r = cot(interval(0.5, 1.0))
    @test bounds(r) == (0.6420926159343306, 1.8304877217124522)
    @test decoration(r) == com

    @test isthin(sec(bareinterval(0.0)), 1.0)
    @test isequal_interval(sec(bareinterval(0.0, 1.0)), bareinterval(1.0, 1.8508157176809257))
    @test isequal_interval(sec(bareinterval(2.0, 3.0)), bareinterval(-2.4029979617223813, -1.0101086659079936))
    @test isequal_interval(sec(bareinterval(2.0, 4.0)), bareinterval(-2.4029979617223813, -1.0))
    @test inf(sec(bareinterval(-1.0, 1.0))) == 1.0
    @test isentire_interval(sec(bareinterval(1.0, 2.0)))
    @test isentire_interval(sec(bareinterval(1.5, 1.6)))
    @test isentire_interval(sec(entireinterval(BareInterval{Float64})))
    @test isempty_interval(sec(emptyinterval(BareInterval{Float64})))
    @test numtype(sec(bareinterval(1//2))) === Float64
    r = sec(interval(0.0, 1.0))
    @test bounds(r) == (1.0, 1.850815717680926)
    @test decoration(r) == com

    @test isempty_interval(csc(bareinterval(0.0)))
    @test isequal_interval(csc(bareinterval(0.5, 1.0)), bareinterval(1.188395105778121, 2.0858296429334886))
    @test isequal_interval(csc(bareinterval(-1.0, 0.0)), bareinterval(-Inf, -1.188395105778121))
    @test bounds(csc(bareinterval(-2.0, 0.0))) == (-Inf, -1.0)
    @test inf(csc(bareinterval(1.0, 2.0))) == 1.0
    @test sup(csc(bareinterval(-2.0, -1.0))) == -1.0
    @test isentire_interval(csc(bareinterval(-0.1, 0.1)))
    @test isentire_interval(csc(bareinterval(3.0, 3.2)))
    @test isentire_interval(csc(entireinterval(BareInterval{Float64})))
    @test isempty_interval(csc(emptyinterval(BareInterval{Float64})))
    @test numtype(csc(bareinterval(1//2))) === Float64
    r = csc(interval(0.5, 1.0))
    @test issubset_interval(interval(1.188395105778121, 2.0858296429334886), r)
    @test decoration(r) == com
end

@testset "asin" begin
    @test isequal_interval(asin(bareinterval(-2.0, 2.0)), bareinterval(-1.5707963267948968, 1.5707963267948968))
    @test isthinzero(asin(bareinterval(0.0)))
    @test isempty_interval(asin(bareinterval(-3.0, -2.0)))
    @test isempty_interval(asin(emptyinterval(BareInterval{Float64})))
    @test numtype(asin(bareinterval(1//2))) === Float64

    @test decoration(asin(interval(-0.5, 0.5))) == com
    @test decoration(asin(interval(-2.0, 2.0))) == trv
    @test isguaranteed(asin(interval(0.5)))

    @test isequal_interval(asin(interval(1)), interval(π) / interval(2))
    @test isequal_interval(asin(interval(0.9, 2)), asin(interval(0.9, 1)))
    @test isequal_interval(asin(interval(3, 4)), emptyinterval())
    @test issubset_interval(asin(interval(BigFloat, 1, 1)), asin(interval(1)))
    @test issubset_interval(asin(interval(BigFloat, 0.9, 2)), asin(interval(0.9, 2)))
    @test issubset_interval(asin(interval(BigFloat, 3, 4)), asin(interval(3, 4)))
end

@testset "acos" begin
    @test isequal_interval(acos(bareinterval(-2.0, 2.0)), bareinterval(0.0, 3.1415926535897936))
    @test isthinzero(acos(bareinterval(1.0)))
    @test isempty_interval(acos(emptyinterval(BareInterval{Float64})))
    @test numtype(acos(bareinterval(1//2))) === Float64

    @test decoration(acos(interval(-0.5, 0.5))) == com
    @test decoration(acos(interval(-2.0, 2.0))) == trv

    @test isequal_interval(acos(interval(1)), interval(0.0, 0.0))
    @test isequal_interval(acos(interval(-2, -0.9)), acos(interval(-1, -0.9)))
    @test isequal_interval(acos(interval(3, 4)), emptyinterval())
    @test issubset_interval(acos(interval(BigFloat, 1, 1)), acos(interval(1)))
    @test issubset_interval(acos(interval(BigFloat, -2, -0.9)), acos(interval(-2, -0.9)))
    @test issubset_interval(acos(interval(BigFloat, 3, 4)), acos(interval(3, 4)))
end

@testset "atan" begin
    @test isthinzero(atan(bareinterval(0.0)))
    @test isequal_interval(atan(entireinterval(BareInterval{Float64})), bareinterval(-1.5707963267948968, 1.5707963267948968))
    @test isempty_interval(atan(emptyinterval(BareInterval{Float64})))
    @test numtype(atan(bareinterval(1//2))) === Float64

    @test decoration(atan(interval(0.0, 1.0))) == com
    @test decoration(atan(interval(-Inf, Inf))) == dac

    @test isequal_interval(atan(interval(-1, 1)), interval(-0.7853981633974484, 0.7853981633974484))
    @test isequal_interval(atan(interval(0)), interval(0.0, 0.0))
    @test issubset_interval(atan(interval(BigFloat, -1, 1)), atan(interval(-1, 1)))
end

@testset "acot" begin
    r = acot(bareinterval(1.0, 2.0))
    @test bounds(r) == (0.4636476090008061, 0.7853981633974484)
    @test inf(r) ≤ acot(2.0) && acot(1.0) ≤ sup(r)
    x = 0x1.9c14c6477256cp-1
    r = acot(bareinterval(x))
    @test inf(r) ≤ acot(big(x)) ≤ sup(r)
    @test isempty_interval(acot(emptyinterval(BareInterval{Float64})))

    # acot(0) = π/2; the jump at 0 is decorated like the branch cut of two-argument atan
    @test isequal_interval(acot(bareinterval(0.0)), IntervalArithmetic._half_pi(Float64))
    @test in_interval(acot(0.0), acot(bareinterval(0.0)))
    @test bounds(acot(bareinterval(-1.0, 1.0))) == (-1.5707963267948968, 1.5707963267948968)
    @test bounds(acot(bareinterval(0.0, 1.0))) == (0.7853981633974483, 1.5707963267948968)
    @test bounds(acot(bareinterval(-1.0, 0.0))) == (-1.5707963267948968, 1.5707963267948968)
    @test bounds(acot(entireinterval(BareInterval{Float64}))) == (-1.5707963267948968, 1.5707963267948968)

    r = acot(interval(0.5, 1.0))
    @test isequal_interval(r, interval(0.7853981633974483, 1.1071487177940906))
    @test decoration(r) == com
    @test decoration(acot(interval(0.0))) == dac
    @test decoration(acot(interval(0.0, 1.0))) == dac
    @test decoration(acot(interval(-1.0, 0.0))) == def
    @test decoration(acot(interval(-1.0, 1.0))) == def
    @test !isguaranteed(acot(convert(Interval{Float64}, 1)))
end

@testset "two-argument atan" begin
    @test isempty_interval(atan(bareinterval(0.0), bareinterval(0.0)))
    @test isequal_interval(atan(bareinterval(1.0), bareinterval(0.0)), IntervalArithmetic._half_pi(Float64))
    @test isequal_interval(atan(bareinterval(-1.0), bareinterval(0.0)), -IntervalArithmetic._half_pi(Float64))
    @test isequal_interval(atan(bareinterval(-1.0, 1.0), bareinterval(0.0)), IntervalArithmetic._half_range_atan(Float64))

    y = bareinterval(0.0)
    @test atan(y, bareinterval(1.0, 2.0)) === y
    @test isequal_interval(atan(bareinterval(1.0), bareinterval(1.0)), bareinterval(0.7853981633974483, 0.7853981633974484))
    @test isequal_interval(atan(bareinterval(0.0), bareinterval(-1.0)), bareinterval(3.141592653589793, 3.1415926535897936))
    @test isequal_interval(atan(bareinterval(-1.0, 1.0), bareinterval(-2.0, -1.0)), IntervalArithmetic._range_atan(Float64))
    @test isequal_interval(atan(bareinterval(1.0, 2.0), bareinterval(-1.0, 1.0)), bareinterval(0.7853981633974483, 2.3561944901923453))
    @test isequal_interval(atan(bareinterval(-1.0, 1.0), bareinterval(-1.0, 1.0)), IntervalArithmetic._range_atan(Float64))

    e = emptyinterval(BareInterval{Float64})
    @test atan(e, bareinterval(1.0)) === e
    @test isempty_interval(atan(bareinterval(1.0), e))
    @test isequal_interval(atan(bareinterval(1//1), bareinterval(1//1)), bareinterval(0.7853981633974483, 0.7853981633974484))
    @test isequal_interval(atan(bareinterval(Float32, 1), bareinterval(Float32, 1)), bareinterval(0.7853981f0, 0.7853982f0))

    @test decoration(atan(interval(-1.0, 1.0), interval(-1.0, 0.0))) == trv
    @test decoration(atan(interval(-1.0, 1.0), interval(-2.0, -1.0))) == def
    @test decoration(atan(interval(0.0, 1.0), interval(-2.0, -1.0))) == dac
    @test decoration(atan(interval(0.1, 1.0), interval(-2.0, -1.0))) == com
    @test decoration(atan(interval(1.0, 2.0), interval(1.0, 2.0))) == com
    @test !isguaranteed(atan(interval(1.0), convert(Interval{Float64}, 1)))
    r = @test_logs (:warn,) atan(nai(Float64), interval(1.0))
    @test isnai(r)

    @test isequal_interval(atan(emptyinterval(), entireinterval()), emptyinterval())
    @test isequal_interval(atan(entireinterval(), emptyinterval()), emptyinterval())
    @test isequal_interval(atan(interval(0.0, 1.0), interval(BigFloat, 0.0, 0.0)), interval(BigFloat, π) / interval(2))
    @test isequal_interval(atan(interval(0.0, 1.0), interval(0.0)), interval(π) / interval(2))
    @test isequal_interval(atan(interval(-1.0, -0.1), interval(0.0)), -interval(π) / interval(2))
    @test isequal_interval(atan(interval(-1.0, 1.0), interval(0.0)), interval(-0.5, 0.5) * interval(π))
    @test isequal_interval(atan(interval(0.0), interval(0.1, 1.0)), interval(0.0))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, 0.1, 1.0)), atan(interval(0.0, 0.1), interval(0.1, 1.0)))
    @test isequal_interval(atan(interval(0.0, 0.1), interval(0.1, 1.0)), interval(0.0, 0.7853981633974484))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, 0.1, 1.0)), atan(interval(-0.1, 0.0), interval(0.1, 1.0)))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(0.1, 1.0)), interval(-0.7853981633974484, 0.0))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, 0.1, Inf)), atan(interval(-0.1, -0.1), interval(0.1, Inf)))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(0.1, Inf)), interval(-0.7853981633974484, 0.0))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, -0.1)), atan(interval(0.0, 0.1), interval(-2.0, -0.1)))
    @test isequal_interval(atan(interval(0.0, 0.1), interval(-2.0, -0.1)), interval(2.356194490192345, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.0), interval(BigFloat, -2.0, -0.1)), atan(interval(-0.1, 0.0), interval(-2.0, -0.1)))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(-2.0, -0.1)), interval(-1, 1) * interval(π))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -Inf, -0.1)), atan(interval(-0.1, 0.1), interval(-Inf, -0.1)))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-Inf, -0.1)), interval(-1, 1) * interval(π))

    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.0), interval(BigFloat, -2.0, 0.0)), atan(interval(0.0, 0.0), interval(-2.0, 0.0)))
    @test isequal_interval(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)), interval(3.141592653589793, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -0.1, 0.0)), atan(interval(0.0, 0.1), interval(-0.1, 0.0)))
    @test isequal_interval(atan(interval(-0.0, 0.1), interval(-0.1, 0.0)), interval(1.5707963267948966, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.0)), atan(interval(-0.1, -0.1), interval(-0.1, 0.0)))
    @test isequal_interval(atan(interval(-0.1, -0.1), interval(-0.1, 0.0)), interval(-2.3561944901923453, -1.5707963267948966))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.0)), atan(interval(-0.1, 0.1), interval(-2.0, 0.0)))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-2.0, 0.0)), interval(-1, 1) * interval(π))
    @test issubset_interval(atan(interval(BigFloat, 0.0, 0.1), interval(BigFloat, -2.0, 0.1)), atan(interval(0.0, 0.1), interval(-2.0, 0.1)))
    @test isequal_interval(atan(interval(-0.0, 0.1), interval(-2.0, 0.1)), interval(0.0, 3.1415926535897936))
    @test issubset_interval(atan(interval(BigFloat, -0.1, -0.1), interval(BigFloat, -0.1, 0.1)), atan(interval(-0.1, -0.1), interval(-0.1, 0.1)))
    @test isequal_interval(atan(interval(-0.1, -0.1), interval(-0.1, 0.1)), interval(-2.3561944901923453, Float64(-big(pi)/4, RoundUp)))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -2.0, 0.1)), atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))
    @test isequal_interval(interval(-1, 1) * interval(π), atan(interval(-0.1, 0.1), interval(-2.0, 0.1)))

    @test isequal_interval(atan(interval(-0.1, 0.1), interval(0.1, 0.1)), interval(-0.7853981633974484, 0.7853981633974484))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, 0.1, 0.1)), atan(interval(-0.1, 0.1), interval(0.1, 0.1)))
    @test isequal_interval(atan(interval(0.0), interval(-0.0, 0.1)), interval(0.0))
    @test isequal_interval(atan(interval(0.0, 0.1), interval(-0.0, 0.1)), interval(0.0, 1.5707963267948968))
    @test isequal_interval(atan(interval(-0.1, 0.0), interval(0.0, 0.1)), interval(-1.5707963267948968, 0.0))
    @test isequal_interval(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)), interval(-1.5707963267948968, 1.5707963267948968))
    @test issubset_interval(atan(interval(BigFloat, -0.1, 0.1), interval(BigFloat, -0.0, 0.1)), atan(interval(-0.1, 0.1), interval(0.0, 0.1)))

    @test isequal_interval(atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)), interval(-0.78539824f0, 0.78539824f0))
    @test issubset_interval(atan(interval(-0.1, 0.1), interval(0.1, 0.1)), atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.1, 0.1)))
    @test isequal_interval(atan(interval(Float32, 0.0, 0.0), interval(Float32, -0.0, 0.1)), interval(Float32, 0.0, 0.0))
    @test isequal_interval(atan(interval(Float32, 0.0, 0.1), interval(Float32, -0.0, 0.1)), interval(0.0, 1.5707964f0))
    @test isequal_interval(atan(interval(Float32, -0.1, 0.0), interval(Float32, 0.0, 0.1)), interval(-1.5707964f0, 0.0))
    @test isequal_interval(atan(interval(Float32, -0.1, 0.1), interval(Float32, -0.0, 0.1)), interval(-1.5707964f0, 1.5707964f0))
    @test issubset_interval(atan(interval(-0.1, 0.1), interval(-0.0, 0.1)), atan(interval(Float32, -0.1, 0.1), interval(Float32, 0.0, 0.1)))
end

@testset "trig identities" begin
    for a ∈ (interval(17, 19), interval(0.5, 1.2))
        @test issubset_interval(tan(a), sin(a) / cos(a))
    end
    @test isequal_interval(sin(interval(-pi/2, 3pi/2)), interval(-1, 1))
    @test isequal_interval(cos(interval(-pi/2, 3pi/2)), interval(-1, 1))
end

@testset "large arguments" begin
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

@testset "inverse roots of unity" begin
    for i ∈ 0:99
        @test issubset_interval(cispi(-interval(i) / interval(50)), inv(cispi(interval(i) / interval(50))))
        @test radius(inv(cispi(interval(i) / interval(50)))) < 10eps()
    end
end

@testset "complex inverse trig" begin
    z = complex(interval(0.1), interval(0.2))
    r = asin(sin(z))
    @test issubset_interval(real(z), real(r))
    @test issubset_interval(imag(z), imag(r))
    r = atan(tan(z))
    @test issubset_interval(real(z), real(r))
    @test issubset_interval(imag(z), imag(r))
    @test in_interval(asin(0.5), real(asin(complex(interval(0.5), interval(0.0)))))
    @test in_interval(acos(0.5), real(acos(complex(interval(0.5), interval(0.0)))))
    @test in_interval(atan(0.5), real(atan(complex(interval(0.5), interval(0.0)))))
end

@testset "point enclosure" begin
    for x ∈ (bareinterval(-1.2, 1.3), bareinterval(2.0, 7.5))
        for t ∈ range(inf(x), sup(x); length = 7)
            @test in_interval(sin(t), sin(x))
            @test in_interval(cos(t), cos(x))
            @test in_interval(tan(t), tan(x))
            @test in_interval(sinpi(t), sinpi(x))
            @test in_interval(cospi(t), cospi(x))
            @test in_interval(atan(t), atan(x))
        end
    end
    x = bareinterval(-0.9, 0.9)
    for t ∈ range(inf(x), sup(x); length = 7)
        @test in_interval(asin(t), asin(x))
        @test in_interval(acos(t), acos(x))
    end
    y = bareinterval(0.2, 1.7)
    x = bareinterval(-2.4, -0.3)
    for s ∈ range(inf(y), sup(y); length = 5), t ∈ range(inf(x), sup(x); length = 5)
        @test in_interval(atan(s, t), atan(y, x))
    end
end
