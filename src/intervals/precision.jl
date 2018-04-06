# This file is part of the IntervalArithmetic.jl package; MIT licensed

mutable struct IntervalParameters

    precision_type::Type
    precision::Int
    rounding::Symbol
    pi::Interval{BigFloat}

    IntervalParameters() = new(BigFloat, 256, :narrow)  # leave out pi
end

const parameters = IntervalParameters()


## Precision:

doc"`big53` creates an equivalent `BigFloat` interval to a given `Float64` interval."
function big53(a::Interval{Float64})
    setprecision(Interval, 53) do  # precision of Float64
        closure(Interval{BigFloat}, a)
    end
end

function big53(x::Float64)
    # BigFloat(x, 53)  # in Julia v0.6

    setprecision(53) do
        BigFloat(x)
    end
end


setprecision(::Type{Interval}, ::Type{Float64}) = parameters.precision_type = Float64
# does not change the BigFloat precision


function setprecision(::Type{Interval}, ::Type{T}, prec::Integer) where T<:AbstractFloat
    #println("SETTING BIGFLOAT PRECISION TO $precision")
    setprecision(BigFloat, prec)

    parameters.precision_type = T
    parameters.precision = prec
    parameters.pi = closure(Interval{BigFloat}, pi)

    prec
end

setprecision(::Type{Interval{T}}, prec) where T<:AbstractFloat =
    setprecision(Interval, T, prec)

setprecision(::Type{Interval}, prec::Integer) = setprecision(Interval, BigFloat, prec)

function setprecision(f::Function, ::Type{Interval}, prec::Integer)

    old_precision = precision(Interval)
    setprecision(Interval, prec)

    try
        return f()
    finally
        setprecision(Interval, old_precision)
    end
end

# setprecision(::Type{Interval}, precision) = setprecision(Interval, precision)
setprecision(::Type{Interval}, t::Tuple) = setprecision(Interval, t...)

precision(::Type{Interval}) = (parameters.precision_type, parameters.precision)


const float_interval_pi = closure(Interval{Float64}, pi)  # does not change

pi_interval(::Type{BigFloat}) = parameters.pi
pi_interval(::Type{Float64})  = float_interval_pi


function Base.setrounding(f::Function, ::Type{Rational{T}},
    rounding_mode::RoundingMode) where T
    setrounding(f, float(Rational{T}), rounding_mode)
end



float(x::Interval{T}) where T = closure( Interval{float(T)}, x)  # https://github.com/dpsanders/IntervalArithmetic.jl/issues/174

big(x::Interval) = closure(Interval{BigFloat}, x)
