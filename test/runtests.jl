using Test
using IntervalArithmetic
using InteractiveUtils

include("generate_ITF1788.jl")

open("tests_warning.log", "w") do io
    redirect_stderr(io) do
        # interval tests
        for f ∈ readdir("interval_tests"; join = true)
            if !occursin("complex", f)
                @testset "$f" begin
                    include(f)
                end
            end
        end
        # ITF1788 tests
        for f ∈ readdir("itl")
            generate(f)
        end
        for f ∈ readdir("ITF1788_tests"; join = true)
            @testset "$f" begin
                include(f)
            end
        end
    end
end
