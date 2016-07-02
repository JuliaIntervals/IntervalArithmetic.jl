# This file is part of the ValidatedNumerics.jl package; MIT licensed

module RootFinding

using ValidatedNumerics
using ForwardDiff

## Root finding
export
    newton, krawczyk,
    derivative, jacobian,  # reexport derivative from ForwardDiff
    Root, is_unique,
    find_roots,
    find_roots_midpoint

import Base: ⊆

const derivative = ForwardDiff.derivative
const D = derivative

immutable Root{T<:Real}
    interval::Interval{T}
    status::Symbol
end

show(io::IO, root::Root) = print(io, "Root($(root.interval), :$(root.status))")

is_unique{T}(root::Root{T}) = root.status == :unique

⊆(a::Interval, b::Root) = a ⊆ b.interval   # the Root object has the interval in the first entry
⊆(a::Root, b::Root) = a.interval ⊆ b.interval


# include("automatic_differentiation.jl")
include("newton.jl")
include("krawczyk.jl")


function find_roots{T}(f::Function, a::Interval{T}, method::Function = newton;
                    tolerance = eps(T), debug = false, maxlevel = 30)

    method(f, a; tolerance=tolerance, debug=debug, maxlevel=maxlevel)
end

function find_roots{T}(f::Function, f_prime::Function, a::Interval{T}, method::Function=newton;
                    tolerance=eps(T), debug=false, maxlevel=30)

    method(f, f_prime, a; tolerance=tolerance, debug=debug, maxlevel=maxlevel)
end

function find_roots(f::Function, a::Real, b::Real, method::Function=newton;
           tolerance=eps(1.0*a), debug=false, maxlevel=30, precision::Int=-1)

    if precision >= 0
        setprecision(Interval, precision) do
            find_roots(f, @interval(a, b), method; tolerance=tolerance, debug=debug, maxlevel=maxlevel)
        end


    else  # use current precision

        find_roots(f, @interval(a, b), method; tolerance=tolerance, debug=debug, maxlevel=maxlevel)

    end
end



function find_roots_midpoint(f::Function, a::Real, b::Real, method::Function=newton;
           tolerance=eps(1.0*a), debug=false, maxlevel=30, precision=-1)

    roots = find_roots(f, a, b, method; tolerance=tolerance, debug=debug, maxlevel=maxlevel, precision=precision)

    T = eltype(roots[1].interval)

    midpoints = T[]
    radii = T[]
    root_symbols = Symbol[]  # :unique or :unknown

    if length(roots) == 0
        return (midpoints, radii, root_symbols)  # still empty
    end

    for root in roots
        midpoint, radius = midpoint_radius(root.interval)
        push!(midpoints, midpoint)
        push!(radii, radius)

        push!(root_symbols, root.status)

    end

    (midpoints, radii, root_symbols)

end

function Base.lexcmp{T}(a::Interval{T}, b::Interval{T})
    #@show a, b
    if a.lo < b.lo
        return -1
    elseif a.lo == b.lo
        if a.hi < b.hi
            return -1
        else
            return 0
        end
    end
    return 1

end

Base.lexcmp{T}(a::Root{T}, b::Root{T}) = lexcmp(a.interval, b.interval)


function clean_roots(f, roots)

    # order, remove duplicates, and include intervals X only if f(X) contains 0
    sort!(roots, lt=lexless)
    roots = unique(roots)
    roots = filter(x -> 0 ∈ f(x.interval), roots)

    # merge neighbouring roots if they touch:

    if length(roots) < 2
        return roots
    end


    new_roots = eltype(roots)[]

    base_root = roots[1]

    for i in 2:length(roots)
        current_root = roots[i]

        if isempty(base_root.interval ∩ current_root.interval) ||
                (base_root.status != current_root.status)

            push!(new_roots, base_root)
            base_root = current_root
        else
            base_root = Root(hull(base_root.interval, current_root.interval), base_root.status)
        end
    end

    push!(new_roots, base_root)

    return new_roots

end

end
