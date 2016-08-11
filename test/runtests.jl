#module ValidatedNumericsTests

using ValidatedNumerics
using FactCheck
using Compat


FactCheck.roughly(a::Interval) = b -> (dist(a, b) < 2*max(eps(a), eps(b)))
roughly = FactCheck.roughly

# Interval tests:

include("interval_tests/intervals.jl")
include("multidim_tests/multidim.jl")
include("decoration_tests/decoration_tests.jl")

# Display tests:
include("display_tests/display.jl")

# Root-finding tests:

include("root_finding_tests/root_finding.jl")


# ITF1788 tests

include("ITF1788_tests/ITF1788_tests.jl")

FactCheck.exitstatus()

#end
