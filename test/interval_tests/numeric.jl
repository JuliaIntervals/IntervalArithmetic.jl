# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

@testset "brodcasting tests" begin
    x = 3..12
    y = 4..5
    a = 3
    b = 12
    
    @test sqrt(sum(x.^2 .+ y.^2)) == 5..13

    for i in 1:20
        @test x.-i == (a-i)..(b-i)
    end


    for i in 1:20
        @test x.*i == (a*i)..(b*i)
    end

    a = 4
    b = 5 
    for i in 1:20
        @test y.+i == (a+i)..(b+i)
    end

    for i in 1:20
        @test y./i == (a/i)..(b/i)
    end

end

@testset "Numeric tests" begin

    a = @interval(0.1, 1.1)
    b = @interval(0.9, 2.0)
    c = @interval(0.25, 4.0)


    ## Basic arithmetic
    @test @interval(0.1) == Interval(9.9999999999999992e-02, 1.0000000000000001e-01)
    @test +a == a
    @test a+b == Interval(9.9999999999999989e-01, 3.1000000000000001e+00)
    @test -a == Interval(-1.1000000000000001e+00, -9.9999999999999992e-02)
    @test a-b == Interval(-1.9000000000000001e+00, 2.0000000000000018e-01)
    @test Interval(1//4,1//2) + Interval(2//3) == Interval(11//12, 7//6)
    @test Interval(1//4,1//2) - Interval(2//3) == Interval(-5//12, -1//6)

    @test 10a == @interval(10a)
    #@test 10Interval(1//10) == one(@interval(1//10))
    @test Interval(-30.0,-15.0) / Interval(-5.0,-3.0) == Interval(3.0, 10.0)
    @test @interval(-30,-15) / @interval(-5,-3) == Interval(3.0, 10.0)
    @test b/a == Interval(8.18181818181818e-01, 2.0000000000000004e+01)
    @test a/c == Interval(2.4999999999999998e-02, 4.4000000000000004e+00)
    @test c/4.0 == Interval(6.25e-02, 1e+00)
    @test c/zero(c) == emptyinterval(c)
    @test Interval(0.0, 1.0)/Interval(0.0,1.0) == Interval(0.0, Inf)
    @test Interval(-1.0, 1.0)/Interval(0.0,1.0) == RR(c)
    @test Interval(-1.0, 1.0)/Interval(-1.0,1.0) == RR(c)

    @test extended_div(Interval(-30.0,-15.0), Interval(-5.0,-3.0)) == (Interval(3.0, 10.0), emptyinterval(c))
    @test extended_div(@interval(-30,-15) , @interval(-5,-3)) == (Interval(3.0, 10.0), emptyinterval(c))
    @test extended_div(1.0..2.0, 0.1..1.0) == (Interval(1, 20.000000000000004), emptyinterval(c))
    @test extended_div(a, c) == (Interval(2.4999999999999998e-02, 4.4e+00), emptyinterval(c))
    @test extended_div(c, Interval(4.0)) == (Interval(6.25e-02, 1e+00), emptyinterval(c))
    @test extended_div(c, zero(c)) == (emptyinterval(c), emptyinterval(c))
    @test extended_div(Interval( 0.0, 1.0), Interval(0.0,1.0)) == (RR(c), emptyinterval(c))
    @test extended_div(Interval(-1.0, 1.0), Interval(0.0,1.0)) == (RR(c), emptyinterval(c))
    @test extended_div(Interval(-1.0, 1.0), Interval(-1.0,1.0)) == (RR(c), emptyinterval(c))
    @test extended_div(Interval(1.0, 2.0), Interval(-4.0, 4.0)) == ((-∞.. -0.25), (0.25..∞))
    @test extended_div(Interval(-2.0, -1.0), Interval(-2.0, 4.0)) == ((-∞.. -0.25), (0.5..∞))
    @test extended_div(Interval(0.0, 0.0), Interval(-1.0, 1.0)) == (RR(c), emptyinterval(c))

    a = @interval(1.e-20)
    @test a == Interval(1.0e-20, 1.0000000000000001e-20)
    @test diam(a) == eps(1.e-20)

    @test (0..∞) * (-1..∞) == -∞..∞
end

@testset "Arithmetic with constants" begin
    x = 1..2

    @test 0.1 + x == Interval(1.0999999999999999, 2.1)
    @test 3.0 - x == 1..2
    @test 3.1 - x == Interval(1.1, 2.1)
    @test 0.1 * (1..1) == Interval(0.1, 0.1)
    @test (1..1) / 10.0 == Interval(0.09999999999999999, 0.1)

end

@testset "Power tests" begin
    @test @interval(0,3) ^ 2 == Interval(0, 9)
    @test @interval(2,3) ^ 2 == Interval(4, 9)
    @test @interval(-3,0) ^ 2 == Interval(0, 9)
    @test @interval(-3,-2) ^ 2 == Interval(4, 9)
    @test @interval(-3,2) ^ 2 == Interval(0, 9)
    @test @interval(0,3) ^ 3 == Interval(0, 27)
    @test @interval(2,3) ^ 3 == Interval(8, 27)
    @test @interval(-3,0) ^ 3 == @interval(-27., 0.)
    @test @interval(-3,-2) ^ 3 == @interval(-27, -8)
    @test @interval(-3,2) ^ 3 == @interval(-27., 8.)
    @test Interval(0,3) ^ -2 == Interval(1/9, Inf)
    @test Interval(-3,0) ^ -2 == Interval(1/9, Inf)
    @test Interval(-3,2) ^ -2 == Interval(1/9, Inf)
    @test Interval(2,3) ^ -2 == Interval(1/9, 1/4)
    @test Interval(1,2) ^ -3 == Interval(1/8, 1.0)
    @test Interval(0,3) ^ -3 == @interval(1/27, Inf)
    @test Interval(-1,2) ^ -3 == RR()
    @test Interval(-3,2) ^ (3//1) == Interval(-27, 8)
    @test Interval(0.0) ^ 1.1 == Interval(0, 0)
    @test Interval(0.0) ^ 0.0 == emptyinterval()
    @test Interval(0.0) ^ (1//10) == Interval(0, 0)
    @test Interval(0.0) ^ (-1//10) == emptyinterval()
    @test ∅ ^ 0 == ∅
    @test Interval(2.5)^3 == Interval(15.625, 15.625)
    #@test Interval(5//2)^3.0 == Interval(125//8)

    x = @interval(-3,2)
    @test x^3 == @interval(-27, 8)

    @test @interval(-3,4) ^ 0.5 == @interval(0, 2)
    @test @interval(-3,4) ^ 0.5 == @interval(-3,4)^(1//2)
    @test @interval(-3,2) ^ @interval(2) == Interval(0.0, 4.0)
    @test @interval(-3,4) ^ @interval(0.5) == Interval(0, 2)
    @test @biginterval(-3,4) ^ 0.5 == @biginterval(0, 2)

    @test dist(@interval(1,27)^@interval(1/3), Interval(1., 3.)) < 2*eps(Interval(1,3)).lo
    @test dist(@interval(1,27)^(1/3), Interval(1., 3.)) < 2*eps(Interval(1,3)).lo
    @test Interval(1., 3.) ⊆ @interval(1,27)^(1//3)
    @test @interval(0.1,0.7)^(1//3) == Interval(0.46415888336127786, 0.8879040017426008)
    @test dist(@interval(0.1,0.7)^(1/3),
        Interval(0.46415888336127786, 0.8879040017426008)) < 2*eps(@interval(0.1,0.7)^(1/3)).lo

    x = @biginterval(27)
    y = x^(1//3)
    @test_broken diam(y) == 0
    y = x^(1/3)
    @test (0 <= diam(y) < 1e-76)
    x = @biginterval(9.595703125)
    y = x^(1//3)
    @test_broken diam(y) == 0
    x = @biginterval(0.1)
    y = x^(1//3)
    @test (0 <= diam(y) < 1e-76)

end

@testset "Exp and log tests" begin
    @test exp(@biginterval(1//2)) ⊆ exp(@interval(1//2))
    @test exp(@interval(1//2)) == Interval(1.648721270700128, 1.6487212707001282)
    @test exp(@biginterval(0.1)) ⊆ exp(@interval(0.1))
    @test exp(@interval(0.1)) == Interval(1.1051709180756475e+00, 1.1051709180756477e+00)
    @test diam(exp(@interval(0.1))) == eps(exp(0.1))

    @test log(@biginterval(1//2)) ⊆ log(@interval(1//2))
    @test log(@interval(1//2)) == Interval(-6.931471805599454e-01, -6.9314718055994529e-01)
    @test log(@biginterval(0.1)) ⊆ log(@interval(0.1))
    @test log(@interval(0.1)) == Interval(-2.3025850929940459e+00, -2.3025850929940455e+00)
    @test diam(log(@interval(0.1))) == eps(log(0.1))

    @test exp2(@biginterval(1//2)) ⊆ exp2(@interval(1//2))
    @test exp2(Interval(1024.0)) == Interval(1.7976931348623157e308, Inf)
    @test exp10(@biginterval(1//2)) ⊆ exp10(@interval(1//2))
    @test exp10(Interval(308.5)) == Interval(1.7976931348623157e308, Inf)

    @test log2(@biginterval(1//2)) ⊆ log2(@interval(1//2))
    @test log2(@interval(0.25, 0.5)) == Interval(-2.0, -1.0)
    @test log10(@biginterval(1//10)) ⊆ log10(@interval(1//10))
    @test log10(@interval(0.01, 0.1)) == @interval(log10(0.01), log10(0.1))

    @test log1p(@interval(-0.5, 0.1)) == @interval(log1p(-0.5), log1p(0.1))
    @test log1p(interval(-10.0)) == ∅
end

@testset "Comparison tests" begin
    d = @interval(0.1, 2)

    @test d < 3
    @test d <= 2
    @test (d < 2) == false
    @test -1 < d
    @test !(d < 0.15)

    # abs
    @test abs(@interval(0.1, 0.2)) == Interval(9.9999999999999992e-02, 2.0000000000000001e-01)
    @test abs(@interval(-1, 2)) == Interval(0, 2)

    # real
    @test real(@interval(-1, 1)) == Interval(-1, 1)
end

@testset "Rational tests" begin

    f = 1 // 3
    g = 1 // 3

    @test @interval(f*g) == Interval(1.1111111111111109e-01, 1.1111111111111115e-01)
    @test big(1.)/9 ∈ @interval(f*g)
    @test @interval(1)/9 ⊆ @interval(f*g)
    @test @interval(1)/9 ≠ @interval(f*g)

    h = 1/3
    i = 1/3

    @test @interval(h*i) == Interval(1.1111111111111109e-01, 1.1111111111111115e-01)
    @test big(1.)/9 ∈ @interval(1/9)

    @test @interval(1/9) == @interval(1//9)
end

@testset "Floor etc. tests" begin
    a = @interval(0.1)
    b = Interval(0.1, 0.1)
    @test_broken dist(a,b) <= eps(a)

    @test floor(@interval(0.1, 1.1)) == Interval(0, 1)
    @test round(@interval(0.1, 1.1), RoundDown) == Interval(0, 1)
    @test ceil(@interval(0.1, 1.1)) == Interval(1, 2)
    @test round(@interval(0.1, 1.1), RoundUp) == Interval(1, 2)
    @test sign(@interval(0.1, 1.1)) == Interval(1.0)
    @test signbit(@interval(-4)) == @interval(1,1)
    @test signbit(@interval(5)) == @interval(0,0)
    @test signbit(@interval(-4,5)) == @interval(0,1)
    @test copysign(@interval(1,2), @interval(-1,1)) == @interval(-2,2)
    @test copysign(3, @interval(-1,1)) == @interval(-3,3)
    @test copysign(3.0, @interval(-1,1)) == @interval(-3,3)
    @test copysign(3f0, @interval(-1,1)) == @interval(-3,3)
    @test copysign(3, @interval(0,1)) == @interval(3) == @interval(copysign(3,0),copysign(3,1))
    @test copysign(3, @interval(-1,0)) == @interval(-3,3) == @interval(copysign(3,-1),copysign(3,0))
    @test copysign(UInt64(3), @interval(-1,1)) == @interval(-3,3)
    @test copysign(BigFloat(3), @interval(-1,1)) == @interval(-3,3)
    @test copysign(@interval(0,1), -1) == @interval(-1,0)
    @test copysign(@interval(0,1), -1.0) == @interval(-1,0)
    @test copysign(@interval(0,1), -1f0) == @interval(-1,0)
    @test copysign(@interval(0,1), -BigFloat(1)) == @interval(-1,0)
    @test copysign(@interval(0,1), UInt64(1)) == @interval(0,1)
    @test copysign(@interval(-1),@interval(-1)) == @interval(-1)
    @test copysign(@interval(-2,2), 2) == @interval(0,2)
    @test flipsign(@interval(1,2), @interval(-1,1)) == @interval(-2,2)
    @test flipsign(@interval(1,2), @interval(1,2)) == @interval(1,2)
    @test flipsign(3, @interval(-1,1)) == @interval(-3,3)
    @test flipsign(3.0, @interval(-1,1)) == @interval(-3,3)
    @test flipsign(3f0, @interval(-1,1)) == @interval(-3,3)
    @test flipsign(3, @interval(0,1)) == @interval(3,3) == @interval(flipsign(3,0),flipsign(3,1))
    @test flipsign(3, @interval(-1,0)) == @interval(-3,3) == @interval(flipsign(3,-1),flipsign(3,0))
    @test flipsign(UInt64(3), @interval(-1,1)) == @interval(-3,3)
    @test flipsign(BigFloat(3), @interval(-1,1)) == @interval(-3,3)
    @test flipsign(@interval(0,1), -1) == @interval(-1,0)
    @test flipsign(@interval(0,1), -1.0) == @interval(-1,0)
    @test flipsign(@interval(0,1), -1f0) == @interval(-1,0)
    @test flipsign(@interval(0,1), -BigFloat(1)) == @interval(-1,0)
    @test flipsign(@interval(0,1), UInt64(1)) == @interval(0,1)
    @test flipsign(@interval(-1),@interval(-1)) == @interval(1)
    @test trunc(@interval(0.1, 1.1)) == Interval(0.0, 1.0)
    @test round(@interval(0.1, 1.1), RoundToZero) == Interval(0.0, 1.0)
    @test round(@interval(0.1, 1.1)) == Interval(0.0, 1.0)
    @test round(@interval(0.1, 1.5)) == Interval(0.0, 2.0)
    @test round(@interval(-1.5, 0.1)) == Interval(-2.0, 0.0)
    @test round(@interval(-2.5, 0.1)) == Interval(-2.0, 0.0)
    @test round(@interval(0.1, 1.1), RoundTiesToEven) == Interval(0.0, 1.0)
    @test round(@interval(0.1, 1.5), RoundTiesToEven) == Interval(0.0, 2.0)
    @test round(@interval(-1.5, 0.1), RoundTiesToEven) == Interval(-2.0, 0.0)
    @test round(@interval(-2.5, 0.1), RoundTiesToEven) == Interval(-2.0, 0.0)
    @test round(@interval(0.1, 1.1), RoundTiesToAway) == Interval(0.0, 1.0)
    @test round(@interval(0.1, 1.5), RoundTiesToAway) == Interval(0.0, 2.0)
    @test round(@interval(-1.5, 0.1), RoundTiesToAway) == Interval(-2.0, 0.0)
    @test round(@interval(-2.5, 0.1), RoundTiesToAway) == Interval(-3.0, 0.0)
end

@testset "Fast power" begin

    @testset "Fast integer powers" begin
        x = 1..2
        @test pow(x, 2) == pow(-x, 2) == Interval(1, 4)
        @test pow(-x, 3) == Interval(-8.0, -1.0)

        @test pow(-1..2, 2) == 0..4
        @test pow(-1..2, 3) == -1..8
        @test pow(-1..2, 4) == 0..16

        @test pow(-2 .. -1, 4..4) == 1..16
        @test pow(-2 .. -1, -1 .. -1) == -1 .. -0.5

        @test pow(@biginterval(-1, 2), 2) == 0..4
        @test pow(@biginterval(-1, 2), 3) == -1..8
        @test pow(@biginterval(1, 2), 2) == 1..4

        x = @interval(pi)
        @test x^100 ⊆ pow(x, 100)
        @test x^50 ⊆ pow(x, 50)
        @test isinterior(x^50, pow(x, 50))

        x = Interval(2)
        @test pow(x, 2000) == Interval(floatmax(), Inf)
    end

    @testset "Fast real powers" begin
        x = 1..2
        @test pow(x, 0.5) == Interval(1.0, 1.4142135623730951)
        @test pow(x, 0.5) == x^0.5

        @test pow(x, 17.3) != x^17.3

        y = 2..3
        @test pow(y, -0.5) == Interval(0.5773502691896257, 0.7071067811865476)

        y = -2..3
        @test pow(y, 2.1) == Interval(0.0, 10.045108566305146)
        @test pow(y, 2.1) != y^2.1
        @test y^2.1 ⊆ pow(y, 2.1)
    end

    @testset "Fast Interval powers" begin
        x = 1..2
        @test x^Interval(-1.5, 2.5) == Interval(0.35355339059327373, 5.656854249492381)

        y = -2..3
        @test pow(y, 2.1) == Interval(0.0, 10.045108566305146)
        @test pow(y, Interval(-2, 3)) == Interval(0, Inf)

        @test pow(y, @interval(2.1)) == Interval(0.0, 10.045108566305146)
    end

    @testset "sqrt" begin
        @test sqrt(2..3) == Interval(1.414213562373095, 1.7320508075688774)

        @test sqrt(big(2..3)) == Interval(big"1.414213562373095048801688724209698078569671875376948073176679737990732478462102", big"1.732050807568877293527446341505872366942805253810380628055806979451933016908815")
    end

    @testset "cbrt" begin
        @test cbrt(2..3) == Interval(1.259921049894873, 1.4422495703074085)

        @test cbrt(big(2..3)) == Interval(big"1.259921049894873164767210607278228350570251464701507980081975112155299676513956", big"1.442249570307408382321638310780109588391869253499350577546416194541687596830003")

        @test cbrt(big(2..3)) ⊆ cbrt(2..3)

        @test cbrt(big(3..4)) != cbrt(3..4)
    end

    @testset "inv" begin
        @test inv(2..3) == Interval(0.3333333333333333, 0.5)
        @test inv(big(2..3)) == Interval(big"3.333333333333333333333333333333333333333333333333333333333333333333333333333305e-01", big"5.0e-01")
    end

    @testset "Float32 Intervals" begin

        a = Interval{Float32}(1e38)
        b = Interval{Float32}(1e2)
        @test a * b == Interval{Float32}(floatmax(Float32), Inf)
    end



end

@testset "Mince for `Interval`s" begin
    II = -1 .. 1
    v = mince(II, 4)
    @test v == [-1 .. -0.5, -0.5 .. 0, 0 .. 0.5, 0.5 .. 1]
    @test hull(v...) == II
    @test hull(v) == II
    v = mince(II, 8)
    @test length(v) == 8
    @test hull(v...) == II
    @test hull(v) == II
end
