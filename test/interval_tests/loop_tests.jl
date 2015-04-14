using ValidatedNumerics
using FactCheck



facts("Interval loop tests") do
    i = 1

    @fact Interval(i,i).lo => 1
    @fact @interval(i).lo => 1


    for i in 1:10
        a = @interval(i)
        @fact a.lo => i
    end

end


## Calculate pi by summing 1/i^2 to give pi^2/6:

set_bigfloat_precision(53)

function calc_pi1(N)
    S1 = @interval(0)

    for i in 1:N
        S1 += @interval(1/i^2)
    end
    S1 += @interval(1/N, 1/(N+1))

    sqrt(6*S1)
end


function calc_pi2(N)
    S2 = @interval(0)

    for i in 1:N
        S2 += 1/i^2
    end
    S2 += @interval(1/N, 1/(N+1))

    sqrt(6*S2)
end


function calc_pi3(N)
    S3 = @floatinterval(0)

    for i in 1:N
        S3 += 1/i^2
    end
    S3 += @floatinterval(1/N, 1/(N+1))

    sqrt(6*S3)
end


facts("Pi tests") do

    N = 10000
    pi1 = calc_pi1(N)
    pi2 = calc_pi2(N)
    pi3 = calc_pi3(N)

    @fact big(pi) ∈ pi1 => true
    @fact big(pi) ∈ pi2 => true
    @fact big(pi) ∈ pi3 => true

    @fact pi1 == pi2 => true
    @fact pi2 == pi3 => true

end
