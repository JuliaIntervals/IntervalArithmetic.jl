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

@testset "minimal_overlap_test" begin
    @test overlap(∅, ∅) == "bothEmpty"
    @test overlap(∅, Interval(1.0,2.0)) == "firstEmpty"
    @test overlap(Interval(1.0,2.0),∅) == "secondEmpty"

    @test overlap(Interval(-Inf,2.0), Interval(3.0,Inf)) == "before"
    @test overlap(Interval(-Inf,2.0), Interval(3.0,4.0)) == "before"
    @test overlap(Interval(2.0,2.0), Interval(3.0,4.0)) == "before"
    @test overlap(Interval(1.0,2.0), Interval(3.0,4.0)) == "before"
    @test overlap(Interval(1.0,2.0), Interval(3.0,3.0)) == "before"
    @test overlap(Interval(2.0,2.0), Interval(3.0,3.0)) == "before"
    @test overlap(Interval(2.0,2.0), Interval(3.0,Inf)) == "before"

    @test overlap(Interval(-Inf,2.0), Interval(2.0,3.0)) == "meets"
    @test overlap(Interval(1.0,2.0), Interval(2.0,3.0)) == "meets"
    @test overlap(Interval(1.0,2.0), Interval(2.0,Inf)) == "meets"

    @test overlap(Interval(1.0,2.0), Interval(1.5,2.5)) == "overlaps"

    @test overlap(Interval(1.0,2.0), Interval(1.0,Inf)) == "starts"
    @test overlap(Interval(1.0,2.0), Interval(1.0,3.0)) == "starts"
    @test overlap(Interval(1.0,1.0), Interval(1.0,3.0)) == "starts"

    @test overlap(Interval(1.0,2.0), Interval(-Inf,Inf)) == "containedBy"
    @test overlap(Interval(1.0,2.0), Interval(-Inf,3.0)) == "containedBy"
    @test overlap(Interval(1.0,2.0), Interval(0.0,3.0)) == "containedBy"
    @test overlap(Interval(2.0,2.0), Interval(0.0,3.0)) == "containedBy"
    @test overlap(Interval(2.0,2.0), Interval(0.0,Inf)) == "containedBy"

    @test overlap(Interval(1.0,2.0), Interval(-Inf,2.0)) == "finishes"
    @test overlap(Interval(1.0,2.0), Interval(0.0,2.0)) == "finishes"
    @test overlap(Interval(2.0,2.0), Interval(0.0,2.0)) == "finishes"

    @test overlap(Interval(1.0,2.0), Interval(1.0,2.0)) == "equals"
    @test overlap(Interval(1.0,1.0), Interval(1.0,1.0)) == "equals"
    @test overlap(Interval(-Inf,1.0), Interval(-Inf,1.0)) == "equals"
    @test overlap(Interval(-Inf,Inf), Interval(-Inf,Inf)) == "equals"

    @test overlap(Interval(3.0,4.0), Interval(2.0,2.0)) == "after"
    @test overlap(Interval(3.0,4.0), Interval(1.0,2.0)) == "after"
    @test overlap(Interval(3.0,3.0), Interval(1.0,2.0)) == "after"
    @test overlap(Interval(3.0,3.0), Interval(2.0,2.0)) == "after"
    @test overlap(Interval(3.0,Inf), Interval(2.0,2.0)) == "after"

    @test overlap(Interval(2.0,3.0), Interval(1.0,2.0)) == "metBy"
    @test overlap(Interval(2.0,3.0), Interval(-Inf,2.0)) == "metBy"

    @test overlap(Interval(1.5,2.5), Interval(1.0,2.0)) == "overlappedBy"
    @test overlap(Interval(1.5,2.5), Interval(-Inf,2.0)) == "overlappedBy"

    @test overlap(Interval(1.0,Inf), Interval(1.0,2.0)) == "startedBy"
    @test overlap(Interval(1.0,3.0), Interval(1.0,2.0)) == "startedBy"
    @test overlap(Interval(1.0,3.0), Interval(1.0,1.0)) == "startedBy"

    @test overlap(Interval(-Inf,3.0), Interval(1.0,2.0)) == "contains"
    @test overlap(Interval(-Inf,Inf), Interval(1.0,2.0)) == "contains"
    @test overlap(Interval(0.0,3.0), Interval(1.0,2.0)) == "contains"
    @test overlap(Interval(0.0,3.0), Interval(2.0,2.0)) == "contains"

    @test overlap(Interval(-Inf,2.0), Interval(1.0,2.0))== "finishedBy"
    @test overlap(Interval(0.0,2.0), Interval(1.0,2.0)) == "finishedBy"
    @test overlap(Interval(0.0,2.0), Interval(2.0,2.0)) == "finishedBy"
end

@testset "minimal_overlap_dec_test" begin
    @test overlap_dec(DecoratedInterval(∅,trv),DecoratedInterval(∅,trv)) == "bothEmpty"
    @test overlap_dec(DecoratedInterval(∅,trv),DecoratedInterval(Interval(1.0,2.0),com)) == "firstEmpty"
    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),def),DecoratedInterval(∅,trv)) == "secondEmpty"

    @test overlap_dec(DecoratedInterval(Interval(2.0,2.0),def),DecoratedInterval(Interval(3.0,4.0),def)) == "before"
    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),dac),DecoratedInterval(Interval(3.0,4.0),com)) == "before"
    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),com),DecoratedInterval(Interval(3.0,3.0),trv)) == "before"
    @test overlap_dec(DecoratedInterval(Interval(2.0,2.0),trv),DecoratedInterval(Interval(3.0,3.0),def)) == "before"

    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),def),DecoratedInterval(Interval(2.0,3.0),def)) == "meets"

    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),dac),DecoratedInterval(Interval(1.5,2.5),def)) == "overlaps"

    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),def),DecoratedInterval(Interval(1.0,3.0),com)) == "starts"
    @test overlap_dec(DecoratedInterval(Interval(1.0,1.0),trv),DecoratedInterval(Interval(1.0,3.0),def)) == "starts"

    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),def),DecoratedInterval(Interval(0.0,3.0),dac)) == "containedBy"
    @test overlap_dec(DecoratedInterval(Interval(2.0,2.0),trv),DecoratedInterval(Interval(0.0,3.0),def)) == "containedBy"

    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),trv),DecoratedInterval(Interval(0.0,2.0),com)) == "finishes"
    @test overlap_dec(DecoratedInterval(Interval(2.0,2.0),def),DecoratedInterval(Interval(0.0,2.0),dac)) == "finishes"

    @test overlap_dec(DecoratedInterval(Interval(1.0,2.0),def),DecoratedInterval(Interval(1.0,2.0),def)) == "equals"
    @test overlap_dec(DecoratedInterval(Interval(1.0,1.0),dac),DecoratedInterval(Interval(1.0,1.0),dac)) == "equals"

    @test overlap_dec(DecoratedInterval(Interval(3.0,4.0),trv),DecoratedInterval(Interval(2.0,2.0),trv)) == "after"
    @test overlap_dec(DecoratedInterval(Interval(3.0,4.0),def),DecoratedInterval(Interval(1.0,2.0),def)) == "after"
    @test overlap_dec(DecoratedInterval(Interval(3.0,3.0),com),DecoratedInterval(Interval(1.0,2.0),dac)) == "after"
    @test overlap_dec(DecoratedInterval(Interval(3.0,3.0),def),DecoratedInterval(Interval(2.0,2.0),trv)) == "after"

    @test overlap_dec(DecoratedInterval(Interval(2.0,3.0),def),DecoratedInterval(Interval(1.0,2.0),trv)) == "metBy"
    @test overlap_dec(DecoratedInterval(Interval(1.5,2.5),com),DecoratedInterval(Interval(1.0,2.0),com)) == "overlappedBy"

    @test overlap_dec(DecoratedInterval(Interval(1.0,3.0),dac),DecoratedInterval(Interval(1.0,2.0),def)) == "startedBy"
    @test overlap_dec(DecoratedInterval(Interval(1.0,3.0),com),DecoratedInterval(Interval(1.0,1.0),dac)) == "startedBy"

    @test overlap_dec(DecoratedInterval(Interval(0.0,3.0),com),DecoratedInterval(Interval(1.0,2.0),dac)) == "contains"
    @test overlap_dec(DecoratedInterval(Interval(0.0,3.0),com),DecoratedInterval(Interval(2.0,2.0),def)) == "contains"

    @test overlap_dec(DecoratedInterval(Interval(0.0,2.0),def),DecoratedInterval(Interval(1.0,2.0),trv)) == "finishedBy"
    @test overlap_dec(DecoratedInterval(Interval(0.0,2.0),dac),DecoratedInterval(Interval(2.0,2.0),def)) == "finishedBy"
end
# FactCheck.exitstatus()
