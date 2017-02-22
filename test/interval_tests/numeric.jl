# This file is part of the ValidatedNumerics.jl package; MIT licensed

if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end
using ValidatedNumerics

setprecision(Interval, Float64)
setrounding(Interval, :narrow)


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
    @test Interval(-1.0, 1.0)/Interval(0.0,1.0) == entireinterval(c)
    @test Interval(-1.0, 1.0)/Interval(-1.0,1.0) == entireinterval(c)
    a = @interval(1.e-20)
    @test a == Interval(1.0e-20, 1.0000000000000001e-20)
    @test diam(a) == eps(1.e-20)
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
    @test Interval(-1,2) ^ -3 == entireinterval()
    @test_throws ArgumentError Interval(-1, -2) ^ -3  # wrong way round
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

    @test dist(@interval(1,27)^@interval(1/3), Interval(1., 3.)) < 2*eps(Interval(1,3))
    @test dist(@interval(1,27)^(1/3), Interval(1., 3.)) < 2*eps(Interval(1,3))
    @test Interval(1., 3.) ⊆ @interval(1,27)^(1//3)
    @test @interval(0.1,0.7)^(1//3) == Interval(0.46415888336127786, 0.8879040017426008)
    @test dist(@interval(0.1,0.7)^(1/3),
        Interval(0.46415888336127786, 0.8879040017426008)) < 2*eps(@interval(0.1,0.7)^(1/3))

    setprecision(Interval, 256)
    x = @biginterval(27)
    y = x^(1//3)
    @test (0 < diam(y) < 1e-76)
    y = x^(1/3)
    @test (0 < diam(y) < 1e-76)

end

setprecision(Interval, Float64)

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
    @test dist(a,b) <= eps(a)

    @test floor(@interval(0.1, 1.1)) == Interval(0, 1)
    @test round(@interval(0.1, 1.1), RoundDown) == Interval(0, 1)
    @test ceil(@interval(0.1, 1.1)) == Interval(1, 2)
    @test round(@interval(0.1, 1.1), RoundUp) == Interval(1, 2)
    @test sign(@interval(0.1, 1.1)) == Interval(1.0)
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

    # :wide tests
    setrounding(Interval, :wide)
    setprecision(Interval, Float64)

    a = @interval(-3.0, 2.0)
    @test a == Interval(-3.0, 2.0)
    @test a^3 == Interval(-27, 8)
    @test Interval(-3,2)^3 == Interval(-27, 8)

    @test Interval(-27.0, 8.0)^(1//3) == Interval(0, 2.0000000000000004)

    setrounding(Interval, :narrow)
end

@testset "Fast power" begin
    x = 1..2
    @test pow(x, 2) == pow(-x, 2) == Interval(1, 4)
    @test pow(-x, 3) == Interval(-8.0, -1.0)

    @test pow(-1..2, 2) == 0..4
    @test pow(-1..2, 3) == -1..8
    @test pow(-1..2, 4) == 0..16

    @test pow(@biginterval(-1, 2), 2) == 0..4
    @test pow(@biginterval(-1, 2), 3) == -1..8
    @test pow(@biginterval(1, 2), 2) == 1..4


    x = @interval(pi)
    @test x^100 ⊆ pow(x, 100)
    @test x^50 ⊆ pow(x, 50)
    @test interior(x^50, pow(x, 50))


end
