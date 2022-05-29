using RecipesBase

# Plot a 2D IntervalBox:
@recipe function f(xx::IntervalBox{2}) #; customcolor = :green, alpha=0.5)

    (x, y) = xx

    seriesalpha --> 0.5
    seriestype := :shape

    xlo, xhi = bounds(x)
    ylo, yhi = bounds(y)
    xv = [xlo, xhi, xhi, xlo]
    yv = [ylo, ylo, yhi, yhi]

    xv, yv
end

# Plot a vector of 2D IntervalBoxes:
@recipe function f(v::Vector{T}) where T<:IntervalBox{2}

    seriestype := :shape

    xs = Float64[]
    ys = Float64[]

    # build up coords:  # (alternative: use @series)
    for xx in v
        (x, y) = xx

        xlo, xhi = bounds(x)
        ylo, yhi = bounds(y)
        # use NaNs to separate
        append!(xs, [xlo, xhi, xhi, xlo, NaN])
        append!(ys, [ylo, ylo, yhi, yhi, NaN])

    end

    seriesalpha --> 0.5

    #x = xs
    #y = ys

    #x, y

    xs, ys

end
