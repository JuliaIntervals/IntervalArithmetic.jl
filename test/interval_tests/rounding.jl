using IntervalArithmetic
using Base.Test


setformat(:full)

# @testset "Interval rounding" begin

# NB: Due to "world age" problems, the following is not a @testset

setrounding(Interval, :slow)
x = Interval(0.5)
@testset "Correct rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setrounding(Interval, :accurate)
@testset "Fast rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.47942553860420306)
end

setrounding(Interval, :none)
@testset "No rounding" begin
    @test sin(x) == Interval(0.479425538604203, 0.479425538604203)
end

setrounding(Interval, :slow)
@testset "Back to correct rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setrounding(Interval, :tight)
@testset "Back to error-free rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setformat(:standard)

# end
# end
