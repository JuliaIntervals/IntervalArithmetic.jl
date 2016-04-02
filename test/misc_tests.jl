using ValidatedNumerics
using FactCheck

facts("Misc tests") do
    @fact BigFloat(pi) == big(pi) --> true
    @fact pi < pi --> false
    @fact pi > pi --> false
end
