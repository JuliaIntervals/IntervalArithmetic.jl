"""
Returns a list of pairs (interval, label)
label is 1 if the interval is *excluded* from the setdiff
label is 0 if the interval is included in the setdiff
label is -1 if the intersection of the two intervals was empty
"""
function labelled_setdiff(x::Interval{T}, y::Interval{T}) where T
    intersection = x ∩ y

    isempty(intersection) && return [(x, -1)]
    intersection == x && return [(x, 1)]

    x.lo == intersection.lo && return [(intersection, 1), (Interval(intersection.hi, x.hi), 0)]
    x.hi == intersection.hi && return [(intersection, 1), (Interval(x.lo, intersection.lo), 0)]

    return [(y, 1),
            (Interval(x.lo, y.lo), 0),
            (Interval(y.hi, x.hi), 0)]

end

# function setdiff{N,T}(A::IntervalBox{N,T}, B::IntervalBox{N,T})
#     X = [labelled_setdiff(a,b) for (a, b) in zip(A, B)]
#     lengths = map(length, X)
#     index = ones(N)
#
#     # index[j] represents which set we are looking at in direction j
#``
#
#     while index[1] <= N
#         current_direction = 1
#         current_piece = [ X[1][index[1]] ]
#
#     end
# end
"""
    setdiff(A::IntervalBox{N,T}, B::IntervalBox{N,T})

Returns a vector of `IntervalBox`es that are in the set difference `A ∖ B`,
i.e. the set of `x` that are in `A` but not in `B`.

Algorithm: Start from the total overlap (in all directions);
expand each direction in turn.
"""
function setdiff(A::IntervalBox{N,T}, B::IntervalBox{N,T}) where {N,T}
    X = [labelled_setdiff(a, b) for (a, b) in zip(A.v, B.v)]
    # ordered such that the first in each is the excluded interval

    first = [ i[1] for i in X ]
    labels = [i[2] for i in first]

    any(labels .== -1) && return [A]  # no overlap

    # @assert all(labels .== 1)

    excluded = [i[1] for i in first]

    result_list = IntervalBox{N,T}[]

    for dimension in N:-1:1
        for which in X[dimension][2:end]
            excluded[dimension] = which[1]
            push!(result_list,
                IntervalBox(excluded[1:dimension]..., A[dimension+1:N]...))
        end
    end

    result_list

end


# """
#     setdiff(A::IntervalBox{2,T}, B::IntervalBox{2,T})
#
# Returns a vector of `IntervalBox`es that are in the set difference `A \ B`,
# i.e. the set of `x` that are in `A` but not in `B`.
# """
# function setdiff{T}(A::IntervalBox{2,T}, B::IntervalBox{2,T})
#     X = labelled_setdiff(A[1], B[1])
#     Y = labelled_setdiff(A[2], B[2])
#
#     results_list = typeof(A)[]
#
#     for (x, label) in X
#         label == -1 && return [A]   # intersection in one direction empty, so total intersection empty
#
#         if label == 0
#             push!(results_list, IntervalBox(x, A[2]))
#             continue
#         end
#
#         # label is 1 here, so there is some intersection in the x direction
#         for (y, label) in Y
#             label == -1 && return [A]
#
#             if label == 0
#                 push!(results_list, IntervalBox(x, y))
#                 continue
#             end
#
#             # label == 1:  exclude this box since all labels are 1
#         end
#     end
#
#     return results_list
# end
