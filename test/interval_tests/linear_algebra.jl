using Test
using IntervalArithmetic

A = [ interval(2, 4)   interval(-2, 1)
     interval(-1, 2)   interval(2, 4)]

b = [interval(-2, 2)
     interval(-2, 2)]

@testset "Linear algebra with intervals tests" begin
    @test all(isequalinterval.(A * b, [interval(-12, 12), interval(-12, 12)]))

    # Example from Moore et al., Introduction to Interval Analysis (2009), pg. 88:
    # TODO This is using the wrong \. I think the correct one is defined
    # elsewhere, maybe IntervalRootFinding.jl.
    @test_skip all(isequalinterval.(A \ b, [interval(-5, 5), interval(-4, 4)]))
end
