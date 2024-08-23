module IntervalArithmeticsIntervalSetsExt

import IntervalSets as IS
import IntervalArithmetic as IA

Base.convert(T::Type{<:IS.Interval}, i::IA.Interval) = T(IA.inf(i), IA.sup(i))
Base.convert(T::Type{<:IA.Interval}, i::IS.Interval) = T(IS.infinum(i), IS.supremum(i))

end
