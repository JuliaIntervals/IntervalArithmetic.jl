
include("automatic_differentiation.jl")
include("newton.jl")
include("krawczyk.jl")


function find_roots(f::Function, a::Interval, method::Function=newton)
    method(f, a)
end

function find_roots(f::Function, f_prime::Function, a::Interval, method::Function=newton)
    method(f, f_prime, a)
end

find_roots(f::Function, a::Real, b::Real) = find_roots(f, Interval(float(a), float(b)))
