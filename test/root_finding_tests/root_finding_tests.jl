using ValidatedNumerics
using Polynomials


# w = poly(collect(1:20))  # Wilkinson polynomial
# coeffs = map(BigFloat, w.a)

# wilkinson(x) = sum( [coeffs[i]*x^(i-1) for i in 1:21] )

# #wilkinson(x) = polyval(w, x)

# a = @interval(-1, 21)

# #@time newton_roots = newton(wilkinson, a)
# @time krawczyk_roots = krawczyk(wilkinson, a)


# try with smaller polynomials:

function wilkinson_type(n)
    p = poly(collect(1:n))  # Wilkinson-type polynomial
    coeffs = map(BigFloat, p.a)

    f(x) = sum( [coeffs[i]*x^(i-1) for i in 1:length(coeffs)] )

    #wilkinson(x) = polyval(w, x)

    a = @interval(-1, 21)

    #@time newton_roots = newton(wilkinson, a)
    @time krawczyk_roots = krawczyk(f, a)
    @time newton_roots = newton(f, a)

    println("Roots for n = $n: ")
    display(krawczyk_roots)
    display(newton_roots)
    println()
end

for n in 1:10
    println("Doing n = $n")
    wilkinson_type(n)
end
