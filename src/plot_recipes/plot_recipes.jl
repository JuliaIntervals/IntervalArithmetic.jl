using RecipesBase

# Plot a 2D IntervalBox:
@recipe function f(xx::IntervalBox{2}) #; customcolor = :green, alpha=0.5)

    (x, y) = xx

    alpha --> 0.5
    seriestype := :shape

    x = [x.lo, x.hi, x.hi, x.lo]
    y = [y.lo, y.lo, y.hi, y.hi]

    x, y
end

# Plot a vector of 2D IntervalBoxes:
@recipe function f(v::Vector{T}) where T<:IntervalBox{2}

    seriestype := :shape

    xs = Float64[]
    ys = Float64[]

    # build up coords:  # (alternative: use @series)
    for xx in v
        (x, y) = xx

        # use NaNs to separate
        append!(xs, [x.lo, x.hi, x.hi, x.lo, NaN])
        append!(ys, [y.lo, y.lo, y.hi, y.hi, NaN])

    end

    alpha --> 0.5

    #x = xs
    #y = ys

    #x, y

    xs, ys

end
