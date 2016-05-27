# This file is part of the ValidatedNumerics.jl package; MIT licensed

using ValidatedNumerics
using FactCheck

setprecision(Interval, Float64)

facts("setdiff") do
    x = 2..4
    y = 3..5

    d = setdiff(x, y)

    @fact typeof(d) --> Vector{Interval{Float64}}
    @fact length(d) --> 1
    @fact d --> [2..3]
    @fact setdiff(y, x) --> [4..5]

    x = 2..4
    y = 2..5

    @fact typeof(d) --> Vector{Interval{Float64}}
    @fact length(setdiff(x, y)) --> 0
    @fact setdiff(y, x) --> [4..5]

    x = 2..5
    y = 3..4
    @fact setdiff(x, y) --> [2..3, 4..5]

#    X = IntervalBox(2..4, 3..5)
#    Y = IntervalBox(3..5, 4..6)

    #@fact setdiff(X, Y) --> IntervalBox(2..3, 3..4)
end
