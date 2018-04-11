# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Base.Test


setprecision(Interval, 128)
setprecision(Interval, Float64)

@testset "Special Functions tests" begin
    @test erf(emptyinterval()) == emptyinterval()

    @test erfc(emptyinterval()) == emptyinterval()
end
