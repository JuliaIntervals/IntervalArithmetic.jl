using IntervalArithmetic
using Base.Test

# using Suppressor

setformat(:full)

# @suppress begin

# @testset "Interval rounding" begin

# NB: Due to "world age" problems, the following is not a @testset

setrounding(Interval, :correct)
x = Interval(0.5)
@testset "Correct rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setrounding(Interval, :fast)
@testset "Fast rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.47942553860420306)
end

setrounding(Interval, :none)
@testset "No rounding" begin
    @test sin(x) == Interval(0.479425538604203, 0.479425538604203)
end

setrounding(Interval, :correct)
@testset "Back to correct rounding" begin
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setformat(:standard)

# end
# end
