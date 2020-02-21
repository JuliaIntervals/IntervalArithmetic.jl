
Base.eltype(x::T) where {T<:Interval} = T

Base.eltype(x::T) where {T<:IntervalArithmetic.IntervalBox} = T

