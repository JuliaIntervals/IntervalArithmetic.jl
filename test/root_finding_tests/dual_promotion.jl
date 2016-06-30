using ValidatedNumerics, ValidatedNumerics.RootFinding
using ForwardDiff

using FactCheck

const Dual = ForwardDiff.Dual

facts("Promotion between Dual and Interval") do
    @fact promote(ForwardDiff.Dual(2, 1), Interval(1, 2)) -->
        (Dual(2..2, 1..1), Dual(1..2, 0..0))

    @fact promote(Interval(2, 3), Dual(2, 1)) --> (Dual(Interval(2, 3), Interval(0)),
            Dual(Interval(2.0), Interval(1.0)))

end
