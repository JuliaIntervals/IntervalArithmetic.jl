# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Precision:

"""
    big53(x::AbstractFlavor{Float64})

Create an equivalent `BigFloat` interval to a given `Float64` interval.
"""
function big53(a::F) where {F <: AbstractFlavor{Float64}}
    setprecision(F, 53) do  # precision of Float64
        atomic(reparametrize(F, BigFloat), a)
    end
end

"""
    big53(x::Float64)

Convert `x` to `BigFloat`.
"""
function big53(x::Float64)
    setprecision(53) do
        BigFloat(x)
    end
end

function Base.setrounding(f::Function, ::Type{Rational{T}},
    rounding_mode::RoundingMode) where T
    setrounding(f, float(Rational{T}), rounding_mode)
end

float(x::F) where {T, F <: AbstractFlavor{T}} = atomic(reparametrize(F, float(T)), x)
big(x::F) where {F <: AbstractFlavor = atomic(reparametrize(F, BigFloat), x)
