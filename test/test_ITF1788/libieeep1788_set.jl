@testset "minimal_intersection_test" begin

    @test isequalinterval(intersectinterval(interval(1.0,3.0), interval(2.1,4.0)), interval(2.1,3.0))

    @test isequalinterval(intersectinterval(interval(1.0,3.0), interval(3.0,4.0)), interval(3.0,3.0))

    @test isequalinterval(intersectinterval(interval(1.0,3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(intersectinterval(entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(intersectinterval(interval(1.0,3.0), entireinterval()), interval(1.0,3.0))

end

@testset "minimal_intersection_dec_test" begin

    @test isequalinterval(intersectinterval(DecoratedInterval(interval(1.0,3.0), com), DecoratedInterval(interval(2.1,4.0), com)), DecoratedInterval(interval(2.1,3.0), trv))

    @test isequalinterval(intersectinterval(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(interval(3.0,4.0), def)), DecoratedInterval(interval(3.0,3.0), trv))

    @test isequalinterval(intersectinterval(DecoratedInterval(interval(1.0,3.0), def), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(intersectinterval(DecoratedInterval(entireinterval(), dac), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(intersectinterval(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(1.0,3.0), trv))

end

@testset "minimal_convex_convexhull_test" begin

    @test isequalinterval(hull(interval(1.0,3.0), interval(2.1,4.0)), interval(1.0,4.0))

    @test isequalinterval(hull(interval(1.0,1.0), interval(2.1,4.0)), interval(1.0,4.0))

    @test isequalinterval(hull(interval(1.0,3.0), emptyinterval()), interval(1.0,3.0))

    @test isequalinterval(hull(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(hull(interval(1.0,3.0), entireinterval()), entireinterval())

end

@testset "minimal_convex_convexhull_dec_test" begin

    @test isequalinterval(hull(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(interval(2.1,4.0), trv)), DecoratedInterval(interval(1.0,4.0), trv))

    @test isequalinterval(hull(DecoratedInterval(interval(1.0,1.0), trv), DecoratedInterval(interval(2.1,4.0), trv)), DecoratedInterval(interval(1.0,4.0), trv))

    @test isequalinterval(hull(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(interval(1.0,3.0), trv))

    @test isequalinterval(hull(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(hull(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), trv))

end
