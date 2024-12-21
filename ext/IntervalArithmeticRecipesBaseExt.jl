module IntervalArithmeticRecipesBaseExt

using IntervalArithmetic, RecipesBase

@recipe function f(v::AbstractVector{<:Interval})
    if length(v) == 2

        seriestype := :shape
        seriesalpha --> 0.5

        x, y = v

        return [inf(x), sup(x), sup(x), inf(x), inf(x)], [inf(y), inf(y), sup(y), sup(y), inf(y)]

    elseif length(v) == 3

        @series begin
            seriestype := :path
            linecolor --> :gray
            linewidth --> 0.5

            x, y, z = v

            xe = [inf(x), sup(x), sup(x), inf(x), inf(x), inf(x), inf(x), inf(x), inf(x), inf(x), sup(x), sup(x), sup(x), sup(x), sup(x), sup(x), inf(x)]
            ye = [inf(y), inf(y), inf(y), inf(y), inf(y), sup(y), sup(y), inf(y), inf(y), sup(y), sup(y), inf(y), sup(y), sup(y), inf(y), sup(y), sup(y)]
            ze = [inf(z), inf(z), sup(z), sup(z), inf(z), inf(z), sup(z), sup(z), inf(z), inf(z), inf(z), inf(z), inf(z), sup(z), sup(z), sup(z), sup(z)]

            return xe, ye, ze
        end

        @series begin
            seriestype := :mesh3d
            primary := false
            connections --> [(1,2,3), (4,2,3), (4,7,8), (7,5,6), (2,4,7), (1,6,2), (2,7,6), (7,8,5), (4,8,5), (4,5,3), (1,6,3), (6,3,5)]
            proj_type --> :persp
            seriesalpha --> 0.5
            linewidth --> -1.0

            x, y, z = v

            xp = [inf(x), inf(x), inf(x), inf(x), sup(x), sup(x), sup(x), sup(x)]
            yp = [inf(y), sup(y), inf(y), sup(y), inf(y), inf(y), sup(y), sup(y)]
            zp = [inf(z), inf(z), sup(z), sup(z), sup(z), inf(z), inf(z), sup(z)]

            return xp, yp, zp
        end

    else
        return throw(ArgumentError("length must 2 or 3"))
    end
end

@recipe function f(v::AbstractVector{<:AbstractVector{<:Interval}})
    if all(vᵢ -> length(vᵢ) == 2, v)

        seriestype := :shape
        seriesalpha --> 0.5

        xs = Float64[]
        ys = Float64[]

        for vᵢ ∈ v
            x, y = vᵢ
            append!(xs, [inf(x), sup(x), sup(x), inf(x), inf(x), NaN])
            append!(ys, [inf(y), inf(y), sup(y), sup(y), inf(y), NaN])
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
                x, y, z = vᵢ
                xe = [inf(x), sup(x), sup(x), inf(x), inf(x), inf(x), inf(x), inf(x), inf(x), inf(x), sup(x), sup(x), sup(x), sup(x), sup(x), sup(x), inf(x)]
                ye = [inf(y), inf(y), inf(y), inf(y), inf(y), sup(y), sup(y), inf(y), inf(y), sup(y), sup(y), inf(y), sup(y), sup(y), inf(y), sup(y), sup(y)]
                ze = [inf(z), inf(z), sup(z), sup(z), inf(z), inf(z), sup(z), sup(z), inf(z), inf(z), inf(z), inf(z), inf(z), sup(z), sup(z), sup(z), sup(z)]
                append!(xs, xe)
                append!(ys, ye)
                append!(zs, ze)
            end

            return xs, ys, zs
        end

        @series begin
            seriestype := :mesh3d
            primary := false
            connections --> [(1,2,3), (4,2,3), (4,7,8), (7,5,6), (2,4,7), (1,6,2), (2,7,6), (7,8,5), (4,8,5), (4,5,3), (1,6,3), (6,3,5)]
            proj_type --> :persp
            seriesalpha --> 0.5
            linewidth --> -1.0

            xs = Vector{Float64}[]
            ys = Vector{Float64}[]
            zs = Vector{Float64}[]

            for vᵢ ∈ v
                x, y, z = vᵢ
                push!(xs, [inf(x), inf(x), inf(x), inf(x), sup(x), sup(x), sup(x), sup(x)])
                push!(ys, [inf(y), sup(y), inf(y), sup(y), inf(y), inf(y), sup(y), sup(y)])
                push!(zs, [inf(z), inf(z), sup(z), sup(z), sup(z), inf(z), inf(z), sup(z)])
            end

            return xs, ys, zs
        end

    else
        return throw(ArgumentError("length must 2 or 3"))
    end
end

end
