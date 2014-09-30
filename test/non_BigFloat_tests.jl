using ValidatedNumerics
using Base.Test

a = Interval(1//2, 3//4)
b = Interval(3//7, 9//12)

@test a + b == Interval(13//14, 3//2)

@test sqrt(a + b) == Interval(9.636241116594314e-01, 1.2247448713915892e+00)