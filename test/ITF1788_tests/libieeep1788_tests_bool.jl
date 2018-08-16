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
if VERSION < v"0.7.0-DEV.2004"
    using Test
else
    using Test
end

#Arithmetic library imports
using IntervalArithmetic

#Preamble
setprecision(53)
setprecision(Interval, Float64)
setrounding(Interval, :tight)
# Set full format, and show decorations
@format full

@testset "minimal_empty_test" begin
    @test isempty(∅)
    @test isempty(Interval(-Inf, Inf)) == false
    @test isempty(Interval(1.0, 2.0)) == false
    @test isempty(Interval(-1.0, 2.0)) == false
    @test isempty(Interval(-3.0, -2.0)) == false
    @test isempty(Interval(-Inf, 2.0)) == false
    @test isempty(Interval(-Inf, 0.0)) == false
    @test isempty(Interval(-Inf, -0.0)) == false
    @test isempty(Interval(0.0, Inf)) == false
    @test isempty(Interval(-0.0, Inf)) == false
    @test isempty(Interval(-0.0, 0.0)) == false
    @test isempty(Interval(0.0, -0.0)) == false
    @test isempty(Interval(0.0, 0.0)) == false
    @test isempty(Interval(-0.0, -0.0)) == false
end

@testset "minimal_empty_dec_test" begin
    @test isempty(DecoratedInterval(∅, trv))
    @test isempty(DecoratedInterval(Interval(-Inf, Inf), def)) == false
    @test isempty(DecoratedInterval(Interval(1.0, 2.0), com)) == false
    @test isempty(DecoratedInterval(Interval(-1.0, 2.0), trv)) == false
    @test isempty(DecoratedInterval(Interval(-3.0, -2.0), dac)) == false
    @test isempty(DecoratedInterval(Interval(-Inf, 2.0), trv)) == false
    @test isempty(DecoratedInterval(Interval(-Inf, 0.0), trv)) == false
    @test isempty(DecoratedInterval(Interval(-Inf, -0.0), trv)) == false
    @test isempty(DecoratedInterval(Interval(0.0, Inf), def)) == false
    @test isempty(DecoratedInterval(Interval(-0.0, Inf), trv)) == false
    @test isempty(DecoratedInterval(Interval(-0.0, 0.0), com)) == false
    @test isempty(DecoratedInterval(Interval(0.0, -0.0), trv)) == false
    @test isempty(DecoratedInterval(Interval(0.0, 0.0), trv)) == false
    @test isempty(DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
end

@testset "minimal_entire_test" begin
    @test isentire(∅) == false
    @test isentire(Interval(-Inf, Inf))
    @test isentire(Interval(1.0, 2.0)) == false
    @test isentire(Interval(-1.0, 2.0)) == false
    @test isentire(Interval(-3.0, -2.0)) == false
    @test isentire(Interval(-Inf, 2.0)) == false
    @test isentire(Interval(-Inf, 0.0)) == false
    @test isentire(Interval(-Inf, -0.0)) == false
    @test isentire(Interval(0.0, Inf)) == false
    @test isentire(Interval(-0.0, Inf)) == false
    @test isentire(Interval(-0.0, 0.0)) == false
    @test isentire(Interval(0.0, -0.0)) == false
    @test isentire(Interval(0.0, 0.0)) == false
    @test isentire(Interval(-0.0, -0.0)) == false
end

@testset "minimal_entire_dec_test" begin
    @test isentire(DecoratedInterval(∅, trv)) == false
    @test isentire(DecoratedInterval(Interval(-Inf, Inf), trv))
    @test isentire(DecoratedInterval(Interval(-Inf, Inf), def))
    @test isentire(DecoratedInterval(Interval(-Inf, Inf), dac))
    @test isentire(DecoratedInterval(Interval(1.0, 2.0), com)) == false
    @test isentire(DecoratedInterval(Interval(-1.0, 2.0), trv)) == false
    @test isentire(DecoratedInterval(Interval(-3.0, -2.0), dac)) == false
    @test isentire(DecoratedInterval(Interval(-Inf, 2.0), trv)) == false
    @test isentire(DecoratedInterval(Interval(-Inf, 0.0), trv)) == false
    @test isentire(DecoratedInterval(Interval(-Inf, -0.0), trv)) == false
    @test isentire(DecoratedInterval(Interval(0.0, Inf), def)) == false
    @test isentire(DecoratedInterval(Interval(-0.0, Inf), trv)) == false
    @test isentire(DecoratedInterval(Interval(-0.0, 0.0), com)) == false
    @test isentire(DecoratedInterval(Interval(0.0, -0.0), trv)) == false
    @test isentire(DecoratedInterval(Interval(0.0, 0.0), trv)) == false
    @test isentire(DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
end

@testset "minimal_nai_dec_test" begin
    @test isnai(DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test isnai(DecoratedInterval(Interval(-Inf, Inf), def)) == false
    @test isnai(DecoratedInterval(Interval(-Inf, Inf), dac)) == false
    @test isnai(DecoratedInterval(Interval(1.0, 2.0), com)) == false
    @test isnai(DecoratedInterval(Interval(-1.0, 2.0), trv)) == false
    @test isnai(DecoratedInterval(Interval(-3.0, -2.0), dac)) == false
    @test isnai(DecoratedInterval(Interval(-Inf, 2.0), trv)) == false
    @test isnai(DecoratedInterval(Interval(-Inf, 0.0), trv)) == false
    @test isnai(DecoratedInterval(Interval(-Inf, -0.0), trv)) == false
    @test isnai(DecoratedInterval(Interval(0.0, Inf), def)) == false
    @test isnai(DecoratedInterval(Interval(-0.0, Inf), trv)) == false
    @test isnai(DecoratedInterval(Interval(-0.0, 0.0), com)) == false
    @test isnai(DecoratedInterval(Interval(0.0, -0.0), trv)) == false
    @test isnai(DecoratedInterval(Interval(0.0, 0.0), trv)) == false
    @test isnai(DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
end

@testset "minimal_equal_test" begin
    @test ==(Interval(1.0, 2.0), Interval(1.0, 2.0))
    @test ==(Interval(1.0, 2.1), Interval(1.0, 2.0)) == false
    @test ==(∅, ∅)
    @test ==(∅, Interval(1.0, 2.0)) == false
    @test ==(Interval(-Inf, Inf), Interval(-Inf, Inf))
    @test ==(Interval(1.0, 2.4), Interval(-Inf, Inf)) == false
    @test ==(Interval(1.0, Inf), Interval(1.0, Inf))
    @test ==(Interval(1.0, 2.4), Interval(1.0, Inf)) == false
    @test ==(Interval(-Inf, 2.0), Interval(-Inf, 2.0))
    @test ==(Interval(-Inf, 2.4), Interval(-Inf, 2.0)) == false
    @test ==(Interval(-2.0, 0.0), Interval(-2.0, 0.0))
    @test ==(Interval(-0.0, 2.0), Interval(0.0, 2.0))
    @test ==(Interval(-0.0, -0.0), Interval(0.0, 0.0))
    @test ==(Interval(-0.0, 0.0), Interval(0.0, 0.0))
    @test ==(Interval(0.0, -0.0), Interval(0.0, 0.0))
end

@testset "minimal_equal_dec_test" begin
    @test ==(DecoratedInterval(Interval(1.0, 2.0), def), DecoratedInterval(Interval(1.0, 2.0), trv))
    @test ==(DecoratedInterval(Interval(1.0, 2.1), trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test ==(DecoratedInterval(∅, trv), DecoratedInterval(∅, trv))
    @test ==(DecoratedInterval(∅, trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test ==(DecoratedInterval(∅, trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test ==(DecoratedInterval(Interval(-Inf, Inf), def), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ==(DecoratedInterval(Interval(1.0, 2.4), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test ==(DecoratedInterval(Interval(1.0, Inf), trv), DecoratedInterval(Interval(1.0, Inf), trv))
    @test ==(DecoratedInterval(Interval(1.0, 2.4), def), DecoratedInterval(Interval(1.0, Inf), trv)) == false
    @test ==(DecoratedInterval(Interval(-Inf, 2.0), trv), DecoratedInterval(Interval(-Inf, 2.0), trv))
    @test ==(DecoratedInterval(Interval(-Inf, 2.4), def), DecoratedInterval(Interval(-Inf, 2.0), trv)) == false
    @test ==(DecoratedInterval(Interval(-2.0, 0.0), trv), DecoratedInterval(Interval(-2.0, 0.0), trv))
    @test ==(DecoratedInterval(Interval(-0.0, 2.0), def), DecoratedInterval(Interval(0.0, 2.0), trv))
    @test ==(DecoratedInterval(Interval(-0.0, -0.0), trv), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ==(DecoratedInterval(Interval(-0.0, 0.0), def), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ==(DecoratedInterval(Interval(0.0, -0.0), trv), DecoratedInterval(Interval(0.0, 0.0), trv))
end

@testset "minimal_subset_test" begin
    @test ⊆(∅, ∅)
    @test ⊆(∅, Interval(0.0, 4.0))
    @test ⊆(∅, Interval(-0.0, 4.0))
    @test ⊆(∅, Interval(-0.1, 1.0))
    @test ⊆(∅, Interval(-0.1, 0.0))
    @test ⊆(∅, Interval(-0.1, -0.0))
    @test ⊆(∅, Interval(-Inf, Inf))
    @test ⊆(Interval(0.0, 4.0), ∅) == false
    @test ⊆(Interval(-0.0, 4.0), ∅) == false
    @test ⊆(Interval(-0.1, 1.0), ∅) == false
    @test ⊆(Interval(-Inf, Inf), ∅) == false
    @test ⊆(Interval(0.0, 4.0), Interval(-Inf, Inf))
    @test ⊆(Interval(-0.0, 4.0), Interval(-Inf, Inf))
    @test ⊆(Interval(-0.1, 1.0), Interval(-Inf, Inf))
    @test ⊆(Interval(-Inf, Inf), Interval(-Inf, Inf))
    @test ⊆(Interval(1.0, 2.0), Interval(1.0, 2.0))
    @test ⊆(Interval(1.0, 2.0), Interval(0.0, 4.0))
    @test ⊆(Interval(1.0, 2.0), Interval(-0.0, 4.0))
    @test ⊆(Interval(0.1, 0.2), Interval(0.0, 4.0))
    @test ⊆(Interval(0.1, 0.2), Interval(-0.0, 4.0))
    @test ⊆(Interval(-0.1, -0.1), Interval(-4.0, 3.4))
    @test ⊆(Interval(0.0, 0.0), Interval(-0.0, -0.0))
    @test ⊆(Interval(-0.0, -0.0), Interval(0.0, 0.0))
    @test ⊆(Interval(-0.0, 0.0), Interval(0.0, 0.0))
    @test ⊆(Interval(-0.0, 0.0), Interval(0.0, -0.0))
    @test ⊆(Interval(0.0, -0.0), Interval(0.0, 0.0))
    @test ⊆(Interval(0.0, -0.0), Interval(-0.0, 0.0))
end

@testset "minimal_subset_dec_test" begin
    @test ⊆(DecoratedInterval(∅, trv), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test ⊆(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-0.0, 4.0), def))
    @test ⊆(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-0.1, 1.0), trv))
    @test ⊆(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-0.1, 0.0), trv))
    @test ⊆(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-0.1, -0.0), trv))
    @test ⊆(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⊆(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(∅, trv)) == false
    @test ⊆(DecoratedInterval(Interval(-0.0, 4.0), def), DecoratedInterval(∅, trv)) == false
    @test ⊆(DecoratedInterval(Interval(-0.1, 1.0), trv), DecoratedInterval(∅, trv)) == false
    @test ⊆(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(∅, trv)) == false
    @test ⊆(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⊆(DecoratedInterval(Interval(-0.0, 4.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⊆(DecoratedInterval(Interval(-0.1, 1.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⊆(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⊆(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(1.0, 2.0), trv))
    @test ⊆(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test ⊆(DecoratedInterval(Interval(1.0, 2.0), def), DecoratedInterval(Interval(-0.0, 4.0), def))
    @test ⊆(DecoratedInterval(Interval(0.1, 0.2), trv), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test ⊆(DecoratedInterval(Interval(0.1, 0.2), trv), DecoratedInterval(Interval(-0.0, 4.0), def))
    @test ⊆(DecoratedInterval(Interval(-0.1, -0.1), trv), DecoratedInterval(Interval(-4.0, 3.4), trv))
    @test ⊆(DecoratedInterval(Interval(0.0, 0.0), trv), DecoratedInterval(Interval(-0.0, -0.0), trv))
    @test ⊆(DecoratedInterval(Interval(-0.0, -0.0), trv), DecoratedInterval(Interval(0.0, 0.0), def))
    @test ⊆(DecoratedInterval(Interval(-0.0, 0.0), trv), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ⊆(DecoratedInterval(Interval(-0.0, 0.0), trv), DecoratedInterval(Interval(0.0, -0.0), trv))
    @test ⊆(DecoratedInterval(Interval(0.0, -0.0), def), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ⊆(DecoratedInterval(Interval(0.0, -0.0), trv), DecoratedInterval(Interval(-0.0, 0.0), trv))
end

@testset "minimal_less_test" begin
    @test ≤(∅, ∅)
    @test ≤(Interval(1.0, 2.0), ∅) == false
    @test ≤(∅, Interval(1.0, 2.0)) == false
    @test ≤(Interval(-Inf, Inf), Interval(-Inf, Inf))
    @test ≤(Interval(1.0, 2.0), Interval(-Inf, Inf)) == false
    @test ≤(Interval(0.0, 2.0), Interval(-Inf, Inf)) == false
    @test ≤(Interval(-0.0, 2.0), Interval(-Inf, Inf)) == false
    @test ≤(Interval(-Inf, Inf), Interval(1.0, 2.0)) == false
    @test ≤(Interval(-Inf, Inf), Interval(0.0, 2.0)) == false
    @test ≤(Interval(-Inf, Inf), Interval(-0.0, 2.0)) == false
    @test ≤(Interval(0.0, 2.0), Interval(0.0, 2.0))
    @test ≤(Interval(0.0, 2.0), Interval(-0.0, 2.0))
    @test ≤(Interval(0.0, 2.0), Interval(1.0, 2.0))
    @test ≤(Interval(-0.0, 2.0), Interval(1.0, 2.0))
    @test ≤(Interval(1.0, 2.0), Interval(1.0, 2.0))
    @test ≤(Interval(1.0, 2.0), Interval(3.0, 4.0))
    @test ≤(Interval(1.0, 3.5), Interval(3.0, 4.0))
    @test ≤(Interval(1.0, 4.0), Interval(3.0, 4.0))
    @test ≤(Interval(-2.0, -1.0), Interval(-2.0, -1.0))
    @test ≤(Interval(-3.0, -1.5), Interval(-2.0, -1.0))
    @test ≤(Interval(0.0, 0.0), Interval(-0.0, -0.0))
    @test ≤(Interval(-0.0, -0.0), Interval(0.0, 0.0))
    @test ≤(Interval(-0.0, 0.0), Interval(0.0, 0.0))
    @test ≤(Interval(-0.0, 0.0), Interval(0.0, -0.0))
    @test ≤(Interval(0.0, -0.0), Interval(0.0, 0.0))
    @test ≤(Interval(0.0, -0.0), Interval(-0.0, 0.0))
end

@testset "minimal_less_dec_test" begin
    @test ≤(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(∅, trv)) == false
    @test ≤(DecoratedInterval(∅, trv), DecoratedInterval(Interval(1.0, 2.0), def)) == false
    @test ≤(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(∅, trv)) == false
    @test ≤(DecoratedInterval(∅, trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test ≤(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ≤(DecoratedInterval(Interval(1.0, 2.0), def), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test ≤(DecoratedInterval(Interval(0.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test ≤(DecoratedInterval(Interval(-0.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test ≤(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test ≤(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(0.0, 2.0), def)) == false
    @test ≤(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-0.0, 2.0), trv)) == false
    @test ≤(DecoratedInterval(Interval(0.0, 2.0), trv), DecoratedInterval(Interval(0.0, 2.0), trv))
    @test ≤(DecoratedInterval(Interval(0.0, 2.0), trv), DecoratedInterval(Interval(-0.0, 2.0), trv))
    @test ≤(DecoratedInterval(Interval(0.0, 2.0), def), DecoratedInterval(Interval(1.0, 2.0), def))
    @test ≤(DecoratedInterval(Interval(-0.0, 2.0), trv), DecoratedInterval(Interval(1.0, 2.0), trv))
    @test ≤(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(1.0, 2.0), trv))
    @test ≤(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(3.0, 4.0), def))
    @test ≤(DecoratedInterval(Interval(1.0, 3.5), trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test ≤(DecoratedInterval(Interval(1.0, 4.0), trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test ≤(DecoratedInterval(Interval(-2.0, -1.0), trv), DecoratedInterval(Interval(-2.0, -1.0), trv))
    @test ≤(DecoratedInterval(Interval(-3.0, -1.5), trv), DecoratedInterval(Interval(-2.0, -1.0), trv))
    @test ≤(DecoratedInterval(Interval(0.0, 0.0), trv), DecoratedInterval(Interval(-0.0, -0.0), trv))
    @test ≤(DecoratedInterval(Interval(-0.0, -0.0), trv), DecoratedInterval(Interval(0.0, 0.0), def))
    @test ≤(DecoratedInterval(Interval(-0.0, 0.0), trv), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ≤(DecoratedInterval(Interval(-0.0, 0.0), trv), DecoratedInterval(Interval(0.0, -0.0), trv))
    @test ≤(DecoratedInterval(Interval(0.0, -0.0), def), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test ≤(DecoratedInterval(Interval(0.0, -0.0), trv), DecoratedInterval(Interval(-0.0, 0.0), trv))
end

@testset "minimal_precedes_test" begin
    @test precedes(∅, Interval(3.0, 4.0))
    @test precedes(Interval(3.0, 4.0), ∅)
    @test precedes(∅, ∅)
    @test precedes(Interval(1.0, 2.0), Interval(-Inf, Inf)) == false
    @test precedes(Interval(0.0, 2.0), Interval(-Inf, Inf)) == false
    @test precedes(Interval(-0.0, 2.0), Interval(-Inf, Inf)) == false
    @test precedes(Interval(-Inf, Inf), Interval(1.0, 2.0)) == false
    @test precedes(Interval(-Inf, Inf), Interval(-Inf, Inf)) == false
    @test precedes(Interval(1.0, 2.0), Interval(3.0, 4.0))
    @test precedes(Interval(1.0, 3.0), Interval(3.0, 4.0))
    @test precedes(Interval(-3.0, -1.0), Interval(-1.0, 0.0))
    @test precedes(Interval(-3.0, -1.0), Interval(-1.0, -0.0))
    @test precedes(Interval(1.0, 3.5), Interval(3.0, 4.0)) == false
    @test precedes(Interval(1.0, 4.0), Interval(3.0, 4.0)) == false
    @test precedes(Interval(-3.0, -0.1), Interval(-1.0, 0.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-0.0, -0.0))
    @test precedes(Interval(-0.0, -0.0), Interval(0.0, 0.0))
    @test precedes(Interval(-0.0, 0.0), Interval(0.0, 0.0))
    @test precedes(Interval(-0.0, 0.0), Interval(0.0, -0.0))
    @test precedes(Interval(0.0, -0.0), Interval(0.0, 0.0))
    @test precedes(Interval(0.0, -0.0), Interval(-0.0, 0.0))
end

@testset "minimal_precedes_dec_test" begin
    @test precedes(DecoratedInterval(∅, trv), DecoratedInterval(Interval(3.0, 4.0), def))
    @test precedes(DecoratedInterval(Interval(3.0, 4.0), trv), DecoratedInterval(∅, trv))
    @test precedes(DecoratedInterval(∅, trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test precedes(DecoratedInterval(Interval(3.0, 4.0), trv), DecoratedInterval(∅, trv))
    @test precedes(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test precedes(DecoratedInterval(Interval(0.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test precedes(DecoratedInterval(Interval(-0.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test precedes(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test precedes(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test precedes(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test precedes(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(Interval(3.0, 4.0), def))
    @test precedes(DecoratedInterval(Interval(-3.0, -1.0), def), DecoratedInterval(Interval(-1.0, 0.0), trv))
    @test precedes(DecoratedInterval(Interval(-3.0, -1.0), trv), DecoratedInterval(Interval(-1.0, -0.0), trv))
    @test precedes(DecoratedInterval(Interval(1.0, 3.5), trv), DecoratedInterval(Interval(3.0, 4.0), trv)) == false
    @test precedes(DecoratedInterval(Interval(1.0, 4.0), trv), DecoratedInterval(Interval(3.0, 4.0), trv)) == false
    @test precedes(DecoratedInterval(Interval(-3.0, -0.1), trv), DecoratedInterval(Interval(-1.0, 0.0), trv)) == false
    @test precedes(DecoratedInterval(Interval(0.0, 0.0), trv), DecoratedInterval(Interval(-0.0, -0.0), trv))
    @test precedes(DecoratedInterval(Interval(-0.0, -0.0), trv), DecoratedInterval(Interval(0.0, 0.0), def))
    @test precedes(DecoratedInterval(Interval(-0.0, 0.0), trv), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test precedes(DecoratedInterval(Interval(-0.0, 0.0), def), DecoratedInterval(Interval(0.0, -0.0), trv))
    @test precedes(DecoratedInterval(Interval(0.0, -0.0), trv), DecoratedInterval(Interval(0.0, 0.0), trv))
    @test precedes(DecoratedInterval(Interval(0.0, -0.0), trv), DecoratedInterval(Interval(-0.0, 0.0), trv))
end

@testset "minimal_interior_test" begin
    @test ⪽(∅, ∅)
    @test isinterior(∅, ∅)
    @test ⪽(∅, Interval(0.0, 4.0))
    @test isinterior(∅, Interval(0.0, 4.0))
    @test ⪽(Interval(0.0, 4.0), ∅) == false
    @test isinterior(Interval(0.0, 4.0), ∅) == false
    @test ⪽(Interval(-Inf, Inf), Interval(-Inf, Inf))
    @test isinterior(Interval(-Inf, Inf), Interval(-Inf, Inf))
    @test ⪽(Interval(0.0, 4.0), Interval(-Inf, Inf))
    @test isinterior(Interval(0.0, 4.0), Interval(-Inf, Inf))
    @test ⪽(∅, Interval(-Inf, Inf))
    @test isinterior(∅, Interval(-Inf, Inf))
    @test ⪽(Interval(-Inf, Inf), Interval(0.0, 4.0)) == false
    @test isinterior(Interval(-Inf, Inf), Interval(0.0, 4.0)) == false
    @test ⪽(Interval(0.0, 4.0), Interval(0.0, 4.0)) == false
    @test isinterior(Interval(0.0, 4.0), Interval(0.0, 4.0)) == false
    @test ⪽(Interval(1.0, 2.0), Interval(0.0, 4.0))
    @test isinterior(Interval(1.0, 2.0), Interval(0.0, 4.0))
    @test ⪽(Interval(-2.0, 2.0), Interval(-2.0, 4.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-2.0, 4.0)) == false
    @test ⪽(Interval(-0.0, -0.0), Interval(-2.0, 4.0))
    @test isinterior(Interval(-0.0, -0.0), Interval(-2.0, 4.0))
    @test ⪽(Interval(0.0, 0.0), Interval(-2.0, 4.0))
    @test isinterior(Interval(0.0, 0.0), Interval(-2.0, 4.0))
    @test ⪽(Interval(0.0, 0.0), Interval(-0.0, -0.0)) == false
    @test isinterior(Interval(0.0, 0.0), Interval(-0.0, -0.0)) == false
    @test ⪽(Interval(0.0, 4.4), Interval(0.0, 4.0)) == false
    @test isinterior(Interval(0.0, 4.4), Interval(0.0, 4.0)) == false
    @test ⪽(Interval(-1.0, -1.0), Interval(0.0, 4.0)) == false
    @test isinterior(Interval(-1.0, -1.0), Interval(0.0, 4.0)) == false
    @test ⪽(Interval(2.0, 2.0), Interval(-2.0, -1.0)) == false
    @test isinterior(Interval(2.0, 2.0), Interval(-2.0, -1.0)) == false
end

@testset "minimal_interior_dec_test" begin
    @test ⪽(DecoratedInterval(∅, trv), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test isinterior(DecoratedInterval(∅, trv), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test ⪽(DecoratedInterval(Interval(0.0, 4.0), def), DecoratedInterval(∅, trv)) == false
    @test isinterior(DecoratedInterval(Interval(0.0, 4.0), def), DecoratedInterval(∅, trv)) == false
    @test ⪽(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(∅, trv)) == false
    @test isinterior(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(∅, trv)) == false
    @test ⪽(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test isinterior(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⪽(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test isinterior(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⪽(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test isinterior(DecoratedInterval(∅, trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test ⪽(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test isinterior(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test ⪽(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test isinterior(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test ⪽(DecoratedInterval(Interval(1.0, 2.0), def), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test isinterior(DecoratedInterval(Interval(1.0, 2.0), def), DecoratedInterval(Interval(0.0, 4.0), trv))
    @test ⪽(DecoratedInterval(Interval(-2.0, 2.0), trv), DecoratedInterval(Interval(-2.0, 4.0), def)) == false
    @test isinterior(DecoratedInterval(Interval(-2.0, 2.0), trv), DecoratedInterval(Interval(-2.0, 4.0), def)) == false
    @test ⪽(DecoratedInterval(Interval(-0.0, -0.0), trv), DecoratedInterval(Interval(-2.0, 4.0), trv))
    @test isinterior(DecoratedInterval(Interval(-0.0, -0.0), trv), DecoratedInterval(Interval(-2.0, 4.0), trv))
    @test ⪽(DecoratedInterval(Interval(0.0, 0.0), def), DecoratedInterval(Interval(-2.0, 4.0), trv))
    @test isinterior(DecoratedInterval(Interval(0.0, 0.0), def), DecoratedInterval(Interval(-2.0, 4.0), trv))
    @test ⪽(DecoratedInterval(Interval(0.0, 0.0), trv), DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
    @test isinterior(DecoratedInterval(Interval(0.0, 0.0), trv), DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
    @test ⪽(DecoratedInterval(Interval(0.0, 4.4), trv), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test isinterior(DecoratedInterval(Interval(0.0, 4.4), trv), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test ⪽(DecoratedInterval(Interval(-1.0, -1.0), trv), DecoratedInterval(Interval(0.0, 4.0), def)) == false
    @test isinterior(DecoratedInterval(Interval(-1.0, -1.0), trv), DecoratedInterval(Interval(0.0, 4.0), def)) == false
    @test ⪽(DecoratedInterval(Interval(2.0, 2.0), def), DecoratedInterval(Interval(-2.0, -1.0), trv)) == false
    @test isinterior(DecoratedInterval(Interval(2.0, 2.0), def), DecoratedInterval(Interval(-2.0, -1.0), trv)) == false
end

@testset "minimal_strictLess_test" begin
    @test <(∅, ∅)
    @test <(Interval(1.0, 2.0), ∅) == false
    @test <(∅, Interval(1.0, 2.0)) == false
    @test <(Interval(-Inf, Inf), Interval(-Inf, Inf))
    @test <(Interval(1.0, 2.0), Interval(-Inf, Inf)) == false
    @test <(Interval(-Inf, Inf), Interval(1.0, 2.0)) == false
    @test <(Interval(1.0, 2.0), Interval(1.0, 2.0)) == false
    @test <(Interval(1.0, 2.0), Interval(3.0, 4.0))
    @test <(Interval(1.0, 3.5), Interval(3.0, 4.0))
    @test <(Interval(1.0, 4.0), Interval(3.0, 4.0)) == false
    @test <(Interval(0.0, 4.0), Interval(0.0, 4.0)) == false
    @test <(Interval(-0.0, 4.0), Interval(0.0, 4.0)) == false
    @test <(Interval(-2.0, -1.0), Interval(-2.0, -1.0)) == false
    @test <(Interval(-3.0, -1.5), Interval(-2.0, -1.0))
end

@testset "minimal_strictLess_dec_test" begin
    @test <(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(∅, trv)) == false
    @test <(DecoratedInterval(∅, trv), DecoratedInterval(Interval(1.0, 2.0), def)) == false
    @test <(DecoratedInterval(Interval(1.0, 2.0), def), DecoratedInterval(∅, trv)) == false
    @test <(DecoratedInterval(∅, trv), DecoratedInterval(Interval(1.0, 2.0), def)) == false
    @test <(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv))
    @test <(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test <(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test <(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test <(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test <(DecoratedInterval(Interval(1.0, 3.5), def), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test <(DecoratedInterval(Interval(1.0, 4.0), trv), DecoratedInterval(Interval(3.0, 4.0), def)) == false
    @test <(DecoratedInterval(Interval(0.0, 4.0), trv), DecoratedInterval(Interval(0.0, 4.0), def)) == false
    @test <(DecoratedInterval(Interval(-0.0, 4.0), def), DecoratedInterval(Interval(0.0, 4.0), trv)) == false
    @test <(DecoratedInterval(Interval(-2.0, -1.0), def), DecoratedInterval(Interval(-2.0, -1.0), def)) == false
    @test <(DecoratedInterval(Interval(-3.0, -1.5), trv), DecoratedInterval(Interval(-2.0, -1.0), trv))
end

@testset "minimal_strictPrecedes_test" begin
    @test strictprecedes(∅, Interval(3.0, 4.0))
    @test strictprecedes(Interval(3.0, 4.0), ∅)
    @test strictprecedes(∅, ∅)
    @test strictprecedes(Interval(1.0, 2.0), Interval(-Inf, Inf)) == false
    @test strictprecedes(Interval(-Inf, Inf), Interval(1.0, 2.0)) == false
    @test strictprecedes(Interval(-Inf, Inf), Interval(-Inf, Inf)) == false
    @test strictprecedes(Interval(1.0, 2.0), Interval(3.0, 4.0))
    @test strictprecedes(Interval(1.0, 3.0), Interval(3.0, 4.0)) == false
    @test strictprecedes(Interval(-3.0, -1.0), Interval(-1.0, 0.0)) == false
    @test strictprecedes(Interval(-3.0, -0.0), Interval(0.0, 1.0)) == false
    @test strictprecedes(Interval(-3.0, 0.0), Interval(-0.0, 1.0)) == false
    @test strictprecedes(Interval(1.0, 3.5), Interval(3.0, 4.0)) == false
    @test strictprecedes(Interval(1.0, 4.0), Interval(3.0, 4.0)) == false
    @test strictprecedes(Interval(-3.0, -0.1), Interval(-1.0, 0.0)) == false
end

@testset "minimal_strictPrecedes_dec_test" begin
    @test strictprecedes(DecoratedInterval(∅, trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test strictprecedes(DecoratedInterval(Interval(3.0, 4.0), def), DecoratedInterval(∅, trv))
    @test strictprecedes(DecoratedInterval(∅, trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test strictprecedes(DecoratedInterval(Interval(3.0, 4.0), def), DecoratedInterval(∅, trv))
    @test strictprecedes(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(1.0, 2.0), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(1.0, 2.0), trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test strictprecedes(DecoratedInterval(Interval(1.0, 3.0), def), DecoratedInterval(Interval(3.0, 4.0), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(-3.0, -1.0), trv), DecoratedInterval(Interval(-1.0, 0.0), def)) == false
    @test strictprecedes(DecoratedInterval(Interval(-3.0, -0.0), def), DecoratedInterval(Interval(0.0, 1.0), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(-3.0, 0.0), trv), DecoratedInterval(Interval(-0.0, 1.0), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(1.0, 3.5), trv), DecoratedInterval(Interval(3.0, 4.0), trv)) == false
    @test strictprecedes(DecoratedInterval(Interval(1.0, 4.0), trv), DecoratedInterval(Interval(3.0, 4.0), def)) == false
    @test strictprecedes(DecoratedInterval(Interval(-3.0, -0.1), trv), DecoratedInterval(Interval(-1.0, 0.0), trv)) == false
end

@testset "minimal_disjoint_test" begin
    @test isdisjoint(∅, Interval(3.0, 4.0))
    @test isdisjoint(Interval(3.0, 4.0), ∅)
    @test isdisjoint(∅, ∅)
    @test isdisjoint(Interval(3.0, 4.0), Interval(1.0, 2.0))
    @test isdisjoint(Interval(0.0, 0.0), Interval(-0.0, -0.0)) == false
    @test isdisjoint(Interval(0.0, -0.0), Interval(-0.0, 0.0)) == false
    @test isdisjoint(Interval(3.0, 4.0), Interval(1.0, 7.0)) == false
    @test isdisjoint(Interval(3.0, 4.0), Interval(-Inf, Inf)) == false
    @test isdisjoint(Interval(-Inf, Inf), Interval(1.0, 7.0)) == false
    @test isdisjoint(Interval(-Inf, Inf), Interval(-Inf, Inf)) == false
end

@testset "minimal_disjoint_dec_test" begin
    @test isdisjoint(DecoratedInterval(∅, trv), DecoratedInterval(Interval(3.0, 4.0), def))
    @test isdisjoint(DecoratedInterval(Interval(3.0, 4.0), trv), DecoratedInterval(∅, trv))
    @test isdisjoint(DecoratedInterval(∅, trv), DecoratedInterval(Interval(3.0, 4.0), trv))
    @test isdisjoint(DecoratedInterval(Interval(3.0, 4.0), trv), DecoratedInterval(∅, trv))
    @test isdisjoint(DecoratedInterval(Interval(3.0, 4.0), trv), DecoratedInterval(Interval(1.0, 2.0), def))
    @test isdisjoint(DecoratedInterval(Interval(0.0, 0.0), trv), DecoratedInterval(Interval(-0.0, -0.0), trv)) == false
    @test isdisjoint(DecoratedInterval(Interval(0.0, -0.0), trv), DecoratedInterval(Interval(-0.0, 0.0), trv)) == false
    @test isdisjoint(DecoratedInterval(Interval(3.0, 4.0), def), DecoratedInterval(Interval(1.0, 7.0), def)) == false
    @test isdisjoint(DecoratedInterval(Interval(3.0, 4.0), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
    @test isdisjoint(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(1.0, 7.0), trv)) == false
    @test isdisjoint(DecoratedInterval(Interval(-Inf, Inf), trv), DecoratedInterval(Interval(-Inf, Inf), trv)) == false
end
# FactCheck.exitstatus()
