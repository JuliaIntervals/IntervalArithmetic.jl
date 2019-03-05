
using IntervalArithmetic
if VERSION < v"0.7.0-DEV.2004"
    using Test
else
    using Test
end

const Interval = IntervalArithmetic.Interval

# Interval tests:

setformat(:full)

include("interval_tests/intervals.jl")
include("decoration_tests/decoration_tests.jl")

include("rand.jl")

# Display tests:
include("display_tests/display.jl")

# ITF1788 tests

include("ITF1788_tests/ITF1788_tests.jl")

include("multidim_tests/multidim.jl")
