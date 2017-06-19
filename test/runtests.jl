
using IntervalArithmetic
using Base.Test

# Interval tests:

setformat(:full)

include("interval_tests/intervals.jl")
include("decoration_tests/decoration_tests.jl")

# Display tests:
include("display_tests/display.jl")

# ITF1788 tests

include("ITF1788_tests/ITF1788_tests.jl")

include("multidim_tests/multidim.jl")
