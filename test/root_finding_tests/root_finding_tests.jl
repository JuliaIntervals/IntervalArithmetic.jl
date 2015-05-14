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


facts("Testing root_finding methods") do

    for method in (newton, krawczyk)

        a = @interval(-5, 5)
        f = sin
        f_prime = cos
        context("Testing zeros using $method of $f in $a") do
            res = BigFloat[-pi, 0.0, pi]
            roots_sin = method(f, f_prime, a)
            for i in 1:length(roots_sin)
                root = roots_sin[i]
                @fact res[i] ∈ root[1] => true
                @fact isa(root, Root{BigFloat}) => true
                @fact is_unique(root) => true
            end
        end

        a = @floatinterval(-7.5, 7.5)
        f = cos
        context("Testing zeros using $method of $f in $a") do
            res = [-3pi/2, -pi/2, pi/2, 3pi/2]
            roots_cos = method(f, a)
            for i in 1:length(roots_cos)
                root = roots_cos[i]
                @fact res[i] ∈ root[1] => true
                @fact isa(root, Root{Float64}) => true
                @fact is_unique(root) => true
            end
        end

        b = @interval(-7.3, 7.3)
        W₃, W₃_prime = generate_wilkinson(3)
        context("Testing zeros of W₃ in $b") do 
            res = BigFloat[1.0, 2.0, 3.0]
            roots_w3 = method(W₃, W₃_prime, b)
            for i in length(roots_w3)
                root = roots_w3[i]
                @fact res[i] ∈ root[1] => true
                @fact isa(root, Root{BigFloat}) => true
                @fact is_unique(root) => true
            end
        end
    end
end


