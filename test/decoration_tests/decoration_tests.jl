using Test
using IntervalArithmetic

let b

@testset "DecoratedInterval tests" begin
    a = DecoratedInterval(interval(1, 2), com)
    @test decoration(a) == com

    b = sqrt(a)
    @test isequal_interval(interval(b), sqrt(interval(a)))
    @test decoration(b) == com

    a = DecoratedInterval(interval(-1, 1), com)
    b = sqrt(a)
    @test isequal_interval(interval(b), sqrt(interval(0, 1)))
    @test decoration(b) == trv

    d = DecoratedInterval(a, dac)
    @test decoration(d) == dac

    @test decoration(DecoratedInterval(1.1)) == com
    @test decoration(DecoratedInterval(1.1, dac)) == dac

    @test decoration(DecoratedInterval(2, 0.1, com)) == ill
    @test decoration(DecoratedInterval(2, 0.1)) == ill
    @test isnai(DecoratedInterval(2, 0.1))
    @test decoration(DecoratedInterval(big(2), big(1))) == ill
    @test isnai((DecoratedInterval(big(2), big(1))))

    # Disabling the following tests, because Julia 0.5 has some strange behaviour here
    # @test_throws ArgumentError DecoratedInterval(BigInt(1), 1//10)

    # Tests related to powers of decorated Intervals
    @test isequal_interval(DecoratedInterval(2, 3) ^ 2, DecoratedInterval(4, 9))
    @test isequal_interval(DecoratedInterval(2, 3) ^ -2, DecoratedInterval(1/9,1/4))
    @test isequal_interval(DecoratedInterval(-3, 2) ^ 3, DecoratedInterval(-27, 8))
    @test isequal_interval(DecoratedInterval(-3, -2) ^ -3, DecoratedInterval(-1/8, -1/27))
    @test isequal_interval(DecoratedInterval(0, 3) ^ 2, DecoratedInterval(0, 9))
    @test isequal_interval(DecoratedInterval(0, 3) ^ -2, DecoratedInterval(1/9, Inf, trv))
    @test isequal_interval(DecoratedInterval(2, 3)^interval(0, 1), DecoratedInterval(1, 3))
    @test isequal_interval(DecoratedInterval(2, 3)^DecoratedInterval(0, 1), DecoratedInterval(1, 3))
    @test isequal_interval(DecoratedInterval(0, 2)^interval(0, 1), DecoratedInterval(0, 2, trv))
    @test isequal_interval(DecoratedInterval(0, 2)^DecoratedInterval(0, 1), DecoratedInterval(0, 2, trv))
    @test isequal_interval(DecoratedInterval(-3, 2)^interval(0, 1), DecoratedInterval(0, 2, trv))
    @test isequal_interval(DecoratedInterval(-3, 2)^DecoratedInterval(0, 1), DecoratedInterval(0, 2, trv))
    @test isequal_interval(DecoratedInterval(-3, 2)^interval(-1, 1), DecoratedInterval(0, Inf, trv))
    @test isequal_interval(DecoratedInterval(-3, 2)^DecoratedInterval(-1, 1), DecoratedInterval(0, Inf, trv))

    a = DecoratedInterval(1, 2)
    b = DecoratedInterval(3, 4)

    @test dist(a, b) == 2.0

    # invalid input
    @test isnai(DecoratedInterval(3, 1, com))
    @test isnai(DecoratedInterval(3, 1))
    @test isnai(DecoratedInterval(Inf, Inf))
    @test isnai(DecoratedInterval(-Inf, -Inf))
    @test isnai(DecoratedInterval(NaN, 3))
    @test isnai(DecoratedInterval(3, NaN))
    @test isnai(DecoratedInterval(NaN, NaN))
end

end
