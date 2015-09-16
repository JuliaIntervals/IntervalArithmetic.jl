# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::Irrational) = big(a)

<(a::Irrational, b::Irrational) = float(a) < float(b)
