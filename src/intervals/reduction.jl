# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""
The file contains the reduction functions stated in the section 12.12.12 with correctly rounded results.
r is the rounding direction which takes 0.0 for RoundingToZero , 0.5 for RoundingNearest , +Inf for RoundingUp and -Inf for RoundingDown.
"""
function mpfr_vector_sum(v :: Vector{T} , r :: Float64) where T
    n = length(v)
    sum = BigFloat(0)
    for i = 1 : n
        sum = sum +  BigFloat(v[i])
    end
    r == 0 && return Float64(sum, MPFRRoundToZero)
    r == 0.5 && return Float64(sum, MPFRRoundNearest)
    r == Inf && return Float64(sum, MPFRRoundUp)
    r == -Inf && return Float64(sum, MPFRRoundDown)
end

function mpfr_vector_dot(v :: Vector{T}, u :: Vector{T}, r :: Float64) where T
    m = length(u)
    sum = BigFloat(0)
    for i = 1 : m
        sum = sum + BigFloat(v[i]) * BigFloat(u[i])
    end
    r == 0 && return Float64(sum, MPFRRoundToZero)
    r == 0.5 && return Float64(sum, MPFRRoundNearest)
    r == Inf && return Float64(sum, MPFRRoundUp)
    r == -Inf && return Float64(sum, MPFRRoundDown)
end

function mpfr_vector_sumAbs(v :: Vector{T} , r :: Float64) where T
    n = length(v)
    sum = BigFloat(0)
    for i = 1 : n
        sum = sum +  BigFloat(abs(v[i]))
    end
    r == 0 && return Float64(sum, MPFRRoundToZero)
    r == 0.5 && return Float64(sum, MPFRRoundNearest)
    r == Inf && return Float64(sum, MPFRRoundUp)
    r == -Inf && return Float64(sum, MPFRRoundDown)
end

function mpfr_vector_sumSquare(v :: Vector{T} , r :: Float64) where T
    return mpfr_vector_dot(v, v, r)
end
