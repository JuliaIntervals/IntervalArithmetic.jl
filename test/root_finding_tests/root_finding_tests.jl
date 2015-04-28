using ValidatedNumerics
using FactCheck

using Polynomials

# Wilkinson-type polynomial defined by its roots:
# wₙ(x) = (x-1)⋅(x-2)⋅ ⋯ ⋅ (x-n)

function generate_wilkinson(n, T=BigFloat)
    p = poly(collect(1:n))
    p_prime = polyder(p)

    coeffs = [convert(T, coeff) for coeff in p.a]
    coeffs_prime = [convert(T, coeff) for coeff in p_prime.a]

    f(x) = sum( [coeffs[i]*x^(i-1) for i in 1:length(coeffs)] )
    f_prime(x) = sum( [coeffs_prime[i]*x^(i-1) for i in 1:length(coeffs_prime)] )

    return f, f_prime
end


is_unique{T}(root::Root{T}) = root[2] == :unique


a = @interval(-5, 5)
f = sin
facts("Testing zeros of $f in $a") do
    roots_sin = newton(f, a)

    @fact -pi ∈ roots_sin[1][1] => true
    @fact zero(eltype(a)) ∈ roots_sin[2][1] => true
    @fact pi ∈ roots_sin[3][1] => true

    for root in roots_sin
        @fact isa(root, Root{BigFloat}) => true
        @fact is_unique(root) => true
    end
end


a = @floatinterval(-7.5, 7.5)
f = cos
facts("Testing zeros of $f in $a using @floatinterval") do
    roots_cos = newton(f,a)
    @fact -3pi/2 ∈ roots_cos[1][1] => true
    @fact -pi/2 ∈ roots_cos[2][1] => true
    @fact pi/2 ∈ roots_cos[3][1] => true
    @fact 3pi/2 ∈ roots_cos[4][1] => true

    for root in roots_cos
        @fact isa(root, Root{Float64}) => true
        @fact is_unique(root) => true
    end
end


b = @interval(-7.3, 7.3)
W₃, W₃_prime = generate_wilkinson(3)

facts("Testing zeros of W₃ in $b") do 
    roots_w3 = newton(W₃, b)
    @fact 1.0 ∈ roots_w3[1][1] => true
    @fact 2.0 ∈ roots_w3[2][1] => true
    @fact 3.0 ∈ roots_w3[3][1] => true

    for root in roots_w3
        @fact isa(root, Root{BigFloat}) => true
        @fact is_unique(root) => true
    end
end

