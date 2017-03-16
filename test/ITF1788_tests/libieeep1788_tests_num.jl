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

facts("minimal_inf_test") do
    @fact infimum(∅) --> Inf
    @fact infimum(Interval(-Inf, Inf)) --> -Inf
    @fact infimum(Interval(1.0, 2.0)) --> 1.0
    @fact infimum(Interval(-3.0, -2.0)) --> -3.0
    @fact infimum(Interval(-Inf, 2.0)) --> -Inf
    @fact infimum(Interval(-Inf, 0.0)) --> -Inf
    @fact infimum(Interval(-Inf, -0.0)) --> -Inf
    @fact infimum(Interval(-2.0, Inf)) --> -2.0
    @fact infimum(Interval(0.0, Inf)) --> -0.0
    @fact infimum(Interval(-0.0, Inf)) --> -0.0
    @fact infimum(Interval(-0.0, 0.0)) --> -0.0
    @fact infimum(Interval(0.0, -0.0)) --> -0.0
    @fact infimum(Interval(0.0, 0.0)) --> -0.0
    @fact infimum(Interval(-0.0, -0.0)) --> -0.0
end

facts("minimal_inf_dec_test") do
    @fact infimum(DecoratedInterval(∅, trv)) --> Inf
    @fact infimum(DecoratedInterval(Interval(-Inf, Inf), def)) --> -Inf
    @fact infimum(DecoratedInterval(Interval(1.0, 2.0), com)) --> 1.0
    @fact infimum(DecoratedInterval(Interval(-3.0, -2.0), trv)) --> -3.0
    @fact infimum(DecoratedInterval(Interval(-Inf, 2.0), dac)) --> -Inf
    @fact infimum(DecoratedInterval(Interval(-Inf, 0.0), def)) --> -Inf
    @fact infimum(DecoratedInterval(Interval(-Inf, -0.0), trv)) --> -Inf
    @fact infimum(DecoratedInterval(Interval(-2.0, Inf), trv)) --> -2.0
    @fact infimum(DecoratedInterval(Interval(0.0, Inf), def)) --> -0.0
    @fact infimum(DecoratedInterval(Interval(-0.0, Inf), trv)) --> -0.0
    @fact infimum(DecoratedInterval(Interval(-0.0, 0.0), dac)) --> -0.0
    @fact infimum(DecoratedInterval(Interval(0.0, -0.0), trv)) --> -0.0
    @fact infimum(DecoratedInterval(Interval(0.0, 0.0), trv)) --> -0.0
    @fact infimum(DecoratedInterval(Interval(-0.0, -0.0), trv)) --> -0.0
end

facts("minimal_sup_test") do
    @fact supremum(∅) --> -Inf
    @fact supremum(Interval(-Inf, Inf)) --> Inf
    @fact supremum(Interval(1.0, 2.0)) --> 2.0
    @fact supremum(Interval(-3.0, -2.0)) --> -2.0
    @fact supremum(Interval(-Inf, 2.0)) --> 2.0
    @fact supremum(Interval(-Inf, 0.0)) --> 0.0
    @fact supremum(Interval(-Inf, -0.0)) --> 0.0
    @fact supremum(Interval(-2.0, Inf)) --> Inf
    @fact supremum(Interval(0.0, Inf)) --> Inf
    @fact supremum(Interval(-0.0, Inf)) --> Inf
    @fact supremum(Interval(-0.0, 0.0)) --> 0.0
    @fact supremum(Interval(0.0, -0.0)) --> 0.0
    @fact supremum(Interval(0.0, 0.0)) --> 0.0
    @fact supremum(Interval(-0.0, -0.0)) --> 0.0
end

facts("minimal_sup_dec_test") do
    @fact supremum(DecoratedInterval(∅, trv)) --> -Inf
    @fact supremum(DecoratedInterval(Interval(-Inf, Inf), def)) --> Inf
    @fact supremum(DecoratedInterval(Interval(1.0, 2.0), com)) --> 2.0
    @fact supremum(DecoratedInterval(Interval(-3.0, -2.0), trv)) --> -2.0
    @fact supremum(DecoratedInterval(Interval(-Inf, 2.0), dac)) --> 2.0
    @fact supremum(DecoratedInterval(Interval(-Inf, 0.0), def)) --> 0.0
    @fact supremum(DecoratedInterval(Interval(-Inf, -0.0), trv)) --> 0.0
    @fact supremum(DecoratedInterval(Interval(-2.0, Inf), trv)) --> Inf
    @fact supremum(DecoratedInterval(Interval(0.0, Inf), def)) --> Inf
    @fact supremum(DecoratedInterval(Interval(-0.0, Inf), trv)) --> Inf
    @fact supremum(DecoratedInterval(Interval(-0.0, 0.0), dac)) --> +0.0
    @fact supremum(DecoratedInterval(Interval(0.0, -0.0), trv)) --> +0.0
    @fact supremum(DecoratedInterval(Interval(0.0, 0.0), trv)) --> +0.0
    @fact supremum(DecoratedInterval(Interval(-0.0, -0.0), trv)) --> +0.0
end

facts("minimal_mid_test") do
    @fact mid(Interval(-Inf, Inf)) --> 0.0
    @fact mid(Interval(-0x1.fffffffffffffp1023, +0x1.fffffffffffffp1023)) --> 0.0
    @fact mid(Interval(0.0, 2.0)) --> 1.0
    @fact mid(Interval(2.0, 2.0)) --> 2.0
    @fact mid(Interval(-2.0, 2.0)) --> 0.0
    @fact mid(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022)) --> 0.0
    @fact mid(Interval(-0x0.0000000000001p-1022, 0x0.0000000000002p-1022)) --> 0.0
end

facts("minimal_mid_dec_test") do
    @fact mid(DecoratedInterval(Interval(-Inf, Inf), def)) --> 0.0
    @fact mid(DecoratedInterval(Interval(-0x1.fffffffffffffp1023, +0x1.fffffffffffffp1023), trv)) --> 0.0
    @fact mid(DecoratedInterval(Interval(0.0, 2.0), com)) --> 1.0
    @fact mid(DecoratedInterval(Interval(2.0, 2.0), dac)) --> 2.0
    @fact mid(DecoratedInterval(Interval(-2.0, 2.0), trv)) --> 0.0
    @fact mid(DecoratedInterval(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022), trv)) --> 0.0
    @fact mid(DecoratedInterval(Interval(-0x0.0000000000001p-1022, 0x0.0000000000002p-1022), trv)) --> 0.0
end

facts("minimal_rad_test") do
    @fact radius(Interval(0.0, 2.0)) --> 1.0
    @fact radius(Interval(2.0, 2.0)) --> 0.0
    @fact radius(Interval(-Inf, Inf)) --> Inf
    @fact radius(Interval(0.0, Inf)) --> Inf
    @fact radius(Interval(-Inf, 1.2)) --> Inf
end

facts("minimal_rad_dec_test") do
    @fact radius(DecoratedInterval(Interval(0.0, 2.0), trv)) --> 1.0
    @fact radius(DecoratedInterval(Interval(2.0, 2.0), com)) --> 0.0
    @fact radius(DecoratedInterval(Interval(-Inf, Inf), trv)) --> Inf
    @fact radius(DecoratedInterval(Interval(0.0, Inf), def)) --> Inf
    @fact radius(DecoratedInterval(Interval(-Inf, 1.2), trv)) --> Inf
end

facts("minimal_wid_test") do
    @fact diam(Interval(2.0, 2.0)) --> 0.0
    @fact diam(Interval(1.0, 2.0)) --> 1.0
    @fact diam(Interval(1.0, Inf)) --> Inf
    @fact diam(Interval(-Inf, 2.0)) --> Inf
    @fact diam(Interval(-Inf, Inf)) --> Inf
end

facts("minimal_wid_dec_test") do
    @fact diam(DecoratedInterval(Interval(2.0, 2.0), com)) --> 0.0
    @fact diam(DecoratedInterval(Interval(1.0, 2.0), trv)) --> 1.0
    @fact diam(DecoratedInterval(Interval(1.0, Inf), trv)) --> Inf
    @fact diam(DecoratedInterval(Interval(-Inf, 2.0), def)) --> Inf
    @fact diam(DecoratedInterval(Interval(-Inf, Inf), trv)) --> Inf
end

facts("minimal_mag_test") do
    @fact mag(Interval(1.0, 2.0)) --> 2.0
    @fact mag(Interval(-4.0, 2.0)) --> 4.0
    @fact mag(Interval(-Inf, 2.0)) --> Inf
    @fact mag(Interval(1.0, Inf)) --> Inf
    @fact mag(Interval(-Inf, Inf)) --> Inf
    @fact mag(Interval(-0.0, 0.0)) --> 0.0
    @fact mag(Interval(-0.0, -0.0)) --> 0.0
end

facts("minimal_mag_dec_test") do
    @fact mag(DecoratedInterval(Interval(1.0, 2.0), com)) --> 2.0
    @fact mag(DecoratedInterval(Interval(-4.0, 2.0), trv)) --> 4.0
    @fact mag(DecoratedInterval(Interval(-Inf, 2.0), trv)) --> Inf
    @fact mag(DecoratedInterval(Interval(1.0, Inf), def)) --> Inf
    @fact mag(DecoratedInterval(Interval(-Inf, Inf), trv)) --> Inf
    @fact mag(DecoratedInterval(Interval(-0.0, 0.0), trv)) --> 0.0
    @fact mag(DecoratedInterval(Interval(-0.0, -0.0), trv)) --> 0.0
end

facts("minimal_mig_test") do
    @fact mig(Interval(1.0, 2.0)) --> 1.0
    @fact mig(Interval(-4.0, 2.0)) --> 0.0
    @fact mig(Interval(-4.0, -2.0)) --> 2.0
    @fact mig(Interval(-Inf, 2.0)) --> 0.0
    @fact mig(Interval(-Inf, -2.0)) --> 2.0
    @fact mig(Interval(-1.0, Inf)) --> 0.0
    @fact mig(Interval(1.0, Inf)) --> 1.0
    @fact mig(Interval(-Inf, Inf)) --> 0.0
    @fact mig(Interval(-0.0, 0.0)) --> 0.0
    @fact mig(Interval(-0.0, -0.0)) --> 0.0
end

facts("minimal_mig_dec_test") do
    @fact mig(DecoratedInterval(Interval(1.0, 2.0), com)) --> 1.0
    @fact mig(DecoratedInterval(Interval(-4.0, 2.0), trv)) --> 0.0
    @fact mig(DecoratedInterval(Interval(-4.0, -2.0), trv)) --> 2.0
    @fact mig(DecoratedInterval(Interval(-Inf, 2.0), def)) --> 0.0
    @fact mig(DecoratedInterval(Interval(-Inf, -2.0), trv)) --> 2.0
    @fact mig(DecoratedInterval(Interval(-1.0, Inf), trv)) --> 0.0
    @fact mig(DecoratedInterval(Interval(1.0, Inf), trv)) --> 1.0
    @fact mig(DecoratedInterval(Interval(-Inf, Inf), trv)) --> 0.0
    @fact mig(DecoratedInterval(Interval(-0.0, 0.0), trv)) --> 0.0
    @fact mig(DecoratedInterval(Interval(-0.0, -0.0), trv)) --> 0.0
end
# FactCheck.exitstatus()
