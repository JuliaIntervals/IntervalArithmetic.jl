using ValidatedNumerics
using FactCheck



facts("Interval loop tests") do
    i = 1

    @fact Interval(i,i).lo --> 1
    @fact @interval(i).lo --> 1


    for i in 1:10
        a = @interval(i)
        @fact a.lo --> i
    end

end


## Calculate pi by summing 1/i^2 to give pi^2/6:

setprecision(Interval, 53)

function calc_pi1(N)
    S1 = @interval(0)

    for i in 1:N
        S1 += @interval(1/i^2)
    end
    S1 += @interval(1/(N+1), 1/N)

    sqrt(6*S1)
end


function calc_pi2(N)
    S2 = @interval(0)

    for i in 1:N
        S2 += 1/i^2
    end
    S2 += @interval(1/(N+1), 1/N)

    sqrt(6*S2)
end


function calc_pi3(N)
    S3 = @floatinterval(0)

    for i in 1:N
        S3 += 1/i^2
    end
    S3 += @floatinterval(1/(N+1), 1/N)

    sqrt(6*S3)
end

function calc_pi4(N)
    S4 = @floatinterval(0)
    II = @floatinterval(1)

    for i in N:-1:1
        S4 += II / (i^2)
    end
    S4 += II / @floatinterval(N, N+1)

    sqrt(6*S4)
end

function calc_pi5(N)
    S5 = @floatinterval(0)
    II = @floatinterval(1)

    for i in N:-1:1
        S5 += 1 // (i^2)
    end
    S5 += 1 / @floatinterval(N, N+1)

    sqrt(6*S5)
end


facts("Pi tests") do

    big_pi = setprecision(256) do
        big(pi)
    end

    N = 10000
    pi1 = calc_pi1(N)
    pi2 = calc_pi2(N)
    pi3 = calc_pi3(N)
    pi4 = calc_pi4(N)
    pi5 = calc_pi5(N)


    @fact big_pi ∈ pi1 --> true
    @fact big_pi ∈ pi2 --> true
    @fact big_pi ∈ pi3 --> true
    @fact big_pi ∈ pi4 --> true
    @fact big_pi ∈ pi5 --> true

    @pending pi1 == pi2 --> true
    @pending pi2 == pi3 --> true

end
