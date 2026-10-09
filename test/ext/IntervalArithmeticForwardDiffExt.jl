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
    @test isequal_interval(ForwardDiff.derivative(x -> interval(0.0)^x, interval(3.0)), interval(0.0))
end

@testset "Power with different tags" begin
    TA = typeof(Tag(x -> x, Interval{Float64}))
    TB = typeof(Tag(x -> 2x, Interval{Float64}))
    @test ForwardDiff.:≺(TA, TB) & !ForwardDiff.:≺(TB, TA)
    x = Dual{TA}(interval(2.0), interval(1.0))
    y = Dual{TB}(interval(3.0), interval(1.0))
    z = x^y
    @test z isa Dual{TB}
    @test isequal_interval(value(z), interval(8))
    @test in_interval(8 * log(2), partials(z, 1))
    z = y^x
    @test z isa Dual{TB}
    @test isequal_interval(value(z), interval(9)) & isequal_interval(partials(z, 1), interval(6))
    # each cross-tag reduction treats the other variable as a constant
    dd = ForwardDiff.derivative(y -> ForwardDiff.derivative(t -> t^y, interval(2.0)), interval(3.0))
    @test isequal_interval(dd, interval(0))
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

@testset "BareInterval" begin
    @testset "sin" begin
        x, w = bareinterval(2), bareinterval(-0.5, 0.5)
        z = bareinterval(0)
        ϕ(t)    = sin(x + (exact(1)+t)*w)
        dϕ(t)   = ForwardDiff.derivative(ϕ, t)
        ddϕ(t)  = ForwardDiff.derivative(dϕ, t)
        dddϕ(t) = ForwardDiff.derivative(ddϕ, t)

        @test isequal_interval(dϕ(z),   cos(x + w) * w)
        @test isequal_interval(ddϕ(z), -sin(x + w) * w * w)
        @test isequal_interval(dddϕ(z), -cos(x + w) * w * w * w)
    end

    @testset "derivative at a bare interval" begin
        @test isequal_interval(ForwardDiff.derivative(exp, bareinterval(0, 1)),
                               exp(bareinterval(0, 1)))
        @test isequal_interval(ForwardDiff.derivative(x -> x^3, bareinterval(1, 2)),
                               bareinterval(3) * bareinterval(1, 2)^2)
    end

    @testset "thick partials" begin
        x, w, z = bareinterval(2), bareinterval(-0.5, 0.5), bareinterval(0)
        for n ∈ (4, 4//1, bareinterval(4), exact(4))
            @test isequal_interval(ForwardDiff.derivative(t -> (x + t*w)^n, z),
                                   bareinterval(4) * x^3 * w)
            @test isequal_interval(ForwardDiff.derivative(t -> ForwardDiff.derivative(s -> (x + s*w)^n, t), z),
                                   bareinterval(12) * x^2 * w * w)
        end
        @test_throws MethodError ForwardDiff.derivative(t -> (x + t*w)^4.0, z)
        @test_throws MethodError ForwardDiff.derivative(t -> (x + t*w)^π, z)
    end

    @testset "exact constants in nested bare duals" begin
        g(x) = exact(2.5) * exp(-x^exact(2) / exact(2)) - exact(1) / (x + exact(4))
        xb, wb = bareinterval(0.25), bareinterval(-0.5, 0.5)
        xd, wd = interval(0.25), interval(-0.5, 0.5)
        ϕb(t) = g(xb + (exact(1)+t)*wb)
        ϕd(t) = g(xd + (exact(1)+t)*wd)
        db1(t)  = ForwardDiff.derivative(ϕb, t)
        db2(t)  = ForwardDiff.derivative(db1, t)
        db3(t)  = ForwardDiff.derivative(db2, t)
        dd1(t)  = ForwardDiff.derivative(ϕd, t)
        dd2(t)  = ForwardDiff.derivative(dd1, t)
        dd3(t)  = ForwardDiff.derivative(dd2, t)
        for (fb, fd) in ((db1, dd1), (db2, dd2), (db3, dd3))
            b, d = fb(bareinterval(0)), fd(interval(0))
            @test inf(b) == inf(d) && sup(b) == sup(d)
        end
    end

    @testset "plain reals are rejected" begin
        X = bareinterval(0.3, 0.7)
        T = ForwardDiff.Tag{Nothing, BareInterval{Float64}}
        d = ForwardDiff.Dual{T}(X, ForwardDiff.Partials((one(X),)))

        for c ∈ (2, 2.0, 1//2, π, ℯ)
            @test_throws MethodError d + c
            @test_throws MethodError c + d
            @test_throws MethodError d - c
            @test_throws MethodError c - d
            @test_throws MethodError d * c
            @test_throws MethodError c * d
            @test_throws MethodError d / c
            @test_throws MethodError c / d
        end

        for c ∈ (exact(2), bareinterval(2))
            @test isequal_interval(ForwardDiff.value(d + c), X + bareinterval(2))
            @test isequal_interval(ForwardDiff.value(c + d), X + bareinterval(2))
            @test isequal_interval(ForwardDiff.value(d - c), X - bareinterval(2))
            @test isequal_interval(ForwardDiff.value(c - d), bareinterval(2) - X)
            @test isequal_interval(ForwardDiff.value(d * c), X * bareinterval(2))
            @test isequal_interval(ForwardDiff.value(c * d), X * bareinterval(2))
            @test isequal_interval(ForwardDiff.value(d / c), X / bareinterval(2))
            @test isequal_interval(ForwardDiff.value(c / d), bareinterval(2) / X)
        end

        # Exponents: exactly representable ones apply, inexact ones do not.
        @test_throws MethodError d^2.5
        @test_throws MethodError d^π
        @test isequal_interval(ForwardDiff.value(d^exact(3)), X^3)
        @test isequal_interval(ForwardDiff.derivative(t -> t^exact(3), X), bareinterval(3) * X^2)
        @test isequal_interval(ForwardDiff.derivative(t -> ForwardDiff.derivative(s -> s^exact(3), t), X),
                               bareinterval(6) * X)

        # A `Dual` over plain reals does not acquire bare-interval arithmetic.
        S = ForwardDiff.Tag{Nothing, Float64}
        e = ForwardDiff.Dual{S}(1.0, ForwardDiff.Partials((1.0,)))
        @test_throws MethodError e * X
        @test_throws MethodError X * e
        @test_throws MethodError e + X

        # `true` and `false` scale a dual without naming an interval.
        @test d * true === d
        @test all(isthinzero, ForwardDiff.partials(d * false).values)
    end

    @testset "zero partials short-circuit" begin
        T = ForwardDiff.Tag{Nothing, BareInterval{Float64}}
        d0 = ForwardDiff.Dual{T}(bareinterval(1, 2), ForwardDiff.Partials((bareinterval(0),)))
        @test isequal_interval(ForwardDiff.value(d0^3), bareinterval(1, 2)^3)
        @test isequal_interval(ForwardDiff.value(d0^4), bareinterval(1, 2)^4)
        @test all(isthinzero, ForwardDiff.partials(d0^4).values)
    end

    ext = Base.get_extension(IntervalArithmetic, :IntervalArithmeticForwardDiffExt)
    unary_rules = ext.BARE_UNARY_RULES

    @testset "vendored rule coverage" begin
        # Test the functions of one argument that `DiffRules` tabulates and
        # `IntervalArithmetic` implements on `BareInterval`. No need to test
        # those ForwardDiff differentiates without consulting the rule table.
        sample = bareinterval(0.3, 0.7)
        supported = Symbol[]
        for (M, f, arity) ∈ ForwardDiff.DiffRules.diffrules(; filter_modules = (:Base,))
            arity == 1 || continue
            (M, f) ∈ ((:Base, :+), (:Base, :-), (:Base, :sin), (:Base, :cos)) && continue
            isdefined(Base, f) || continue
            ok = try
                getfield(Base, f)(sample) isa BareInterval
            catch
                false
            end
            ok && push!(supported, f)
        end
        @test sort(supported) == sort(collect(unary_rules))
    end

    @testset "derivative rules" begin
        @test isempty(detect_ambiguities(ext))

        # Intervals lying inside the domain of each rule.
        domains = Dict(:acosh => (1.3, 1.7), :acoth => (1.3, 1.7))
        D = ForwardDiff.Dual{ForwardDiff.Tag{Nothing,BareInterval{Float64}},BareInterval{Float64},1}

        for f ∈ unary_rules
            g = getfield(Base, f)
            @test which(g, Tuple{D}).module === ext

            lo, hi = get(domains, f, (0.3, 0.7))
            X = bareinterval(lo, hi)
            d₁ = ForwardDiff.derivative(g, X)
            d₂ = ForwardDiff.derivative(t -> ForwardDiff.derivative(g, t), X)
            for t ∈ (lo, (lo + hi) / 2, hi)
                @test in_interval(ForwardDiff.derivative(g, big(t)), d₁)
                @test in_interval(ForwardDiff.derivative(s -> ForwardDiff.derivative(g, s), big(t)), d₂)
            end
        end
    end

    @testset "binary derivative rules" begin
        X, Y = bareinterval(0.3, 0.7), bareinterval(1.1, 1.4)
        for g ∈ (atan, hypot)
            dx = ForwardDiff.derivative(t -> g(t, Y), X)
            dy = ForwardDiff.derivative(t -> g(X, t), Y)
            for (t, u) ∈ ((0.3, 1.1), (0.5, 1.25), (0.7, 1.4))
                @test in_interval(ForwardDiff.derivative(s -> g(s, big(u)), big(t)), dx)
                @test in_interval(ForwardDiff.derivative(s -> g(big(t), s), big(u)), dy)
            end
        end
    end

    @testset "abs" begin
        @test isequal_interval(ForwardDiff.derivative(abs, bareinterval(-2, -1)), bareinterval(-1))
        @test isequal_interval(ForwardDiff.derivative(abs, bareinterval(1, 2)), bareinterval(1))
        @test isequal_interval(ForwardDiff.derivative(abs, bareinterval(0)), bareinterval(-1, 1))
        @test isequal_interval(ForwardDiff.derivative(abs, bareinterval(-2, 2)), bareinterval(-1, 1))
    end
end
