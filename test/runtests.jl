using IntervalArithmetic
using Test


const Interval = IntervalArithmetic.Interval

# Interval tests:

setformat(:full)

include("interval_tests/intervals.jl")
include("decoration_tests/decoration_tests.jl")

include("rand.jl")
include("interval_tests/ad.jl")

# Display tests:
include("display_tests/display.jl")

include("multidim_tests/multidim.jl")

# ITF1788 tests

include("test_ITF1788/run_ITF1788.jl")
