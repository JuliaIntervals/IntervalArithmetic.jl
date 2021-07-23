"""
    _setdiff(x::Interval{T}, y::Interval{T})

Computes the set difference x\\y and always returns a tuple of two intervals.
If the set difference is only one interval or is empty, then the returned tuple contains 1
or 2 empty intervals.
"""
function _setdiff(x::Interval{T}, y::Interval{T}) where T
    intersection = x ∩ y

    isempty(intersection) && return (x, emptyinterval(T))
    intersection == x && return (emptyinterval(T), emptyinterval(T))  # x is subset of y; setdiff is empty

    x.lo == intersection.lo && return (Interval(intersection.hi, x.hi), emptyinterval(T))
    x.hi == intersection.hi && return (Interval(x.lo, intersection.lo), emptyinterval(T))

    return (Interval(x.lo, y.lo), Interval(y.hi, x.hi))

end


"""
    setdiff(A::IntervalBox{N,T}, B::IntervalBox{N,T})

Returns a vector of `IntervalBox`es that are in the set difference `A ∖ B`,
i.e. the set of `x` that are in `A` but not in `B`.

Algorithm: Start from the total overlap (in all directions);
expand each direction in turn.
"""
function setdiff(A::IntervalBox{N,T}, B::IntervalBox{N,T}) where {N,T}

    intersection = A ∩ B
    isempty(intersection) && return [A]

    result_list = fill(IntervalBox(emptyinterval(T), N), 2*N)
    offset = 0
    x = A.v
    @inbounds for i = 1:N
        tmp = _setdiff(A[i], B[i])
        @inbounds for j = 1:2
            x = setindex(x, tmp[j], i)
            result_list[offset+j] = IntervalBox{N, T}(x)
        end
        offset += 2
        x = setindex(x, intersection[i], i)
    end
    filter!(!isempty, result_list)
end
