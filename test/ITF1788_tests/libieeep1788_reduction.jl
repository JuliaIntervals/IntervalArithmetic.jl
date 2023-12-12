@testset "minimal_sum_test" begin

    @test sum([1.0, 2.0, 3.0]) === 6.0

    @test isnan(sum([1.0, 2.0, NaN, 3.0]))

    @test isnan(sum([1.0, -Inf, 2.0, Inf, 3.0]))

end

@testset "minimal_sum_abs_test" begin

    @test sum(abs.([1.0, -2.0, 3.0])) === 6.0

    @test isnan(sum(abs.([1.0, -2.0, NaN, 3.0])))

    @test sum(abs.([1.0, -Inf, 2.0, Inf, 3.0])) === Inf

end

@testset "minimal_sum_sqr_test" begin

    @test sum([1.0, 2.0, 3.0].^2) === 14.0

    @test isnan(sum([1.0, 2.0, NaN, 3.0].^2))

    @test sum([1.0, -Inf, 2.0, Inf, 3.0].^2) === Inf

end

@testset "minimal_dot_test" begin

    @test sum(.*([1.0, 2.0, 3.0], [1.0, 2.0, 3.0])) === 14.0

    @test_broken sum(.*([0x10000000000001p0, 0x1p104], [0x0fffffffffffffp0, -1.0])) === -1.0

    @test isnan(sum(.*([1.0, 2.0, NaN, 3.0], [1.0, 2.0, 3.0, 4.0])))

    @test isnan(sum(.*([1.0, 2.0, 3.0, 4.0], [1.0, 2.0, NaN, 3.0])))

    @test isnan(sum(.*([1.0, 2.0, 0.0, 4.0], [1.0, 2.0, Inf, 3.0])))

    @test isnan(sum(.*([1.0, 2.0, -Inf, 4.0], [1.0, 2.0, 0.0, 3.0])))

end
