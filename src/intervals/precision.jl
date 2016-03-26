# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Precision:

doc"`big53` creates an equivalent `BigFloat` interval to a given `Float64` interval."
function big53(a::Interval{Float64})
    x = with_interval_precision(53) do  # precision of Float64
        convert(Interval{BigFloat}, a)
    end
end


set_interval_precision(::Type{Float64}, prec=-1) = parameters.precision_type = Float64


function set_interval_precision(::Type{BigFloat}, precision::Integer=256)
    setprecision(precision)

    parameters.precision_type = BigFloat
    parameters.precision = precision
    parameters.pi = convert(Interval{BigFloat}, pi)

    precision
end

function with_interval_precision(f::Function, precision::Integer=256)
    old_interval_precision = get_interval_precision()
    set_interval_precision(precision)
    try
        return f()
    finally
        set_interval_precision(old_interval_precision)
    end
end

set_interval_precision(precision) = set_interval_precision(BigFloat, precision)
set_interval_precision(t::Tuple) = set_interval_precision(t...)

get_interval_precision() =
    parameters.precision_type == Float64 ? (Float64, -1) : (BigFloat, parameters.precision)


const float_interval_pi = convert(Interval{Float64}, pi)  # does not change

pi_interval(::Type{BigFloat}) = parameters.pi
pi_interval(::Type{Float64})  = float_interval_pi
