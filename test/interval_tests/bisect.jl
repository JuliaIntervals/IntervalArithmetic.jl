using Test
using IntervalArithmetic

@testset "`bisect` function" begin
    X = interval(0, 1)
    @test all(isequal_interval.(bisect(X, 0.5), (interval(0, 0.5), interval(0.5, 1))))
    @test all(isequal_interval.(bisect(X, 0.25), (interval(0, 0.25), interval(0.25, 1))))

    @test all(isequal_interval.(bisect(X), (interval(0.0, 0.49609375), interval(0.49609375, 1.0))))

    X = interval(-Inf, Inf)
    @test all(isequal_interval.(bisect(X, 0.5), (interval(-Inf, 0), interval(0, Inf))))
    B = bisect(X, 0.75)
    @test B[1].hi > 0
    @test B[1].hi == B[2].lo
    B = bisect(X, 0.25)
    @test B[1].hi < 0
    @test B[1].hi == B[2].lo

    X = [interval(0, 1), interval(0, 2)]

    tuple_starequal(x, y) = all(isequal_interval.(x, y))

    @test all(tuple_starequal.(bisect(X, 2, 0.5),
        ([interval(0, 1), interval(0, 1)], [interval(0, 1), interval(1, 2)])))
    @test all(tuple_starequal.(bisect(X, 2, 0.25),
        ([interval(0, 1), interval(0, 0.5)], [interval(0, 1), interval(0.5, 2)])))
    @test all(tuple_starequal.(bisect(X, 1, 0.5),
        ([interval(0, 0.5), interval(0, 2)], [interval(0.5, 1), interval(0, 2)])))
    @test all(tuple_starequal.(bisect(X, 1, 0.25),
        ([interval(0, 0.25), interval(0, 2)], [interval(0.25, 1), interval(0, 2)])))

    @test all(tuple_starequal.(bisect(X, 2),
        ([interval(0, 1), interval(0.0, 0.9921875)], [interval(0, 1), interval(0.9921875, 2.0)])))

    X = [interval(-Inf, Inf), interval(-Inf, Inf)]
    @test all(tuple_starequal.(bisect(X, 1, 0.5),
        ([interval(-Inf, 0), interval(-Inf, Inf)], [interval(0, Inf), interval(-Inf, Inf)])))
end
