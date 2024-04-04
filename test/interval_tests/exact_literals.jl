@testset "Exact literals" begin
    x = @exact_input 0.5
    @test (2 * x) isa Float64
    Y = interval(2) * x
    @test isguaranteed(Y)
    @test in_interval(1, Y)

    @exact_input function f(x)
       return x^2 - 2x + 1
    end

    Z = f(interval(1))
    @test f(1.22) isa Real
    @test isguaranteed(Z)
    @test in_interval(0, Z)

    @test_throws MethodError convert(ExactReal{Float64}, 2)

    @test has_exact_display(0.5)
    @test !has_exact_display(0.1)
end
