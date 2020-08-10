#=
 Copyright 2013 - 2015 Marco Nehmeier (nehmeier@informatik.uni-wuerzburg.de)
 Copyright 2015 Oliver Heimlich (oheim@posteo.de)

 Original author: Marco Nehmeier (unit tests in libieeep1788)
 Converted into portable ITL format by Oliver Heimlich with minor corrections.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
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

@testset "minimal_isCommonInterval_test" begin
    @test iscommon(Interval(-27.0, -27.0))
    @test iscommon(Interval(-27.0, 0.0))
    @test iscommon(Interval(0.0, 0.0))
    @test iscommon(Interval(-0.0, -0.0))
    @test iscommon(Interval(-0.0, 0.0))
    @test iscommon(Interval(0.0, -0.0))
    @test iscommon(Interval(5.0, 12.4))
    @test iscommon(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023))
    @test iscommon(RR(Float64)) == false
    @test iscommon(∅) == false
    @test iscommon(Interval(-Inf, 0.0)) == false
    @test iscommon(Interval(0.0, Inf)) == false
end

@testset "minimal_isCommonInterval_dec_test" begin
    @test iscommon(DecoratedInterval(Interval(-27.0, -27.0), com))
    @test iscommon(DecoratedInterval(Interval(-27.0, 0.0), com))
    @test iscommon(DecoratedInterval(Interval(0.0, 0.0), com))
    @test iscommon(DecoratedInterval(Interval(-0.0, -0.0), com))
    @test iscommon(DecoratedInterval(Interval(-0.0, 0.0), com))
    @test iscommon(DecoratedInterval(Interval(0.0, -0.0), com))
    @test iscommon(DecoratedInterval(Interval(5.0, 12.4), com))
    @test iscommon(DecoratedInterval(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), com))
    @test iscommon(DecoratedInterval(Interval(-27.0, -27.0), trv))
    @test iscommon(DecoratedInterval(Interval(-27.0, 0.0), def))
    @test iscommon(DecoratedInterval(Interval(0.0, 0.0), dac))
    @test iscommon(DecoratedInterval(Interval(-0.0, -0.0), trv))
    @test iscommon(DecoratedInterval(Interval(-0.0, 0.0), def))
    @test iscommon(DecoratedInterval(Interval(0.0, -0.0), dac))
    @test iscommon(DecoratedInterval(Interval(5.0, 12.4), def))
    @test iscommon(DecoratedInterval(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), trv))
    @test iscommon(DecoratedInterval(RR(Float64), dac)) == false
    @test iscommon(DecoratedInterval(∅, trv)) == false
    @test iscommon(DecoratedInterval(∅, trv)) == false
    @test iscommon(DecoratedInterval(Interval(-Inf, 0.0), trv)) == false
    @test iscommon(DecoratedInterval(Interval(0.0, Inf), def)) == false
end

@testset "minimal_isSingleton_test" begin
    @test isthin(Interval(-27.0, -27.0))
    @test isthin(Interval(-2.0, -2.0))
    @test isthin(Interval(12.0, 12.0))
    @test isthin(Interval(17.1, 17.1))
    @test isthin(Interval(-0.0, -0.0))
    @test isthin(Interval(0.0, 0.0))
    @test isthin(Interval(-0.0, 0.0))
    @test isthin(Interval(0.0, -0.0))
    @test isthin(∅) == false
    @test isthin(RR(Float64)) == false
    @test isthin(Interval(-1.0, 0.0)) == false
    @test isthin(Interval(-1.0, -0.5)) == false
    @test isthin(Interval(1.0, 2.0)) == false
    @test isthin(Interval(-Inf, -0x1.fffffffffffffp1023)) == false
    @test isthin(Interval(-1.0, Inf)) == false
end

@testset "minimal_isSingleton_dec_test" begin
    @test isthin(DecoratedInterval(Interval(-27.0, -27.0), def))
    @test isthin(DecoratedInterval(Interval(-2.0, -2.0), trv))
    @test isthin(DecoratedInterval(Interval(12.0, 12.0), dac))
    @test isthin(DecoratedInterval(Interval(17.1, 17.1), com))
    @test isthin(DecoratedInterval(Interval(-0.0, -0.0), def))
    @test isthin(DecoratedInterval(Interval(0.0, 0.0), com))
    @test isthin(DecoratedInterval(Interval(-0.0, 0.0), def))
    @test isthin(DecoratedInterval(Interval(0.0, -0.0), dac))
    @test isthin(DecoratedInterval(∅, trv)) == false
    @test isthin(DecoratedInterval(∅, trv)) == false
    @test isthin(DecoratedInterval(RR(Float64), def)) == false
    @test isthin(DecoratedInterval(Interval(-1.0, 0.0), dac)) == false
    @test isthin(DecoratedInterval(Interval(-1.0, -0.5), com)) == false
    @test isthin(DecoratedInterval(Interval(1.0, 2.0), def)) == false
    @test isthin(DecoratedInterval(Interval(-Inf, -0x1.fffffffffffffp1023), dac)) == false
    @test isthin(DecoratedInterval(Interval(-1.0, Inf), trv)) == false
end

@testset "minimal_isMember_test" begin
    @test ∈(-27.0, Interval(-27.0, -27.0))
    @test in(-27.0, Interval(-27.0, -27.0))
    @test ∈(-27.0, Interval(-27.0, 0.0))
    @test in(-27.0, Interval(-27.0, 0.0))
    @test ∈(-7.0, Interval(-27.0, 0.0))
    @test in(-7.0, Interval(-27.0, 0.0))
    @test ∈(0.0, Interval(-27.0, 0.0))
    @test in(0.0, Interval(-27.0, 0.0))
    @test ∈(-0.0, Interval(0.0, 0.0))
    @test in(-0.0, Interval(0.0, 0.0))
    @test ∈(0.0, Interval(0.0, 0.0))
    @test in(0.0, Interval(0.0, 0.0))
    @test ∈(0.0, Interval(-0.0, -0.0))
    @test in(0.0, Interval(-0.0, -0.0))
    @test ∈(0.0, Interval(-0.0, 0.0))
    @test in(0.0, Interval(-0.0, 0.0))
    @test ∈(0.0, Interval(0.0, -0.0))
    @test in(0.0, Interval(0.0, -0.0))
    @test ∈(5.0, Interval(5.0, 12.4))
    @test in(5.0, Interval(5.0, 12.4))
    @test ∈(6.3, Interval(5.0, 12.4))
    @test in(6.3, Interval(5.0, 12.4))
    @test ∈(12.4, Interval(5.0, 12.4))
    @test in(12.4, Interval(5.0, 12.4))
    @test ∈(0.0, RR(Float64))
    @test in(0.0, RR(Float64))
    @test ∈(5.0, RR(Float64))
    @test in(5.0, RR(Float64))
    @test ∈(6.3, RR(Float64))
    @test in(6.3, RR(Float64))
    @test ∈(12.4, RR(Float64))
    @test in(12.4, RR(Float64))
    @test ∈(-71.0, Interval(-27.0, 0.0)) == false
    @test in(-71.0, Interval(-27.0, 0.0)) == false
    @test ∈(0.1, Interval(-27.0, 0.0)) == false
    @test in(0.1, Interval(-27.0, 0.0)) == false
    @test ∈(-0.01, Interval(0.0, 0.0)) == false
    @test in(-0.01, Interval(0.0, 0.0)) == false
    @test ∈(0.000001, Interval(0.0, 0.0)) == false
    @test in(0.000001, Interval(0.0, 0.0)) == false
    @test ∈(111110.0, Interval(-0.0, -0.0)) == false
    @test in(111110.0, Interval(-0.0, -0.0)) == false
    @test ∈(4.9, Interval(5.0, 12.4)) == false
    @test in(4.9, Interval(5.0, 12.4)) == false
    @test ∈(-6.3, Interval(5.0, 12.4)) == false
    @test in(-6.3, Interval(5.0, 12.4)) == false
    @test ∈(0.0, ∅) == false
    @test in(0.0, ∅) == false
    @test ∈(-4535.3, ∅) == false
    @test in(-4535.3, ∅) == false
    @test ∈(-Inf, ∅) == false
    @test in(-Inf, ∅) == false
    @test ∈(Inf, ∅) == false
    @test in(Inf, ∅) == false
    @test ∈(-Inf, RR(Float64)) == false
    @test in(-Inf, RR(Float64)) == false
    @test ∈(Inf, RR(Float64)) == false
    @test in(Inf, RR(Float64)) == false
end

@testset "minimal_isMember_dec_test" begin
    @test ∈(-27.0, DecoratedInterval(Interval(-27.0, -27.0), trv))
    @test in(-27.0, DecoratedInterval(Interval(-27.0, -27.0), trv))
    @test ∈(-27.0, DecoratedInterval(Interval(-27.0, 0.0), def))
    @test in(-27.0, DecoratedInterval(Interval(-27.0, 0.0), def))
    @test ∈(-7.0, DecoratedInterval(Interval(-27.0, 0.0), dac))
    @test in(-7.0, DecoratedInterval(Interval(-27.0, 0.0), dac))
    @test ∈(0.0, DecoratedInterval(Interval(-27.0, 0.0), com))
    @test in(0.0, DecoratedInterval(Interval(-27.0, 0.0), com))
    @test ∈(-0.0, DecoratedInterval(Interval(0.0, 0.0), trv))
    @test in(-0.0, DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ∈(0.0, DecoratedInterval(Interval(0.0, 0.0), def))
    @test in(0.0, DecoratedInterval(Interval(0.0, 0.0), def))
    @test ∈(0.0, DecoratedInterval(Interval(-0.0, -0.0), dac))
    @test in(0.0, DecoratedInterval(Interval(-0.0, -0.0), dac))
    @test ∈(0.0, DecoratedInterval(Interval(-0.0, 0.0), com))
    @test in(0.0, DecoratedInterval(Interval(-0.0, 0.0), com))
    @test ∈(0.0, DecoratedInterval(Interval(0.0, -0.0), trv))
    @test in(0.0, DecoratedInterval(Interval(0.0, -0.0), trv))
    @test ∈(5.0, DecoratedInterval(Interval(5.0, 12.4), def))
    @test in(5.0, DecoratedInterval(Interval(5.0, 12.4), def))
    @test ∈(6.3, DecoratedInterval(Interval(5.0, 12.4), dac))
    @test in(6.3, DecoratedInterval(Interval(5.0, 12.4), dac))
    @test ∈(12.4, DecoratedInterval(Interval(5.0, 12.4), com))
    @test in(12.4, DecoratedInterval(Interval(5.0, 12.4), com))
    @test ∈(0.0, DecoratedInterval(RR(Float64), trv))
    @test in(0.0, DecoratedInterval(RR(Float64), trv))
    @test ∈(5.0, DecoratedInterval(RR(Float64), def))
    @test in(5.0, DecoratedInterval(RR(Float64), def))
    @test ∈(6.3, DecoratedInterval(RR(Float64), dac))
    @test in(6.3, DecoratedInterval(RR(Float64), dac))
    @test ∈(12.4, DecoratedInterval(RR(Float64), trv))
    @test in(12.4, DecoratedInterval(RR(Float64), trv))
    @test ∈(-71.0, DecoratedInterval(Interval(-27.0, 0.0), trv)) == false
    @test in(-71.0, DecoratedInterval(Interval(-27.0, 0.0), trv)) == false
    @test ∈(0.1, DecoratedInterval(Interval(-27.0, 0.0), def)) == false
    @test in(0.1, DecoratedInterval(Interval(-27.0, 0.0), def)) == false
    @test ∈(-0.01, DecoratedInterval(Interval(0.0, 0.0), dac)) == false
    @test in(-0.01, DecoratedInterval(Interval(0.0, 0.0), dac)) == false
    @test ∈(0.000001, DecoratedInterval(Interval(0.0, 0.0), com)) == false
    @test in(0.000001, DecoratedInterval(Interval(0.0, 0.0), com)) == false
    @test ∈(111110.0, DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
    @test in(111110.0, DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
    @test ∈(4.9, DecoratedInterval(Interval(5.0, 12.4), def)) == false
    @test in(4.9, DecoratedInterval(Interval(5.0, 12.4), def)) == false
    @test ∈(-6.3, DecoratedInterval(Interval(5.0, 12.4), dac)) == false
    @test in(-6.3, DecoratedInterval(Interval(5.0, 12.4), dac)) == false
    @test ∈(0.0, DecoratedInterval(∅, trv)) == false
    @test in(0.0, DecoratedInterval(∅, trv)) == false
    @test ∈(0.0, DecoratedInterval(∅, trv)) == false
    @test in(0.0, DecoratedInterval(∅, trv)) == false
    @test ∈(-4535.3, DecoratedInterval(∅, trv)) == false
    @test in(-4535.3, DecoratedInterval(∅, trv)) == false
    @test ∈(-4535.3, DecoratedInterval(∅, trv)) == false
    @test in(-4535.3, DecoratedInterval(∅, trv)) == false
    @test ∈(-Inf, DecoratedInterval(∅, trv)) == false
    @test in(-Inf, DecoratedInterval(∅, trv)) == false
    @test ∈(-Inf, DecoratedInterval(∅, trv)) == false
    @test in(-Inf, DecoratedInterval(∅, trv)) == false
    @test ∈(Inf, DecoratedInterval(∅, trv)) == false
    @test in(Inf, DecoratedInterval(∅, trv)) == false
    @test ∈(Inf, DecoratedInterval(∅, trv)) == false
    @test in(Inf, DecoratedInterval(∅, trv)) == false
    @test ∈(-Inf, DecoratedInterval(RR(Float64), trv)) == false
    @test in(-Inf, DecoratedInterval(RR(Float64), trv)) == false
    @test ∈(Inf, DecoratedInterval(RR(Float64), def)) == false
    @test in(Inf, DecoratedInterval(RR(Float64), def)) == false
end
# FactCheck.exitstatus()
