doc"""
Returns a list of pairs (interval, label)
label is 1 if the interval is *excluded* from the setdiff
label is 0 if the interval is included in the setdiff
label is -1 if the intersection of the two intervals was empty
"""
function labelled_setdiff{T}(x::Interval{T}, y::Interval{T})
    intersection = x ∩ y

    isempty(intersection) && return [(x, -1)]
    intersection == x && return [(x, 1)]

    x.lo == intersection.lo && return [(intersection,1), (Interval(intersection.hi, x.hi), 0)]
    x.hi == intersection.hi && return [(Interval(x.lo, intersection.lo), 0), (intersection, 1)]

    return [(Interval(x.lo, y.lo), 0),
            (y, 1),
            (Interval(y.hi, x.hi), 0)]

end

doc"""
    setdiff(A::IntervalBox{2,T}, B::IntervalBox{2,T})

Returns a vector of `IntervalBox`es that are in the set difference `A \ B`,
i.e. the set of `x` that are in `A` but not in `B`.
"""
function setdiff{T}(A::IntervalBox{2,T}, B::IntervalBox{2,T})
    X = labelled_setdiff(A[1], B[1])
    Y = labelled_setdiff(A[2], B[2])
    
    results_list = typeof(A)[]

    for (x, label) in X
        label == -1 && return [A]   # intersection in one direction empty, so total intersection empty

        if label == 0
            push!(results_list, IntervalBox(x, A[2]))
            continue
        end

        # label is 1 here, so there is some intersection in the x direction
        for (y, label) in Y
            label == -1 && return [A]

            if label == 0
                push!(results_list, IntervalBox(x, y))
                continue
            end

            # label == 1:  exclude this box since all labels are 1
        end
    end

    return results_list
end
