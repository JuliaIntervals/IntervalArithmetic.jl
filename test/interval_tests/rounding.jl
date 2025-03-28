x = interval(0.5)

@testset "IntervalRounding{:correct}" begin
    IntervalArithmetic.configure(rounding = :correct)
    @test isequal_interval(sin(x), interval(0.47942553860420295, 0.479425538604203))

    # https://github.com/JuliaIntervals/IntervalArithmetic.jl/issues/215
    tiny = interval(0, floatmin())
    huge = interval(floatmax(), Inf)
    @test isequal_interval(tiny * tiny, interval(0, nextfloat(0.0)))
    @test isequal_interval(huge * huge, interval(floatmax(), Inf))
    @test isequal_interval(huge / tiny, interval(floatmax(), Inf))
    @test isequal_interval(tiny / huge, interval(0, nextfloat(0.0)))
end

@testset "No rounding" begin
    IntervalArithmetic.configure(; rounding = :none)
    @test isequal_interval(sin(x), interval(0.479425538604203, 0.479425538604203))
end

# @testset "IntervalRounding{:fast}" begin
#     IntervalArithmetic.configure(rounding = :fast)
#     @test isequal_interval(interval(Float64, 0.5) + interval(Float64, 0.5), interval(0.9999999999999999, 1.0000000000000002))
#     @test isequal_interval(sqrt(interval(Float64, 9)), interval(2.9999999999999996, 3.0000000000000004))
# end

# @testset "IntervalRounding{:slow}" begin
#     IntervalArithmetic.default_rounding() = IntervalArithmetic.IntervalRounding{:slow}()
#     @test isequal_interval(sin(x), interval(0.47942553860420295, 0.479425538604203))
# end

IntervalArithmetic.configure(rounding = :correct)
