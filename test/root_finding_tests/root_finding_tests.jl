using ValidatedNumerics
using FactCheck

using Polynomials

# Wilkinson-type polynomial defined by its roots:
# wₙ(x) = (x-1)⋅(x-2)⋅ ⋯ ⋅ (x-n)

# function generate_wilkinson(n, T=BigFloat)
#     p = poly(collect(1:n))
#     p_prime = polyder(p)

#     coeffs = [convert(T, coeff) for coeff in p.a]
#     coeffs_prime = [convert(T, coeff) for coeff in p_prime.a]

#     f(x) = sum( [coeffs[i]*x^(i-1) for i in 1:length(coeffs)] )
#     f_prime(x) = sum( [coeffs_prime[i]*x^(i-1) for i in 1:length(coeffs_prime)] )

#     return f, f_prime
# end

function generate_wilkinson(n)#, T=BigFloat)

    p = poly(collect(1:n))
    p_prime = polyder(p)

    coeffs = p.a #[convert(T, coeff) for coeff in p.a]
    # coeffs_prime = [convert(T, coeff) for coeff in p_prime.a]

    function f(x)
        total = coeffs[1]
        for i in 2:length(coeffs)
            total += coeffs[i]*x^(i-1)
        end
        total
    end

    f
end


is_unique{T}(root::Root{T}) = root[2] == :unique

set_interval_precision(BigFloat)
big_pi = @interval(pi)


set_interval_precision(Float64)
float_pi = @interval(pi)

⊆(a::Interval, b::Root) = a ⊆ b[1]   # the Root object has the interval in the first entry

# TODO rewrite root-finding tests using a table of functions and their roots, e.g.:
#functions = [(sin, cos, -5, 5, [-current_pi, @interval(0), current_pi])]

# Using precision "only" 256 leads to overestimation of the true roots
# i.e the Newton method gives more accurate results!!

set_interval_precision(10000)

big_pi = @interval(pi)
half_pi = big_pi / 2
three_halves_pi = 3*big_pi/2

zero = @interval(0)

#= Wilkinson polynomials:
Generate coefficients via
```
using Polynomials
n = 8
p = poly(collect(1:n))
coeffs = p.a
```
=#

W3(x) = -6 + 11x - 6x^2 + x^3
W7(x) = -5040 + 13068x - 13132x^2 + 6769x^3 - 1960x^4 + 322x^5 - 28x^6 + x^7
# W8 takes too long for tests

# Format:  (function, derivative, lower_bound, upper_bound, [true_roots])
function_list = [
                    (sin, cos,    -5,  5,    [ -big_pi, zero, big_pi ] ) ,
                    (cos, D(cos), -7.5, 7.5, [ -three_halves_pi, -half_pi, half_pi, three_halves_pi ] ),
                    (W3, D(W3),   -10, 10,   [ @interval(1), @interval(2.), @interval(3.) ] ),
                    (W7, D(W7),   -10, 10,   [ @interval(i) for i in 1:7 ] ),
                    (x->exp(x)-2, D(x->exp(x)-2),  -20, 20,  [log(@biginterval(2))] )
                ]


facts("Testing root finding") do
    for interval_precision in (:wide, :narrow)

        context("Interval precision: $interval_precision") do

            for precision_type in ( (BigFloat,53), (BigFloat,256) ) #, (BigFloat,1024) )#, (Float64, -1)
                context("Precision: $precision_type") do

                    set_interval_precision(precision_type)

                    for method in (newton, krawczyk)

                        context("Method $method") do

                            for func in function_list

                                f, f_prime, a_lower, a_upper, true_roots = func
                                a = @interval(a_lower, a_upper)


                                context("Function $f; interval $a") do

                                    roots = method(f, f_prime, a)

                                    for i in 1:length(roots)
                                        root = roots[i]

                                        @fact true_roots[i] ⊆ root => true
                                        @fact isa(root, Root{precision_type[1]}) => true
                                        @fact is_unique(root) => true
                                    end
                                end

                            end
                        end
                    end
                end
            end
        end
    end
end
