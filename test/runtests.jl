using IntervalArithmetic
using Test

IntervalArithmetic.:(≛)(a::Tuple, b::Tuple) = all(a .≛ b)

function include_test(filename)
    @testset "$filename" begin
        include(filename)
    end
end

setformat(:full)

# Interval tests:
include_test("interval_tests/intervals.jl")
include_test("decoration_tests/decoration_tests.jl")

include_test("rand.jl")

# Display tests:
include_test("display_tests/display.jl")

# Multidim tests
include_test("multidim_tests/multidim.jl")

# ITF1788 tests
include_test("test_ITF1788/run_ITF1788.jl")  # TODO fix these tests
