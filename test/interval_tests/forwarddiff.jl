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
        @test ForwardDiff.derivative(f, interval(-1, 1)) === interval(-2,  2, trv)

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
        @test        ψ′(0)   === dψ(0)   && !isguaranteed(ψ′(0))
        @test_broken ψ′′(0)  === ddψ(0)  && !isguaranteed(ψ′′(0)) # rely on `Interval{T}(::Real)` being defined
        @test_broken ψ′′′(0) === dddψ(0) && !isguaranteed(ψ′′′(0)) # rely on `Interval{T}(::Real)` being defined
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

    @testset "min" begin
        @test isequal_interval(ForwardDiff.derivative(x->min(x, 1.5), interval(1, 2)), interval(0, 1))
        @test isequal_interval(ForwardDiff.derivative(x->min(x, 1.5), interval(1.75, 2)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(x->min(x, 1.5), interval(0.5, 0.75)), interval(1))
        @test isequal_interval(ForwardDiff.derivative(x->min(x, 1.5), interval(1, 2)), ForwardDiff.derivative(x->min(1.5, x), interval(1, 2)))

        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(x, 1.5), y), interval(1, 2)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(x, 1.5)^2, y), interval(1, 2)), interval(0, 2))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(x, 1.5)^3, y), interval(1, 2)), interval(0, 9))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(x, 3.0)^3, y), interval(1, 2)), interval(6, 12))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(x, 3.0)^3, y), interval(4, 5)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(x, 1.5)^3, y), interval(1, 2)), ForwardDiff.derivative(y->ForwardDiff.derivative(x->min(1.5, x)^3, y), interval(1, 2)))
    end

    @testset "max" begin
        @test isequal_interval(ForwardDiff.derivative(x->max(x, 1.5), interval(1, 2)), interval(0, 1))
        @test isequal_interval(ForwardDiff.derivative(x->max(x, 1.5), interval(1.75, 2)), interval(1))
        @test isequal_interval(ForwardDiff.derivative(x->max(x, 1.5), interval(0.5, 0.75)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(x->max(x, 1.5), interval(1, 2)), ForwardDiff.derivative(x->max(1.5, x), interval(1, 2)))

        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(x, 1.5), y), interval(1, 2)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(x, 1.5)^2, y), interval(1, 2)), interval(0, 2))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(x, 1.5)^3, y), interval(1, 2)), interval(0, 12))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(x, 3.0)^3, y), interval(1, 2)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(x, 3.0)^3, y), interval(4, 5)), interval(24, 30))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(x, 1.5)^3, y), interval(1, 2)), ForwardDiff.derivative(y->ForwardDiff.derivative(x->max(1.5, x)^3, y), interval(1, 2)))
    end

    @testset "clamp" begin
        @test isequal_interval(ForwardDiff.derivative(x->clamp(x, 1.5, 2.5), interval(1, 2)), interval(0, 1))
        @test isequal_interval(ForwardDiff.derivative(x->clamp(x, 1.5, 2.5), interval(2, 3)), interval(0, 1))
        @test isequal_interval(ForwardDiff.derivative(x->clamp(x, 1.5, 2.5), interval(1.75, 2)), interval(1))
        @test isequal_interval(ForwardDiff.derivative(x->clamp(x, 1.5, 2.5), interval(2.75, 3)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(x->clamp(x, 1.5, 2.5), interval(0.75, 1)), interval(0))

        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5), y), interval(1, 2)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5)^2, y), interval(1, 2)), interval(0, 2))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5)^3, y), interval(1, 2)), interval(0, 12))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5)^3, y), interval(2, 3)), interval(0, 15))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5)^3, y), interval(3, 4)), interval(0))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5)^3, y), interval(1.75, 2)), interval(6*1.75, 12))
        @test isequal_interval(ForwardDiff.derivative(y->ForwardDiff.derivative(x->clamp(x, 1.5, 2.5)^3, y), interval(0, 1)), interval(0))
    end
end