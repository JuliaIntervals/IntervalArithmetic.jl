module ValidatedNumericsTests

using ValidatedNumerics
using FactCheck

# Interval tests:

include("interval_tests/interval_tests.jl")


# Root-finding tests:

include("root_finding_tests/auto_diff_tests.jl")
include("root_finding_tests/root_finding_tests.jl")

FactCheck.exitstatus()

end
