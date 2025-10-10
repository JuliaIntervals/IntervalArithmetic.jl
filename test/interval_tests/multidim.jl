using IntervalArithmetic.Symbols

@testset "Linear algebra" begin
    IntervalArithmetic.configure(; matmul = :slow)
    A = [interval(2, 4)  interval(-2, 1)
         interval(-1, 2) interval(2, 4)]

    b = [interval(-2, 2)
         interval(-2, 2)]

    @test all(isequal_interval.(A * b, [interval(-12, 12), interval(-12, 12)]))
    @test_throws ArgumentError A \ b

    @test all(isequal_interval.(interval.([1 2; 3 4]) * interval(-1, 1), [interval(-1, 1) interval(-2, 2) ; interval(-3, 3) interval(-4, 4)]))
    IntervalArithmetic.configure(; matmul = :fast)
end


@testset "interiordiff" begin
    function sameset(A, B)
        length(A) != length(B) && return false
        for a ∈ A
            found = false
            for b ∈ B
                if all(isequal_interval.(a, b))
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
        interiordiff(X, Y),
        [ [3..4, 3..4],
          [2..3, 3..5] ])

    X = [2..5, 3..6]
    Y = [-10..10, 4..5]
    @test sameset(
        interiordiff(X, Y),
        [ [2..5, 3..4],
          [2..5, 5..6] ])

    X = [2..5, 3..6]
    Y = [4..6, 4..5]
    @test sameset(
        interiordiff(X, Y),
        [ [4..5, 3..4],
          [4..5, 5..6],
          [2..4, 3..6] ])

    X = [2..5, 3..6]
    Y = [3..4, 4..5]
    @test sameset(
        interiordiff(X, Y),
        [ [3..4, 3..4],
          [3..4, 5..6],
          [2..3, 3..6],
          [4..5, 3..6] ])

    X = [2..5, 3..6]
    Y = [2..4, 10..20]
    @test sameset(interiordiff(X, Y), typeof(X)[X])

    X = [2..5, 3..6]
    Y = [-10..10, -10..10]
    @test sameset(interiordiff(X, Y), typeof(X)[])

    X = [1..4, 3..6, 7..10]
    Y = [2..3, 4..5, 8..9]
    @test sameset(
        interiordiff(X, Y),
        [ [2..3, 4..5, 7..8],
          [2..3, 4..5, 9..10],
          [2..3, 3..4, 7..10],
          [2..3, 5..6, 7..10],
          [1..2, 3..6, 7..10],
          [3..4, 3..6, 7..10] ])

    X = [-Inf..Inf, 1..2]
    Y = [1..2, -1..1.5]
    @test sameset(
        interiordiff(X, Y),
        [ [-Inf..1, 1..2],
          [2..Inf, 1..2],
          [1..2, 1.5..2] ])
end

@testset "Mince and hull" begin
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
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, vb2, vv)
    @test all(enumerate(ib2)) do (i, Ib)
        hulled = reduce(hull, [vb2[k][i] for k in eachindex(vb2)])
        isequal_interval(hulled, Ib)
    end
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib2, (4, 4)), vb2)
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib2, (1,4)),
        [[(-1 .. 1), (-1 .. -0.5)], [(-1 .. 1), (-0.5 .. 0)], [(-1 .. 1), (0 .. 0.5)], [(-1 .. 1), (0.5 .. 1)]])

    vb2bis = mince(ib2, (1,4))
    @test all(enumerate(ib2)) do (i, Ib)
        hulled = reduce(hull, [vb2bis[k][i] for k in eachindex(vb2bis)])
        isequal_interval(hulled, Ib)
    end

    ib3 = fill(-1..1, 3)
    vb3 = mince(ib3, 4)
    @test length(vb3) == 4^3
    @test all(enumerate(ib3)) do (i, Ib)
        hulled = reduce(hull, [vb3[k][i] for k in eachindex(vb3)])
        isequal_interval(hulled, Ib)
    end
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib3, (4,4,4)), vb3)
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib3, (2,1,1)),
        [[(-1 .. 0), (-1 .. 1), (-1 .. 1)], [(0 .. 1), (-1 .. 1), (-1 .. 1)]])
    vb3bis = mince(ib3, (2,1,1))
    @test all(enumerate(ib3)) do (i, Ib)
        hulled = reduce(hull, [vb3bis[k][i] for k in eachindex(vb3bis)])
        isequal_interval(hulled, Ib)
    end

    ib4 = fill(-1..1, 4)
    vb4 = mince(ib4, 4)
    @test length(vb4) == 4^4
    @test all(enumerate(ib4)) do (i, Ib)
        hulled = reduce(hull, [vb4[k][i] for k in eachindex(vb4)])
        isequal_interval(hulled, Ib)
    end
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib4, (4,4,4,4)), vb4)
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib4, (1,1,1,1)), (ib4,))
end

@testset "Bisect" begin
    v = [interval(0, 1), interval(0, 2)]
    w = bisect(v, 1, 0.5)
    @test all(isequal_interval.( w[1], [interval(0, 0.5), interval(0, 2)] )) &
          all(isequal_interval.( w[2], [interval(0.5, 1), interval(0, 2)] ))
    w = bisect(v, 2, 0.5)
    @test all(isequal_interval.( w[1], [interval(0, 1), interval(0, 1)] )) &
          all(isequal_interval.( w[2], [interval(0, 1), interval(1, 2)] ))
    w = bisect(v, 1, 0.25)
    @test all(isequal_interval.( w[1], [interval(0, 0.25), interval(0, 2)] )) &
          all(isequal_interval.( w[2], [interval(0.25, 1), interval(0, 2)] ))
    w = bisect(v, 2, 0.25)
    @test all(isequal_interval.( w[1], [interval(0, 1), interval(0, 0.5)] )) &
          all(isequal_interval.( w[2], [interval(0, 1), interval(0.5, 2)] ))
    w = bisect(v, 1)
    @test all(isequal_interval.( w[1], [interval(0, 0.5), interval(0, 2)] )) &
          all(isequal_interval.( w[2], [interval(0.5, 1), interval(0, 2)] ))
    w = bisect(v, 2)
    @test all(isequal_interval.( w[1], [interval(0, 1), interval(0, 1)] )) &
          all(isequal_interval.( w[2], [interval(0, 1), interval(1, 2)] ))

    v = [interval(-Inf, Inf), interval(-Inf, Inf)]
    w = bisect(v, 1, 0.5)
    @test all(isequal_interval.( w[1], [interval(-Inf, 0), interval(-Inf, Inf)] )) &
          all(isequal_interval.( w[2], [interval(0, Inf),  interval(-Inf, Inf)] ))
end
