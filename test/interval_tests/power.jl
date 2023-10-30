@testset "rational_power_test" begin
    @test isequal_interval(^(emptyinterval(), 1//3), emptyinterval())
    @test isequal_interval(^(interval(1, 8), 1//3), interval(1, 2))
    @test issubset_interval(interval(2^(1//3), 2), ^(interval(2, 8), 1//3))
    @test issubset_interval(interval(1, 9^(1//3)), ^(interval(1, 9), 1//3))
    @test issubset_interval(interval(2^(1//3), 9^(1//3)), ^(interval(2, 9), 1//3))
    @test isequal_interval(^(interval(-1, 8), 1//3), interval(0, 2))
    @test issubset_interval(interval(0, 2), ^(interval(-2, 8), 1//3))
    @test issubset_interval(interval(0, 9^(1//3)), ^(interval(-1, 9), 1//3))
    @test issubset_interval(interval(0, 9^(1//3)), ^(interval(-2, 9), 1//3))
    @test isequal_interval(^(interval(1, 8), -1//3), interval(0.5, 1))
    @test issubset_interval(interval(0.5, 2^(-1//3)), ^(interval(2, 8), -1//3))
    @test issubset_interval(interval(9^(-1//3), 1), ^(interval(1, 9), -1//3))
    @test issubset_interval(interval(9^(-1//3), 2^(-1//3)), ^(interval(2, 9), -1//3))
    @test isequal_interval(^(interval(-1, 8), -1//3), interval(0.5, Inf))
    @test issubset_interval(interval(0.5, Inf), ^(interval(-2, 8), -1//3))
    @test issubset_interval(interval(9^(-1//3), Inf), ^(interval(-1, 9), -1//3))
    @test issubset_interval(interval(9^(-1//3), Inf), ^(interval(-2, 9), -1//3))
    @test isequal_interval(^(interval(-2, 4), 1//2), interval(0, 2))
    @test isequal_interval(^(interval(-2, 8), 1//3), interval(0, 2))
    @test isequal_interval(^(interval(-8, -2), 1//3), emptyinterval())
    @test isequal_interval(^(interval(-8, -2), 1//2), emptyinterval())
    @test isequal_interval(^(interval(-8, -2), -1//3), emptyinterval())
    @test isequal_interval(^(interval(-8, -2), -1//2), emptyinterval())
    @test isequal_interval(^(emptyinterval(), 2//3), emptyinterval())
    @test isequal_interval(^(interval(1, 8), 2//3), interval(1, 4))
    @test issubset_interval(interval(2^(2//3), 4), ^(interval(2, 8), 2//3))
    @test issubset_interval(interval(1, 9^(2//3)), ^(interval(1, 9), 2//3))
    @test issubset_interval(interval(2^(2//3), 9^(2//3)), ^(interval(2, 9), 2//3))
    @test isequal_interval(^(interval(-1, 8), 2//3), interval(0, 4))
    @test issubset_interval(interval(0, 4), ^(interval(-2, 8), 2//3))
    @test issubset_interval(interval(0, 9^(2//3)), ^(interval(-1, 9), 2//3))
    @test issubset_interval(interval(0, 9^(2//3)), ^(interval(-2, 9), 2//3))
    @test isequal_interval(^(interval(1, 8), -2//3), interval(0.25, 1))
    @test issubset_interval(interval(0.25, 2^(-2//3)), ^(interval(2, 8), -2//3))
    @test issubset_interval(interval(9^(-2//3), 1), ^(interval(1, 9), -2//3))
    @test issubset_interval(interval(9^(-2//3), 2^(-2//3)), ^(interval(2, 9), -2//3))
    @test isequal_interval(^(interval(-1, 8), -2//3), interval(0.25, Inf))
    @test issubset_interval(interval(0.25, Inf), ^(interval(-2, 8), -2//3))
    @test issubset_interval(interval(9^(-2//3), Inf), ^(interval(-1, 9), -2//3))
    @test issubset_interval(interval(9^(-2//3), Inf), ^(interval(-2, 9), -2//3))
    @test isequal_interval(^(interval(-2, 4), 3//2), interval(0, 8))
    @test isequal_interval(^(interval(-2, 8), 2//3), interval(0, 4))
    @test isequal_interval(^(interval(-8, -2), 2//3), emptyinterval())
    @test isequal_interval(^(interval(-8, -2), 3//2), emptyinterval())
    @test isequal_interval(^(interval(-8, -2), -2//3), emptyinterval())
    @test isequal_interval(^(interval(-8, -2), -3//2), emptyinterval())
    @test isequal_interval(^(interval(-1, 1), 1000000000000000000000000000000000000000//1), interval(0, 1))
end

@testset "Interval{<:Rational}" begin
    a = interval(Rational{Int64}, 1//2, 3//4)
    b = interval(Rational{Int64}, 3//7, 9//12)

    @test isequal_interval(sqrt(a + b), interval(Int64(137482504)//142672337, Int64(46099201)//37639840))

    @test isequal_interval(sqrt(interval(1//3)), interval(Int64(29354524)//50843527, Int64(50843527)//88063572))
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

    @test isequal_interval(interval(2, 3)   ^  2, interval(4, 9))
    @test isequal_interval(interval(2, 3)   ^ -2, interval(1/9, 1/4))
    @test isequal_interval(interval(-3, 2)  ^  3, interval(-27, 8))
    @test isequal_interval(interval(-3, -2) ^ -3, interval(-1/8, -1/27))
    @test isequal_interval(interval(0, 3)   ^  2, interval(0, 9))
    @test isequal_interval(interval(0, 3)   ^ -2, interval(1/9, Inf, IntervalArithmetic.trv))
    @test isequal_interval(interval(2, 3)   ^ interval(0, 1), interval(1, 3))
    @test isequal_interval(interval(2, 3)   ^ interval(0, 1), interval(1, 3))
    @test isequal_interval(interval(0, 2)   ^ interval(0, 1), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(interval(0, 2)   ^ interval(0, 1), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(interval(-3, 2)  ^ interval(0, 1), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(interval(-3, 2)  ^ interval(0, 1), interval(0, 2, IntervalArithmetic.trv))
    @test isequal_interval(interval(-3, 2)  ^ interval(-1, 1), interval(0, Inf, IntervalArithmetic.trv))
    @test isequal_interval(interval(-3, 2)  ^ interval(-1, 1), interval(0, Inf, IntervalArithmetic.trv))
end

# @testset "Complex{<:Interval}" begin
#     a = interval(3 + 4im)
#     b = exp(a)
#     @test real(b) == interval(-13.12878308146216, -13.128783081462153)
#     @test imag(b) == interval(-15.200784463067956, -15.20078446306795)
# end
