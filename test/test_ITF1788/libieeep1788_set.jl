@testset "minimal_intersection_test" begin

    @test intersect(interval(1.0,3.0), interval(2.1,4.0)) === Interval(2.1,3.0)

    @test intersect(interval(1.0,3.0), interval(3.0,4.0)) === Interval(3.0,3.0)

    @test intersect(interval(1.0,3.0), emptyinterval()) === emptyinterval()

    @test intersect(entireinterval(), emptyinterval()) === emptyinterval()

    @test intersect(interval(1.0,3.0), entireinterval()) === Interval(1.0,3.0)

end

@testset "minimal_intersection_dec_test" begin

    @test intersect(DecoratedInterval(interval(1.0,3.0), com), DecoratedInterval(interval(2.1,4.0), com)) === DecoratedInterval(Interval(2.1,3.0), trv)

    @test intersect(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(interval(3.0,4.0), def)) === DecoratedInterval(Interval(3.0,3.0), trv)

    @test intersect(DecoratedInterval(interval(1.0,3.0), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test intersect(DecoratedInterval(entireinterval(), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test intersect(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(1.0,3.0), trv)

end

@testset "minimal_convex_hull_test" begin

    @test hull(interval(1.0,3.0), interval(2.1,4.0)) === Interval(1.0,4.0)

    @test hull(interval(1.0,1.0), interval(2.1,4.0)) === Interval(1.0,4.0)

    @test hull(interval(1.0,3.0), emptyinterval()) === Interval(1.0,3.0)

    @test hull(emptyinterval(), emptyinterval()) === emptyinterval()

    @test hull(interval(1.0,3.0), entireinterval()) === entireinterval()

end

@testset "minimal_convex_hull_dec_test" begin

    @test hull(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(interval(2.1,4.0), trv)) === DecoratedInterval(Interval(1.0,4.0), trv)

    @test hull(DecoratedInterval(interval(1.0,1.0), trv), DecoratedInterval(interval(2.1,4.0), trv)) === DecoratedInterval(Interval(1.0,4.0), trv)

    @test hull(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(Interval(1.0,3.0), trv)

    @test hull(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test hull(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

end

