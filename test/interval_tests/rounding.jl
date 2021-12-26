using IntervalArithmetic
using Test

setformat(:full)

x = Interval(0.5)

@testset "IntervalRounding{:slow}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:slow}()
    @test sin(x) ≛ Interval(0.47942553860420295, 0.479425538604203)
end

@testset "IntervalRounding{:accurate}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:accurate}()
    @test sin(x) ≛ Interval(0.47942553860420295, 0.47942553860420306)
end

@testset "No rounding" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:none}()
    @test sin(x) ≛ Interval(0.479425538604203, 0.479425538604203)
end

@testset "IntervalRounding{:fast}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:fast}()
    @test sin(x) ≛ Interval(0.47942553860420295, 0.479425538604203)
end

@testset "IntervalRounding{:tight}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:tight}()
    @test sin(x) ≛ Interval(0.47942553860420295, 0.479425538604203)

    # https://github.com/JuliaIntervals/IntervalArithmetic.jl/issues/215
    tiny = Interval(0, floatmin())
    huge = Interval(floatmax(), Inf)
    @test tiny * tiny ≛ Interval(0, nextfloat(0.0))
    @test huge * huge ≛ Interval(floatmax(), Inf)
    @test huge / tiny ≛ Interval(floatmax(), Inf)
    @test tiny / huge ≛ Interval(0, nextfloat(0.0))
end

setformat(:standard)
IntervalArithmetic.interval_rounding() = IntervalRounding{:tight}()
