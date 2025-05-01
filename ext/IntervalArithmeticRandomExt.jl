module IntervalArithmeticRandomExt

using IntervalArithmetic
import Random

Random.rand(rng::Random.AbstractRNG, ::Random.SamplerType{Interval{T}}) where {T<:IntervalArithmetic.NumTypes} = interval(rand(rng, T))

end
