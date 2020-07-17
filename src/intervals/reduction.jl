# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""
The file contains the reduction functions stated in the section 12.12.12 with correctly rounded results.
r is the rounding direction which takes 0.0 for RoundingToZero , 0.5 for RoundingNearest , +Inf for RoundingUp and -Inf for RoundingDown.
"""
function vector_sum(v :: Vector{T} , r :: RoundingMode) where T
    sum1 = sum(BigFloat.(v))
    return T(sum1, r)
end

function vector_dot(v :: Vector{T}, u :: Vector{T}, r :: RoundingMode) where T
    sum1 = sum(BigFloat.(v) .* BigFloat.(u))
    return T(sum1, r)
end

function vector_sumAbs(v :: Vector{T} , r :: RoundingMode) where T
    sum1 = sum(BigFloat.(abs.(v)))
    return T(sum1, r)
end

function vector_sumSquare(v :: Vector{T} , r :: RoundingMode) where T
    return vector_dot(v, v, r)
end
