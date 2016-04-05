#
# Copyright 2013 - 2015 Marco Nehmeier (nehmeier@informatik.uni-wuerzburg.de)
# Copyright 2015 Oliver Heimlich (oheim@posteo.de)
#
# Original author: Marco Nehmeier (unit tests in libieeep1788)
# Converted into portable ITL format by Oliver Heimlich with minor corrections.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#Language imports

#Test library imports
using FactCheck

#Arithmetic library imports
using ValidatedNumerics

#Preamble
setprecision(53)
set_interval_precision(Float64)
set_interval_rounding(:narrow)

facts("minimal_pos_test") do
    @fact +Interval(1.0, 2.0) --> Interval(1.0, 2.0)
    @fact +∅ --> ∅
    @fact +entireinterval(Float64) --> entireinterval(Float64)
    @fact +Interval(1.0, Inf) --> Interval(1.0, Inf)
    @fact +Interval(-Inf, -1.0) --> Interval(-Inf, -1.0)
    @fact +Interval(0.0, 2.0) --> Interval(0.0, 2.0)
    @fact +Interval(-0.0, 2.0) --> Interval(0.0, 2.0)
    @fact +Interval(-2.5, -0.0) --> Interval(-2.5, 0.0)
    @fact +Interval(-2.5, 0.0) --> Interval(-2.5, 0.0)
    @fact +Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact +Interval(0.0, 0.0) --> Interval(0.0, 0.0)
end

facts("minimal_pos_dec_test") do

end

facts("minimal_neg_test") do
    @fact -(Interval(1.0, 2.0)) --> Interval(-2.0, -1.0)
    @fact -(∅) --> ∅
    @fact -(entireinterval(Float64)) --> entireinterval(Float64)
    @fact -(Interval(1.0, Inf)) --> Interval(-Inf, -1.0)
    @fact -(Interval(-Inf, 1.0)) --> Interval(-1.0, Inf)
    @fact -(Interval(0.0, 2.0)) --> Interval(-2.0, 0.0)
    @fact -(Interval(-0.0, 2.0)) --> Interval(-2.0, 0.0)
    @fact -(Interval(-2.0, 0.0)) --> Interval(0.0, 2.0)
    @fact -(Interval(-2.0, -0.0)) --> Interval(0.0, 2.0)
    @fact -(Interval(0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact -(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
end

facts("minimal_neg_dec_test") do

end

facts("minimal_add_test") do
    @fact ∅ + ∅ --> ∅
    @fact Interval(-1.0, 1.0) + ∅ --> ∅
    @fact ∅ + Interval(-1.0, 1.0) --> ∅
    @fact ∅ + entireinterval(Float64) --> ∅
    @fact entireinterval(Float64) + ∅ --> ∅
    @fact entireinterval(Float64) + Interval(-Inf, 1.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) + Interval(-1.0, 1.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) + Interval(-1.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) + entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 1.0) + entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-1.0, 1.0) + entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) + entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 2.0) + Interval(-Inf, 4.0) --> Interval(-Inf, 6.0)
    @fact Interval(-Inf, 2.0) + Interval(3.0, 4.0) --> Interval(-Inf, 6.0)
    @fact Interval(-Inf, 2.0) + Interval(3.0, Inf) --> entireinterval(Float64)
    @fact Interval(1.0, 2.0) + Interval(-Inf, 4.0) --> Interval(-Inf, 6.0)
    @fact Interval(1.0, 2.0) + Interval(3.0, 4.0) --> Interval(4.0, 6.0)
    @fact Interval(1.0, 2.0) + Interval(3.0, Inf) --> Interval(4.0, Inf)
    @fact Interval(1.0, Inf) + Interval(-Inf, 4.0) --> entireinterval(Float64)
    @fact Interval(1.0, Inf) + Interval(3.0, 4.0) --> Interval(4.0, Inf)
    @fact Interval(1.0, Inf) + Interval(3.0, Inf) --> Interval(4.0, Inf)
    @fact Interval(1.0, 0x1.fffffffffffffp1023) + Interval(3.0, 4.0) --> Interval(4.0, Inf)
    @fact Interval(-0x1.fffffffffffffp1023, 2.0) + Interval(-3.0, 4.0) --> Interval(-Inf, 6.0)
    @fact Interval(-0x1.fffffffffffffp1023, 2.0) + Interval(-3.0, 0x1.fffffffffffffp1023) --> entireinterval(Float64)
    @fact Interval(1.0, 0x1.fffffffffffffp1023) + Interval(0.0, 0.0) --> Interval(1.0, 0x1.fffffffffffffp1023)
    @fact Interval(1.0, 0x1.fffffffffffffp1023) + Interval(-0.0, -0.0) --> Interval(1.0, 0x1.fffffffffffffp1023)
    @fact Interval(0.0, 0.0) + Interval(-3.0, 4.0) --> Interval(-3.0, 4.0)
    @fact Interval(-0.0, -0.0) + Interval(-3.0, 0x1.fffffffffffffp1023) --> Interval(-3.0, 0x1.fffffffffffffp1023)
    @fact Interval(0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0) + Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4) --> Interval(0x1.0ccccccccccc4p+1, 0x1.0ccccccccccc5p+1)
    @fact Interval(0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0) + Interval(-0x1.999999999999ap-4, -0x1.999999999999ap-4) --> Interval(0x1.e666666666656p+0, 0x1.e666666666657p+0)
    @fact Interval(-0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0) + Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4) --> Interval(-0x1.e666666666657p+0, 0x1.0ccccccccccc5p+1)
end

facts("minimal_add_dec_test") do

end

facts("minimal_sub_test") do
    @fact ∅ - ∅ --> ∅
    @fact Interval(-1.0, 1.0) - ∅ --> ∅
    @fact ∅ - Interval(-1.0, 1.0) --> ∅
    @fact ∅ - entireinterval(Float64) --> ∅
    @fact entireinterval(Float64) - ∅ --> ∅
    @fact entireinterval(Float64) - Interval(-Inf, 1.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) - Interval(-1.0, 1.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) - Interval(-1.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) - entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 1.0) - entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-1.0, 1.0) - entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) - entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 2.0) - Interval(-Inf, 4.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 2.0) - Interval(3.0, 4.0) --> Interval(-Inf, -1.0)
    @fact Interval(-Inf, 2.0) - Interval(3.0, Inf) --> Interval(-Inf, -1.0)
    @fact Interval(1.0, 2.0) - Interval(-Inf, 4.0) --> Interval(-3.0, Inf)
    @fact Interval(1.0, 2.0) - Interval(3.0, 4.0) --> Interval(-3.0, -1.0)
    @fact Interval(1.0, 2.0) - Interval(3.0, Inf) --> Interval(-Inf, -1.0)
    @fact Interval(1.0, Inf) - Interval(-Inf, 4.0) --> Interval(-3.0, Inf)
    @fact Interval(1.0, Inf) - Interval(3.0, 4.0) --> Interval(-3.0, Inf)
    @fact Interval(1.0, Inf) - Interval(3.0, Inf) --> entireinterval(Float64)
    @fact Interval(1.0, 0x1.fffffffffffffp1023) - Interval(-3.0, 4.0) --> Interval(-3.0, Inf)
    @fact Interval(-0x1.fffffffffffffp1023, 2.0) - Interval(3.0, 4.0) --> Interval(-Inf, -1.0)
    @fact Interval(-0x1.fffffffffffffp1023, 2.0) - Interval(-0x1.fffffffffffffp1023, 4.0) --> entireinterval(Float64)
    @fact Interval(1.0, 0x1.fffffffffffffp1023) - Interval(0.0, 0.0) --> Interval(1.0, 0x1.fffffffffffffp1023)
    @fact Interval(1.0, 0x1.fffffffffffffp1023) - Interval(-0.0, -0.0) --> Interval(1.0, 0x1.fffffffffffffp1023)
    @fact Interval(0.0, 0.0) - Interval(-3.0, 4.0) --> Interval(-4.0, 3.0)
    @fact Interval(-0.0, -0.0) - Interval(-3.0, 0x1.fffffffffffffp1023) --> Interval(-0x1.fffffffffffffp1023, 3.0)
    @fact Interval(0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0) - Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4) --> Interval(0x1.e666666666656p+0, 0x1.e666666666657p+0)
    @fact Interval(0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0) - Interval(-0x1.999999999999ap-4, -0x1.999999999999ap-4) --> Interval(0x1.0ccccccccccc4p+1, 0x1.0ccccccccccc5p+1)
    @fact Interval(-0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0) - Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4) --> Interval(-0x1.0ccccccccccc5p+1, 0x1.e666666666657p+0)
end

facts("minimal_sub_dec_test") do

end

facts("minimal_mul_test") do
    @fact ∅ * ∅ --> ∅
    @fact Interval(-1.0, 1.0) * ∅ --> ∅
    @fact ∅ * Interval(-1.0, 1.0) --> ∅
    @fact ∅ * entireinterval(Float64) --> ∅
    @fact entireinterval(Float64) * ∅ --> ∅
    @fact Interval(0.0, 0.0) * ∅ --> ∅
    @fact ∅ * Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) * ∅ --> ∅
    @fact ∅ * Interval(-0.0, -0.0) --> ∅
    @fact entireinterval(Float64) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact entireinterval(Float64) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact entireinterval(Float64) * Interval(-5.0, -1.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) * Interval(-5.0, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) * Interval(1.0, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) * Interval(-Inf, -1.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) * Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) * Interval(-5.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) * Interval(1.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(1.0, Inf) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(1.0, Inf) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(1.0, Inf) * Interval(-5.0, -1.0) --> Interval(-Inf, -1.0)
    @fact Interval(1.0, Inf) * Interval(-5.0, 3.0) --> entireinterval(Float64)
    @fact Interval(1.0, Inf) * Interval(1.0, 3.0) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) * Interval(-Inf, -1.0) --> Interval(-Inf, -1.0)
    @fact Interval(1.0, Inf) * Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(1.0, Inf) * Interval(-5.0, Inf) --> entireinterval(Float64)
    @fact Interval(1.0, Inf) * Interval(1.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, Inf) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, Inf) * Interval(-5.0, -1.0) --> Interval(-Inf, 5.0)
    @fact Interval(-1.0, Inf) * Interval(-5.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) * Interval(1.0, 3.0) --> Interval(-3.0, Inf)
    @fact Interval(-1.0, Inf) * Interval(-Inf, -1.0) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) * Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) * Interval(-5.0, Inf) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) * Interval(1.0, Inf) --> entireinterval(Float64)
    @fact Interval(-1.0, Inf) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 3.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-Inf, 3.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-Inf, 3.0) * Interval(-5.0, -1.0) --> Interval(-15.0, Inf)
    @fact Interval(-Inf, 3.0) * Interval(-5.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 3.0) * Interval(1.0, 3.0) --> Interval(-Inf, 9.0)
    @fact Interval(-Inf, 3.0) * Interval(-Inf, -1.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 3.0) * Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 3.0) * Interval(-5.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, 3.0) * Interval(1.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, 3.0) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, -3.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-Inf, -3.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-Inf, -3.0) * Interval(-5.0, -1.0) --> Interval(3.0, Inf)
    @fact Interval(-Inf, -3.0) * Interval(-5.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, -3.0) * Interval(1.0, 3.0) --> Interval(-Inf, -3.0)
    @fact Interval(-Inf, -3.0) * Interval(-Inf, -1.0) --> Interval(3.0, Inf)
    @fact Interval(-Inf, -3.0) * Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, -3.0) * Interval(-5.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, -3.0) * Interval(1.0, Inf) --> Interval(-Inf, -3.0)
    @fact Interval(-Inf, -3.0) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(-5.0, -1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(-5.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(1.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(-Inf, -1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(-Inf, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(-5.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) * entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(-5.0, -1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(-5.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(1.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(-Inf, -1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(-Inf, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(-5.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) * entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(1.0, 5.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(1.0, 5.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(1.0, 5.0) * Interval(-5.0, -1.0) --> Interval(-25.0, -1.0)
    @fact Interval(1.0, 5.0) * Interval(-5.0, 3.0) --> Interval(-25.0, 15.0)
    @fact Interval(1.0, 5.0) * Interval(1.0, 3.0) --> Interval(1.0, 15.0)
    @fact Interval(1.0, 5.0) * Interval(-Inf, -1.0) --> Interval(-Inf, -1.0)
    @fact Interval(1.0, 5.0) * Interval(-Inf, 3.0) --> Interval(-Inf, 15.0)
    @fact Interval(1.0, 5.0) * Interval(-5.0, Inf) --> Interval(-25.0, Inf)
    @fact Interval(1.0, 5.0) * Interval(1.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, 5.0) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-1.0, 5.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 5.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 5.0) * Interval(-5.0, -1.0) --> Interval(-25.0, 5.0)
    #min max
    @fact Interval(-1.0, 5.0) * Interval(-5.0, 3.0) --> Interval(-25.0, 15.0)
    @fact Interval(-10.0, 2.0) * Interval(-5.0, 3.0) --> Interval(-30.0, 50.0)
    @fact Interval(-1.0, 5.0) * Interval(-1.0, 10.0) --> Interval(-10.0, 50.0)
    @fact Interval(-2.0, 2.0) * Interval(-5.0, 3.0) --> Interval(-10.0, 10.0)
    #end min max
    @fact Interval(-1.0, 5.0) * Interval(1.0, 3.0) --> Interval(-3.0, 15.0)
    @fact Interval(-1.0, 5.0) * Interval(-Inf, -1.0) --> entireinterval(Float64)
    @fact Interval(-1.0, 5.0) * Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-1.0, 5.0) * Interval(-5.0, Inf) --> entireinterval(Float64)
    @fact Interval(-1.0, 5.0) * Interval(1.0, Inf) --> entireinterval(Float64)
    @fact Interval(-1.0, 5.0) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-10.0, -5.0) * Interval(0.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-10.0, -5.0) * Interval(-0.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-10.0, -5.0) * Interval(-5.0, -1.0) --> Interval(5.0, 50.0)
    @fact Interval(-10.0, -5.0) * Interval(-5.0, 3.0) --> Interval(-30.0, 50.0)
    @fact Interval(-10.0, -5.0) * Interval(1.0, 3.0) --> Interval(-30.0, -5.0)
    @fact Interval(-10.0, -5.0) * Interval(-Inf, -1.0) --> Interval(5.0, Inf)
    @fact Interval(-10.0, -5.0) * Interval(-Inf, 3.0) --> Interval(-30.0, Inf)
    @fact Interval(-10.0, -5.0) * Interval(-5.0, Inf) --> Interval(-Inf, 50.0)
    @fact Interval(-10.0, -5.0) * Interval(1.0, Inf) --> Interval(-Inf, -5.0)
    @fact Interval(-10.0, -5.0) * entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(0x1.999999999999ap-4, 0x1.ffffffffffffp+0) * Interval(-0x1.ffffffffffffp+0, Inf) --> Interval(-0x1.fffffffffffe1p+1, Inf)
    @fact Interval(-0x1.999999999999ap-4, 0x1.ffffffffffffp+0) * Interval(-0x1.ffffffffffffp+0, -0x1.999999999999ap-4) --> Interval(-0x1.fffffffffffe1p+1, 0x1.999999999998ep-3)
    @fact Interval(-0x1.999999999999ap-4, 0x1.999999999999ap-4) * Interval(-0x1.ffffffffffffp+0, 0x1.999999999999ap-4) --> Interval(-0x1.999999999998ep-3, 0x1.999999999998ep-3)
    @fact Interval(-0x1.ffffffffffffp+0, -0x1.999999999999ap-4) * Interval(0x1.999999999999ap-4, 0x1.ffffffffffffp+0) --> Interval(-0x1.fffffffffffe1p+1, -0x1.47ae147ae147bp-7)
end

facts("minimal_mul_dec_test") do

end

facts("minimal_div_test") do
    @fact ∅ / ∅ --> ∅
    @fact Interval(-1.0, 1.0) / ∅ --> ∅
    @fact ∅ / Interval(-1.0, 1.0) --> ∅
    @fact ∅ / Interval(0.1, 1.0) --> ∅
    @fact ∅ / Interval(-1.0, -0.1) --> ∅
    @fact ∅ / entireinterval(Float64) --> ∅
    @fact entireinterval(Float64) / ∅ --> ∅
    @fact Interval(0.0, 0.0) / ∅ --> ∅
    @fact ∅ / Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) / ∅ --> ∅
    @fact ∅ / Interval(-0.0, -0.0) --> ∅
    @fact entireinterval(Float64) / Interval(-5.0, -3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(3.0, 5.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-Inf, -3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(3.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(0.0, 0.0) --> ∅
    @fact entireinterval(Float64) / Interval(-0.0, -0.0) --> ∅
    @fact entireinterval(Float64) / Interval(-3.0, 0.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-3.0, -0.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(0.0, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-Inf, 0.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-0.0, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-Inf, -0.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(0.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) / Interval(-0.0, Inf) --> entireinterval(Float64)
    @fact entireinterval(Float64) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-30.0, -15.0) / Interval(-5.0, -3.0) --> Interval(3.0, 10.0)
    @fact Interval(-30.0, -15.0) / Interval(3.0, 5.0) --> Interval(-10.0, -3.0)
    @fact Interval(-30.0, -15.0) / Interval(-Inf, -3.0) --> Interval(0.0, 10.0)
    @fact Interval(-30.0, -15.0) / Interval(3.0, Inf) --> Interval(-10.0, 0.0)
    @fact Interval(-30.0, -15.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-30.0, -15.0) / Interval(-3.0, 0.0) --> Interval(5.0, Inf)
    @fact Interval(-30.0, -15.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-30.0, -15.0) / Interval(-3.0, -0.0) --> Interval(5.0, Inf)
    @fact Interval(-30.0, -15.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, -15.0) / Interval(0.0, 3.0) --> Interval(-Inf, -5.0)
    @fact Interval(-30.0, -15.0) / Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, -15.0) / Interval(-0.0, 3.0) --> Interval(-Inf, -5.0)
    @fact Interval(-30.0, -15.0) / Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, -15.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, -15.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-30.0, -15.0) / Interval(0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, -15.0) / Interval(-0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, -15.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-5.0, -3.0) --> Interval(-5.0, 10.0)
    @fact Interval(-30.0, 15.0) / Interval(3.0, 5.0) --> Interval(-10.0, 5.0)
    @fact Interval(-30.0, 15.0) / Interval(-Inf, -3.0) --> Interval(-5.0, 10.0)
    @fact Interval(-30.0, 15.0) / Interval(3.0, Inf) --> Interval(-10.0, 5.0)
    @fact Interval(-30.0, 15.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-30.0, 15.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-30.0, 15.0) / Interval(-3.0, 0.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-3.0, -0.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(0.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-Inf, 0.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-0.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-Inf, -0.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(0.0, Inf) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / Interval(-0.0, Inf) --> entireinterval(Float64)
    @fact Interval(-30.0, 15.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(15.0, 30.0) / Interval(-5.0, -3.0) --> Interval(-10.0, -3.0)
    @fact Interval(15.0, 30.0) / Interval(3.0, 5.0) --> Interval(3.0, 10.0)
    @fact Interval(15.0, 30.0) / Interval(-Inf, -3.0) --> Interval(-10.0, 0.0)
    @fact Interval(15.0, 30.0) / Interval(3.0, Inf) --> Interval(0.0, 10.0)
    @fact Interval(15.0, 30.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(15.0, 30.0) / Interval(-3.0, 0.0) --> Interval(-Inf, -5.0)
    @fact Interval(15.0, 30.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(15.0, 30.0) / Interval(-3.0, -0.0) --> Interval(-Inf, -5.0)
    @fact Interval(15.0, 30.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(15.0, 30.0) / Interval(0.0, 3.0) --> Interval(5.0, Inf)
    @fact Interval(15.0, 30.0) / Interval(-Inf, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(15.0, 30.0) / Interval(-0.0, 3.0) --> Interval(5.0, Inf)
    @fact Interval(15.0, 30.0) / Interval(-Inf, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(15.0, 30.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(15.0, 30.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(15.0, 30.0) / Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(15.0, 30.0) / Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(15.0, 30.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) / Interval(-5.0, -3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(3.0, 5.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-Inf, -3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(3.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(0.0, 0.0) / Interval(-3.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(0.0, 0.0) / Interval(-3.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-3.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(0.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-Inf, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-0.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-Inf, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-Inf, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-3.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) / entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-5.0, -3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(3.0, 5.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-Inf, -3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(3.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) / Interval(-3.0, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-0.0, -0.0) / Interval(-3.0, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-3.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(0.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-Inf, 0.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-0.0, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-Inf, -0.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-Inf, 3.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-3.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) / entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-Inf, -15.0) / Interval(-5.0, -3.0) --> Interval(3.0, Inf)
    @fact Interval(-Inf, -15.0) / Interval(3.0, 5.0) --> Interval(-Inf, -3.0)
    @fact Interval(-Inf, -15.0) / Interval(-Inf, -3.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -15.0) / Interval(3.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -15.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-Inf, -15.0) / Interval(-3.0, 0.0) --> Interval(5.0, Inf)
    @fact Interval(-Inf, -15.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-Inf, -15.0) / Interval(-3.0, -0.0) --> Interval(5.0, Inf)
    @fact Interval(-Inf, -15.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, -15.0) / Interval(0.0, 3.0) --> Interval(-Inf, -5.0)
    @fact Interval(-Inf, -15.0) / Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -15.0) / Interval(-0.0, 3.0) --> Interval(-Inf, -5.0)
    @fact Interval(-Inf, -15.0) / Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -15.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, -15.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, -15.0) / Interval(0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -15.0) / Interval(-0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -15.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-5.0, -3.0) --> Interval(-5.0, Inf)
    @fact Interval(-Inf, 15.0) / Interval(3.0, 5.0) --> Interval(-Inf, 5.0)
    @fact Interval(-Inf, 15.0) / Interval(-Inf, -3.0) --> Interval(-5.0, Inf)
    @fact Interval(-Inf, 15.0) / Interval(3.0, Inf) --> Interval(-Inf, 5.0)
    @fact Interval(-Inf, 15.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-Inf, 15.0) / Interval(-3.0, 0.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-Inf, 15.0) / Interval(-3.0, -0.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(0.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-Inf, 0.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-0.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-Inf, -0.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(0.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / Interval(-0.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, 15.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-5.0, -3.0) --> Interval(-Inf, 5.0)
    @fact Interval(-15.0, Inf) / Interval(3.0, 5.0) --> Interval(-5.0, Inf)
    @fact Interval(-15.0, Inf) / Interval(-Inf, -3.0) --> Interval(-Inf, 5.0)
    @fact Interval(-15.0, Inf) / Interval(3.0, Inf) --> Interval(-5.0, Inf)
    @fact Interval(-15.0, Inf) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-15.0, Inf) / Interval(-3.0, 0.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-15.0, Inf) / Interval(-3.0, -0.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(0.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-Inf, 0.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-0.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-Inf, -0.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(0.0, Inf) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / Interval(-0.0, Inf) --> entireinterval(Float64)
    @fact Interval(-15.0, Inf) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(15.0, Inf) / Interval(-5.0, -3.0) --> Interval(-Inf, -3.0)
    @fact Interval(15.0, Inf) / Interval(3.0, 5.0) --> Interval(3.0, Inf)
    @fact Interval(15.0, Inf) / Interval(-Inf, -3.0) --> Interval(-Inf, 0.0)
    @fact Interval(15.0, Inf) / Interval(3.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(15.0, Inf) / Interval(0.0, 0.0) --> ∅
    @fact Interval(15.0, Inf) / Interval(-3.0, 0.0) --> Interval(-Inf, -5.0)
    @fact Interval(15.0, Inf) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(15.0, Inf) / Interval(-3.0, -0.0) --> Interval(-Inf, -5.0)
    @fact Interval(15.0, Inf) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(15.0, Inf) / Interval(0.0, 3.0) --> Interval(5.0, Inf)
    @fact Interval(15.0, Inf) / Interval(-Inf, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(15.0, Inf) / Interval(-0.0, 3.0) --> Interval(5.0, Inf)
    @fact Interval(15.0, Inf) / Interval(-Inf, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(15.0, Inf) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(15.0, Inf) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(15.0, Inf) / Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(15.0, Inf) / Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(15.0, Inf) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-30.0, 0.0) / Interval(-5.0, -3.0) --> Interval(0.0, 10.0)
    @fact Interval(-30.0, 0.0) / Interval(3.0, 5.0) --> Interval(-10.0, 0.0)
    @fact Interval(-30.0, 0.0) / Interval(-Inf, -3.0) --> Interval(0.0, 10.0)
    @fact Interval(-30.0, 0.0) / Interval(3.0, Inf) --> Interval(-10.0, 0.0)
    @fact Interval(-30.0, 0.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-30.0, 0.0) / Interval(-3.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, 0.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-30.0, 0.0) / Interval(-3.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, 0.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 0.0) / Interval(0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, 0.0) / Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, 0.0) / Interval(-0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, 0.0) / Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, 0.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, 0.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-30.0, 0.0) / Interval(0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, 0.0) / Interval(-0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, 0.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-30.0, -0.0) / Interval(-5.0, -3.0) --> Interval(0.0, 10.0)
    @fact Interval(-30.0, -0.0) / Interval(3.0, 5.0) --> Interval(-10.0, 0.0)
    @fact Interval(-30.0, -0.0) / Interval(-Inf, -3.0) --> Interval(0.0, 10.0)
    @fact Interval(-30.0, -0.0) / Interval(3.0, Inf) --> Interval(-10.0, 0.0)
    @fact Interval(-30.0, -0.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-30.0, -0.0) / Interval(-3.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, -0.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-30.0, -0.0) / Interval(-3.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, -0.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, -0.0) / Interval(0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, -0.0) / Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, -0.0) / Interval(-0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, -0.0) / Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-30.0, -0.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-30.0, -0.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-30.0, -0.0) / Interval(0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, -0.0) / Interval(-0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-30.0, -0.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(0.0, 30.0) / Interval(-5.0, -3.0) --> Interval(-10.0, 0.0)
    @fact Interval(0.0, 30.0) / Interval(3.0, 5.0) --> Interval(0.0, 10.0)
    @fact Interval(0.0, 30.0) / Interval(-Inf, -3.0) --> Interval(-10.0, 0.0)
    @fact Interval(0.0, 30.0) / Interval(3.0, Inf) --> Interval(0.0, 10.0)
    @fact Interval(0.0, 30.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(0.0, 30.0) / Interval(-3.0, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, 30.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(0.0, 30.0) / Interval(-3.0, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, 30.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(0.0, 30.0) / Interval(0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 30.0) / Interval(-Inf, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, 30.0) / Interval(-0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 30.0) / Interval(-Inf, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, 30.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(0.0, 30.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(0.0, 30.0) / Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 30.0) / Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 30.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-0.0, 30.0) / Interval(-5.0, -3.0) --> Interval(-10.0, 0.0)
    @fact Interval(-0.0, 30.0) / Interval(3.0, 5.0) --> Interval(0.0, 10.0)
    @fact Interval(-0.0, 30.0) / Interval(-Inf, -3.0) --> Interval(-10.0, 0.0)
    @fact Interval(-0.0, 30.0) / Interval(3.0, Inf) --> Interval(0.0, 10.0)
    @fact Interval(-0.0, 30.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, 30.0) / Interval(-3.0, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, 30.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-0.0, 30.0) / Interval(-3.0, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, 30.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-0.0, 30.0) / Interval(0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 30.0) / Interval(-Inf, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, 30.0) / Interval(-0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 30.0) / Interval(-Inf, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, 30.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-0.0, 30.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-0.0, 30.0) / Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 30.0) / Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 30.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, 0.0) / Interval(-5.0, -3.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) / Interval(3.0, 5.0) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, 0.0) / Interval(-Inf, -3.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) / Interval(3.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, 0.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-Inf, 0.0) / Interval(-3.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-Inf, 0.0) / Interval(-3.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 0.0) / Interval(0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, 0.0) / Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) / Interval(-0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, 0.0) / Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, 0.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, 0.0) / Interval(0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, 0.0) / Interval(-0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, 0.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-Inf, -0.0) / Interval(-5.0, -3.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) / Interval(3.0, 5.0) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) / Interval(-Inf, -3.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) / Interval(3.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-Inf, -0.0) / Interval(-3.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-Inf, -0.0) / Interval(-3.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, -0.0) / Interval(0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) / Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) / Interval(-0.0, 3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) / Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-Inf, -0.0) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-Inf, -0.0) / Interval(0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) / Interval(-0.0, Inf) --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(0.0, Inf) / Interval(-5.0, -3.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, Inf) / Interval(3.0, 5.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) / Interval(-Inf, -3.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, Inf) / Interval(3.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) / Interval(0.0, 0.0) --> ∅
    @fact Interval(0.0, Inf) / Interval(-3.0, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, Inf) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(0.0, Inf) / Interval(-3.0, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, Inf) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(0.0, Inf) / Interval(0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) / Interval(-Inf, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, Inf) / Interval(-0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) / Interval(-Inf, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(0.0, Inf) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(0.0, Inf) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(0.0, Inf) / Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) / Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-0.0, Inf) / Interval(-5.0, -3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, Inf) / Interval(3.0, 5.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) / Interval(-Inf, -3.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, Inf) / Interval(3.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) / Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, Inf) / Interval(-3.0, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, Inf) / Interval(-0.0, -0.0) --> ∅
    @fact Interval(-0.0, Inf) / Interval(-3.0, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, Inf) / Interval(-3.0, 3.0) --> entireinterval(Float64)
    @fact Interval(-0.0, Inf) / Interval(0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) / Interval(-Inf, 0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, Inf) / Interval(-0.0, 3.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) / Interval(-Inf, -0.0) --> Interval(-Inf, 0.0)
    @fact Interval(-0.0, Inf) / Interval(-Inf, 3.0) --> entireinterval(Float64)
    @fact Interval(-0.0, Inf) / Interval(-3.0, Inf) --> entireinterval(Float64)
    @fact Interval(-0.0, Inf) / Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) / Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) / entireinterval(Float64) --> entireinterval(Float64)
    @fact Interval(-2.0, -1.0) / Interval(-10.0, -3.0) --> Interval(0x1.9999999999999p-4, 0x1.5555555555556p-1)
    @fact Interval(-2.0, -1.0) / Interval(0.0, 10.0) --> Interval(-Inf, -0x1.9999999999999p-4)
    @fact Interval(-2.0, -1.0) / Interval(-0.0, 10.0) --> Interval(-Inf, -0x1.9999999999999p-4)
    @fact Interval(-1.0, 2.0) / Interval(10.0, Inf) --> Interval(-0x1.999999999999ap-4, 0x1.999999999999ap-3)
    @fact Interval(1.0, 3.0) / Interval(-Inf, -10.0) --> Interval(-0x1.3333333333334p-2, 0.0)
    @fact Interval(-Inf, -1.0) / Interval(1.0, 3.0) --> Interval(-Inf, -0x1.5555555555555p-2)
end

facts("minimal_div_dec_test") do

end

facts("minimal_recip_test") do
    @fact inv(Interval(-50.0, -10.0)) --> Interval(-0x1.999999999999ap-4, -0x1.47ae147ae147ap-6)
    @fact inv(Interval(10.0, 50.0)) --> Interval(0x1.47ae147ae147ap-6, 0x1.999999999999ap-4)
    @fact inv(Interval(-Inf, -10.0)) --> Interval(-0x1.999999999999ap-4, 0.0)
    @fact inv(Interval(10.0, Inf)) --> Interval(0.0, 0x1.999999999999ap-4)
    @fact inv(Interval(0.0, 0.0)) --> ∅
    @fact inv(Interval(-0.0, -0.0)) --> ∅
    @fact inv(Interval(-10.0, 0.0)) --> Interval(-Inf, -0x1.9999999999999p-4)
    @fact inv(Interval(-10.0, -0.0)) --> Interval(-Inf, -0x1.9999999999999p-4)
    @fact inv(Interval(-10.0, 10.0)) --> entireinterval(Float64)
    @fact inv(Interval(0.0, 10.0)) --> Interval(0x1.9999999999999p-4, Inf)
    @fact inv(Interval(-0.0, 10.0)) --> Interval(0x1.9999999999999p-4, Inf)
    @fact inv(Interval(-Inf, 0.0)) --> Interval(-Inf, 0.0)
    @fact inv(Interval(-Inf, -0.0)) --> Interval(-Inf, 0.0)
    @fact inv(Interval(-Inf, 10.0)) --> entireinterval(Float64)
    @fact inv(Interval(-10.0, Inf)) --> entireinterval(Float64)
    @fact inv(Interval(0.0, Inf)) --> Interval(0.0, Inf)
    @fact inv(Interval(-0.0, Inf)) --> Interval(0.0, Inf)
    @fact inv(entireinterval(Float64)) --> entireinterval(Float64)
end

facts("minimal_recip_dec_test") do

end

facts("minimal_sqr_test") do
    @fact ∅ ^ 2 --> ∅
    @fact entireinterval(Float64) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0x0.0000000000001p-1022) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(-1.0, 1.0) ^ 2 --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ 2 --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ 2 --> Interval(0.0, 1.0)
    @fact Interval(-5.0, 3.0) ^ 2 --> Interval(0.0, 25.0)
    @fact Interval(-5.0, 0.0) ^ 2 --> Interval(0.0, 25.0)
    @fact Interval(-5.0, -0.0) ^ 2 --> Interval(0.0, 25.0)
    @fact Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4) ^ 2 --> Interval(0x1.47ae147ae147bp-7, 0x1.47ae147ae147cp-7)
    @fact Interval(-0x1.ffffffffffffp+0, 0x1.999999999999ap-4) ^ 2 --> Interval(0.0, 0x1.fffffffffffe1p+1)
    @fact Interval(-0x1.ffffffffffffp+0, -0x1.ffffffffffffp+0) ^ 2 --> Interval(0x1.fffffffffffep+1, 0x1.fffffffffffe1p+1)
end

facts("minimal_sqr_dec_test") do

end

facts("minimal_sqrt_test") do
    @fact sqrt(∅) --> ∅
    @fact sqrt(entireinterval(Float64)) --> Interval(0.0, Inf)
    @fact sqrt(Interval(-Inf, -0x0.0000000000001p-1022)) --> ∅
    @fact sqrt(Interval(-1.0, 1.0)) --> Interval(0.0, 1.0)
    @fact sqrt(Interval(0.0, 1.0)) --> Interval(0.0, 1.0)
    @fact sqrt(Interval(-0.0, 1.0)) --> Interval(0.0, 1.0)
    @fact sqrt(Interval(-5.0, 25.0)) --> Interval(0.0, 5.0)
    @fact sqrt(Interval(0.0, 25.0)) --> Interval(0.0, 5.0)
    @fact sqrt(Interval(-0.0, 25.0)) --> Interval(0.0, 5.0)
    @fact sqrt(Interval(-5.0, Inf)) --> Interval(0.0, Inf)
    @fact sqrt(Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4)) --> Interval(0x1.43d136248490fp-2, 0x1.43d136248491p-2)
    @fact sqrt(Interval(-0x1.ffffffffffffp+0, 0x1.999999999999ap-4)) --> Interval(0.0, 0x1.43d136248491p-2)
    @fact sqrt(Interval(0x1.999999999999ap-4, 0x1.ffffffffffffp+0)) --> Interval(0x1.43d136248490fp-2, 0x1.6a09e667f3bc7p+0)
end

facts("minimal_sqrt_dec_test") do

end

facts("minimal_fma_test") do
    @fact fma(∅, ∅, ∅) --> ∅
    @fact fma(Interval(-1.0, 1.0), ∅, ∅) --> ∅
    @fact fma(∅, Interval(-1.0, 1.0), ∅) --> ∅
    @fact fma(∅, entireinterval(Float64), ∅) --> ∅
    @fact fma(entireinterval(Float64), ∅, ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), ∅, ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), ∅, ∅) --> ∅
    @fact fma(∅, Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(∅, Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(entireinterval(Float64), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(entireinterval(Float64), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(1.0, Inf), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(-1.0, Inf), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(-Inf, 3.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(-Inf, -3.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(0.0, 0.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(-0.0, -0.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(1.0, 5.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, -1.0), ∅) --> ∅
    #min max
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-10.0, 2.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(-1.0, 10.0), ∅) --> ∅
    @fact fma(Interval(-2.0, 2.0), Interval(-5.0, 3.0), ∅) --> ∅
    #end min max
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(-1.0, 5.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(0.0, 0.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(-0.0, -0.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, -1.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, 3.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, -1.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, 3.0), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, Inf), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, Inf), ∅) --> ∅
    @fact fma(Interval(-10.0, -5.0), entireinterval(Float64), ∅) --> ∅
    @fact fma(∅, ∅, Interval(-Inf, 2.0)) --> ∅
    @fact fma(Interval(-1.0, 1.0), ∅, Interval(-Inf, 2.0)) --> ∅
    @fact fma(∅, Interval(-1.0, 1.0), Interval(-Inf, 2.0)) --> ∅
    @fact fma(∅, entireinterval(Float64), Interval(-Inf, 2.0)) --> ∅
    @fact fma(entireinterval(Float64), ∅, Interval(-Inf, 2.0)) --> ∅
    @fact fma(Interval(0.0, 0.0), ∅, Interval(-Inf, 2.0)) --> ∅
    @fact fma(Interval(-0.0, -0.0), ∅, Interval(-Inf, 2.0)) --> ∅
    @fact fma(∅, Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> ∅
    @fact fma(∅, Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> ∅
    @fact fma(entireinterval(Float64), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(entireinterval(Float64), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(entireinterval(Float64), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(1.0, Inf), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-1.0, Inf), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 7.0)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-Inf, 3.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 11.0)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-Inf, -3.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, -1.0)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, -1.0)
    @fact fma(Interval(-Inf, -3.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(0.0, 0.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-0.0, -0.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(1.0, 5.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(1.0, 5.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 17.0)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 17.0)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 17.0)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 7.0)
    #min max
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 17.0)
    @fact fma(Interval(-10.0, 2.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 52.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-1.0, 10.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 52.0)
    @fact fma(Interval(-2.0, 2.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 12.0)
    #end min max
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 17.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(0.0, 0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-0.0, -0.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 2.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, -1.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 52.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, 52.0)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, 3.0), Interval(-Inf, 2.0)) --> Interval(-Inf, -3.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, -1.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, 3.0), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, 52.0)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, Inf), Interval(-Inf, 2.0)) --> Interval(-Inf, -3.0)
    @fact fma(Interval(-10.0, -5.0), entireinterval(Float64), Interval(-Inf, 2.0)) --> entireinterval(Float64)
    @fact fma(∅, ∅, Interval(-2.0, 2.0)) --> ∅
    @fact fma(Interval(-1.0, 1.0), ∅, Interval(-2.0, 2.0)) --> ∅
    @fact fma(∅, Interval(-1.0, 1.0), Interval(-2.0, 2.0)) --> ∅
    @fact fma(∅, entireinterval(Float64), Interval(-2.0, 2.0)) --> ∅
    @fact fma(entireinterval(Float64), ∅, Interval(-2.0, 2.0)) --> ∅
    @fact fma(Interval(0.0, 0.0), ∅, Interval(-2.0, 2.0)) --> ∅
    @fact fma(Interval(-0.0, -0.0), ∅, Interval(-2.0, 2.0)) --> ∅
    @fact fma(∅, Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> ∅
    @fact fma(∅, Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> ∅
    @fact fma(entireinterval(Float64), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(entireinterval(Float64), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(entireinterval(Float64), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(1.0, Inf), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, Inf), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-1.0, Inf), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-Inf, 7.0)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-5.0, Inf)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-Inf, 3.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-17.0, Inf)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-Inf, 11.0)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-Inf, -3.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(1.0, Inf)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-Inf, -1.0)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> Interval(1.0, Inf)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> Interval(-Inf, -1.0)
    @fact fma(Interval(-Inf, -3.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(0.0, 0.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-0.0, -0.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(1.0, 5.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(1.0, 5.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-27.0, 1.0)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-27.0, 17.0)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-1.0, 17.0)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> Interval(-Inf, 1.0)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> Interval(-Inf, 17.0)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> Interval(-27.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, 5.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(-27.0, 7.0)
    #min max
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-27.0, 17.0)
    @fact fma(Interval(-10.0, 2.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-32.0, 52.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-1.0, 10.0), Interval(-2.0, 2.0)) --> Interval(-12.0, 52.0)
    @fact fma(Interval(-2.0, 2.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-12.0, 12.0)
    #end min max
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-5.0, 17.0)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(0.0, 0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-0.0, -0.0), Interval(-2.0, 2.0)) --> Interval(-2.0, 2.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, -1.0), Interval(-2.0, 2.0)) --> Interval(3.0, 52.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-32.0, 52.0)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, 3.0), Interval(-2.0, 2.0)) --> Interval(-32.0, -3.0)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, -1.0), Interval(-2.0, 2.0)) --> Interval(3.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, 3.0), Interval(-2.0, 2.0)) --> Interval(-32.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, Inf), Interval(-2.0, 2.0)) --> Interval(-Inf, 52.0)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, Inf), Interval(-2.0, 2.0)) --> Interval(-Inf, -3.0)
    @fact fma(Interval(-10.0, -5.0), entireinterval(Float64), Interval(-2.0, 2.0)) --> entireinterval(Float64)
    @fact fma(∅, ∅, Interval(-2.0, Inf)) --> ∅
    @fact fma(Interval(-1.0, 1.0), ∅, Interval(-2.0, Inf)) --> ∅
    @fact fma(∅, Interval(-1.0, 1.0), Interval(-2.0, Inf)) --> ∅
    @fact fma(∅, entireinterval(Float64), Interval(-2.0, Inf)) --> ∅
    @fact fma(entireinterval(Float64), ∅, Interval(-2.0, Inf)) --> ∅
    @fact fma(Interval(0.0, 0.0), ∅, Interval(-2.0, Inf)) --> ∅
    @fact fma(Interval(-0.0, -0.0), ∅, Interval(-2.0, Inf)) --> ∅
    @fact fma(∅, Interval(0.0, 0.0), Interval(-2.0, Inf)) --> ∅
    @fact fma(∅, Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> ∅
    @fact fma(entireinterval(Float64), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(entireinterval(Float64), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(entireinterval(Float64), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(1.0, Inf), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, Inf), Interval(-2.0, Inf)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, Inf), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-1.0, Inf), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-5.0, Inf)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-Inf, 3.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(-17.0, Inf)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-Inf, -3.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(1.0, Inf)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> Interval(1.0, Inf)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(0.0, 0.0), entireinterval(Float64), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-0.0, -0.0), entireinterval(Float64), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(-27.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-27.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> Interval(-27.0, Inf)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> Interval(-1.0, Inf)
    @fact fma(Interval(1.0, 5.0), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-1.0, 5.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(-27.0, Inf)
    #min max
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-27.0, Inf)
    @fact fma(Interval(-10.0, 2.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-32.0, Inf)
    @fact fma(Interval(-1.0, 5.0), Interval(-1.0, 10.0), Interval(-2.0, Inf)) --> Interval(-12.0, Inf)
    @fact fma(Interval(-2.0, 2.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-12.0, Inf)
    #end min max
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-5.0, Inf)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(0.0, 0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-0.0, -0.0), Interval(-2.0, Inf)) --> Interval(-2.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, -1.0), Interval(-2.0, Inf)) --> Interval(3.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, 3.0), Interval(-2.0, Inf)) --> Interval(-32.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, 3.0), Interval(-2.0, Inf)) --> Interval(-32.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, -1.0), Interval(-2.0, Inf)) --> Interval(3.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, 3.0), Interval(-2.0, Inf)) --> Interval(-32.0, Inf)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, Inf), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), entireinterval(Float64), Interval(-2.0, Inf)) --> entireinterval(Float64)
    @fact fma(∅, ∅, entireinterval(Float64)) --> ∅
    @fact fma(Interval(-1.0, 1.0), ∅, entireinterval(Float64)) --> ∅
    @fact fma(∅, Interval(-1.0, 1.0), entireinterval(Float64)) --> ∅
    @fact fma(∅, entireinterval(Float64), entireinterval(Float64)) --> ∅
    @fact fma(entireinterval(Float64), ∅, entireinterval(Float64)) --> ∅
    @fact fma(Interval(0.0, 0.0), ∅, entireinterval(Float64)) --> ∅
    @fact fma(Interval(-0.0, -0.0), ∅, entireinterval(Float64)) --> ∅
    @fact fma(∅, Interval(0.0, 0.0), entireinterval(Float64)) --> ∅
    @fact fma(∅, Interval(-0.0, -0.0), entireinterval(Float64)) --> ∅
    @fact fma(entireinterval(Float64), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(entireinterval(Float64), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, Inf), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, Inf), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, 3.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-Inf, -3.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.0, 0.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-0.0, -0.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(1.0, 5.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    #min max
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, 2.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-1.0, 10.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-2.0, 2.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    #end min max
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-1.0, 5.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(0.0, 0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-0.0, -0.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-Inf, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(-5.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), Interval(1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(-10.0, -5.0), entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact fma(Interval(0.1, 0.5), Interval(-5.0, 3.0), Interval(-0.1, 0.1)) --> Interval(-0x1.4cccccccccccdp+1, 0x1.999999999999ap+0)
    @fact fma(Interval(-0.5, 0.2), Interval(-5.0, 3.0), Interval(-0.1, 0.1)) --> Interval(-0x1.999999999999ap+0, 0x1.4cccccccccccdp+1)
    @fact fma(Interval(-0.5, -0.1), Interval(2.0, 3.0), Interval(-0.1, 0.1)) --> Interval(-0x1.999999999999ap+0, -0x1.999999999999ap-4)
    @fact fma(Interval(-0.5, -0.1), Interval(-Inf, 3.0), Interval(-0.1, 0.1)) --> Interval(-0x1.999999999999ap+0, Inf)
end

facts("minimal_fma_dec_test") do

end

facts("minimal_pown_test") do
    @fact ∅ ^ 0 --> ∅
    @fact entireinterval(Float64) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(0.0, 0.0) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-0.0, -0.0) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(13.1, 13.1) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-7451.145, -7451.145) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(0.0, Inf) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-0.0, Inf) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-Inf, 0.0) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-Inf, -0.0) ^ 0 --> Interval(1.0, 1.0)
    @fact Interval(-324.3, 2.5) ^ 0 --> Interval(1.0, 1.0)
    @fact ∅ ^ 2 --> ∅
    @fact entireinterval(Float64) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.0) ^ 2 --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ 2 --> Interval(0.0, 0.0)
    @fact Interval(13.1, 13.1) ^ 2 --> Interval(0x1.573851eb851ebp+7, 0x1.573851eb851ecp+7)
    @fact Interval(-7451.145, -7451.145) ^ 2 --> Interval(0x1.a794a4e7cfaadp+25, 0x1.a794a4e7cfaaep+25)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ 2 --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ 2 --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact Interval(0.0, Inf) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) ^ 2 --> Interval(0.0, Inf)
    @fact Interval(-324.3, 2.5) ^ 2 --> Interval(0.0, 0x1.9ad27d70a3d72p+16)
    @fact Interval(0.01, 2.33) ^ 2 --> Interval(0x1.a36e2eb1c432cp-14, 0x1.5b7318fc50482p+2)
    @fact Interval(-1.9, -0.33) ^ 2 --> Interval(0x1.be0ded288ce7p-4, 0x1.ce147ae147ae1p+1)
    @fact ∅ ^ 8 --> ∅
    @fact entireinterval(Float64) ^ 8 --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.0) ^ 8 --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ 8 --> Interval(0.0, 0.0)
    @fact Interval(13.1, 13.1) ^ 8 --> Interval(0x1.9d8fd495853f5p+29, 0x1.9d8fd495853f6p+29)
    @fact Interval(-7451.145, -7451.145) ^ 8 --> Interval(0x1.dfb1bb622e70dp+102, 0x1.dfb1bb622e70ep+102)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ 8 --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ 8 --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact Interval(0.0, Inf) ^ 8 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ 8 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ 8 --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) ^ 8 --> Interval(0.0, Inf)
    @fact Interval(-324.3, 2.5) ^ 8 --> Interval(0.0, 0x1.a87587109655p+66)
    @fact Interval(0.01, 2.33) ^ 8 --> Interval(0x1.cd2b297d889bdp-54, 0x1.b253d9f33ce4dp+9)
    @fact Interval(-1.9, -0.33) ^ 8 --> Interval(0x1.26f1fcdd502a3p-13, 0x1.53abd7bfc4fc6p+7)
    @fact ∅ ^ 1 --> ∅
    @fact entireinterval(Float64) ^ 1 --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) ^ 1 --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ 1 --> Interval(0.0, 0.0)
    @fact Interval(13.1, 13.1) ^ 1 --> Interval(13.1, 13.1)
    @fact Interval(-7451.145, -7451.145) ^ 1 --> Interval(-7451.145, -7451.145)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ 1 --> Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ 1 --> Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023)
    @fact Interval(0.0, Inf) ^ 1 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ 1 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ 1 --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) ^ 1 --> Interval(-Inf, 0.0)
    @fact Interval(-324.3, 2.5) ^ 1 --> Interval(-324.3, 2.5)
    @fact Interval(0.01, 2.33) ^ 1 --> Interval(0.01, 2.33)
    @fact Interval(-1.9, -0.33) ^ 1 --> Interval(-1.9, -0.33)
    @fact ∅ ^ 3 --> ∅
    @fact entireinterval(Float64) ^ 3 --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) ^ 3 --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ 3 --> Interval(0.0, 0.0)
    @fact Interval(13.1, 13.1) ^ 3 --> Interval(0x1.1902e978d4fdep+11, 0x1.1902e978d4fdfp+11)
    @fact Interval(-7451.145, -7451.145) ^ 3 --> Interval(-0x1.81460637b9a3dp+38, -0x1.81460637b9a3cp+38)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ 3 --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ 3 --> Interval(-Inf, -0x1.fffffffffffffp1023)
    @fact Interval(0.0, Inf) ^ 3 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ 3 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ 3 --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) ^ 3 --> Interval(-Inf, 0.0)
    @fact Interval(-324.3, 2.5) ^ 3 --> Interval(-0x1.0436d2f418938p+25, 0x1.f4p+3)
    @fact Interval(0.01, 2.33) ^ 3 --> Interval(0x1.0c6f7a0b5ed8dp-20, 0x1.94c75e6362a6p+3)
    @fact Interval(-1.9, -0.33) ^ 3 --> Interval(-0x1.b6f9db22d0e55p+2, -0x1.266559f6ec5b1p-5)
    @fact ∅ ^ 7 --> ∅
    @fact entireinterval(Float64) ^ 7 --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) ^ 7 --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ 7 --> Interval(0.0, 0.0)
    @fact Interval(13.1, 13.1) ^ 7 --> Interval(0x1.f91d1b185493bp+25, 0x1.f91d1b185493cp+25)
    @fact Interval(-7451.145, -7451.145) ^ 7 --> Interval(-0x1.07b1da32f9b59p+90, -0x1.07b1da32f9b58p+90)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ 7 --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ 7 --> Interval(-Inf, -0x1.fffffffffffffp1023)
    @fact Interval(0.0, Inf) ^ 7 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ 7 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ 7 --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) ^ 7 --> Interval(-Inf, 0.0)
    @fact Interval(-324.3, 2.5) ^ 7 --> Interval(-0x1.4f109959e6d7fp+58, 0x1.312dp+9)
    @fact Interval(0.01, 2.33) ^ 7 --> Interval(0x1.6849b86a12b9bp-47, 0x1.74d0373c76313p+8)
    @fact Interval(-1.9, -0.33) ^ 7 --> Interval(-0x1.658c775099757p+6, -0x1.bee30301bf47ap-12)
    @fact ∅ ^ -2 --> ∅
    @fact entireinterval(Float64) ^ -2 --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.0) ^ -2 --> ∅
    @fact Interval(-0.0, -0.0) ^ -2 --> ∅
    @fact Interval(13.1, 13.1) ^ -2 --> Interval(0x1.7de3a077d1568p-8, 0x1.7de3a077d1569p-8)
    @fact Interval(-7451.145, -7451.145) ^ -2 --> Interval(0x1.3570290cd6e14p-26, 0x1.3570290cd6e15p-26)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ -2 --> Interval(0x0p+0, 0x0.0000000000001p-1022)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ -2 --> Interval(0x0p+0, 0x0.0000000000001p-1022)
    @fact Interval(0.0, Inf) ^ -2 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ -2 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ -2 --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) ^ -2 --> Interval(0.0, Inf)
    @fact Interval(-324.3, 2.5) ^ -2 --> Interval(0x1.3f0c482c977c9p-17, Inf)
    @fact Interval(0.01, 2.33) ^ -2 --> Interval(0x1.793d85ef38e47p-3, 0x1.388p+13)
    @fact Interval(-1.9, -0.33) ^ -2 --> Interval(0x1.1ba81104f6c8p-2, 0x1.25d8fa1f801e1p+3)
    @fact ∅ ^ -8 --> ∅
    @fact entireinterval(Float64) ^ -8 --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.0) ^ -8 --> ∅
    @fact Interval(-0.0, -0.0) ^ -8 --> ∅
    @fact Interval(13.1, 13.1) ^ -8 --> Interval(0x1.3cef39247ca6dp-30, 0x1.3cef39247ca6ep-30)
    @fact Interval(-7451.145, -7451.145) ^ -8 --> Interval(0x1.113d9ef0a99acp-103, 0x1.113d9ef0a99adp-103)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ -8 --> Interval(0x0p+0, 0x0.0000000000001p-1022)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ -8 --> Interval(0x0p+0, 0x0.0000000000001p-1022)
    @fact Interval(0.0, Inf) ^ -8 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ -8 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ -8 --> Interval(0.0, Inf)
    @fact Interval(-Inf, -0.0) ^ -8 --> Interval(0.0, Inf)
    @fact Interval(-324.3, 2.5) ^ -8 --> Interval(0x1.34cc3764d1e0cp-67, Inf)
    @fact Interval(0.01, 2.33) ^ -8 --> Interval(0x1.2dc80db11ab7cp-10, 0x1.1c37937e08p+53)
    @fact Interval(-1.9, -0.33) ^ -8 --> Interval(0x1.81e104e61630dp-8, 0x1.bc64f21560e34p+12)
    @fact ∅ ^ -1 --> ∅
    @fact entireinterval(Float64) ^ -1 --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) ^ -1 --> ∅
    @fact Interval(-0.0, -0.0) ^ -1 --> ∅
    @fact Interval(13.1, 13.1) ^ -1 --> Interval(0x1.38abf82ee6986p-4, 0x1.38abf82ee6987p-4)
    @fact Interval(-7451.145, -7451.145) ^ -1 --> Interval(-0x1.197422c9048bfp-13, -0x1.197422c9048bep-13)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ -1 --> Interval(0x0.4p-1022, 0x0.4000000000001p-1022)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ -1 --> Interval(-0x0.4000000000001p-1022, -0x0.4p-1022)
    @fact Interval(0.0, Inf) ^ -1 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ -1 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ -1 --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) ^ -1 --> Interval(-Inf, 0.0)
    @fact Interval(-324.3, 2.5) ^ -1 --> entireinterval(Float64)
    @fact Interval(0.01, 2.33) ^ -1 --> Interval(0x1.b77c278dbbe13p-2, 0x1.9p+6)
    @fact Interval(-1.9, -0.33) ^ -1 --> Interval(-0x1.83e0f83e0f83ep+1, -0x1.0d79435e50d79p-1)
    @fact ∅ ^ -3 --> ∅
    @fact entireinterval(Float64) ^ -3 --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) ^ -3 --> ∅
    @fact Interval(-0.0, -0.0) ^ -3 --> ∅
    @fact Interval(13.1, 13.1) ^ -3 --> Interval(0x1.d26df4d8b1831p-12, 0x1.d26df4d8b1832p-12)
    @fact Interval(-7451.145, -7451.145) ^ -3 --> Interval(-0x1.54347ded91b19p-39, -0x1.54347ded91b18p-39)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ -3 --> Interval(0x0p+0, 0x0.0000000000001p-1022)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ -3 --> Interval(-0x0.0000000000001p-1022, -0x0p+0)
    @fact Interval(0.0, Inf) ^ -3 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ -3 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ -3 --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) ^ -3 --> Interval(-Inf, 0.0)
    @fact Interval(-324.3, 2.5) ^ -3 --> entireinterval(Float64)
    @fact Interval(0.01, 2.33) ^ -3 --> Interval(0x1.43cfba61aacabp-4, 0x1.e848p+19)
    @fact Interval(-1.9, -0.33) ^ -3 --> Interval(-0x1.bd393ce9e8e7cp+4, -0x1.2a95f6f7c066cp-3)
    @fact ∅ ^ -7 --> ∅
    @fact entireinterval(Float64) ^ -7 --> entireinterval(Float64)
    @fact Interval(0.0, 0.0) ^ -7 --> ∅
    @fact Interval(-0.0, -0.0) ^ -7 --> ∅
    @fact Interval(13.1, 13.1) ^ -7 --> Interval(0x1.037d76c912dbcp-26, 0x1.037d76c912dbdp-26)
    @fact Interval(-7451.145, -7451.145) ^ -7 --> Interval(-0x1.f10f41fb8858fp-91, -0x1.f10f41fb8858ep-91)
    @fact Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023) ^ -7 --> Interval(0x0p+0, 0x0.0000000000001p-1022)
    @fact Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023) ^ -7 --> Interval(-0x0.0000000000001p-1022, -0x0p+0)
    @fact Interval(0.0, Inf) ^ -7 --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ -7 --> Interval(0.0, Inf)
    @fact Interval(-Inf, 0.0) ^ -7 --> Interval(-Inf, 0.0)
    @fact Interval(-Inf, -0.0) ^ -7 --> Interval(-Inf, 0.0)
    @fact Interval(-324.3, 2.5) ^ -7 --> entireinterval(Float64)
    @fact Interval(0.01, 2.33) ^ -7 --> Interval(0x1.5f934d64162a9p-9, 0x1.6bcc41e9p+46)
    @fact Interval(-1.9, -0.33) ^ -7 --> Interval(-0x1.254cdd3711ddbp+11, -0x1.6e95c4a761e19p-7)
end

facts("minimal_pown_dec_test") do

end

if VERSION < v"0.5-dev"
facts("minimal_pow_test") do
    @fact ∅ ^ ∅ --> ∅
    @fact ∅ ^ entireinterval(Float64) --> ∅
    @fact ∅ ^ Interval(-Inf, -1.0) --> ∅
    @fact ∅ ^ Interval(-Inf, 0.0) --> ∅
    @fact ∅ ^ Interval(-Inf, -0.0) --> ∅
    @fact ∅ ^ Interval(0.0, Inf) --> ∅
    @fact ∅ ^ Interval(-0.0, Inf) --> ∅
    @fact ∅ ^ Interval(1.0, Inf) --> ∅
    @fact ∅ ^ Interval(-3.0, 5.0) --> ∅
    @fact ∅ ^ Interval(0.0, 0.0) --> ∅
    @fact ∅ ^ Interval(-0.0, -0.0) --> ∅
    @fact ∅ ^ Interval(-5.0, -5.0) --> ∅
    @fact ∅ ^ Interval(5.0, 5.0) --> ∅
    @fact Interval(0.1, 0.5) ^ ∅ --> ∅
    @fact Interval(0.1, 0.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(0.0, 1.0) --> Interval(0x1.999999999999ap-4, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.0, 1.0) --> Interval(0x1.999999999999ap-4, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(0.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 0.5) ^ Interval(0.1, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.ddb680117ab13p-1)
    @fact Interval(0.1, 0.5) ^ Interval(0.1, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.ddb680117ab13p-1)
    @fact Interval(0.1, 0.5) ^ Interval(0.1, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.ddb680117ab13p-1)
    @fact Interval(0.1, 0.5) ^ Interval(0.1, Inf) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(0.1, 0.5) ^ Interval(1.0, 1.0) --> Interval(0x1.999999999999ap-4, 0x1p-1)
    @fact Interval(0.1, 0.5) ^ Interval(1.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1p-1)
    @fact Interval(0.1, 0.5) ^ Interval(1.0, Inf) --> Interval(0.0, 0x1p-1)
    @fact Interval(0.1, 0.5) ^ Interval(2.5, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.6a09e667f3bcdp-3)
    @fact Interval(0.1, 0.5) ^ Interval(2.5, Inf) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(0.1, 0.5) ^ Interval(-0.1, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.1, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.1, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 0.5) ^ Interval(-0.1, Inf) --> Interval(0.0, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, Inf) --> Interval(0.0, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, Inf) --> Interval(0.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, 0.1) --> Interval(0x1.96b230bcdc434p-1, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, 1.0) --> Interval(0x1.999999999999ap-4, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, Inf)
    @fact Interval(0.1, 0.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, 0.0) --> Interval(1.0, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, -0.0) --> Interval(1.0, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, 0.0) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, -0.0) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.125fbee250664p+0, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.125fbee250664p+0, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.125fbee250664p+0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-1.0, -1.0) --> Interval(0x1p+1, 0x1.4p+3)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, -1.0) --> Interval(0x1p+1, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(0.1, 0.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.6a09e667f3bccp+2, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 0.5) ^ Interval(-Inf, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(0.1, 1.0) ^ ∅ --> ∅
    @fact Interval(0.1, 1.0) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.0, 1.0) --> Interval(0x1.999999999999ap-4, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.0, 1.0) --> Interval(0x1.999999999999ap-4, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.1, 0.1) --> Interval(0x1.96b230bcdc434p-1, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.1, 1.0) --> Interval(0x1.999999999999ap-4, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.1, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(0.1, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(1.0, 1.0) --> Interval(0x1.999999999999ap-4, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(1.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(1.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(2.5, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(2.5, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, 0.1) --> Interval(0x1.96b230bcdc434p-1, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, 1.0) --> Interval(0x1.999999999999ap-4, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, 0.1) --> Interval(0x1.96b230bcdc434p-1, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, 1.0) --> Interval(0x1.999999999999ap-4, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, 2.5) --> Interval(0x1.9e7c6e43390b7p-9, Inf)
    @fact Interval(0.1, 1.0) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, 0.0) --> Interval(1.0, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, -0.0) --> Interval(1.0, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, 0.0) --> Interval(1.0, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, -0.0) --> Interval(1.0, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, 0.0) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, -0.0) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-0.1, -0.1) --> Interval(1.0, 0x1.4248ef8fc2604p+0)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, -0.1) --> Interval(1.0, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, -0.1) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, -0.1) --> Interval(1.0, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-1.0, -1.0) --> Interval(1.0, 0x1.4p+3)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, -1.0) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, -1.0) --> Interval(1.0, Inf)
    @fact Interval(0.1, 1.0) ^ Interval(-2.5, -2.5) --> Interval(1.0, 0x1.3c3a4edfa9758p+8)
    @fact Interval(0.1, 1.0) ^ Interval(-Inf, -2.5) --> Interval(1.0, Inf)
    @fact Interval(0.5, 1.5) ^ ∅ --> ∅
    @fact Interval(0.5, 1.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.5, 1.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.5, 1.5) ^ Interval(0.0, 1.0) --> Interval(0.5, 1.5)
    @fact Interval(0.5, 1.5) ^ Interval(-0.0, 1.0) --> Interval(0.5, 1.5)
    @fact Interval(0.5, 1.5) ^ Interval(0.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-0.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(0.1, 0.1) --> Interval(0x1.ddb680117ab12p-1, 0x1.0a97dce72a0cbp+0)
    @fact Interval(0.5, 1.5) ^ Interval(0.1, 1.0) --> Interval(0.5, 1.5)
    @fact Interval(0.5, 1.5) ^ Interval(0.1, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(1.0, 1.0) --> Interval(0.5, 1.5)
    @fact Interval(0.5, 1.5) ^ Interval(1.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(2.5, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-0.1, 0.1) --> Interval(0x1.ddb680117ab12p-1, 0x1.125fbee250665p+0)
    @fact Interval(0.5, 1.5) ^ Interval(-0.1, 1.0) --> Interval(0x1p-1, 0x1.8p+0)
    @fact Interval(0.5, 1.5) ^ Interval(-0.1, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-0.1, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, 0.1) --> Interval(0x1.5555555555555p-1, 0x1p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, 1.0) --> Interval(0x1p-1, 0x1p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, 0.1) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, 1.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, 2.5) --> Interval(0x1.6a09e667f3bccp-3, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ entireinterval(Float64) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, 0.0) --> Interval(0x1.5555555555555p-1, 0x1p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, -0.0) --> Interval(0x1.5555555555555p-1, 0x1p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, 0.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, -0.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, 0.0) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, -0.0) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.125fbee250665p+0)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.5555555555555p-1, 0x1p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, -0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-1.0, -1.0) --> Interval(0x1.5555555555555p-1, 0x1p+1)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, -1.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, -1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, 1.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, 1.5) ^ Interval(-Inf, -2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(0.5, Inf) ^ ∅ --> ∅
    @fact Interval(0.5, Inf) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.5, Inf) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.5, Inf) ^ Interval(0.0, 1.0) --> Interval(0.5, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.0, 1.0) --> Interval(0.5, Inf)
    @fact Interval(0.5, Inf) ^ Interval(0.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, Inf)
    @fact Interval(0.5, Inf) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(0.1, 0.1) --> Interval(0x1.ddb680117ab12p-1, Inf)
    @fact Interval(0.5, Inf) ^ Interval(0.1, 1.0) --> Interval(0.5, Inf)
    @fact Interval(0.5, Inf) ^ Interval(0.1, 2.5) --> Interval(0x1.6a09e667f3bccp-3, Inf)
    @fact Interval(0.5, Inf) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(1.0, 1.0) --> Interval(0.5, Inf)
    @fact Interval(0.5, Inf) ^ Interval(1.0, 2.5) --> Interval(0x1.6a09e667f3bccp-3, Inf)
    @fact Interval(0.5, Inf) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(2.5, 2.5) --> Interval(0x1.6a09e667f3bccp-3, Inf)
    @fact Interval(0.5, Inf) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, 0.0) --> Interval(0.0, 0x1p+1)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, -0.0) --> Interval(0.0, 0x1p+1)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, 0.0) --> Interval(0.0, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, -0.0) --> Interval(0.0, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-0.1, -0.1) --> Interval(0.0, 0x1.125fbee250665p+0)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, -0.1) --> Interval(0.0, 0x1p+1)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, -0.1) --> Interval(0.0, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-1.0, -1.0) --> Interval(0.0, 0x1p+1)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, -1.0) --> Interval(0.0, 0x1.6a09e667f3bcdp+2)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(0.5, Inf) ^ Interval(-2.5, -2.5) --> Interval(0.0, 0x1.6a09e667f3bcdp+2)
    @fact Interval(1.0, 1.5) ^ ∅ --> ∅
    @fact Interval(1.0, 1.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(0.0, 1.0) --> Interval(1.0, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(-0.0, 1.0) --> Interval(1.0, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(0.0, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(-0.0, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(-0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(0.1, 0.1) --> Interval(1.0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.0, 1.5) ^ Interval(0.1, 1.0) --> Interval(1.0, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(0.1, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(0.1, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(1.0, 1.0) --> Interval(1.0, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(1.0, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(1.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(2.5, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(2.5, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(-0.1, 0.1) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.0, 1.5) ^ Interval(-0.1, 1.0) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(-0.1, 2.5) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(-0.1, Inf) --> Interval(0x1.eba7c9e4d31e9p-1, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, 0.1) --> Interval(0x1.5555555555555p-1, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, 1.0) --> Interval(0x1.5555555555555p-1, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, 2.5) --> Interval(0x1.5555555555555p-1, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, Inf) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, 0.1) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, 1.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, 2.5) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, Inf) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, 0.1) --> Interval(0x0p+0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, 1.0) --> Interval(0x0p+0, 0x1.8p+0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, 2.5) --> Interval(0x0p+0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.0, 1.5) ^ entireinterval(Float64) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, 0.0) --> Interval(0x1.5555555555555p-1, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, -0.0) --> Interval(0x1.5555555555555p-1, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, 0.0) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, -0.0) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.eba7c9e4d31e9p-1, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.5555555555555p-1, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, -0.1) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-1.0, -1.0) --> Interval(0x1.5555555555555p-1, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, -1.0) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, -1.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.0, 1.5) ^ Interval(-Inf, -2.5) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ ∅ --> ∅
    @fact Interval(1.0, Inf) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(0.0, 1.0) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.0, 1.0) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(0.0, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.0, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(0.1, 0.1) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(0.1, 1.0) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(0.1, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(0.1, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(1.0, 1.0) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(1.0, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(1.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(2.5, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(2.5, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.1, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.1, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.1, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-0.1, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ entireinterval(Float64) --> Interval(0x0p+0, Inf)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-0.1, -0.1) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, -0.1) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, -0.1) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, -0.1) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-1.0, -1.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, -1.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, -1.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-2.5, -2.5) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.0, Inf) ^ Interval(-Inf, -2.5) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, 1.5) ^ ∅ --> ∅
    @fact Interval(1.1, 1.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(0.0, 1.0) --> Interval(1.0, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(-0.0, 1.0) --> Interval(1.0, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(0.0, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(-0.0, 2.5) --> Interval(1.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(-0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(0.1, 0.1) --> Interval(0x1.02739c65d58bfp+0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.1, 1.5) ^ Interval(0.1, 1.0) --> Interval(0x1.02739c65d58bfp+0, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(0.1, 2.5) --> Interval(0x1.02739c65d58bfp+0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(0.1, Inf) --> Interval(0x1.02739c65d58bfp+0, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(1.0, 1.0) --> Interval(0x1.199999999999ap+0, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(1.0, 2.5) --> Interval(0x1.199999999999ap+0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(1.0, Inf) --> Interval(0x1.199999999999ap+0, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(2.5, 2.5) --> Interval(0x1.44e1080833b25p+0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(2.5, Inf) --> Interval(0x1.44e1080833b25p+0, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(-0.1, 0.1) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.1, 1.5) ^ Interval(-0.1, 1.0) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(-0.1, 2.5) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(-0.1, Inf) --> Interval(0x1.eba7c9e4d31e9p-1, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, 0.1) --> Interval(0x1.5555555555555p-1, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, 1.0) --> Interval(0x1.5555555555555p-1, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, 2.5) --> Interval(0x1.5555555555555p-1, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, Inf) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, 0.1) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, 1.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, 2.5) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, Inf) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, 0.1) --> Interval(0x0p+0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, 1.0) --> Interval(0x0p+0, 0x1.8p+0)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, 2.5) --> Interval(0x0p+0, 0x1.60b9fd68a4555p+1)
    @fact Interval(1.1, 1.5) ^ entireinterval(Float64) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, 0.0) --> Interval(0x1.5555555555555p-1, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, -0.0) --> Interval(0x1.5555555555555p-1, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, 0.0) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, -0.0) --> Interval(0x1.7398bf1d1ee6fp-2, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, 1.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.eba7c9e4d31e9p-1, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.5555555555555p-1, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, -0.1) --> Interval(0x0p+0, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-1.0, -1.0) --> Interval(0x1.5555555555555p-1, 0x1.d1745d1745d17p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, -1.0) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.d1745d1745d17p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, -1.0) --> Interval(0x0p+0, 0x1.d1745d1745d17p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.7398bf1d1ee6fp-2, 0x1.9372d999784c8p-1)
    @fact Interval(1.1, 1.5) ^ Interval(-Inf, -2.5) --> Interval(0x0p+0, 0x1.9372d999784c8p-1)
    @fact Interval(1.1, Inf) ^ ∅ --> ∅
    @fact Interval(1.1, Inf) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(0.0, 1.0) --> Interval(1.0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.0, 1.0) --> Interval(1.0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(0.0, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.0, 2.5) --> Interval(1.0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.0, Inf) --> Interval(1.0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(0.1, 0.1) --> Interval(0x1.02739c65d58bfp+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(0.1, 1.0) --> Interval(0x1.02739c65d58bfp+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(0.1, 2.5) --> Interval(0x1.02739c65d58bfp+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(0.1, Inf) --> Interval(0x1.02739c65d58bfp+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(1.0, 1.0) --> Interval(0x1.199999999999ap+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(1.0, 2.5) --> Interval(0x1.199999999999ap+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(1.0, Inf) --> Interval(0x1.199999999999ap+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(2.5, 2.5) --> Interval(0x1.44e1080833b25p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(2.5, Inf) --> Interval(0x1.44e1080833b25p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.1, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.1, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.1, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-0.1, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, Inf) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, 0.1) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, 1.0) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, 2.5) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ entireinterval(Float64) --> Interval(0x0p+0, Inf)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, 0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, -0.0) --> Interval(0x0p+0, 1.0)
    @fact Interval(1.1, Inf) ^ Interval(-0.1, -0.1) --> Interval(0x0p+0, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, -0.1) --> Interval(0x0p+0, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, -0.1) --> Interval(0x0p+0, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, -0.1) --> Interval(0x0p+0, 0x1.fb24af5281928p-1)
    @fact Interval(1.1, Inf) ^ Interval(-1.0, -1.0) --> Interval(0x0p+0, 0x1.d1745d1745d17p-1)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, -1.0) --> Interval(0x0p+0, 0x1.d1745d1745d17p-1)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, -1.0) --> Interval(0x0p+0, 0x1.d1745d1745d17p-1)
    @fact Interval(1.1, Inf) ^ Interval(-2.5, -2.5) --> Interval(0x0p+0, 0x1.9372d999784c8p-1)
    @fact Interval(1.1, Inf) ^ Interval(-Inf, -2.5) --> Interval(0x0p+0, 0x1.9372d999784c8p-1)
    @fact Interval(0.0, 0.5) ^ ∅ --> ∅
    @fact Interval(0.0, 0.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(-0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 0.5) ^ Interval(0.1, 0.1) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(0.0, 0.5) ^ Interval(0.1, 1.0) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(0.0, 0.5) ^ Interval(0.1, 2.5) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(0.0, 0.5) ^ Interval(0.1, Inf) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(0.0, 0.5) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.5)
    @fact Interval(0.0, 0.5) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.5)
    @fact Interval(0.0, 0.5) ^ Interval(1.0, Inf) --> Interval(0.0, 0.5)
    @fact Interval(0.0, 0.5) ^ Interval(2.5, 2.5) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(0.0, 0.5) ^ Interval(2.5, Inf) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(0.0, 0.5) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-1.0, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(0.0, 0.5) ^ Interval(-Inf, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(0.0, 1.0) ^ ∅ --> ∅
    @fact Interval(0.0, 1.0) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(0.1, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(1.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(2.5, Inf) --> Interval(0.0, 1.0)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-0.1, -0.1) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, -0.1) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, -0.1) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, -0.1) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-1.0, -1.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, -1.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, -1.0) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-2.5, -2.5) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.0) ^ Interval(-Inf, -2.5) --> Interval(1.0, Inf)
    @fact Interval(0.0, 1.5) ^ ∅ --> ∅
    @fact Interval(0.0, 1.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, 1.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, 1.5) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(0.0, 1.5) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(0.0, 1.5) ^ Interval(0.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.0, 1.5) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.0, 1.5) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(0.1, 0.1) --> Interval(0.0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(0.0, 1.5) ^ Interval(0.1, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(0.0, 1.5) ^ Interval(0.1, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.0, 1.5) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(1.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(0.0, 1.5) ^ Interval(1.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.0, 1.5) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(2.5, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(0.0, 1.5) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, 0.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, -0.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, 0.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, -0.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.eba7c9e4d31e9p-1, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-1.0, -1.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, -1.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(0.0, 1.5) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ ∅ --> ∅
    @fact Interval(0.0, Inf) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, Inf) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(0.0, Inf) ^ Interval(0.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(0.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, 0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, -0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-0.1, -0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, -0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, -0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-1.0, -1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, -1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, Inf) ^ Interval(-2.5, -2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ ∅ --> ∅
    @fact Interval(-0.0, 0.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 0.5) ^ Interval(0.1, 0.1) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.0, 0.5) ^ Interval(0.1, 1.0) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.0, 0.5) ^ Interval(0.1, 2.5) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.0, 0.5) ^ Interval(0.1, Inf) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.0, 0.5) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.5)
    @fact Interval(-0.0, 0.5) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.5)
    @fact Interval(-0.0, 0.5) ^ Interval(1.0, Inf) --> Interval(0.0, 0.5)
    @fact Interval(-0.0, 0.5) ^ Interval(2.5, 2.5) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(-0.0, 0.5) ^ Interval(2.5, Inf) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-1.0, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(-0.0, 0.5) ^ Interval(-Inf, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(-0.0, 1.0) ^ ∅ --> ∅
    @fact Interval(-0.0, 1.0) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(0.1, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(1.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(2.5, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-0.1, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-1.0, -1.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, -1.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, -1.0) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-2.5, -2.5) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.0) ^ Interval(-Inf, -2.5) --> Interval(1.0, Inf)
    @fact Interval(-0.0, 1.5) ^ ∅ --> ∅
    @fact Interval(-0.0, 1.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, 1.5) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.0, 1.5) ^ Interval(0.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.0, 1.5) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(0.1, 0.1) --> Interval(0.0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(-0.0, 1.5) ^ Interval(0.1, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.0, 1.5) ^ Interval(0.1, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.0, 1.5) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(1.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.0, 1.5) ^ Interval(1.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.0, 1.5) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(2.5, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.0, 1.5) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, 0.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, -0.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, 0.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, -0.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.eba7c9e4d31e9p-1, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-1.0, -1.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, -1.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.0, 1.5) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ ∅ --> ∅
    @fact Interval(-0.0, Inf) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, Inf) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.0, Inf) ^ Interval(0.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(0.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-0.1, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-1.0, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.0, Inf) ^ Interval(-2.5, -2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ ∅ --> ∅
    @fact Interval(-0.1, 0.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 0.5) ^ Interval(0.1, 0.1) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.1, 0.5) ^ Interval(0.1, 1.0) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.1, 0.5) ^ Interval(0.1, 2.5) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.1, 0.5) ^ Interval(0.1, Inf) --> Interval(0.0, 0x1.ddb680117ab13p-1)
    @fact Interval(-0.1, 0.5) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.5)
    @fact Interval(-0.1, 0.5) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.5)
    @fact Interval(-0.1, 0.5) ^ Interval(1.0, Inf) --> Interval(0.0, 0.5)
    @fact Interval(-0.1, 0.5) ^ Interval(2.5, 2.5) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(-0.1, 0.5) ^ Interval(2.5, Inf) --> Interval(0.0, 0x1.6a09e667f3bcdp-3)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, -0.1) --> Interval(0x1.125fbee250664p+0, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-1.0, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, -1.0) --> Interval(0x1p+1, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(-0.1, 0.5) ^ Interval(-Inf, -2.5) --> Interval(0x1.6a09e667f3bccp+2, Inf)
    @fact Interval(-0.1, 1.0) ^ ∅ --> ∅
    @fact Interval(-0.1, 1.0) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(0.1, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(1.0, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(2.5, Inf) --> Interval(0.0, 1.0)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, 0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, -0.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-0.1, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, -0.1) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-1.0, -1.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, -1.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, -1.0) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-2.5, -2.5) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.0) ^ Interval(-Inf, -2.5) --> Interval(1.0, Inf)
    @fact Interval(-0.1, 1.5) ^ ∅ --> ∅
    @fact Interval(-0.1, 1.5) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, 1.5) ^ Interval(0.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.1, 1.5) ^ Interval(0.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.1, 1.5) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(0.1, 0.1) --> Interval(0.0, 0x1.0a97dce72a0cbp+0)
    @fact Interval(-0.1, 1.5) ^ Interval(0.1, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.1, 1.5) ^ Interval(0.1, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.1, 1.5) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(1.0, 1.0) --> Interval(0.0, 1.5)
    @fact Interval(-0.1, 1.5) ^ Interval(1.0, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.1, 1.5) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(2.5, 2.5) --> Interval(0.0, 0x1.60b9fd68a4555p+1)
    @fact Interval(-0.1, 1.5) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, 0.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, -0.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, 0.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, -0.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-0.1, -0.1) --> Interval(0x1.eba7c9e4d31e9p-1, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, -0.1) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, -0.1) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-1.0, -1.0) --> Interval(0x1.5555555555555p-1, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, -1.0) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-2.5, -2.5) --> Interval(0x1.7398bf1d1ee6fp-2, Inf)
    @fact Interval(-0.1, 1.5) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ ∅ --> ∅
    @fact Interval(-0.1, Inf) ^ Interval(0.0, 0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, Inf) ^ Interval(-0.0, -0.0) --> Interval(1.0, 1.0)
    @fact Interval(-0.1, Inf) ^ Interval(0.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(0.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.1, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.1, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.1, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.1, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, Inf) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, 0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, 1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, 2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ entireinterval(Float64) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, 0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, -0.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-0.1, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, -0.1) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-1.0, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, -1.0) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-Inf, -2.5) --> Interval(0.0, Inf)
    @fact Interval(-0.1, Inf) ^ Interval(-2.5, -2.5) --> Interval(0.0, Inf)
    @fact Interval(0.0, 0.0) ^ ∅ --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(0.0, 0.0) ^ Interval(-2.5, -2.5) --> ∅
    @fact Interval(-0.0, -0.0) ^ ∅ --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(-0.0, -0.0) ^ Interval(-2.5, -2.5) --> ∅
    @fact Interval(-0.0, 0.0) ^ ∅ --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(-0.0, 0.0) ^ Interval(-2.5, -2.5) --> ∅
    @fact Interval(0.0, -0.0) ^ ∅ --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(0.0, -0.0) ^ Interval(-2.5, -2.5) --> ∅
    @fact Interval(-1.0, 0.0) ^ ∅ --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(-1.0, 0.0) ^ Interval(-2.5, -2.5) --> ∅
    @fact Interval(-1.0, -0.0) ^ ∅ --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.1, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.1, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.1, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-0.1, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, Inf) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, 0.1) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, 1.0) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, 2.5) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ entireinterval(Float64) --> Interval(0.0, 0.0)
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(-1.0, -0.0) ^ Interval(-2.5, -2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ ∅ --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.0, 0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.0, -0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.0, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.0, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.0, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.0, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.0, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.0, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.1, 0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.1, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.1, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(0.1, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(1.0, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(1.0, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(1.0, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(2.5, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(2.5, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.1, 0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.1, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.1, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.1, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, 0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, 0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, Inf) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, 0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, 1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, 2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ entireinterval(Float64) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, 0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, -0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, 0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, -0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, 0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, -0.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-0.1, -0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, -0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, -0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, -0.1) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-1.0, -1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, -1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, -1.0) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-Inf, -2.5) --> ∅
    @fact Interval(-1.0, -0.1) ^ Interval(-2.5, -2.5) --> ∅
end
end

facts("minimal_pow_dec_test") do

end

facts("minimal_exp_test") do
    @fact exp(∅) --> ∅
    @fact exp(Interval(-Inf, 0.0)) --> Interval(0.0, 1.0)
    @fact exp(Interval(-Inf, -0.0)) --> Interval(0.0, 1.0)
    @fact exp(Interval(0.0, Inf)) --> Interval(1.0, Inf)
    @fact exp(Interval(-0.0, Inf)) --> Interval(1.0, Inf)
    @fact exp(entireinterval(Float64)) --> Interval(0.0, Inf)
    @fact exp(Interval(-Inf, 0x1.62e42fefa39fp+9)) --> Interval(0.0, Inf)
    @fact exp(Interval(0x1.62e42fefa39fp+9, 0x1.62e42fefa39fp+9)) --> Interval(0x1.fffffffffffffp+1023, Inf)
    @fact exp(Interval(0.0, 0x1.62e42fefa39ep+9)) --> Interval(1.0, 0x1.fffffffffc32bp+1023)
    @fact exp(Interval(-0.0, 0x1.62e42fefa39ep+9)) --> Interval(1.0, 0x1.fffffffffc32bp+1023)
    @fact exp(Interval(-0x1.6232bdd7abcd3p+9, 0x1.62e42fefa39ep+9)) --> Interval(0x0.ffffffffffe7bp-1022, 0x1.fffffffffc32bp+1023)
    @fact exp(Interval(-0x1.6232bdd7abcd3p+8, 0x1.62e42fefa39ep+9)) --> Interval(0x1.ffffffffffe7bp-512, 0x1.fffffffffc32bp+1023)
    @fact exp(Interval(-0x1.6232bdd7abcd3p+8, 0.0)) --> Interval(0x1.ffffffffffe7bp-512, 1.0)
    @fact exp(Interval(-0x1.6232bdd7abcd3p+8, -0.0)) --> Interval(0x1.ffffffffffe7bp-512, 1.0)
    @fact exp(Interval(-0x1.6232bdd7abcd3p+8, 1.0)) --> Interval(0x1.ffffffffffe7bp-512, 0x1.5bf0a8b14576ap+1)
    @fact exp(Interval(1.0, 5.0)) --> Interval(0x1.5bf0a8b145769p+1, 0x1.28d389970339p+7)
    @fact exp(Interval(-0x1.a934f0979a372p+1, 0x1.ceaecfea8085ap+0)) --> Interval(0x1.2797f0a337a5fp-5, 0x1.86091cc9095c5p+2)
    @fact exp(Interval(0x1.87f42b972949cp-1, 0x1.8b55484710029p+6)) --> Interval(0x1.1337e9e45812ap+1, 0x1.805a5c88021b6p+142)
    @fact exp(Interval(0x1.78025c8b3fd39p+3, 0x1.9fd8eef3fa79bp+4)) --> Interval(0x1.ef461a783114cp+16, 0x1.691d36c6b008cp+37)
end

facts("minimal_exp_dec_test") do

end

facts("minimal_exp2_test") do
    @fact exp2(∅) --> ∅
    @fact exp2(Interval(-Inf, 0.0)) --> Interval(0.0, 1.0)
    @fact exp2(Interval(-Inf, -0.0)) --> Interval(0.0, 1.0)
    @fact exp2(Interval(0.0, Inf)) --> Interval(1.0, Inf)
    @fact exp2(Interval(-0.0, Inf)) --> Interval(1.0, Inf)
    @fact exp2(entireinterval(Float64)) --> Interval(0.0, Inf)
    @fact exp2(Interval(-Inf, 1024.0)) --> Interval(0.0, Inf)
    @fact exp2(Interval(1024.0, 1024.0)) --> Interval(0x1.fffffffffffffp+1023, Inf)
    @fact exp2(Interval(0.0, 1023.0)) --> Interval(1.0, 0x1p+1023)
    @fact exp2(Interval(-0.0, 1023.0)) --> Interval(1.0, 0x1p+1023)
    @fact exp2(Interval(-1022.0, 1023.0)) --> Interval(0x1p-1022, 0x1p+1023)
    @fact exp2(Interval(-1022.0, 0.0)) --> Interval(0x1p-1022, 1.0)
    @fact exp2(Interval(-1022.0, -0.0)) --> Interval(0x1p-1022, 1.0)
    @fact exp2(Interval(-1022.0, 1.0)) --> Interval(0x1p-1022, 2.0)
    @fact exp2(Interval(1.0, 5.0)) --> Interval(2.0, 32.0)
    @fact exp2(Interval(-0x1.a934f0979a372p+1, 0x1.ceaecfea8085ap+0)) --> Interval(0x1.9999999999998p-4, 0x1.c000000000001p+1)
    @fact exp2(Interval(0x1.87f42b972949cp-1, 0x1.8b55484710029p+6)) --> Interval(0x1.b333333333332p+0, 0x1.c81fd88228b4fp+98)
    @fact exp2(Interval(0x1.78025c8b3fd39p+3, 0x1.9fd8eef3fa79bp+4)) --> Interval(0x1.aea0000721857p+11, 0x1.fca0555555559p+25)
end

facts("minimal_exp2_dec_test") do

end

facts("minimal_exp10_test") do
    @fact exp10(∅) --> ∅
    @fact exp10(Interval(-Inf, 0.0)) --> Interval(0.0, 1.0)
    @fact exp10(Interval(-Inf, -0.0)) --> Interval(0.0, 1.0)
    @fact exp10(Interval(0.0, Inf)) --> Interval(1.0, Inf)
    @fact exp10(Interval(-0.0, Inf)) --> Interval(1.0, Inf)
    @fact exp10(entireinterval(Float64)) --> Interval(0.0, Inf)
    @fact exp10(Interval(-Inf, 0x1.34413509f79ffp+8)) --> Interval(0.0, Inf)
    @fact exp10(Interval(0x1.34413509f79ffp+8, 0x1.34413509f79ffp+8)) --> Interval(0x1.fffffffffffffp+1023, Inf)
    @fact exp10(Interval(0.0, 0x1.34413509f79fep+8)) --> Interval(1.0, 0x1.ffffffffffba1p+1023)
    @fact exp10(Interval(-0.0, 0x1.34413509f79fep+8)) --> Interval(1.0, 0x1.ffffffffffba1p+1023)
    @fact exp10(Interval(-0x1.33a7146f72a42p+8, 0x1.34413509f79fep+8)) --> Interval(0x0.fffffffffffe3p-1022, 0x1.ffffffffffba1p+1023)
    @fact exp10(Interval(-0x1.22p+7, 0x1.34413509f79fep+8)) --> Interval(0x1.3faac3e3fa1f3p-482, 0x1.ffffffffffba1p+1023)
    @fact exp10(Interval(-0x1.22p+7, 0.0)) --> Interval(0x1.3faac3e3fa1f3p-482, 1.0)
    @fact exp10(Interval(-0x1.22p+7, -0.0)) --> Interval(0x1.3faac3e3fa1f3p-482, 1.0)
    @fact exp10(Interval(-0x1.22p+7, 1.0)) --> Interval(0x1.3faac3e3fa1f3p-482, 10.0)
    @fact exp10(Interval(1.0, 5.0)) --> Interval(10.0, 100000.0)
    @fact exp10(Interval(-0x1.a934f0979a372p+1, 0x1.ceaecfea8085ap+0)) --> Interval(0x1.f3a8254311f9ap-12, 0x1.00b18ad5b7d56p+6)
    @fact exp10(Interval(0x1.87f42b972949cp-1, 0x1.8b55484710029p+6)) --> Interval(0x1.75014b7296807p+2, 0x1.3eec1d47dfb2bp+328)
    @fact exp10(Interval(0x1.78025c8b3fd39p+3, 0x1.9fd8eef3fa79bp+4)) --> Interval(0x1.0608d2279a811p+39, 0x1.43af5d4271cb8p+86)
end

facts("minimal_exp10_dec_test") do

end

facts("minimal_log_test") do
    @fact log(∅) --> ∅
    @fact log(Interval(-Inf, 0.0)) --> ∅
    @fact log(Interval(-Inf, -0.0)) --> ∅
    @fact log(Interval(0.0, 1.0)) --> Interval(-Inf, 0.0)
    @fact log(Interval(-0.0, 1.0)) --> Interval(-Inf, 0.0)
    @fact log(Interval(1.0, Inf)) --> Interval(0.0, Inf)
    @fact log(Interval(0.0, Inf)) --> entireinterval(Float64)
    @fact log(Interval(-0.0, Inf)) --> entireinterval(Float64)
    @fact log(entireinterval(Float64)) --> entireinterval(Float64)
    @fact log(Interval(0.0, 0x1.fffffffffffffp1023)) --> Interval(-Inf, 0x1.62e42fefa39fp+9)
    @fact log(Interval(-0.0, 0x1.fffffffffffffp1023)) --> Interval(-Inf, 0x1.62e42fefa39fp+9)
    @fact log(Interval(1.0, 0x1.fffffffffffffp1023)) --> Interval(0.0, 0x1.62e42fefa39fp+9)
    @fact log(Interval(0x0.0000000000001p-1022, 0x1.fffffffffffffp1023)) --> Interval(-0x1.74385446d71c4p9, +0x1.62e42fefa39fp9)
    @fact log(Interval(0x0.0000000000001p-1022, 1.0)) --> Interval(-0x1.74385446d71c4p9, 0.0)
    @fact log(Interval(0x1.5bf0a8b145769p+1, 0x1.5bf0a8b145769p+1)) --> Interval(0x1.fffffffffffffp-1, 0x1p+0)
    @fact log(Interval(0x1.5bf0a8b14576ap+1, 0x1.5bf0a8b14576ap+1)) --> Interval(0x1p+0, 0x1.0000000000001p+0)
    @fact log(Interval(0x0.0000000000001p-1022, 0x1.5bf0a8b14576ap+1)) --> Interval(-0x1.74385446d71c4p9, 0x1.0000000000001p+0)
    @fact log(Interval(0x1.5bf0a8b145769p+1, 32.0)) --> Interval(0x1.fffffffffffffp-1, 0x1.bb9d3beb8c86cp+1)
    @fact log(Interval(0x1.999999999999ap-4, 0x1.cp+1)) --> Interval(-0x1.26bb1bbb55516p+1, 0x1.40b512eb53d6p+0)
    @fact log(Interval(0x1.b333333333333p+0, 0x1.c81fd88228b2fp+98)) --> Interval(0x1.0fae81914a99p-1, 0x1.120627f6ae7f1p+6)
    @fact log(Interval(0x1.aea0000721861p+11, 0x1.fca055555554cp+25)) --> Interval(0x1.04a1363db1e63p+3, 0x1.203e52c0256b5p+4)
end

facts("minimal_log_dec_test") do

end

facts("minimal_log2_test") do
    @fact log2(∅) --> ∅
    @fact log2(Interval(-Inf, 0.0)) --> ∅
    @fact log2(Interval(-Inf, -0.0)) --> ∅
    @fact log2(Interval(0.0, 1.0)) --> Interval(-Inf, 0.0)
    @fact log2(Interval(-0.0, 1.0)) --> Interval(-Inf, 0.0)
    @fact log2(Interval(1.0, Inf)) --> Interval(0.0, Inf)
    @fact log2(Interval(0.0, Inf)) --> entireinterval(Float64)
    @fact log2(Interval(-0.0, Inf)) --> entireinterval(Float64)
    @fact log2(entireinterval(Float64)) --> entireinterval(Float64)
    @fact log2(Interval(0.0, 0x1.fffffffffffffp1023)) --> Interval(-Inf, 1024.0)
    @fact log2(Interval(-0.0, 0x1.fffffffffffffp1023)) --> Interval(-Inf, 1024.0)
    @fact log2(Interval(1.0, 0x1.fffffffffffffp1023)) --> Interval(0.0, 1024.0)
    @fact log2(Interval(0x0.0000000000001p-1022, 0x1.fffffffffffffp1023)) --> Interval(-1074.0, 1024.0)
    @fact log2(Interval(0x0.0000000000001p-1022, 1.0)) --> Interval(-1074.0, 0.0)
    @fact log2(Interval(0x0.0000000000001p-1022, 2.0)) --> Interval(-1074.0, 1.0)
    @fact log2(Interval(2.0, 32.0)) --> Interval(1.0, 5.0)
    @fact log2(Interval(0x1.999999999999ap-4, 0x1.cp+1)) --> Interval(-0x1.a934f0979a372p+1, 0x1.ceaecfea8085ap+0)
    @fact log2(Interval(0x1.b333333333333p+0, 0x1.c81fd88228b2fp+98)) --> Interval(0x1.87f42b972949cp-1, 0x1.8b55484710029p+6)
    @fact log2(Interval(0x1.aea0000721861p+11, 0x1.fca055555554cp+25)) --> Interval(0x1.78025c8b3fd39p+3, 0x1.9fd8eef3fa79bp+4)
end

facts("minimal_log2_dec_test") do

end

facts("minimal_log10_test") do
    @fact log10(∅) --> ∅
    @fact log10(Interval(-Inf, 0.0)) --> ∅
    @fact log10(Interval(-Inf, -0.0)) --> ∅
    @fact log10(Interval(0.0, 1.0)) --> Interval(-Inf, 0.0)
    @fact log10(Interval(-0.0, 1.0)) --> Interval(-Inf, 0.0)
    @fact log10(Interval(1.0, Inf)) --> Interval(0.0, Inf)
    @fact log10(Interval(0.0, Inf)) --> entireinterval(Float64)
    @fact log10(Interval(-0.0, Inf)) --> entireinterval(Float64)
    @fact log10(entireinterval(Float64)) --> entireinterval(Float64)
    @fact log10(Interval(0.0, 0x1.fffffffffffffp1023)) --> Interval(-Inf, 0x1.34413509f79ffp+8)
    @fact log10(Interval(-0.0, 0x1.fffffffffffffp1023)) --> Interval(-Inf, 0x1.34413509f79ffp+8)
    @fact log10(Interval(1.0, 0x1.fffffffffffffp1023)) --> Interval(0.0, 0x1.34413509f79ffp+8)
    @fact log10(Interval(0x0.0000000000001p-1022, 0x1.fffffffffffffp1023)) --> Interval(-0x1.434e6420f4374p+8, +0x1.34413509f79ffp+8)
    @fact log10(Interval(0x0.0000000000001p-1022, 1.0)) --> Interval(-0x1.434e6420f4374p+8, 0.0)
    @fact log10(Interval(0x0.0000000000001p-1022, 10.0)) --> Interval(-0x1.434e6420f4374p+8, 1.0)
    @fact log10(Interval(10.0, 100000.0)) --> Interval(1.0, 5.0)
    @fact log10(Interval(0x1.999999999999ap-4, 0x1.cp+1)) --> Interval(-0x1p+0, 0x1.1690163290f4p-1)
    @fact log10(Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact log10(Interval(0x1.b333333333333p+0, 0x1.c81fd88228b2fp+98)) --> Interval(0x1.d7f59aa5becb9p-3, 0x1.dc074d84e5aabp+4)
    @fact log10(Interval(0x1.aea0000721861p+11, 0x1.fca055555554cp+25)) --> Interval(0x1.c4c29dd829191p+1, 0x1.f4baebba4fa4p+2)
end

facts("minimal_log10_dec_test") do

end

facts("minimal_sin_test") do
    @fact sin(∅) --> ∅
    @fact sin(Interval(0.0, Inf)) --> Interval(-1.0, 1.0)
    @fact sin(Interval(-0.0, Inf)) --> Interval(-1.0, 1.0)
    @fact sin(Interval(-Inf, 0.0)) --> Interval(-1.0, 1.0)
    @fact sin(Interval(-Inf, -0.0)) --> Interval(-1.0, 1.0)
    @fact sin(entireinterval(Float64)) --> Interval(-1.0, 1.0)
    @fact sin(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact sin(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact sin(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d18p+0)) --> Interval(0x1.fffffffffffffp-1, 0x1p+0)
    @fact sin(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)) --> Interval(0x1.fffffffffffffp-1, 0x1p+0)
    @fact sin(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)) --> Interval(0x1.fffffffffffffp-1, 0x1p+0)
    @fact sin(Interval(0.0, 0x1.921fb54442d18p+0)) --> Interval(0.0, 0x1p+0)
    @fact sin(Interval(-0.0, 0x1.921fb54442d18p+0)) --> Interval(0.0, 0x1p+0)
    @fact sin(Interval(0.0, 0x1.921fb54442d19p+0)) --> Interval(0.0, 0x1p+0)
    @fact sin(Interval(-0.0, 0x1.921fb54442d19p+0)) --> Interval(0.0, 0x1p+0)
    @fact sin(Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d18p+1)) --> Interval(0x1.1a62633145c06p-53, 0x1.1a62633145c07p-53)
    @fact sin(Interval(0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)) --> Interval(-0x1.72cece675d1fdp-52, -0x1.72cece675d1fcp-52)
    @fact sin(Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)) --> Interval(-0x1.72cece675d1fdp-52, 0x1.1a62633145c07p-53)
    @fact sin(Interval(0.0, 0x1.921fb54442d18p+1)) --> Interval(0.0, 1.0)
    @fact sin(Interval(-0.0, 0x1.921fb54442d18p+1)) --> Interval(0.0, 1.0)
    @fact sin(Interval(0.0, 0x1.921fb54442d19p+1)) --> Interval(-0x1.72cece675d1fdp-52, 1.0)
    @fact sin(Interval(-0.0, 0x1.921fb54442d19p+1)) --> Interval(-0x1.72cece675d1fdp-52, 1.0)
    @fact sin(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d18p+1)) --> Interval(0x1.1a62633145c06p-53, 0x1p+0)
    @fact sin(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)) --> Interval(-0x1.72cece675d1fdp-52, 0x1p+0)
    @fact sin(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d18p+1)) --> Interval(0x1.1a62633145c06p-53, 0x1p+0)
    @fact sin(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d19p+1)) --> Interval(-0x1.72cece675d1fdp-52, 0x1p+0)
    @fact sin(Interval(-0x1.921fb54442d18p+0, -0x1.921fb54442d18p+0)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact sin(Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d19p+0)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact sin(Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact sin(Interval(-0x1.921fb54442d18p+0, 0.0)) --> Interval(-0x1p+0, 0.0)
    @fact sin(Interval(-0x1.921fb54442d18p+0, -0.0)) --> Interval(-0x1p+0, 0.0)
    @fact sin(Interval(-0x1.921fb54442d19p+0, 0.0)) --> Interval(-0x1p+0, 0.0)
    @fact sin(Interval(-0x1.921fb54442d19p+0, -0.0)) --> Interval(-0x1p+0, 0.0)
    @fact sin(Interval(-0x1.921fb54442d18p+1, -0x1.921fb54442d18p+1)) --> Interval(-0x1.1a62633145c07p-53, -0x1.1a62633145c06p-53)
    @fact sin(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d19p+1)) --> Interval(0x1.72cece675d1fcp-52, 0x1.72cece675d1fdp-52)
    @fact sin(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d18p+1)) --> Interval(-0x1.1a62633145c07p-53, 0x1.72cece675d1fdp-52)
    @fact sin(Interval(-0x1.921fb54442d18p+1, 0.0)) --> Interval(-1.0, 0.0)
    @fact sin(Interval(-0x1.921fb54442d18p+1, -0.0)) --> Interval(-1.0, 0.0)
    @fact sin(Interval(-0x1.921fb54442d19p+1, 0.0)) --> Interval(-1.0, 0x1.72cece675d1fdp-52)
    @fact sin(Interval(-0x1.921fb54442d19p+1, -0.0)) --> Interval(-1.0, 0x1.72cece675d1fdp-52)
    @fact sin(Interval(-0x1.921fb54442d18p+1, -0x1.921fb54442d18p+0)) --> Interval(-0x1p+0, -0x1.1a62633145c06p-53)
    @fact sin(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d18p+0)) --> Interval(-0x1p+0, 0x1.72cece675d1fdp-52)
    @fact sin(Interval(-0x1.921fb54442d18p+1, -0x1.921fb54442d19p+0)) --> Interval(-0x1p+0, -0x1.1a62633145c06p-53)
    @fact sin(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d19p+0)) --> Interval(-0x1p+0, 0x1.72cece675d1fdp-52)
    @fact sin(Interval(-0x1.921fb54442d18p+0, 0x1.921fb54442d18p+0)) --> Interval(-0x1p+0, 0x1p+0)
    @fact sin(Interval(-0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1p+0, 0x1p+0)
    @fact sin(Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d18p+0)) --> Interval(-0x1p+0, 0x1p+0)
    @fact sin(Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1p+0, 0x1p+0)
    @fact sin(Interval(-0.7, 0.1)) --> Interval(-0x1.49d6e694619b9p-1, 0x1.98eaecb8bcb2dp-4)
    @fact sin(Interval(1.0, 2.0)) --> Interval(0x1.aed548f090ceep-1, 1.0)
    @fact sin(Interval(-3.2, -2.9)) --> Interval(-0x1.e9fb8d64830e3p-3, 0x1.de33739e82d33p-5)
    @fact sin(Interval(2.0, 3.0)) --> Interval(0x1.210386db6d55bp-3, 0x1.d18f6ead1b446p-1)
end

facts("minimal_sin_dec_test") do

end

facts("minimal_cos_test") do
    @fact cos(∅) --> ∅
    @fact cos(Interval(0.0, Inf)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0.0, Inf)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-Inf, 0.0)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-Inf, -0.0)) --> Interval(-1.0, 1.0)
    @fact cos(entireinterval(Float64)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(0.0, 0.0)) --> Interval(1.0, 1.0)
    @fact cos(Interval(-0.0, -0.0)) --> Interval(1.0, 1.0)
    @fact cos(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d18p+0)) --> Interval(0x1.1a62633145c06p-54, 0x1.1a62633145c07p-54)
    @fact cos(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, -0x1.72cece675d1fcp-53)
    @fact cos(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, 0x1.1a62633145c07p-54)
    @fact cos(Interval(0.0, 0x1.921fb54442d18p+0)) --> Interval(0x1.1a62633145c06p-54, 1.0)
    @fact cos(Interval(-0.0, 0x1.921fb54442d18p+0)) --> Interval(0x1.1a62633145c06p-54, 1.0)
    @fact cos(Interval(0.0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(-0.0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d18p+1)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact cos(Interval(0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact cos(Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact cos(Interval(0.0, 0x1.921fb54442d18p+1)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0.0, 0x1.921fb54442d18p+1)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(0.0, 0x1.921fb54442d19p+1)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0.0, 0x1.921fb54442d19p+1)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d18p+1)) --> Interval(-1.0, 0x1.1a62633145c07p-54)
    @fact cos(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)) --> Interval(-1.0, 0x1.1a62633145c07p-54)
    @fact cos(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d18p+1)) --> Interval(-1.0, -0x1.72cece675d1fcp-53)
    @fact cos(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d19p+1)) --> Interval(-1.0, -0x1.72cece675d1fcp-53)
    @fact cos(Interval(-0x1.921fb54442d18p+0, -0x1.921fb54442d18p+0)) --> Interval(0x1.1a62633145c06p-54, 0x1.1a62633145c07p-54)
    @fact cos(Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, -0x1.72cece675d1fcp-53)
    @fact cos(Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)) --> Interval(-0x1.72cece675d1fdp-53, 0x1.1a62633145c07p-54)
    @fact cos(Interval(-0x1.921fb54442d18p+0, 0.0)) --> Interval(0x1.1a62633145c06p-54, 1.0)
    @fact cos(Interval(-0x1.921fb54442d18p+0, -0.0)) --> Interval(0x1.1a62633145c06p-54, 1.0)
    @fact cos(Interval(-0x1.921fb54442d19p+0, 0.0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(-0x1.921fb54442d19p+0, -0.0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(-0x1.921fb54442d18p+1, -0x1.921fb54442d18p+1)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact cos(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d19p+1)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact cos(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d18p+1)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact cos(Interval(-0x1.921fb54442d18p+1, 0.0)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0x1.921fb54442d18p+1, -0.0)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0x1.921fb54442d19p+1, 0.0)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0x1.921fb54442d19p+1, -0.0)) --> Interval(-1.0, 1.0)
    @fact cos(Interval(-0x1.921fb54442d18p+1, -0x1.921fb54442d18p+0)) --> Interval(-1.0, 0x1.1a62633145c07p-54)
    @fact cos(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d18p+0)) --> Interval(-1.0, 0x1.1a62633145c07p-54)
    @fact cos(Interval(-0x1.921fb54442d18p+1, -0x1.921fb54442d19p+0)) --> Interval(-1.0, -0x1.72cece675d1fcp-53)
    @fact cos(Interval(-0x1.921fb54442d19p+1, -0x1.921fb54442d19p+0)) --> Interval(-1.0, -0x1.72cece675d1fcp-53)
    @fact cos(Interval(-0x1.921fb54442d18p+0, 0x1.921fb54442d18p+0)) --> Interval(0x1.1a62633145c06p-54, 1.0)
    @fact cos(Interval(-0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d18p+0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.72cece675d1fdp-53, 1.0)
    @fact cos(Interval(-0.7, 0.1)) --> Interval(0x1.87996529f9d92p-1, 1.0)
    @fact cos(Interval(1.0, 2.0)) --> Interval(-0x1.aa22657537205p-2, 0x1.14a280fb5068cp-1)
    @fact cos(Interval(-3.2, -2.9)) --> Interval(-1.0, -0x1.f1216dba340c8p-1)
    @fact cos(Interval(2.0, 3.0)) --> Interval(-0x1.fae04be85e5d3p-1, -0x1.aa22657537204p-2)
end

facts("minimal_cos_dec_test") do

end

facts("minimal_tan_test") do
    @fact tan(∅) --> ∅
    @fact tan(Interval(0.0, Inf)) --> entireinterval(Float64)
    @fact tan(Interval(-0.0, Inf)) --> entireinterval(Float64)
    @fact tan(Interval(-Inf, 0.0)) --> entireinterval(Float64)
    @fact tan(Interval(-Inf, -0.0)) --> entireinterval(Float64)
    @fact tan(entireinterval(Float64)) --> entireinterval(Float64)
    @fact tan(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact tan(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact tan(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d18p+0)) --> Interval(0x1.d02967c31cdb4p+53, 0x1.d02967c31cdb5p+53)
    @fact tan(Interval(0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)) --> Interval(-0x1.617a15494767bp+52, -0x1.617a15494767ap+52)
    @fact tan(Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)) --> entireinterval(Float64)
    @fact tan(Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d18p+1)) --> Interval(-0x1.1a62633145c07p-53, -0x1.1a62633145c06p-53)
    @fact tan(Interval(0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)) --> Interval(0x1.72cece675d1fcp-52, 0x1.72cece675d1fdp-52)
    @fact tan(Interval(0.0, 0x1.921fb54442d18p+0)) --> Interval(0.0, 0x1.d02967c31cdb5p+53)
    @fact tan(Interval(-0.0, 0x1.921fb54442d18p+0)) --> Interval(0.0, 0x1.d02967c31cdb5p+53)
    @fact tan(Interval(0.0, 0x1.921fb54442d19p+0)) --> entireinterval(Float64)
    @fact tan(Interval(-0.0, 0x1.921fb54442d19p+0)) --> entireinterval(Float64)
    @fact tan(Interval(0.0, 0x1.921fb54442d18p+1)) --> entireinterval(Float64)
    @fact tan(Interval(-0.0, 0x1.921fb54442d18p+1)) --> entireinterval(Float64)
    @fact tan(Interval(0.0, 0x1.921fb54442d19p+1)) --> entireinterval(Float64)
    @fact tan(Interval(-0.0, 0x1.921fb54442d19p+1)) --> entireinterval(Float64)
    @fact tan(Interval(0x1p-51, 0x1.921fb54442d18p+1)) --> entireinterval(Float64)
    @fact tan(Interval(0x1p-51, 0x1.921fb54442d19p+1)) --> entireinterval(Float64)
    @fact tan(Interval(0x1p-52, 0x1.921fb54442d18p+1)) --> entireinterval(Float64)
    @fact tan(Interval(0x1p-52, 0x1.921fb54442d19p+1)) --> entireinterval(Float64)
    @fact tan(Interval(-0x1.921fb54442d18p+0, 0x1.921fb54442d18p+0)) --> Interval(-0x1.d02967c31cdb5p+53, 0x1.d02967c31cdb5p+53)
    @fact tan(Interval(-0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)) --> entireinterval(Float64)
    @fact tan(Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d18p+0)) --> entireinterval(Float64)
    @fact tan(Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)) --> entireinterval(Float64)
    @fact tan(Interval(-0x1.555475a31a4bep-2, 0x1.999999999999ap-4)) --> Interval(-0x1.628f4fd931fefp-2, 0x1.9af8877430b81p-4)
    @fact tan(Interval(0x1.4e18e147ae148p+12, 0x1.4e2028f5c28f6p+12)) --> Interval(-0x1.d6d67b035b6b4p+2, -0x1.7e42b0760e3f3p+0)
    @fact tan(Interval(0x1.4e18e147ae148p+12, 0x1.546028f5c28f6p+12)) --> entireinterval(Float64)
    @fact tan(Interval(0x1.fae147ae147aep-1, 0x1.028f5c28f5c29p+0)) --> Interval(0x1.860fadcc59064p+0, 0x1.979ad0628469dp+0)
end

facts("minimal_tan_dec_test") do

end

facts("minimal_asin_test") do
    @fact asin(∅) --> ∅
    @fact asin(Interval(0.0, Inf)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact asin(Interval(-0.0, Inf)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact asin(Interval(-Inf, 0.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact asin(Interval(-Inf, -0.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact asin(entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact asin(Interval(-1.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact asin(Interval(-Inf, -1.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact asin(Interval(1.0, Inf)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact asin(Interval(-1.0, -1.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact asin(Interval(1.0, 1.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact asin(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact asin(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact asin(Interval(-Inf, -0x1.0000000000001p+0)) --> ∅
    @fact asin(Interval(0x1.0000000000001p+0, Inf)) --> ∅
    @fact asin(Interval(-0x1.999999999999ap-4, 0x1.999999999999ap-4)) --> Interval(-0x1.9a49276037885p-4, 0x1.9a49276037885p-4)
    @fact asin(Interval(-0x1.51eb851eb851fp-2, 0x1.fffffffffffffp-1)) --> Interval(-0x1.585ff6e341c3fp-2, 0x1.921fb50442d19p+0)
    @fact asin(Interval(-0x1.fffffffffffffp-1, 0x1.fffffffffffffp-1)) --> Interval(-0x1.921fb50442d19p+0, 0x1.921fb50442d19p+0)
end

facts("minimal_asin_dec_test") do

end

facts("minimal_acos_test") do
    @fact acos(∅) --> ∅
    @fact acos(Interval(0.0, Inf)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact acos(Interval(-0.0, Inf)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact acos(Interval(-Inf, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)
    @fact acos(Interval(-Inf, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)
    @fact acos(entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact acos(Interval(-1.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact acos(Interval(-Inf, -1.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact acos(Interval(1.0, Inf)) --> Interval(0.0, 0.0)
    @fact acos(Interval(-1.0, -1.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact acos(Interval(1.0, 1.0)) --> Interval(0.0, 0.0)
    @fact acos(Interval(0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact acos(Interval(-0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact acos(Interval(-Inf, -0x1.0000000000001p+0)) --> ∅
    @fact acos(Interval(0x1.0000000000001p+0, Inf)) --> ∅
    @fact acos(Interval(-0x1.999999999999ap-4, 0x1.999999999999ap-4)) --> Interval(0x1.787b22ce3f59p+0, 0x1.abc447ba464a1p+0)
    @fact acos(Interval(-0x1.51eb851eb851fp-2, 0x1.fffffffffffffp-1)) --> Interval(0x1p-26, 0x1.e837b2fd13428p+0)
    @fact acos(Interval(-0x1.fffffffffffffp-1, 0x1.fffffffffffffp-1)) --> Interval(0x1p-26, 0x1.921fb52442d19p+1)
end

facts("minimal_acos_dec_test") do

end

facts("minimal_atan_test") do
    @fact atan(∅) --> ∅
    @fact atan(Interval(0.0, Inf)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact atan(Interval(-0.0, Inf)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact atan(Interval(-Inf, 0.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact atan(Interval(-Inf, -0.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact atan(entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact atan(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact atan(Interval(1.0, 0x1.4c2463567c5acp+25)) --> Interval(0x1.921fb54442d18p-1, 0x1.921fb4e19abd7p+0)
    @fact atan(Interval(-0x1.fd219490eaac1p+38, -0x1.1af1c9d74f06dp+9)) --> Interval(-0x1.921fb54440cebp+0, -0x1.91abe5c1e4c6dp+0)
end

facts("minimal_atan_dec_test") do

end

facts("minimal_atan2_test") do
    @fact atan2(∅, ∅) --> ∅
    @fact atan2(∅, entireinterval(Float64)) --> ∅
    @fact atan2(∅, Interval(0.0, 0.0)) --> ∅
    @fact atan2(∅, Interval(-0.0, 0.0)) --> ∅
    @fact atan2(∅, Interval(0.0, -0.0)) --> ∅
    @fact atan2(∅, Interval(-0.0, -0.0)) --> ∅
    @fact atan2(∅, Interval(-2.0, -0.1)) --> ∅
    @fact atan2(∅, Interval(-2.0, 0.0)) --> ∅
    @fact atan2(∅, Interval(-2.0, -0.0)) --> ∅
    @fact atan2(∅, Interval(-2.0, 1.0)) --> ∅
    @fact atan2(∅, Interval(0.0, 1.0)) --> ∅
    @fact atan2(∅, Interval(-0.0, 1.0)) --> ∅
    @fact atan2(∅, Interval(0.1, 1.0)) --> ∅
    @fact atan2(entireinterval(Float64), ∅) --> ∅
    @fact atan2(entireinterval(Float64), entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(entireinterval(Float64), Interval(0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(entireinterval(Float64), Interval(0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(entireinterval(Float64), Interval(-0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(entireinterval(Float64), Interval(-0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(entireinterval(Float64), Interval(-2.0, -0.1)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(entireinterval(Float64), Interval(-2.0, 0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(entireinterval(Float64), Interval(-2.0, -0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(entireinterval(Float64), Interval(-2.0, 1.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(entireinterval(Float64), Interval(0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(entireinterval(Float64), Interval(-0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(entireinterval(Float64), Interval(0.1, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 0.0), ∅) --> ∅
    @fact atan2(Interval(0.0, 0.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 0.0), Interval(0.0, 0.0)) --> ∅
    @fact atan2(Interval(0.0, 0.0), Interval(-0.0, 0.0)) --> ∅
    @fact atan2(Interval(0.0, 0.0), Interval(0.0, -0.0)) --> ∅
    @fact atan2(Interval(0.0, 0.0), Interval(-0.0, -0.0)) --> ∅
    @fact atan2(Interval(0.0, 0.0), Interval(-2.0, -0.1)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 0.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 0.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 0.0), Interval(-2.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 0.0), Interval(0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(0.0, 0.0), Interval(-0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(0.0, 0.0), Interval(0.1, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-0.0, 0.0), ∅) --> ∅
    @fact atan2(Interval(-0.0, 0.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 0.0), Interval(0.0, 0.0)) --> ∅
    @fact atan2(Interval(-0.0, 0.0), Interval(-0.0, 0.0)) --> ∅
    @fact atan2(Interval(-0.0, 0.0), Interval(0.0, -0.0)) --> ∅
    @fact atan2(Interval(-0.0, 0.0), Interval(-0.0, -0.0)) --> ∅
    @fact atan2(Interval(-0.0, 0.0), Interval(-2.0, -0.1)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 0.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 0.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 0.0), Interval(-2.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 0.0), Interval(0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-0.0, 0.0), Interval(-0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-0.0, 0.0), Interval(0.1, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(0.0, -0.0), ∅) --> ∅
    @fact atan2(Interval(0.0, -0.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, -0.0), Interval(0.0, 0.0)) --> ∅
    @fact atan2(Interval(0.0, -0.0), Interval(-0.0, 0.0)) --> ∅
    @fact atan2(Interval(0.0, -0.0), Interval(0.0, -0.0)) --> ∅
    @fact atan2(Interval(0.0, -0.0), Interval(-0.0, -0.0)) --> ∅
    @fact atan2(Interval(0.0, -0.0), Interval(-2.0, -0.1)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, -0.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, -0.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, -0.0), Interval(-2.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, -0.0), Interval(0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(0.0, -0.0), Interval(-0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(0.0, -0.0), Interval(0.1, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-0.0, -0.0), ∅) --> ∅
    @fact atan2(Interval(-0.0, -0.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, -0.0), Interval(0.0, 0.0)) --> ∅
    @fact atan2(Interval(-0.0, -0.0), Interval(-0.0, 0.0)) --> ∅
    @fact atan2(Interval(-0.0, -0.0), Interval(0.0, -0.0)) --> ∅
    @fact atan2(Interval(-0.0, -0.0), Interval(-0.0, -0.0)) --> ∅
    @fact atan2(Interval(-0.0, -0.0), Interval(-2.0, -0.1)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, -0.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, -0.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, -0.0), Interval(-2.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, -0.0), Interval(0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-0.0, -0.0), Interval(-0.0, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-0.0, -0.0), Interval(0.1, 1.0)) --> Interval(0.0, 0.0)
    @fact atan2(Interval(-2.0, -0.1), ∅) --> ∅
    @fact atan2(Interval(-2.0, -0.1), entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+1, 0.0)
    @fact atan2(Interval(-2.0, -0.1), Interval(0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(-0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(-2.0, -0.1)) --> Interval(-0x1.8bbaabde5e29cp+1, -0x1.9ee9c8100c211p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(-2.0, 0.0)) --> Interval(-0x1.8bbaabde5e29cp+1, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(-2.0, -0.0)) --> Interval(-0x1.8bbaabde5e29cp+1, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.1), Interval(-2.0, 1.0)) --> Interval(-0x1.8bbaabde5e29cp+1, -0x1.983e282e2cc4cp-4)
    @fact atan2(Interval(-2.0, -0.1), Interval(0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.983e282e2cc4cp-4)
    @fact atan2(Interval(-2.0, -0.1), Interval(-0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.983e282e2cc4cp-4)
    @fact atan2(Interval(-2.0, -0.1), Interval(0.1, 1.0)) --> Interval(-0x1.8555a2787982p+0, -0x1.983e282e2cc4cp-4)
    @fact atan2(Interval(-2.0, 0.0), ∅) --> ∅
    @fact atan2(Interval(-2.0, 0.0), entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 0.0), Interval(0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, 0.0), Interval(-0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, 0.0), Interval(0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, 0.0), Interval(-0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, 0.0), Interval(-2.0, -0.1)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 0.0), Interval(-2.0, 0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 0.0), Interval(-2.0, -0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 0.0), Interval(-2.0, 1.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 0.0), Interval(0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact atan2(Interval(-2.0, 0.0), Interval(-0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact atan2(Interval(-2.0, 0.0), Interval(0.1, 1.0)) --> Interval(-0x1.8555a2787982p+0, 0.0)
    @fact atan2(Interval(-2.0, -0.0), ∅) --> ∅
    @fact atan2(Interval(-2.0, -0.0), entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, -0.0), Interval(0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.0), Interval(-0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.0), Interval(0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.0), Interval(-0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, -0x1.921fb54442d18p+0)
    @fact atan2(Interval(-2.0, -0.0), Interval(-2.0, -0.1)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, -0.0), Interval(-2.0, 0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, -0.0), Interval(-2.0, -0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, -0.0), Interval(-2.0, 1.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, -0.0), Interval(0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact atan2(Interval(-2.0, -0.0), Interval(-0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0.0)
    @fact atan2(Interval(-2.0, -0.0), Interval(0.1, 1.0)) --> Interval(-0x1.8555a2787982p+0, 0.0)
    @fact atan2(Interval(-2.0, 1.0), ∅) --> ∅
    @fact atan2(Interval(-2.0, 1.0), entireinterval(Float64)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 1.0), Interval(0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-2.0, 1.0), Interval(-0.0, 0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-2.0, 1.0), Interval(0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-2.0, 1.0), Interval(-0.0, -0.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-2.0, 1.0), Interval(-2.0, -0.1)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 1.0), Interval(-2.0, 0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 1.0), Interval(-2.0, -0.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 1.0), Interval(-2.0, 1.0)) --> Interval(-0x1.921fb54442d19p+1, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-2.0, 1.0), Interval(0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-2.0, 1.0), Interval(-0.0, 1.0)) --> Interval(-0x1.921fb54442d19p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-2.0, 1.0), Interval(0.1, 1.0)) --> Interval(-0x1.8555a2787982p+0, 0x1.789bd2c160054p+0)
    @fact atan2(Interval(-0.0, 1.0), ∅) --> ∅
    @fact atan2(Interval(-0.0, 1.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 1.0), Interval(0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-0.0, 1.0), Interval(-0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-0.0, 1.0), Interval(0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-0.0, 1.0), Interval(-0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-0.0, 1.0), Interval(-2.0, -0.1)) --> Interval(0x1.aba397c7259ddp+0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 1.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 1.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 1.0), Interval(-2.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(-0.0, 1.0), Interval(0.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-0.0, 1.0), Interval(-0.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(-0.0, 1.0), Interval(0.1, 1.0)) --> Interval(0.0, 0x1.789bd2c160054p+0)
    @fact atan2(Interval(0.0, 1.0), ∅) --> ∅
    @fact atan2(Interval(0.0, 1.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 1.0), Interval(0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 1.0), Interval(-0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 1.0), Interval(0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 1.0), Interval(-0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 1.0), Interval(-2.0, -0.1)) --> Interval(0x1.aba397c7259ddp+0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 1.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 1.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 1.0), Interval(-2.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.0, 1.0), Interval(0.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 1.0), Interval(-0.0, 1.0)) --> Interval(0.0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.0, 1.0), Interval(0.1, 1.0)) --> Interval(0.0, 0x1.789bd2c160054p+0)
    @fact atan2(Interval(0.1, 1.0), ∅) --> ∅
    @fact atan2(Interval(0.1, 1.0), entireinterval(Float64)) --> Interval(0.0, 0x1.921fb54442d19p+1)
    @fact atan2(Interval(0.1, 1.0), Interval(0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.1, 1.0), Interval(-0.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.1, 1.0), Interval(0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.1, 1.0), Interval(-0.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.1, 1.0), Interval(-2.0, -0.1)) --> Interval(0x1.aba397c7259ddp+0, 0x1.8bbaabde5e29cp+1)
    @fact atan2(Interval(0.1, 1.0), Interval(-2.0, 0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.8bbaabde5e29cp+1)
    @fact atan2(Interval(0.1, 1.0), Interval(-2.0, -0.0)) --> Interval(0x1.921fb54442d18p+0, 0x1.8bbaabde5e29cp+1)
    @fact atan2(Interval(0.1, 1.0), Interval(-2.0, 1.0)) --> Interval(0x1.983e282e2cc4cp-4, 0x1.8bbaabde5e29cp+1)
    @fact atan2(Interval(0.1, 1.0), Interval(0.0, 1.0)) --> Interval(0x1.983e282e2cc4cp-4, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.1, 1.0), Interval(-0.0, 1.0)) --> Interval(0x1.983e282e2cc4cp-4, 0x1.921fb54442d19p+0)
    @fact atan2(Interval(0.1, 1.0), Interval(0.1, 1.0)) --> Interval(0x1.983e282e2cc4cp-4, 0x1.789bd2c160054p+0)
end

facts("minimal_atan2_dec_test") do

end

facts("minimal_sinh_test") do
    @fact sinh(∅) --> ∅
    @fact sinh(Interval(0.0, Inf)) --> Interval(0.0, Inf)
    @fact sinh(Interval(-0.0, Inf)) --> Interval(0.0, Inf)
    @fact sinh(Interval(-Inf, 0.0)) --> Interval(-Inf, 0.0)
    @fact sinh(Interval(-Inf, -0.0)) --> Interval(-Inf, 0.0)
    @fact sinh(entireinterval(Float64)) --> entireinterval(Float64)
    @fact sinh(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact sinh(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact sinh(Interval(1.0, 0x1.2c903022dd7aap+8)) --> Interval(0x1.2cd9fc44eb982p+0, 0x1.89bca168970c6p+432)
    @fact sinh(Interval(-0x1.fd219490eaac1p+38, -0x1.1af1c9d74f06dp+9)) --> Interval(-Inf, -0x1.53045b4f849dep+815)
    @fact sinh(Interval(-0x1.199999999999ap+0, 0x1.2666666666666p+1)) --> Interval(-0x1.55ecfe1b2b215p+0, 0x1.3bf72ea61af1bp+2)
end

facts("minimal_sinh_dec_test") do

end

facts("minimal_cosh_test") do
    @fact cosh(∅) --> ∅
    @fact cosh(Interval(0.0, Inf)) --> Interval(1.0, Inf)
    @fact cosh(Interval(-0.0, Inf)) --> Interval(1.0, Inf)
    @fact cosh(Interval(-Inf, 0.0)) --> Interval(1.0, Inf)
    @fact cosh(Interval(-Inf, -0.0)) --> Interval(1.0, Inf)
    @fact cosh(entireinterval(Float64)) --> Interval(1.0, Inf)
    @fact cosh(Interval(0.0, 0.0)) --> Interval(1.0, 1.0)
    @fact cosh(Interval(-0.0, -0.0)) --> Interval(1.0, 1.0)
    @fact cosh(Interval(1.0, 0x1.2c903022dd7aap+8)) --> Interval(0x1.8b07551d9f55p+0, 0x1.89bca168970c6p+432)
    @fact cosh(Interval(-0x1.fd219490eaac1p+38, -0x1.1af1c9d74f06dp+9)) --> Interval(0x1.53045b4f849dep+815, Inf)
    @fact cosh(Interval(-0x1.199999999999ap+0, 0x1.2666666666666p+1)) --> Interval(1.0, 0x1.4261d2b7d6181p+2)
end

facts("minimal_cosh_dec_test") do

end

facts("minimal_tanh_test") do
    @fact tanh(∅) --> ∅
    @fact tanh(Interval(0.0, Inf)) --> Interval(0.0, 1.0)
    @fact tanh(Interval(-0.0, Inf)) --> Interval(0.0, 1.0)
    @fact tanh(Interval(-Inf, 0.0)) --> Interval(-1.0, 0.0)
    @fact tanh(Interval(-Inf, -0.0)) --> Interval(-1.0, 0.0)
    @fact tanh(entireinterval(Float64)) --> Interval(-1.0, 1.0)
    @fact tanh(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact tanh(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact tanh(Interval(1.0, 0x1.2c903022dd7aap+8)) --> Interval(0x1.85efab514f394p-1, 0x1p+0)
    @fact tanh(Interval(-0x1.fd219490eaac1p+38, -0x1.1af1c9d74f06dp+9)) --> Interval(-0x1p+0, -0x1.fffffffffffffp-1)
    @fact tanh(Interval(-0x1.199999999999ap+0, 0x1.2666666666666p+1)) --> Interval(-0x1.99db01fde2406p-1, 0x1.f5cf31e1c8103p-1)
end

facts("minimal_tanh_dec_test") do

end

facts("minimal_asinh_test") do
    @fact asinh(∅) --> ∅
    @fact asinh(Interval(0.0, Inf)) --> Interval(0.0, Inf)
    @fact asinh(Interval(-0.0, Inf)) --> Interval(0.0, Inf)
    @fact asinh(Interval(-Inf, 0.0)) --> Interval(-Inf, 0.0)
    @fact asinh(Interval(-Inf, -0.0)) --> Interval(-Inf, 0.0)
    @fact asinh(entireinterval(Float64)) --> entireinterval(Float64)
    @fact asinh(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact asinh(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact asinh(Interval(1.0, 0x1.2c903022dd7aap+8)) --> Interval(0x1.c34366179d426p-1, 0x1.9986127438a87p+2)
    @fact asinh(Interval(-0x1.fd219490eaac1p+38, -0x1.1af1c9d74f06dp+9)) --> Interval(-0x1.bb86380a6cc45p+4, -0x1.c204d8eb20827p+2)
    @fact asinh(Interval(-0x1.199999999999ap+0, 0x1.2666666666666p+1)) --> Interval(-0x1.e693df6edf1e7p-1, 0x1.91fdc64de0e51p+0)
end

facts("minimal_asinh_dec_test") do

end

facts("minimal_acosh_test") do
    @fact acosh(∅) --> ∅
    @fact acosh(Interval(0.0, Inf)) --> Interval(0.0, Inf)
    @fact acosh(Interval(-0.0, Inf)) --> Interval(0.0, Inf)
    @fact acosh(Interval(1.0, Inf)) --> Interval(0.0, Inf)
    @fact acosh(Interval(-Inf, 1.0)) --> Interval(0.0, 0.0)
    @fact acosh(Interval(-Inf, 0x1.fffffffffffffp-1)) --> ∅
    @fact acosh(entireinterval(Float64)) --> Interval(0.0, Inf)
    @fact acosh(Interval(1.0, 1.0)) --> Interval(0.0, 0.0)
    @fact acosh(Interval(1.0, 0x1.2c903022dd7aap+8)) --> Interval(0.0, 0x1.9985fb3d532afp+2)
    @fact acosh(Interval(0x1.199999999999ap+0, 0x1.2666666666666p+1)) --> Interval(0x1.c636c1a882f2cp-2, 0x1.799c88e79140dp+0)
    @fact acosh(Interval(0x1.14d4e82b2b26fp+15, 0x1.72dbe91c837b5p+29)) --> Interval(0x1.656510b4baec3p+3, 0x1.52a415ee8455ap+4)
end

facts("minimal_acosh_dec_test") do

end

facts("minimal_atanh_test") do
    @fact atanh(∅) --> ∅
    @fact atanh(Interval(0.0, Inf)) --> Interval(0.0, Inf)
    @fact atanh(Interval(-0.0, Inf)) --> Interval(0.0, Inf)
    @fact atanh(Interval(1.0, Inf)) --> ∅
    @fact atanh(Interval(-Inf, 0.0)) --> Interval(-Inf, 0.0)
    @fact atanh(Interval(-Inf, -0.0)) --> Interval(-Inf, 0.0)
    @fact atanh(Interval(-Inf, -1.0)) --> ∅
    @fact atanh(Interval(-1.0, 1.0)) --> entireinterval(Float64)
    @fact atanh(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact atanh(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact atanh(Interval(-1.0, -1.0)) --> ∅
    @fact atanh(Interval(1.0, 1.0)) --> ∅
    @fact atanh(entireinterval(Float64)) --> entireinterval(Float64)
    @fact atanh(Interval(0x1.4c0420f6f08ccp-2, 0x1.fffffffffffffp-1)) --> Interval(0x1.5871dd2df9102p-2, 0x1.2b708872320e2p+4)
    @fact atanh(Interval(-0x1.ffb88e9eb6307p-1, 0x1.999999999999ap-4)) --> Interval(-0x1.06a3a97d7979cp+2, 0x1.9af93cd234413p-4)
end

facts("minimal_atanh_dec_test") do

end

facts("minimal_sign_test") do
    @fact sign(∅) --> ∅
    @fact sign(Interval(1.0, 2.0)) --> Interval(1.0, 1.0)
    @fact sign(Interval(-1.0, 2.0)) --> Interval(-1.0, 1.0)
    @fact sign(Interval(-1.0, 0.0)) --> Interval(-1.0, 0.0)
    @fact sign(Interval(0.0, 2.0)) --> Interval(0.0, 1.0)
    @fact sign(Interval(-0.0, 2.0)) --> Interval(0.0, 1.0)
    @fact sign(Interval(-5.0, -2.0)) --> Interval(-1.0, -1.0)
    @fact sign(Interval(0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact sign(Interval(-0.0, -0.0)) --> Interval(0.0, 0.0)
    @fact sign(Interval(-0.0, 0.0)) --> Interval(0.0, 0.0)
    @fact sign(entireinterval(Float64)) --> Interval(-1.0, 1.0)
end

facts("minimal_sign_dec_test") do

end

facts("minimal_ceil_test") do
    @fact ceil(∅) --> ∅
    @fact round(∅, RoundUp) --> ∅
    @fact ceil(entireinterval(Float64)) --> entireinterval(Float64)
    @fact round(entireinterval(Float64), RoundUp) --> entireinterval(Float64)
    @fact ceil(Interval(1.1, 2.0)) --> Interval(2.0, 2.0)
    @fact round(Interval(1.1, 2.0), RoundUp) --> Interval(2.0, 2.0)
    @fact ceil(Interval(-1.1, 2.0)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundUp) --> Interval(-1.0, 2.0)
    @fact ceil(Interval(-1.1, 0.0)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, 0.0), RoundUp) --> Interval(-1.0, 0.0)
    @fact ceil(Interval(-1.1, -0.0)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.0), RoundUp) --> Interval(-1.0, 0.0)
    @fact ceil(Interval(-1.1, -0.4)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.4), RoundUp) --> Interval(-1.0, 0.0)
    @fact ceil(Interval(-1.9, 2.2)) --> Interval(-1.0, 3.0)
    @fact round(Interval(-1.9, 2.2), RoundUp) --> Interval(-1.0, 3.0)
    @fact ceil(Interval(-1.0, 2.2)) --> Interval(-1.0, 3.0)
    @fact round(Interval(-1.0, 2.2), RoundUp) --> Interval(-1.0, 3.0)
    @fact ceil(Interval(0.0, 2.2)) --> Interval(0.0, 3.0)
    @fact round(Interval(0.0, 2.2), RoundUp) --> Interval(0.0, 3.0)
    @fact ceil(Interval(-0.0, 2.2)) --> Interval(0.0, 3.0)
    @fact round(Interval(-0.0, 2.2), RoundUp) --> Interval(0.0, 3.0)
    @fact ceil(Interval(-1.5, Inf)) --> Interval(-1.0, Inf)
    @fact round(Interval(-1.5, Inf), RoundUp) --> Interval(-1.0, Inf)
    @fact ceil(Interval(0x1.fffffffffffffp1023, Inf)) --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact round(Interval(0x1.fffffffffffffp1023, Inf), RoundUp) --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact ceil(Interval(-Inf, 2.2)) --> Interval(-Inf, 3.0)
    @fact round(Interval(-Inf, 2.2), RoundUp) --> Interval(-Inf, 3.0)
    @fact ceil(Interval(-Inf, -0x1.fffffffffffffp1023)) --> Interval(-Inf, -0x1.fffffffffffffp1023)
    @fact round(Interval(-Inf, -0x1.fffffffffffffp1023), RoundUp) --> Interval(-Inf, -0x1.fffffffffffffp1023)
end

facts("minimal_ceil_dec_test") do

end

facts("minimal_floor_test") do
    @fact floor(∅) --> ∅
    @fact round(∅, RoundDown) --> ∅
    @fact floor(entireinterval(Float64)) --> entireinterval(Float64)
    @fact round(entireinterval(Float64), RoundDown) --> entireinterval(Float64)
    @fact floor(Interval(1.1, 2.0)) --> Interval(1.0, 2.0)
    @fact round(Interval(1.1, 2.0), RoundDown) --> Interval(1.0, 2.0)
    @fact floor(Interval(-1.1, 2.0)) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundDown) --> Interval(-2.0, 2.0)
    @fact floor(Interval(-1.1, 0.0)) --> Interval(-2.0, 0.0)
    @fact round(Interval(-1.1, 0.0), RoundDown) --> Interval(-2.0, 0.0)
    @fact floor(Interval(-1.1, -0.0)) --> Interval(-2.0, 0.0)
    @fact round(Interval(-1.1, -0.0), RoundDown) --> Interval(-2.0, 0.0)
    @fact floor(Interval(-1.1, -0.4)) --> Interval(-2.0, -1.0)
    @fact round(Interval(-1.1, -0.4), RoundDown) --> Interval(-2.0, -1.0)
    @fact floor(Interval(-1.9, 2.2)) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.9, 2.2), RoundDown) --> Interval(-2.0, 2.0)
    @fact floor(Interval(-1.0, 2.2)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.0, 2.2), RoundDown) --> Interval(-1.0, 2.0)
    @fact floor(Interval(0.0, 2.2)) --> Interval(0.0, 2.0)
    @fact round(Interval(0.0, 2.2), RoundDown) --> Interval(0.0, 2.0)
    @fact floor(Interval(-0.0, 2.2)) --> Interval(0.0, 2.0)
    @fact round(Interval(-0.0, 2.2), RoundDown) --> Interval(0.0, 2.0)
    @fact floor(Interval(-1.5, Inf)) --> Interval(-2.0, Inf)
    @fact round(Interval(-1.5, Inf), RoundDown) --> Interval(-2.0, Inf)
    @fact floor(Interval(-Inf, 2.2)) --> Interval(-Inf, 2.0)
    @fact round(Interval(-Inf, 2.2), RoundDown) --> Interval(-Inf, 2.0)
end

facts("minimal_floor_dec_test") do

end

facts("minimal_trunc_test") do
    @fact trunc(∅) --> ∅
    @fact round(∅, RoundToZero) --> ∅
    @fact trunc(entireinterval(Float64)) --> entireinterval(Float64)
    @fact round(entireinterval(Float64), RoundToZero) --> entireinterval(Float64)
    @fact trunc(Interval(1.1, 2.1)) --> Interval(1.0, 2.0)
    @fact round(Interval(1.1, 2.1), RoundToZero) --> Interval(1.0, 2.0)
    @fact trunc(Interval(-1.1, 2.0)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundToZero) --> Interval(-1.0, 2.0)
    @fact trunc(Interval(-1.1, 0.0)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, 0.0), RoundToZero) --> Interval(-1.0, 0.0)
    @fact trunc(Interval(-1.1, -0.0)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.0), RoundToZero) --> Interval(-1.0, 0.0)
    @fact trunc(Interval(-1.1, -0.4)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.4), RoundToZero) --> Interval(-1.0, 0.0)
    @fact trunc(Interval(-1.9, 2.2)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.9, 2.2), RoundToZero) --> Interval(-1.0, 2.0)
    @fact trunc(Interval(-1.0, 2.2)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.0, 2.2), RoundToZero) --> Interval(-1.0, 2.0)
    @fact trunc(Interval(0.0, 2.2)) --> Interval(0.0, 2.0)
    @fact round(Interval(0.0, 2.2), RoundToZero) --> Interval(0.0, 2.0)
    @fact trunc(Interval(-0.0, 2.2)) --> Interval(0.0, 2.0)
    @fact round(Interval(-0.0, 2.2), RoundToZero) --> Interval(0.0, 2.0)
    @fact trunc(Interval(-1.5, Inf)) --> Interval(-1.0, Inf)
    @fact round(Interval(-1.5, Inf), RoundToZero) --> Interval(-1.0, Inf)
    @fact trunc(Interval(-Inf, 2.2)) --> Interval(-Inf, 2.0)
    @fact round(Interval(-Inf, 2.2), RoundToZero) --> Interval(-Inf, 2.0)
end

facts("minimal_trunc_dec_test") do

end

facts("minimal_roundTiesToEven_test") do
    @fact round(∅) --> ∅
    @fact round(∅, RoundNearest) --> ∅
    @fact round(∅, RoundTiesToEven) --> ∅
    @fact round(entireinterval(Float64)) --> entireinterval(Float64)
    @fact round(entireinterval(Float64), RoundNearest) --> entireinterval(Float64)
    @fact round(entireinterval(Float64), RoundTiesToEven) --> entireinterval(Float64)
    @fact round(Interval(1.1, 2.1)) --> Interval(1.0, 2.0)
    @fact round(Interval(1.1, 2.1), RoundNearest) --> Interval(1.0, 2.0)
    @fact round(Interval(1.1, 2.1), RoundTiesToEven) --> Interval(1.0, 2.0)
    @fact round(Interval(-1.1, 2.0)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundNearest) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundTiesToEven) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, -0.4)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.4), RoundNearest) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.4), RoundTiesToEven) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, 0.0)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, 0.0), RoundNearest) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, 0.0), RoundTiesToEven) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.0)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.0), RoundNearest) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.0), RoundTiesToEven) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.9, 2.2)) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.9, 2.2), RoundNearest) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.9, 2.2), RoundTiesToEven) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.0, 2.2)) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.0, 2.2), RoundNearest) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.0, 2.2), RoundTiesToEven) --> Interval(-1.0, 2.0)
    @fact round(Interval(1.5, 2.1)) --> Interval(2.0, 2.0)
    @fact round(Interval(1.5, 2.1), RoundNearest) --> Interval(2.0, 2.0)
    @fact round(Interval(1.5, 2.1), RoundTiesToEven) --> Interval(2.0, 2.0)
    @fact round(Interval(-1.5, 2.0)) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.5, 2.0), RoundNearest) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.5, 2.0), RoundTiesToEven) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.1, -0.5)) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.5), RoundNearest) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.5), RoundTiesToEven) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.9, 2.5)) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.9, 2.5), RoundNearest) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.9, 2.5), RoundTiesToEven) --> Interval(-2.0, 2.0)
    @fact round(Interval(0.0, 2.5)) --> Interval(0.0, 2.0)
    @fact round(Interval(0.0, 2.5), RoundNearest) --> Interval(0.0, 2.0)
    @fact round(Interval(0.0, 2.5), RoundTiesToEven) --> Interval(0.0, 2.0)
    @fact round(Interval(-0.0, 2.5)) --> Interval(0.0, 2.0)
    @fact round(Interval(-0.0, 2.5), RoundNearest) --> Interval(0.0, 2.0)
    @fact round(Interval(-0.0, 2.5), RoundTiesToEven) --> Interval(0.0, 2.0)
    @fact round(Interval(-1.5, 2.5)) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.5, 2.5), RoundNearest) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.5, 2.5), RoundTiesToEven) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.5, Inf)) --> Interval(-2.0, Inf)
    @fact round(Interval(-1.5, Inf), RoundNearest) --> Interval(-2.0, Inf)
    @fact round(Interval(-1.5, Inf), RoundTiesToEven) --> Interval(-2.0, Inf)
    @fact round(Interval(-Inf, 2.2)) --> Interval(-Inf, 2.0)
    @fact round(Interval(-Inf, 2.2), RoundNearest) --> Interval(-Inf, 2.0)
    @fact round(Interval(-Inf, 2.2), RoundTiesToEven) --> Interval(-Inf, 2.0)
end

facts("minimal_roundTiesToEven_dec_test") do

end

facts("minimal_roundTiesToAway_test") do
    @fact round(∅, RoundNearestTiesAway) --> ∅
    @fact round(∅, RoundTiesToAway) --> ∅
    @fact round(entireinterval(Float64), RoundNearestTiesAway) --> entireinterval(Float64)
    @fact round(entireinterval(Float64), RoundTiesToAway) --> entireinterval(Float64)
    @fact round(Interval(1.1, 2.1), RoundNearestTiesAway) --> Interval(1.0, 2.0)
    @fact round(Interval(1.1, 2.1), RoundTiesToAway) --> Interval(1.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundNearestTiesAway) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, 2.0), RoundTiesToAway) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.1, 0.0), RoundNearestTiesAway) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, 0.0), RoundTiesToAway) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.0), RoundNearestTiesAway) --> Interval(-1.0, -0.0)
    @fact round(Interval(-1.1, -0.0), RoundTiesToAway) --> Interval(-1.0, -0.0)
    @fact round(Interval(-1.1, -0.4), RoundNearestTiesAway) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.1, -0.4), RoundTiesToAway) --> Interval(-1.0, 0.0)
    @fact round(Interval(-1.9, 2.2), RoundNearestTiesAway) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.9, 2.2), RoundTiesToAway) --> Interval(-2.0, 2.0)
    @fact round(Interval(-1.0, 2.2), RoundNearestTiesAway) --> Interval(-1.0, 2.0)
    @fact round(Interval(-1.0, 2.2), RoundTiesToAway) --> Interval(-1.0, 2.0)
    @fact round(Interval(0.5, 2.1), RoundNearestTiesAway) --> Interval(1.0, 2.0)
    @fact round(Interval(0.5, 2.1), RoundTiesToAway) --> Interval(1.0, 2.0)
    @fact round(Interval(-2.5, 2.0), RoundNearestTiesAway) --> Interval(-3.0, 2.0)
    @fact round(Interval(-2.5, 2.0), RoundTiesToAway) --> Interval(-3.0, 2.0)
    @fact round(Interval(-1.1, -0.5), RoundNearestTiesAway) --> Interval(-1.0, -1.0)
    @fact round(Interval(-1.1, -0.5), RoundTiesToAway) --> Interval(-1.0, -1.0)
    @fact round(Interval(-1.9, 2.5), RoundNearestTiesAway) --> Interval(-2.0, 3.0)
    @fact round(Interval(-1.9, 2.5), RoundTiesToAway) --> Interval(-2.0, 3.0)
    @fact round(Interval(-1.5, 2.5), RoundNearestTiesAway) --> Interval(-2.0, 3.0)
    @fact round(Interval(-1.5, 2.5), RoundTiesToAway) --> Interval(-2.0, 3.0)
    @fact round(Interval(0.0, 2.5), RoundNearestTiesAway) --> Interval(0.0, 3.0)
    @fact round(Interval(0.0, 2.5), RoundTiesToAway) --> Interval(0.0, 3.0)
    @fact round(Interval(-0.0, 2.5), RoundNearestTiesAway) --> Interval(0.0, 3.0)
    @fact round(Interval(-0.0, 2.5), RoundTiesToAway) --> Interval(0.0, 3.0)
    @fact round(Interval(-1.5, Inf), RoundNearestTiesAway) --> Interval(-2.0, Inf)
    @fact round(Interval(-1.5, Inf), RoundTiesToAway) --> Interval(-2.0, Inf)
    @fact round(Interval(-Inf, 2.2), RoundNearestTiesAway) --> Interval(-Inf, 2.0)
    @fact round(Interval(-Inf, 2.2), RoundTiesToAway) --> Interval(-Inf, 2.0)
end

facts("minimal_roundTiesToAway_dec_test") do

end

facts("minimal_abs_test") do
    @fact abs(∅) --> ∅
    @fact abs(entireinterval(Float64)) --> Interval(0.0, Inf)
    @fact abs(Interval(1.1, 2.1)) --> Interval(1.1, 2.1)
    @fact abs(Interval(-1.1, 2.0)) --> Interval(0.0, 2.0)
    @fact abs(Interval(-1.1, 0.0)) --> Interval(0.0, 1.1)
    @fact abs(Interval(-1.1, -0.0)) --> Interval(0.0, 1.1)
    @fact abs(Interval(-1.1, -0.4)) --> Interval(0.4, 1.1)
    @fact abs(Interval(-1.9, 0.2)) --> Interval(0.0, 1.9)
    @fact abs(Interval(0.0, 0.2)) --> Interval(0.0, 0.2)
    @fact abs(Interval(-0.0, 0.2)) --> Interval(0.0, 0.2)
    @fact abs(Interval(-1.5, Inf)) --> Interval(0.0, Inf)
    @fact abs(Interval(-Inf, -2.2)) --> Interval(2.2, Inf)
end

facts("minimal_abs_dec_test") do

end

facts("minimal_min_test") do
    @fact min(∅, Interval(1.0, 2.0)) --> ∅
    @fact min(Interval(1.0, 2.0), ∅) --> ∅
    @fact min(∅, ∅) --> ∅
    @fact min(entireinterval(Float64), Interval(1.0, 2.0)) --> Interval(-Inf, 2.0)
    @fact min(Interval(1.0, 2.0), entireinterval(Float64)) --> Interval(-Inf, 2.0)
    @fact min(entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact min(∅, entireinterval(Float64)) --> ∅
    @fact min(Interval(1.0, 5.0), Interval(2.0, 4.0)) --> Interval(1.0, 4.0)
    @fact min(Interval(0.0, 5.0), Interval(2.0, 4.0)) --> Interval(0.0, 4.0)
    @fact min(Interval(-0.0, 5.0), Interval(2.0, 4.0)) --> Interval(0.0, 4.0)
    @fact min(Interval(1.0, 5.0), Interval(2.0, 8.0)) --> Interval(1.0, 5.0)
    @fact min(Interval(1.0, 5.0), entireinterval(Float64)) --> Interval(-Inf, 5.0)
    @fact min(Interval(-7.0, -5.0), Interval(2.0, 4.0)) --> Interval(-7.0, -5.0)
    @fact min(Interval(-7.0, 0.0), Interval(2.0, 4.0)) --> Interval(-7.0, 0.0)
    @fact min(Interval(-7.0, -0.0), Interval(2.0, 4.0)) --> Interval(-7.0, 0.0)
end

facts("minimal_min_dec_test") do

end

facts("minimal_max_test") do
    @fact max(∅, Interval(1.0, 2.0)) --> ∅
    @fact max(Interval(1.0, 2.0), ∅) --> ∅
    @fact max(∅, ∅) --> ∅
    @fact max(entireinterval(Float64), Interval(1.0, 2.0)) --> Interval(1.0, Inf)
    @fact max(Interval(1.0, 2.0), entireinterval(Float64)) --> Interval(1.0, Inf)
    @fact max(entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact max(∅, entireinterval(Float64)) --> ∅
    @fact max(Interval(1.0, 5.0), Interval(2.0, 4.0)) --> Interval(2.0, 5.0)
    @fact max(Interval(1.0, 5.0), Interval(2.0, 8.0)) --> Interval(2.0, 8.0)
    @fact max(Interval(-1.0, 5.0), entireinterval(Float64)) --> Interval(-1.0, Inf)
    @fact max(Interval(-7.0, -5.0), Interval(2.0, 4.0)) --> Interval(2.0, 4.0)
    @fact max(Interval(-7.0, -5.0), Interval(0.0, 4.0)) --> Interval(0.0, 4.0)
    @fact max(Interval(-7.0, -5.0), Interval(-0.0, 4.0)) --> Interval(0.0, 4.0)
    @fact max(Interval(-7.0, -5.0), Interval(-2.0, 0.0)) --> Interval(-2.0, 0.0)
    @fact max(Interval(-7.0, -5.0), Interval(-2.0, -0.0)) --> Interval(-2.0, 0.0)
end

facts("minimal_max_dec_test") do

end
# FactCheck.exitstatus()
