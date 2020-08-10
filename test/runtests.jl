using IntervalArithmetic
using Test


const Interval = IntervalArithmetic.Interval

# Interval tests:

setformat(:full)

include("interval_tests/intervals.jl")
include("decoration_tests/decoration_tests.jl")

include("rand.jl")

# Display tests:
# include("display_tests/display.jl")  # TODO Chose what display to have now

# ITF1788 tests

# include("ITF1788_tests/ITF1788_tests.jl")  # TODO fix these tests

include("multidim_tests/multidim.jl")
