module IntervalArithmeticRandomExt

using IntervalArithmetic
import Random

Random.rand(rng::Random.AbstractRNG, ::Random.SamplerType{Interval{T}}) where {T<:IntervalArithmetic.NumTypes} = interval(rand(rng, T))

Random.rand(rng::Random.AbstractRNG, x::Random.SamplerTrivial{Interval{T}}) where {T<:IntervalArithmetic.NumTypes} = mid(x[], rand(rng, T))

end
