using ForwardDiff
using ValidatedNumerics
using FactCheck

const Dual = ForwardDiff.Dual

facts("Promotion between Dual and Interval") do
    @fact promote(ForwardDiff.Dual(2,1), Interval(1,2)) -->
        (Dual(2..2, 1..1), Dual(1..2, 0..0))
end
