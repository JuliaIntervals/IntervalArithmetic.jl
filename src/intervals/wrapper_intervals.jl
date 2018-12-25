import Base: convert, promote_rule

"""
    SetInterval

Interval type that works like a set.
"""
struct SetInterval{T}
    interval::BaseInterval{T}
end

"""
    RealSetInterval

Interval type that works like a set, but is a subtype of `Real` nonetheless.
"""
struct RealSetInterval{T} <: Real
    interval::BaseInterval{T}
end

"""
    PseudoNumberInterval

Interval type that works like a number and is a subtype of `Real`.

Operation that returns `Bool` return `false` when the result can not be
certified to be `true` for all elements in the interval.

!!! warning
    This behavior may have unexpected consequence, as for example for
    `X = PseudoNumberInterval(-1..1)` both `X > 0` and `X <= 0` both return
    `false`.
"""
struct PseudoNumberInterval{T} <: Real
    interval::BaseInterval{T}
end

for IT in (:SetInterval, :RealSetInterval, :PseudoNumberInterval)
    @eval ($IT)(params...) = ($IT)(BaseInterval(params...))
    @eval convert(IT, x::BaseInterval) = ($IT)(x)
    # @eval ($IT){T}(params...) = ($IT){T}(BaseInterval(params...))
end

AnyInterval{T, M} = Union{BaseInterval{T},
                          SetInterval{T},
                          RealSetInterval{T},
                          PseudoNumberInterval{T}}

# Alias for convenience.
# Default is to the most restrictive version.
Interval{T} = SetInterval{T}

disambiguation_mode(val) = NoDisambiguation
disambiguation_mode(::Union{SetInterval, RealSetInterval}) = ErrorOnAmbiguous
disambiguation_mode(::PseudoNumberInterval) = FalseOnAmbiguous

wrapped_interval(val) = val
wrapped_interval(x::Union{SetInterval, RealSetInterval, PseudoNumberInterval}) = x.interval

@interval_function lo(x::BaseInterval) = x.lo
@interval_function hi(x::BaseInterval) = x.hi
@interval_function in(val::Real, x::BaseInterval) = lo(x) <= val <= hi(x)

@interval_function function iszero(x::BaseInterval)
    !(0 in x) && return IntervalBool(false)
    lo(x) == hi(x) == 0 && return IntervalBool(true)
    return IntervalBool(true, true)
end

#TODO Redifine the macro to the following form
function f(X...)
    promoted_type = promote_type(interval_type.(X)...)
    bare_res = f(wrapped_interval.(X)...)
    disamb_res = disambiguate(disambiguation_mode(promoted_type), bare_res, :f)
    return reinterval(promoted_type, disamb_res)
end
