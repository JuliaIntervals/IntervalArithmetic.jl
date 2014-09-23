# Simple tests for @intervals
#using @intervals
using ValidatedNumerics
using Base.Test

set_bigfloat_precision(53)

a = @interval(1.1,0.1)
b = @interval(0.9,2.0)
c = @interval(0.25,4.0)

include("consistency_tests.jl")
include("numeric_tests.jl")
include("trig_tests.jl")





println("    \033[32;1mSUCCESS\033[0m")
