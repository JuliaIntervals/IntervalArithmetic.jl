using ValidatedNumerics
using Polynomials


# Wilkinson-type polynomial defined by its roots:
# wₙ(x) = (x-1)⋅(x-2)⋅ ⋯ ⋅ (x-n)

function generate_wilkinson(n, type_constructor=BigFloat)
    p = poly(collect(1:n))
    p_prime = polyder(p)

    coeffs = map(type_constructor, p.a)
    coeffs_prime = map(type_constructor, p_prime.a)

    f(x) = sum( [coeffs[i]*x^(i-1) for i in 1:length(coeffs)] )
    f_prime(x) = sum( [coeffs_prime[i]*x^(i-1) for i in 1:length(coeffs_prime)] )

    return f, f_prime
end


function run_wilkinson(a::Interval, n::Int)

    f, f_prime = generate_wilkinson(n, BigFloat)

    println("Roots for n = $n: ")

    #@time krawczyk_roots = krawczyk(f, a)
    #display(krawczyk_roots)

    @time newton_roots = newton(f, a)
    display(newton_roots)

    @time krawczyk_roots = krawczyk(f, f_prime, a)
    display(krawczyk_roots)

    @time newton_roots = newton(f, f_prime, a)
    display(newton_roots)


    # repeat with Float64 intervals


    f, f_prime = generate_wilkinson(n, float)
    a = floatinterval(a)

    @time krawczyk_roots = krawczyk(f, a)
    display(krawczyk_roots)

    @time newton_roots = newton(f, a)
    display(newton_roots)

    @time krawczyk_roots = krawczyk(f, f_prime, a)
    display(krawczyk_roots)

    @time newton_roots = newton(f, f_prime, a)
    display(newton_roots)



    println()
end

# for n in 1:7
#     println("Doing n = $n")
#     wilkinson_type(n)
# end
