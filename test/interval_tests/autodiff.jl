import ForwardDiff

@testset "BareInterval" begin
    @testset "abs" begin
        @test_throws MethodError ForwardDiff.derivative(abs, bareinterval(-1, 1))
    end
end

@testset "Interval" begin
    @testset "abs" begin
        @test ForwardDiff.derivative(abs, interval(-2, -1)) === interval(-1, -1, com)
        @test ForwardDiff.derivative(abs, interval( 1,  2)) === interval( 1,  1, com)
        @test ForwardDiff.derivative(abs, interval(   0  )) === interval(   0  , trv)
        @test ForwardDiff.derivative(abs, interval(-1,  0)) === interval(-1,  0, trv)
        @test ForwardDiff.derivative(abs, interval( 0,  1)) === interval( 0,  1, trv)
        @test ForwardDiff.derivative(abs, interval(-2,  2)) === interval(-1,  1, trv)

        f(x) = abs(x)^interval(2)
        @test_broken ForwardDiff.derivative(f, interval(-1, 1)) === interval(-2,  2, trv)

        g(x) = abs(x)^2
        @test     ForwardDiff.derivative(g,             interval(-1, 1) )  ===  interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)
        @test all(ForwardDiff.gradient(  v -> g(v[1]), [interval(-1, 1)]) .=== [interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)])
        @test_broken all(ForwardDiff.hessian(   v -> g(v[1]), [interval(  0  )]) .=== [interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)])
    end
end
