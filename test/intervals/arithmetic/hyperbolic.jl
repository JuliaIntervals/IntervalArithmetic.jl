using Test
using IntervalArithmetic

@testset "sinh" begin
    @test isequal_interval(sinh(bareinterval(0.0, 1.0)), bareinterval(0.0, 1.1752011936438016))
    @test isempty_interval(sinh(emptyinterval(BareInterval{Float64})))
    @test isentire_interval(sinh(entireinterval(BareInterval{Float64})))
    r = sinh(bareinterval(1.0))
    @test inf(r) < sup(r)
    @test in_interval(sinh(big(1)), r)
    @test numtype(sinh(bareinterval(1//1))) === Float64

    @test decoration(sinh(interval(-Inf, Inf))) == dac
    @test decoration(sinh(interval(1.0, 2.0, def))) == def
    @test isguaranteed(sinh(interval(1.0)))
    @test !isguaranteed(sinh(convert(Interval{Float64}, 1)))
    r = @test_logs (:warn,) sinh(nai(Float64))
    @test isnai(r)

    @test isequal_interval(sinh(emptyinterval()), emptyinterval())
    @test isequal_interval(sinh(interval(0.5)), interval(0.5210953054937473, 0.5210953054937474))
    @test isequal_interval(sinh(interval(0.5, 1.67)), interval(0.5210953054937473, 2.5619603657712102))
    @test isequal_interval(sinh(interval(-4.5, 0.1)), interval(-45.00301115199179, 0.10016675001984404))

    for lo_hi ∈ ((0.5, 0.5), (0.5, 1.67), (1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(sinh(interval(BigFloat, lo_hi...)), sinh(interval(lo_hi...)))
    end

    @test isthinzero(sinh(complex(interval(0.0), interval(0.0))))
    z = complex(interval(0.3), interval(0.4))
    @test isequal_interval(sinh(z), (exp(z) - exp(-z)) / interval(Float64, 2))
end

@testset "cosh" begin
    @test isequal_interval(cosh(bareinterval(-1.0, 2.0)), bareinterval(1.0, 3.762195691083632))
    @test isequal_interval(cosh(bareinterval(1.0, 2.0)), bareinterval(1.5430806348152437, 3.762195691083632))
    @test isempty_interval(cosh(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(cosh(entireinterval(BareInterval{Float64})), bareinterval(1.0, Inf))
    @test numtype(cosh(bareinterval(1//1))) === Float64

    @test decoration(cosh(interval(-1.0, 2.0))) == com
    @test decoration(cosh(interval(1.0, 2.0, def))) == def
    @test isguaranteed(cosh(interval(1.0)))
    @test !isguaranteed(cosh(convert(Interval{Float64}, 1)))

    @test isequal_interval(cosh(emptyinterval()), emptyinterval())
    @test isequal_interval(cosh(interval(0.5)), interval(1.1276259652063807, 1.127625965206381))
    @test isequal_interval(cosh(interval(0.5, 1.67)), interval(1.1276259652063807, 2.750207431409957))
    @test isequal_interval(cosh(interval(-4.5, 0.1)), interval(1.0, 45.01412014853003))

    for lo_hi ∈ ((0.5, 0.5), (0.5, 1.67), (1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(cosh(interval(BigFloat, lo_hi...)), cosh(interval(lo_hi...)))
    end

    z = complex(interval(0.3), interval(0.4))
    @test isequal_interval(cosh(z), (exp(z) + exp(-z)) / interval(Float64, 2))
end

@testset "tanh" begin
    @test isequal_interval(tanh(bareinterval(0.0, 1.0)), bareinterval(0.0, 0.761594155955765))
    @test isempty_interval(tanh(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(tanh(entireinterval(BareInterval{Float64})), bareinterval(-1.0, 1.0))
    @test numtype(tanh(bareinterval(1//1))) === Float64

    @test decoration(tanh(interval(1.0, 2.0, def))) == def
    @test decoration(tanh(interval(-Inf, Inf))) == dac
    @test isguaranteed(tanh(interval(1.0)))

    @test isequal_interval(tanh(emptyinterval()), emptyinterval())
    @test isequal_interval(tanh(interval(0.5)), interval(0.46211715726000974, 0.4621171572600098))
    @test isequal_interval(tanh(interval(0.5, 1.67)), interval(0.46211715726000974, 0.9315516846152083))
    @test isequal_interval(tanh(interval(-4.5, 0.1)), interval(-0.9997532108480276, 0.09966799462495583))

    for lo_hi ∈ ((0.5, 0.5), (0.5, 1.67), (1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(tanh(interval(BigFloat, lo_hi...)), tanh(interval(lo_hi...)))
    end
    for lo_hi ∈ ((0.5, 0.5), (0.5, 1.67), (1.67, 3.2), (2.1, 5.6), (0.5, 8.5), (-4.5, 0.1), (1.3, 6.3))
        @test issubset_interval(tanh(interval(lo_hi...)), tanh(interval(Float32, lo_hi...)))
    end

    for a ∈ (interval(17, 19), interval(0.5, 1.2))
        @test issubset_interval(tanh(a), sinh(a) / cosh(a))
    end

    z = complex(interval(0.3), interval(0.4))
    @test isequal_interval(tanh(z), sinh(z) / cosh(z))
end

@testset "coth" begin
    @test isempty_interval(coth(bareinterval(0.0)))
    @test isentire_interval(coth(bareinterval(-1.0, 1.0)))
    @test isequal_interval(coth(bareinterval(0.0, 1.0)), bareinterval(1.3130352854993312, Inf))
    @test isequal_interval(coth(bareinterval(-1.0, 0.0)), bareinterval(-Inf, -1.3130352854993312))
    @test isequal_interval(coth(bareinterval(1.0, 2.0)), bareinterval(1.037314720727548, 1.3130352854993315))
    @test isempty_interval(coth(emptyinterval(BareInterval{Float64})))
    @test numtype(coth(bareinterval(1//1))) === Float64

    @test decoration(coth(interval(-1.0, 1.0))) == trv
    @test decoration(coth(interval(0.0, 1.0))) == trv
    @test decoration(coth(interval(1.0, 2.0))) == com
    @test isguaranteed(coth(interval(1.0)))
end

@testset "sech" begin
    @test isequal_interval(sech(bareinterval(0.0, 1.0)), bareinterval(0.6480542736638853, 1.0))
    @test isequal_interval(sech(bareinterval(-1.0, 0.0)), bareinterval(0.6480542736638853, 1.0))
    @test isequal_interval(sech(bareinterval(-1.0, 2.0)), bareinterval(0.26580222883407967, 1.0))
    @test isempty_interval(sech(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(sech(entireinterval(BareInterval{Float64})), bareinterval(0.0, 1.0))
    @test numtype(sech(bareinterval(1//1))) === Float64

    @test decoration(sech(interval(-1.0, 1.0))) == com
    @test isguaranteed(sech(interval(1.0)))
end

@testset "csch" begin
    @test isempty_interval(csch(bareinterval(0.0)))
    @test isentire_interval(csch(bareinterval(-1.0, 1.0)))
    @test isequal_interval(csch(bareinterval(0.0, 1.0)), bareinterval(0.8509181282393214, Inf))
    @test isequal_interval(csch(bareinterval(-1.0, 0.0)), bareinterval(-Inf, -0.8509181282393214))
    @test isequal_interval(csch(bareinterval(1.0, 2.0)), bareinterval(0.2757205647717832, 0.8509181282393216))
    @test isempty_interval(csch(emptyinterval(BareInterval{Float64})))
    @test numtype(csch(bareinterval(1//1))) === Float64

    @test decoration(csch(interval(-1.0, 1.0))) == trv
    @test decoration(csch(interval(0.0, 1.0))) == trv
    @test decoration(csch(interval(1.0, 2.0))) == com
end

@testset "asinh" begin
    @test isequal_interval(asinh(bareinterval(0.0, 1.0)), bareinterval(0.0, 0.881373587019543))
    @test isempty_interval(asinh(emptyinterval(BareInterval{Float64})))
    @test isentire_interval(asinh(entireinterval(BareInterval{Float64})))
    @test numtype(asinh(bareinterval(1//1))) === Float64

    @test decoration(asinh(interval(1.0, 2.0, def))) == def
    @test isguaranteed(asinh(interval(1.0)))
    r = @test_logs (:warn,) asinh(nai(Float64))
    @test isnai(r)

    @test issubset_interval(asinh(interval(BigFloat, 1, 1)), asinh(interval(1)))
    @test issubset_interval(asinh(interval(BigFloat, 0.9, 2)), asinh(interval(0.9, 2)))
    @test issubset_interval(asinh(interval(BigFloat, 3, 4)), asinh(interval(3, 4)))
end

@testset "acosh" begin
    @test isequal_interval(acosh(bareinterval(0.0, 2.0)), bareinterval(0.0, 1.3169578969248168))
    @test isempty_interval(acosh(bareinterval(-2.0, 0.0)))
    @test isthinzero(acosh(bareinterval(1.0)))
    @test isempty_interval(acosh(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(acosh(bareinterval(1.0, Inf)), bareinterval(0.0, Inf))
    @test numtype(acosh(bareinterval(2//1))) === Float64

    @test decoration(acosh(interval(1.0, 2.0))) == com
    @test decoration(acosh(interval(0.0, 2.0))) == trv
    @test decoration(acosh(interval(1.0, Inf))) == dac
    @test isguaranteed(acosh(interval(1.0, 2.0)))

    @test issubset_interval(acosh(interval(BigFloat, 1, 1)), acosh(interval(1)))
    @test issubset_interval(acosh(interval(BigFloat, -2, -0.9)), acosh(interval(-2, -0.9)))
    @test issubset_interval(acosh(interval(BigFloat, 3, 4)), acosh(interval(3, 4)))
end

@testset "atanh" begin
    @test isentire_interval(atanh(bareinterval(-2.0, 2.0)))
    @test isentire_interval(atanh(bareinterval(-1.0, 1.0)))
    @test isequal_interval(atanh(bareinterval(0.0, 0.5)), bareinterval(0.0, 0.5493061443340549))
    @test isempty_interval(atanh(emptyinterval(BareInterval{Float64})))
    @test isempty_interval(atanh(bareinterval(-2.0, -1.5)))
    @test numtype(atanh(bareinterval(1//2))) === Float64

    @test decoration(atanh(interval(-0.5, 0.5))) == com
    @test decoration(atanh(interval(-1.0, 1.0))) == trv
    @test decoration(atanh(interval(0.0, 1.0))) == trv
    @test isguaranteed(atanh(interval(0.5)))
end

@testset "acoth" begin
    @test isempty_interval(acoth(bareinterval(-1.0, 1.0)))
    @test isentire_interval(acoth(bareinterval(-2.0, 2.0)))
    @test isempty_interval(acoth(bareinterval(0.5, 2.0)))
    @test isempty_interval(acoth(bareinterval(-2.0, 0.5)))
    @test isequal_interval(acoth(bareinterval(1.0, 2.0)), bareinterval(0.5493061443340548, Inf))
    @test isequal_interval(acoth(bareinterval(-2.0, -1.0)), bareinterval(-Inf, -0.5493061443340548))
    @test isequal_interval(acoth(bareinterval(2.0, 3.0)), bareinterval(0.34657359027997264, 0.5493061443340549))
    x = 1.0122020710883537
    r = acoth(bareinterval(x))
    @test inf(r) ≤ acoth(big(x)) ≤ sup(r)
    @test isequal_interval(acoth(bareinterval(-3.0, -2.0)), bareinterval(-0.5493061443340549, -0.34657359027997264))
    @test isempty_interval(acoth(emptyinterval(BareInterval{Float64})))
    @test isentire_interval(acoth(entireinterval(BareInterval{Float64})))
    @test numtype(acoth(bareinterval(2//1))) === Float64

    @test decoration(acoth(interval(2.0, 3.0))) == com
    r = acoth(interval(-1.0, 1.0))
    @test isempty_interval(r)
    @test decoration(r) == trv
    r = acoth(interval(0.5, 2.0))
    @test isempty_interval(r)
    @test decoration(r) == trv
end

@testset "numtype stability" begin
    for T ∈ (Float16, Float32, BigFloat)
        for f ∈ (sinh, cosh, tanh, sech, asinh)
            r = f(bareinterval(T, 1//2, 1))
            @test numtype(r) === T
            @test in_interval(f(big(1) / 2), r) || in_interval(f(big(1)), r)
        end
        @test numtype(coth(bareinterval(T, 1, 2))) === T
        @test numtype(csch(bareinterval(T, 1, 2))) === T
        @test numtype(acosh(bareinterval(T, 1, 2))) === T
        @test numtype(atanh(bareinterval(T, 0, 1//2))) === T
        @test numtype(acoth(bareinterval(T, 2, 3))) === T
    end
end

@testset "point enclosure and inverse pairs" begin
    x = bareinterval(0.1, 2.7)
    for t ∈ range(inf(x), sup(x); length = 7)
        @test in_interval(sinh(t), sinh(x))
        @test in_interval(cosh(t), cosh(x))
        @test in_interval(tanh(t), tanh(x))
        @test in_interval(coth(t), coth(x))
        @test in_interval(sech(t), sech(x))
        @test in_interval(csch(t), csch(x))
        @test in_interval(asinh(t), asinh(x))
    end
    y = bareinterval(-0.9, 0.9)
    for t ∈ range(inf(y), sup(y); length = 7)
        @test in_interval(atanh(t), atanh(y))
    end

    for x ∈ (bareinterval(-0.75, 0.5), bareinterval(0.1, 0.9))
        @test issubset_interval(x, sinh(asinh(x)))
        @test issubset_interval(x, tanh(atanh(x)))
    end
    for x ∈ (bareinterval(1.0, 2.0), bareinterval(1.5, 10.0))
        @test issubset_interval(x, cosh(acosh(x)))
    end
end
