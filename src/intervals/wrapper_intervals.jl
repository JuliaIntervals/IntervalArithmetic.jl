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

Interval type that works like a number and i a subtype of `Real`.
"""
struct PseudoNumberInterval{T} <: Real
    interval::BaseInterval{T}
end

for IT in (:SetInterval, :RealSetInterval, :PseudoNumberInterval)
    @eval ($IT)(params...) = ($IT)(BaseInterval(params...))
    # @eval ($IT){T}(params...) = ($IT){T}(BaseInterval(params...))
end

AnyInterval{T, M} = Union{BaseInterval{T},
                          SetInterval{T},
                          RealSetInterval{T},
                          PseudoNumberInterval{T}}

# Alias for convenience.
# Default is to the most restrictive version.
Interval{T} = SetInterval{T}


function adapt_result(::Type{IT}, func_call, res::IntervalBool) where
    {IT <: Union{SetInterval, RealSetInterval}}

    isambiguous(res) && throw(AmbiguousError(repr(func_call)))
    return convert(Bool, res)
end

function adapt_result(::Type{IT}, func_call, res::IntervalBool) where
    {IT <: PseudoNumberInterval}

    isambiguous(res) && return false
    return convert(Bool, res)
end

function adapt_result(::Type{IT}, func_call, res::BaseInterval) where
    {IT <: Union{SetInterval, RealSetInterval, PseudoNumberInterval}}

    return IT(res)
end

# Default case
function adapt_result(::Type{IT}, func_call, res) where
    {IT <: Union{SetInterval, RealSetInterval, PseudoNumberInterval}}

    return res
end


@interval_function lo(x::BaseInterval) = x.lo
@interval_function hi(x::BaseInterval) = x.hi
@interval_function in(val::Real, x::BaseInterval) = lo(x) <= val <= hi(x)

@interval_function function iszero(x::BaseInterval)
    !(0 in x) && return IntervalBool(false)
    lo(x) == hi(x) == 0 && return IntervalBool(true)
    return IntervalBool(true, true)
end
