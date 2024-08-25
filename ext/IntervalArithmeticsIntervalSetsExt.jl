module IntervalArithmeticsIntervalSetsExt

import IntervalSets as IS
import IntervalArithmetic as IA


# Interval <- IS.Interval
function IA.interval(i::IS.Interval)
    x = IA.interval(IS.endpoints(i)...)
    return IA._unsafe_interval(IA.bareinterval(x), IA.decoration(x), false)
end
function IA.interval(::Type{T}, i::IS.Interval) where {T<:IA.NumTypes}
    x = IA.interval(T, IS.endpoints(i)...)
    return IA._unsafe_interval(IA.bareinterval(x), IA.decoration(x), false)
end
Base.convert(::Type{IA.Interval}, i::IS.Interval) = IA.interval(i)
Base.convert(::Type{IA.Interval{T}}, i::IS.Interval) where {T<:IA.NumTypes} = IA.interval(T, i)

# Interval -> IS.Interval
IS.Interval(i::IA.Interval) = IS.Interval(IA.inf(i), IA.sup(i))
IS.Interval{T,S,R}(i::IA.Interval) where {T,S,R} = IS.Interval{T,S,R}(IA.inf(i), IA.sup(i))
Base.convert(::Type{IS.Interval}, i::IA.Interval) = IS.Interval(i)
Base.convert(::Type{T}, i::IA.Interval) where {T<:IS.Interval} = T(i)

end
