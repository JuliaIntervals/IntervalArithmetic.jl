using Test
using IntervalArithmetic

@testset "PowerMode" begin
    @test IntervalArithmetic.default_power() === IntervalArithmetic.PowerMode{:fast}()

    x = bareinterval(-2.0, 3.0)
    y = bareinterval(1.0, 2.0)
    @test isequal_interval(IntervalArithmetic._select_pown(IntervalArithmetic.PowerMode{:fast}(), x, 3), fastpown(x, 3))
    @test isequal_interval(IntervalArithmetic._select_pown(IntervalArithmetic.PowerMode{:slow}(), x, 3), pown(x, 3))
    @test isequal_interval(IntervalArithmetic._select_pow(IntervalArithmetic.PowerMode{:fast}(), y, bareinterval(2.0, 3.0)), fastpow(y, bareinterval(2.0, 3.0)))
    @test isequal_interval(IntervalArithmetic._select_pow(IntervalArithmetic.PowerMode{:slow}(), y, bareinterval(2.0, 3.0)), pow(y, bareinterval(2.0, 3.0)))

    # invokelatest is needed since `configure` redefines `default_power` in a newer world age
    try
        IntervalArithmetic.configure(power = :slow)
        @test Base.invokelatest(IntervalArithmetic.default_power) === IntervalArithmetic.PowerMode{:slow}()
        @test isequal_interval(Base.invokelatest(^, x, bareinterval(3.0)), bareinterval(-8.0, 27.0))
        @test_throws ArgumentError IntervalArithmetic.configure(power = :bogus)
    finally
        IntervalArithmetic.configure(power = :fast)
    end
    @test Base.invokelatest(IntervalArithmetic.default_power) === IntervalArithmetic.PowerMode{:fast}()
    @test isequal_interval(Base.invokelatest(^, x, bareinterval(3.0)), bareinterval(-18.0, 27.0))
end

@testset "^ operator" begin
    @test isequal_interval(bareinterval(2, 3) ^ bareinterval(2), bareinterval(4.0, 9.0))
    @test isequal_interval(bareinterval(2.0) ^ bareinterval(0.5), bareinterval(1.414213562373095, 1.4142135623730951))
    @test_throws InexactError bareinterval(2.0) ^ bareinterval(1e300)

    r = interval(-1, 1) ^ interval(3)
    @test isequal_interval(r, interval(-1.0, 1.0))
    @test decoration(r) == com
    r = interval(-1, 1) ^ interval(-3)
    @test isentire_interval(r)
    @test decoration(r) == trv

    @test decoration(interval(2.0) ^ interval(3.0, 3.0, def)) == def
    @test !isguaranteed(interval(2.0) ^ convert(Interval{Float64}, 2))
    r = interval(2.0) ^ emptyinterval()
    @test isempty_interval(r)
    @test decoration(r) == trv

    n = 3
    @test !isguaranteed(interval(2.0) ^ n)
    @test isguaranteed(interval(2.0) ^ 3)
    @test isequal_interval(interval(2.0) ^ n, interval(8.0))

    r = interval(2.0) ^ (1//2)
    @test isequal_interval(r, interval(1.414213562373095, 1.4142135623730951))
    @test !isguaranteed(r)
end

@testset "literal powers" begin
    @test isequal_interval(interval(-2.0, 3.0) ^ 2, interval(0.0, 9.0))
    @test isequal_interval(interval(-2.0, 3.0) ^ 3, interval(-18.0, 27.0))
    @test isequal_interval(interval(-2.0, 3.0) ^ 0, interval(1.0))
    r = interval(-2.0, 3.0) ^ -1
    @test isentire_interval(r)
    @test decoration(r) == trv

    @test isequal_interval(complex(interval(1.0, 2.0), interval(1.0, 2.0)) ^ 2, complex(interval(-3.0, 3.0), interval(2.0, 8.0)))
    @test isequal_interval(complex(interval(1.0, 2.0), interval(1.0, 2.0)) ^ 0, complex(interval(1.0), interval(0.0)))

    x = interval(-1, 1)
    n2 = 2
    @test isguaranteed(x ^ 2)
    @test !isguaranteed(x ^ n2)
    @test !isguaranteed(x ^ 2.0)
    if VERSION ≥ v"1.12-DEV" && Int != Int32
        @test isguaranteed(x ^ 2305843009213693952)
    else
        @test_broken isguaranteed(x ^ 2305843009213693952)
    end
    @test isequal_interval(x ^ 2, interval(0, 1))
    @test isequal_interval(x ^ 3, x)
end

@testset "BareInterval powers" begin
    x = bareinterval(2, 3)
    y = bareinterval(-1, 1)
    n = 2 # a non-literal exponent bypasses `literal_pow`

    @test isequal_interval(x^2, bareinterval(4, 9))
    @test isequal_interval(x^n, bareinterval(4, 9))
    @test isequal_interval(x^(2//1), bareinterval(4, 9))
    @test isequal_interval(x^0, bareinterval(1, 1))
    @test isequal_interval(y^2, bareinterval(0, 1))
    @test isequal_interval(y^3, y)
    @test isequal_interval(y^-1, entireinterval(BareInterval{Float64}))
    @test isequal_interval(emptyinterval(BareInterval{Float64})^2, emptyinterval(BareInterval{Float64}))

    for m ∈ (-3, -2, -1, 0, 1, 2, 3)
        @test isequal_interval(x^m, bareinterval(interval(2, 3)^m))
        @test isequal_interval(y^m, bareinterval(interval(-1, 1)^m))
    end
    @test isequal_interval(x^(1//3), bareinterval(interval(2, 3)^(1//3)))

    r = bareinterval(Rational{Int64}, 1//2, 3//4)
    @test r^2 isa BareInterval{Rational{Int64}}
    @test isequal_interval(r^2, bareinterval(Rational{Int64}, 1//4, 9//16))
end

@testset "complex powers" begin
    z = complex(interval(1.0, 2.0), interval(1.0, 2.0))
    @test isequal_interval(z ^ complex(interval(2.0), interval(0.0)), complex(interval(-3.0, 3.0), interval(2.0, 8.0)))

    w = complex(interval(2.0), interval(0.0)) ^ complex(interval(2.0, 4.0), interval(0.0))
    @test issubset_interval(interval(4.0, 16.0), real(w))
    @test isthinzero(imag(w))

    @test isempty_interval(complex(emptyinterval(), interval(1.0)) ^ complex(interval(2.0), interval(0.0)))

    x = complex(interval(2.0), interval(1.0))
    y = complex(interval(1.0), interval(1.0))
    @test isequal_interval(x ^ y, exp(y * log(x)))

    @test isequal_interval(complex(interval(2.0), interval(0.0)) ^ interval(2.0), complex(interval(4.0), interval(0.0)))
    @test isequal_interval(interval(2.0) ^ complex(interval(2.0), interval(0.0)), complex(interval(4.0), interval(0.0)))

    a = interval(3 + 4im)
    b = exp(a)
    @test isequal_interval(real(b), interval(-13.12878308146216, -13.128783081462153))
    @test isequal_interval(imag(b), interval(-15.200784463067956, -15.20078446306795))

    ze = exp(-im * interval(π))
    @test in_interval(-1, real(ze))
    @test in_interval(0, imag(ze))

    z0 = interval(0im)
    @test isthinzero(z0 ^ 2)
    @test isthinone(z0 ^ 0)
    @test isempty_interval(z0 ^ (-1))
    @test isthinzero(z0 ^ interval(2))
    @test isthinone(z0 ^ interval(0))
    @test isempty_interval(z0 ^ interval(-1))
    @test isempty_interval(z0 ^ emptyinterval())

    x34 = interval(3 + 4im)
    @test in_interval(-7 + 24im, x34 ^ 2)
    @test issubset_interval(sqrt(x34), x34 ^ 0.5)
    a2 = -3.1
    @test issubset_interval(x34, (x34 ^ a2) ^ (1 / a2))
    @test in_interval(2 + im, sqrt(x34))

    @test issubset_interval(interval(0, 1) * interval(im), sqrt(interval(-1, 0) + interval(0) * interval(im)))
    @test issubset_interval(interval(0, 1) + interval(0, 1) * interval(im), sqrt(interval(-1, 1) + interval(0) * interval(im)))
    @test issubset_interval(interval(0, Inf) + interval(-3//8, Inf) * interval(im), sqrt(interval(-9//32, Inf) * interval(im)))

    xc = interval(-0.5) + interval(im) * interval(-1e-14, 1e-14)
    yc = interval(1)
    @test issubset_interval(xc ^ yc, exp(yc * log(xc)))
    yc = interval(1.5, 2.5)
    res = xc ^ yc
    ref = exp(yc * log(xc))
    @test inf(real(ref)) < -0.3 < -1e-13 < inf(real(res))
    yc = interval(-2, Inf)
    @test isequal_interval(xc ^ yc, exp(yc * log(xc)))
    @test isequal_interval(fastpown(xc, 1), xc ^ interval(1))
    @test isequal_interval(fastpown(xc, 2), xc ^ interval(2))
    @test isequal_interval(fastpown(xc, 5), xc ^ interval(5))
end

@testset "pow" begin
    @test isequal_interval(pow(bareinterval(2, 3), bareinterval(2)), bareinterval(4.0, 9.0))
    @test isequal_interval(pow(bareinterval(-1.0, 1.0), bareinterval(0.5)), bareinterval(0.0, 1.0))
    @test isempty_interval(pow(bareinterval(2.0), emptyinterval(BareInterval{Float64})))
    @test isempty_interval(pow(bareinterval(-2.0, -1.0), bareinterval(2.0)))
    @test isthinzero(pow(bareinterval(0.0), bareinterval(1.0)))
    @test isempty_interval(pow(bareinterval(0.0), bareinterval(0.0)))
    @test isempty_interval(pow(bareinterval(0.0), bareinterval(-1.0)))
    @test isequal_interval(pow(bareinterval(0.0, 2.0), bareinterval(1.0, 2.0)), bareinterval(0.0, 4.0))

    @test numtype(pow(bareinterval(2.0), bareinterval(1//2))) === Float64
    @test isequal_interval(pow(bareinterval(1//2, 1//1), bareinterval(2//1)), bareinterval(1//4, 1//1))
    @test numtype(pow(bareinterval(1//2, 1//1), bareinterval(2//1))) === Rational{Int}

    @test isequal_interval(pow(bareinterval(2.0), 3), bareinterval(8.0))
    @test isequal_interval(pow(bareinterval(4.0), 1//2), bareinterval(2.0))
    @test isequal_interval(pow(bareinterval(2.0), 3), pow(bareinterval(2.0), bareinterval(3)))

    r = pow(interval(-1, 1), interval(3))
    @test isequal_interval(r, interval(0.0, 1.0))
    @test decoration(r) == trv
    r = pow(interval(-1, 1), interval(-3))
    @test isequal_interval(r, interval(1.0, Inf))
    @test decoration(r) == trv
    @test isequal_interval(pow(interval(2, 3), interval(0, 1)), interval(1, 3))
    r = pow(interval(0, 2), interval(0, 1))
    @test isequal_interval(r, interval(0, 2))
    @test decoration(r) == trv
    r = pow(interval(-3, 2), interval(0, 1))
    @test isequal_interval(r, interval(0, 2))
    @test decoration(r) == trv
    r = pow(interval(-3, 2), interval(-1, 1))
    @test isequal_interval(r, interval(0, Inf))
    @test decoration(r) == trv
    @test decoration(pow(interval(1.0, 2.0), interval(0.0, 1.0))) == com
    @test decoration(pow(interval(0.0, 1.0), interval(1.0, 2.0))) == com
    @test decoration(pow(interval(0.0, 1.0), interval(0.0, 1.0))) == trv
    @test decoration(pow(interval(-1.0, 1.0), interval(1.0, 2.0))) == trv
    @test !isguaranteed(pow(interval(2.0), convert(Interval{Float64}, 2)))
    @test isguaranteed(pow(interval(2.0), 3))
    @test isequal_interval(pow(interval(2.0), 3), interval(8.0))
    @test isequal_interval(pow(interval(4.0), 1//2), interval(2.0))

    a = interval(1, 2)
    @test isequal_interval(pow(a, interval(3, 4)), interval(1, 16))
    @test isequal_interval(pow(a, interval(0.5, 1)), a)
    @test isequal_interval(pow(a, interval(0.3, 0.5)), interval(1, sqrt(2)))
    @test isequal_interval(pow(a, interval(-1.5, 2.5)), interval(0.35355339059327373, 5.656854249492381))

    @test isequal_interval(pow(interval(0.0), interval(1.1)), interval(0))
    @test isequal_interval(pow(interval(0.0), interval(1//10)), interval(0))
    @test isequal_interval(pow(interval(0.0), interval(-1//10)), emptyinterval())

    @test isequal_interval(pow(interval(-3, 4), interval(0.5)), interval(0, 2))
    @test isequal_interval(pow(interval(-3, 4), interval(0.5)), pow(interval(-3, 4), 1//2))
    @test isequal_interval(pow(interval(BigFloat, -3, 4), interval(0.5)), interval(BigFloat, 0, 2))

    @test dist(pow(interval(1, 27), interval(1/3)), interval(1, 3)) < 2 * inf(eps(interval(1, 3)))
    @test issubset_interval(interval(1, 3), pow(interval(1, 27), interval(1//3)))
    @test isequal_interval(pow(interval(0.1, 0.7), interval(1//3)), interval(0.46415888336127786, 0.8879040017426008))
    @test dist(pow(interval(0.1, 0.7), interval(1/3)), interval(0.46415888336127786, 0.8879040017426008)) < 2 * inf(eps(pow(interval(0.1, 0.7), interval(1/3))))

    @test diam(pow(interval(BigFloat, 27), interval(1//3))) == 0
    @test diam(pow(interval(BigFloat, 9.595703125), interval(1//3))) == 0
    @test 0 <= diam(pow(interval(BigFloat, 0.1), interval(1//3))) < 1e-76

    @test isequal_interval(pow(interval(1.0f0), interval(1.0f0)), interval(1.0f0))
end

@testset "pow with rational exponents" begin
    @test isequal_interval(pow(emptyinterval(), 1//3), emptyinterval())
    @test isequal_interval(pow(interval(1, 8), 1//3), interval(1, 2))
    @test issubset_interval(interval(2^(1//3), 2), pow(interval(2, 8), 1//3))
    @test issubset_interval(interval(1, 9^(1//3)), pow(interval(1, 9), 1//3))
    @test issubset_interval(interval(2^(1//3), 9^(1//3)), pow(interval(2, 9), 1//3))
    @test isequal_interval(pow(interval(-1, 8), 1//3), interval(0, 2))
    @test issubset_interval(interval(0, 2), pow(interval(-2, 8), 1//3))
    @test issubset_interval(interval(0, 9^(1//3)), pow(interval(-1, 9), 1//3))
    @test issubset_interval(interval(0, 9^(1//3)), pow(interval(-2, 9), 1//3))
    @test isequal_interval(pow(interval(1, 8), -1//3), interval(0.5, 1))
    @test issubset_interval(interval(0.5, 2^(-1//3)), pow(interval(2, 8), -1//3))
    @test issubset_interval(interval(9^(-1//3), 1), pow(interval(1, 9), -1//3))
    @test issubset_interval(interval(9^(-1//3), 2^(-1//3)), pow(interval(2, 9), -1//3))
    @test isequal_interval(pow(interval(-1, 8), -1//3), interval(0.5, Inf))
    @test issubset_interval(interval(0.5, Inf), pow(interval(-2, 8), -1//3))
    @test issubset_interval(interval(9^(-1//3), Inf), pow(interval(-1, 9), -1//3))
    @test issubset_interval(interval(9^(-1//3), Inf), pow(interval(-2, 9), -1//3))
    @test isequal_interval(pow(interval(-2, 4), 1//2), interval(0, 2))
    @test isequal_interval(pow(interval(-2, 8), 1//3), interval(0, 2))
    @test isequal_interval(pow(interval(-8, -2), 1//3), emptyinterval())
    @test isequal_interval(pow(interval(-8, -2), 1//2), emptyinterval())
    @test isequal_interval(pow(interval(-8, -2), -1//3), emptyinterval())
    @test isequal_interval(pow(interval(-8, -2), -1//2), emptyinterval())
    @test isequal_interval(pow(emptyinterval(), 2//3), emptyinterval())
    @test isequal_interval(pow(interval(1, 8), 2//3), interval(1, 4))
    @test issubset_interval(interval(2^(2//3), 4), pow(interval(2, 8), 2//3))
    @test issubset_interval(interval(1, 9^(2//3)), pow(interval(1, 9), 2//3))
    @test issubset_interval(interval(2^(2//3), 9^(2//3)), pow(interval(2, 9), 2//3))
    @test isequal_interval(pow(interval(-1, 8), 2//3), interval(0, 4))
    @test issubset_interval(interval(0, 4), pow(interval(-2, 8), 2//3))
    @test issubset_interval(interval(0, 9^(2//3)), pow(interval(-1, 9), 2//3))
    @test issubset_interval(interval(0, 9^(2//3)), pow(interval(-2, 9), 2//3))
    @test isequal_interval(pow(interval(1, 8), -2//3), interval(0.25, 1))
    @test issubset_interval(interval(0.25, 2^(-2//3)), pow(interval(2, 8), -2//3))
    @test issubset_interval(interval(9^(-2//3), 1), pow(interval(1, 9), -2//3))
    @test issubset_interval(interval(9^(-2//3), 2^(-2//3)), pow(interval(2, 9), -2//3))
    @test isequal_interval(pow(interval(-1, 8), -2//3), interval(0.25, Inf))
    @test issubset_interval(interval(0.25, Inf), pow(interval(-2, 8), -2//3))
    @test issubset_interval(interval(9^(-2//3), Inf), pow(interval(-1, 9), -2//3))
    @test issubset_interval(interval(9^(-2//3), Inf), pow(interval(-2, 9), -2//3))
    @test isequal_interval(pow(interval(-2, 4), 3//2), interval(0, 8))
    @test isequal_interval(pow(interval(-2, 8), 2//3), interval(0, 4))
    @test isequal_interval(pow(interval(-8, -2), 2//3), emptyinterval())
    @test isequal_interval(pow(interval(-8, -2), 3//2), emptyinterval())
    @test isequal_interval(pow(interval(-8, -2), -2//3), emptyinterval())
    @test isequal_interval(pow(interval(-8, -2), -3//2), emptyinterval())
    @test isequal_interval(pow(interval(-1, 1), 1000000000000000000000000000000000000000//1), interval(0, 1))
end

@testset "_thin_pow" begin
    @test isthinzero(IntervalArithmetic._thin_pow(bareinterval(0.0), 1.0))
    @test isempty_interval(IntervalArithmetic._thin_pow(bareinterval(0.0), -1.0))
    x = bareinterval(2.0, 3.0)
    @test IntervalArithmetic._thin_pow(x, 0.5) === sqrt(x)
    @test isequal_interval(IntervalArithmetic._thin_pow(x, 3.0), pown(x, 3))
    @test isequal_interval(IntervalArithmetic._thin_pow(bareinterval(4.0), 3//2), bareinterval(8.0))
    @test isequal_interval(IntervalArithmetic._thin_pow(x, 4//2), pown(x, 2))
end

@testset "pown" begin
    x = bareinterval(2.0, 3.0)
    @test isequal_interval(pown(x, 0), one(BareInterval{Float64}))
    @test isequal_interval(pown(entireinterval(BareInterval{Float64}), 0), one(BareInterval{Float64}))
    @test pown(x, 1) === x
    @test isempty_interval(pown(emptyinterval(BareInterval{Float64}), 3))
    @test isempty_interval(pown(bareinterval(0.0), -3))
    @test isempty_interval(pown(bareinterval(0.0), -2))

    @test isequal_interval(pown(bareinterval(2, 3), 3), bareinterval(8.0, 27.0))
    @test isequal_interval(pown(bareinterval(0.0, 3.0), 3), bareinterval(0.0, 27.0))
    @test isequal_interval(pown(bareinterval(-3.0, 0.0), 3), bareinterval(-27.0, 0.0))
    @test isentire_interval(pown(entireinterval(BareInterval{Float64}), 3))

    @test isequal_interval(pown(bareinterval(0.0, 3.0), -3), bareinterval(0.037037037037037035, Inf))
    @test isequal_interval(pown(bareinterval(-3.0, 0.0), -3), bareinterval(-Inf, -0.037037037037037035))
    @test isentire_interval(pown(bareinterval(-1.0, 1.0), -3))

    @test isequal_interval(pown(bareinterval(-2.0, 3.0), 2), bareinterval(0.0, 9.0))
    @test isequal_interval(pown(bareinterval(2, 3), 2), bareinterval(4.0, 9.0))
    @test isequal_interval(pown(bareinterval(-3.0, -2.0), 2), bareinterval(4.0, 9.0))
    @test isequal_interval(pown(entireinterval(BareInterval{Float64}), 2), bareinterval(0.0, Inf))

    @test isequal_interval(pown(bareinterval(-2.0, 3.0), -2), bareinterval(0.1111111111111111, Inf))
    @test isequal_interval(pown(bareinterval(2.0, 3.0), -2), bareinterval(0.1111111111111111, 0.25))
    @test isequal_interval(pown(entireinterval(BareInterval{Float64}), -2), bareinterval(0.0, Inf))

    @test isequal_interval(pown(bareinterval(1//2), 2), bareinterval(1//4))
    @test isequal_interval(pown(bareinterval(1//2), -2), bareinterval(4//1))
    @test numtype(pown(bareinterval(1//2), 2)) === Rational{Int}

    @test decoration(pown(interval(-1, 1), 3)) == com
    r = pown(interval(-1, 1), -3)
    @test isentire_interval(r)
    @test decoration(r) == trv
    r = pown(interval(0.0), -1)
    @test isempty_interval(r)
    @test decoration(r) == trv
    @test isguaranteed(pown(interval(2.0), 3))
    @test !isguaranteed(pown(convert(Interval{Float64}, 2), 3))
    r = @test_logs (:warn,) pown(nai(Float64), 2)
    @test isnai(r)

    @test isequal_interval(pown(interval(2, 3), 2), interval(4, 9))
    @test isequal_interval(pown(interval(0, 3), 2), interval(0, 9))
    @test isequal_interval(pown(interval(-3, 0), 2), interval(0, 9))
    @test isequal_interval(pown(interval(-3, -2), 2), interval(4, 9))
    @test isequal_interval(pown(interval(-3, 2), 2), interval(0, 9))
    @test isequal_interval(pown(interval(0, 3), 3), interval(0, 27))
    @test isequal_interval(pown(interval(2, 3), 3), interval(8, 27))
    @test isequal_interval(pown(interval(-3, 0), 3), interval(-27.0, 0.0))
    @test isequal_interval(pown(interval(-3, -2), 3), interval(-27, -8))
    @test isequal_interval(pown(interval(-3, 2), 3), interval(-27.0, 8.0))
    @test isequal_interval(pown(interval(0, 3), -2), interval(1/9, Inf))
    @test isequal_interval(pown(interval(-3, 0), -2), interval(1/9, Inf))
    @test isequal_interval(pown(interval(-3, 2), -2), interval(1/9, Inf))
    @test isequal_interval(pown(interval(2, 3), -2), interval(1/9, 1/4))
    @test isequal_interval(pown(interval(1, 2), -3), interval(1/8, 1.0))
    @test isequal_interval(pown(interval(0, 3), -3), interval(1/27, Inf))
    @test isequal_interval(pown(interval(-1, 2), -3), entireinterval())
    @test isequal_interval(pown(interval(-3, -2), -3), interval(-1/8, -1/27))
    @test isequal_interval(pown(interval(0.0), 0), interval(1))
    @test isequal_interval(pown(emptyinterval(), 0), emptyinterval())
    @test isequal_interval(pown(interval(2.5), 3), interval(15.625, 15.625))
    @test isequal_interval(pown(interval(5//2), 3), interval(125//8))
    @test decoration(pown(interval(0, 3), -2)) == trv
end

@testset "rootn" begin
    x = bareinterval(2.0, 3.0)
    @test isempty_interval(rootn(x, 0))
    @test rootn(x, 1) === x
    @test rootn(bareinterval(4.0), 2) === sqrt(bareinterval(4.0))
    @test isequal_interval(rootn(bareinterval(8.0), -3), bareinterval(0.5))
    @test isequal_interval(rootn(bareinterval(8.0), -3), inv(rootn(bareinterval(8.0), 3)))

    @test isequal_interval(rootn(bareinterval(8.0), 3), bareinterval(2.0))
    @test isequal_interval(rootn(bareinterval(-8.0), 3), bareinterval(-2.0))
    @test isequal_interval(rootn(bareinterval(-8.0, 8.0), 2), bareinterval(0.0, 2.8284271247461903))
    @test isempty_interval(rootn(bareinterval(-8.0, -1.0), 2))
    @test isempty_interval(rootn(emptyinterval(BareInterval{Float64}), 3))

    @test rootn(bareinterval(1//2), 3) isa BareInterval{Float64}
    @test bounds(rootn(bareinterval(1//2), 3)) == (0.7937005259840997, 0.7937005259840998)
    @test in_interval(0.5^(1/3), rootn(interval(1//2), 3))
    @test decoration(rootn(interval(1//2), 3)) == com

    @test decoration(rootn(interval(-8.0, 8.0), 2)) == trv
    @test decoration(rootn(interval(1.0, 8.0), 3)) == com
    @test isguaranteed(rootn(interval(8.0), 3))
    @test !isguaranteed(rootn(convert(Interval{Float64}, 8), 3))

    @test isequal_interval(rootn(emptyinterval(), 3), emptyinterval())
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

@testset "hypot" begin
    @test isequal_interval(hypot(bareinterval(3.0), bareinterval(4.0)), bareinterval(5.0))
    r = hypot(interval(3.0), interval(4.0))
    @test isequal_interval(r, interval(5.0))
    @test decoration(r) == com
    x = bareinterval(3.0)
    y = bareinterval(4.0)
    @test isequal_interval(hypot(x, y), sqrt(IntervalArithmetic._select_pown(x, 2) + IntervalArithmetic._select_pown(y, 2)))
    @test isempty_interval(hypot(bareinterval(1.0), emptyinterval(BareInterval{Float64})))
    @test isthinzero(hypot(interval(0.0), interval(0.0)))
    r = hypot(interval(0.0, Inf), interval(1.0))
    @test !isbounded(r)
    @test decoration(r) == dac
end

@testset "fastpow" begin
    @test isequal_interval(fastpow(bareinterval(2.0, 3.0), bareinterval(2.0)), bareinterval(4.0, 9.0))
    @test isequal_interval(fastpow(interval(1.0, 2.0), interval(2.0, 3.0)), interval(1.0, 8.000000000000004))
    @test issubset_interval(pow(interval(1.0, 2.0), interval(2.0, 3.0)), fastpow(interval(1.0, 2.0), interval(2.0, 3.0)))
    @test isequal_interval(fastpow(bareinterval(-1.0, 1.0), bareinterval(0.5)), bareinterval(0.0, 1.0))
    y = emptyinterval(BareInterval{Float64})
    @test fastpow(bareinterval(2.0), y) === y
    @test isempty_interval(fastpow(bareinterval(-2.0, -1.0), bareinterval(2.0)))
    @test isthinzero(fastpow(bareinterval(0.0), bareinterval(1.0)))
    @test isempty_interval(fastpow(bareinterval(0.0), bareinterval(-1.0)))
    @test isempty_interval(fastpow(bareinterval(0.0), bareinterval(0.0)))

    @test isthin(fastpow(bareinterval(2.0), bareinterval(-2.0)), 0.25)
    @test isequal_interval(fastpow(bareinterval(2.0), bareinterval(0.5)), exp(bareinterval(0.5) * log(bareinterval(2.0))))
    @test isequal_interval(fastpow(bareinterval(2.0), 3.0), bareinterval(8.0))
    @test isequal_interval(fastpow(interval(2.0), 3.0), interval(8.0))

    @test decoration(fastpow(interval(1.0, 2.0), interval(0.0, 1.0))) == com
    @test decoration(fastpow(interval(0.0, 1.0), interval(1.0, 2.0))) == com
    @test decoration(fastpow(interval(0.0, 1.0), interval(0.0, 1.0))) == trv
    @test decoration(fastpow(interval(-1.0, 1.0), interval(1.0, 2.0))) == trv
    @test !isguaranteed(fastpow(interval(2.0), convert(Interval{Float64}, 2)))

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

    xpi = interval(π)
    @test isinterior(pow(xpi, 100), fastpow(xpi, 100))
    @test isinterior(pow(xpi, 50), fastpow(xpi, 50))
    @test isequal_interval(fastpow(interval(2), 2000), interval(floatmax(), Inf))

    @test isequal_interval(fastpow(x, 0.5), interval(1.0, 1.4142135623730951))
    @test isequal_interval(fastpow(x, 0.5), pow(x, interval(0.5)))
    @test isequal_interval(fastpow(interval(2, 3), -0.5), interval(0.5773502691896257, 0.7071067811865476))
    yw = interval(-2, 3)
    @test isequal_interval(fastpow(yw, 2.1), interval(0.0, 10.045108566305146))
    @test issubset_interval(pow(yw, interval(2.1)), fastpow(yw, 2.1))
    @test isequal_interval(fastpow(yw, interval(-2, 3)), interval(0, Inf))
    @test isequal_interval(fastpow(yw, interval(2.1)), interval(0.0, 10.045108566305146))
end

@testset "fastpown" begin
    @test isequal_interval(fastpown(bareinterval(-2.0, 3.0), 3), bareinterval(-18.0, 27.0))
    @test isequal_interval(pown(bareinterval(-2.0, 3.0), 3), bareinterval(-8.0, 27.0))
    @test issubset_interval(pown(bareinterval(-2.0, 3.0), 3), fastpown(bareinterval(-2.0, 3.0), 3))

    @test isempty_interval(fastpown(bareinterval(0.0), -1))
    @test isequal_interval(fastpown(bareinterval(2.0), -2), bareinterval(0.25))
    @test isequal_interval(fastpown(bareinterval(2.0), -2), inv(fastpown(bareinterval(2.0), 2)))
    @test isequal_interval(fastpown(bareinterval(-1.0, 1.0), 4), bareinterval(0.0, 1.0))
    @test inf(fastpown(bareinterval(-2.0, 1.0), 2)) ≥ 0
    @test isempty_interval(fastpown(emptyinterval(BareInterval{Float64}), 3))
    x = bareinterval(2.0, 3.0)
    @test isequal_interval(fastpown(x, 0), one(x))
    @test fastpown(x, 1) === x

    @test decoration(fastpown(interval(1.0, 2.0), 2)) == com
    @test decoration(fastpown(interval(-1.0, 1.0), -2)) == trv
    @test isguaranteed(fastpown(interval(2.0), 3))

    @test isequal_interval(fastpown(complex(interval(1.0, 2.0), interval(0.0)), 3), complex(interval(1.0, 8.0), interval(0.0)))
    @test isequal_interval(fastpown(complex(interval(0.0), interval(1.0, 2.0)), 0), complex(interval(1.0), interval(0.0)))
    @test isequal_interval(fastpown(complex(interval(0.0), interval(1.0, 2.0)), 1), complex(interval(0.0), interval(1.0, 2.0)))
    @test isequal_interval(fastpown(complex(interval(0.0), interval(1.0, 2.0)), 2), complex(interval(-4.0, -1.0), interval(0.0)))
    @test isequal_interval(fastpown(complex(interval(0.0), interval(1.0, 2.0)), 3), complex(interval(0.0), interval(-8.0, -1.0)))
    @test isequal_interval(fastpown(complex(interval(1.0), interval(1.0)), 2), complex(interval(0.0), interval(2.0)))
end

@testset "_positive_power_by_squaring" begin
    x = bareinterval(2.0)
    @test isequal_interval(IntervalArithmetic._positive_power_by_squaring(x, 10), bareinterval(1024.0))
    @test IntervalArithmetic._positive_power_by_squaring(x, 0) === one(x)
    @test IntervalArithmetic._positive_power_by_squaring(x, 1) === x
    @test isequal_interval(IntervalArithmetic._positive_power_by_squaring(x, 2), x * x)
    for n ∈ 0:10
        @test isthin(IntervalArithmetic._positive_power_by_squaring(x, n), 2.0^n)
    end
end

@testset "cbrt, exp, exp2, exp10 and expm1" begin
    @test isequal_interval(exp(bareinterval(0.0, 1.0)), bareinterval(1.0, 2.7182818284590455))
    @test isequal_interval(cbrt(bareinterval(-8.0, 8.0)), bareinterval(-2.0, 2.0))
    @test isequal_interval(exp2(bareinterval(1.0)), bareinterval(2.0))
    @test isequal_interval(exp10(bareinterval(1.0)), bareinterval(10.0))
    @test isthinzero(expm1(bareinterval(0.0)))
    @test isequal_interval(exp(entireinterval(BareInterval{Float64})), bareinterval(0.0, Inf))
    @test decoration(exp(interval(-Inf, Inf))) == dac

    for f ∈ (cbrt, exp, exp2, exp10, expm1)
        @test isempty_interval(f(emptyinterval(BareInterval{Float64})))
        @test numtype(f(bareinterval(1//2))) === Float64
        @test decoration(f(interval(0.0, 1.0))) == com
        @test decoration(f(interval(0.0, 1.0, def))) == def
        @test isguaranteed(f(interval(1.0)))
        @test !isguaranteed(f(convert(Interval{Float64}, 1)))
    end

    @test issubset_interval(exp(interval(BigFloat, 1//2)), exp(interval(1//2)))
    @test in_interval(exp(big(1//2)), exp(interval(1//2)))
    @test issubset_interval(exp(interval(BigFloat, 0.1)), exp(interval(0.1)))
    @test isequal_interval(exp(interval(0.1)), interval(1.1051709180756475e+00, 1.1051709180756477e+00))
    @test diam(exp(interval(0.1))) == eps(exp(0.1))
    @test issubset_interval(exp2(interval(BigFloat, 1//2)), exp2(interval(1//2)))
    @test isequal_interval(exp2(interval(1024.0)), interval(1.7976931348623157e308, Inf))
    @test issubset_interval(exp10(interval(BigFloat, 1//2)), exp10(interval(1//2)))
    @test isequal_interval(exp10(interval(308.5)), interval(1.7976931348623157e308, Inf))

    @test isequal_interval(cbrt(interval(2, 3)), interval(1.259921049894873, 1.4422495703074085))
    @test isequal_interval(cbrt(big(interval(2, 3))), interval(big"1.259921049894873164767210607278228350570251464701507980081975112155299676513956", big"1.442249570307408382321638310780109588391869253499350577546416194541687596830003"))
    @test issubset_interval(cbrt(big(interval(2, 3))), cbrt(interval(2, 3)))
    @test issubset_interval(Interval{Float64}(cbrt(big(interval(3, 4)))), cbrt(interval(3, 4)))
    @test isequal_interval(cbrt(interval(2f0, 3f0)), interval(1.259921f0, 1.4422497f0))
    @test issubset_interval(cbrt(interval(2, 3)), cbrt(interval(2f0, 3f0)))

    z = complex(interval(0.0), interval(0.0))
    @test isequal_interval(exp(z), complex(interval(1.0), interval(0.0)))
    w = complex(interval(0.3), interval(0.4))
    @test isequal_interval(exp(w), exp(real(w)) * cis(imag(w)))
    @test isequal_interval(exp2(w), exp2(real(w)) * cis(imag(w) * log(interval(Float64, 2))))
    @test isequal_interval(exp10(w), exp10(real(w)) * cis(imag(w) * log(interval(Float64, 10))))
    @test isequal_interval(expm1(w), exp(w) - interval(Float64, 1))
end

@testset "log, log2, log10 and log1p" begin
    @test isempty_interval(log(bareinterval(0.0)))
    @test isempty_interval(log(bareinterval(-2.0, -1.0)))
    @test isequal_interval(log(bareinterval(-1.0, 1.0)), bareinterval(-Inf, 0.0))
    @test isequal_interval(log(bareinterval(0.0, 1.0)), bareinterval(-Inf, 0.0))
    @test isequal_interval(log2(bareinterval(8.0)), bareinterval(3.0))
    @test isequal_interval(log10(bareinterval(100.0)), bareinterval(2.0))

    for f ∈ (log, log2, log10)
        @test decoration(f(interval(1.0, 2.0))) == com
        @test decoration(f(interval(0.0, 1.0))) == trv
        @test decoration(f(interval(-1.0, 1.0))) == trv
        @test decoration(f(interval(1.0, Inf))) == dac
        @test isempty_interval(f(emptyinterval(BareInterval{Float64})))
        @test numtype(f(bareinterval(1//2))) === Float64
        @test isguaranteed(f(interval(1.0)))
    end

    @test isempty_interval(log1p(bareinterval(-1.0)))
    @test isempty_interval(log1p(bareinterval(-2.0, -1.0)))
    @test isequal_interval(log1p(bareinterval(-1.0, 1.0)), bareinterval(-Inf, 0.6931471805599454))
    @test decoration(log1p(interval(0.0, 1.0))) == com
    @test decoration(log1p(interval(-1.0, 1.0))) == trv
    @test numtype(log1p(bareinterval(1//2))) === Float64

    @test issubset_interval(log(interval(BigFloat, 1//2)), log(interval(1//2)))
    @test in_interval(log(big(1//2)), log(interval(1//2)))
    @test issubset_interval(log(interval(BigFloat, 0.1)), log(interval(0.1)))
    @test isequal_interval(log(interval(0.1)), interval(-2.3025850929940459e+00, -2.3025850929940455e+00))
    @test diam(log(interval(0.1))) == eps(log(0.1))
    @test issubset_interval(log2(interval(BigFloat, 1//2)), log2(interval(1//2)))
    @test isequal_interval(log2(interval(0.25, 0.5)), interval(-2.0, -1.0))
    @test in_interval(log10(big(1//10)), log10(interval(1//10)))
    @test isequal_interval(log1p(interval(-10.0)), emptyinterval())

    @test issubset_interval(log(interval(-2, 5)), interval(-Inf, sup(log(interval(5)))))

    z = complex(interval(1.0), interval(0.0))
    @test isequal_interval(log(z), complex(interval(0.0), interval(0.0)))
    w = complex(interval(2.0), interval(1.0))
    @test isequal_interval(log(w), complex(log(abs(w)), angle(w)))
    @test isequal_interval(log2(w), complex(log2(abs(w)), angle(w) / log(interval(Float64, 2))))
    @test isequal_interval(log10(w), complex(log10(abs(w)), angle(w) / log(interval(Float64, 10))))
    @test isequal_interval(log1p(w), log(interval(Float64, 1) + w))
end

@testset "numtype stability and point enclosure" begin
    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test isequal_interval(pown(bareinterval(T, 2), 3), bareinterval(T, 8))
        @test numtype(pown(bareinterval(T, 2), 3)) === T
        for f ∈ (cbrt, exp, exp2, exp10, expm1, log, log2, log10, log1p)
            r = f(bareinterval(T, 1, 2))
            @test numtype(r) === T
            @test in_interval(f(big(3) / 2), r)
        end
    end

    x = bareinterval(0.3, 2.6)
    for t ∈ range(inf(x), sup(x); length = 7)
        for n ∈ (2, 3, -2)
            @test in_interval(t^n, pown(x, n))
            @test in_interval(t^n, fastpown(x, n))
        end
        @test in_interval(exp(t), exp(x))
        @test in_interval(log(t), log(x))
        @test in_interval(cbrt(t), cbrt(x))
    end
end
