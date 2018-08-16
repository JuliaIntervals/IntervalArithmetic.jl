using IntervalArithmetic
if VERSION < v"0.7.0-DEV.2004"
    using Test
else
    using Test
    # using LinearAlgebra, SparseArrays
end



A = [ 2..4   -2..1
     -1..2    2..4]

b = [-2..2
     -2..2]


@testset "Linear algebra with intervals tests" begin

    @test A * b == [-12..12
                    -12..12]

    # Example from Moore et al., Introduction to Interval Analysis (2009), pg. 88:

    @test A \ b == [-5..5
                    -4..4]

end
