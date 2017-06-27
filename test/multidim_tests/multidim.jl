using IntervalArithmetic
using Base.Test


@testset "Operations on boxes" begin
    A = IntervalBox(1..2, 3..4)
    B = IntervalBox(0..2, 3..6)

    @test 2*A == IntervalBox(2..4, 6..8)
    @test A + B == IntervalBox(1..4, 6..10)
    @test dot(A, B) == @interval(9, 28)

    @test A ⊆ B
    @test A ∩ B == A
    @test A ∪ B == B

    X = IntervalBox(1..2, 3..4)
    Y = IntervalBox(3..4, 3..4)

    @test isempty(X ∩ Y)
    @test X ∪ Y == IntervalBox(1..4, 3..4)

    X = IntervalBox(2..4, 3..5)
    Y = IntervalBox(3..5, 4..17)
    @test X ∩ Y == IntervalBox(3..4, 4..5)

    v = [@interval(i, i+1) for i in 1:10]
    V = IntervalBox(v...)
    @test length(V) == 10

    Y = IntervalBox(1..2)  # single interval
    @test isa(Y, IntervalBox)
    @test length(Y) == 1
    @test Y == IntervalBox( (Interval(1., 2.),) )

end

# @testset "@intervalbox tests" begin
#     @intervalbox f(x, y) = (x + y, x - y)
#
#     X = IntervalBox(1..1, 2..2)
#     @test f(X) == IntervalBox(3..3, -1 .. -1)
#
#     @intervalbox g(x, y) = x - y
#     @test isa(g(X), IntervalBox)
#
#     @test emptyinterval(X) == IntervalBox(∅, ∅)
#
# end

@testset "setdiff for IntervalBox" begin
    X = IntervalBox(2..4, 3..5)
    Y = IntervalBox(3..5, 4..6)
    @test setdiff(X, Y) == [ IntervalBox(3..4, 3..4),
                              IntervalBox(2..3, 3..5) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(-10..10, 4..5)
    @test setdiff(X, Y) == [ IntervalBox(2..5, 3..4),
                              IntervalBox(2..5, 5..6) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(4..6, 4..5)
    @test setdiff(X, Y) == [ IntervalBox(4..5, 3..4),
                              IntervalBox(4..5, 5..6),
                              IntervalBox(2..4, 3..6) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(3..4, 4..5)
    @test setdiff(X, Y) == [ IntervalBox(3..4, 3..4),
                              IntervalBox(3..4, 5..6),
                              IntervalBox(2..3, 3..6),
                              IntervalBox(4..5, 3..6) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(2..4, 10..20)
    @test setdiff(X, Y) == typeof(X)[X]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(-10..10, -10..10)
    @test setdiff(X, Y) == typeof(X)[]


    X = IntervalBox(1..4, 3..6, 7..10)
    Y = IntervalBox(2..3, 4..5, 8..9)
    @test setdiff(X, Y) == [ IntervalBox(2..3, 4..5, 7..8),
                              IntervalBox(2..3, 4..5, 9..10),
                              IntervalBox(2..3, 3..4, 7..10),
                              IntervalBox(2..3, 5..6, 7..10),
                              IntervalBox(1..2, 3..6, 7..10),
                              IntervalBox(3..4, 3..6, 7..10) ]


end

@testset "mid, diam, × for IntervalBox" begin
    X = (0..2) × (3..5)
    @test length(X) == 2
    @test X == IntervalBox(Interval(0, 2), Interval(3, 5))

    @test diam(X) == 2
    @test mid(X) == [1, 4]

    Y = X × (4..8)
    @test isa(Y, IntervalBox)
    @test length(Y) == 3
    @test Y == IntervalBox(Interval(0, 2), Interval(3, 5), Interval(4, 8))
    @test diam(Y) == 4
end

@testset "Constructing multidimensional IntervalBoxes" begin
end
