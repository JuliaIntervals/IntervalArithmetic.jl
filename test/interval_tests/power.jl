using Test
using IntervalArithmetic

@testset "rational_power_test" begin
    @test ^(∅, 1//3) == ∅
    @test ^(1 .. 8, 1//3) == interval(1, 2)
    @test ^(2 .. 8, 1//3) ⊇  interval(2^(1//3), 2)
    @test ^(1 .. 9, 1//3) ⊇  interval(1, 9^(1//3))
    @test ^(2 .. 9, 1//3) ⊇  interval(2^(1//3), 9^(1//3))
    @test ^(-1 .. 8, 1//3) == interval(0, 2)
    @test ^(-2 .. 8, 1//3) ⊇  interval(0, 2)
    @test ^(-1 .. 9, 1//3) ⊇  interval(0, 9^(1//3))
    @test ^(-2 .. 9, 1//3) ⊇  interval(0, 9^(1//3))
    @test ^(1 .. 8, -1//3) == interval(0.5, 1)
    @test ^(2 .. 8, -1//3) ⊇  interval(0.5, 2^(-1//3))
    @test ^(1 .. 9, -1//3) ⊇  interval(9^(-1//3), 1)
    @test ^(2 .. 9, -1//3) ⊇  interval(9^(-1//3), 2^(-1//3))
    @test ^(-1 .. 8, -1//3) == interval(0.5, Inf)
    @test ^(-2 .. 8, -1//3) ⊇  interval(0.5, Inf)
    @test ^(-1 .. 9, -1//3) ⊇  interval(9^(-1//3), Inf)
    @test ^(-2 .. 9, -1//3) ⊇  interval(9^(-1//3), Inf)
    @test ^(-2 .. 4 , 1//2) == interval(0, 2)
    @test ^(-2 .. 8 , 1//3) == interval(0, 2)
    @test ^(-8 .. -2 , 1//3) == ∅
    @test ^(-8 .. -2 , 1//2) == ∅
    @test ^(-8 .. -2 , -1//3) == ∅
    @test ^(-8 .. -2 , -1//2) == ∅
    @test ^(∅, 2//3) == ∅
    @test ^(1 .. 8, 2//3) == interval(1, 4)
    @test ^(2 .. 8, 2//3) ⊇  interval(2^(2//3), 4)
    @test ^(1 .. 9, 2//3) ⊇  interval(1, 9^(2//3))
    @test ^(2 .. 9, 2//3) ⊇  interval(2^(2//3), 9^(2//3))
    @test ^(-1 .. 8, 2//3) == interval(0, 4)
    @test ^(-2 .. 8, 2//3) ⊇  interval(0, 4)
    @test ^(-1 .. 9, 2//3) ⊇  interval(0, 9^(2//3))
    @test ^(-2 .. 9, 2//3) ⊇  interval(0, 9^(2//3))
    @test ^(1 .. 8, -2//3) == interval(0.25, 1)
    @test ^(2 .. 8, -2//3) ⊇  interval(0.25, 2^(-2//3))
    @test ^(1 .. 9, -2//3) ⊇  interval(9^(-2//3), 1)
    @test ^(2 .. 9, -2//3) ⊇  interval(9^(-2//3), 2^(-2//3))
    @test ^(-1 .. 8, -2//3) == interval(0.25, Inf)
    @test ^(-2 .. 8, -2//3) ⊇  interval(0.25, Inf)
    @test ^(-1 .. 9, -2//3) ⊇  interval(9^(-2//3), Inf)
    @test ^(-2 .. 9, -2//3) ⊇  interval(9^(-2//3), Inf)
    @test ^(-2 .. 4 , 3//2) == interval(0, 8)
    @test ^(-2 .. 8 , 2//3) == interval(0, 4)
    @test ^(-8 .. -2 , 2//3) == ∅
    @test ^(-8 .. -2 , 3//2) == ∅
    @test ^(-8 .. -2 , -2//3) == ∅
    @test ^(-8 .. -2 , -3//2) == ∅
    @test ^(-1..1, 1000000000000000000000000000000000000000//1) == interval(0, 1)
end
