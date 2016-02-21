#module ValidatedNumericsTests

using ValidatedNumerics
using FactCheck
using Compat


FactCheck.roughly(a::Interval) = b -> (dist(a, b) < 2*max(eps(a), eps(b)))
roughly = FactCheck.roughly

include("misc_tests.jl")


# Interval tests:

include("interval_tests/interval_tests.jl")


# Root-finding tests:

include("root_finding_tests/auto_diff_tests.jl")
include("root_finding_tests/root_finding_tests.jl")

# ITF1788 tests

include("ITF1788_tests/ITF1788_tests.jl")

FactCheck.exitstatus()

#end
