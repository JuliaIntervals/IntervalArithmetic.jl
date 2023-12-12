@testset "Brodcasting" begin
    x = interval(1, 2)

    for f ∈ (+, -, *, /)
        @test isequal_interval(f.(x, x), f(x, x))
    end
end

@testset "Numeric tests" begin
    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)
    c = interval(0.25, 4.0)


    ## Basic arithmetic
    @test isequal_interval(+a, a)
    @test isequal_interval(-a, interval(-sup(a), -inf(a)))
    for f in (:+, :-, :*, :/)
        @eval begin
            @test isequal_interval($f(interval(Float64, pi), interval(Float32, pi)),
                $f(interval(Float64, pi), Interval{Float64}(interval(Float32, pi))))
        end
    end
    @test isequal_interval(interval(Rational{Int}, 1//4, 1//2) + interval(Rational{Int}, 2//3), interval(Rational{Int}, 11//12, 7//6))
    @test isequal_interval(interval(Rational{Int}, 1//4, 1//2) - interval(Rational{Int}, 2//3), interval(Rational{Int}, -5//12, -1//6))

    @test isequal_interval(interval(-30.0,-15.0) / interval(-5.0,-3.0), interval(3.0, 10.0))
    @test isequal_interval(interval(-30,-15) / interval(-5,-3), interval(3.0, 10.0))
    @test isequal_interval(a/c, interval(0.025, 4.4))
    @test isequal_interval(c/interval(4.0), interval(6.25e-02, 1e+00))
    @test isequal_interval(c/zero(c), emptyinterval(c))
    @test isequal_interval(interval(0.0, 1.0)/interval(0.0,1.0), interval(0.0, Inf))
    @test isequal_interval(interval(-1.0, 1.0)/interval(0.0,1.0), entireinterval(c))
    @test isequal_interval(interval(-1.0, 1.0)/interval(-1.0,1.0), entireinterval(c))

    @test all(isequal_interval.(extended_div(interval(-30.0,-15.0), interval(-5.0,-3.0)), (interval(3.0, 10.0), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(interval(-30,-15) , interval(-5,-3)), (interval(3.0, 10.0), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(interval(1.0, 2.0), interval(0.1, 1.0)), (interval(1, 20.0), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(a, c), (interval(0.025, 4.4e+00), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(c, interval(4.0)), (interval(6.25e-02, 1e+00), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(c, zero(c)), (emptyinterval(c), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(interval(0.0, 1.0), interval(0.0,1.0)), (entireinterval(c), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(interval(-1.0, 1.0), interval(0.0,1.0)), (entireinterval(c), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(interval(-1.0, 1.0), interval(-1.0,1.0)), (entireinterval(c), emptyinterval(c))))
    @test all(isequal_interval.(extended_div(interval(1.0, 2.0), interval(-4.0, 4.0)), (interval(-Inf, -0.25), interval(0.25, Inf))))
    @test all(isequal_interval.(extended_div(interval(-2.0, -1.0), interval(-2.0, 4.0)), (interval(-Inf, -0.25), interval(0.5, Inf))))
    @test all(isequal_interval.(extended_div(interval(0.0, 0.0), interval(-1.0, 1.0)), (entireinterval(c), emptyinterval(c))))

    @test isequal_interval(interval(0, Inf) * interval(-1, Inf), interval(-Inf, Inf))

    result = interval(1.1) * interval(2) + interval(3)
    @test isequal_interval(muladd(interval(1.1), interval(2), interval(3)), result)
    @test isequal_interval(muladd(interval(1.1), interval(Float32, 2), interval(3)), result)

end

@testset "Arithmetic with constants" begin
    x = interval(1, 2)

    @test isequal_interval(interval(0.1) + x, interval(1.0999999999999999, 2.1))
    @test isequal_interval(interval(3.0) - x, x)
    @test isequal_interval(interval(3.1) - x, interval(1.1, 2.1))
    @test isequal_interval(interval(0.1) * interval(1), interval(0.1, 0.1))
    @test isequal_interval(interval(0.0) * interval(1), interval(0.0, 0.0))
    @test isequal_interval(interval(1) / interval(10.0), interval(0.09999999999999999, 0.1))
end

@testset "Arithmetic with irrational" begin
    @test isequal_interval(interval(1) * interval(π), interval(π))
    @test isequal_interval(interval(π) * interval(1), interval(π))
    @test isequal_interval(interval(π) + interval(0), interval(π))
    @test isequal_interval(interval(0) + interval(π), interval(π))
    @test isequal_interval(interval(π) - interval(0), interval(π))
    @test isequal_interval(interval(0) - interval(π), -interval(π))
end

@testset "Power tests" begin
    @test isequal_interval(pown(interval(2,3)  , 2), interval(4, 9))
    @test isequal_interval(pown(interval(0,3)  , 2), interval(0, 9))
    @test isequal_interval(pown(interval(-3,0) , 2), interval(0, 9))
    @test isequal_interval(pown(interval(-3,-2), 2), interval(4, 9))
    @test isequal_interval(pown(interval(-3,2) , 2), interval(0, 9))
    @test isequal_interval(pown(interval(0,3)  , 3), interval(0, 27))
    @test isequal_interval(pown(interval(2,3)  , 3), interval(8, 27))
    @test isequal_interval(pown(interval(-3,0) , 3), interval(-27., 0.))
    @test isequal_interval(pown(interval(-3,-2), 3), interval(-27, -8))
    @test isequal_interval(pown(interval(-3,2) , 3), interval(-27., 8.))
    @test isequal_interval(pown(interval(0,3)  , -2), interval(1/9, Inf))
    @test isequal_interval(pown(interval(-3,0) , -2), interval(1/9, Inf))
    @test isequal_interval(pown(interval(-3,2) , -2), interval(1/9, Inf))
    @test isequal_interval(pown(interval(2,3)  , -2), interval(1/9, 1/4))
    @test isequal_interval(pown(interval(1,2)  , -3), interval(1/8, 1.0))
    @test isequal_interval(pown(interval(0,3)  , -3), interval(1/27, Inf))
    @test isequal_interval(pown(interval(-1,2) , -3), entireinterval())
    @test isequal_interval(pown(interval(-3,2) ,  3), interval(-27, 8))
    @test isequal_interval(pow(interval(0.0), interval(1.1)), interval(0))
    @test isequal_interval(pown(interval(0.0)  , 0), interval(1))
    @test isequal_interval(pow(interval(0.0), interval(1//10)), interval(0))
    @test isequal_interval(pow(interval(0.0), interval(-1//10)), emptyinterval())
    @test isequal_interval(pown(emptyinterval(), 0), emptyinterval())
    @test isequal_interval(pown(interval(2.5) , 3), interval(15.625, 15.625))
    @test isequal_interval(pown(interval(5//2), 3), interval(125//8))

    x = interval(-3, 2)
    @test isequal_interval(pown(x, 3), interval(-27, 8))

    @test isequal_interval(pow(interval(-3, 4), interval(0.5)), interval(0, 2))
    @test isequal_interval(pow(interval(-3, 4), interval(0.5)), pow(interval(-3, 4), (1//2)))
    @test isequal_interval(pown(interval(-3, 2), 2), interval(0.0, 9.0))
    @test isequal_interval(pow(interval(-3, 4), interval(0.5)), interval(0, 2))
    @test isequal_interval(pow(interval(BigFloat, -3, 4), interval(0.5)), interval(BigFloat, 0, 2))

    @test dist(pow(interval(1, 27), interval(1/3)), interval(1, 3)) < 2*inf(eps(interval(1, 3)))
    @test dist(pow(interval(1, 27), interval(1/3)), interval(1, 3)) < 2*inf(eps(interval(1, 3)))
    @test issubset_interval(interval(1, 3), pow(interval(1, 27), interval(1//3)))
    @test isequal_interval(pow(interval(0.1, 0.7), interval(1//3)), interval(0.46415888336127786, 0.8879040017426008))
    @test dist(pow(interval(0.1, 0.7), interval(1/3)),
        interval(0.46415888336127786, 0.8879040017426008)) < 2*inf(eps(pow(interval(0.1, 0.7), interval(1/3))))

    x = interval(BigFloat, 27)
    y = pow(x, interval(1//3))
    @test diam(y) == 0
    x = interval(BigFloat, 9.595703125)
    y = pow(x, interval(1//3))
    @test diam(y) == 0
    x = interval(BigFloat, 0.1)
    y = pow(x, interval(1//3))
    @test (0 <= diam(y) < 1e-76)
end

@testset "Exp and log tests" begin
    @test issubset_interval(exp(interval(BigFloat, 1//2)), exp(interval(1//2)))
    @test in_interval(exp(big(1//2)), exp(interval(1//2)))
    @test issubset_interval(exp(interval(BigFloat, 0.1)), exp(interval(0.1)))
    @test isequal_interval(exp(interval(0.1)), interval(1.1051709180756475e+00, 1.1051709180756477e+00))
    @test diam(exp(interval(0.1))) == eps(exp(0.1))

    @test issubset_interval(log(interval(BigFloat, 1//2)), log(interval(1//2)))
    @test in_interval(log(big(1//2)), log(interval(1//2)))
    @test issubset_interval(log(interval(BigFloat, 0.1)), log(interval(0.1)))
    @test isequal_interval(log(interval(0.1)), interval(-2.3025850929940459e+00, -2.3025850929940455e+00))
    @test diam(log(interval(0.1))) == eps(log(0.1))

    @test issubset_interval(exp2(interval(BigFloat, 1//2)), exp2(interval(1//2)))
    @test isequal_interval(exp2(interval(1024.0)), interval(1.7976931348623157e308, Inf))
    @test issubset_interval(exp10(interval(BigFloat, 1//2)), exp10(interval(1//2)))
    @test isequal_interval(exp10(interval(308.5)), interval(1.7976931348623157e308, Inf))

    @test issubset_interval(log2(interval(BigFloat, 1//2)), log2(interval(1//2)))
    @test isequal_interval(log2(interval(0.25, 0.5)), interval(-2.0, -1.0))
    @test in_interval(log10(big(1//10)), log10(interval(1//10)))

    @test isequal_interval(log1p(interval(-10.0)), emptyinterval())
end

@testset "Comparison tests" begin
    d = interval(0.1, 2)

    @test isstrictless(d, interval(3))
    @test isweakless(d, interval(2))
    @test isstrictless(interval(-1), d)

    # abs
    @test isequal_interval(abs(interval(0.1, 0.2)), interval(0.1, 0.2))
    @test isequal_interval(abs(interval(-1, 2)), interval(0, 2))

    # real
    @test isequal_interval(real(interval(-1, 1)), interval(-1, 1))
end

@testset "Rational tests" begin
    f = 1 // 3
    g = 1 // 3
    @test isequal_interval(interval(f*g), interval(1//9))
    @test isequal_interval(interval(1//9), interval(1//9, 1//9))
    @test isequal_interval(interval(f, g) - interval(1//1), interval(-2 // 3, -2 // 3))
    @test issubset_interval(interval(f*g), interval(1)/interval(9))
end

@testset "Floor etc. tests" begin
    a = interval(0.1)
    b = interval(0.1, 0.1)
    @test dist(a, b) <= inf(eps(a))

    @test isequal_interval(floor(interval(0.1, 1.1)), interval(0, 1))
    @test isequal_interval(round(interval(0.1, 1.1), RoundDown), interval(0, 1))
    @test isequal_interval(ceil(interval(0.1, 1.1)), interval(1, 2))
    @test isequal_interval(round(interval(0.1, 1.1), RoundUp), interval(1, 2))
    @test isequal_interval(sign(interval(0.1, 1.1)), interval(1.0))
    @test isequal_interval(trunc(interval(0.1, 1.1)), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.1), RoundToZero), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.1)), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.5)), interval(0.0, 2.0))
    @test isequal_interval(round(interval(-1.5, 0.1)), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(-2.5, 0.1)), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(0.1, 1.1), RoundNearest), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.5), RoundNearest), interval(0.0, 2.0))
    @test isequal_interval(round(interval(-1.5, 0.1), RoundNearest), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(-2.5, 0.1), RoundNearest), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(0.1, 1.1), RoundNearestTiesAway), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.5), RoundNearestTiesAway), interval(0.0, 2.0))
    @test isequal_interval(round(interval(-1.5, 0.1), RoundNearestTiesAway), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(-2.5, 0.1), RoundNearestTiesAway), interval(-3.0, 0.0))
end

@testset "Fast power" begin

    @testset "Fast integer powers" begin
        x = interval(1, 2)
        @test isequal_interval(fastpow(x, 2), interval(1, 4))
        @test isequal_interval(fastpow(x, 3), interval(1, 8))
        @test isempty_interval(fastpow(-x, 3))

        @test isequal_interval(fastpow(interval(-1, 2), 2), interval(0, 4))
        @test isequal_interval(fastpow(interval(-1, 2), 3), interval(0, 8))
        @test isequal_interval(fastpow(interval(-1, 2), 4), interval(0, 16))

        @test isempty_interval(fastpow(interval(-2, -1), interval(-1, -1)))

        @test isequal_interval(fastpow(interval(BigFloat, -1, 2), 2), interval(0, 4))
        @test isequal_interval(fastpow(interval(BigFloat, -1, 2), 3), interval(0, 8))
        @test isequal_interval(fastpow(interval(BigFloat, 1, 2), 2), interval(1, 4))

        x = interval(π)
        @test isinterior(pow(x, 100), fastpow(x, 100))
        @test isinterior(pow(x, 50), fastpow(x, 50))
        @test isinterior(pow(x, 50), fastpow(x, 50))

        x = interval(2)
        @test isequal_interval(fastpow(x, 2000), interval(floatmax(), Inf))
    end

    @testset "Fast real powers" begin
        x = interval(1, 2)
        @test isequal_interval(fastpow(x, 0.5), interval(1.0, 1.4142135623730951))
        @test isequal_interval(fastpow(x, 0.5), pow(x, interval(0.5)))

        y = interval(2, 3)
        @test isequal_interval(fastpow(y, -0.5), interval(0.5773502691896257, 0.7071067811865476))

        y = interval(-2, 3)
        @test isequal_interval(fastpow(y, 2.1), interval(0.0, 10.045108566305146))
        @test issubset_interval(pow(y, interval(2.1)), fastpow(y, 2.1))
    end

    @testset "Fast interval powers" begin
        x = interval(1, 2)
        @test isequal_interval(pow(x, interval(-1.5, 2.5)), interval(0.35355339059327373, 5.656854249492381))

        y = interval(-2, 3)
        @test isequal_interval(fastpow(y, 2.1), interval(0.0, 10.045108566305146))
        @test isequal_interval(fastpow(y, interval(-2, 3)), interval(0, Inf))

        @test isequal_interval(fastpow(y, interval(2.1)), interval(0.0, 10.045108566305146))
    end

    @testset "sqrt" begin
        @test isequal_interval(sqrt(interval(2, 3)), interval(1.414213562373095, 1.7320508075688774))

        @test isequal_interval(sqrt(big(interval(2, 3))), interval(big"1.414213562373095048801688724209698078569671875376948073176679737990732478462102", big"1.732050807568877293527446341505872366942805253810380628055806979451933016908815"))
    end

    @testset "cbrt" begin
        @test isequal_interval(cbrt(interval(2, 3)), interval(1.259921049894873, 1.4422495703074085))
        @test isequal_interval(cbrt(big(interval(2, 3))), interval(big"1.259921049894873164767210607278228350570251464701507980081975112155299676513956", big"1.442249570307408382321638310780109588391869253499350577546416194541687596830003"))
        @test issubset_interval(cbrt(big(interval(2, 3))), cbrt(interval(2, 3)))
        @test issubset_interval(Interval{Float64}(cbrt(big(interval(3, 4)))), cbrt(interval(3, 4)))
        @test isequal_interval(cbrt(interval(2f0, 3f0)), interval(1.259921f0, 1.4422497f0))
        @test issubset_interval(cbrt(interval(2, 3)), cbrt(interval(2f0, 3f0)))
    end

    @testset "inv" begin
        @test isequal_interval(inv(interval(2, 3)), interval(0.3333333333333333, 0.5))
        @test isequal_interval(inv(big(interval(2, 3))), interval(big"3.333333333333333333333333333333333333333333333333333333333333333333333333333305e-01", big"5.0e-01"))
    end

    @testset "Float32 intervals" begin

        a = interval(Float32, 1e38)
        b = interval(Float32, 1e2)
        @test isequal_interval(a * b, interval(Float32, floatmax(Float32), Inf))
        @test isequal_interval(pow(interval(1.0f0), interval(1.0f0)), interval(1.0f0)) # test for PR #482
    end



end

@testset "Mince for `Interval`s" begin
    II = interval(-1, 1)
    v = mince(II, 4)
    @test all(isequal_interval.(v, [interval(-1, -0.5), interval(-0.5, 0), interval(0, 0.5), interval(0.5, 1)]))
    @test isequal_interval(hull(v...), II)
    v = mince(II, 8)
    @test length(v) == 8
    @test isequal_interval(hull(v...), II)
end

@testset "rootn test" begin
    @test isequal_interval(rootn(emptyinterval(), 3),  emptyinterval())
    @test isequal_interval(rootn(emptyinterval(), 4), emptyinterval())
    @test isequal_interval(rootn(emptyinterval(), -3), emptyinterval())
    @test isequal_interval(rootn(emptyinterval(), -4), emptyinterval())
    @test isequal_interval(rootn(interval(1, 2), 0), emptyinterval())
    @test isequal_interval(rootn(interval(5, 8), 0), emptyinterval())
    @test isequal_interval(rootn(interval(1, 7), 0), emptyinterval())
    @test isequal_interval(rootn(interval(8, 27), 3), interval(2, 3))
    @test isequal_interval(rootn(interval(0, 27), 3), interval(0, 3))
    @test isequal_interval(rootn(interval(-27, 0), 3), interval(-3, 0))
    @test isequal_interval(rootn(interval(-27, 27), 3), interval(-3, 3))
    @test isequal_interval(rootn(interval(-27, -8), 3), interval(-3, -2))
    @test isequal_interval(rootn(interval(16, 81), 4), interval(2, 3))
    @test isequal_interval(rootn(interval(0, 81), 4), interval(0, 3))
    @test isequal_interval(rootn(interval(-81, 0), 4), interval(0))
    @test isequal_interval(rootn(interval(-81, 81), 4), interval(0, 3))
    @test isequal_interval(rootn(interval(-81, -16), 4), emptyinterval())
    @test isequal_interval(rootn(interval(8, 27), -3), interval(1/3, 1/2))
    @test isequal_interval(rootn(interval(0, 27), -3), interval(1/3, Inf))
    @test isequal_interval(rootn(interval(-27, 0), -3), interval(-Inf, -1/3))
    @test isequal_interval(rootn(interval(-27, 27), -3), interval(-Inf, Inf))
    @test isequal_interval(rootn(interval(-27, -8), -3), interval(-1/2, -1/3))
    @test isequal_interval(rootn(interval(16, 81), -4), interval(1/3, 1/2))
    @test isequal_interval(rootn(interval(0, 81), -4), interval(1/3, Inf))
    @test isequal_interval(rootn(interval(-81, 0), -4), emptyinterval())
    @test isequal_interval(rootn(interval(-81, 1), 1), interval(-81, 1))
    @test isequal_interval(rootn(interval(-81, 81), -4), interval(1/3, Inf))
    @test isequal_interval(rootn(interval(-81, -16), -4), emptyinterval())
    @test isequal_interval(rootn(interval(-81, -16), 1), interval(-81, -16))
    @test isequal_interval(rootn(interval(BigFloat, 16, 81), 4), interval(BigFloat, 2, 3))
    @test isequal_interval(rootn(interval(BigFloat, 0, 81), 4), interval(BigFloat, 0, 3))
    @test isequal_interval(rootn(interval(BigFloat, -81, 0), 4), interval(BigFloat, 0, 0))
    @test isequal_interval(rootn(interval(BigFloat, -81, 81), 4), interval(BigFloat, 0, 3))
    @test isequal_interval(rootn(interval(BigFloat, -27, 27), -3), interval(BigFloat, -Inf, Inf))
    @test isequal_interval(rootn(interval(BigFloat, -81, -16), -4), emptyinterval())
    @test isequal_interval(rootn(interval(BigFloat, -81, -16), 1), interval(BigFloat, -81, -16))
end
