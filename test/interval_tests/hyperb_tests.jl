# This file is part of the ValidatedNumerics.jl package; MIT licensed

using ValidatedNumerics
using FactCheck

set_interval_precision(128)
set_interval_precision(Float64)

facts("Hyperb tests") do
    @fact sinh(emptyinterval()) --> emptyinterval()
    @fact sinh(Interval(0.5)) --> Interval(0.5210953054937473, 0.5210953054937474)
    @fact sinh(Interval(0.5, 1.67)) --> Interval(0.5210953054937473, 2.5619603657712102)
    @fact sinh(Interval(-4.5, 0.1)) --> Interval(-45.00301115199179, 0.10016675001984404)
    @fact sinh(@biginterval(0.5)) ⊆ sinh(@interval(0.5)) --> true


    @fact sinh(@biginterval(0.5, 1.67)) ⊆ sinh(@interval(0.5, 1.67)) --> true
    @fact sinh(@biginterval(1.67, 3.2)) ⊆ sinh(@interval(1.67, 3.2)) --> true
    @fact sinh(@biginterval(2.1, 5.6)) ⊆ sinh(@interval(2.1, 5.6)) --> true
    @fact sinh(@biginterval(0.5, 8.5)) ⊆ sinh(@interval(0.5, 8.5)) --> true
    @fact sinh(@biginterval(-4.5, 0.1)) ⊆ sinh(@interval(-4.5, 0.1)) --> true
    @fact sinh(@biginterval(1.3, 6.3)) ⊆ sinh(@interval(1.3, 6.3)) --> true

    @fact cosh(emptyinterval()) --> emptyinterval()
    @fact cosh(Interval(0.5)) --> Interval(1.1276259652063807, 1.127625965206381)
    @fact cosh(Interval(0.5, 1.67)) --> Interval(1.1276259652063807, 2.750207431409957)
    @fact cosh(Interval(-4.5, 0.1)) --> Interval(1.0, 45.01412014853003)
    @fact cosh(@biginterval(0.5)) ⊆ cosh(@interval(0.5)) --> true
    @fact cosh(@biginterval(0.5, 1.67)) ⊆ cosh(@interval(0.5, 1.67)) --> true
    @fact cosh(@biginterval(1.67, 3.2)) ⊆ cosh(@interval(1.67, 3.2)) --> true
    @fact cosh(@biginterval(2.1, 5.6)) ⊆ cosh(@interval(2.1, 5.6)) --> true
    @fact cosh(@biginterval(0.5, 8.5)) ⊆ cosh(@interval(0.5, 8.5)) --> true
    @fact cosh(@biginterval(-4.5, 0.1)) ⊆ cosh(@interval(-4.5, 0.1)) --> true
    @fact cosh(@biginterval(1.3, 6.3)) ⊆ cosh(@interval(1.3, 6.3)) --> true

    @fact tanh(emptyinterval()) --> emptyinterval()
    @fact tanh(Interval(0.5)) --> Interval(0.46211715726000974, 0.4621171572600098)
    @fact tanh(Interval(0.5, 1.67)) --> Interval(0.46211715726000974, 0.9315516846152083)
    @fact tanh(Interval(-4.5, 0.1)) --> Interval(-0.9997532108480276, 0.09966799462495583)
    @fact tanh(@biginterval(0.5)) ⊆ tanh(@interval(0.5)) --> true

    @show tanh(@biginterval(0.5))
    @show tanh(@interval(0.5))


    @fact tanh(@biginterval(0.5, 1.67)) ⊆ tanh(@interval(0.5, 1.67)) --> true
    @fact tanh(@biginterval(1.67, 3.2)) ⊆ tanh(@interval(1.67, 3.2)) --> true
    @fact tanh(@biginterval(2.1, 5.6)) ⊆ tanh(@interval(2.1, 5.6)) --> true
    @fact tanh(@biginterval(0.5, 8.5)) ⊆ tanh(@interval(0.5, 8.5)) --> true
    @fact tanh(@biginterval(-4.5, 0.1)) ⊆ tanh(@interval(-4.5, 0.1)) --> true
    @fact tanh(@biginterval(1.3, 6.3)) ⊆ tanh(@interval(1.3, 6.3)) --> true

    @fact asinh(@biginterval(1)) ⊆ asinh(@interval(1)) --> true
    @fact asinh(@biginterval(0.9, 2)) ⊆ asinh(@interval(0.9, 2)) --> true
    @fact asinh(@biginterval(3, 4)) ⊆ asinh(@interval(3, 4)) --> true

    @fact acosh(@biginterval(1)) ⊆ acosh(@interval(1)) --> true
    @fact acosh(@biginterval(-2, -0.9)) ⊆ acosh(@interval(-2, -0.9)) --> true
    @fact acosh(@biginterval(3, 4)) ⊆ acosh(@interval(3, 4)) --> true

    for a in ( Interval(17, 19), Interval(0.5, 1.2) )
        @fact tanh(a) ⊆ sinh(a)/cosh(a) --> true
    end

end
