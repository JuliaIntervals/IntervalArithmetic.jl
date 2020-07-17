#=
 
 Unit tests from libieeep1788 for reduction operations
 (Original author: Marco Nehmeier)
 converted into portable ITL format by Oliver Heimlich.
 
 Copyright 2013-2015 Marco Nehmeier (nehmeier@informatik.uni-wuerzburg.de)
 Copyright 2015-2017 Oliver Heimlich (oheim@posteo.de)
 
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
setprecision(256)
setprecision(Interval, Float64)
setrounding(Interval, :tight)
# Set full format, and show decorations
@format full

@testset "minimal_sum_test" begin
    @test vector_sum([1.0, 2.0, 3.0], RoundNearest) == 6.0
    @test isnan(vector_sum([1.0, 2.0, NaN, 3.0], RoundNearest))
    @test isnan(vector_sum([1.0, -Inf, 2.0, Inf, 3.0], RoundNearest))
end

@testset "minimal_sum_abs_test" begin
    @test vector_sumAbs([1.0, -2.0, 3.0], RoundNearest) == 6.0
    @test isnan(vector_sumAbs([1.0, -2.0, NaN, 3.0], RoundNearest))
    @test vector_sumAbs([1.0, -Inf, 2.0, Inf, 3.0], RoundNearest) == Inf
end

@testset "minimal_sum_sqr_test" begin
    @test vector_sumSquare([1.0, 2.0, 3.0], RoundNearest) == 14.0
    @test isnan(vector_sumSquare([1.0, 2.0, NaN, 3.0], RoundNearest))
    @test vector_sumSquare([1.0, -Inf, 2.0, Inf, 3.0], RoundNearest) == Inf
end

@testset "minimal_dot_test" begin
    @test vector_dot([1.0, 2.0, 3.0], [1.0, 2.0, 3.0], RoundNearest) == 14.0
    @test vector_dot([0x10000000000001p0, 0x1p104], [0x0fffffffffffffp0, -1.0], RoundNearest) == -1.0
    @test isnan(vector_dot([1.0, 2.0, NaN, 3.0], [1.0, 2.0, 3.0, 4.0], RoundNearest))
    @test isnan(vector_dot([1.0, 2.0, 3.0, 4.0], [1.0, 2.0, NaN, 3.0], RoundNearest))
    @test isnan(vector_dot([1.0, 2.0, 0.0, 4.0], [1.0, 2.0, Inf, 3.0], RoundNearest))
    @test isnan(vector_dot([1.0, 2.0, -Inf, 4.0], [1.0, 2.0, 0.0, 3.0], RoundNearest))
end
# FactCheck.exitstatus()
