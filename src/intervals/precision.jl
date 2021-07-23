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

"`bigequiv` creates an equivalent `BigFloat` interval to a given `AbstractFloat` interval."
function bigequiv(a::Interval{T}) where {T <: AbstractFloat}
    return guarded_setprecision(Interval, precision(T)) do
        return atomic(Interval{BigFloat}, a)
    end
end

bigequiv(x::AbstractFloat) = guarded_setprecision(precision(x)) do
    return BigFloat(x)
end

# NOTE: prevents multiple threads from calling setprecision() concurrently
const precision_lock = ReentrantLock()

guarded_setprecision(f, ::Type{Interval}, prec::Integer) = lock(precision_lock) do
    return setprecision(f, Interval, prec)
end

guarded_setprecision(f, prec::Integer) = lock(precision_lock) do
    return setprecision(f, prec)
end

setprecision(::Type{Interval}, ::Type{Float64}) = parameters.precision_type = Float64
# does not change the BigFloat precision

function setprecision(::Type{Interval}, ::Type{T}, prec::Integer) where T<:AbstractFloat
    #println("SETTING BIGFLOAT PRECISION TO $precision")
    setprecision(BigFloat, prec)

    parameters.precision_type = T
    parameters.precision = prec
    parameters.pi = atomic(Interval{BigFloat}, pi)

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

function Base.setrounding(f::Function, ::Type{Rational{T}},
    rounding_mode::RoundingMode) where T
    setrounding(f, float(Rational{T}), rounding_mode)
end

float(x::Interval{T}) where T = atomic( Interval{float(T)}, x)  # https://github.com/dpsanders/IntervalArithmetic.jl/issues/174

big(x::Interval) = atomic(Interval{BigFloat}, x)
