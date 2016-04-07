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
    x = with_interval_precision(53) do  # precision of Float64
        convert(Interval{BigFloat}, a)
    end
end


set_interval_precision(::Type{Float64}) = parameters.precision_type = Float64
# does not change the BigFloat precision


function set_interval_precision{T}(::Type{T}, precision::Integer=256)
    #println("SETTING BIGFLOAT PRECISION TO $precision")
    setprecision(BigFloat, precision)

    parameters.precision_type = T
    parameters.precision = precision
    parameters.pi = convert(Interval{BigFloat}, pi)

    precision
end

function with_interval_precision(f::Function, precision::Integer=256)
    old_interval_precision = get_interval_precision()
    #@show old_interval_precision
    set_interval_precision(precision)
    try
        return f()
    finally
        set_interval_precision(old_interval_precision)
    end
end

set_interval_precision(precision) = set_interval_precision(BigFloat, precision)
set_interval_precision(t::Tuple) = set_interval_precision(t...)

get_interval_precision() = (parameters.precision_type, parameters.precision)
    #parameters.precision_type == Float64 ? (Float64, -1) : (BigFloat, parameters.precision)


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


doc"""`get_interval_rounding()` returns the current interval rounding mode.
There are two possible rounding modes:

- :narrow  -- changes the floating-point rounding mode to `RoundUp` and `RoundDown`.
This gives the narrowest possible interval.

- :wide -- Leaves the floating-point rounding mode in `RoundNearest` and uses
`prevfloat` and `nextfloat` to achieve directed rounding. This creates an interval of width 2`eps`.
"""

get_interval_rounding() = parameters.rounding

function set_interval_rounding(mode)
    if mode ∉ [:wide, :narrow]
        throw(ArgumentError("Only possible interval rounding modes are `:wide` and `:narrow`"))
    end

    parameters.rounding = mode  # a symbol
end

big{T}(x::Interval{T}) = convert(Interval{BigFloat}, x)
