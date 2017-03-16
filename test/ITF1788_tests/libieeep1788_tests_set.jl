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

facts("minimal_intersection_test") do
    @fact Interval(1.0, 3.0) ∩ Interval(2.1, 4.0) --> Interval(2.1, 3.0)
    @fact intersect(Interval(1.0, 3.0), Interval(2.1, 4.0)) --> Interval(2.1, 3.0)
    @fact Interval(1.0, 3.0) ∩ Interval(3.0, 4.0) --> Interval(3.0, 3.0)
    @fact intersect(Interval(1.0, 3.0), Interval(3.0, 4.0)) --> Interval(3.0, 3.0)
    @fact Interval(1.0, 3.0) ∩ ∅ --> ∅
    @fact intersect(Interval(1.0, 3.0), ∅) --> ∅
    @fact entireinterval(Float64) ∩ ∅ --> ∅
    @fact intersect(entireinterval(Float64), ∅) --> ∅
    @fact Interval(1.0, 3.0) ∩ entireinterval(Float64) --> Interval(1.0, 3.0)
    @fact intersect(Interval(1.0, 3.0), entireinterval(Float64)) --> Interval(1.0, 3.0)
end

facts("minimal_intersection_dec_test") do
    @fact DecoratedInterval(Interval(1.0, 3.0), com) ∩ DecoratedInterval(Interval(2.1, 4.0), com) --> DecoratedInterval(Interval(2.1, 3.0), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), com) ∩ DecoratedInterval(Interval(2.1, 4.0), com)) --> decoration(DecoratedInterval(Interval(2.1, 3.0), trv))
    @fact intersect(DecoratedInterval(Interval(1.0, 3.0), com), DecoratedInterval(Interval(2.1, 4.0), com)) --> DecoratedInterval(Interval(2.1, 3.0), trv)
    @fact decoration(intersect(DecoratedInterval(Interval(1.0, 3.0), com), DecoratedInterval(Interval(2.1, 4.0), com))) --> decoration(DecoratedInterval(Interval(2.1, 3.0), trv))
    @fact DecoratedInterval(Interval(1.0, 3.0), dac) ∩ DecoratedInterval(Interval(3.0, 4.0), def) --> DecoratedInterval(Interval(3.0, 3.0), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), dac) ∩ DecoratedInterval(Interval(3.0, 4.0), def)) --> decoration(DecoratedInterval(Interval(3.0, 3.0), trv))
    @fact intersect(DecoratedInterval(Interval(1.0, 3.0), dac), DecoratedInterval(Interval(3.0, 4.0), def)) --> DecoratedInterval(Interval(3.0, 3.0), trv)
    @fact decoration(intersect(DecoratedInterval(Interval(1.0, 3.0), dac), DecoratedInterval(Interval(3.0, 4.0), def))) --> decoration(DecoratedInterval(Interval(3.0, 3.0), trv))
    @fact DecoratedInterval(Interval(1.0, 3.0), def) ∩ DecoratedInterval(∅, trv) --> DecoratedInterval(∅, trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), def) ∩ DecoratedInterval(∅, trv)) --> decoration(DecoratedInterval(∅, trv))
    @fact intersect(DecoratedInterval(Interval(1.0, 3.0), def), DecoratedInterval(∅, trv)) --> DecoratedInterval(∅, trv)
    @fact decoration(intersect(DecoratedInterval(Interval(1.0, 3.0), def), DecoratedInterval(∅, trv))) --> decoration(DecoratedInterval(∅, trv))
    @fact DecoratedInterval(entireinterval(Float64), def) ∩ DecoratedInterval(∅, trv) --> DecoratedInterval(∅, trv)
    @fact decoration(DecoratedInterval(entireinterval(Float64), def) ∩ DecoratedInterval(∅, trv)) --> decoration(DecoratedInterval(∅, trv))
    @fact intersect(DecoratedInterval(entireinterval(Float64), def), DecoratedInterval(∅, trv)) --> DecoratedInterval(∅, trv)
    @fact decoration(intersect(DecoratedInterval(entireinterval(Float64), def), DecoratedInterval(∅, trv))) --> decoration(DecoratedInterval(∅, trv))
    @fact DecoratedInterval(Interval(1.0, 3.0), dac) ∩ DecoratedInterval(entireinterval(Float64), def) --> DecoratedInterval(Interval(1.0, 3.0), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), dac) ∩ DecoratedInterval(entireinterval(Float64), def)) --> decoration(DecoratedInterval(Interval(1.0, 3.0), trv))
    @fact intersect(DecoratedInterval(Interval(1.0, 3.0), dac), DecoratedInterval(entireinterval(Float64), def)) --> DecoratedInterval(Interval(1.0, 3.0), trv)
    @fact decoration(intersect(DecoratedInterval(Interval(1.0, 3.0), dac), DecoratedInterval(entireinterval(Float64), def))) --> decoration(DecoratedInterval(Interval(1.0, 3.0), trv))
end

facts("minimal_convexHull_test") do
    @fact Interval(1.0, 3.0) ∪ Interval(2.1, 4.0) --> Interval(1.0, 4.0)
    @fact hull(Interval(1.0, 3.0), Interval(2.1, 4.0)) --> Interval(1.0, 4.0)
    @fact Interval(1.0, 1.0) ∪ Interval(2.1, 4.0) --> Interval(1.0, 4.0)
    @fact hull(Interval(1.0, 1.0), Interval(2.1, 4.0)) --> Interval(1.0, 4.0)
    @fact Interval(1.0, 3.0) ∪ ∅ --> Interval(1.0, 3.0)
    @fact hull(Interval(1.0, 3.0), ∅) --> Interval(1.0, 3.0)
    @fact ∅ ∪ ∅ --> ∅
    @fact hull(∅, ∅) --> ∅
    @fact Interval(1.0, 3.0) ∪ entireinterval(Float64) --> entireinterval(Float64)
    @fact hull(Interval(1.0, 3.0), entireinterval(Float64)) --> entireinterval(Float64)
end

facts("minimal_convexHull_dec_test") do
    @fact DecoratedInterval(Interval(1.0, 3.0), trv) ∪ DecoratedInterval(Interval(2.1, 4.0), trv) --> DecoratedInterval(Interval(1.0, 4.0), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), trv) ∪ DecoratedInterval(Interval(2.1, 4.0), trv)) --> decoration(DecoratedInterval(Interval(1.0, 4.0), trv))
    @fact hull(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(Interval(2.1, 4.0), trv)) --> DecoratedInterval(Interval(1.0, 4.0), trv)
    @fact decoration(hull(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(Interval(2.1, 4.0), trv))) --> decoration(DecoratedInterval(Interval(1.0, 4.0), trv))
    @fact DecoratedInterval(Interval(1.0, 1.0), trv) ∪ DecoratedInterval(Interval(2.1, 4.0), trv) --> DecoratedInterval(Interval(1.0, 4.0), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 1.0), trv) ∪ DecoratedInterval(Interval(2.1, 4.0), trv)) --> decoration(DecoratedInterval(Interval(1.0, 4.0), trv))
    @fact hull(DecoratedInterval(Interval(1.0, 1.0), trv), DecoratedInterval(Interval(2.1, 4.0), trv)) --> DecoratedInterval(Interval(1.0, 4.0), trv)
    @fact decoration(hull(DecoratedInterval(Interval(1.0, 1.0), trv), DecoratedInterval(Interval(2.1, 4.0), trv))) --> decoration(DecoratedInterval(Interval(1.0, 4.0), trv))
    @fact DecoratedInterval(Interval(1.0, 3.0), trv) ∪ DecoratedInterval(∅, trv) --> DecoratedInterval(Interval(1.0, 3.0), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), trv) ∪ DecoratedInterval(∅, trv)) --> decoration(DecoratedInterval(Interval(1.0, 3.0), trv))
    @fact hull(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(∅, trv)) --> DecoratedInterval(Interval(1.0, 3.0), trv)
    @fact decoration(hull(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(∅, trv))) --> decoration(DecoratedInterval(Interval(1.0, 3.0), trv))
    @fact DecoratedInterval(∅, trv) ∪ DecoratedInterval(∅, trv) --> DecoratedInterval(∅, trv)
    @fact decoration(DecoratedInterval(∅, trv) ∪ DecoratedInterval(∅, trv)) --> decoration(DecoratedInterval(∅, trv))
    @fact hull(DecoratedInterval(∅, trv), DecoratedInterval(∅, trv)) --> DecoratedInterval(∅, trv)
    @fact decoration(hull(DecoratedInterval(∅, trv), DecoratedInterval(∅, trv))) --> decoration(DecoratedInterval(∅, trv))
    @fact DecoratedInterval(Interval(1.0, 3.0), trv) ∪ DecoratedInterval(entireinterval(Float64), def) --> DecoratedInterval(entireinterval(Float64), trv)
    @fact decoration(DecoratedInterval(Interval(1.0, 3.0), trv) ∪ DecoratedInterval(entireinterval(Float64), def)) --> decoration(DecoratedInterval(entireinterval(Float64), trv))
    @fact hull(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(entireinterval(Float64), def)) --> DecoratedInterval(entireinterval(Float64), trv)
    @fact decoration(hull(DecoratedInterval(Interval(1.0, 3.0), trv), DecoratedInterval(entireinterval(Float64), def))) --> decoration(DecoratedInterval(entireinterval(Float64), trv))
end
# FactCheck.exitstatus()
