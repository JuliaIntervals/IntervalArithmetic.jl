using IntervalArithmetic
using Test


const Interval = IntervalArithmetic.Interval

# Interval tests:

IntervalArithmetic.configure!(; directed_rounding=:tight, powers=:tight)

include("interval_tests/intervals.jl")
include("decoration_tests/decoration_tests.jl")

include("rand.jl")

# Display tests:
include("display_tests/display.jl")

include("multidim_tests/multidim.jl")

# ITF1788 tests

include("test_ITF1788/run_ITF1788.jl")
