#=
 
 Unit tests from C-XSC version 2.5.4
 converted into portable ITL format by Oliver Heimlich.
 
 Copyright 1990-2000 Institut fuer Angewandte Mathematik,
                     Universitaet Karlsruhe, Germany
 Copyright 2000-2014 Wiss. Rechnen/Softwaretechnologie
                     Universitaet Wuppertal, Germany   
 Copyright 2015-2016 Oliver Heimlich (oheim@posteo.de)
 
 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 
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

# Tests A+B, B+A, A-B, B-A, -A, +A
@testset "cxsc.intervaladdsub" begin
    @test Interval(10.0, 20.0) + Interval(13.0, 17.0) == Interval(23.0, 37.0)
    @test Interval(13.0, 17.0) + Interval(10.0, 20.0) == Interval(23.0, 37.0)
    @test Interval(10.0, 20.0) - Interval(13.0, 16.0) == Interval(-6.0, 7.0)
    @test Interval(13.0, 16.0) - Interval(10.0, 20.0) == Interval(-7.0, 6.0)
    @test -(Interval(10.0, 20.0)) == Interval(-20.0, -10.0)
    @test +Interval(10.0, 20.0) == Interval(10.0, 20.0)
end

# Tests A*B, B*A, A/B, B/A
@testset "cxsc.intervalmuldiv" begin
    @test Interval(1.0, 2.0) * Interval(3.0, 4.0) == Interval(3.0, 8.0)
    @test Interval(-1.0, 2.0) * Interval(3.0, 4.0) == Interval(-4.0, 8.0)
    @test Interval(-2.0, 1.0) * Interval(3.0, 4.0) == Interval(-8.0, 4.0)
    @test Interval(-2.0, -1.0) * Interval(3.0, 4.0) == Interval(-8.0, -3.0)
    @test Interval(1.0, 2.0) * Interval(-3.0, 4.0) == Interval(-6.0, 8.0)
    @test Interval(-1.0, 2.0) * Interval(-3.0, 4.0) == Interval(-6.0, 8.0)
    @test Interval(-2.0, 1.0) * Interval(-3.0, 4.0) == Interval(-8.0, 6.0)
    @test Interval(-2.0, -1.0) * Interval(-3.0, 4.0) == Interval(-8.0, 6.0)
    @test Interval(1.0, 2.0) * Interval(-4.0, 3.0) == Interval(-8.0, 6.0)
    @test Interval(-1.0, 2.0) * Interval(-4.0, 3.0) == Interval(-8.0, 6.0)
    @test Interval(-2.0, 1.0) * Interval(-4.0, 3.0) == Interval(-6.0, 8.0)
    @test Interval(-2.0, -1.0) * Interval(-4.0, 3.0) == Interval(-6.0, 8.0)
    @test Interval(1.0, 2.0) * Interval(-4.0, -3.0) == Interval(-8.0, -3.0)
    @test Interval(-1.0, 2.0) * Interval(-4.0, -3.0) == Interval(-8.0, 4.0)
    @test Interval(-2.0, -1.0) * Interval(-4.0, -3.0) == Interval(3.0, 8.0)
    @test Interval(1.0, 2.0) / Interval(4.0, 8.0) == Interval(0.125, 0.5)
    @test Interval(-1.0, 2.0) / Interval(4.0, 8.0) == Interval(-0.25, 0.5)
    @test Interval(-2.0, 1.0) / Interval(4.0, 8.0) == Interval(-0.5, 0.25)
    @test Interval(-2.0, -1.0) / Interval(4.0, 8.0) == Interval(-0.5, -0.125)
    @test Interval(1.0, 2.0) / Interval(-4.0, 8.0) == entireinterval(Float64)
    @test Interval(-1.0, 2.0) / Interval(-4.0, 8.0) == entireinterval(Float64)
    @test Interval(-2.0, 1.0) / Interval(-4.0, 8.0) == entireinterval(Float64)
    @test Interval(-2.0, -1.0) / Interval(-4.0, 8.0) == entireinterval(Float64)
    @test Interval(1.0, 2.0) / Interval(-8.0, 4.0) == entireinterval(Float64)
    @test Interval(-1.0, 2.0) / Interval(-8.0, 4.0) == entireinterval(Float64)
    @test Interval(-2.0, 1.0) / Interval(-8.0, 4.0) == entireinterval(Float64)
    @test Interval(-2.0, -1.0) / Interval(-8.0, 4.0) == entireinterval(Float64)
    @test Interval(1.0, 2.0) / Interval(-8.0, -4.0) == Interval(-0.5, -0.125)
    @test Interval(-1.0, 2.0) / Interval(-8.0, -4.0) == Interval(-0.5, 0.25)
    @test Interval(-2.0, 1.0) / Interval(-8.0, -4.0) == Interval(-0.25, 0.5)
    @test Interval(-2.0, -1.0) / Interval(-8.0, -4.0) == Interval(0.125, 0.5)
end

# Tests A|B, B|A, A&B, B&A
@testset "cxsc.intervalsetops" begin
    @test hull(Interval(-2.0, 2.0), Interval(-4.0, -3.0)) == Interval(-4.0, 2.0)
    @test ∪(Interval(-2.0, 2.0), Interval(-4.0, -3.0)) == Interval(-4.0, 2.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(-4.0, -3.0)) == Interval(-4.0, 2.0)
    @test hull(Interval(-2.0, 2.0), Interval(-4.0, -1.0)) == Interval(-4.0, 2.0)
    @test ∪(Interval(-2.0, 2.0), Interval(-4.0, -1.0)) == Interval(-4.0, 2.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(-4.0, -1.0)) == Interval(-4.0, 2.0)
    @test hull(Interval(-2.0, 2.0), Interval(-4.0, 4.0)) == Interval(-4.0, 4.0)
    @test ∪(Interval(-2.0, 2.0), Interval(-4.0, 4.0)) == Interval(-4.0, 4.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(-4.0, 4.0)) == Interval(-4.0, 4.0)
    @test hull(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == Interval(-2.0, 2.0)
    @test ∪(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == Interval(-2.0, 2.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(-1.0, 1.0)) == Interval(-2.0, 2.0)
    @test hull(Interval(-2.0, 2.0), Interval(1.0, 4.0)) == Interval(-2.0, 4.0)
    @test ∪(Interval(-2.0, 2.0), Interval(1.0, 4.0)) == Interval(-2.0, 4.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(1.0, 4.0)) == Interval(-2.0, 4.0)
    @test hull(Interval(-2.0, 2.0), Interval(3.0, 4.0)) == Interval(-2.0, 4.0)
    @test ∪(Interval(-2.0, 2.0), Interval(3.0, 4.0)) == Interval(-2.0, 4.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(3.0, 4.0)) == Interval(-2.0, 4.0)
    @test hull(Interval(-4.0, -3.0), Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test ∪(Interval(-4.0, -3.0), Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test (Interval(-4.0, -3.0) ∪ Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test hull(Interval(-4.0, -1.0), Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test ∪(Interval(-4.0, -1.0), Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test (Interval(-4.0, -1.0) ∪ Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test hull(Interval(-4.0, 4.0), Interval(-2.0, 2.0)) == Interval(-4.0, 4.0)
    @test ∪(Interval(-4.0, 4.0), Interval(-2.0, 2.0)) == Interval(-4.0, 4.0)
    @test (Interval(-4.0, 4.0) ∪ Interval(-2.0, 2.0)) == Interval(-4.0, 4.0)
    @test hull(Interval(-1.0, 1.0), Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test ∪(Interval(-1.0, 1.0), Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test (Interval(-1.0, 1.0) ∪ Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test hull(Interval(1.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test ∪(Interval(1.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test (Interval(1.0, 4.0) ∪ Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test hull(Interval(3.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test ∪(Interval(3.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test (Interval(3.0, 4.0) ∪ Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test intersect(Interval(-2.0, 2.0), Interval(-4.0, -3.0)) == ∅
    @test ∩(Interval(-2.0, 2.0), Interval(-4.0, -3.0)) == ∅
    @test (Interval(-2.0, 2.0) ∩ Interval(-4.0, -3.0)) == ∅
    @test intersect(Interval(-2.0, 2.0), Interval(-4.0, -1.0)) == Interval(-2.0, -1.0)
    @test ∩(Interval(-2.0, 2.0), Interval(-4.0, -1.0)) == Interval(-2.0, -1.0)
    @test (Interval(-2.0, 2.0) ∩ Interval(-4.0, -1.0)) == Interval(-2.0, -1.0)
    @test intersect(Interval(-2.0, 2.0), Interval(-4.0, 4.0)) == Interval(-2.0, 2.0)
    @test ∩(Interval(-2.0, 2.0), Interval(-4.0, 4.0)) == Interval(-2.0, 2.0)
    @test (Interval(-2.0, 2.0) ∩ Interval(-4.0, 4.0)) == Interval(-2.0, 2.0)
    @test intersect(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == Interval(-1.0, 1.0)
    @test ∩(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == Interval(-1.0, 1.0)
    @test (Interval(-2.0, 2.0) ∩ Interval(-1.0, 1.0)) == Interval(-1.0, 1.0)
    @test intersect(Interval(-2.0, 2.0), Interval(1.0, 4.0)) == Interval(1.0, 2.0)
    @test ∩(Interval(-2.0, 2.0), Interval(1.0, 4.0)) == Interval(1.0, 2.0)
    @test (Interval(-2.0, 2.0) ∩ Interval(1.0, 4.0)) == Interval(1.0, 2.0)
    @test intersect(Interval(-2.0, 2.0), Interval(3.0, 4.0)) == ∅
    @test ∩(Interval(-2.0, 2.0), Interval(3.0, 4.0)) == ∅
    @test (Interval(-2.0, 2.0) ∩ Interval(3.0, 4.0)) == ∅
    @test intersect(Interval(-4.0, -3.0), Interval(-2.0, 2.0)) == ∅
    @test ∩(Interval(-4.0, -3.0), Interval(-2.0, 2.0)) == ∅
    @test (Interval(-4.0, -3.0) ∩ Interval(-2.0, 2.0)) == ∅
    @test intersect(Interval(-4.0, -1.0), Interval(-2.0, 2.0)) == Interval(-2.0, -1.0)
    @test ∩(Interval(-4.0, -1.0), Interval(-2.0, 2.0)) == Interval(-2.0, -1.0)
    @test (Interval(-4.0, -1.0) ∩ Interval(-2.0, 2.0)) == Interval(-2.0, -1.0)
    @test intersect(Interval(-4.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test ∩(Interval(-4.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test (Interval(-4.0, 4.0) ∩ Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test intersect(Interval(-1.0, 1.0), Interval(-2.0, 2.0)) == Interval(-1.0, 1.0)
    @test ∩(Interval(-1.0, 1.0), Interval(-2.0, 2.0)) == Interval(-1.0, 1.0)
    @test (Interval(-1.0, 1.0) ∩ Interval(-2.0, 2.0)) == Interval(-1.0, 1.0)
    @test intersect(Interval(1.0, 4.0), Interval(-2.0, 2.0)) == Interval(1.0, 2.0)
    @test ∩(Interval(1.0, 4.0), Interval(-2.0, 2.0)) == Interval(1.0, 2.0)
    @test (Interval(1.0, 4.0) ∩ Interval(-2.0, 2.0)) == Interval(1.0, 2.0)
    @test intersect(Interval(3.0, 4.0), Interval(-2.0, 2.0)) == ∅
    @test ∩(Interval(3.0, 4.0), Interval(-2.0, 2.0)) == ∅
    @test (Interval(3.0, 4.0) ∩ Interval(-2.0, 2.0)) == ∅
end

# Tests A|B, B|A, A&B, B&A, B is scalar-type
@testset "cxsc.intervalmixsetops" begin
    @test hull(Interval(-2.0, 2.0), Interval(-4.0, -4.0)) == Interval(-4.0, 2.0)
    @test ∪(Interval(-2.0, 2.0), Interval(-4.0, -4.0)) == Interval(-4.0, 2.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(-4.0, -4.0)) == Interval(-4.0, 2.0)
    @test hull(Interval(-2.0, 2.0), Interval(1.0, 1.0)) == Interval(-2.0, 2.0)
    @test ∪(Interval(-2.0, 2.0), Interval(1.0, 1.0)) == Interval(-2.0, 2.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(1.0, 1.0)) == Interval(-2.0, 2.0)
    @test hull(Interval(-2.0, 2.0), Interval(4.0, 4.0)) == Interval(-2.0, 4.0)
    @test ∪(Interval(-2.0, 2.0), Interval(4.0, 4.0)) == Interval(-2.0, 4.0)
    @test (Interval(-2.0, 2.0) ∪ Interval(4.0, 4.0)) == Interval(-2.0, 4.0)
    @test hull(Interval(-4.0, -4.0), Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test ∪(Interval(-4.0, -4.0), Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test (Interval(-4.0, -4.0) ∪ Interval(-2.0, 2.0)) == Interval(-4.0, 2.0)
    @test hull(Interval(1.0, 1.0), Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test ∪(Interval(1.0, 1.0), Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test (Interval(1.0, 1.0) ∪ Interval(-2.0, 2.0)) == Interval(-2.0, 2.0)
    @test hull(Interval(4.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test ∪(Interval(4.0, 4.0), Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test (Interval(4.0, 4.0) ∪ Interval(-2.0, 2.0)) == Interval(-2.0, 4.0)
    @test intersect(Interval(-2.0, 2.0), Interval(-4.0, -4.0)) == ∅
    @test ∩(Interval(-2.0, 2.0), Interval(-4.0, -4.0)) == ∅
    @test (Interval(-2.0, 2.0) ∩ Interval(-4.0, -4.0)) == ∅
    @test intersect(Interval(-2.0, 2.0), Interval(1.0, 1.0)) == Interval(1.0, 1.0)
    @test ∩(Interval(-2.0, 2.0), Interval(1.0, 1.0)) == Interval(1.0, 1.0)
    @test (Interval(-2.0, 2.0) ∩ Interval(1.0, 1.0)) == Interval(1.0, 1.0)
    @test intersect(Interval(-2.0, 2.0), Interval(4.0, 4.0)) == ∅
    @test ∩(Interval(-2.0, 2.0), Interval(4.0, 4.0)) == ∅
    @test (Interval(-2.0, 2.0) ∩ Interval(4.0, 4.0)) == ∅
    @test intersect(Interval(-4.0, -4.0), Interval(-2.0, 2.0)) == ∅
    @test ∩(Interval(-4.0, -4.0), Interval(-2.0, 2.0)) == ∅
    @test (Interval(-4.0, -4.0) ∩ Interval(-2.0, 2.0)) == ∅
    @test intersect(Interval(1.0, 1.0), Interval(-2.0, 2.0)) == Interval(1.0, 1.0)
    @test ∩(Interval(1.0, 1.0), Interval(-2.0, 2.0)) == Interval(1.0, 1.0)
    @test (Interval(1.0, 1.0) ∩ Interval(-2.0, 2.0)) == Interval(1.0, 1.0)
    @test intersect(Interval(4.0, 4.0), Interval(-2.0, 2.0)) == ∅
    @test ∩(Interval(4.0, 4.0), Interval(-2.0, 2.0)) == ∅
    @test (Interval(4.0, 4.0) ∩ Interval(-2.0, 2.0)) == ∅
end

# Tests A|B, B|A, A and B are scalar-type
@testset "cxsc.scalarmixsetops" begin
    @test hull(Interval(-2.0, -2.0), Interval(-4.0, -4.0)) == Interval(-4.0, -2.0)
    @test ∪(Interval(-2.0, -2.0), Interval(-4.0, -4.0)) == Interval(-4.0, -2.0)
    @test (Interval(-2.0, -2.0) ∪ Interval(-4.0, -4.0)) == Interval(-4.0, -2.0)
    @test hull(Interval(-2.0, -2.0), Interval(-2.0, -2.0)) == Interval(-2.0, -2.0)
    @test ∪(Interval(-2.0, -2.0), Interval(-2.0, -2.0)) == Interval(-2.0, -2.0)
    @test (Interval(-2.0, -2.0) ∪ Interval(-2.0, -2.0)) == Interval(-2.0, -2.0)
    @test hull(Interval(-2.0, -2.0), Interval(2.0, 2.0)) == Interval(-2.0, 2.0)
    @test ∪(Interval(-2.0, -2.0), Interval(2.0, 2.0)) == Interval(-2.0, 2.0)
    @test (Interval(-2.0, -2.0) ∪ Interval(2.0, 2.0)) == Interval(-2.0, 2.0)
    @test hull(Interval(-4.0, -4.0), Interval(-2.0, -2.0)) == Interval(-4.0, -2.0)
    @test ∪(Interval(-4.0, -4.0), Interval(-2.0, -2.0)) == Interval(-4.0, -2.0)
    @test (Interval(-4.0, -4.0) ∪ Interval(-2.0, -2.0)) == Interval(-4.0, -2.0)
    @test hull(Interval(-2.0, -2.0), Interval(-2.0, -2.0)) == Interval(-2.0, -2.0)
    @test ∪(Interval(-2.0, -2.0), Interval(-2.0, -2.0)) == Interval(-2.0, -2.0)
    @test (Interval(-2.0, -2.0) ∪ Interval(-2.0, -2.0)) == Interval(-2.0, -2.0)
    @test hull(Interval(2.0, 2.0), Interval(-2.0, -2.0)) == Interval(-2.0, 2.0)
    @test ∪(Interval(2.0, 2.0), Interval(-2.0, -2.0)) == Interval(-2.0, 2.0)
    @test (Interval(2.0, 2.0) ∪ Interval(-2.0, -2.0)) == Interval(-2.0, 2.0)
end

# Tests A<B, A>B, A<=B, A>=B, A==B
@testset "cxsc.intervalsetcompops" begin
    @test ⪽(Interval(-1.0, 2.0), Interval(-1.0, 2.0)) == false
    @test isinterior(Interval(-1.0, 2.0), Interval(-1.0, 2.0)) == false
    @test (Interval(-1.0, 2.0) ⪽ Interval(-1.0, 2.0)) == false
    @test ⪽(Interval(-2.0, 1.0), Interval(-3.0, 2.0))
    @test isinterior(Interval(-2.0, 1.0), Interval(-3.0, 2.0))
    @test (Interval(-2.0, 1.0) ⪽ Interval(-3.0, 2.0))
    @test ⪽(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(-1.0, 1.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(-1.0, 2.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-1.0, 2.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(-1.0, 2.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(-2.0, 1.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-2.0, 1.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(-2.0, 1.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(-2.0, 3.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-2.0, 3.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(-2.0, 3.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(-3.0, 2.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-3.0, 2.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(-3.0, 2.0)) == false
    @test ⪽(Interval(-1.0, 2.0), Interval(-1.0, 2.0)) == false
    @test isinterior(Interval(-1.0, 2.0), Interval(-1.0, 2.0)) == false
    @test (Interval(-1.0, 2.0) ⪽ Interval(-1.0, 2.0)) == false
    @test ⪽(Interval(-3.0, 2.0), Interval(-2.0, 1.0)) == false
    @test isinterior(Interval(-3.0, 2.0), Interval(-2.0, 1.0)) == false
    @test (Interval(-3.0, 2.0) ⪽ Interval(-2.0, 1.0)) == false
    @test ⪽(Interval(-1.0, 1.0), Interval(-2.0, 2.0))
    @test isinterior(Interval(-1.0, 1.0), Interval(-2.0, 2.0))
    @test (Interval(-1.0, 1.0) ⪽ Interval(-2.0, 2.0))
    @test ⪽(Interval(-1.0, 2.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(-1.0, 2.0), Interval(-2.0, 2.0)) == false
    @test (Interval(-1.0, 2.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⪽(Interval(-2.0, 1.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(-2.0, 1.0), Interval(-2.0, 2.0)) == false
    @test (Interval(-2.0, 1.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⪽(Interval(-2.0, 3.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(-2.0, 3.0), Interval(-2.0, 2.0)) == false
    @test (Interval(-2.0, 3.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⪽(Interval(-3.0, 2.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(-3.0, 2.0), Interval(-2.0, 2.0)) == false
    @test (Interval(-3.0, 2.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⊆(Interval(-1.0, 2.0), Interval(-1.0, 2.0))
    @test ⊆(Interval(-2.0, 1.0), Interval(-3.0, 2.0))
    @test ⊆(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(-1.0, 2.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(-2.0, 1.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(-2.0, 3.0))
    @test ⊆(Interval(-2.0, 2.0), Interval(-3.0, 2.0))
    @test ⊆(Interval(-3.0, 2.0), Interval(-2.0, 1.0)) == false
    @test ⊆(Interval(-1.0, 1.0), Interval(-2.0, 2.0))
    @test ⊆(Interval(-1.0, 2.0), Interval(-2.0, 2.0))
    @test ⊆(Interval(-2.0, 1.0), Interval(-2.0, 2.0))
    @test ⊆(Interval(-2.0, 3.0), Interval(-2.0, 2.0)) == false
    @test ⊆(Interval(-3.0, 2.0), Interval(-2.0, 2.0)) == false
    @test ==(Interval(-1.0, 2.0), Interval(-1.0, 2.0))
    @test ==(Interval(-2.0, 1.0), Interval(-3.0, 2.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(-1.0, 1.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(-1.0, 2.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(-2.0, 1.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(-2.0, 3.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(-3.0, 2.0)) == false
end

# Tests A<B, A>B, A<=B, A>=B, A==B, B<A, B>A, B<=A, B>=A, B==A, where B is scalar
@testset "cxsc.intervalscalarsetcompops" begin
    @test ⪽(Interval(-1.0, 2.0), Interval(-2.0, -2.0)) == false
    @test isinterior(Interval(-1.0, 2.0), Interval(-2.0, -2.0)) == false
    @test (Interval(-1.0, 2.0) ⪽ Interval(-2.0, -2.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(-2.0, -2.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(-2.0, -2.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(-2.0, -2.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(0.0, 0.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(0.0, 0.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(0.0, 0.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(2.0, 2.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(2.0, 2.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(2.0, 2.0)) == false
    @test ⪽(Interval(-2.0, 2.0), Interval(3.0, 3.0)) == false
    @test isinterior(Interval(-2.0, 2.0), Interval(3.0, 3.0)) == false
    @test (Interval(-2.0, 2.0) ⪽ Interval(3.0, 3.0)) == false
    @test ⪽(Interval(-1.0, -1.0), Interval(1.0, 1.0)) == false
    @test isinterior(Interval(-1.0, -1.0), Interval(1.0, 1.0)) == false
    @test (Interval(-1.0, -1.0) ⪽ Interval(1.0, 1.0)) == false
    @test ⪽(Interval(-1.0, -1.0), Interval(-1.0, -1.0)) == false
    @test isinterior(Interval(-1.0, -1.0), Interval(-1.0, -1.0)) == false
    @test (Interval(-1.0, -1.0) ⪽ Interval(-1.0, -1.0)) == false
    @test ⪽(Interval(-2.0, -2.0), Interval(-1.0, 2.0)) == false
    @test isinterior(Interval(-2.0, -2.0), Interval(-1.0, 2.0)) == false
    @test (Interval(-2.0, -2.0) ⪽ Interval(-1.0, 2.0)) == false
    @test ⪽(Interval(-2.0, -2.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(-2.0, -2.0), Interval(-2.0, 2.0)) == false
    @test (Interval(-2.0, -2.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⪽(Interval(0.0, 0.0), Interval(-2.0, 2.0))
    @test isinterior(Interval(0.0, 0.0), Interval(-2.0, 2.0))
    @test (Interval(0.0, 0.0) ⪽ Interval(-2.0, 2.0))
    @test ⪽(Interval(2.0, 2.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(2.0, 2.0), Interval(-2.0, 2.0)) == false
    @test (Interval(2.0, 2.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⪽(Interval(3.0, 3.0), Interval(-2.0, 2.0)) == false
    @test isinterior(Interval(3.0, 3.0), Interval(-2.0, 2.0)) == false
    @test (Interval(3.0, 3.0) ⪽ Interval(-2.0, 2.0)) == false
    @test ⪽(Interval(1.0, 1.0), Interval(-1.0, -1.0)) == false
    @test isinterior(Interval(1.0, 1.0), Interval(-1.0, -1.0)) == false
    @test (Interval(1.0, 1.0) ⪽ Interval(-1.0, -1.0)) == false
    @test ⪽(Interval(-1.0, -1.0), Interval(-1.0, -1.0)) == false
    @test isinterior(Interval(-1.0, -1.0), Interval(-1.0, -1.0)) == false
    @test (Interval(-1.0, -1.0) ⪽ Interval(-1.0, -1.0)) == false
    @test ⊆(Interval(-1.0, 2.0), Interval(-2.0, -2.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(-2.0, -2.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(0.0, 0.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(2.0, 2.0)) == false
    @test ⊆(Interval(-2.0, 2.0), Interval(3.0, 3.0)) == false
    @test ⊆(Interval(-1.0, -1.0), Interval(1.0, 1.0)) == false
    @test ⊆(Interval(-1.0, -1.0), Interval(-1.0, -1.0))
    @test ⊆(Interval(-2.0, -2.0), Interval(-1.0, 2.0)) == false
    @test ⊆(Interval(-2.0, -2.0), Interval(-2.0, 2.0))
    @test ⊆(Interval(0.0, 0.0), Interval(-2.0, 2.0))
    @test ⊆(Interval(2.0, 2.0), Interval(-2.0, 2.0))
    @test ⊆(Interval(3.0, 3.0), Interval(-2.0, 2.0)) == false
    @test ⊆(Interval(1.0, 1.0), Interval(-1.0, -1.0)) == false
    @test ⊆(Interval(-1.0, -1.0), Interval(-1.0, -1.0))
    @test ==(Interval(-1.0, 2.0), Interval(-2.0, -2.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(-2.0, -2.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(0.0, 0.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(2.0, 2.0)) == false
    @test ==(Interval(-2.0, 2.0), Interval(3.0, 3.0)) == false
    @test ==(Interval(-1.0, -1.0), Interval(1.0, 1.0)) == false
    @test ==(Interval(-1.0, -1.0), Interval(-1.0, -1.0))
end

@testset "cxsc.intervalstdfunc" begin
    @test Interval(11.0, 11.0) ^2 == Interval(121.0, 121.0)
    @test Interval(11.0, 11.0) ^(2//1) == Interval(121.0, 121.0)
    @test Interval(11.0, 11.0) ^(2.0) == Interval(121.0, 121.0)
    @test Interval(0.0, 0.0) ^2 == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) ^(2//1) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) ^(2.0) == Interval(0.0, 0.0)
    @test Interval(-9.0, -9.0) ^2 == Interval(81.0, 81.0)
    @test Interval(-9.0, -9.0) ^(2//1) == Interval(81.0, 81.0)
    @test Interval(-9.0, -9.0) ^(2.0) == Interval(81.0, 81.0)
    @test sqrt(Interval(121.0, 121.0)) == Interval(11.0, 11.0)
    @test (Interval(121.0, 121.0))^(1/2) == Interval(11.0, 11.0)
    @test (Interval(121.0, 121.0))^(0.5) == Interval(11.0, 11.0)
    @test (Interval(121.0, 121.0))^(1//2) == Interval(11.0, 11.0)
    @test sqrt(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0))^(1/2) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0))^(0.5) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0))^(1//2) == Interval(0.0, 0.0)
    @test sqrt(Interval(81.0, 81.0)) == Interval(9.0, 9.0)
    @test (Interval(81.0, 81.0))^(1/2) == Interval(9.0, 9.0)
    @test (Interval(81.0, 81.0))^(0.5) == Interval(9.0, 9.0)
    @test (Interval(81.0, 81.0))^(1//2) == Interval(9.0, 9.0)
    @test nthroot(Interval(27.0, 27.0), 3) == Interval(3.0, 3.0)
    @test nthroot(Interval(0.0, 0.0), 4) == Interval(0.0, 0.0)
    @test nthroot(Interval(1024.0, 1024.0), 10) == Interval(2.0, 2.0)
    @test Interval(2.0, 2.0) ^ Interval(2.0, 2.0) == Interval(4.0, 4.0)
    @test Interval(4.0, 4.0) ^ Interval(5.0, 5.0) == Interval(1024.0, 1024.0)
    # Negativ geht noch nicht
    @test Interval(2.0, 2.0) ^ Interval(3.0, 3.0) == Interval(8.0, 8.0)
end
# FactCheck.exitstatus()
