@testset "Exact literals" begin
    x = @exact_literals 0.5
    @test (2 * x) isa Float64
    Y = interval(2) * x
    @test isguaranteed(Y)
    @test in_interval(1, Y)

    @exact_literals function f(x)
        sqrt(2) * (x^2 - 2x + 1)
    end

    Z = f(interval(1))
    @test_broken f(1) isa Float64
    @test isguaranteed(Z)
    @test in_interval(0, Z)


    @test_throws ArgumentError convert(ExactReal{Float64}, 2)
end