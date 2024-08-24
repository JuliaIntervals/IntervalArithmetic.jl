module IntervalArithmeticsIntervalSetsExt

import IntervalSets as IS
import IntervalArithmetic as IA


# BareInterval <- IS.Interval
Base.convert(::Type{IA.BareInterval}, i::IS.Interval) = IA.bareinterval(IS.endpoints(i)...)
IA.bareinterval(i::IS.Interval) = IA.bareinterval(IS.endpoints(i)...)

# BareInterval -> IS.Interval
Base.convert(::Type{IS.Interval}, i::IA.BareInterval) = IS.Interval(IA.inf(i), IA.sup(i))
IS.Interval(i::IA.BareInterval) = IS.Interval(IA.inf(i), IA.sup(i))

# Interval <- IS.Interval
Base.convert(::Type{IA.Interval}, i::IS.Interval{<:Any,<:Any,T}) where {T} = convert(IA.Interval{float(T)}, i)
function Base.convert(::Type{IA.Interval{T}}, i::IS.Interval) where {T}
    bi = IA.bareinterval(i)
    return IA._unsafe_interval(bi, IA.decoration(bi), false)
end
IA.interval(i::IS.Interval) = IA.interval(IS.endpoints(i)...)

# Interval -> IS.Interval
Base.convert(::Type{IS.Interval}, i::IA.Interval) = IS.Interval(IA.inf(i), IA.sup(i))
IS.Interval(i::IA.Interval) = IS.Interval(IA.inf(i), IA.sup(i))

end
