
include("automatic_differentiation.jl")
include("newton.jl")
include("krawczyk.jl")


function findroots(f::Function, a::Interval, method::Function=newton)
    method(f, a)
end

function findroots(f::Function, f_prime::Function, a::Interval, method::Function=newton)
    method(f, f_prime, a)
end

findroots(f::Function, a::Real, b::Real, method::Function=newton) = findroots(f, Interval(float(a), float(b)), method)
