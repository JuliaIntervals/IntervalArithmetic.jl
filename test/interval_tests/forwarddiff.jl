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

    @testset "sin" begin
        x, w = interval(2), interval(-0.5, 0.5)
        ϕ(t)    =  sin(x + (1+t)*w)
        ϕ′(t)   =  cos(x + (1+t)*w) * w
        ϕ′′(t)  = -sin(x + (1+t)*w) * w * w
        ϕ′′′(t) = -cos(x + (1+t)*w) * w * w * w
        dϕ(t)   = ForwardDiff.derivative(ϕ, t)
        ddϕ(t)  = ForwardDiff.derivative(dϕ, t)
        dddϕ(t) = ForwardDiff.derivative(ddϕ, t)

        @test ϕ′(0)   === dϕ(0)
        @test ϕ′′(0)  === ddϕ(0)
        @test ϕ′′′(0) === dddϕ(0)

        y = interval(1)
        ψ(t)    =  sin(x + (y+t)*w)
        ψ′(t)   =  cos(x + (y+t)*w) * w
        ψ′′(t)  = -sin(x + (y+t)*w) * w * w
        ψ′′′(t) = -cos(x + (y+t)*w) * w * w * w
        dψ(t)   = ForwardDiff.derivative(ψ, t)
        ddψ(t)  = ForwardDiff.derivative(dψ, t)
        dddψ(t) = ForwardDiff.derivative(ddψ, t)
        @test ψ′(0)   === dψ(0)   && !isguaranteed(ψ′(0))
        @test_broken ψ′′(0)  === ddψ(0)  && !isguaranteed(ψ′′(0)) # rely on `Interval{T}(::Real)` being defined
        @test_broken ψ′′′(0) === dddψ(0) && !isguaranteed(ψ′′′(0)) # rely on `Interval{T}(::Real)` being defined
        t₀ = interval(0)
        @test ψ′(t₀)   === dψ(t₀)   && isguaranteed(ψ′(t₀))
        @test ψ′′(t₀)  === ddψ(t₀)  && isguaranteed(ψ′′(t₀))
        @test ψ′′′(t₀) === dddψ(t₀) && isguaranteed(ψ′′′(t₀))
    end

    @testset "Power" begin
        f(x)  = interval(2)^x
        f′(x) = log(interval(2)) * f(x)
        df(t) = ForwardDiff.derivative(f, t)

        # g(x) = 2^x # not guaranteed

        @test_broken f′(0) === df(0)
    end
end
