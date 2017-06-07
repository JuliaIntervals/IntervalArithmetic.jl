
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

if VERSION >= v"0.6.0-dev.1671"  # PR https://github.com/JuliaLang/julia/pull/17057 fixing issue #265
    include("interval_tests/rounding.jl")
end
