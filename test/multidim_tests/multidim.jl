using IntervalArithmetic.Symbols

@testset "setdiffinterval" begin
    function sameset(A, B)
        length(A) != length(B) && return false
        for a ∈ A
            found = false
            for b ∈ B
                if all(equal.(a, b))
                    found = true
                    break
                end
            end
            !found && return false
        end
        return true
    end

    X = [2..4, 3..5]
    Y = [3..5, 4..6]
    @test sameset(
        setdiffinterval(X, Y),
        [ [3..4, 3..4],
          [2..3, 3..5] ])

    X = [2..5, 3..6]
    Y = [-10..10, 4..5]
    @test sameset(
        setdiffinterval(X, Y),
        [ [2..5, 3..4],
          [2..5, 5..6] ])

    X = [2..5, 3..6]
    Y = [4..6, 4..5]
    @test sameset(
        setdiffinterval(X, Y),
        [ [4..5, 3..4],
          [4..5, 5..6],
          [2..4, 3..6] ])

    X = [2..5, 3..6]
    Y = [3..4, 4..5]
    @test sameset(
        setdiffinterval(X, Y),
        [ [3..4, 3..4],
          [3..4, 5..6],
          [2..3, 3..6],
          [4..5, 3..6] ])

    X = [2..5, 3..6]
    Y = [2..4, 10..20]
    @test sameset(setdiffinterval(X, Y), typeof(X)[X])

    X = [2..5, 3..6]
    Y = [-10..10, -10..10]
    @test sameset(setdiffinterval(X, Y), typeof(X)[])

    X = [1..4, 3..6, 7..10]
    Y = [2..3, 4..5, 8..9]
    @test sameset(
        setdiffinterval(X, Y),
        [ [2..3, 4..5, 7..8],
          [2..3, 4..5, 9..10],
          [2..3, 3..4, 7..10],
          [2..3, 5..6, 7..10],
          [1..2, 3..6, 7..10],
          [3..4, 3..6, 7..10] ])

    X = [-Inf..Inf, 1..2]
    Y = [1..2, -1..1.5]
    @test sameset(
        setdiffinterval(X, Y),
        [ [-Inf..1, 1..2],
          [2..Inf, 1..2],
          [1..2, 1.5..2] ])
end

@testset "Mince and convexhull" begin
    ib2 = [-1..1, -1..1]
    vb2 = mince(ib2, 4)
    @test length(vb2) == 4^2
    vv = [[(-1 .. -0.5), (-1 .. -0.5)], [(-0.5 .. 0), (-1 .. -0.5)],
          [(0 .. 0.5), (-1 .. -0.5)], [(0.5 .. 1), (-1 .. -0.5)],
          [(-1 .. -0.5), (-0.5 .. 0)], [(-0.5 .. 0), (-0.5 .. 0)],
          [(0 .. 0.5), (-0.5 .. 0)], [(0.5 .. 1), (-0.5 .. 0)],
          [(-1 .. -0.5), (0 .. 0.5)], [(-0.5 .. 0), (0 .. 0.5)],
          [(0 .. 0.5), (0 .. 0.5)], [(0.5 .. 1), (0 .. 0.5)],
          [(-1 .. -0.5), (0.5 .. 1)], [(-0.5 .. 0), (0.5 .. 1)],
          [(0 .. 0.5), (0.5 .. 1)], [(0.5 .. 1), (0.5 .. 1)]]
    @test mapreduce((x, y) -> all(equal.(x, y)), &, vb2, vv)
    @test all(equal.(convexhull.(vb2...), ib2))
    @test mapreduce((x, y) -> all(equal.(x, y)), &, mince(ib2, (4, 4)), vb2)
    @test mapreduce((x, y) -> all(equal.(x, y)), &, mince(ib2, (1,4)),
        [[(-1 .. 1), (-1 .. -0.5)], [(-1 .. 1), (-0.5 .. 0)], [(-1 .. 1), (0 .. 0.5)], [(-1 .. 1), (0.5 .. 1)]])
    @test all(equal.(convexhull.(mince(ib2, (1,4))...), ib2))

    ib3 = fill(-1..1, 3)
    vb3 = mince(ib3, 4)
    @test length(vb3) == 4^3
    @test all(equal.(convexhull.(vb3...), ib3))
    @test mapreduce((x, y) -> all(equal.(x, y)), &, mince(ib3, (4,4,4)), vb3)
    @test mapreduce((x, y) -> all(equal.(x, y)), &, mince(ib3, (2,1,1)),
        [[(-1 .. 0), (-1 .. 1), (-1 .. 1)], [(0 .. 1), (-1 .. 1), (-1 .. 1)]])
    @test all(equal.(convexhull.(mince(ib3, (2,1,1))...), ib3))

    ib4 = fill(-1..1, 4)
    vb4 = mince(ib4, 4)
    @test length(vb4) == 4^4
    @test all(equal.(convexhull.(vb4...), ib4))
    @test mapreduce((x, y) -> all(equal.(x, y)), &, mince(ib4, (4,4,4,4)), vb4)
    @test mapreduce((x, y) -> all(equal.(x, y)), &, mince(ib4, (1,1,1,1)), (ib4,))
end
