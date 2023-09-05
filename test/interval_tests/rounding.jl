using Test
using IntervalArithmetic

x = interval(0.5)

@testset "IntervalRounding{:slow}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:slow}()
    @test equal(sin(x), interval(0.47942553860420295, 0.479425538604203))
end

@testset "IntervalRounding{:accurate}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:accurate}()
    @test equal(sin(x), interval(0.47942553860420295, 0.47942553860420306))
end

@testset "No rounding" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:none}()
    @test equal(sin(x), interval(0.479425538604203, 0.479425538604203))
end

@testset "IntervalRounding{:fast}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:fast}()
    @test equal(sin(x), interval(0.47942553860420295, 0.479425538604203))
end

@testset "IntervalRounding{:tight}" begin
    IntervalArithmetic.interval_rounding() = IntervalRounding{:tight}()
    @test equal(sin(x), interval(0.47942553860420295, 0.479425538604203))

    # https://github.com/JuliaIntervals/IntervalArithmetic.jl/issues/215
    tiny = interval(0, floatmin())
    huge = interval(floatmax(), Inf)
    @test equal(tiny * tiny, interval(0, nextfloat(0.0)))
    @test equal(huge * huge, interval(floatmax(), Inf))
    @test equal(huge / tiny, interval(floatmax(), Inf))
    @test equal(tiny / huge, interval(0, nextfloat(0.0)))
end

setformat(:standard)
IntervalArithmetic.interval_rounding() = IntervalRounding{:tight}()
