"""
    bisect(x::AbstractVector, i::Integer, α=0.49609375)

Bisect the `IntervalBox` in side number `i`.
"""
function bisect(x::AbstractVector, i::Integer, α=0.49609375)
    y1, y2 = bisect(x[i], α)
    x1 = copy(x)
    x1[i] = y1
    x2 = copy(x)
    x2[i] = y2
    return (x1, x2)
end

"""
    mince(x::AbstractVector, n::Integer)

Splits `x` in `n` intervals in each dimension of the same diameter. These
intervals are combined in all possible intervals, which are returned
as a vector.
"""
mince(x::AbstractVector, n::Integer) = mince(x, ntuple(_ -> n, length(x)))

"""
    mince(x::AbstractVector, n::NTuple{N,Integer})

Splits `x[i]` in `n[i]` intervals . These intervals are
combined in all possible intervals, which are returned
as a vector.
"""
function mince(x::AbstractVector, n::NTuple{N,Integer}) where {N}
    length(x) == N || return throw(DimensionMismatch("x and n must have the same length"))
    minced_intervals = [mince(x[i], n[i]) for i ∈ 1:N]
    minced_boxes = Vector{typeof(x)}(undef, prod(n))
    for (k, cut_indices) ∈ enumerate(CartesianIndices(n))
        y = similar(x, N)
        for (i, j) ∈ zip(1:N, eachindex(y))
            y[j] = minced_intervals[i][cut_indices[i]]
        end
        minced_boxes[k] = y
    end
    return minced_boxes
end

"""
    setdiff_interval(A::AbstractVector, B::AbstractVector)

Returns a vector of `IntervalBox`es that are in the set difference `A ∖ B`,
i.e. the set of `x` that are in `A` but not in `B`.

Algorithm: Start from the total overlap (in all directions);
expand each direction in turn.
"""
function setdiff_interval(A::T, B::T) where {T<:AbstractVector}
    N = length(A)
    (length(B) == N) || return throw(DimensionMismatch("A and B must have the same length"))
    inter = intersect_interval.(A, B)
    any(x -> isempty_interval(x) | isnai(x), inter) && return [A]
    result_list = Vector{T}(undef, 2*N)
    offset = 0
    x = copy(A)
    @inbounds for i ∈ 1:N
        h1, h2 = _setdiff_interval(A[i], B[i])
        y = similar(T, N)
        z = similar(T, N)
        for (j, k) ∈ enumerate(eachindex(y))
            y[k] = ifelse(j == i, h1, x[k])
            z[k] = ifelse(j == i, h2, x[k])
        end
        result_list[offset+1] = y
        result_list[offset+2] = z
        offset += 2
        x[i] = inter[i]
    end
    return filter!(x -> !any(x -> isempty_interval(x) | isnai(x), x), result_list)
end

# Computes the set difference x\\y and always returns a tuple of two intervals.
# If the set difference is only one interval or is empty, then the returned tuple contains 1
# or 2 empty intervals.
function _setdiff_interval(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    inter = intersect_interval(x, y)
    isempty_interval(inter) && return (x, emptyinterval(BareInterval{T}))
    isequal_interval(inter, x) && return (emptyinterval(BareInterval{T}), emptyinterval(BareInterval{T})) # x is subset of y; setdiff is empty
    xlo, xhi = bounds(x)
    ylo, yhi = bounds(y)
    interlo, interhi = bounds(inter)
    xlo == interlo && return (_unsafe_bareinterval(T, interhi, xhi), emptyinterval(BareInterval{T}))
    xhi == interhi && return (_unsafe_bareinterval(T, xlo, interlo), emptyinterval(BareInterval{T}))
    return (_unsafe_bareinterval(T, xlo, ylo), _unsafe_bareinterval(T, yhi, xhi))
end

function _setdiff_interval(x::Interval{T}, y::Interval{T}) where {T<:NumTypes}
    h1, h2 = _setdiff_interval(bareinterval(x), bareinterval(y))
    return (_unsafe_interval(h1, trv), _unsafe_interval(h2, trv))
end
