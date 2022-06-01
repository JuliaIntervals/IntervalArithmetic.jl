using IntervalArithmetic
using StaticArrays

using Test

let X, A  # avoid problems with global variables

@testset "Operations on boxes" begin
    A = IntervalBox(1..2, 3..4)
    B = IntervalBox(0..2, 3..6)
    s = @SVector [1, 2]

    @test 2*A == A*2 == IntervalBox(2..4, 6..8)
    @test typeof(2*A) == IntervalBox{2, Float64}
    @test A + B == IntervalBox(1..4, 6..10)
    @test A + B.v == IntervalBox(1..4, 6..10)
    @test A.v + B == IntervalBox(1..4, 6..10)
    @test A + s == IntervalBox(2..3, 5..6)
    @test A - B == IntervalBox(-1..2, -3..1)
    @test A.v - B == IntervalBox(-1..2, -3..1)
    @test A - B.v == IntervalBox(-1..2, -3..1)
    @test A - s == IntervalBox(0..1, 1..2)
    @test 2 + A == IntervalBox(3..4,5..6)
    @test A + 2 == IntervalBox(3..4,5..6)
    @test -A == IntervalBox((-2)..(-1), (-4)..(-3))
    @test 2 - A == IntervalBox(0..1, (-2)..(-1))
    @test B - 2 == IntervalBox((-2)..0, 1..4)
    @test dot(A, B) == @interval(9, 28)
    @test dot(A, B.v) == @interval(9, 28)
    @test dot(A.v, B) == @interval(9, 28)
    @test A .* B == IntervalBox(0..4, 9..24)
    @test A ./ A == IntervalBox((0.5)..2, (0.75)..(4/3))
    @test 1 ./ B == IntervalBox((0.5)..Inf, (1/6)..(1/3))
    @test B ./ 1 == B
    @test A .^ 2 == IntervalBox(1..4, 9..16)
    @test B .^ 0.5 == IntervalBox(@interval(0,sqrt(2)), @interval(sqrt(3),sqrt(6)))

    for (A, B) in ( (A,B), (big(A), B), (A, big(B)), (big(A), big(B)) )
        @test A ⊆ A
        @test A ⊆ B
        @test A.v ⊆ B
        @test A ⊂ B.v
        @test !(A ⊂ A)
        @test A ⊂ B
        @test A.v ⊂ B
        @test A ⊆ B.v
        @test !(B ⊆ A)
        @test !(B ⊂ A)
        @test B ⊇ B
        @test B ⊇ A
        @test B.v ⊇ A
        @test B ⊇ A.v
        @test !(B ⊃ B)
        @test B ⊃ A
        @test B.v ⊃ A
        @test B ⊃ A.v
        @test !(A ⊇ B)
        @test !(A ⊃ B)

        @test A ∩ B == A
        @test A.v ∩ B == A
        @test A ∩ B.v == A

        @test A ∪ B == B
        @test A.v ∪ B == B
        @test A ∪ B.v == B
    end

    x = 0.5 .. 3
    a = IntervalBox(A[1]) # 1 .. 2
    @test !(x ⊆ a) && a ⊆ x
    @test !(x ⊂ a) && a ⊂ x
    @test x ∩ a == a ∩ x == A[1]
    @test x ∪ a ==  a ∪ x == x

    X = IntervalBox(1..2, 3..4)
    Y = IntervalBox(3..4, 3..4)

    @test isempty(X ∩ Y)
    @test X ∪ Y == IntervalBox(1..4, 3..4)

    @test !contains_zero(X ∩ Y)
    @test contains_zero( (-1..1) × (-1..1) )
    @test !isinf( (-1..1) × (0..Inf) )
    @test isinf( entireinterval() × entireinterval() )

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
    @test typeof(Y) == IntervalBox{1, Float64}
end

@testset "Functions on boxes" begin
    A = IntervalBox(1..2, 3..4)

    @test exp.(A) == IntervalBox(exp(A[1]), exp(A[2]))
    @test typeof(exp.(A)) == IntervalBox{2,Float64}
    @test log.(A) == IntervalBox(log(A[1]), log(A[2]))
    @test sqrt.(A) == IntervalBox(sqrt(A[1]), sqrt(A[2]))
    @test inv.(A) == IntervalBox(inv(A[1]), inv(A[2]))
end


@testset "setdiff for IntervalBox" begin
    X = IntervalBox(2..4, 3..5)
    Y = IntervalBox(3..5, 4..6)
    @test Set(setdiff(X, Y)) == Set([ IntervalBox(3..4, 3..4),
                              IntervalBox(2..3, 3..5) ])

    @test Set(setdiff(X.v, Y)) == Set([ IntervalBox(3..4, 3..4),
                              IntervalBox(2..3, 3..5) ])

    @test Set(setdiff(X, Y.v)) == Set([ IntervalBox(3..4, 3..4),
                              IntervalBox(2..3, 3..5) ])

    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(-10..10, 4..5)
    @test Set(setdiff(X, Y)) == Set([ IntervalBox(2..5, 3..4),
                              IntervalBox(2..5, 5..6) ])


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(4..6, 4..5)
    @test Set(setdiff(X, Y)) == Set([ IntervalBox(4..5, 3..4),
                              IntervalBox(4..5, 5..6),
                              IntervalBox(2..4, 3..6) ])


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(3..4, 4..5)
    @test Set(setdiff(X, Y)) == Set([ IntervalBox(3..4, 3..4),
                              IntervalBox(3..4, 5..6),
                              IntervalBox(2..3, 3..6),
                              IntervalBox(4..5, 3..6) ])


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(2..4, 10..20)
    @test setdiff(X, Y) == typeof(X)[X]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(-10..10, -10..10)
    @test setdiff(X, Y) == typeof(X)[]


    X = IntervalBox(1..4, 3..6, 7..10)
    Y = IntervalBox(2..3, 4..5, 8..9)
    @test Set(setdiff(X, Y)) == Set([ IntervalBox(2..3, 4..5, 7..8),
                              IntervalBox(2..3, 4..5, 9..10),
                              IntervalBox(2..3, 3..4, 7..10),
                              IntervalBox(2..3, 5..6, 7..10),
                              IntervalBox(1..2, 3..6, 7..10),
                              IntervalBox(3..4, 3..6, 7..10) ])


    X = IntervalBox(-Inf..Inf, 1..2)
    Y = IntervalBox(1..2, -1..1.5)

    @test Set(setdiff(X, Y)) == Set([IntervalBox(-Inf..1, 1..2),
                              IntervalBox(2..Inf, 1..2),
                              IntervalBox(1..2, 1.5..2)])
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

    Z = X × Y
    @test isa(Z, IntervalBox)
    @test length(Z) == 5
    @test Z == IntervalBox(Interval(0, 2), Interval(3, 5), Interval(0, 2), Interval(3, 5), Interval(4, 8))
    @test diam(Z) == 4

    Z = X × Y.v
    @test isa(Z, IntervalBox)
    @test length(Z) == 5
    @test Z == IntervalBox(Interval(0, 2), Interval(3, 5), Interval(0, 2), Interval(3, 5), Interval(4, 8))
    @test diam(Z) == 4

    Z = X.v × Y
    @test isa(Z, IntervalBox)
    @test length(Z) == 5
    @test Z == IntervalBox(Interval(0, 2), Interval(3, 5), Interval(0, 2), Interval(3, 5), Interval(4, 8))
    @test diam(Z) == 4

    @test mid(IntervalBox(0..1, 3), 0.75) == [0.75, 0.75, 0.75]
end

@testset "Constructing multidimensional IntervalBoxes" begin
    @test IntervalBox(1..2, Val(1)) == IntervalBox(1..2)
    @test IntervalBox(1..2, Val(2)) == (1..2) × (1..2)
    @test IntervalBox(1..2, Val(5)) == (1..2) × (1..2) × (1..2) × (1..2) × (1..2)

    @test IntervalBox(1..2, 3) == IntervalBox(1..2, Val(3))
    @test IntervalBox((1..2, 2..3)) == IntervalBox(1..2, 2..3)
    @test IntervalBox((1, 2)) == IntervalBox(1..1, 2..2)
    @test IntervalBox( (1, 2, 3) ) == IntervalBox(1..1, 2..2, 3..3)
    @test IntervalBox( (1, 2, 3.1) ) == IntervalBox(1..1, 2..2, interval(3.1))
    @test IntervalBox( SVector(1, 2, 3.1) ) == IntervalBox(1..1, 2..2, interval(3.1))
    @test IntervalBox( interval.(SVector(1, 2, 3.1)) ) == IntervalBox(1..1, 2..2, interval(3.1))
    @test IntervalBox(3) == IntervalBox(3..3)
    @test IntervalBox(1:5) == IntervalBox(1..1, 2..2, 3..3, 4..4, 5..5)
    @test IntervalBox([1:5...]) == IntervalBox(1..1, 2..2, 3..3, 4..4, 5..5)
    @test IntervalBox((1..2) × (2..3), 2) == (1..2) × (2..3) × (1..2) × (2..3)

    # construct from corners:
    @test IntervalBox(SVector(1, 2), SVector(3, 4)) == (1..3) × (2..4)
    @test IntervalBox(SVector(3, 4), SVector(1, 2)) == (1..3) × (2..4)

end

@testset "getindex and setindex" begin
    X = IntervalBox(3..4, 5..6)
    @test X[1] == 3..4
    @test X[2] == 5..6
    @test_throws BoundsError X[3]

    @test setindex(X, 5..5, 2) == IntervalBox(3..4, 5..5)
    @test_throws BoundsError setindex(X, 5..5, 3)
end

@testset "Iteration" begin
    X = IntervalBox(3..4, 5..6)
    Y = collect(X)
    @test Y == [3..4, 5..6]
    @test eltype(Y) == Interval{Float64}
end

@testset "Broadcasting" begin
    X = IntervalBox(3..4, 5..6)

    @test sin.(X) == IntervalBox(sin(X[1]), sin(X[2]))
    @test mid.(X) == SVector(mid(X[1]), mid(X[2]))
    @test diam.(X) == SVector(diam(X[1]), diam(X[2]))


    Y = IntervalBox(4..6, 4..5)
    for i in 1:5
        @test Y.*i == IntervalBox(Y[1].*i, Y[2].*i)
    end
    for i in 1:5
        @test Y.+i == IntervalBox(Y[1].+i, Y[2].+i)
    end
    for i in 1:5
        @test Y.-i == IntervalBox(Y[1].-i, Y[2].-i)
    end
    for i in 1:5
        @test Y./i == IntervalBox(Y[1]./i, Y[2]./i)
    end

end

@testset "∈" begin
    X = IntervalBox(3..4, 5..6)
    @test mid(X) ∈ X
    @test mid(X, 0.75) ∈ X

    @test (zero(mid(X)) ∈ X) == false
    @test zero(mid(X)) ∉ X

    @test_throws ArgumentError (3..4) ∈ X

    @test_throws ArgumentError [3..4, 5..6] ∈ X

end

@testset "Multiplication by a matrix" begin
    A = [1 2; 3 4]
    X = IntervalBox(1..2, 3..4)

    @test A * X == IntervalBox(7..10, 15..22)

    B = SMatrix{2,2}(A)

    @test B * X == IntervalBox(7..10, 15..22)

end

@testset "Mince and hull for `IntervalBox`es" begin
    ib2 = IntervalBox(-1..1, 2)
    vb2 = mince(ib2, 4)
    @test length(vb2) == 4^2
    vv = [(-1 .. -0.5) × (-1 .. -0.5), (-0.5 .. 0) × (-1 .. -0.5),
        (0 .. 0.5) × (-1 .. -0.5), (0.5 .. 1) × (-1 .. -0.5), #
        (-1 .. -0.5) × (-0.5 .. 0), (-0.5 .. 0) × (-0.5 .. 0),
        (0 .. 0.5) × (-0.5 .. 0), (0.5 .. 1) × (-0.5 .. 0), #
        (-1 .. -0.5) × (0 .. 0.5), (-0.5 .. 0) × (0 .. 0.5),
        (0 .. 0.5) × (0 .. 0.5), (0.5 .. 1) × (0 .. 0.5), #
        (-1 .. -0.5) × (0.5 .. 1), (-0.5 .. 0) × (0.5 .. 1),
        (0 .. 0.5) × (0.5 .. 1), (0.5 .. 1) × (0.5 .. 1)]
    @test vb2 == vv
    @test hull(vb2...) == ib2
    @test hull(vb2) == ib2
    @test mince(ib2, (4,4)) == vb2
    @test mince(ib2, (1,4)) == [ (-1 .. 1)×(-1 .. -0.5), (-1 .. 1)×(-0.5 .. 0),
        (-1 .. 1)×(0 .. 0.5), (-1 .. 1)×(0.5 .. 1)]
    @test hull(mince(ib2, (1,4))) == ib2

    ib3 = IntervalBox(-1..1, 3)
    vb3 = mince(ib3, 4)
    @test length(vb3) == 4^3
    @test hull(vb3...) == ib3
    @test hull(vb3) == ib3
    @test mince(ib3, (4,4,4)) == vb3
    @test mince(ib3, (2,1,1)) == [(-1 .. 0)×(-1 .. 1)×(-1 .. 1), 
        (0 .. 1)×(-1 .. 1)×(-1 .. 1)]
    @test hull(mince(ib3, (2,1,1))) == ib3

    ib4 = IntervalBox(-1..1, 4)
    vb4 = mince(ib4, 4)
    @test length(vb4) == 4^4
    @test hull(vb4...) == ib4
    @test hull(vb4) == ib4
    @test mince(ib4,(4,4,4,4)) == vb4
    @test mince(ib4,(1,1,1,1)) == [ib4]
end

@testset "Special box constructors" begin
    @test zero(IntervalBox{2, Float64}) === IntervalBox(0 .. 0, 2)
    @test zero((0..1) × (0..1)) === IntervalBox(0 .. 0, 2)
    @test symmetric_box(2, Float64) === IntervalBox(-1 .. 1, 2)
end

end
