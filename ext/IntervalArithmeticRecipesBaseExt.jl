module IntervalArithmeticRecipesBaseExt

using IntervalArithmetic, RecipesBase

@recipe function f(v::AbtrstactVector{<:Interval})
    @assert length(v) == 2

    seriesalpha --> 0.5
    seriestype := :shape

    x, y = v

    x = [inf(x), sup(x), sup(x), inf(x)]
    y = [inf(y), inf(y), sup(y), sup(y)]

    return x, y
end

@recipe function f(v::AbstractVector{<:AbtrstactVector{<:Interval}})
    @assert all(vᵢ -> length(vᵢ) == 2, v)

    seriestype := :shape
    seriesalpha --> 0.5

    xs = Float64[]
    ys = Float64[]

    # build up coords: # (alternative: use @series)
    for vᵢ ∈ v
        x, y = vᵢ
        # use NaNs to separate
        append!(xs, [inf(x), sup(x), sup(x), inf(x), NaN])
        append!(ys, [inf(y), inf(y), sup(y), sup(y), NaN])
    end

    return xs, ys
end

end
