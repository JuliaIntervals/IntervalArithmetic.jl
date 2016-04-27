# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::Irrational) = big(a)

<(a::Irrational, b::Irrational) = float(a) < float(b)

## Extended a trivial case for rationalize; needed for promotion
# for rational intervals
Base.rationalize{T<:Integer}(::Type{T}, x::Rational) =
    convert(T, x.num) // convert(T, x.den)
Base.rationalize{T<:Integer}(x::Rational{T}) = x
