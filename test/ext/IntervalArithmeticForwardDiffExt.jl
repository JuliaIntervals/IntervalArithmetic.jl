using Test
using IntervalArithmetic
using ForwardDiff
using ForwardDiff: Dual, Partials, Tag, value, partials, npartials

@testset "Dual and ExactReal" begin
    @test ForwardDiff.can_dual(ExactReal)
    d = Dual{Nothing}(exact(2.0))
    @test value(d) === exact(2.0)
    @test npartials(d) == 0
    @test Dual(exact(2.0)) === d
    @test Dual{Nothing,Interval{Float64},1}(exact(2.0)) === Dual{Nothing}(interval(2.0), interval(0.0))
    @test convert(Dual{Nothing,Float64,1}, exact(2.0)) === Dual{Nothing}(2.0, 0.0)
    c = convert(Dual{Nothing,Interval{Float64},2}, exact(2.0))
    @test npartials(c) == 2
    @test value(c) === interval(2.0)
    @test all(isthinzero, partials(c))
end

@testset "Promotion rules" begin
    @test promote_type(Dual{Nothing,Float64,1}, Interval{Float64}) === Dual{Nothing,Interval{Float64},1}
    @test promote_type(Interval{Float64}, Dual{Nothing,Float64,1}) === Dual{Nothing,Interval{Float64},1}
    @test promote_type(Dual{Nothing,Float64,1}, Interval{Float32}) === Dual{Nothing,Interval{Float64},1}
    @test promote_type(Interval{Float32}, Dual{Nothing,Float64,1}) === Dual{Nothing,Interval{Float64},1}
    @test promote_type(Dual{Nothing,Float64,1}, ExactReal{Float64}) === Dual{Nothing,ExactReal{Float64},1}
    @test promote_type(ExactReal{Float64}, Dual{Nothing,Float64,1}) === Dual{Nothing,ExactReal{Float64},1}
    @test (Dual{Nothing}(1.0, 1.0) + interval(1, 2)) isa Dual{Nothing,Interval{Float64},1}
end

@testset "Comparisons" begin
    d = Dual{Nothing}(interval(2), interval(0))
    @test interval(2) == d
    @test d == interval(2)
    @test !(interval(3) == d)
    @test !(d == interval(3))
    @test_throws IntervalArithmetic.InconclusiveBooleanOperation interval(1, 2) == Dual{Nothing}(interval(1, 2), interval(0))
    @test interval(1, 2) < Dual{Nothing}(interval(3, 4), interval(0))
    @test !(Dual{Nothing}(interval(3, 4), interval(0)) < interval(1, 2))
end

@testset "Power of interval Duals" begin
    d = ForwardDiff.derivative(x -> x^x, interval(2.0))
    @test isequal_interval(d, interval(6.772588722239781, 6.772588722239782))
    @test in_interval(4 * (1 + log(2)), d)
    @test isguaranteed(d)

    x = Dual{Nothing}(interval(2.0), interval(1.0))
    y0 = Dual{Nothing}(interval(3.0), interval(0.0))
    z = x^y0
    @test isequal_interval(value(z), interval(8)) & isequal_interval(partials(z, 1), interval(12))

    x0 = Dual{Nothing}(interval(0.0), interval(1.0))
    y1 = Dual{Nothing}(interval(3.0), interval(1.0))
    z = x0^y1
    @test isequal_interval(value(z), interval(0)) & isequal_interval(partials(z, 1), interval(0))
    @test !isnai(partials(z, 1))

    z = x^y1
    @test isequal_interval(value(z), interval(8))
    @test in_interval(12 + 8 * log(2), partials(z, 1))

    xneg = Dual{Nothing}(interval(-2.0), interval(1.0))
    z = xneg^y1
    @test isequal_interval(value(z), interval(-8))
    @test decoration(partials(z, 1)) === trv

    @test isequal_interval(ForwardDiff.derivative(x -> x^interval(3.0), interval(2.0)), interval(12.0))
    @test isequal_interval(ForwardDiff.derivative(x -> x^interval(0.0), interval(2.0)), interval(0.0))
    zt = Dual{Nothing}(interval(2.0), interval(0.0))^interval(3.0)
    @test isequal_interval(partials(zt, 1), interval(0))

    d = ForwardDiff.derivative(x -> interval(2.0)^x, interval(3.0))
    @test in_interval(8 * log(2), d)

    d = ForwardDiff.derivative(x -> x^1e-20, interval(2.0))
    @test in_interval(setprecision(() -> big(1e-20) * big(2.0)^(big(1e-20) - 1), BigFloat, 4000), d)
    t = setprecision(() -> big(1) / 3, BigFloat, 512)
    d = ForwardDiff.derivative(x -> x^t, setprecision(() -> interval(BigFloat, 2), BigFloat, 512))
    @test in_interval(setprecision(() -> BigFloat(t; precision = 4000) * big(2.0)^(BigFloat(t; precision = 4000) - 1), BigFloat, 4000), d)
    @test isequal_interval(ForwardDiff.derivative(x -> x^3, interval(-2.0)), interval(12.0))
    @test isequal_interval(ForwardDiff.derivative(x -> x^2.0, interval(-2.0)), interval(-4.0))
    for T ∈ (Float16, Float32)
        x = Dual(interval(T, 2), interval(T, 1))
        @test x^T(0.5) isa Dual{Nothing,Interval{T},1}
        @test x^π isa Dual{Nothing,Interval{T},1}
        @test in_interval(setprecision(() -> big(T(0.1)) * big(2.0)^(big(T(0.1)) - 1), BigFloat, 4000), partials(x^T(0.1))[1])
    end
    @test ForwardDiff.gradient(v -> v[1]^0.5f0, [interval(Float32, 2)]) isa Vector{Interval{Float32}}
    @test ForwardDiff.derivative(x -> ForwardDiff.derivative(z -> z^0.5f0, x), interval(Float32, 2)) isa Interval{Float32}
    @test Dual(interval(Float32, 2), interval(Float32, 1))^interval(Float32, 0.5) isa Dual{Nothing,Interval{Float32},1}
    @test isequal_interval(value(Dual(interval(1e300), interval(1.0))^big(2.0)), interval(1e300)^big(2.0))
    @test value(Dual(interval(Float32, 2), interval(Float32, 1))^2.0) === interval(Float32, 2)^2.0
    d = ForwardDiff.derivative(x -> ForwardDiff.derivative(z -> z^1e-20, x), interval(2.0))
    @test in_interval(setprecision(() -> big(1e-20) * (big(1e-20) - 1) * big(2.0)^(big(1e-20) - 2), BigFloat, 4000), d)
    d = ForwardDiff.derivative(x -> ForwardDiff.derivative(z -> z^exact(1e-20), x), interval(2.0))
    @test in_interval(setprecision(() -> big(1e-20) * (big(1e-20) - 1) * big(2.0)^(big(1e-20) - 2), BigFloat, 4000), d)
    @test isguaranteed(d)
    @test isequal_interval(ForwardDiff.derivative(x -> interval(0.0)^x, interval(3.0)), interval(0.0))

    # mixed second derivative through closures, where the two duals have different tags
    t = 4 * (3 * log(big(2)) + 1)
    @test in_interval(t, ForwardDiff.derivative(x -> ForwardDiff.derivative(y -> x^y, interval(3.0)), interval(2.0)))
    @test in_interval(t, ForwardDiff.derivative(y -> ForwardDiff.derivative(x -> x^y, interval(2.0)), interval(3.0)))
    # higher derivatives when a partial or the base contains zero without being thin
    d2(f, x) = ForwardDiff.derivative(z -> ForwardDiff.derivative(f, z), x)
    @test in_interval(d2(x -> x^((x - big(31) / 10)^2), big(31) / 10), d2(x -> x^((x - 3.1)^2), interval(3.0, 3.2)))
    @test d2(x -> interval(0.0, 1.0)^x, interval(3.0)) isa Interval
    @test isguaranteed(d2(x -> x^x, interval(2.0)))
    @test isguaranteed(d2(x -> exact(2.0)^x, interval(3.0)))
end

@testset "Power with different tags" begin
    TA = typeof(Tag(x -> x, Interval{Float64}))
    TB = typeof(Tag(x -> 2x, Interval{Float64}))
    @test ForwardDiff.:≺(TA, TB) & !ForwardDiff.:≺(TB, TA)
    x = Dual{TA}(interval(2.0), interval(1.0))
    y = Dual{TB}(interval(3.0), interval(1.0))
    z = x^y
    @test z isa Dual{TB}
    @test isequal_interval(value(value(z)), interval(8))
    @test in_interval(8 * log(2), value(partials(z, 1)))
    z = y^x
    @test z isa Dual{TB}
    @test isequal_interval(value(value(z)), interval(9)) & isequal_interval(value(partials(z, 1)), interval(6))
    # as in ForwardDiff, the dual with the lower tag is kept inside the result
    dd = ForwardDiff.derivative(y -> ForwardDiff.derivative(t -> t^y, interval(2.0)), interval(3.0))
    @test in_interval(4 * (3 * log(big(2)) + 1), dd)
    @test ForwardDiff.derivative(y -> ForwardDiff.derivative(t -> t^y, 2.0), 3.0) ≈ 4 * (3 * log(2) + 1)
end

@testset "Power and ExactReal" begin
    @test isequal_interval(ForwardDiff.derivative(x -> x^exact(3), interval(2.0)), interval(12.0))
    @test in_interval(8 * log(2), ForwardDiff.derivative(x -> exact(2)^x, interval(3.0)))
    @test ForwardDiff.derivative(x -> x^exact(3), 2.0) == 12.0
    @test ForwardDiff.derivative(x -> exact(2)^x, 3.0) ≈ 5.545177444479562
    @test ForwardDiff.derivative(x -> x^exact(0), 2.0) == 0.0
    @test partials(Dual{Nothing}(2.0, 0.0)^exact(3), 1) == 0.0
    @test ForwardDiff.derivative(x -> exact(0)^x, 3.0) == 0.0
end

@testset "Legacy power grid" begin
    fxy(xy) = xy[1]^xy[2]

    for x ∈ [0.0, 1.1, 2.2]
        for y ∈ [-3.3, 0.0, 4.4]
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

@testset "ExactReal" begin
    @exact f(x) = x^2 - 2
    @test isguaranteed(ForwardDiff.derivative(f, interval(1)))

    @exact g(x) = 2^x + 6sin(x^3) - 33
    @test isguaranteed(ForwardDiff.derivative(g, interval(1)))
end

@testset "constant piece on Dual" begin
    # `@exact Returns(value)` returns a real, which the `Piecewise` `Dual` method
    # normalises to that value with vanishing partials
    c = @exact Returns(1.2)
    p = Piecewise(Domain{:closed,:closed}(0, 1) => c, Domain{:open,:closed}(1, 2) => identity)

    d = p(Dual{Nothing}(interval(0.2, 0.8), interval(1.0)))
    @test d isa Dual{Nothing,Interval{Float64},1}
    @test isequal_interval(value(d), interval(1.2))
    @test decoration(value(d)) === com && isguaranteed(value(d))
    @test isthinzero(partials(d, 1))

    @test isequal_interval(ForwardDiff.derivative(p, interval(0.2, 0.8)), interval(0.0))
    @test isguaranteed(ForwardDiff.derivative(p, interval(0.2, 0.8)))

    # spanning the junction: the constant and identity pieces are hulled
    dspan = ForwardDiff.derivative(p, interval(0.5, 1.5))
    @test isequal_interval(dspan, interval(0, 1))
    @test decoration(dspan) === def

    p32 = Piecewise(Domain{:closed,:closed}(0, 1) => c, Domain{:open,:closed}(1, 2) => identity)
    @test p32(Dual{Nothing}(interval(Float32, 0.2, 0.8), interval(Float32, 1.0))) isa Dual{Nothing,Interval{Float32},1}
    @test npartials(p(Dual{Nothing}(interval(0.2, 0.8), interval(1.0), interval(3.0)))) == 2
end

@testset "Piecewise on Dual" begin
    myabs = Piecewise(Domain{:open,:closed}(-Inf, 0) => (x -> -x), Domain{:open,:open}(0, Inf) => identity)
    @test ForwardDiff.derivative(myabs, interval(1, 2)) === interval(1, 1, com)
    @test ForwardDiff.derivative(myabs, interval(-5, -1)) === interval(-1, -1, com)
    @test ForwardDiff.derivative(myabs, interval(-5, 5)) === interval(-1, 1, def)

    d = myabs(Dual{Nothing}(interval(-5, 5), interval(1.0)))
    @test isequal_interval(value(d), interval(0, 5))
    @test decoration(value(d)) === def
    @test isequal_interval(partials(d, 1), interval(-1, 1))
    @test decoration(partials(d, 1)) === def

    g = ForwardDiff.gradient(v -> myabs(v[1]) + v[2], [interval(1.0), interval(2.0)])
    @test length(g) == 2
    @test isequal_interval(g[1], interval(1)) & isequal_interval(g[2], interval(1))

    p = Piecewise(Domain{:closed,:closed}(0, 1) => (@exact Returns(1.0)), Domain{:open,:closed}(1, 2) => identity)
    d = p(Dual{Nothing}(interval(-1.0, 0.5), interval(1.0)))
    @test isequal_interval(value(d), interval(1))
    @test decoration(value(d)) === trv
    @test isequal_interval(partials(d, 1), interval(0))
    @test decoration(partials(d, 1)) === trv
    # emptyinterval(X) .* partials(dual) is a Vector, not a Partials
    @test_throws ArgumentError ForwardDiff.derivative(p, interval(3, 4))
end

@testset "Piecewise derivatives" begin
    slide = Piecewise(
        Domain{:open,:closed}(-Inf, -1) => x -> -2x - 1,
        Domain{:open,:closed}(-1, 0) => x -> x^2,
        Domain{:open,:open}(0, Inf) => (@exact Returns(0));
        continuity = [1, 1]
    )

    @test ForwardDiff.derivative(slide, -5.5) == -2
    @test ForwardDiff.derivative(slide, -0.5) == -1
    @test ForwardDiff.derivative(slide, 1.2) == 0

    @test isequal_interval(ForwardDiff.derivative(slide, interval(-7, -3)), interval(-2))
    @test isequal_interval(ForwardDiff.derivative(slide, interval(-0.7, -0.3)), interval(-1.4, -0.6))
    @test isequal_interval(ForwardDiff.derivative(slide, interval(0.7, 1.3)), interval(0))
    @test isequal_interval(ForwardDiff.derivative(slide, interval(-1.7, -0.3)), interval(-2, -0.6))
    @test isequal_interval(ForwardDiff.derivative(slide, interval(-0.7, 1.3)), interval(-1.4, 0))
    @test isequal_interval(ForwardDiff.derivative(slide, interval(-1.7, 1.3)), interval(-2, 0))

    x1 = interval(-0.5, 0)
    x2 = interval(-3, -2)

    grad1 = ForwardDiff.gradient(xx -> slide(-xx[1]^2), [x1, x2])
    grad2 = ForwardDiff.gradient(xx -> slide(0.7xx[2]), [x1, x2])

    g1 = -2x1 * ForwardDiff.derivative(slide, -x1^2)
    g2 = 0.7 * ForwardDiff.derivative(slide, x2)

    @test isequal_interval(grad1[1], g1)
    @test isequal_interval(grad1[2], interval(0))
    @test isequal_interval(grad2[1], interval(0))
    @test isequal_interval(grad2[2], g2)

    grad = ForwardDiff.gradient(xx -> slide(-xx[1]^2 + 0.7xx[2]), [x1, x2])
    g1 = -2x1 * ForwardDiff.derivative(slide, -x1^2 + 0.7x2)
    g2 = 0.7 * ForwardDiff.derivative(slide, -x1^2 + 0.7x2)
    @test isequal_interval(grad[1], g1)
    @test isequal_interval(grad[2], g2)
end

@testset "Piecewise singularities" begin
    f = Piecewise(
        Domain{:open,:closed}(0, 1) => (@exact Returns(0)),
        Domain{:open,:closed}(1, 2) => x -> 0.5x,
        Domain{:open,:closed}(2, 3) => (@exact Returns(1)),
        Domain{:open,:open}(3, 4) => x -> (x-3)^2 + 1;
        continuity = [-1, 0, 1]
    )

    df = x -> ForwardDiff.derivative(f, x)
    @test decoration(df(interval(0.5, 1.5))) == def
    @test decoration(df(interval(1.5, 2.5))) == def
    @test decoration(df(interval(2.5, 3.5))) == com
end

@testset "_abs_deriv on Dual" begin
    d = ForwardDiff.DiffRules._abs_deriv(Dual{Nothing}(interval(1, 2), interval(1.0)))
    @test value(d) === interval(1, 1, com)
    @test isequal_interval(partials(d, 1), interval(0))
    d0 = ForwardDiff.DiffRules._abs_deriv(Dual{Nothing}(interval(-1, 1), interval(1.0)))
    @test value(d0) === interval(-1, 1, trv)
    @test isequal_interval(partials(d0, 1), interval(0))
    dd = ForwardDiff.derivative(t -> ForwardDiff.derivative(abs, t), interval(1, 2))
    @test isequal_interval(dd, interval(0))
    @test decoration(dd) === com
end

@testset "thick partials" begin
    # Differentiating by a real leaves interval-valued constants in the partials.
    x, w = 2.0, interval(-0.5, 0.5)

    # Test real, interval, and exact exponents.
    for n ∈ (4, 4.0, interval(4), exact(4))
        @test isequal_interval(ForwardDiff.derivative(t -> (x + t*w)^n, 0), interval(4x^3) * w)
        @test isequal_interval(ForwardDiff.derivative(t -> ForwardDiff.derivative(s -> (x + s*w)^n, t), 0),
                               interval(12x^2) * w * w)
    end

    # Each derivative order adds a `Dual` layer.
    ϕ(t)     = (x + t*w)^4
    dϕ(t)    = ForwardDiff.derivative(ϕ, t)
    ddϕ(t)   = ForwardDiff.derivative(dϕ, t)
    dddϕ(t)  = ForwardDiff.derivative(ddϕ, t)
    ddddϕ(t) = ForwardDiff.derivative(dddϕ, t)

    @test isequal_interval(dϕ(0)   , interval(4x^3) * w)
    @test isequal_interval(ddϕ(0)  , interval(12x^2) * w * w)
    @test isequal_interval(dddϕ(0) , interval(24x) * w * w * w)
    @test isequal_interval(ddddϕ(0), interval(24) * w * w * w * w)

    # Test multivariate first- and second-order derivatives.
    ψ(v) = (v[1]*w + v[2])^5
    @test all(isequal_interval.(ForwardDiff.gradient(ψ, [0, 1]), [interval(5) * w, interval(5)]))
    @test all(isequal_interval.(ForwardDiff.hessian(ψ, [0, 1]),
        [interval(20) * w * w  interval(20) * w
         interval(20) * w      interval(20)    ]))
end
