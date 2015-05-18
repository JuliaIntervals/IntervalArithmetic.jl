# Wilkinson-type polynomial defined by its roots:
# wₙ(x) = (x-1)⋅(x-2)⋅ ⋯ ⋅ (x-n)

using Polynomials


# function generate_wilkinson(n)#, T=BigFloat)   # SLOW

#     p = poly(collect(1:n))
#     p_prime = polyder(p)

#     coeffs = p.a #[convert(T, coeff) for coeff in p.a]
#     # coeffs_prime = [convert(T, coeff) for coeff in p_prime.a]

#     function f(x)
#         total = coeffs[1]
#         for i in 2:length(coeffs)
#             total += coeffs[i]*x^(i-1)
#         end
#         total
#     end

#     f
# end

function generate_wilkinson_horner(n)
    p = poly(collect(1:n))  # make polynomial with roots 1 to n

    coeffs = p.a

    expr = :($(coeffs[end]))

    for i in length(coeffs)-1:-1:1
        expr = :($expr*x + $(coeffs[i]))
    end

    expr
end

function subscriptify(n::Int)
    subscript_digits = [c for c in "₀₁₂₃₄₅₆₇₈₉"]
    dig = reverse(digits(n))
    join([subscript_digits[i+1] for i in dig])
end

# Generate Wilkinson functions W₃ etc.:
for n in 1:15
    fn_name = symbol(string("W", subscriptify(n)))
    expr = generate_wilkinson_horner(n)

    @eval $(fn_name)(x) = $(expr)
end

