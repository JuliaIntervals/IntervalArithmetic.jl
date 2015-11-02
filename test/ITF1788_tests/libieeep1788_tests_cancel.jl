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
set_bigfloat_precision(53)
set_interval_precision(Float64)
set_interval_rounding(:narrow)

facts("minimal_cancelPlus_test") do
    @fact cancelplus(Interval(-Inf, -1.0), ∅) --> entireinterval(Float64)
    @fact cancelplus(Interval(-1.0, Inf), ∅) --> entireinterval(Float64)
    @fact cancelplus(entireinterval(Float64), ∅) --> entireinterval(Float64)
    @fact cancelplus(Interval(-Inf, -1.0), Interval(-5.0, 1.0)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-1.0, Inf), Interval(-5.0, 1.0)) --> entireinterval(Float64)
    @fact cancelplus(entireinterval(Float64), Interval(-5.0, 1.0)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelplus(∅, Interval(1.0, Inf)) --> entireinterval(Float64)
    @fact cancelplus(∅, Interval(-Inf, 1.0)) --> entireinterval(Float64)
    @fact cancelplus(∅, entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-1.0, 5.0), Interval(1.0, Inf)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-1.0, 5.0), Interval(-Inf, 1.0)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-1.0, 5.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelplus(entireinterval(Float64), Interval(1.0, Inf)) --> entireinterval(Float64)
    @fact cancelplus(entireinterval(Float64), Interval(-Inf, 1.0)) --> entireinterval(Float64)
    @fact cancelplus(entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-5.0, -1.0), Interval(1.0, 5.1)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-5.0, -1.0), Interval(0.9, 5.0)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-5.0, -1.0), Interval(0.9, 5.1)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-10.0, 5.0), Interval(-5.0, 10.1)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-10.0, 5.0), Interval(-5.1, 10.0)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-10.0, 5.0), Interval(-5.1, 10.1)) --> entireinterval(Float64)
    @fact cancelplus(Interval(1.0, 5.0), Interval(-5.0, -0.9)) --> entireinterval(Float64)
    @fact cancelplus(Interval(1.0, 5.0), Interval(-5.1, -1.0)) --> entireinterval(Float64)
    @fact cancelplus(Interval(1.0, 5.0), Interval(-5.1, -0.9)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-10.0, -1.0), ∅) --> entireinterval(Float64)
    @fact cancelplus(Interval(-10.0, 5.0), ∅) --> entireinterval(Float64)
    @fact cancelplus(Interval(1.0, 5.0), ∅) --> entireinterval(Float64)
    @fact cancelplus(∅, ∅) --> ∅
    @fact cancelplus(∅, Interval(1.0, 10.0)) --> ∅
    @fact cancelplus(∅, Interval(-5.0, 10.0)) --> ∅
    @fact cancelplus(∅, Interval(-5.0, -1.0)) --> ∅
    @fact cancelplus(Interval(-5.1, -0.0), Interval(0.0, 5.0)) --> Interval(-0x1.999999999998p-4, 0.0)
    @fact cancelplus(Interval(-5.1, -1.0), Interval(1.0, 5.0)) --> Interval(-0x1.999999999998p-4, 0.0)
    @fact cancelplus(Interval(-5.0, -0.9), Interval(1.0, 5.0)) --> Interval(0.0, 0x1.9999999999998p-4)
    @fact cancelplus(Interval(-5.1, -0.9), Interval(1.0, 5.0)) --> Interval(-0x1.999999999998p-4, 0x1.9999999999998p-4)
    @fact cancelplus(Interval(-5.0, -1.0), Interval(1.0, 5.0)) --> Interval(0.0, 0.0)
    @fact cancelplus(Interval(-10.1, 5.0), Interval(-5.0, 10.0)) --> Interval(-0x1.999999999998p-4, 0.0)
    @fact cancelplus(Interval(-10.0, 5.1), Interval(-5.0, 10.0)) --> Interval(0.0, 0x1.999999999998p-4)
    @fact cancelplus(Interval(-10.1, 5.1), Interval(-5.0, 10.0)) --> Interval(-0x1.999999999998p-4, 0x1.999999999998p-4)
    @fact cancelplus(Interval(-10.0, 5.0), Interval(-5.0, 10.0)) --> Interval(0.0, 0.0)
    @fact cancelplus(Interval(0.9, 5.0), Interval(-5.0, -1.0)) --> Interval(-0x1.9999999999998p-4, 0.0)
    @fact cancelplus(Interval(1.0, 5.1), Interval(-5.0, -1.0)) --> Interval(0.0, 0x1.999999999998p-4)
    @fact cancelplus(Interval(0.0, 5.1), Interval(-5.0, -0.0)) --> Interval(0.0, 0x1.999999999998p-4)
    @fact cancelplus(Interval(0.9, 5.1), Interval(-5.0, -1.0)) --> Interval(-0x1.9999999999998p-4, 0x1.999999999998p-4)
    @fact cancelplus(Interval(1.0, 5.0), Interval(-5.0, -1.0)) --> Interval(0.0, 0.0)
    @fact cancelplus(Interval(0.0, 5.0), Interval(-5.0, -0.0)) --> Interval(0.0, 0.0)
    @fact cancelplus(Interval(0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0), Interval(-0x1.999999999999ap-4, -0x1.999999999999ap-4)) --> Interval(0x1.e666666666656p+0, 0x1.e666666666657p+0)
    @fact cancelplus(Interval(-0x1.999999999999ap-4, 0x1.ffffffffffffp+0), Interval(-0x1.999999999999ap-4, 0.01)) --> Interval(-0x1.70a3d70a3d70bp-4, 0x1.e666666666657p+0)
    @fact cancelplus(Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact cancelplus(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> Interval(0.0, 0.0)
    @fact cancelplus(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.ffffffffffffep+1023, 0x1.fffffffffffffp1023)) --> Interval(0.0, 0x1p+971)
    @fact cancelplus(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, 0x1.ffffffffffffep+1023)) --> Interval(-0x1p+971, 0.0)
    @fact cancelplus(Interval(-0x1.fffffffffffffp1023, 0x1.ffffffffffffep+1023), Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-0x1.ffffffffffffep+1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> entireinterval(Float64)
    @fact cancelplus(Interval(-0x1p+0, 0x1.fffffffffffffp-53), Interval(-0x1p+0, 0x1.ffffffffffffep-53)) --> Interval(-0x1.fffffffffffffp-1, -0x1.ffffffffffffep-1)
    @fact cancelplus(Interval(-0x1p+0, 0x1.ffffffffffffep-53), Interval(-0x1p+0, 0x1.fffffffffffffp-53)) --> entireinterval(Float64)
end

facts("minimal_cancelPlus_dec_test") do

end

facts("minimal_cancelMinus_test") do
    @fact cancelminus(Interval(-Inf, -1.0), ∅) --> entireinterval(Float64)
    @fact cancelminus(Interval(-1.0, Inf), ∅) --> entireinterval(Float64)
    @fact cancelminus(entireinterval(Float64), ∅) --> entireinterval(Float64)
    @fact cancelminus(Interval(-Inf, -1.0), Interval(-1.0, 5.0)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-1.0, Inf), Interval(-1.0, 5.0)) --> entireinterval(Float64)
    @fact cancelminus(entireinterval(Float64), Interval(-1.0, 5.0)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-Inf, -1.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-1.0, Inf), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelminus(∅, Interval(-Inf, -1.0)) --> entireinterval(Float64)
    @fact cancelminus(∅, Interval(-1.0, Inf)) --> entireinterval(Float64)
    @fact cancelminus(∅, entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-1.0, 5.0), Interval(-Inf, -1.0)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-1.0, 5.0), Interval(-1.0, Inf)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-1.0, 5.0), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelminus(entireinterval(Float64), Interval(-Inf, -1.0)) --> entireinterval(Float64)
    @fact cancelminus(entireinterval(Float64), Interval(-1.0, Inf)) --> entireinterval(Float64)
    @fact cancelminus(entireinterval(Float64), entireinterval(Float64)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-5.0, -1.0), Interval(-5.1, -1.0)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-5.0, -1.0), Interval(-5.0, -0.9)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-5.0, -1.0), Interval(-5.1, -0.9)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-10.0, 5.0), Interval(-10.1, 5.0)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-10.0, 5.0), Interval(-10.0, 5.1)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-10.0, 5.0), Interval(-10.1, 5.1)) --> entireinterval(Float64)
    @fact cancelminus(Interval(1.0, 5.0), Interval(0.9, 5.0)) --> entireinterval(Float64)
    @fact cancelminus(Interval(1.0, 5.0), Interval(1.0, 5.1)) --> entireinterval(Float64)
    @fact cancelminus(Interval(1.0, 5.0), Interval(0.9, 5.1)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-10.0, -1.0), ∅) --> entireinterval(Float64)
    @fact cancelminus(Interval(-10.0, 5.0), ∅) --> entireinterval(Float64)
    @fact cancelminus(Interval(1.0, 5.0), ∅) --> entireinterval(Float64)
    @fact cancelminus(∅, ∅) --> ∅
    @fact cancelminus(∅, Interval(-10.0, -1.0)) --> ∅
    @fact cancelminus(∅, Interval(-10.0, 5.0)) --> ∅
    @fact cancelminus(∅, Interval(1.0, 5.0)) --> ∅
    @fact cancelminus(Interval(-5.1, -0.0), Interval(-5.0, 0.0)) --> Interval(-0x1.999999999998p-4, 0.0)
    @fact cancelminus(Interval(-5.1, -1.0), Interval(-5.0, -1.0)) --> Interval(-0x1.999999999998p-4, 0.0)
    @fact cancelminus(Interval(-5.0, -0.9), Interval(-5.0, -1.0)) --> Interval(0.0, 0x1.9999999999998p-4)
    @fact cancelminus(Interval(-5.1, -0.9), Interval(-5.0, -1.0)) --> Interval(-0x1.999999999998p-4, 0x1.9999999999998p-4)
    @fact cancelminus(Interval(-5.0, -1.0), Interval(-5.0, -1.0)) --> Interval(0.0, 0.0)
    @fact cancelminus(Interval(-10.1, 5.0), Interval(-10.0, 5.0)) --> Interval(-0x1.999999999998p-4, 0.0)
    @fact cancelminus(Interval(-10.0, 5.1), Interval(-10.0, 5.0)) --> Interval(0.0, 0x1.999999999998p-4)
    @fact cancelminus(Interval(-10.1, 5.1), Interval(-10.0, 5.0)) --> Interval(-0x1.999999999998p-4, 0x1.999999999998p-4)
    @fact cancelminus(Interval(-10.0, 5.0), Interval(-10.0, 5.0)) --> Interval(0.0, 0.0)
    @fact cancelminus(Interval(0.9, 5.0), Interval(1.0, 5.0)) --> Interval(-0x1.9999999999998p-4, 0.0)
    @fact cancelminus(Interval(-0.0, 5.1), Interval(0.0, 5.0)) --> Interval(0.0, 0x1.999999999998p-4)
    @fact cancelminus(Interval(1.0, 5.1), Interval(1.0, 5.0)) --> Interval(0.0, 0x1.999999999998p-4)
    @fact cancelminus(Interval(0.9, 5.1), Interval(1.0, 5.0)) --> Interval(-0x1.9999999999998p-4, 0x1.999999999998p-4)
    @fact cancelminus(Interval(1.0, 5.0), Interval(1.0, 5.0)) --> Interval(0.0, 0.0)
    @fact cancelminus(Interval(-5.0, 1.0), Interval(-1.0, 5.0)) --> Interval(-4.0, -4.0)
    @fact cancelminus(Interval(-5.0, 0.0), Interval(-0.0, 5.0)) --> Interval(-5.0, -5.0)
    @fact cancelminus(Interval(0x1.ffffffffffffp+0, 0x1.ffffffffffffp+0), Interval(0x1.999999999999ap-4, 0x1.999999999999ap-4)) --> Interval(0x1.e666666666656p+0, 0x1.e666666666657p+0)
    @fact cancelminus(Interval(-0x1.999999999999ap-4, 0x1.ffffffffffffp+0), Interval(-0.01, 0x1.999999999999ap-4)) --> Interval(-0x1.70a3d70a3d70bp-4, 0x1.e666666666657p+0)
    @fact cancelminus(Interval(0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, -0x1.fffffffffffffp1023)) --> Interval(0x1.fffffffffffffp1023, Inf)
    @fact cancelminus(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> Interval(0.0, 0.0)
    @fact cancelminus(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, 0x1.ffffffffffffep+1023)) --> Interval(0.0, 0x1p+971)
    @fact cancelminus(Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023), Interval(-0x1.ffffffffffffep+1023, 0x1.fffffffffffffp1023)) --> Interval(-0x1p+971, 0.0)
    @fact cancelminus(Interval(-0x1.fffffffffffffp1023, 0x1.ffffffffffffep+1023), Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-0x1.ffffffffffffep+1023, 0x1.fffffffffffffp1023), Interval(-0x1.fffffffffffffp1023, 0x1.fffffffffffffp1023)) --> entireinterval(Float64)
    @fact cancelminus(Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022), Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022)) --> Interval(0.0, 0.0)
    @fact cancelminus(Interval(0x0.0000000000001p-1022, 0x0.0000000000001p-1022), Interval(-0x0.0000000000001p-1022, -0x0.0000000000001p-1022)) --> Interval(0x0.0000000000002p-1022, 0x0.0000000000002p-1022)
    @fact cancelminus(Interval(0x1p-1022, 0x1.0000000000002p-1022), Interval(0x1p-1022, 0x1.0000000000001p-1022)) --> Interval(0.0, 0x0.0000000000001p-1022)
    @fact cancelminus(Interval(0x1p-1022, 0x1.0000000000001p-1022), Interval(0x1p-1022, 0x1.0000000000002p-1022)) --> entireinterval(Float64)
    @fact cancelminus(Interval(-0x1p+0, 0x1.fffffffffffffp-53), Interval(-0x1.ffffffffffffep-53, 0x1p+0)) --> Interval(-0x1.fffffffffffffp-1, -0x1.ffffffffffffep-1)
    @fact cancelminus(Interval(-0x1p+0, 0x1.ffffffffffffep-53), Interval(-0x1.fffffffffffffp-53, 0x1p+0)) --> entireinterval(Float64)
end

facts("minimal_cancelMinus_dec_test") do

end
# FactCheck.exitstatus()
