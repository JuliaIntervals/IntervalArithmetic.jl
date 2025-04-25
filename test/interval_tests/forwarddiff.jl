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
        @test ForwardDiff.derivative(abs, interval(   0  )) === interval(-1,  1, trv)
        @test ForwardDiff.derivative(abs, interval(-1,  0)) === interval(-1,  0, trv)
        @test ForwardDiff.derivative(abs, interval( 0,  1)) === interval( 0,  1, trv)
        @test ForwardDiff.derivative(abs, interval(-2,  2)) === interval(-1,  1, trv)

        f(x) = abs(x)^interval(2)
        @test ForwardDiff.derivative(f, interval(-1, 1)) === interval(-2,  2, trv)

        g(x) = abs(x)^2
        @test     ForwardDiff.derivative(g,             interval(-1, 1) )  ===  interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)
        @test all(ForwardDiff.gradient(  v -> g(v[1]), [interval(-1, 1)]) .=== [interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)])
        @test all(ForwardDiff.hessian(   v -> g(v[1]), [interval(  0  )]) .=== [interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)])
        @test all(ForwardDiff.hessian(   v -> g(v[1]), [interval(-1, 1)]) .=== [interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)])
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
        @test ψ′′(0)  === ddψ(0)  && !isguaranteed(ψ′′(0))
        @test ψ′′′(0) === dddψ(0) && !isguaranteed(ψ′′′(0))
        t₀ = interval(0)
        @test ψ′(t₀)   === dψ(t₀)   && isguaranteed(ψ′(t₀))
        @test ψ′′(t₀)  === ddψ(t₀)  && isguaranteed(ψ′′(t₀))
        @test ψ′′′(t₀) === dddψ(t₀) && isguaranteed(ψ′′′(t₀))
    end

    @testset "Power" begin
        fxy(xy) = xy[1]^xy[2]

        for x in [0.0, 1.1, 2.2]
            for y in [-3.3, 0.0, 4.4]
                fx(xx) = xx^y
                fxi(xx) = xx^interval(y)
                fy(yy) = x^yy
                fyi(yy) = interval(x)^yy

                dfdx = ForwardDiff.derivative(fxi, interval(x))
                dfdy = ForwardDiff.derivative(fyi, interval(y))
                grad = ForwardDiff.gradient(fxy, [interval(x), interval(y)])

                @test isguaranteed(dfdx)
                @test isguaranteed(dfdy)
                @test isguaranteed(grad[1])
                @test isguaranteed(grad[2])

                if iszero(x) && y < 0
                    @test decoration(dfdx) == trv
                else
                    @test in_interval(ForwardDiff.derivative(fx, x), dfdx)
                end

                if iszero(x) && y <= 0
                    @test decoration(dfdy) == trv
                else
                    @test in_interval(ForwardDiff.derivative(fy, y), dfdy)
                end

                if iszero(x) && iszero(y)
                    @test decoration(grad[1]) == trv
                    @test decoration(dfdx) == com
                else
                    @test isequal_interval(dfdx, grad[1])
                end
                @test isequal_interval(dfdy, grad[2])
            end
        end
    end

    @testset "ExactReal" begin
        @exact f(x) = x^2 - 2
        @test isguaranteed(ForwardDiff.derivative(f, interval(1)))

        @exact g(x) = 2^x + 6sin(x^3) - 33
        @test isguaranteed(ForwardDiff.derivative(f, interval(1)))
    end
end
