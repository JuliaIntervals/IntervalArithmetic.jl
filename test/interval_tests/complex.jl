using ValidatedNumerics
using FactCheck

facts("Complex interval operations") do
    a = @interval 1im
    @fact a -->  Interval(0) + Interval(1)*im
    @fact a * a --> Interval(-1)
    @fact a + a --> Interval(2)*im
    @fact a - a --> 0
    @fact a / a --> 1
    @fact a^2 --> -1
end
