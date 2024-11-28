@testset "Step function" begin
    step = Piecewise(
        interval(-Inf, 0) => Constant(0),
        interval(0, Inf) => Constant(1)
    )

    @test step(-1) == 0
    @test step(100) == 1
    @test isequal_interval(step(interval(-3.2, -2.1)), interval(0))
    @test decoration(step(interval(-3.33))) == com
    @test isequal_interval(step(interval(2.3, 3.4)), interval(1))
    @test decoration(step(interval(4.44))) == com
    @test isequal_interval(step(interval(-22.2, 33.3)), interval(0, 1))
    @test decoration(step(interval(-11, 11))) == def
end

@testset "abs" begin
    myabs = Piecewise(
        interval(-Inf, 0) => x -> -x,
        interval(0, Inf) => identity ;
        continuous = true
    )

    @test myabs(-1) == 1
    @test myabs(100) == 100
    @test isequal_interval(myabs(interval(-3.2, -2.1)), interval(2.1, 3.2))
    @test decoration(myabs(interval(-3.33))) == com
    @test isequal_interval(myabs(interval(2.3, 3.4)), interval(2.3, 3.4))
    @test decoration(myabs(interval(4.444))) == com
    @test isequal_interval(myabs(interval(-22.2, 33.3)), interval(0, 33.3))
    @test decoration(myabs(interval(-11, 11))) == dac
end