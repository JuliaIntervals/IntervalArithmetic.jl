using IntervalArithmetic
using Test

IntervalArithmetic.:(≛)(a::Tuple, b::Tuple) = all(a .≛ b)

function include_test(filename)
    @testset "$filename" begin
        include(filename)
    end
end

# Interval tests:
setformat(:full)

include_test("interval_tests/intervals.jl")
include_test("decoration_tests/decoration_tests.jl")

include_test("rand.jl")

# Display tests:
include_test("display_tests/display.jl")

# ITF1788 tests

# include_test("ITF1788_tests/ITF1788_tests.jl")  # TODO fix these tests

include_test("multidim_tests/multidim.jl")
