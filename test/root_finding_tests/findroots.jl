
using ValidatedNumerics, ValidatedNumerics.RootFinding
using ForwardDiff
using Base.Test

const D = RootFinding.derivative

include("wilkinson.jl")


function generate_wilkinson(n)#, T=BigFloat)   # SLOW

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


setprecision(Interval, Float64)
float_pi = @interval(pi)

setprecision(Interval, 10000)
big_pi = @interval(pi)
# Using precision "only" 256 leads to overestimation of the true roots for `cos`
# i.e the Newton method gives more accurate results!

half_pi = big_pi / 2
three_halves_pi = 3*big_pi/2


# Format:  (function, derivative, lower_bound, upper_bound, [true_roots])
function_list = [
                    (sin, cos,    -5,  5,    [ -big_pi, @interval(0), big_pi ] ) ,
                    (cos, x->D(cos, x), -7.5, 7.5, [ -three_halves_pi, -half_pi, half_pi, three_halves_pi ] ),
                    (W₃, x->D(W₃, x),   -10, 10,   [ @interval(1), @interval(2), @interval(3) ] ),
                    (W₇, x->D(W₇, x),   -10, 10,   [ @interval(i) for i in 1:7 ] ),
                    (x->exp(x)-2, y->D(x->exp(x),y),  -20, 20,  [log(@biginterval(2))] ),
                    (x->asin(sin(x)) - 0.1, y->D(x->asin(sin(x)),y), 0, 1, [@biginterval(0.1)])
                ]


@testset "Testing root finding" begin

    for rounding_type in (:wide, :narrow)
        @testset "Interval rounding: $rounding_type" begin
            setrounding(Interval, rounding_type)

            for prec in ( (BigFloat,53), (BigFloat,256), (Float64,64) )
                @testset "Precision: $prec" begin
                    setprecision(Interval, prec)

                    for method in (newton, krawczyk)
                        @testset "Method $method" begin

                            for func in function_list

                                f, f_prime, a_lower, a_upper, true_roots = func
                                a = @interval(a_lower, a_upper)

                                @testset "Function $f; interval $a" begin

                                    for autodiff in (false, true)

                                        @testset "With autodiff=$autodiff" begin

                                            if autodiff
                                                roots = method(f, a)
                                            else
                                                roots = method(f, f_prime, a)
                                            end

                                            @test length(roots) == length(true_roots)

                                            for i in 1:length(roots)
                                                root = roots[i]

                                                @test isa(root, Root{prec[1]})
                                                @test is_unique(root)
                                                @test true_roots[i] ⊆ root.interval
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
    end
end



setprecision(Interval, Float64)

@testset "find_roots tests" begin
    f(x) = x^2 - 2

    roots = newton(f, @interval(10, 11))
    @test length(roots) == 0


    roots = find_roots_midpoint(f, -5, 5)
    @test length(roots) == 3
    @test length(roots[1]) == 2

    roots = find_roots(f, -5, 5)
    @test length(roots) == 2

    setprecision(Interval, 256)

    for method in (newton, krawczyk)
        new_roots = method(f, roots)
        @test length(new_roots) == length(roots)

        for (root1, root2) in zip(new_roots, roots)
            @test root1 ⊆ root2
        end
    end
end

@testset "Multiple roots" begin
    setprecision(Interval, Float64)
    let
        f(x) = (x-1) * (x^2 - 2)^3 * (x^3 - 2)^4

        roots = newton(f, -5..5.1, maxlevel=1000)

        @test length(roots) == 4
        @test roots[1].status == :unknown
        @test roots[1].interval == Interval(-1.4142135623730954, -1.414213562373095)
        @test roots[3].interval == Interval(1.259921049894873, 1.2599210498948734)

    end
end



# Example of a function with a double root at 0 from Burden & Faires, 9th ed, p.84
# exp(x) - x - 1
