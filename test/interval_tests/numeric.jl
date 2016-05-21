# This file is part of the ValidatedNumerics.jl package; MIT licensed

using ValidatedNumerics
using FactCheck

setprecision(Interval, Float64)
setrounding(Interval, :narrow)


facts("Numeric tests") do

    a = @interval(0.1, 1.1)
    b = @interval(0.9, 2.0)
    c = @interval(0.25, 4.0)


    ## Basic arithmetic
    @fact @interval(0.1) --> Interval(9.9999999999999992e-02, 1.0000000000000001e-01)
    @fact +a == a --> true
    @fact a+b --> Interval(9.9999999999999989e-01, 3.1000000000000001e+00)
    @fact -a --> Interval(-1.1000000000000001e+00, -9.9999999999999992e-02)
    @fact a-b --> Interval(-1.9000000000000001e+00, 2.0000000000000018e-01)
    @fact Interval(1//4,1//2) + Interval(2//3) --> Interval(11//12, 7//6)
    @fact Interval(1//4,1//2) - Interval(2//3) --> Interval(-5//12, -1//6)

    @fact 10a --> @interval(10a)
    #@fact 10Interval(1//10) --> one(@interval(1//10))
    @fact Interval(-30.0,-15.0) / Interval(-5.0,-3.0) --> Interval(3.0, 10.0)
    @fact @interval(-30,-15) / @interval(-5,-3) --> Interval(3.0, 10.0)
    @fact b/a --> Interval(8.18181818181818e-01, 2.0000000000000004e+01)
    @fact a/c --> Interval(2.4999999999999998e-02, 4.4000000000000004e+00)
    @fact c/4.0 --> Interval(6.25e-02, 1e+00)
    @fact c/zero(c) --> emptyinterval(c)
    @fact Interval(0.0, 1.0)/Interval(0.0,1.0) --> Interval(0.0, Inf)
    @fact Interval(-1.0, 1.0)/Interval(0.0,1.0) --> entireinterval(c)
    @fact Interval(-1.0, 1.0)/Interval(-1.0,1.0) --> entireinterval(c)
    a = @interval(1.e-20)
    @fact a --> Interval(1.0e-20, 1.0000000000000001e-20)
    @fact diam(a) --> eps(1.e-20)
end

facts("Power tests") do
    @fact @interval(0,3) ^ 2 --> Interval(0, 9)
    @fact @interval(2,3) ^ 2 --> Interval(4, 9)
    @fact @interval(-3,0) ^ 2 --> Interval(0, 9)
    @fact @interval(-3,-2) ^ 2 --> Interval(4, 9)
    @fact @interval(-3,2) ^ 2 --> Interval(0, 9)
    @fact @interval(0,3) ^ 3 --> Interval(0, 27)
    @fact @interval(2,3) ^ 3 --> Interval(8, 27)
    @fact @interval(-3,0) ^ 3 --> @interval(-27., 0.)
    @fact @interval(-3,-2) ^ 3 --> @interval(-27, -8)
    @fact @interval(-3,2) ^ 3 --> @interval(-27., 8.)
    @fact Interval(0,3) ^ -2 --> Interval(1/9, Inf)
    @fact Interval(-3,0) ^ -2 --> Interval(1/9, Inf)
    @fact Interval(-3,2) ^ -2 --> Interval(1/9, Inf)
    @fact Interval(2,3) ^ -2 --> Interval(1/9, 1/4)
    @fact Interval(1,2) ^ -3 --> Interval(1/8, 1.0)
    @fact Interval(0,3) ^ -3 --> @interval(1/27, Inf)
    @fact Interval(-1,2) ^ -3 --> entireinterval()
    @fact_throws ArgumentError Interval(-1, -2) ^ -3  # wrong way round
    @fact Interval(-3,2) ^ (3//1) --> Interval(-27, 8)
    @fact Interval(0.0) ^ 1.1 --> Interval(0, 0)
    @fact Interval(0.0) ^ 0.0 --> emptyinterval()
    @fact Interval(0.0) ^ (1//10) --> Interval(0, 0)
    @fact Interval(0.0) ^ (-1//10) --> emptyinterval()
    @fact ∅ ^ 0 --> ∅
    @fact Interval(2.5)^3 --> Interval(15.625, 15.625)
    #@fact Interval(5//2)^3.0 --> Interval(125//8)

    x = @interval(-3,2)
    @fact x^3 --> @interval(-27, 8)

    @fact @interval(-3,4) ^ 0.5 --> @interval(0, 2)
    @fact @interval(-3,4) ^ 0.5 --> @interval(-3,4)^(1//2)
    @fact @interval(-3,2) ^ @interval(2) --> Interval(0.0, 4.0)
    @fact @interval(-3,4) ^ @interval(0.5) --> Interval(0, 2)
    @fact @biginterval(-3,4) ^ 0.5 --> @biginterval(0, 2)

    @fact @interval(1,27)^@interval(1/3) --> roughly(Interval(1., 3.))
    @fact @interval(1,27)^(1/3) --> roughly(Interval(1., 3.))
    @fact Interval(1., 3.) ⊆ @interval(1,27)^(1//3) --> true
    @fact @interval(0.1,0.7)^(1//3) --> Interval(0.46415888336127786, 0.8879040017426008)
    @fact @interval(0.1,0.7)^(1/3)  --> roughly(Interval(0.46415888336127786, 0.8879040017426008))

    setprecision(Interval, 256)
    x = @biginterval(27)
    y = x^(1//3)
    @fact (0 < diam(y) < 1e-76) --> true
    y = x^(1/3)
    @fact (0 < diam(y) < 1e-76) --> true
    @fact x^(1//3) --> x^(1/3)
end

setprecision(Interval, Float64)

facts("Exp and log tests") do
    @fact exp(@biginterval(1//2)) ⊆ exp(@interval(1//2)) --> true
    @fact exp(@interval(1//2)) --> Interval(1.648721270700128, 1.6487212707001282)
    @fact exp(@biginterval(0.1)) ⊆ exp(@interval(0.1)) --> true
    @fact exp(@interval(0.1)) --> Interval(1.1051709180756475e+00, 1.1051709180756477e+00)
    @fact diam(exp(@interval(0.1))) --> eps(exp(0.1))

    @fact log(@biginterval(1//2)) ⊆ log(@interval(1//2)) --> true
    @fact log(@interval(1//2)) --> Interval(-6.931471805599454e-01, -6.9314718055994529e-01)
    @fact log(@biginterval(0.1)) ⊆ log(@interval(0.1)) --> true
    @fact log(@interval(0.1)) --> Interval(-2.3025850929940459e+00, -2.3025850929940455e+00)
    @fact diam(log(@interval(0.1))) --> eps(log(0.1))

    @fact exp2(@biginterval(1//2)) ⊆ exp2(@interval(1//2)) --> true
    @fact exp2(Interval(1024.0)) --> Interval(1.7976931348623157e308, Inf)
    @fact exp10(@biginterval(1//2)) ⊆ exp10(@interval(1//2)) --> true
    @fact exp10(Interval(308.5)) --> Interval(1.7976931348623157e308, Inf)

    @fact log2(@biginterval(1//2)) ⊆ log2(@interval(1//2)) --> true
    @fact log2(@interval(0.25, 0.5)) --> Interval(-2.0, -1.0)
    @fact log10(@biginterval(1//10)) ⊆ log10(@interval(1//10)) --> true
    @fact log10(@interval(0.01, 0.1)) --> @interval(log10(0.01), log10(0.1))
end

facts("Comparison tests") do
    d = @interval(0.1, 2)

    @fact d < 3 --> true
    @fact d <= 2 --> true
    @fact d < 2 --> false
    @fact -1 < d --> true
    @fact !(d < 0.15) --> true

    # abs
    @fact abs(@interval(0.1, 0.2)) --> Interval(9.9999999999999992e-02, 2.0000000000000001e-01)
    @fact abs(@interval(-1, 2)) --> Interval(0, 2)

    # real
    @fact real(@interval(-1, 1)) --> Interval(-1, 1)
end

facts("Rational tests") do

    f = 1 // 3
    g = 1 // 3

    @fact @interval(f*g) --> Interval(1.1111111111111109e-01, 1.1111111111111115e-01)
    @fact big(1.)/9 ∈ @interval(f*g) --> true
    @fact @interval(1)/9 ⊆ @interval(f*g) --> true
    @fact @interval(1)/9 ≠ @interval(f*g) --> true

    h = 1/3
    i = 1/3

    @fact @interval(h*i) --> Interval(1.1111111111111109e-01, 1.1111111111111115e-01)
    @fact big(1.)/9 ∈ @interval(1/9) --> true

    @fact @interval(1/9) == @interval(1//9) --> true
end

facts("Floor etc. tests") do
    a = @interval(0.1)
    b = Interval(0.1, 0.1)
    @fact dist(a,b) <= eps(a) --> true

    @fact floor(@interval(0.1, 1.1)) --> Interval(0, 1)
    @fact round(@interval(0.1, 1.1), RoundDown) --> Interval(0, 1)
    @fact ceil(@interval(0.1, 1.1)) --> Interval(1, 2)
    @fact round(@interval(0.1, 1.1), RoundUp) --> Interval(1, 2)
    @fact sign(@interval(0.1, 1.1)) --> Interval(1.0)
    @fact trunc(@interval(0.1, 1.1)) --> Interval(0.0, 1.0)
    @fact round(@interval(0.1, 1.1), RoundToZero) --> Interval(0.0, 1.0)
    @fact round(@interval(0.1, 1.1)) --> Interval(0.0, 1.0)
    @fact round(@interval(0.1, 1.5)) --> Interval(0.0, 2.0)
    @fact round(@interval(-1.5, 0.1)) --> Interval(-2.0, 0.0)
    @fact round(@interval(-2.5, 0.1)) --> Interval(-2.0, 0.0)
    @fact round(@interval(0.1, 1.1), RoundTiesToEven) --> Interval(0.0, 1.0)
    @fact round(@interval(0.1, 1.5), RoundTiesToEven) --> Interval(0.0, 2.0)
    @fact round(@interval(-1.5, 0.1), RoundTiesToEven) --> Interval(-2.0, 0.0)
    @fact round(@interval(-2.5, 0.1), RoundTiesToEven) --> Interval(-2.0, 0.0)
    @fact round(@interval(0.1, 1.1), RoundTiesToAway) --> Interval(0.0, 1.0)
    @fact round(@interval(0.1, 1.5), RoundTiesToAway) --> Interval(0.0, 2.0)
    @fact round(@interval(-1.5, 0.1), RoundTiesToAway) --> Interval(-2.0, 0.0)
    @fact round(@interval(-2.5, 0.1), RoundTiesToAway) --> Interval(-3.0, 0.0)

    # :wide tests
    setrounding(Interval, :wide)
    setprecision(Interval, Float64)

    a = @interval(-3.0, 2.0)
    @fact a --> Interval(-3.0, 2.0)
    @fact a^3 --> Interval(-27.000000000000004, 8.000000000000002)
    @fact Interval(-3,2)^3 --> Interval(-27.000000000000004, 8.000000000000002)

    @fact Interval(-27.0, 8.0)^(1//3) --> Interval(-5.0e-324, 2.0000000000000004)

    setrounding(Interval, :narrow)
end
