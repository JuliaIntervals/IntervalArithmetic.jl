module IntervalArithmeticSparseArraysExt

 using IntervalArithmetic
 import SparseArrays

 SparseArrays._iszero(x::Interval) = isthinzero(x)

 SparseArrays._isnotzero(x::Interval) = !isthinzero(x)

 end
