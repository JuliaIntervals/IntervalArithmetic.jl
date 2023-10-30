@testset "Interval" begin
    x = interval(0, 1)
    @test all(isequal_interval.( bisect(x, 0.5),  (interval(0, 0.5),          interval(0.5, 1)         ) ))
    @test all(isequal_interval.( bisect(x, 0.25), (interval(0, 0.25),         interval(0.25, 1)        ) ))
    @test all(isequal_interval.( bisect(x),       (interval(0.0, 0.49609375), interval(0.49609375, 1.0)) ))

    x = interval(-Inf, Inf)
    @test all(isequal_interval.( bisect(x, 0.5), (interval(-Inf, 0), interval(0, Inf)) ))
    y = bisect(x, nextfloat(0.5))
    @test sup(y[1]) == inf(y[2]) > 0
    y = bisect(x, prevfloat(0.5))
    @test sup(y[1]) == inf(y[2]) < 0
end
