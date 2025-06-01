using Test

using ForwardDiff
using IntervalArithmetic
using InteractiveUtils
import Arblib
import IntervalSets as IS

include("generate_ITF1788.jl")

# interval tests
for f ∈ readdir("interval_tests"; join = true)
    @testset "$f" begin
        include(f)
    end
end

# ITF1788 tests
# these tests were generated using:
# for f ∈ readdir("itl")
#     if !occursin("LICENSE", f)
#         generate(f)
#     end
# end
for f ∈ readdir("ITF1788_tests"; join = true)
    @testset "$f" begin
        include(f)
    end
end

# Aqua tests
include("aqua.jl")
