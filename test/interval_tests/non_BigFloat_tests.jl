using ValidatedNumerics
using FactCheck

facts("Tests with rational intervals") do

    a = Interval(1//2, 3//4)
    b = Interval(3//7, 9//12)

    @fact a + b => Interval(13//14, 3//2)

    @fact sqrt(a + b) => Interval(0.9636241116594315, 1.224744871391589)

end
