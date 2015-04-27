using Polynomials

a = @interval -5 5
b = @interval -7.3 7.3

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


# roots of sin(x)
facts("Testing zeros of sin(x) in [-5,5]") do
    a = @interval -5 5
    f(x) = sin(x)
    roots_sin = newton(f,a)
    @fact -pi ∈ roots_sin[1][1] => true
    @fact :unique == roots_sin[1][2] => true
    @fact zero(eltype(a)) ∈ roots_sin[2][1] => true
    @fact :unique == roots_sin[2][2] => true
    @fact pi ∈ roots_sin[3][1] => true
    @fact :unique == roots_sin[3][2] => true
end

# roots of cos(x)
facts("Testing zeros of cos(x) in [-7.5,7.5] using @floatinterval") do
    a = @floatinterval -7.5 7.5
    f(x) = cos(x)
    roots_cos = newton(f,a)
    @fact -3pi/2 ∈ roots_cos[1][1] => true
    @fact :unique == roots_cos[1][2] => true
    @fact -pi/2 ∈ roots_cos[2][1] => true
    @fact :unique == roots_cos[2][2] => true
    @fact pi/2 ∈ roots_cos[3][1] => true
    @fact :unique == roots_cos[3][2] => true
    @fact 3pi/2 ∈ roots_cos[4][1] => true
    @fact :unique == roots_cos[1][2] => true
end

facts("Testing zeros of W₃ in [-7.3,7.3]") do
    b = @interval -7.3 7.3
    g, gprime = generate_wilkinson(3)
    roots_w3 = newton(g,b)
    @fact 1.0 ∈ roots_w3[1][1] => true
    @fact :unique == roots_w3[1][2] => true
    @fact 2.0 ∈ roots_w3[2][1] => true
    @fact :unique == roots_w3[2][2] => true
    @fact 3.0 ∈ roots_w3[3][1] => true
    @fact :unique == roots_w3[3][2] => true
end

