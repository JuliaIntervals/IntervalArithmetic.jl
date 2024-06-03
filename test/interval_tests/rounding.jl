x = interval(0.5)

@testset "IntervalRounding{:fast}" begin
    IntervalArithmetic.interval_rounding() = IntervalArithmetic.IntervalRounding{:fast}()
    @test isequal_interval(sin(x), interval(0.47942553860420295, 0.47942553860420306))
    @test isequal_interval(x + x, interval(0.9999999999999999, 1.0000000000000002))
end

@testset "IntervalRounding{:tight}" begin
    IntervalArithmetic.interval_rounding() = IntervalArithmetic.IntervalRounding{:tight}()
    @test isequal_interval(sin(x), interval(0.47942553860420295, 0.479425538604203))

    # https://github.com/JuliaIntervals/IntervalArithmetic.jl/issues/215
    tiny = interval(0, floatmin())
    huge = interval(floatmax(), Inf)
    @test isequal_interval(tiny * tiny, interval(0, nextfloat(0.0)))
    @test isequal_interval(huge * huge, interval(floatmax(), Inf))
    @test isequal_interval(huge / tiny, interval(floatmax(), Inf))
    @test isequal_interval(tiny / huge, interval(0, nextfloat(0.0)))
end

@testset "IntervalRounding{:slow}" begin
    IntervalArithmetic.interval_rounding() = IntervalArithmetic.IntervalRounding{:slow}()
    @test isequal_interval(sin(x), interval(0.47942553860420295, 0.479425538604203))
end

@testset "No rounding" begin
    IntervalArithmetic.interval_rounding() = IntervalArithmetic.IntervalRounding{:none}()
    @test isequal_interval(sin(x), interval(0.479425538604203, 0.479425538604203))
end

IntervalArithmetic.interval_rounding() = IntervalArithmetic.IntervalRounding{:tight}()
