#module ValidatedNumericsTests

using ValidatedNumerics
using FactCheck
using Compat


FactCheck.roughly(a::Interval) = b -> (dist(a, b) < 2*max(eps(a), eps(b)))
roughly = FactCheck.roughly

# Interval tests:

include("interval_tests/intervals.jl")
include("multidim_tests/multidim.jl")


# Root-finding tests:

include("root_finding_tests/root_finding.jl")

# Multidimensional boxes tests:

# ITF1788 tests

if VERSION < v"0.5-dev"
    include("ITF1788_tests/ITF1788_tests.jl")
end

FactCheck.exitstatus()

#end
