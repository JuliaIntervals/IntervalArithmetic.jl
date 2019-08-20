#=

 Test cases for interval inverse tangent function with two arguments.

 Copyright 2015-2016 Oliver Heimlich (oheim@posteo.de)

 Copying and distribution of this file, with or without modification,
 are permitted in any medium without royalty provided the copyright
 notice and this notice are preserved.  This file is offered as-is,
 without any warranty.

=#
#Language imports

#Test library imports
using Test

#Arithmetic library imports
using IntervalArithmetic

#Preamble
setprecision(53)
setprecision(Interval, Float64)
setrounding(Interval, :tight)
# Set full format, and show decorations
@format full

@testset "minimal.atan2_test" begin
    @test atan(∅, ∅) == ∅
    @test atan(∅, entireinterval(Float64)) == ∅
    @test atan(entireinterval(Float64), ∅) == ∅
    @test atan(Interval(0.0, 0.0), Interval(0.0, 0.0)) == ∅
    @test atan(entireinterval(Float64), entireinterval(Float64)) == Interval(-0x1.921fb54442d19p1, +0x1.921fb54442d19p1)
    @test atan(Interval(0.0, 0.0), Interval(-Inf, 0.0)) == Interval(0x1.921fb54442d18p1, 0x1.921fb54442d19p1)
    @test atan(Interval(0.0, 0.0), Interval(0.0, Inf)) == Interval(0.0, 0.0)
    @test atan(Interval(0.0, Inf), Interval(0.0, 0.0)) == Interval(0x1.921fb54442d18p0, 0x1.921fb54442d19p0)
    @test atan(Interval(-Inf, 0.0), Interval(0.0, 0.0)) == Interval(-0x1.921fb54442d19p0, -0x1.921fb54442d18p0)
    @test atan(Interval(-0x1p-1022, 0.0), Interval(-0x1p-1022, -0x1p-1022)) == Interval(-0x1.921fb54442d19p1, +0x1.921fb54442d19p1)
    @test atan(Interval(1.0, 1.0), Interval(-1.0, -1.0)) == Interval(0x1.2d97c7f3321d2p1, 0x1.2d97c7f3321d3p1)
    @test atan(Interval(1.0, 1.0), Interval(1.0, 1.0)) == Interval(0x1.921fb54442d18p-1, 0x1.921fb54442d19p-1)
    @test atan(Interval(-1.0, -1.0), Interval(1.0, 1.0)) == Interval(-0x1.921fb54442d19p-1, -0x1.921fb54442d18p-1)
    @test atan(Interval(-1.0, -1.0), Interval(-1.0, -1.0)) == Interval(-0x1.2d97c7f3321d3p1, -0x1.2d97c7f3321d2p1)
    @test atan(Interval(-0x1p-1022, 0x1p-1022), Interval(-0x1p-1022, -0x1p-1022)) == Interval(-0x1.921fb54442d19p1, +0x1.921fb54442d19p1)
    @test atan(Interval(-0x1p-1022, 0x1p-1022), Interval(0x1p-1022, 0x1p-1022)) == Interval(-0x1.921fb54442d19p-1, +0x1.921fb54442d19p-1)
    @test atan(Interval(-0x1p-1022, -0x1p-1022), Interval(-0x1p-1022, 0x1p-1022)) == Interval(-0x1.2d97c7f3321d3p1, -0x1.921fb54442d18p-1)
    @test atan(Interval(0x1p-1022, 0x1p-1022), Interval(-0x1p-1022, 0x1p-1022)) == Interval(0x1.921fb54442d18p-1, 0x1.2d97c7f3321d3p1)
    @test atan(Interval(-2.0, 2.0), Interval(-3.0, -1.0)) == Interval(-0x1.921fb54442d19p1, +0x1.921fb54442d19p1)
    @test atan(Interval(0.0, 2.0), Interval(-3.0, -1.0)) == Interval(0x1.0468a8ace4df6p1, 0x1.921fb54442d19p1)
    @test atan(Interval(1.0, 3.0), Interval(-3.0, -1.0)) == Interval(0x1.e47df3d0dd4dp0, 0x1.68f095fdf593dp1)
    @test atan(Interval(1.0, 3.0), Interval(-2.0, 0.0)) == Interval(0x1.921fb54442d18p0, 0x1.56c6e7397f5afp1)
    @test atan(Interval(1.0, 3.0), Interval(-2.0, 2.0)) == Interval(0x1.dac670561bb4fp-2, 0x1.56c6e7397f5afp1)
    @test atan(Interval(1.0, 3.0), Interval(0.0, 2.0)) == Interval(0x1.dac670561bb4fp-2, 0x1.921fb54442d19p0)
    @test atan(Interval(1.0, 3.0), Interval(1.0, 3.0)) == Interval(0x1.4978fa3269ee1p-2, 0x1.3fc176b7a856p0)
    @test atan(Interval(0.0, 2.0), Interval(1.0, 3.0)) == Interval(0x0p0, 0x1.1b6e192ebbe45p0)
    @test atan(Interval(-2.0, 2.0), Interval(1.0, 3.0)) == Interval(-0x1.1b6e192ebbe45p0, +0x1.1b6e192ebbe45p0)
    @test atan(Interval(-2.0, 0.0), Interval(1.0, 3.0)) == Interval(-0x1.1b6e192ebbe45p0, 0x0p0)
    @test atan(Interval(-3.0, -1.0), Interval(1.0, 3.0)) == Interval(-0x1.3fc176b7a856p0, -0x1.4978fa3269ee1p-2)
    @test atan(Interval(-3.0, -1.0), Interval(0.0, 2.0)) == Interval(-0x1.921fb54442d19p0, -0x1.dac670561bb4fp-2)
    @test atan(Interval(-3.0, -1.0), Interval(-2.0, 2.0)) == Interval(-0x1.56c6e7397f5afp1, -0x1.dac670561bb4fp-2)
    @test atan(Interval(-3.0, -1.0), Interval(-2.0, 0.0)) == Interval(-0x1.56c6e7397f5afp1, -0x1.921fb54442d18p0)
    @test atan(Interval(-3.0, -1.0), Interval(-3.0, -1.0)) == Interval(-0x1.68f095fdf593dp1, -0x1.e47df3d0dd4dp0)
    @test atan(Interval(-2.0, 0.0), Interval(-3.0, -1.0)) == Interval(-0x1.921fb54442d19p1, +0x1.921fb54442d19p1)
    @test atan(Interval(-5.0, 0.0), Interval(-5.0, 0.0)) == Interval(-0x1.921fb54442d19p1, +0x1.921fb54442d19p1)
    @test atan(Interval(0.0, 5.0), Interval(-5.0, 0.0)) == Interval(0x1.921fb54442d18p0, 0x1.921fb54442d19p1)
    @test atan(Interval(0.0, 5.0), Interval(0.0, 5.0)) == Interval(0x0p0, 0x1.921fb54442d19p0)
    @test atan(Interval(-5.0, 0.0), Interval(0.0, 5.0)) == Interval(-0x1.921fb54442d19p0, 0x0p0)
end
# FactCheck.exitstatus()
