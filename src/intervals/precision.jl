# This file is part of the ValidatedNumerics.jl package; MIT licensed

type IntervalParameters

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
    x = setprecision(Interval, 53) do  # precision of Float64
        convert(Interval{BigFloat}, a)
    end
end


setprecision(::Type{Interval}, ::Type{Float64}) = parameters.precision_type = Float64
# does not change the BigFloat precision


function setprecision{T<:AbstractFloat}(::Type{Interval}, ::Type{T}, prec::Integer)
    #println("SETTING BIGFLOAT PRECISION TO $precision")
    setprecision(BigFloat, prec)

    parameters.precision_type = T
    parameters.precision = prec
    parameters.pi = convert(Interval{BigFloat}, pi)

    prec
end

setprecision{T<:AbstractFloat}(::Type{Interval{T}}, prec) = setprecision(Interval, T, prec)

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


const float_interval_pi = convert(Interval{Float64}, pi)  # does not change

pi_interval(::Type{BigFloat}) = parameters.pi
pi_interval(::Type{Float64})  = float_interval_pi


# Rounding for rational intervals, e.g for sqrt of rational interval:
# Find the corresponding AbstractFloat type for a given rational type

Base.float{T}(::Type{Rational{T}}) = typeof(float(one(Rational{T})))

# better to just do the following ?
# Base.float(::Type{Rational{Int64}}) = Float64
# Base.float(::Type{Rational{BigInt}}) = BigFloat

# Use that type for rounding with rationals, e.g. for sqrt:

if VERSION < v"0.5.0-dev+1182"

    function Base.with_rounding{T}(f::Function, ::Type{Rational{T}},
        rounding_mode::RoundingMode)
        setrounding(f, float(Rational{T}), rounding_mode)
    end

else
    function Base.setrounding{T}(f::Function, ::Type{Rational{T}},
        rounding_mode::RoundingMode)
        setrounding(f, float(Rational{T}), rounding_mode)
    end
end


float(x::Interval) =
    # @round(BigFloat, convert(Float64, x.lo), convert(Float64, x.hi))
    convert(Interval{Float64}, x)

## Change type of interval rounding:


doc"""`rounding(Interval)` returns the current interval rounding mode.
There are two possible rounding modes:

- :narrow  -- changes the floating-point rounding mode to `RoundUp` and `RoundDown`.
This gives the narrowest possible interval.

- :wide -- Leaves the floating-point rounding mode in `RoundNearest` and uses
`prevfloat` and `nextfloat` to achieve directed rounding. This creates an interval of width 2`eps`.
"""

rounding(::Type{Interval}) = parameters.rounding

function setrounding(::Type{Interval}, mode)
    if mode ∉ [:wide, :narrow]
        throw(ArgumentError("Only possible interval rounding modes are `:wide` and `:narrow`"))
    end

    parameters.rounding = mode  # a symbol
end

big{T}(x::Interval{T}) = convert(Interval{BigFloat}, x)
