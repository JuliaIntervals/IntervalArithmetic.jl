module IntervalArithmeticLinearAlgebraExt

using IntervalArithmetic, LinearAlgebra

IntervalArithmetic.interval(::Type{T}, J::UniformScaling, d::IntervalArithmetic.Decoration = com; format::Symbol = :infsup) where {T} =
    UniformScaling(interval(T, J.λ, d; format = format))
IntervalArithmetic.interval(J::UniformScaling, d::IntervalArithmetic.Decoration = com; format::Symbol = :infsup) =
    UniformScaling(interval(J.λ, d; format = format))

end
