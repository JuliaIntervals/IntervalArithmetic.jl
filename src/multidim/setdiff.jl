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

"""
    setdiff(A::IntervalBox{N,T}, B::IntervalBox{N,T})

Returns a vector of `IntervalBox`es that are in the set difference `A ∖ B`,
i.e. the set of `x` that are in `A` but not in `B`.

Algorithm: Start from the total overlap (in all directions);
expand each direction in turn.
"""
function setdiff1(A::IntervalBox{N,T}, B::IntervalBox{N,T}) where {N,T}
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

function setdiff2(A::IntervalBox{N,T}, B::IntervalBox{N,T}) where {N,T}

    intersection = A ∩ B
    isempty(intersection) && return [A]

    result_list = fill(IntervalBox(emptyinterval(T), N), 2*N)
    offset = 0
    x = Array(A.v)
    @inbounds for i = 1:N
        tmp = setdiff(A[i], B[i])
        @inbounds for j = 1:length(tmp)
            x[i] = tmp[j]
            result_list[offset+j] = IntervalBox{N, T}(x)
        end
        offset += length(tmp)
        x[i] = intersection[i]
    end
    filter!(!isempty, result_list)
end

function setdiff(A::IntervalBox{N,T}, B::IntervalBox{N,T}) where {N,T}

    intersection = A ∩ B
    isempty(intersection) && return [A]

    result_list = fill(IntervalBox(emptyinterval(T), N), 2*N)
    offset = 0
    x = Array(A.v)
    @inbounds for i = 1:N
        tmp = _setdiff(A[i], B[i])
        @inbounds for j = 1:2
            x[i] = tmp[j]
            result_list[offset+j] = IntervalBox{N, T}(x)
        end
        offset += 2
        x[i] = intersection[i]
    end
    filter!(!isempty, result_list)
end

function _setdiff(x::Interval{T}, y::Interval{T}) where T
    intersection = x ∩ y

    isempty(intersection) && return (x, emptyinterval(T))
    intersection == x && return (emptyinterval(T), emptyinterval(T))  # x is subset of y; setdiff is empty

    x.lo == intersection.lo && return (Interval(intersection.hi, x.hi), emptyinterval(T))
    x.hi == intersection.hi && return (Interval(x.lo, intersection.lo), emptyinterval(T))

    return (Interval(x.lo, y.lo), Interval(y.hi, x.hi))

end
