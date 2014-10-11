# Tests for ValidatedNumerics

using ValidatedNumerics
using Base.Test

# Tests for Intervals.jl:

include("interval_tests/interval_tests.jl")
#include("root_finding_tests/auto_diff_tests.jl")
#include("root_finding_tests/root_finding_tests.jl")


println("    \033[32;1mSUCCESS\033[0m")
