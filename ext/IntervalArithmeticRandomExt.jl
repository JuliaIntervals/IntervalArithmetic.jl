module IntervalArithmeticRandomExt

using IntervalArithmetic
import Random

Random.rand(rng::Random.AbstractRNG, ::Random.SamplerType{Interval{T}}) where {T<:IntervalArithmetic.NumTypes} =
    interval(rand(rng, T))

function Random.rand(rng::Random.AbstractRNG, x::Random.SamplerTrivial{Interval{T}}) where {T<:AbstractFloat}
    lo, hi = bounds(x[])
    val = max(lo, floatmin(T)) + rand(rng, T) * (min(hi, floatmax(T)) - max(lo, floatmin(T)))
    val = ifelse(val < lo, lo, val)
    val = ifelse(val > hi, hi, val)
    return val
end

end
