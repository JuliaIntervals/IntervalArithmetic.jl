using Test
using IntervalArithmetic
using InteractiveUtils

function include_test(filename)
    @testset "$filename" begin
        include(filename)
    end
end

# interval tests
include_test("interval_tests/run_intervals.jl")

# ITF1788 tests
include_test("test_ITF1788/run_ITF1788.jl") # TODO fix these tests
