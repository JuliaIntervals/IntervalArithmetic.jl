using IntervalArithmetic
using Test


setformat(:full)

# NB: Due to "world age" problems, do *not* wrap everything in another @testset
# The `setrounding` commands must be at top level

setrounding(Interval, :slow)
x = Interval(0.5)
@testset "Tight, slow rounding by changing rounding mode" begin
    @test rounding(Interval) == :slow
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setrounding(Interval, :accurate)
@testset "Accurate, fast rounding using prevfloat and nextfloat" begin
    @test rounding(Interval) == :accurate
    @test sin(x) == Interval(0.47942553860420295, 0.47942553860420306)
end

setrounding(Interval, :none)
@testset "No rounding" begin
    @test rounding(Interval) == :none
    @test sin(x) == Interval(0.479425538604203, 0.479425538604203)
    w = 0 ± big(1)
    @test isa(w+w, Interval)
end

setrounding(Interval, :tight)
@testset "Tight, fast rounding using FastRounding.jl" begin
    @test rounding(Interval) == :tight
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)
end

setrounding(Interval, :emulation)
@testset "Tight rounding using RoundingEmulator.jl" begin
    @test rounding(Interval) == :emulation
    @test sin(x) == Interval(0.47942553860420295, 0.479425538604203)

    # https://github.com/JuliaIntervals/IntervalArithmetic.jl/issues/215
    tiny = Interval(0, floatmin())
    huge = Interval(floatmax(), Inf)
    @test tiny * tiny == Interval(0, nextfloat(0.0))
    @test huge * huge == Interval(floatmax(), Inf)
    @test huge / tiny == Interval(floatmax(), Inf)
    @test tiny / huge == Interval(0, nextfloat(0.0))
end

setformat(:standard)

# end
# end
