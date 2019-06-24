#Test library imports
using Test

#Arithmetic library imports
using IntervalArithmetic

#Preamble
setprecision(53)
setprecision(Interval, Float64)
setrounding(Interval, :tight)
# Set full format, and show decorations
@format full
@testset "rational_power_test" begin
        @test ^(∅, 1//3) == ∅
        @test ^(1 .. 8, 1//3) == Interval(1, 2)
        @test ^(2 .. 8, 1//3) ⊇  Interval(2^(1//3), 2)
        @test ^(1 .. 9, 1//3) ⊇  Interval(1, 9^(1//3))
        @test ^(2 .. 9, 1//3) ⊇  Interval(2^(1//3), 9^(1//3))
        @test ^(-1 .. 8, 1//3) == Interval(0, 2)
        @test ^(-2 .. 8, 1//3) ⊇  Interval(0, 2)
        @test ^(-1 .. 9, 1//3) ⊇  Interval(0, 9^(1//3))
        @test ^(-2 .. 9, 1//3) ⊇  Interval(0, 9^(1//3))
        @test ^(1 .. 8, -1//3) == Interval(0.5, 1)
        @test ^(2 .. 8, -1//3) ⊇  Interval(0.5, 2^(-1//3))
        @test ^(1 .. 9, -1//3) ⊇  Interval(9^(-1//3), 1)
        @test ^(2 .. 9, -1//3) ⊇  Interval(9^(-1//3), 2^(-1//3))
        @test ^(-1 .. 8, -1//3) == Interval(0.5, Inf)
        @test ^(-2 .. 8, -1//3) ⊇  Interval(0.5, Inf)
        @test ^(-1 .. 9, -1//3) ⊇  Interval(9^(-1//3), Inf)
        @test ^(-2 .. 9, -1//3) ⊇  Interval(9^(-1//3), Inf)
        @test ^(-2 .. 4 , 1//2) == Interval(0, 2)
        @test ^(-2 .. 8 , 1//3) == Interval(0, 2)
        @test ^(-8 .. -2 , 1//3) == ∅
        @test ^(-8 .. -2 , 1//2) == ∅
        @test ^(-8 .. -2 , -1//3) == ∅
        @test ^(-8 .. -2 , -1//2) == ∅
        @test ^(∅, 2//3) == ∅
        @test ^(1 .. 8, 2//3) == Interval(1, 4)
        @test ^(2 .. 8, 2//3) ⊇  Interval(2^(2//3), 4)
        @test ^(1 .. 9, 2//3) ⊇  Interval(1, 9^(2//3))
        @test ^(2 .. 9, 2//3) ⊇  Interval(2^(2//3), 9^(2//3))
        @test ^(-1 .. 8, 2//3) == Interval(0, 4)
        @test ^(-2 .. 8, 2//3) ⊇  Interval(0, 4)
        @test ^(-1 .. 9, 2//3) ⊇  Interval(0, 9^(2//3))
        @test ^(-2 .. 9, 2//3) ⊇  Interval(0, 9^(2//3))
        @test ^(1 .. 8, -2//3) == Interval(0.25, 1)
        @test ^(2 .. 8, -2//3) ⊇  Interval(0.25, 2^(-2//3))
        @test ^(1 .. 9, -2//3) ⊇  Interval(9^(-2//3), 1)
        @test ^(2 .. 9, -2//3) ⊇  Interval(9^(-2//3), 2^(-2//3))
        @test ^(-1 .. 8, -2//3) == Interval(0.25, Inf)
        @test ^(-2 .. 8, -2//3) ⊇  Interval(0.25, Inf)
        @test ^(-1 .. 9, -2//3) ⊇  Interval(9^(-2//3), Inf)
        @test ^(-2 .. 9, -2//3) ⊇  Interval(9^(-2//3), Inf)
        @test ^(-2 .. 4 , 3//2) == Interval(0, 8)
        @test ^(-2 .. 8 , 2//3) == Interval(0, 4)
        @test ^(-8 .. -2 , 2//3) == ∅
        @test ^(-8 .. -2 , 3//2) == ∅
        @test ^(-8 .. -2 , -2//3) == ∅
        @test ^(-8 .. -2 , -3//2) == ∅
end
