# Tests for ValidatedNumerics

using ValidatedNumerics
using Base.Test

# Tests for Intervals.jl:

include("consistency_tests.jl")
include("numeric_tests.jl")
include("trig_tests.jl")
include("non_BigFloat_tests.jl")


println("    \033[32;1mSUCCESS\033[0m")
