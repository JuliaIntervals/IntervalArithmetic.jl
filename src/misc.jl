# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = float(a) < float(b)
