# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""
    big53(x::Interval{Float64})

Create an equivalent `BigFloat` interval to a given `Float64` interval.
"""
function big53(a::Interval{Float64})
    setprecision(BigFloat, 53) do  # precision of Float64
        return atomic(Interval{BigFloat}, a)
    end
end

"""
    big53(x::Float64)

Convert `x` to `BigFloat`.
"""
function big53(x::Float64)
    setprecision(BigFloat, 53) do
        return BigFloat(x)
    end
end

function Base.setrounding(f::Function, ::Type{Rational{T}}, 
                          rounding_mode::RoundingMode) where T
    setrounding(f, float(Rational{T}), rounding_mode)
end

float(x::Interval{T}) where T = atomic(Interval{float(T)}, x)
big(x::Interval) = atomic(Interval{BigFloat}, x)
