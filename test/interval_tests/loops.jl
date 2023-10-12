using Test
using IntervalArithmetic


@testset "Interval loop tests" begin
    i = 1

    @test interval(i, i).lo == 1
    @test interval(i).lo == 1


    for i in 1:10
        a = interval(i)
        @test a.lo == i
    end
end


## Calculate pi by summing 1/i^2 to give pi^2/6:

function calc_pi1(N)
    S1 = interval(0)

    for i in 1:N
        S1 += 1/interval(i)^2
    end
    S1 += interval(1/interval(N+1), 1/interval(N))

    sqrt(6*S1)
end

function calc_pi2(N)
    S2 = interval(0)

    for i in 1:N
        S2 += 1 / i^2
    end
    S2 += interval(1/interval(N+1), 1/interval(N))

    sqrt(6*S2)
end

function calc_pi3(N)
    S3 = interval(0)

    for i in 1:N
        S3 += 1 / i^2
    end
    S3 += parse(Interval{Float64}, "[1/$(N+1), 1/$N]")

    sqrt(6*S3)
end

function calc_pi4(N)
    S4 = interval(0)
    II = interval(1)

    for i in N:-1:1
        S4 += II / i^2
    end
    S4 += II / interval(N, N+1)

    sqrt(6*S4)
end

function calc_pi5(N)
    S5 = interval(0)

    for i in N:-1:1
        S5 += 1 // i^2
    end
    S5 += 1 / interval(N, N+1)

    sqrt(6*S5)
end

@testset "Pi tests" begin
    big_pi = setprecision(256) do
        big(pi)
    end

    N = 10000
    pi1 = calc_pi1(N)
    pi2 = calc_pi2(N)
    pi3 = calc_pi3(N)
    pi4 = calc_pi4(N)
    pi5 = calc_pi5(N)


    @test in_interval(big_pi, pi1)
    @test in_interval(big_pi, pi2)
    @test in_interval(big_pi, pi3)
    @test in_interval(big_pi, pi4)
    @test in_interval(big_pi, pi5)

    @test isequal_interval(pi1, pi2)
    @test isequal_interval(pi2, pi3)
end
