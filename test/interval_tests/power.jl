@testset "rational_power_test" begin
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

@testset "Interval{<:Rational}" begin
    a = interval(Rational{Int64}, 1//2, 3//4)
    b = interval(Rational{Int64}, 3//7, 9//12)

    @test issubset_interval(sqrt(a + b), interval(Int64(137482504)//142672337, Int64(46099201)//37639840))

    @test issubset_interval(sqrt(interval(1//3)), interval(Int64(29354524)//50843527, Int64(50843527)//88063572))
end

@testset "Decorations" begin
    a = interval(1, 2, IntervalArithmetic.com)
    b = sqrt(a)
    @test isequal_interval(interval(b), sqrt(interval(1, 2)))
    @test decoration(b) == IntervalArithmetic.com

    a = interval(-1, 1, IntervalArithmetic.com)
    b = sqrt(a)
    @test isequal_interval(interval(b), sqrt(interval(0, 1)))
    @test decoration(b) == IntervalArithmetic.trv

    @test isequal_interval(pown(interval(2, 3)  ,  2), interval(4, 9))
    @test isequal_interval(pown(interval(2, 3)  , -2), interval(1/9, 1/4))
    @test isequal_interval(pown(interval(-3, 2) ,  3), interval(-27, 8))
    @test isequal_interval(pown(interval(-3, -2), -3), interval(-1/8, -1/27))
    @test isequal_interval(pown(interval(0, 3)  ,  2), interval(0, 9))
    @test isequal_interval(pown(interval(0, 3)  , -2), interval(1/9, Inf, IntervalArithmetic.trv))
    @test isequal_interval(pow(interval(2, 3) , interval(0, 1)), interval(1, 3))
    @test isequal_interval(pow(interval(2, 3) , interval(0, 1)), interval(1, 3))
    @test isequal_interval(pow(interval(0, 2) , interval(0, 1)), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(pow(interval(0, 2) , interval(0, 1)), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(pow(interval(-3, 2), interval(0, 1)), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(pow(interval(-3, 2), interval(0, 1)), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(pow(interval(-3, 2), interval(-1, 1)), interval(0, Inf, IntervalArithmetic.trv))
    @test isequal_interval(pow(interval(-3, 2), interval(-1, 1)), interval(0, Inf, IntervalArithmetic.trv))
end

@testset "Complex{<:Interval}" begin
    a = interval(3 + 4im)
    b = exp(a)
    @test isequal_interval(real(b), interval(-13.12878308146216, -13.128783081462153))
    @test isequal_interval(imag(b), interval(-15.200784463067956, -15.20078446306795))

    z = exp(-im * interval(π))
    @test in_interval(-1, real(z))
    @test in_interval(0, imag(z))

    z = interval(0im)
    @test isthinzero(z ^ 2)
    @test isthinone(z ^ 0)
    @test isempty_interval(z ^ (-1))

    z = interval(0im)
    @test isthinzero(z ^ interval(2))
    @test isthinone(z ^ interval(0))
    @test isempty_interval(z ^ interval(-1))
    @test isempty_interval(z ^ emptyinterval())

    x = interval(3 + 4im)
    @test in_interval(-7 + 24im, x^2)
    @test issubset_interval(sqrt(x), x^0.5)

    a = -3.1
    @test issubset_interval(x, (x^a)^(1/a))

    z = interval(3 + 4im)
    sZ = sqrt(z)
    @test in_interval(2 + im, sZ)

    @test issubset_interval(interval(0, 1)*interval(im), sqrt(interval(-1, 0) + interval(0)*interval(im)))
    @test issubset_interval(interval(0, 1) + interval(0, 1)*interval(im), sqrt(interval(-1, 1) + interval(0)*interval(im)))
    @test issubset_interval(interval(0, Inf) + interval(-3//8, Inf)*interval(im), sqrt(interval(-9//32, Inf)*interval(im)))
end

@testset "Literal powers" begin
    x = interval(-1,1)
    n = 2
    @test isguaranteed(x ^ 2)
    @test !isguaranteed(x ^ n)
    @test !isguaranteed(x ^ 2.0)
    if VERSION ≥ v"1.12-DEV" && Int != Int32
        @test isguaranteed(x ^ 2305843009213693952)
    else
        @test_broken isguaranteed(x ^ 2305843009213693952)
    end
    @test isequal_interval(x^2, interval(0,1))
    @test isequal_interval(x^3, x)
end
