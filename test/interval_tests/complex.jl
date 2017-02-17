if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end
using ValidatedNumerics

@testset "Complex interval operations" begin
    a = @interval 1im
    @test typeof(a)== Complex{ValidatedNumerics.Interval{Float64}}
    @test a ==  Interval(0) + Interval(1)*im
    @test a * a == Interval(-1)
    @test a + a == Interval(2)*im
    @test a - a == 0
    @test a / a == 1
    @test a^2 == -1
end
