#module ValidatedNumericsTests

using ValidatedNumerics
using FactCheck
using Compat


FactCheck.roughly(a::Interval) = b -> (dist(a, b) < 2*max(eps(a), eps(b)))
roughly = FactCheck.roughly

include("misc_tests.jl")


# Interval tests:

include("interval_tests/interval_tests.jl")
include("multidim_tests/multidim_tests.jl")


# Root-finding tests:

include("root_finding_tests/auto_diff_tests.jl")
include("root_finding_tests/root_finding_tests.jl")

# Multidimensional boxes tests:

# ITF1788 tests

if VERSION < v"0.5-dev"
    include("ITF1788_tests/ITF1788_tests.jl")
end

FactCheck.exitstatus()

#end
