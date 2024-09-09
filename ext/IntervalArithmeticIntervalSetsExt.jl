module IntervalArithmeticIntervalSetsExt

import IntervalSets as IS
import IntervalArithmetic as IA

IA.interval(i::IS.Interval{L,R,T}) where {L,R,T} = IA.interval(IA.promote_numtype(T, T), i)
function IA.interval(::Type{T}, i::IS.Interval{L,R}) where {T<:IA.NumTypes,L,R}
    # infinite endpoints are always open in IA, finite always closed:
    isinf(IS.leftendpoint(i)) != IS.isleftopen(i) && return IA.nai(T)
    isinf(IS.rightendpoint(i)) != IS.isrightopen(i) && return IA.nai(T)
    x = IA.interval(T, IS.endpoints(i)...)
    return IA._unsafe_interval(IA.bareinterval(x), IA.decoration(x), false)
end

function IS.Interval(i::IA.Interval)
    lo, hi = IA.bounds(i)
    # infinite endpoints are always open in IA, finite always closed:
    L = ifelse(isinf(lo), :open, :closed)
    R = ifelse(isinf(hi), :open, :closed)
    return IS.Interval{L,R}(lo, hi)
end

end
