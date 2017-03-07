
using ValidatedNumerics
using Base.Test

# Interval tests:

setdisplay(:full)

include("interval_tests/intervals.jl")
include("multidim_tests/multidim.jl")
include("decoration_tests/decoration_tests.jl")

# Display tests:
include("display_tests/display.jl")

# Root-finding tests:

using ValidatedNumerics.RootFinding
include("root_finding_tests/root_finding.jl")


# ITF1788 tests

include("ITF1788_tests/ITF1788_tests.jl")
