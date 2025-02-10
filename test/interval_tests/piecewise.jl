using IntervalArithmetic: leftof, intersect_domain, isempty_domain

@testset "Domain" begin
    @testset "Construction" begin
        @test_throws ErrorException Domain{:oopen, :closed}(0, 1)
        @test_throws ErrorException Domain{:open, :close}(0, 1)
        @test_throws MethodError Piecewise(
            (Domain{:closed, :closed}(1, 2), Domain{:open, :open}(2, 3)),
            (sin, cos), (-1,), (2, 3))
        @test_throws ArgumentError Piecewise(
            (Domain{:closed, :closed}(1, 2), Domain{:open, :open}(2, 3)),
            (sin, cos), (-1,-1), (2, 3))
        @test_throws MethodError Piecewise(
            (Domain{:closed, :closed}(1, 2), Domain{:open, :open}(2, 3)),
            (sin, cos, log), (-1,), (2))
    end

    @testset "leftof" begin
        d1 = Domain{:open, :closed}(0, 1)
        d2 = Domain{:open, :open}(0, 1)
        d3 = Domain{:open, :closed}(1, 2)
        d4 = Domain{:closed, :closed}(1, 2)

        @test !leftof(d1, d2)
        @test leftof(d1, d3)
        @test !leftof(d1, d4)

        @test leftof(d2, d3)
        @test leftof(d2, d4)
    end

    @testset "intersect_domain" begin
        d1 = Domain{:closed, :open}(0, 10)
        d2 = Domain{:closed, :open}(2, 15)
        d3 = Domain{:open, :closed}(4, 7)
        d4 = Domain{:open, :closed}(-20, 3)

        @test intersect_domain(d1, d2) == Domain{:closed, :open}(2, 10)
        @test intersect_domain(d1, d3) == Domain{:open, :closed}(4, 7)
        @test intersect_domain(d1, d4) == Domain{:closed, :closed}(0, 3)
        @test intersect_domain(d2, d3) == Domain{:open, :closed}(4, 7)
        @test intersect_domain(d2, d4) == Domain{:closed, :closed}(2, 3)
        @test intersect_domain(d3, d4) == Domain()
    end

    @testset "isempty_domain" begin
        @test isempty_domain(Domain{:open, :open}(1, 1))
        @test !isempty_domain(Domain{:closed, :closed}(1, 1))
        @test !isempty_domain(Domain{:open, :open}(1, 2))
        @test isempty_domain(Domain())
    end
end

@testset "Piecewise constructor" begin
    d1 = Domain{:open, :closed}(0, 1)
    d2 = Domain{:open, :closed}(1, 2)
    d3 = Domain{:closed, :closed}(1, 2)

    @test_throws ArgumentError Piecewise(d2 => Constant(0), d1 => Constant(1))
    @test_throws ArgumentError Piecewise(d1 => Constant(0), d3 => Constant(1))
end

@testset "Step function" begin
    step = Piecewise(
        Domain{:open, :closed}(-Inf, 0) => Constant(0),
        Domain{:open, :open}(0, 1000) => Constant(1)
    )

    @test step(-1) == 0
    @test step(100) == 1
    @test isequal_interval(step(interval(-3.2, -2.1)), interval(0))
    @test decoration(step(interval(-3.33))) == com
    @test isequal_interval(step(interval(2.3, 3.4)), interval(1))
    @test decoration(step(interval(4.44))) == com
    @test isequal_interval(step(interval(-22.2, 33.3)), interval(0, 1))
    @test decoration(step(interval(-11, 11))) == def
    @test decoration(step(interval(500, 2000))) == trv
end

@testset "abs" begin
    myabs = Piecewise(
        Domain{:open, :closed}(-Inf, 0) => x -> -x,
        Domain{:open, :open}(0, Inf) => identity ;
        continuity = [0]
    )

    @test myabs(-1) == 1
    @test myabs(100) == 100
    @test isequal_interval(myabs(interval(-3.2, -2.1)), interval(2.1, 3.2))
    @test decoration(myabs(interval(-3.33))) == com
    @test isequal_interval(myabs(interval(2.3, 3.4)), interval(2.3, 3.4))
    @test decoration(myabs(interval(4.444))) == com
    @test isequal_interval(myabs(interval(-22.2, 33.3)), interval(0, 33.3))
    @test decoration(myabs(interval(-11, 11))) == com
end

@testset "Out of domain" begin
    window = Piecewise(
        Domain{:open, :closed}(-π, π) => x -> 1/2 * (cos(x) + 1)
    )

    @test_throws DomainError window(123)
    @test isequal_interval(window(interval(0, π)), interval(0, 1))
    @test decoration(window(interval(-π, 0))) == com
    @test isequal_interval(window(interval(-10, 10)), interval(0, 1))
    @test decoration(window(interval(-10, 10))) == trv
    @test isempty_interval(window(interval(100, 1000)))
end

@testset "Derivatives" begin
    slide = Piecewise(
        Domain{:open, :closed}(-Inf, -1) => x -> -2x - 1,
        Domain{:open, :closed}(-1, 0) => x -> x^2,
        Domain{:open, :open}(0, Inf) => Constant(0) ;
        continuity = [1, 1]
    )

    @test ForwardDiff.derivative(slide, -5.5) == -2
    @test ForwardDiff.derivative(slide, -0.5) == -1
    @test ForwardDiff.derivative(slide, 1.2) == 0 

    @test isequal_interval(
        ForwardDiff.derivative(slide, interval(-7, -3)),
        interval(-2)
    )
    @test isequal_interval(
        ForwardDiff.derivative(slide, interval(-0.7, -0.3)),
        interval(-1.4, -0.6)
    )
    @test isequal_interval(
        ForwardDiff.derivative(slide, interval(0.7, 1.3)),
        interval(0)
    )

    @test isequal_interval(
        ForwardDiff.derivative(slide, interval(-1.7, -0.3)),
        interval(-2, -0.6)
    )

    @test isequal_interval(
        ForwardDiff.derivative(slide, interval(-0.7, 1.3)),
        interval(-1.4, 0)
    )

    @test isequal_interval(
        ForwardDiff.derivative(slide, interval(-1.7, 1.3)),
        interval(-2, 0)
    )

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

@testset "Singularities" begin
    f = Piecewise(
        Domain{:open, :closed}(0, 1) => Constant(0),
        Domain{:open, :closed}(1, 2) => x -> 0.5x,
        Domain{:open, :closed}(2, 3) => Constant(1),
        Domain{:open, :open}(3, 4) => x -> (x-3)^2 + 1 ;
        continuity = [-1, 0, 1]
    )

    @test decoration(f(interval(0.5, 1.5))) == def
    @test decoration(f(interval(1.5, 2.5))) == com
    @test decoration(f(interval(2.5, 3.5))) == com

    df = x -> ForwardDiff.derivative(f, x)
    @test decoration(df(interval(0.5, 1.5))) == def
    @test decoration(df(interval(1.5, 2.5))) == def
    @test decoration(df(interval(2.5, 3.5))) == com
end