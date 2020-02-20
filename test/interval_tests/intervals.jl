# This file is part of the IntervalArithmetic.jl package; MIT licensed
using IntervalArithmetic
using Test

include("construction.jl")
include("consistency.jl")
include("numeric.jl")
include("trig.jl")
include("hyperbolic.jl")
include("non_BigFloat.jl")
include("linear_algebra.jl")
include("loops.jl")
include("parsing.jl")
# include("rounding_macros.jl")
include("rounding.jl")
include("bisect.jl")
include("complex.jl")

@testset "brodcasting tests" begin
    x = 3..12
    y = 4..5
    a = 3
    b = 12
    
    @test sqrt(sum(x.^2 .+ y.^2)) == 5..13

    for i in 1:100
        @test x.-i == (a-i)..(b-i)
    end


    for i in 1:100
        @test x.*i == (a*i)..(b*i)
    end

    a = 4
    b = 5 
    for i in 1:100
        @test y.+i == (a+i)..(b+i)
    end

    a = 4
    b = 5 
    for i in 1:100
        @test y./i == (a/i)..(b/i)
    end
end