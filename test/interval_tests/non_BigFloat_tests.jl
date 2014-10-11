using ValidatedNumerics
using Base.Test

a = Interval(1//2, 3//4)
b = Interval(3//7, 9//12)

@test a + b == Interval(13//14, 3//2)

@test sqrt(a + b) == Interval(0.9636241116594315, 1.224744871391589)
