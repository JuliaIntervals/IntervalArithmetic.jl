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
setprecision(Interval, Float64)
# setrounding(Interval, :narrow)

facts("minimal_isCommonInterval_test") do
    @fact iscommon(Interval(-27.0, -27.0)) --> true
    @fact iscommon(Interval(-27.0, 0.0)) --> true
    @fact iscommon(Interval(0.0, 0.0)) --> true
    @fact iscommon(Interval(-0.0, -0.0)) --> true
    @fact iscommon(Interval(-0.0, 0.0)) --> true
    @fact iscommon(Interval(0.0, -0.0)) --> true
    @fact iscommon(Interval(5.0, 12.4)) --> true
    @fact iscommon(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> true
    @fact iscommon(entireinterval(Float64)) --> false
    @fact iscommon(∅) --> false
    @fact iscommon(Interval(-Inf, 0.0)) --> false
    @fact iscommon(Interval(0.0, Inf)) --> false
end

facts("minimal_isCommonInterval_dec_test") do
    @fact iscommon(DecoratedInterval(Interval(-27.0, -27.0), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(-27.0, 0.0), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(0.0, 0.0), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(-0.0, -0.0), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(-0.0, 0.0), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(0.0, -0.0), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(5.0, 12.4), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), com)) --> true
    @fact iscommon(DecoratedInterval(Interval(-27.0, -27.0), trv)) --> true
    @fact iscommon(DecoratedInterval(Interval(-27.0, 0.0), def)) --> true
    @fact iscommon(DecoratedInterval(Interval(0.0, 0.0), dac)) --> true
    @fact iscommon(DecoratedInterval(Interval(-0.0, -0.0), trv)) --> true
    @fact iscommon(DecoratedInterval(Interval(-0.0, 0.0), def)) --> true
    @fact iscommon(DecoratedInterval(Interval(0.0, -0.0), dac)) --> true
    @fact iscommon(DecoratedInterval(Interval(5.0, 12.4), def)) --> true
    @fact iscommon(DecoratedInterval(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), trv)) --> true
    @fact iscommon(DecoratedInterval(entireinterval(Float64), dac)) --> false
    @fact iscommon(DecoratedInterval(∅, trv)) --> false
    @fact iscommon(DecoratedInterval(∅, trv)) --> false
    @fact iscommon(DecoratedInterval(Interval(-Inf, 0.0), trv)) --> false
    @fact iscommon(DecoratedInterval(Interval(0.0, Inf), def)) --> false
end

facts("minimal_isSingleton_test") do
    @fact isthin(Interval(-27.0, -27.0)) --> true
    @fact isthin(Interval(-2.0, -2.0)) --> true
    @fact isthin(Interval(12.0, 12.0)) --> true
    @fact isthin(Interval(17.1, 17.1)) --> true
    @fact isthin(Interval(-0.0, -0.0)) --> true
    @fact isthin(Interval(0.0, 0.0)) --> true
    @fact isthin(Interval(-0.0, 0.0)) --> true
    @fact isthin(Interval(0.0, -0.0)) --> true
    @fact isthin(∅) --> false
    @fact isthin(entireinterval(Float64)) --> false
    @fact isthin(Interval(-1.0, 0.0)) --> false
    @fact isthin(Interval(-1.0, -0.5)) --> false
    @fact isthin(Interval(1.0, 2.0)) --> false
    @fact isthin(Interval(-Inf, -0x1.fffffffffffffp1023)) --> false
    @fact isthin(Interval(-1.0, Inf)) --> false
end

facts("minimal_isSingleton_dec_test") do
    @fact isthin(DecoratedInterval(Interval(-27.0, -27.0), def)) --> true
    @fact isthin(DecoratedInterval(Interval(-2.0, -2.0), trv)) --> true
    @fact isthin(DecoratedInterval(Interval(12.0, 12.0), dac)) --> true
    @fact isthin(DecoratedInterval(Interval(17.1, 17.1), com)) --> true
    @fact isthin(DecoratedInterval(Interval(-0.0, -0.0), def)) --> true
    @fact isthin(DecoratedInterval(Interval(0.0, 0.0), com)) --> true
    @fact isthin(DecoratedInterval(Interval(-0.0, 0.0), def)) --> true
    @fact isthin(DecoratedInterval(Interval(0.0, -0.0), dac)) --> true
    @fact isthin(DecoratedInterval(∅, trv)) --> false
    @fact isthin(DecoratedInterval(∅, trv)) --> false
    @fact isthin(DecoratedInterval(entireinterval(Float64), def)) --> false
    @fact isthin(DecoratedInterval(Interval(-1.0, 0.0), dac)) --> false
    @fact isthin(DecoratedInterval(Interval(-1.0, -0.5), com)) --> false
    @fact isthin(DecoratedInterval(Interval(1.0, 2.0), def)) --> false
    @fact isthin(DecoratedInterval(Interval(-Inf, -0x1.fffffffffffffp1023), dac)) --> false
    @fact isthin(DecoratedInterval(Interval(-1.0, Inf), trv)) --> false
end

facts("minimal_isMember_test") do
    @fact -27.0 ∈ Interval(-27.0, -27.0) --> true
    @fact in(-27.0, Interval(-27.0, -27.0)) --> true
    @fact -27.0 ∈ Interval(-27.0, 0.0) --> true
    @fact in(-27.0, Interval(-27.0, 0.0)) --> true
    @fact -7.0 ∈ Interval(-27.0, 0.0) --> true
    @fact in(-7.0, Interval(-27.0, 0.0)) --> true
    @fact 0.0 ∈ Interval(-27.0, 0.0) --> true
    @fact in(0.0, Interval(-27.0, 0.0)) --> true
    @fact -0.0 ∈ Interval(0.0, 0.0) --> true
    @fact in(-0.0, Interval(0.0, 0.0)) --> true
    @fact 0.0 ∈ Interval(0.0, 0.0) --> true
    @fact in(0.0, Interval(0.0, 0.0)) --> true
    @fact 0.0 ∈ Interval(-0.0, -0.0) --> true
    @fact in(0.0, Interval(-0.0, -0.0)) --> true
    @fact 0.0 ∈ Interval(-0.0, 0.0) --> true
    @fact in(0.0, Interval(-0.0, 0.0)) --> true
    @fact 0.0 ∈ Interval(0.0, -0.0) --> true
    @fact in(0.0, Interval(0.0, -0.0)) --> true
    @fact 5.0 ∈ Interval(5.0, 12.4) --> true
    @fact in(5.0, Interval(5.0, 12.4)) --> true
    @fact 6.3 ∈ Interval(5.0, 12.4) --> true
    @fact in(6.3, Interval(5.0, 12.4)) --> true
    @fact 12.4 ∈ Interval(5.0, 12.4) --> true
    @fact in(12.4, Interval(5.0, 12.4)) --> true
    @fact 0.0 ∈ entireinterval(Float64) --> true
    @fact in(0.0, entireinterval(Float64)) --> true
    @fact 5.0 ∈ entireinterval(Float64) --> true
    @fact in(5.0, entireinterval(Float64)) --> true
    @fact 6.3 ∈ entireinterval(Float64) --> true
    @fact in(6.3, entireinterval(Float64)) --> true
    @fact 12.4 ∈ entireinterval(Float64) --> true
    @fact in(12.4, entireinterval(Float64)) --> true
    @fact -71.0 ∈ Interval(-27.0, 0.0) --> false
    @fact in(-71.0, Interval(-27.0, 0.0)) --> false
    @fact 0.1 ∈ Interval(-27.0, 0.0) --> false
    @fact in(0.1, Interval(-27.0, 0.0)) --> false
    @fact -0.01 ∈ Interval(0.0, 0.0) --> false
    @fact in(-0.01, Interval(0.0, 0.0)) --> false
    @fact 0.000001 ∈ Interval(0.0, 0.0) --> false
    @fact in(0.000001, Interval(0.0, 0.0)) --> false
    @fact 111110.0 ∈ Interval(-0.0, -0.0) --> false
    @fact in(111110.0, Interval(-0.0, -0.0)) --> false
    @fact 4.9 ∈ Interval(5.0, 12.4) --> false
    @fact in(4.9, Interval(5.0, 12.4)) --> false
    @fact -6.3 ∈ Interval(5.0, 12.4) --> false
    @fact in(-6.3, Interval(5.0, 12.4)) --> false
    @fact 0.0 ∈ ∅ --> false
    @fact in(0.0, ∅) --> false
    @fact -4535.3 ∈ ∅ --> false
    @fact in(-4535.3, ∅) --> false
    @fact -Inf ∈ ∅ --> false
    @fact in(-Inf, ∅) --> false
    @fact Inf ∈ ∅ --> false
    @fact in(Inf, ∅) --> false
    @fact -Inf ∈ entireinterval(Float64) --> false
    @fact in(-Inf, entireinterval(Float64)) --> false
    @fact Inf ∈ entireinterval(Float64) --> false
    @fact in(Inf, entireinterval(Float64)) --> false
end

facts("minimal_isMember_dec_test") do
    @fact -27.0 ∈ DecoratedInterval(Interval(-27.0, -27.0), trv) --> true
    @fact in(-27.0, DecoratedInterval(Interval(-27.0, -27.0), trv)) --> true
    @fact -27.0 ∈ DecoratedInterval(Interval(-27.0, 0.0), def) --> true
    @fact in(-27.0, DecoratedInterval(Interval(-27.0, 0.0), def)) --> true
    @fact -7.0 ∈ DecoratedInterval(Interval(-27.0, 0.0), dac) --> true
    @fact in(-7.0, DecoratedInterval(Interval(-27.0, 0.0), dac)) --> true
    @fact 0.0 ∈ DecoratedInterval(Interval(-27.0, 0.0), com) --> true
    @fact in(0.0, DecoratedInterval(Interval(-27.0, 0.0), com)) --> true
    @fact -0.0 ∈ DecoratedInterval(Interval(0.0, 0.0), trv) --> true
    @fact in(-0.0, DecoratedInterval(Interval(0.0, 0.0), trv)) --> true
    @fact 0.0 ∈ DecoratedInterval(Interval(0.0, 0.0), def) --> true
    @fact in(0.0, DecoratedInterval(Interval(0.0, 0.0), def)) --> true
    @fact 0.0 ∈ DecoratedInterval(Interval(-0.0, -0.0), dac) --> true
    @fact in(0.0, DecoratedInterval(Interval(-0.0, -0.0), dac)) --> true
    @fact 0.0 ∈ DecoratedInterval(Interval(-0.0, 0.0), com) --> true
    @fact in(0.0, DecoratedInterval(Interval(-0.0, 0.0), com)) --> true
    @fact 0.0 ∈ DecoratedInterval(Interval(0.0, -0.0), trv) --> true
    @fact in(0.0, DecoratedInterval(Interval(0.0, -0.0), trv)) --> true
    @fact 5.0 ∈ DecoratedInterval(Interval(5.0, 12.4), def) --> true
    @fact in(5.0, DecoratedInterval(Interval(5.0, 12.4), def)) --> true
    @fact 6.3 ∈ DecoratedInterval(Interval(5.0, 12.4), dac) --> true
    @fact in(6.3, DecoratedInterval(Interval(5.0, 12.4), dac)) --> true
    @fact 12.4 ∈ DecoratedInterval(Interval(5.0, 12.4), com) --> true
    @fact in(12.4, DecoratedInterval(Interval(5.0, 12.4), com)) --> true
    @fact 0.0 ∈ DecoratedInterval(entireinterval(Float64), trv) --> true
    @fact in(0.0, DecoratedInterval(entireinterval(Float64), trv)) --> true
    @fact 5.0 ∈ DecoratedInterval(entireinterval(Float64), def) --> true
    @fact in(5.0, DecoratedInterval(entireinterval(Float64), def)) --> true
    @fact 6.3 ∈ DecoratedInterval(entireinterval(Float64), dac) --> true
    @fact in(6.3, DecoratedInterval(entireinterval(Float64), dac)) --> true
    @fact 12.4 ∈ DecoratedInterval(entireinterval(Float64), trv) --> true
    @fact in(12.4, DecoratedInterval(entireinterval(Float64), trv)) --> true
    @fact -71.0 ∈ DecoratedInterval(Interval(-27.0, 0.0), trv) --> false
    @fact in(-71.0, DecoratedInterval(Interval(-27.0, 0.0), trv)) --> false
    @fact 0.1 ∈ DecoratedInterval(Interval(-27.0, 0.0), def) --> false
    @fact in(0.1, DecoratedInterval(Interval(-27.0, 0.0), def)) --> false
    @fact -0.01 ∈ DecoratedInterval(Interval(0.0, 0.0), dac) --> false
    @fact in(-0.01, DecoratedInterval(Interval(0.0, 0.0), dac)) --> false
    @fact 0.000001 ∈ DecoratedInterval(Interval(0.0, 0.0), com) --> false
    @fact in(0.000001, DecoratedInterval(Interval(0.0, 0.0), com)) --> false
    @fact 111110.0 ∈ DecoratedInterval(Interval(-0.0, -0.0), trv) --> false
    @fact in(111110.0, DecoratedInterval(Interval(-0.0, -0.0), trv)) --> false
    @fact 4.9 ∈ DecoratedInterval(Interval(5.0, 12.4), def) --> false
    @fact in(4.9, DecoratedInterval(Interval(5.0, 12.4), def)) --> false
    @fact -6.3 ∈ DecoratedInterval(Interval(5.0, 12.4), dac) --> false
    @fact in(-6.3, DecoratedInterval(Interval(5.0, 12.4), dac)) --> false
    @fact 0.0 ∈ DecoratedInterval(∅, trv) --> false
    @fact in(0.0, DecoratedInterval(∅, trv)) --> false
    @fact 0.0 ∈ DecoratedInterval(∅, trv) --> false
    @fact in(0.0, DecoratedInterval(∅, trv)) --> false
    @fact -4535.3 ∈ DecoratedInterval(∅, trv) --> false
    @fact in(-4535.3, DecoratedInterval(∅, trv)) --> false
    @fact -4535.3 ∈ DecoratedInterval(∅, trv) --> false
    @fact in(-4535.3, DecoratedInterval(∅, trv)) --> false
    @fact -Inf ∈ DecoratedInterval(∅, trv) --> false
    @fact in(-Inf, DecoratedInterval(∅, trv)) --> false
    @fact -Inf ∈ DecoratedInterval(∅, trv) --> false
    @fact in(-Inf, DecoratedInterval(∅, trv)) --> false
    @fact Inf ∈ DecoratedInterval(∅, trv) --> false
    @fact in(Inf, DecoratedInterval(∅, trv)) --> false
    @fact Inf ∈ DecoratedInterval(∅, trv) --> false
    @fact in(Inf, DecoratedInterval(∅, trv)) --> false
    @fact -Inf ∈ DecoratedInterval(entireinterval(Float64), trv) --> false
    @fact in(-Inf, DecoratedInterval(entireinterval(Float64), trv)) --> false
    @fact Inf ∈ DecoratedInterval(entireinterval(Float64), def) --> false
    @fact in(Inf, DecoratedInterval(entireinterval(Float64), def)) --> false
end
# FactCheck.exitstatus()
