
include("automatic_differentiation.jl")
include("newton.jl")
include("krawczyk.jl")


function find_roots(f::Function, a::Interval, method=newton)
    method(f, a)
end

function find_roots(f::Function, f_prime::Function, a::Interval, method=newton)
    method(f, f_prime, a)
end
