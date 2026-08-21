module IntervalArithmeticRecipesBaseExt

using IntervalArithmetic, RecipesBase

# a vector of 2 (resp. 3) intervals is interpreted as a rectangle (resp. a cuboid)

_rectangle(x, y) =
    ([inf(x), sup(x), sup(x), inf(x), inf(x)],
     [inf(y), inf(y), sup(y), sup(y), inf(y)])

# path visiting the 12 edges of a cuboid; 4 edges are traversed twice since the
# cuboid graph has no Eulerian path

_cuboid_edges(x, y, z) =
    ([inf(x), sup(x), sup(x), inf(x), inf(x), inf(x), inf(x), inf(x), inf(x), inf(x), sup(x), sup(x), sup(x), sup(x), sup(x), sup(x), inf(x)],
     [inf(y), inf(y), inf(y), inf(y), inf(y), sup(y), sup(y), inf(y), inf(y), sup(y), sup(y), inf(y), sup(y), sup(y), inf(y), sup(y), sup(y)],
     [inf(z), inf(z), sup(z), sup(z), inf(z), inf(z), sup(z), sup(z), inf(z), inf(z), inf(z), inf(z), inf(z), sup(z), sup(z), sup(z), sup(z)])

_cuboid_vertices(x, y, z) =
    ([inf(x), inf(x), inf(x), inf(x), sup(x), sup(x), sup(x), sup(x)],
     [inf(y), sup(y), inf(y), sup(y), inf(y), inf(y), sup(y), sup(y)],
     [inf(z), inf(z), sup(z), sup(z), sup(z), inf(z), inf(z), sup(z)])

# triangulation of the faces of a cuboid, indexing into `_cuboid_vertices`

const _cuboid_connections = [(1,2,3), (4,2,3), (4,7,8), (7,5,6), (2,4,7), (1,6,2), (2,7,6), (7,8,5), (4,8,5), (4,5,3), (1,6,3), (6,3,5)]

@recipe function f(v::AbstractVector{<:Interval})
    if length(v) == 2

        seriestype := :shape
        seriesalpha --> 0.5

        return _rectangle(v...)

    elseif length(v) == 3

        @series begin
            seriestype := :path
            linecolor --> :gray
            linewidth --> 0.5

            return _cuboid_edges(v...)
        end

        @series begin
            seriestype := :mesh3d
            primary := false
            connections --> _cuboid_connections
            proj_type --> :persp
            seriesalpha --> 0.5
            linewidth --> -1.0

            return _cuboid_vertices(v...)
        end

    else
        return throw(ArgumentError("boxes must have length 2 or 3"))
    end
end

@recipe function f(v::AbstractVector{<:AbstractVector{<:Interval}})
    if all(vᵢ -> length(vᵢ) == 2, v)

        seriestype := :shape
        seriesalpha --> 0.5

        xs = Float64[]
        ys = Float64[]

        for vᵢ ∈ v
            xᵢ, yᵢ = _rectangle(vᵢ...)
            append!(xs, xᵢ, NaN)
            append!(ys, yᵢ, NaN)
        end

        return xs, ys

    elseif all(vᵢ -> length(vᵢ) == 3, v)

        @series begin
            seriestype := :path
            linecolor --> :gray
            linewidth --> 0.5

            xs = Float64[]
            ys = Float64[]
            zs = Float64[]

            for vᵢ ∈ v
                xᵢ, yᵢ, zᵢ = _cuboid_edges(vᵢ...)
                append!(xs, xᵢ)
                append!(ys, yᵢ)
                append!(zs, zᵢ)
            end

            return xs, ys, zs
        end

        @series begin
            seriestype := :mesh3d
            primary := false
            connections --> _cuboid_connections
            proj_type --> :persp
            seriesalpha --> 0.5
            linewidth --> -1.0

            xs = Vector{Float64}[]
            ys = Vector{Float64}[]
            zs = Vector{Float64}[]

            for vᵢ ∈ v
                xᵢ, yᵢ, zᵢ = _cuboid_vertices(vᵢ...)
                push!(xs, xᵢ)
                push!(ys, yᵢ)
                push!(zs, zᵢ)
            end

            return xs, ys, zs
        end

    else
        return throw(ArgumentError("boxes must all have length 2, or all have length 3"))
    end
end

# enclosure of a function over a grid

@recipe function f(x::AbstractVector{<:Real}, y::AbstractVector{<:Interval})
    fillrange := sup.(y)
    fillalpha --> 0.5
    linewidth --> 0

    return x, inf.(y)
end

@recipe function f(x::AbstractVector{<:Interval}, y::AbstractVector{<:Interval})
    return [[xᵢ, yᵢ] for (xᵢ, yᵢ) ∈ zip(x, y)]
end

end
