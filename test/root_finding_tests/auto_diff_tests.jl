
using ValidatedNumerics
using Base.Test


@test D(x -> x^2, 3) == 6

f(x) = sin(2x) - x
for a in [3, 7, 11]
    @test D(f, a) == 2*cos(2a) - 1
end
