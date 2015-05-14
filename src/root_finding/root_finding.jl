
include("automatic_differentiation.jl")
include("newton.jl")
include("krawczyk.jl")

typealias Root{T<:Real} @compat Tuple{Interval{T}, Symbol}

function find_roots(f::Function, a::Interval, method::Function=newton;
    tolerance=eps(one(T)), debug=false, maxlevel=30)
    method(f, a, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
end

function find_roots(f::Function, f_prime::Function, a::Interval, method::Function=newton;
    tolerance=eps(one(T)), debug=false, maxlevel=30)
    method(f, f_prime, a, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
end

find_roots(f::Function, a::Real, b::Real, method::Function=newton;
    tolerance=eps(one(T)), debug=false, maxlevel=30) =
    find_roots(f, Interval(float(a), float(b)), method, tolerance=tolerance,
        debug=debug, maxlevel=maxlevel)
