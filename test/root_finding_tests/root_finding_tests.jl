using ValidatedNumerics
using Polynomials


# Wilkinson-type polynomial defined by its roots:
# wₙ(x) = (x-1)⋅(x-2)⋅ ⋯ ⋅ (x-n)

function wilkinson_type(n)
    p = poly(collect(1:n))
    p_prime = polyder(p)

    coeffs = map(BigFloat, p.a)
    coeffs_prime = map(BigFloat, p_prime.a)

    # define the polynomial
    # TODO: use Horner's rule for efficiency?
    f(x) = sum( [coeffs[i]*x^(i-1) for i in 1:length(coeffs)] )
    f_prime(x) = sum( [coeffs_prime[i]*x^(i-1) for i in 1:length(coeffs_prime)] )


    a = @interval(-1.1, 21.05)   # where to look for the roots

    println("Roots for n = $n: ")

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
