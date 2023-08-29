using Test
using IntervalArithmetic

@testset "brodcasting tests" begin
    a = 3
    b = 12
    x = interval(a, b)

    for i in 1:20
        @test x.-i ≛ interval(a-i, b-i)
    end


    for i in 1:20
        @test x.*i ≛ interval(a*i, b*i)
    end

    a = 4
    b = 5
    y = interval(a, b)
    for i in 1:20
        @test y.+i ≛ interval(a+i, b+i)
    end

    for i in 1:20
        @test y./i ≛ interval(/(a, i, RoundDown), /(b, i, RoundUp))
    end
end

@testset "Numeric tests" begin
    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)
    c = interval(0.25, 4.0)


    ## Basic arithmetic
    @test +a ≛ a
    @test a + b ≛ interval(+(a.lo, b.lo, RoundDown), +(a.hi, b.hi, RoundUp))
    @test -a ≛ interval(-a.hi, -a.lo)
    @test a - b ≛ interval(-(a.lo, b.hi, RoundDown), -(a.hi, b.lo, RoundUp))
    for f in (:+, :-, :*, :/)
        @eval begin
            @test $f(interval(Float64, pi), interval(Float32, pi)) ≛
                $f(interval(Float64, pi), Interval{Float64}(interval(Float32, pi)))
        end
    end
    @test interval(Rational{Int}, 1//4, 1//2) + interval(Rational{Int}, 2//3) ≛ interval(Rational{Int}, 11//12, 7//6)
    @test interval(Rational{Int}, 1//4, 1//2) - interval(Rational{Int}, 2//3) ≛ interval(Rational{Int}, -5//12, -1//6)

    @test interval(-30.0,-15.0) / interval(-5.0,-3.0) ≛ interval(3.0, 10.0)
    @test interval(-30,-15) / interval(-5,-3) ≛ interval(3.0, 10.0)
    @test b/a ≛ interval(/(b.lo, a.hi, RoundDown), /(b.hi, a.lo, RoundUp))
    @test a/c ≛ interval(0.025, 4.4)
    @test c/4.0 ≛ interval(6.25e-02, 1e+00)
    @test c/zero(c) ≛ emptyinterval(c)
    @test interval(0.0, 1.0)/interval(0.0,1.0) ≛ interval(0.0, Inf)
    @test interval(-1.0, 1.0)/interval(0.0,1.0) ≛ entireinterval(c)
    @test interval(-1.0, 1.0)/interval(-1.0,1.0) ≛ entireinterval(c)

    @test extended_div(interval(-30.0,-15.0), interval(-5.0,-3.0)) ≛ (interval(3.0, 10.0), emptyinterval(c))
    @test extended_div(interval(-30,-15) , interval(-5,-3)) ≛ (interval(3.0, 10.0), emptyinterval(c))
    @test extended_div(interval(1.0, 2.0), interval(0.1, 1.0)) ≛ (interval(1, 20.0), emptyinterval(c))
    @test extended_div(a, c) ≛ (interval(0.025, 4.4e+00), emptyinterval(c))
    @test extended_div(c, interval(4.0)) ≛ (interval(6.25e-02, 1e+00), emptyinterval(c))
    @test extended_div(c, zero(c)) ≛ (emptyinterval(c), emptyinterval(c))
    @test extended_div(interval( 0.0, 1.0), interval(0.0,1.0)) ≛ (entireinterval(c), emptyinterval(c))
    @test extended_div(interval(-1.0, 1.0), interval(0.0,1.0)) ≛ (entireinterval(c), emptyinterval(c))
    @test extended_div(interval(-1.0, 1.0), interval(-1.0,1.0)) ≛ (entireinterval(c), emptyinterval(c))
    @test extended_div(interval(1.0, 2.0), interval(-4.0, 4.0)) ≛ (interval(-Inf, -0.25), interval(0.25, Inf))
    @test extended_div(interval(-2.0, -1.0), interval(-2.0, 4.0)) ≛ (interval(-Inf, -0.25), interval(0.5, Inf))
    @test extended_div(interval(0.0, 0.0), interval(-1.0, 1.0)) ≛ (entireinterval(c), emptyinterval(c))

    @test interval(0, Inf) * interval(-1, Inf) ≛ interval(-Inf, Inf)

    result = interval(1.1) * interval(2) + interval(3)
    @test muladd(interval(1.1), interval(2), interval(3)) ≛ result
    @test muladd(interval(1.1), interval(Float32, 2), interval(3)) ≛ result
    @test muladd(interval(1.1), interval(2), 3) ≛ result
    @test muladd(interval(1.1), 2, interval(3)) ≛ result
    @test muladd(1.1, interval(2), interval(3)) ≛ result
    @test muladd(interval(1.1), 2, 3) ≛ result
    @test muladd(1.1, interval(2), 3) ≛ result
    @test muladd(1.1, 2, interval(3)) ≛ result

end

@testset "Arithmetic with constants" begin
    x = interval(1, 2)

    @test 0.1 + x ≛ interval(1.0999999999999999, 2.1)
    @test 3.0 - x ≛ x
    @test 3.1 - x ≛ interval(1.1, 2.1)
    @test 0.1 * interval(1) ≛ interval(0.1, 0.1)
    @test 0.0 * interval(1) ≛ interval(0.0, 0.0)
    @test interval(1) / 10.0 ≛ interval(0.09999999999999999, 0.1)
end

@testset "Arithmetic with irrational" begin
    @test interval(1) * π ≛ interval(π)
    @test π * interval(1) ≛ interval(π)
    @test π + interval(0) ≛ interval(π)
    @test interval(0) + π ≛ interval(π)
    @test π - interval(0) ≛ interval(π)
    @test interval(0) - π ≛ -interval(π)
end

@testset "Power tests" begin
    @test interval(0,3) ^ 2 ≛ interval(0, 9)
    @test interval(2,3) ^ 2 ≛ interval(4, 9)
    @test interval(-3,0) ^ 2 ≛ interval(0, 9)
    @test interval(-3,-2) ^ 2 ≛ interval(4, 9)
    @test interval(-3,2) ^ 2 ≛ interval(0, 9)
    @test interval(0,3) ^ 3 ≛ interval(0, 27)
    @test interval(2,3) ^ 3 ≛ interval(8, 27)
    @test interval(-3,0) ^ 3 ≛ interval(-27., 0.)
    @test interval(-3,-2) ^ 3 ≛ interval(-27, -8)
    @test interval(-3,2) ^ 3 ≛ interval(-27., 8.)
    @test interval(0,3) ^ -2 ≛ interval(1/9, Inf)
    @test interval(-3,0) ^ -2 ≛ interval(1/9, Inf)
    @test interval(-3,2) ^ -2 ≛ interval(1/9, Inf)
    @test interval(2,3) ^ -2 ≛ interval(1/9, 1/4)
    @test interval(1,2) ^ -3 ≛ interval(1/8, 1.0)
    @test interval(0,3) ^ -3 ≛ interval(1/27, Inf)
    @test interval(-1,2) ^ -3 ≛ entireinterval()
    @test interval(-3,2) ^ (3//1) ≛ interval(-27, 8)
    @test interval(0.0) ^ 1.1 ≛ interval(0, 0)
    @test interval(0.0) ^ 0.0 ≛ emptyinterval()
    @test interval(0.0) ^ (1//10) ≛ interval(0, 0)
    @test interval(0.0) ^ (-1//10) ≛ emptyinterval()
    @test emptyinterval() ^ 0 ≛ emptyinterval()
    @test interval(2.5)^3 ≛ interval(15.625, 15.625)
    @test interval(5//2)^3.0 ≛ interval(125//8)

    x = interval(-3, 2)
    @test x^3 ≛ interval(-27, 8)

    @test interval(-3, 4) ^ 0.5 ≛ interval(0, 2)
    @test interval(-3, 4) ^ 0.5 ≛ interval(-3, 4)^(1//2)
    @test interval(-3, 2) ^ interval(2) ≛ interval(0.0, 4.0)
    @test interval(-3, 4) ^ interval(0.5) ≛ interval(0, 2)
    @test interval(BigFloat, -3, 4) ^ 0.5 ≛ interval(BigFloat, 0, 2)

    @test dist(interval(1,27)^interval(1/3), interval(1., 3.)) < 2*eps(interval(1,3)).lo
    @test dist(interval(1,27)^(1/3), interval(1., 3.)) < 2*eps(interval(1,3)).lo
    @test interval(1., 3.) ⊆ interval(1,27)^(1//3)
    @test interval(0.1,0.7)^(1//3) ≛ interval(0.46415888336127786, 0.8879040017426008)
    @test dist(interval(0.1,0.7)^(1/3),
        interval(0.46415888336127786, 0.8879040017426008)) < 2*eps(interval(0.1,0.7)^(1/3)).lo

    x = interval(BigFloat, 27)
    y = x^(1//3)
    @test diam(y) == 0
    x = interval(BigFloat, 9.595703125)
    y = x^(1//3)
    @test diam(y) == 0
    x = interval(BigFloat, 0.1)
    y = x^(1//3)
    @test (0 <= diam(y) < 1e-76)
end

@testset "Exp and log tests" begin
    @test exp(interval(BigFloat, 1//2)) ⊆ exp(interval(1//2))
    @test exp(big(1//2)) ∈ exp(interval(1//2))
    @test exp(interval(BigFloat, 0.1)) ⊆ exp(interval(0.1))
    @test exp(interval(0.1)) ≛ interval(1.1051709180756475e+00, 1.1051709180756477e+00)
    @test diam(exp(interval(0.1))) == eps(exp(0.1))

    @test log(interval(BigFloat, 1//2)) ⊆ log(interval(1//2))
    @test log(big(1//2)) ∈ log(interval(1//2))
    @test log(interval(BigFloat, 0.1)) ⊆ log(interval(0.1))
    @test log(interval(0.1)) ≛ interval(-2.3025850929940459e+00, -2.3025850929940455e+00)
    @test diam(log(interval(0.1))) == eps(log(0.1))

    @test exp2(interval(BigFloat, 1//2)) ⊆ exp2(interval(1//2))
    @test exp2(interval(1024.0)) ≛ interval(1.7976931348623157e308, Inf)
    @test exp10(interval(BigFloat, 1//2)) ⊆ exp10(interval(1//2))
    @test exp10(interval(308.5)) ≛ interval(1.7976931348623157e308, Inf)

    @test log2(interval(BigFloat, 1//2)) ⊆ log2(interval(1//2))
    @test log2(interval(0.25, 0.5)) ≛ interval(-2.0, -1.0)
    @test log10(big(1//10)) ∈ log10(interval(1//10))
    @test log10(interval(0.01, 0.1)) ≛ interval(log10(0.01, RoundDown), log10(0.1, RoundUp))

    @test log1p(interval(-0.5, 0.1)) ≛ interval(log1p(-0.5, RoundDown), log1p(0.1, RoundUp))
    @test log1p(interval(-10.0)) ≛ emptyinterval()
end

@testset "Comparison tests" begin
    d = interval(0.1, 2)

    @test isstrictless(d, interval(3))
    @test isweaklyless(d, interval(2))
    @test isstrictless(interval(-1), d)

    # abs
    @test abs(interval(0.1, 0.2)) ≛ interval(0.1, 0.2)
    @test abs(interval(-1, 2)) ≛ interval(0, 2)

    # real
    @test real(interval(-1, 1)) ≛ interval(-1, 1)
end

@testset "Rational tests" begin
    f = 1 // 3
    g = 1 // 3
    @test interval(f*g) ≛ interval(1//9) ≛ interval(1//9, 1//9)
    @test interval(f, g) - 1 ≛ interval(-2 // 3, -2 // 3)
    @test interval(f*g) ⊆ interval(1)/9
end

@testset "Floor etc. tests" begin
    a = interval(0.1)
    b = interval(0.1, 0.1)
    @test dist(a, b) <= eps(a).lo

    @test floor(interval(0.1, 1.1)) ≛ interval(0, 1)
    @test round(interval(0.1, 1.1), RoundDown) ≛ interval(0, 1)
    @test ceil(interval(0.1, 1.1)) ≛ interval(1, 2)
    @test round(interval(0.1, 1.1), RoundUp) ≛ interval(1, 2)
    @test sign(interval(0.1, 1.1)) ≛ interval(1.0)
    @test signbit(interval(-4)) ≛ interval(1,1)
    @test signbit(interval(5)) ≛ interval(0,0)
    @test signbit(interval(-4,5)) ≛ interval(0,1)
    @test copysign(interval(1,2), interval(-1,1)) ≛ interval(-2,2)
    @test copysign(3, interval(-1,1)) ≛ interval(-3,3)
    @test copysign(3.0, interval(-1,1)) ≛ interval(-3,3)
    @test copysign(3f0, interval(-1,1)) ≛ interval(-3,3)
    @test copysign(3, interval(0,1)) ≛ interval(3) ≛ interval(copysign(3,0),copysign(3,1))
    @test copysign(3, interval(-1,0)) ≛ interval(-3,3) ≛ interval(copysign(3,-1),copysign(3,0))
    @test copysign(UInt64(3), interval(-1,1)) ≛ interval(-3,3)
    @test copysign(BigFloat(3), interval(-1,1)) ≛ interval(-3,3)
    @test copysign(interval(0,1), -1) ≛ interval(-1,0)
    @test copysign(interval(0,1), -1.0) ≛ interval(-1,0)
    @test copysign(interval(0,1), -1f0) ≛ interval(-1,0)
    @test copysign(interval(0,1), -BigFloat(1)) ≛ interval(-1,0)
    @test copysign(interval(0,1), UInt64(1)) ≛ interval(0,1)
    @test copysign(interval(-1),interval(-1)) ≛ interval(-1)
    @test copysign(interval(-2,2), 2) ≛ interval(0,2)
    @test flipsign(interval(1,2), interval(-1,1)) ≛ interval(-2,2)
    @test flipsign(interval(1,2), interval(1,2)) ≛ interval(1,2)
    @test flipsign(3, interval(-1,1)) ≛ interval(-3,3)
    @test flipsign(3.0, interval(-1,1)) ≛ interval(-3,3)
    @test flipsign(3f0, interval(-1,1)) ≛ interval(-3,3)
    @test flipsign(3, interval(0,1)) ≛ interval(3,3) ≛ interval(flipsign(3,0),flipsign(3,1))
    @test flipsign(3, interval(-1,0)) ≛ interval(-3,3) ≛ interval(flipsign(3,-1),flipsign(3,0))
    @test flipsign(UInt64(3), interval(-1,1)) ≛ interval(-3,3)
    @test flipsign(BigFloat(3), interval(-1,1)) ≛ interval(-3,3)
    @test flipsign(interval(0,1), -1) ≛ interval(-1,0)
    @test flipsign(interval(0,1), -1.0) ≛ interval(-1,0)
    @test flipsign(interval(0,1), -1f0) ≛ interval(-1,0)
    @test flipsign(interval(0,1), -BigFloat(1)) ≛ interval(-1,0)
    @test flipsign(interval(0,1), UInt64(1)) ≛ interval(0,1)
    @test flipsign(interval(-1),interval(-1)) ≛ interval(1)
    @test trunc(interval(0.1, 1.1)) ≛ interval(0.0, 1.0)
    @test round(interval(0.1, 1.1), RoundToZero) ≛ interval(0.0, 1.0)
    @test round(interval(0.1, 1.1)) ≛ interval(0.0, 1.0)
    @test round(interval(0.1, 1.5)) ≛ interval(0.0, 2.0)
    @test round(interval(-1.5, 0.1)) ≛ interval(-2.0, 0.0)
    @test round(interval(-2.5, 0.1)) ≛ interval(-2.0, 0.0)
    @test round(interval(0.1, 1.1), RoundTiesToEven) ≛ interval(0.0, 1.0)
    @test round(interval(0.1, 1.5), RoundTiesToEven) ≛ interval(0.0, 2.0)
    @test round(interval(-1.5, 0.1), RoundTiesToEven) ≛ interval(-2.0, 0.0)
    @test round(interval(-2.5, 0.1), RoundTiesToEven) ≛ interval(-2.0, 0.0)
    @test round(interval(0.1, 1.1), RoundTiesToAway) ≛ interval(0.0, 1.0)
    @test round(interval(0.1, 1.5), RoundTiesToAway) ≛ interval(0.0, 2.0)
    @test round(interval(-1.5, 0.1), RoundTiesToAway) ≛ interval(-2.0, 0.0)
    @test round(interval(-2.5, 0.1), RoundTiesToAway) ≛ interval(-3.0, 0.0)
end

@testset "Fast power" begin

    @testset "Fast integer powers" begin
        x = interval(1, 2)
        @test pow(x, 2) ≛ pow(-x, 2) ≛ interval(1, 4)
        @test pow(-x, 3) ≛ interval(-8.0, -1.0)

        @test pow(interval(-1, 2), 2) ≛ interval(0, 4)
        @test pow(interval(-1, 2), 3) ≛ interval(-1, 8)
        @test pow(interval(-1, 2), 4) ≛ interval(0, 16)

        @test pow(interval(-2, -1), interval(4)) ≛ interval(1, 16)
        @test pow(interval(-2, -1), interval(-1, -1)) ≛ interval(-1, -0.5)

        @test pow(interval(BigFloat, -1, 2), 2) ≛ interval(0, 4)
        @test pow(interval(BigFloat, -1, 2), 3) ≛ interval(-1, 8)
        @test pow(interval(BigFloat, 1, 2), 2) ≛ interval(1, 4)

        x = interval(pi)
        @test x^100 ⊆ pow(x, 100)
        @test x^50 ⊆ pow(x, 50)
        @test isinterior(x^50, pow(x, 50))

        x = interval(2)
        @test pow(x, 2000) ≛ interval(floatmax(), Inf)
    end

    @testset "Fast real powers" begin
        x = interval(1, 2)
        @test pow(x, 0.5) ≛ interval(1.0, 1.4142135623730951)
        @test pow(x, 0.5) ≛ x^0.5

        y = interval(2, 3)
        @test pow(y, -0.5) ≛ interval(0.5773502691896257, 0.7071067811865476)

        y = interval(-2, 3)
        @test pow(y, 2.1) ≛ interval(0.0, 10.045108566305146)
        @test y^2.1 ⊆ pow(y, 2.1)
    end

    @testset "Fast interval powers" begin
        x = interval(1, 2)
        @test x^interval(-1.5, 2.5) ≛ interval(0.35355339059327373, 5.656854249492381)

        y = interval(-2, 3)
        @test pow(y, 2.1) ≛ interval(0.0, 10.045108566305146)
        @test pow(y, interval(-2, 3)) ≛ interval(0, Inf)

        @test pow(y, interval(2.1)) ≛ interval(0.0, 10.045108566305146)
    end

    @testset "sqrt" begin
        @test sqrt(interval(2, 3)) ≛ interval(1.414213562373095, 1.7320508075688774)

        @test sqrt(big(interval(2, 3))) ≛ interval(big"1.414213562373095048801688724209698078569671875376948073176679737990732478462102", big"1.732050807568877293527446341505872366942805253810380628055806979451933016908815")
    end

    @testset "cbrt" begin
        @test cbrt(interval(2, 3)) ≛ interval(1.259921049894873, 1.4422495703074085)
        @test cbrt(big(interval(2, 3))) ≛ interval(big"1.259921049894873164767210607278228350570251464701507980081975112155299676513956", big"1.442249570307408382321638310780109588391869253499350577546416194541687596830003")
        @test cbrt(big(interval(2, 3))) ⊆ cbrt(interval(2, 3))
        @test_skip ismissing(cbrt(big(interval(3, 4))) == cbrt(interval(3, 4)))
        @test cbrt(interval(2f0, 3f0)) ≛ interval(1.259921f0, 1.4422497f0)
        @test cbrt(interval(2, 3)) ⊆ cbrt(interval(2f0, 3f0))
    end

    @testset "inv" begin
        @test inv(interval(2, 3)) ≛ interval(0.3333333333333333, 0.5)
        @test inv(big(interval(2, 3))) ≛ interval(big"3.333333333333333333333333333333333333333333333333333333333333333333333333333305e-01", big"5.0e-01")
    end

    @testset "Float32 intervals" begin

        a = interval(Float32, 1e38)
        b = interval(Float32, 1e2)
        @test a * b ≛ interval(Float32, floatmax(Float32), Inf)
        @test interval(1.0f0) ^ interval(1.0f0) ≛ interval(1.0f0) # test for PR #482
    end



end

@testset "Mince for `Interval`s" begin
    II = interval(-1, 1)
    v = mince(II, 4)
    @test all(v .≛ [interval(-1, -0.5), interval(-0.5, 0), interval(0, 0.5), interval(0.5, 1)])
    @test hull(v...) ≛ II
    @test hull(v) ≛ II
    v = mince(II, 8)
    @test length(v) == 8
    @test hull(v...) ≛ II
    @test hull(v) ≛ II
end

@testset "nthroot test" begin
    @test nthroot(emptyinterval(), 3) ≛ emptyinterval()
    @test nthroot(emptyinterval(), 4) ≛ emptyinterval()
    @test nthroot(emptyinterval(), -3) ≛ emptyinterval()
    @test nthroot(emptyinterval(), -4) ≛ emptyinterval()
    @test nthroot(interval(1, 2), 0) ≛ emptyinterval()
    @test nthroot(interval(5, 8), 0) ≛ emptyinterval()
    @test nthroot(interval(1, 7), 0) ≛ emptyinterval()
    @test nthroot(interval(8, 27), 3) ≛ interval(2, 3)
    @test nthroot(interval(0, 27), 3) ≛ interval(0, 3)
    @test nthroot(interval(-27, 0), 3) ≛ interval(-3, 0)
    @test nthroot(interval(-27, 27), 3) ≛ interval(-3, 3)
    @test nthroot(interval(-27, -8), 3) ≛ interval(-3, -2)
    @test nthroot(interval(16, 81), 4) ≛ interval(2, 3)
    @test nthroot(interval(0, 81), 4) ≛ interval(0, 3)
    @test nthroot(interval(-81, 0), 4) ≛ interval(0)
    @test nthroot(interval(-81, 81), 4) ≛ interval(0, 3)
    @test nthroot(interval(-81, -16), 4) ≛ emptyinterval()
    @test nthroot(interval(8, 27), -3) ≛ interval(1/3, 1/2)
    @test nthroot(interval(0, 27), -3) ≛ interval(1/3, Inf)
    @test nthroot(interval(-27, 0), -3) ≛ interval(-Inf, -1/3)
    @test nthroot(interval(-27, 27), -3) ≛ interval(-Inf, Inf)
    @test nthroot(interval(-27, -8), -3) ≛ interval(-1/2, -1/3)
    @test nthroot(interval(16, 81), -4) ≛ interval(1/3, 1/2)
    @test nthroot(interval(0, 81), -4) ≛ interval(1/3, Inf)
    @test nthroot(interval(-81, 0), -4) ≛ emptyinterval()
    @test nthroot(interval(-81, 1), 1) ≛ interval(-81, 1)
    @test nthroot(interval(-81, 81), -4) ≛ interval(1/3, Inf)
    @test nthroot(interval(-81, -16), -4) ≛ emptyinterval()
    @test nthroot(interval(-81, -16), 1) ≛ interval(-81, -16)
    @test nthroot(interval(BigFloat, 16, 81), 4) ≛ interval(BigFloat, 2, 3)
    @test nthroot(interval(BigFloat, 0, 81), 4) ≛ interval(BigFloat, 0, 3)
    @test nthroot(interval(BigFloat, -81, 0), 4) ≛ interval(BigFloat, 0, 0)
    @test nthroot(interval(BigFloat, -81, 81), 4) ≛ interval(BigFloat, 0, 3)
    @test nthroot(interval(BigFloat, -27, 27), -3) ≛ interval(BigFloat, -Inf, Inf)
    @test nthroot(interval(BigFloat, -81, -16), -4) ≛ emptyinterval()
    @test nthroot(interval(BigFloat, -81, -16), 1) ≛ interval(BigFloat, -81, -16)
end
