# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

@testset "brodcasting tests" begin
    a = 3
    b = 12
    x = a..b

    for i in 1:20
        @test x.-i ≛ Interval(a-i, b-i)
    end


    for i in 1:20
        @test x.*i ≛ Interval(a*i, b*i)
    end

    a = 4
    b = 5
    y = a..b
    for i in 1:20
        @test y.+i ≛ Interval(a+i, b+i)
    end

    for i in 1:20
        @test y./i ≛ Interval(/(a, i, RoundDown), /(b, i, RoundUp))
    end
end

@testset "Numeric tests" begin
    a = Interval(0.1, 1.1)
    b = Interval(0.9, 2.0)
    c = Interval(0.25, 4.0)


    ## Basic arithmetic
    @test +a ≛ a
    @test a + b ≛ Interval(+(a.lo, b.lo, RoundDown), +(a.hi, b.hi, RoundUp))
    @test -a ≛ Interval(-a.hi, -a.lo)
    @test a - b ≛ Interval(-(a.lo, b.hi, RoundDown), -(a.hi, b.lo, RoundUp))
    @test Interval(1//4,1//2) + Interval(2//3) ≛ Interval(11//12, 7//6)
    @test_broken Interval(1//4,1//2) - Interval(2//3) ≛ Interval(-5//12, -1//6)

    @test Interval(-30.0,-15.0) / Interval(-5.0,-3.0) ≛ Interval(3.0, 10.0)
    @test Interval(-30,-15) / Interval(-5,-3) ≛ Interval(3.0, 10.0)
    @test b/a ≛ Interval(/(b.lo, a.hi, RoundDown), /(b.hi, a.lo, RoundUp))
    @test a/c ≛ Interval(0.025, 4.4)
    @test c/4.0 ≛ Interval(6.25e-02, 1e+00)
    @test c/zero(c) ≛ emptyinterval(c)
    @test Interval(0.0, 1.0)/Interval(0.0,1.0) ≛ Interval(0.0, Inf)
    @test Interval(-1.0, 1.0)/Interval(0.0,1.0) ≛ entireinterval(c)
    @test Interval(-1.0, 1.0)/Interval(-1.0,1.0) ≛ entireinterval(c)

    @test extended_div(Interval(-30.0,-15.0), Interval(-5.0,-3.0)) ≛ (Interval(3.0, 10.0), emptyinterval(c))
    @test extended_div(Interval(-30,-15) , Interval(-5,-3)) ≛ (Interval(3.0, 10.0), emptyinterval(c))
    @test extended_div(Interval(1.0, 2.0), Interval(0.1, 1.0)) ≛ (Interval(1, 20.0), emptyinterval(c))
    @test extended_div(a, c) ≛ (Interval(0.025, 4.4e+00), emptyinterval(c))
    @test extended_div(c, Interval(4.0)) ≛ (Interval(6.25e-02, 1e+00), emptyinterval(c))
    @test extended_div(c, zero(c)) ≛ (emptyinterval(c), emptyinterval(c))
    @test extended_div(Interval( 0.0, 1.0), Interval(0.0,1.0)) ≛ (entireinterval(c), emptyinterval(c))
    @test extended_div(Interval(-1.0, 1.0), Interval(0.0,1.0)) ≛ (entireinterval(c), emptyinterval(c))
    @test extended_div(Interval(-1.0, 1.0), Interval(-1.0,1.0)) ≛ (entireinterval(c), emptyinterval(c))
    @test extended_div(Interval(1.0, 2.0), Interval(-4.0, 4.0)) ≛ ((-∞.. -0.25), (0.25..∞))
    @test extended_div(Interval(-2.0, -1.0), Interval(-2.0, 4.0)) ≛ ((-∞.. -0.25), (0.5..∞))
    @test extended_div(Interval(0.0, 0.0), Interval(-1.0, 1.0)) ≛ (entireinterval(c), emptyinterval(c))

    @test (0..∞) * (-1..∞) ≛ -∞..∞
end

@testset "Arithmetic with constants" begin
    x = 1..2

    @test 0.1 + x ≛ Interval(1.0999999999999999, 2.1)
    @test 3.0 - x ≛ 1..2
    @test 3.1 - x ≛ Interval(1.1, 2.1)
    @test 0.1 * (1..1) ≛ Interval(0.1, 0.1)
    @test (1..1) / 10.0 ≛ Interval(0.09999999999999999, 0.1)
end

@testset "Arithmetic with irrational" begin
    @test (1..1) * π ≛ Interval(π)
    @test π * (1..1) ≛ Interval(π)
    @test π + (0..0) ≛ Interval(π)
    @test (0..0) + π ≛ Interval(π)
    @test π - (0..0) ≛ Interval(π)
    @test (0..0) - π ≛ -Interval(π)
end

@testset "Power tests" begin
    @test Interval(0,3) ^ 2 ≛ Interval(0, 9)
    @test Interval(2,3) ^ 2 ≛ Interval(4, 9)
    @test Interval(-3,0) ^ 2 ≛ Interval(0, 9)
    @test Interval(-3,-2) ^ 2 ≛ Interval(4, 9)
    @test Interval(-3,2) ^ 2 ≛ Interval(0, 9)
    @test Interval(0,3) ^ 3 ≛ Interval(0, 27)
    @test Interval(2,3) ^ 3 ≛ Interval(8, 27)
    @test Interval(-3,0) ^ 3 ≛ Interval(-27., 0.)
    @test Interval(-3,-2) ^ 3 ≛ Interval(-27, -8)
    @test Interval(-3,2) ^ 3 ≛ Interval(-27., 8.)
    @test Interval(0,3) ^ -2 ≛ Interval(1/9, Inf)
    @test Interval(-3,0) ^ -2 ≛ Interval(1/9, Inf)
    @test Interval(-3,2) ^ -2 ≛ Interval(1/9, Inf)
    @test Interval(2,3) ^ -2 ≛ Interval(1/9, 1/4)
    @test Interval(1,2) ^ -3 ≛ Interval(1/8, 1.0)
    @test Interval(0,3) ^ -3 ≛ Interval(1/27, Inf)
    @test Interval(-1,2) ^ -3 ≛ entireinterval()
    @test Interval(-3,2) ^ (3//1) ≛ Interval(-27, 8)
    @test Interval(0.0) ^ 1.1 ≛ Interval(0, 0)
    @test Interval(0.0) ^ 0.0 ≛ emptyinterval()
    @test Interval(0.0) ^ (1//10) ≛ Interval(0, 0)
    @test Interval(0.0) ^ (-1//10) ≛ emptyinterval()
    @test ∅ ^ 0 ≛ ∅
    @test Interval(2.5)^3 ≛ Interval(15.625, 15.625)
    @test Interval(5//2)^3.0 ≛ Interval(125//8)

    x = Interval(-3, 2)
    @test x^3 ≛ Interval(-27, 8)

    @test Interval(-3, 4) ^ 0.5 ≛ Interval(0, 2)
    @test Interval(-3, 4) ^ 0.5 ≛ Interval(-3, 4)^(1//2)
    @test Interval(-3, 2) ^ Interval(2) ≛ Interval(0.0, 4.0)
    @test Interval(-3, 4) ^ Interval(0.5) ≛ Interval(0, 2)
    @test @biginterval(-3, 4) ^ 0.5 ≛ @biginterval(0, 2)

    @test dist(Interval(1,27)^Interval(1/3), Interval(1., 3.)) < 2*eps(Interval(1,3)).lo
    @test dist(Interval(1,27)^(1/3), Interval(1., 3.)) < 2*eps(Interval(1,3)).lo
    @test Interval(1., 3.) ⊆ Interval(1,27)^(1//3)
    @test Interval(0.1,0.7)^(1//3) ≛ Interval(0.46415888336127786, 0.8879040017426008)
    @test dist(Interval(0.1,0.7)^(1/3),
        Interval(0.46415888336127786, 0.8879040017426008)) < 2*eps(Interval(0.1,0.7)^(1/3)).lo

    x = Interval{BigFloat}(27)
    y = x^(1//3)
    @test diam(y) == 0
    x = Interval{BigFloat}(9.595703125)
    y = x^(1//3)
    @test diam(y) == 0
    x = @biginterval(0.1)
    y = x^(1//3)
    @test (0 <= diam(y) < 1e-76)
end

@testset "Exp and log tests" begin
    @test exp(@biginterval(1//2)) ⊆ exp(Interval(1//2))
    @test exp(Interval(1//2)) ≛ Interval(1.648721270700128, 1.6487212707001282)
    @test exp(@biginterval(0.1)) ⊆ exp(Interval(0.1))
    @test exp(Interval(0.1)) ≛ Interval(1.1051709180756475e+00, 1.1051709180756477e+00)
    @test diam(exp(Interval(0.1))) == eps(exp(0.1))

    @test log(@biginterval(1//2)) ⊆ log(Interval(1//2))
    @test log(Interval(1//2)) ≛ Interval(-6.931471805599454e-01, -6.9314718055994529e-01)
    @test log(@biginterval(0.1)) ⊆ log(Interval(0.1))
    @test log(Interval(0.1)) ≛ Interval(-2.3025850929940459e+00, -2.3025850929940455e+00)
    @test diam(log(Interval(0.1))) == eps(log(0.1))

    @test exp2(@biginterval(1//2)) ⊆ exp2(Interval(1//2))
    @test exp2(Interval(1024.0)) ≛ Interval(1.7976931348623157e308, Inf)
    @test exp10(@biginterval(1//2)) ⊆ exp10(Interval(1//2))
    @test exp10(Interval(308.5)) ≛ Interval(1.7976931348623157e308, Inf)

    @test log2(@biginterval(1//2)) ⊆ log2(Interval(1//2))
    @test log2(Interval(0.25, 0.5)) ≛ Interval(-2.0, -1.0)
    @test log10(@biginterval(1//10)) ⊆ log10(Interval(1//10))
    @test log10(Interval(0.01, 0.1)) ≛ Interval(log10(0.01, RoundDown), log10(0.1, RoundUp))

    @test log1p(Interval(-0.5, 0.1)) ≛ Interval(log1p(-0.5, RoundDown), log1p(0.1, RoundUp))
    @test log1p(interval(-10.0)) ≛ ∅
end

@testset "Comparison tests" begin
    d = Interval(0.1, 2)

    @test d < 3
    @test d <= 2
    @test_skip ismissing(d < 2)  # Test depends on pointwise_policy mode
    @test -1 < d
    @test_skip ismissing(d < 0.15)  # Test depends on pointwise_policy mode

    # abs
    @test abs(Interval(0.1, 0.2)) ≛ Interval(0.1, 0.2)
    @test abs(Interval(-1, 2)) ≛ Interval(0, 2)

    # real
    @test real(Interval(-1, 1)) ≛ Interval(-1, 1)
end

@testset "Rational tests" begin
    f = 1 // 3
    g = 1 // 3
    @test_broken Interval(f*g) ≛ Interval(1.1111111111111109e-01, 1.1111111111111115e-01)
    @test interval(f, g) - 1 ≛ interval(-2 // 3, -2 // 3)
    @test big(1.)/9 ∈ Interval(f*g)
    @test Interval(1)/9 ⊆ Interval(f*g)
    @test_broken Interval(1/9) ≛ Interval(1//9)
end

@testset "Floor etc. tests" begin
    a = Interval(0.1)
    b = Interval(0.1, 0.1)
    @test dist(a, b) <= eps(a).lo

    @test floor(Interval(0.1, 1.1)) ≛ Interval(0, 1)
    @test round(Interval(0.1, 1.1), RoundDown) ≛ Interval(0, 1)
    @test ceil(Interval(0.1, 1.1)) ≛ Interval(1, 2)
    @test round(Interval(0.1, 1.1), RoundUp) ≛ Interval(1, 2)
    @test sign(Interval(0.1, 1.1)) ≛ Interval(1.0)
    @test signbit(Interval(-4)) ≛ Interval(1,1)
    @test signbit(Interval(5)) ≛ Interval(0,0)
    @test signbit(Interval(-4,5)) ≛ Interval(0,1)
    @test copysign(Interval(1,2), Interval(-1,1)) ≛ Interval(-2,2)
    @test copysign(3, Interval(-1,1)) ≛ Interval(-3,3)
    @test copysign(3.0, Interval(-1,1)) ≛ Interval(-3,3)
    @test copysign(3f0, Interval(-1,1)) ≛ Interval(-3,3)
    @test copysign(3, Interval(0,1)) ≛ Interval(3) ≛ Interval(copysign(3,0),copysign(3,1))
    @test copysign(3, Interval(-1,0)) ≛ Interval(-3,3) ≛ Interval(copysign(3,-1),copysign(3,0))
    @test copysign(UInt64(3), Interval(-1,1)) ≛ Interval(-3,3)
    @test copysign(BigFloat(3), Interval(-1,1)) ≛ Interval(-3,3)
    @test copysign(Interval(0,1), -1) ≛ Interval(-1,0)
    @test copysign(Interval(0,1), -1.0) ≛ Interval(-1,0)
    @test copysign(Interval(0,1), -1f0) ≛ Interval(-1,0)
    @test copysign(Interval(0,1), -BigFloat(1)) ≛ Interval(-1,0)
    @test copysign(Interval(0,1), UInt64(1)) ≛ Interval(0,1)
    @test copysign(Interval(-1),Interval(-1)) ≛ Interval(-1)
    @test copysign(Interval(-2,2), 2) ≛ Interval(0,2)
    @test flipsign(Interval(1,2), Interval(-1,1)) ≛ Interval(-2,2)
    @test flipsign(Interval(1,2), Interval(1,2)) ≛ Interval(1,2)
    @test flipsign(3, Interval(-1,1)) ≛ Interval(-3,3)
    @test flipsign(3.0, Interval(-1,1)) ≛ Interval(-3,3)
    @test flipsign(3f0, Interval(-1,1)) ≛ Interval(-3,3)
    @test flipsign(3, Interval(0,1)) ≛ Interval(3,3) ≛ Interval(flipsign(3,0),flipsign(3,1))
    @test flipsign(3, Interval(-1,0)) ≛ Interval(-3,3) ≛ Interval(flipsign(3,-1),flipsign(3,0))
    @test flipsign(UInt64(3), Interval(-1,1)) ≛ Interval(-3,3)
    @test flipsign(BigFloat(3), Interval(-1,1)) ≛ Interval(-3,3)
    @test flipsign(Interval(0,1), -1) ≛ Interval(-1,0)
    @test flipsign(Interval(0,1), -1.0) ≛ Interval(-1,0)
    @test flipsign(Interval(0,1), -1f0) ≛ Interval(-1,0)
    @test flipsign(Interval(0,1), -BigFloat(1)) ≛ Interval(-1,0)
    @test flipsign(Interval(0,1), UInt64(1)) ≛ Interval(0,1)
    @test flipsign(Interval(-1),Interval(-1)) ≛ Interval(1)
    @test trunc(Interval(0.1, 1.1)) ≛ Interval(0.0, 1.0)
    @test round(Interval(0.1, 1.1), RoundToZero) ≛ Interval(0.0, 1.0)
    @test round(Interval(0.1, 1.1)) ≛ Interval(0.0, 1.0)
    @test round(Interval(0.1, 1.5)) ≛ Interval(0.0, 2.0)
    @test round(Interval(-1.5, 0.1)) ≛ Interval(-2.0, 0.0)
    @test round(Interval(-2.5, 0.1)) ≛ Interval(-2.0, 0.0)
    @test round(Interval(0.1, 1.1), RoundTiesToEven) ≛ Interval(0.0, 1.0)
    @test round(Interval(0.1, 1.5), RoundTiesToEven) ≛ Interval(0.0, 2.0)
    @test round(Interval(-1.5, 0.1), RoundTiesToEven) ≛ Interval(-2.0, 0.0)
    @test round(Interval(-2.5, 0.1), RoundTiesToEven) ≛ Interval(-2.0, 0.0)
    @test round(Interval(0.1, 1.1), RoundTiesToAway) ≛ Interval(0.0, 1.0)
    @test round(Interval(0.1, 1.5), RoundTiesToAway) ≛ Interval(0.0, 2.0)
    @test round(Interval(-1.5, 0.1), RoundTiesToAway) ≛ Interval(-2.0, 0.0)
    @test round(Interval(-2.5, 0.1), RoundTiesToAway) ≛ Interval(-3.0, 0.0)
end

@testset "Fast power" begin

    @testset "Fast integer powers" begin
        x = 1..2
        @test pow(x, 2) ≛ pow(-x, 2) ≛ Interval(1, 4)
        @test pow(-x, 3) ≛ Interval(-8.0, -1.0)

        @test pow(-1..2, 2) ≛ 0..4
        @test pow(-1..2, 3) ≛ -1..8
        @test pow(-1..2, 4) ≛ 0..16

        @test pow(-2 .. -1, 4..4) ≛ 1..16
        @test pow(-2 .. -1, -1 .. -1) ≛ -1 .. -0.5

        @test pow(@biginterval(-1, 2), 2) ≛ 0..4
        @test pow(@biginterval(-1, 2), 3) ≛ -1..8
        @test pow(@biginterval(1, 2), 2) ≛ 1..4

        x = Interval(pi)
        @test x^100 ⊆ pow(x, 100)
        @test x^50 ⊆ pow(x, 50)
        @test isinterior(x^50, pow(x, 50))

        x = Interval(2)
        @test pow(x, 2000) ≛ Interval(floatmax(), Inf)
    end

    @testset "Fast real powers" begin
        x = 1..2
        @test pow(x, 0.5) ≛ Interval(1.0, 1.4142135623730951)
        @test pow(x, 0.5) ≛ x^0.5

        y = 2..3
        @test pow(y, -0.5) ≛ Interval(0.5773502691896257, 0.7071067811865476)

        y = -2..3
        @test pow(y, 2.1) ≛ Interval(0.0, 10.045108566305146)
        @test y^2.1 ⊆ pow(y, 2.1)
    end

    @testset "Fast interval powers" begin
        x = 1..2
        @test x^Interval(-1.5, 2.5) ≛ Interval(0.35355339059327373, 5.656854249492381)

        y = -2..3
        @test pow(y, 2.1) ≛ Interval(0.0, 10.045108566305146)
        @test pow(y, Interval(-2, 3)) ≛ Interval(0, Inf)

        @test pow(y, Interval(2.1)) ≛ Interval(0.0, 10.045108566305146)
    end

    @testset "sqrt" begin
        @test sqrt(2..3) ≛ Interval(1.414213562373095, 1.7320508075688774)

        @test sqrt(big(2..3)) ≛ Interval(big"1.414213562373095048801688724209698078569671875376948073176679737990732478462102", big"1.732050807568877293527446341505872366942805253810380628055806979451933016908815")
    end

    @testset "cbrt" begin
        @test cbrt(2..3) ≛ Interval(1.259921049894873, 1.4422495703074085)
        @test cbrt(big(2..3)) ≛ Interval(big"1.259921049894873164767210607278228350570251464701507980081975112155299676513956", big"1.442249570307408382321638310780109588391869253499350577546416194541687596830003")
        @test cbrt(big(2..3)) ⊆ cbrt(2..3)
        @test_skip ismissing(cbrt(big(3..4)) == cbrt(3..4))
        @test cbrt(2f0..3f0) ≛ Interval(1.259921f0, 1.4422497f0)
        @test cbrt(2..3) ⊆ cbrt(2f0..3f0)
    end

    @testset "inv" begin
        @test inv(2..3) ≛ Interval(0.3333333333333333, 0.5)
        @test inv(big(2..3)) ≛ Interval(big"3.333333333333333333333333333333333333333333333333333333333333333333333333333305e-01", big"5.0e-01")
    end

    @testset "Float32 intervals" begin

        a = Interval{Float32}(1e38)
        b = Interval{Float32}(1e2)
        @test a * b ≛ Interval{Float32}(floatmax(Float32), Inf)
    end



end

@testset "Mince for `Interval`s" begin
    II = -1 .. 1
    v = mince(II, 4)
    @test all(v .≛ [-1 .. -0.5, -0.5 .. 0, 0 .. 0.5, 0.5 .. 1])
    @test hull(v...) ≛ II
    @test hull(v) ≛ II
    v = mince(II, 8)
    @test length(v) == 8
    @test hull(v...) ≛ II
    @test hull(v) ≛ II
end

@testset "nthroot test" begin
    @test nthroot(∅, 3) ≛ ∅
    @test nthroot(∅, 4) ≛ ∅
    @test nthroot(∅, -3) ≛ ∅
    @test nthroot(∅, -4) ≛ ∅
    @test nthroot(Interval(1, 2), 0) ≛ ∅
    @test nthroot(Interval(5, 8), 0) ≛ ∅
    @test nthroot(Interval(1, 7), 0) ≛ ∅
    @test nthroot(Interval(8, 27), 3) ≛ Interval(2, 3)
    @test nthroot(Interval(0, 27), 3) ≛ Interval(0, 3)
    @test nthroot(Interval(-27, 0), 3) ≛ Interval(-3, 0)
    @test nthroot(Interval(-27, 27), 3) ≛ Interval(-3, 3)
    @test nthroot(Interval(-27, -8), 3) ≛ Interval(-3, -2)
    @test nthroot(Interval(16, 81), 4) ≛ Interval(2, 3)
    @test nthroot(Interval(0, 81), 4) ≛ Interval(0, 3)
    @test nthroot(Interval(-81, 0), 4) ≛ Interval(0)
    @test nthroot(Interval(-81, 81), 4) ≛ Interval(0, 3)
    @test nthroot(Interval(-81, -16), 4) ≛ ∅
    @test nthroot(Interval(8, 27), -3) ≛ Interval(1/3, 1/2)
    @test nthroot(Interval(0, 27), -3) ≛ Interval(1/3, Inf)
    @test nthroot(Interval(-27, 0), -3) ≛ Interval(-Inf, -1/3)
    @test nthroot(Interval(-27, 27), -3) ≛ Interval(-Inf, Inf)
    @test nthroot(Interval(-27, -8), -3) ≛ Interval(-1/2, -1/3)
    @test nthroot(Interval(16, 81), -4) ≛ Interval(1/3, 1/2)
    @test nthroot(Interval(0, 81), -4) ≛ Interval(1/3, Inf)
    @test nthroot(Interval(-81, 0), -4) ≛ ∅
    @test nthroot(Interval(-81, 1), 1) ≛ Interval(-81, 1)
    @test nthroot(Interval(-81, 81), -4) ≛ Interval(1/3, Inf)
    @test nthroot(Interval(-81, -16), -4) ≛ ∅
    @test nthroot(Interval(-81, -16), 1) ≛ Interval(-81, -16)
    @test nthroot(Interval{BigFloat}(16, 81), 4) ≛ Interval{BigFloat}(2, 3)
    @test nthroot(Interval{BigFloat}(0, 81), 4) ≛ Interval{BigFloat}(0, 3)
    @test nthroot(Interval{BigFloat}(-81, 0), 4) ≛ Interval{BigFloat}(0)
    @test nthroot(Interval{BigFloat}(-81, 81), 4) ≛ Interval{BigFloat}(0, 3)
    @test nthroot(Interval{BigFloat}(-27, 27), -3) ≛ Interval{BigFloat}(-Inf, Inf)
    @test nthroot(Interval{BigFloat}(-81, -16), -4) ≛ ∅
    @test nthroot(Interval{BigFloat}(-81, -16), 1) ≛ Interval{BigFloat}(-81, -16)
end
