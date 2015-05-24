
include("automatic_differentiation.jl")
include("newton.jl")
include("krawczyk.jl")


typealias Root{T<:Real} @compat Tuple{Interval{T}, Symbol}

function find_roots{T}(f::Function, a::Interval{T}, method::Function = newton;
                    tolerance = eps(T), debug = false, maxlevel = 30)

    method(f, a, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
end

function find_roots{T}(f::Function, f_prime::Function, a::Interval{T}, method::Function=newton;
                    tolerance=eps(T), debug=false, maxlevel=30)

    method(f, f_prime, a, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
end

find_roots(f::Function, a::Real, b::Real, method::Function=newton;
           tolerance=eps(1.0*a), debug=false, maxlevel=30) =

    find_roots(f, @interval(a, b), method, tolerance=tolerance, debug=debug, maxlevel=maxlevel)


@doc doc"""`clean_roots` removes tuples with `:none` from the vector of roots"""->
function clean_roots{T}(roots::Vector{Root{T}})

    new_roots = similar(roots, 0)  # empty
    for root in roots
        if root[2] != :none
            push!(new_roots, root)
        end
    end

    sort!(new_roots)
    new_roots
end
