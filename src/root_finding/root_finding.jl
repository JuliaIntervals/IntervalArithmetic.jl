
# immutable Root{T<:Real}
#     interval::Interval{T}
#     existence::Symbol    # :unique or :unknown
# end



# Base.getindex(r::Root, i::Integer) = getfield(r, i)

@which sort!([3, 5, 4])

#typealias Root{T<:Real} @compat Tuple{Interval{T}, Symbol}
immutable Root{T<:Real}
    interval::Interval{T}
    root_type::Symbol
end

show(io::IO, root::Root) = print(io, "Root($(root.interval), :$(root.root_type))")

is_unique{T}(root::Root{T}) = root.root_type == :unique


include("automatic_differentiation.jl")
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
        with_interval_precision(precision) do
            find_roots(f, @interval(a, b), method; tolerance=tolerance, debug=debug, maxlevel=maxlevel)
        end


    else  # use current precision

        find_roots(f, @interval(a, b), method; tolerance=tolerance, debug=debug, maxlevel=maxlevel)

    end
end



function find_roots_midpoint(f::Function, a::Real, b::Real, method::Function=newton;
           tolerance=eps(1.0*a), debug=false, maxlevel=30, precision=-1)

    roots = find_roots(f, a, b, method; tolerance=tolerance, debug=debug, maxlevel=maxlevel, precision=precision)

    midpoints = T[]
    radii = T[]
    root_symbols = Symbol[]  # :unique or :unknown

    if length(roots) == 0
        return (midpoints, radii, root_symbols)  # still empty
    end

    T = eltype(roots[1].interval)



    for root in roots
        midpoint, radius = midpoint_radius(root.interval)
        push!(midpoints, midpoint)
        push!(radii, radius)

        push!(root_symbols, root.root_type)

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
