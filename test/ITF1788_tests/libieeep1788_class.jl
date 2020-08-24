#=
 
 Unit tests from libieeep1788 for interval constructors
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
setprecision(53)
setprecision(Interval, Float64)
setrounding(Interval, :tight)
# Set full format, and show decorations
@format full

@testset "minimal_nums_to_interval_test" begin
    @test Interval(-1.0, 1.0) == Interval(-1.0, 1.0)
    @test Interval(-Inf, 1.0) == Interval(-Inf, 1.0)
    @test Interval(-1.0, Inf) == Interval(-1.0, Inf)
    @test Interval(-Inf, Inf) == Interval(-Inf, Inf)
    @test_throws ArgumentError @interval(NaN, NaN)
    @test_throws ArgumentError @interval(1.0, -1.0) ### ∅
    @test Interval(-Inf, -Inf) == Interval(-Inf, -Inf) ### ∅
    @test Interval(Inf, Inf) == Interval(Inf, Inf) ### ∅
end

@testset "minimal_nums_to_decorated_interval_test" begin
    @test @decorated(-1.0, 1.0) == DecoratedInterval(Interval(-1.0, 1.0), com)
    @test @decorated(-Inf, 1.0) == DecoratedInterval(Interval(-Inf, 1.0), dac)
    @test @decorated(-1.0, Inf) == DecoratedInterval(Interval(-1.0, Inf), dac)
    @test @decorated(-Inf, Inf) == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test_throws ArgumentError @decorated(NaN, NaN)
    @test_throws ArgumentError @decorated(1.0, -1.0)
    @test @decorated(-Inf, -Inf) == DecoratedInterval(Interval(-Inf, -1.7976931348623157e308), dac) ###nai() or undefined
    @test @decorated(Inf, Inf) == DecoratedInterval(Interval(1.7976931348623157e308, Inf), dac) ###nai() or undefined
end

@testset "minimal_text_to_interval_test" begin
    @test @interval("[ Empty  ]") == ∅
    @test_throws ArgumentError @interval("[ Empty  ]_trv")
    @test @interval("[  ]") == ∅
    @test_throws ArgumentError @interval("[  ]_trv") 
    @test @interval("[,]") == @interval(-Inf, Inf)
    @test_throws ArgumentError @interval("[,]_trv") 
    @test @interval("[ entire  ]") == @interval(-Inf, Inf)
    @test_throws ArgumentError @interval("[ ENTIRE ]_dac") 
    @test @interval("[ ENTIRE ]") == Interval(-Inf, Inf)
    @test @interval("[ -inf , INF  ]") == Interval(-Inf, Inf)
    @test_throws ArgumentError @interval("[ -inf, INF ]_def") 
    @test @interval("[-1.0,1.0]") == Interval(-1.0, 1.0)
    @test @interval("[  -1.0  ,  1.0  ]") == Interval(-1.0, 1.0)
    @test @interval("[  -1.0  , 1.0]") == Interval(-1.0, 1.0)
    @test @interval("[-1,]") == Interval(-1.0, Inf)
    @test @interval("[-1.0, +inf]") == Interval(-1.0, Inf)
    @test @interval("[-1.0, +infinity]") == Interval(-1.0, Inf)
    @test @interval("[-Inf, 1.000 ]") == Interval(-Inf, 1.0)
    @test @interval("[-Infinity, 1.000 ]") == Interval(-Inf, 1.0)
    @test @interval("[1.0E+400 ]") == Interval(0x1.fffffffffffffp+1023, Inf)
    @test @interval("[ -4/2, 10/5 ]") == Interval(-2.0, 2.0)
    @test @interval("[ -1/10, 1/10 ]") == Interval(-0.1, 0.1)
    @test @interval("0.0?") == Interval(-0.05, 0.05)
    @test @interval("0.0?u") == Interval(0.0, 0.05)
    @test @interval("0.0?d") == Interval(-0.05, 0.0)
    @test @interval("2.5?") == Interval(0x1.3999999999999p+1, 0x1.4666666666667p+1)
    @test @interval("2.5?u") == Interval(2.5, 0x1.4666666666667p+1)
    @test @interval("2.5?d") == Interval(0x1.3999999999999p+1, 2.5)
    @test @interval("0.000?5") == Interval(-0.005, 0.005)
    @test @interval("0.000?5u") == Interval(0.0, 0.005)
    @test @interval("0.000?5d") == Interval(-0.005, 0.0)
    @test @interval("2.500?5") == Interval(0x1.3f5c28f5c28f5p+1, 0x1.40a3d70a3d70bp+1)
    @test @interval("2.500?5u") == Interval(2.5, 0x1.40a3d70a3d70bp+1)
    @test @interval("2.500?5d") == Interval(0x1.3f5c28f5c28f5p+1, 2.5)
    @test @interval("0.0??") == Interval(-Inf, Inf)
    @test @interval("0.0??u") == Interval(0.0, Inf)
    @test @interval("0.0??d") == Interval(-Inf, 0.0)
    @test @interval("2.5??") == Interval(-Inf, Inf)
    @test @interval("2.5??u") == Interval(2.5, Inf)
    @test @interval("2.5??d") == Interval(-Inf, 2.5)
    @test @interval("2.500?5e+27") == Interval(0x1.01fa19a08fe7fp+91, 0x1.0302cc4352683p+91)
    @test @interval("2.500?5ue4") == Interval(0x1.86ap+14, 0x1.8768p+14)
    @test @interval("2.500?5de-5") == Interval(0x1.a2976f1cee4d5p-16, 0x1.a36e2eb1c432dp-16)
    @test @interval("10?3") == @interval(7.0, 13.0)
    @test @interval("10?3e+380") == Interval(0x1.fffffffffffffp+1023, Inf)
    @test @interval("1.0000000000000001?1") == @interval(1.0, 0x1.0000000000001p+0)
    # 10?18 + 308 zeros
    @test @interval("10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") == @interval(-Inf, Inf)
    @test_throws ArgumentError @interval("[ Nai  ]") 
    @test_throws ArgumentError @interval("[ Nai  ]_ill") 
    @test_throws ArgumentError @interval("[ Nai  ]_trv")
    @test_throws ArgumentError @interval("[ Empty  ]_ill")
    @test_throws ArgumentError @interval("[  ]_com") 
    @test_throws ArgumentError @interval("[,]_com") 
    @test_throws ArgumentError @interval("[   Entire ]_com") 
    @test_throws ArgumentError @interval("[ -inf ,  INF ]_com") 
    @test_throws ArgumentError @interval("[  -1.0  , 1.0]_ill") 
    @test_throws ArgumentError @interval("[  -1.0  , 1.0]_fooo") 
    @test_throws ArgumentError @interval("[  -1.0  , 1.0]_da") 
    @test_throws ArgumentError @interval("[-1.0,]_com") 
    @test_throws ArgumentError @interval("[-Inf, 1.000 ]_ill") 
    @test_throws ArgumentError @interval("[-I  nf, 1.000 ]") 
    @test_throws ArgumentError @interval("[-Inf, 1.0  00 ]")
    @test_throws ArgumentError @interval("[-Inf ]") 
    @test @interval("[Inf , INF]") == @interval(Inf, Inf) ### ∅
    @test_throws ArgumentError @interval("[ foo ]") 
    @test_throws ArgumentError @interval("0.0??_com")
    @test_throws ArgumentError @interval("0.0??u_ill")
    @test_throws ArgumentError @interval("0.0??d_com")
    @test @interval("[1.0000000000000002,1.0000000000000001]") == @interval(1.0, 0x1.0000000000001p+0)
    @test @interval("[10000000000000001/10000000000000000,10000000000000002/10000000000000001]") == Interval(1.0, 1.0000000000000002) ###@interval(1.0, 0x1.0000000000001p+0)(strict rounding) 
    @test @interval("[0x1.00000000000002p0,0x1.00000000000001p0]") == @interval(1.0, 0x1.0000000000001p+0)
end

@testset "minimal_text_to_decorated_interval_test" begin
    @test @decorated("[ Empty  ]") == DecoratedInterval(∅, trv)
    @test @decorated("[ Empty  ]_trv") == DecoratedInterval(∅, trv)
    @test @decorated("[  ]") == DecoratedInterval(∅, trv)
    @test @decorated("[  ]_trv") == DecoratedInterval(∅, trv)
    @test @decorated("[,]") == DecoratedInterval(entireinterval(Float64), dac)
    @test @decorated("[,]_trv") == DecoratedInterval(entireinterval(Float64), trv)
    @test @decorated("[ entire  ]") == DecoratedInterval(entireinterval(Float64), dac)
    @test @decorated("[ ENTIRE ]_dac") == DecoratedInterval(entireinterval(Float64), dac)
    @test @decorated("[ -inf , INF  ]") == DecoratedInterval(entireinterval(Float64), dac)
    @test @decorated("[ -inf, INF ]_def") == DecoratedInterval(entireinterval(Float64), def)
    @test @decorated("[-1.0,1.0]") == DecoratedInterval(Interval(-1.0, 1.0), com)
    @test @decorated("[  -1.0  ,  1.0  ]_com") == DecoratedInterval(Interval(-1.0, 1.0), com)
    @test @decorated("[  -1.0  , 1.0]_trv") == DecoratedInterval(Interval(-1.0, 1.0), trv)
    @test @decorated("[-1,]") == DecoratedInterval(Interval(-1.0, Inf), dac)
    @test @decorated("[-1.0, +inf]_def") == DecoratedInterval(Interval(-1.0, Inf), def)
    @test @decorated("[-1.0, +infinity]_def") == DecoratedInterval(Interval(-1.0, Inf), def)
    @test @decorated("[-Inf, 1.000 ]") == DecoratedInterval(Interval(-Inf, 1.0), dac)
    @test @decorated("[-Infinity, 1.000 ]_trv") == DecoratedInterval(Interval(-Inf, 1.0), trv)
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[1.0E+400 ]_com")
    @test @decorated("[ -4/2, 10/5 ]_com") == DecoratedInterval(Interval(-2.0, 2.0), com)
    @test @decorated("[ -1/10, 1/10 ]_com") == DecoratedInterval(Interval(-0.1, 0.1), com)
    @test @decorated("0.0?") == DecoratedInterval(Interval(-0.05, 0.05), com)
    @test @decorated("0.0?u_trv") == DecoratedInterval(Interval(0.0, 0.05), trv)
    @test @decorated("0.0?d_dac") == DecoratedInterval(Interval(-0.05, 0.0), dac)
    @test @decorated("2.5?") == DecoratedInterval(Interval(0x1.3999999999999p+1, 0x1.4666666666667p+1), com)
    @test @decorated("2.5?u") == DecoratedInterval(Interval(2.5, 0x1.4666666666667p+1), com)
    @test @decorated("2.5?d_trv") == DecoratedInterval(Interval(0x1.3999999999999p+1, 2.5), trv)
    @test @decorated("0.000?5") == DecoratedInterval(Interval(-0.005, 0.005), com)
    @test @decorated("0.000?5u_def") == DecoratedInterval(Interval(0.0, 0.005), def)
    @test @decorated("0.000?5d") == DecoratedInterval(Interval(-0.005, 0.0), com)
    @test @decorated("2.500?5") == DecoratedInterval(Interval(0x1.3f5c28f5c28f5p+1, 0x1.40a3d70a3d70bp+1), com)
    @test @decorated("2.500?5u") == DecoratedInterval(Interval(2.5, 0x1.40a3d70a3d70bp+1), com)
    @test @decorated("2.500?5d") == DecoratedInterval(Interval(0x1.3f5c28f5c28f5p+1, 2.5), com)
    @test @decorated("0.0??_dac") == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test @decorated("0.0??u_trv") == DecoratedInterval(Interval(0.0, Inf), trv)
    @test @decorated("0.0??d") == DecoratedInterval(Interval(-Inf, 0.0), dac)
    @test @decorated("2.5??") == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test @decorated("2.5??u_def") == DecoratedInterval(Interval(2.5, Inf), def)
    @test @decorated("2.5??d_dac") == DecoratedInterval(Interval(-Inf, 2.5), dac)
    @test @decorated("2.500?5e+27") == DecoratedInterval(Interval(0x1.01fa19a08fe7fp+91, 0x1.0302cc4352683p+91), com)
    @test @decorated("2.500?5ue4_def") == DecoratedInterval(Interval(0x1.86ap+14, 0x1.8768p+14), def)
    @test @decorated("2.500?5de-5") == DecoratedInterval(Interval(0x1.a2976f1cee4d5p-16, 0x1.a36e2eb1c432dp-16), com)
    @test isnai(@decorated("[ Nai  ]"))
    # 10?18 + 308 zeros + _com
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_com")
    @test @decorated("10?3_com") == DecoratedInterval(Interval(7.0, 13.0), com)
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "10?3e380_com")
    @test isnai(@decorated("[ Nai  ]_ill"))
    @test isnai(@decorated("[ Nai  ]_trv"))
    @test isnai(@decorated("[ Empty  ]_ill"))
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[  ]_com")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[,]_com")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[   Entire ]_com")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[ -inf ,  INF ]_com")
    @test isnai(@decorated("[  -1.0  , 1.0]_ill"))
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[  -1.0  , 1.0]_foo")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[  -1.0  , 1.0]_da")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[-1.0,]_com")
    @test isnai(@decorated("[-Inf, 1.000 ]_ill"))
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[-I  nf, 1.000 ]")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[-Inf, 1.0  00 ]")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[-Inf ]")
    @test @decorated("[Inf , INF]") == DecoratedInterval(Interval(1.7976931348623157e308, Inf), dac) ###nai()
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "[ foo ]")
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "0.0??_com")
    @test isnai(@decorated("0.0??u_ill"))
    @test_throws ArgumentError var"@decorated"(LineNumberNode(1), @__MODULE__, "0.0??d_com")
    @test_throws ErrorException var"@decorated"(LineNumberNode(1), @__MODULE__, "[1.0,2.0")
    # @test @decorated("[1.0000000000000002,1.0000000000000001]") == DecoratedInterval(Interval(1.0, 0x1.0000000000001p+0), com)
    @test @decorated("[10000000000000001/10000000000000000,10000000000000002/10000000000000001]") == DecoratedInterval(Interval(1.0, 0x1.0000000000001p+0), com)
    # @test @decorated("[0x1.00000000000002p0,0x1.00000000000001p0]") == DecoratedInterval(Interval(1.0, 0x1.0000000000001p+0), com)
end

@testset "minimal_interval_part_test" begin
    @test interval(@decorated("[-0x1.99999A842549Ap+4,0X1.9999999999999P-4]_trv")) == @interval(-0x1.99999A842549Ap+4, 0x1.9999999999999P-4)
    @test interval(@decorated("[-0X1.99999C0000000p+4,0X1.9999999999999P-4]_com")) == @interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)
    @test interval(@decorated("[-0x1.99999A842549Ap+4,0x1.99999A0000000p-4]_dac")) == @interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)
    @test interval(@decorated("[-0X1.99999C0000000p+4,0x1.99999A0000000p-4]_def")) == @interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)
    @test interval(@decorated("[-0x0.0000000000001p-1022,-0x0.0000000000001p-1022]_trv")) == @interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)
    @test interval(@decorated("[0x0.0000000000001p-1022,0x0.0000000000001p-1022]_trv")) == @interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)
    @test interval(@decorated("[-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023]_trv")) == @interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)
    @test interval(@decorated("[-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023]_trv")) == @interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)
    @test interval(@decorated("[0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023]_trv")) == @interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)
    @test interval(@decorated("[-infinity,infinity]_trv")) == entireinterval()
    @test interval(@decorated("[empty]_trv")) == @interval("[empty]")
    @test interval(@decorated("[-0X1.99999C0000000p+4,0X1.9999999999999P-4]_com")) == @interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)
    @test_throws IntervalArithmetic.IntvlPartOfNaI interval(@decorated("[nai]"))
end

@testset "minimal_new_dec_test" begin
    @test DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.9999999999999p-4)) == DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.9999999999999p-4), com)
    @test DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4)) == DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4), com)
    @test DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.99999a0000000p-4)) == DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.99999a0000000p-4), com)
    @test DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.99999a0000000p-4)) == DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.99999a0000000p-4), com)
    @test DecoratedInterval(Interval(-0x0.0000000000001p-1022, -0x0.0000000000001p-1022)) == DecoratedInterval(Interval(-0x0.0000000000001p-1022, -0x0.0000000000001p-1022), com)
    @test DecoratedInterval(Interval(-0x0.0000000000001p-1022, 0x0.0000000000001p-1022)) == DecoratedInterval(Interval(-0x0.0000000000001p-1022, 0x0.0000000000001p-1022), com)
    @test DecoratedInterval(Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022)) == DecoratedInterval(Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022), com)
    @test DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, -0x1.fffffffffffffp+1023)) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, -0x1.fffffffffffffp+1023), com)
    @test DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023)) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023), com)
    @test DecoratedInterval(Interval(0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023)) == DecoratedInterval(Interval(0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023), com)
    @test DecoratedInterval(Interval(-Inf, Inf)) == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test DecoratedInterval(∅) == DecoratedInterval(∅, trv)
    @test DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4)) == DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4), com)
end

@testset "minimal_set_dec_test" begin
    @test DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.9999999999999p-4), trv) == DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.9999999999999p-4), trv)
    @test DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4), com) == DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4), com)
    @test DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.99999a0000000p-4), dac) == DecoratedInterval(Interval(-0x1.99999a842549ap+4, 0x1.99999a0000000p-4), dac)
    @test DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.99999a0000000p-4), def) == DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.99999a0000000p-4), def)
    @test DecoratedInterval(Interval(-0x0.0000000000001p-1022, -0x0.0000000000001p-1022), trv) == DecoratedInterval(Interval(-0x0.0000000000001p-1022, -0x0.0000000000001p-1022), trv)
    @test DecoratedInterval(Interval(-0x0.0000000000001p-1022, 0x0.0000000000001p-1022), def) == DecoratedInterval(Interval(-0x0.0000000000001p-1022, 0x0.0000000000001p-1022), def)
    @test DecoratedInterval(Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022), dac) == DecoratedInterval(Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022), dac)
    @test DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, -0x1.fffffffffffffp+1023), com) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, -0x1.fffffffffffffp+1023), com)
    @test DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023), def) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023), def)
    @test DecoratedInterval(Interval(0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023), trv) == DecoratedInterval(Interval(0x1.fffffffffffffp+1023, 0x1.fffffffffffffp+1023), trv)
    @test DecoratedInterval(Interval(-Inf, Inf), dac) == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test DecoratedInterval(∅, trv) == DecoratedInterval(∅, trv)
    @test DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4), com) == DecoratedInterval(Interval(-0x1.99999c0000000p+4, 0x1.9999999999999p-4), com)
    @test DecoratedInterval(∅, def) == DecoratedInterval(∅, trv)
    @test DecoratedInterval(∅, dac) == DecoratedInterval(∅, trv)
    @test DecoratedInterval(∅, com) == DecoratedInterval(∅, trv)
    @test DecoratedInterval(Interval(1.0, Inf), com) == DecoratedInterval(Interval(1.0, Inf), dac)
    @test DecoratedInterval(Interval(-Inf, 3.0), com) == DecoratedInterval(Interval(-Inf, 3.0), dac)
    @test DecoratedInterval(Interval(-Inf, Inf), com) == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test isnai(DecoratedInterval(∅, ill))
    @test isnai(DecoratedInterval(Interval(-Inf, 3.0), ill))
    @test isnai(DecoratedInterval(Interval(-1.0, 3.0), ill))
end

@testset "minimal_decoration_part_test" begin
    @test decoration(nai()) == ill
    @test decoration(DecoratedInterval(∅, trv)) == trv
    @test decoration(DecoratedInterval(Interval(-1.0, 3.0), trv)) == trv
    @test decoration(DecoratedInterval(Interval(-1.0, 3.0), def)) == def
    @test decoration(DecoratedInterval(Interval(-1.0, 3.0), dac)) == dac
    @test decoration(DecoratedInterval(Interval(-1.0, 3.0), com)) == com
end
# FactCheck.exitstatus()
