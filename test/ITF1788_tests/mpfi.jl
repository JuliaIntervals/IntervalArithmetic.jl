#=
 
 Unit tests from GNU MPFI
 (Original authors: Philippe Theveny and Nathalie Revol )
 converted into portable ITL format by Oliver Heimlich.
 
 Copyright 2009–2012 Spaces project, Inria Lorraine
                     and Salsa project, INRIA Rocquencourt,
                     and Arenaire project, Inria Rhone-Alpes, France
                     and Lab. ANO, USTL (Univ. of Lille), France
 Copyright 2015-2016 Oliver Heimlich
 
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

@testset "mpfi_abs" begin
    # special values
    @test abs(Interval(-Inf, -7.0)) == Interval(+7.0, Inf)
    @test abs(Interval(-Inf, 0.0)) == Interval(0.0, Inf)
    @test abs(Interval(-Inf, 0.0)) == Interval(0.0, Inf)
    @test abs(Interval(-Inf, +8.0)) == Interval(0.0, Inf)
    @test abs(entireinterval(Float64)) == Interval(0.0, Inf)
    @test abs(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test abs(Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test abs(Interval(0.0, Inf)) == Interval(0.0, Inf)
    @test abs(Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test abs(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test abs(Interval(0x123456789p-16, 0x123456799p-16)) == Interval(0x123456789p-16, 0x123456799p-16)
    @test abs(Interval(-0x123456789p-16, 0x123456799p-16)) == Interval(0.0, 0x123456799p-16)
end

@testset "mpfi_acos" begin
    # special values
    @test acos(Interval(-1.0, 0.0)) == Interval(0x3243f6a8885a3p-49, 0x1921fb54442d19p-51)
    @test acos(Interval(0.0, 0.0)) == Interval(0x3243f6a8885a3p-49, 0x1921fb54442d19p-52)
    @test acos(Interval(0.0, +1.0)) == Interval(0.0, 0x1921fb54442d19p-52)
    # regular values
    @test acos(Interval(-1.0, -0.5)) == Interval(0x10c152382d7365p-51, 0x1921fb54442d19p-51)
    @test acos(Interval(-0.75, -0.25)) == Interval(0x1d2cf5c7c70f0bp-52, 0x4d6749be4edb1p-49)
    @test acos(Interval(-0.5, 0.5)) == Interval(0x10c152382d7365p-52, 0x860a91c16b9b3p-50)
    @test acos(Interval(0.25, 0.625)) == Interval(0x1ca94936b98a21p-53, 0x151700e0c14b25p-52)
    @test acos(Interval(-1.0, 1.0)) == Interval(0.0, 0x1921fb54442d19p-51)
end

@testset "mpfi_acosh" begin
    # special values
    @test acosh(Interval(+1.0, Inf)) == Interval(0.0, Inf)
    @test acosh(Interval(+1.5, Inf)) == Interval(0x1ecc2caec51609p-53, Inf)
    # regular values
    @test acosh(Interval(1.0, 1.5)) == Interval(0.0, 0xf661657628b05p-52)
    @test acosh(Interval(1.5, 1.5)) == Interval(0x1ecc2caec51609p-53, 0xf661657628b05p-52)
    @test acosh(Interval(2.0, 1000.0)) == Interval(0x544909c66010dp-50, 0x799d4ba2a13b5p-48)
end

@testset "mpfi_add" begin
    # special values
    @test Interval(-Inf, -7.0) + Interval(-1.0, +8.0) == Interval(-Inf, +1.0)
    @test Interval(-Inf, 0.0) + Interval(+8.0, Inf) == entireinterval(Float64)
    @test Interval(-Inf, +8.0) + Interval(0.0, +8.0) == Interval(-Inf, +16.0)
    @test entireinterval(Float64) + Interval(0.0, +8.0) == entireinterval(Float64)
    @test Interval(0.0, 0.0) + Interval(-Inf, -7.0) == Interval(-Inf, -7.0)
    @test Interval(0.0, +8.0) + Interval(-7.0, 0.0) == Interval(-7.0, +8.0)
    @test Interval(0.0, 0.0) + Interval(0.0, +8.0) == Interval(0.0, +8.0)
    @test Interval(0.0, Inf) + Interval(0.0, +8.0) == Interval(0.0, Inf)
    @test Interval(0.0, 0.0) + Interval(+8.0, Inf) == Interval(+8.0, Inf)
    @test Interval(0.0, 0.0) + entireinterval(Float64) == entireinterval(Float64)
    @test Interval(0.0, +8.0) + Interval(0.0, +8.0) == Interval(0.0, +16.0)
    @test Interval(0.0, 0.0) + Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, Inf) + Interval(-7.0, +8.0) == Interval(-7.0, Inf)
    # regular values
    @test Interval(-0.375, -0x10187p-256) + Interval(-0.125, 0x1p-240) == Interval(-0x1p-1, -0x187p-256)
    @test Interval(-0x1p-300, 0x123456p+28) + Interval(-0x10000000000000p-93, 0x789abcdp0) == Interval(-0x10000000000001p-93, 0x123456789abcdp0)
    @test Interval(-4.0, +7.0) + Interval(-0x123456789abcdp-17, 3e300) == Interval(-0x123456791abcdp-17, 0x8f596b3002c1bp+947)
    @test Interval(0x1000100010001p+8, 0x1p+60) + Interval(0x1000100010001p0, 3.0e300) == Interval(+0x1010101010101p+8, 0x8f596b3002c1bp+947)
    # signed zeros
    @test Interval(+4.0, +8.0) + Interval(-4.0, -2.0) == Interval(0.0, +6.0)
    @test Interval(+4.0, +8.0) + Interval(-9.0, -8.0) == Interval(-5.0, 0.0)
end

@testset "mpfi_add_d" begin
    # special values
    @test Interval(-Inf, -7.0) + Interval(-0x170ef54646d497p-107, -0x170ef54646d497p-107) == Interval(-Inf, -7.0)
    @test Interval(-Inf, -7.0) + Interval(0.0, 0.0) == Interval(-Inf, -7.0)
    @test Interval(-Inf, -7.0) + Interval(0x170ef54646d497p-107, 0x170ef54646d497p-107) == Interval(-Inf, -0x1bffffffffffffp-50)
    @test Interval(-Inf, 0.0) + Interval(-0x170ef54646d497p-106, -0x170ef54646d497p-106) == Interval(-Inf, -8.0e-17)
    @test Interval(-Inf, 0.0) + Interval(0.0, 0.0) == Interval(-Inf, 0.0)
    @test Interval(-Inf, 0.0) + Interval(0x170ef54646d497p-106, 0x170ef54646d497p-106) == Interval(-Inf, 0x170ef54646d497p-106)
    @test Interval(-Inf, 8.0) + Interval(-0x16345785d8a00000p0, -0x16345785d8a00000p0) == Interval(-Inf, -0x16345785d89fff00p0)
    @test Interval(-Inf, 8.0) + Interval(0.0, 0.0) == Interval(-Inf, 8.0)
    @test Interval(-Inf, 8.0) + Interval(0x16345785d8a00000p0, 0x16345785d8a00000p0) == Interval(-Inf, 0x16345785d8a00100p0)
    @test entireinterval(Float64) + Interval(-0x170ef54646d497p-105, -0x170ef54646d497p-105) == entireinterval(Float64)
    @test entireinterval(Float64) + Interval(0.0e-17, 0.0e-17) == entireinterval(Float64)
    @test entireinterval(Float64) + Interval(+0x170ef54646d497p-105, +0x170ef54646d497p-105) == entireinterval(Float64)
    @test Interval(0.0, 0.0) + Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109) == Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)
    @test Interval(0.0, 0.0) + Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) + Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109) == Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109)
    @test Interval(0.0, 8.0) + Interval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107) == Interval(-0x114b37f4b51f71p-107, 8.0)
    @test Interval(0.0, 8.0) + Interval(0.0, 0.0) == Interval(0.0, 8.0)
    @test Interval(0.0, 8.0) + Interval(0x114b37f4b51f7p-103, 0x114b37f4b51f7p-103) == Interval(0x114b37f4b51f7p-103, 0x10000000000001p-49)
    @test Interval(0.0, Inf) + Interval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104) == Interval(-0x50b45a75f7e81p-104, Inf)
    @test Interval(0.0, Inf) + Interval(0.0, 0.0) == Interval(0.0, Inf)
    @test Interval(0.0, Inf) + Interval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106) == Interval(0x142d169d7dfa03p-106, Inf)
    # regular values
    @test Interval(-32.0, -17.0) + Interval(-0xfb53d14aa9c2fp-47, -0xfb53d14aa9c2fp-47) == Interval(-0x1fb53d14aa9c2fp-47, -0x18353d14aa9c2fp-47)
    @test Interval(-0xfb53d14aa9c2fp-47, -17.0) + Interval(0xfb53d14aa9c2fp-47, 0xfb53d14aa9c2fp-47) == Interval(0.0, 0x7353d14aa9c2fp-47)
    @test Interval(-32.0, -0xfb53d14aa9c2fp-48) + Interval(0xfb53d14aa9c2fp-48, 0xfb53d14aa9c2fp-48) == Interval(-0x104ac2eb5563d1p-48, 0.0)
    @test Interval(0x123456789abcdfp-48, 0x123456789abcdfp-4) + Interval(3.5, 3.5) == Interval(0x15b456789abcdfp-48, 0x123456789abd17p-4)
    @test Interval(0x123456789abcdfp-56, 0x123456789abcdfp-4) + Interval(3.5, 3.5) == Interval(0x3923456789abcdp-52, 0x123456789abd17p-4)
    @test Interval(-0xffp0, 0x123456789abcdfp-52) + Interval(256.5, 256.5) == Interval(0x18p-4, 0x101a3456789abdp-44)
    @test Interval(-0x1fffffffffffffp-52, -0x1p-550) + Interval(4097.5, 4097.5) == Interval(0xfff8p-4, 0x10018p-4)
    @test Interval(0x123456789abcdfp-48, 0x123456789abcdfp-4) + Interval(-3.5, -3.5) == Interval(0xeb456789abcdfp-48, 0x123456789abca7p-4)
    @test Interval(0x123456789abcdfp-56, 0x123456789abcdfp-4) + Interval(-3.5, -3.5) == Interval(-0x36dcba98765434p-52, 0x123456789abca7p-4)
    @test Interval(-0xffp0, 0x123456789abcdfp-52) + Interval(-256.5, -256.5) == Interval(-0x1ff8p-4, -0xff5cba9876543p-44)
    @test Interval(-0x1fffffffffffffp-52, -0x1p-550) + Interval(-4097.5, -4097.5) == Interval(-0x10038p-4, -0x10018p-4)
end

@testset "mpfi_asin" begin
    # special values
    @test asin(Interval(-1.0, 0.0)) == Interval(-0x1921fb54442d19p-52, 0.0)
    @test asin(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test asin(Interval(0.0, +1.0)) == Interval(0.0, 0x1921fb54442d19p-52)
    # regular values
    @test asin(Interval(-1.0, -0.5)) == Interval(-0x1921fb54442d19p-52, -0x10c152382d7365p-53)
    @test asin(Interval(-0.75, -0.25)) == Interval(-0x1b235315c680ddp-53, -0x102be9ce0b87cdp-54)
    @test asin(Interval(-0.5, 0.5)) == Interval(-0x860a91c16b9b3p-52, 0x860a91c16b9b3p-52)
    @test asin(Interval(0.25, 0.625)) == Interval(0x102be9ce0b87cdp-54, 0x159aad71ced00fp-53)
    @test asin(Interval(-1.0, 1.0)) == Interval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)
end

@testset "mpfi_asinh" begin
    # special values
    @test asinh(Interval(-Inf, -7.0)) == Interval(-Inf, -0x152728c91b5f1dp-51)
    @test asinh(Interval(-Inf, 0.0)) == Interval(-Inf, 0.0)
    @test asinh(Interval(-Inf, +8.0)) == Interval(-Inf, 0x58d8dc657eaf5p-49)
    @test asinh(entireinterval(Float64)) == entireinterval(Float64)
    @test asinh(Interval(-1.0, 0.0)) == Interval(-0x1c34366179d427p-53, 0.0)
    @test asinh(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test asinh(Interval(0.0, +1.0)) == Interval(0.0, 0x1c34366179d427p-53)
    @test asinh(Interval(0.0, +8.0)) == Interval(0.0, 0x58d8dc657eaf5p-49)
    @test asinh(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test asinh(Interval(-6.0, -4.0)) == Interval(-0x4fbca919fe219p-49, -0x10c1f8a6e80eebp-51)
    @test asinh(Interval(-2.0, -0.5)) == Interval(-0x2e32430627a11p-49, -0x1ecc2caec51609p-54)
    @test asinh(Interval(-1.0, -0.5)) == Interval(-0x1c34366179d427p-53, -0x1ecc2caec51609p-54)
    @test asinh(Interval(-0.75, -0.25)) == Interval(-0x162e42fefa39fp-49, -0xfd67d91ccf31bp-54)
    @test asinh(Interval(-0.5, 0.5)) == Interval(-0xf661657628b05p-53, 0xf661657628b05p-53)
    @test asinh(Interval(0.25, 0.625)) == Interval(0xfd67d91ccf31bp-54, 0x4b89d40b2fecdp-51)
    @test asinh(Interval(-1.0, 1.0)) == Interval(-0x1c34366179d427p-53, 0x1c34366179d427p-53)
    @test asinh(Interval(0.125, 17.0)) == Interval(0xff5685b4cb4b9p-55, 0xe1be0ba541ef7p-50)
    @test asinh(Interval(17.0, 42.0)) == Interval(0x1c37c174a83dedp-51, 0x8dca6976ad6bdp-49)
    @test asinh(Interval(-42.0, 17.0)) == Interval(-0x8dca6976ad6bdp-49, 0xe1be0ba541ef7p-50)
end

@testset "mpfi_atan" begin
    # special values
    @test atan(Interval(-Inf, -7.0)) == Interval(-0x1921fb54442d19p-52, -0x5b7315eed597fp-50)
    @test atan(Interval(-Inf, 0.0)) == Interval(-0x1921fb54442d19p-52, 0.0)
    @test atan(Interval(-Inf, +8.0)) == Interval(-0x1921fb54442d19p-52, 0xb924fd54cb511p-51)
    @test atan(entireinterval(Float64)) == Interval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)
    @test atan(Interval(-1.0, 0.0)) == Interval(-0x1921fb54442d19p-53, 0.0)
    @test atan(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test atan(Interval(0.0, +1.0)) == Interval(0.0, 0x1921fb54442d19p-53)
    @test atan(Interval(0.0, +8.0)) == Interval(0.0, 0xb924fd54cb511p-51)
    @test atan(Interval(0.0, Inf)) == Interval(0.0, 0x1921fb54442d19p-52)
    # regular values
    @test atan(Interval(-6.0, -4.0)) == Interval(-0x167d8863bc99bdp-52, -0x54da32547a73fp-50)
    @test atan(Interval(-2.0, -0.5)) == Interval(-0x11b6e192ebbe45p-52, -0x1dac670561bb4fp-54)
    @test atan(Interval(-1.0, -0.5)) == Interval(-0x1921fb54442d19p-53, -0x1dac670561bb4fp-54)
    @test atan(Interval(-0.75, -0.25)) == Interval(-0xa4bc7d1934f71p-52, -0x1f5b75f92c80ddp-55)
    @test atan(Interval(-0.5, 0.5)) == Interval(-0x1dac670561bb5p-50, 0x1dac670561bb5p-50)
    @test atan(Interval(0.25, 0.625)) == Interval(0x1f5b75f92c80ddp-55, 0x47802eaf7bfadp-51)
    @test atan(Interval(-1.0, 1.0)) == Interval(-0x1921fb54442d19p-53, 0x1921fb54442d19p-53)
    @test atan(Interval(0.125, 17.0)) == Interval(0x1fd5ba9aac2f6dp-56, 0x1831516233f561p-52)
    @test atan(Interval(17.0, 42.0)) == Interval(0xc18a8b119fabp-47, 0x18c079f3350d27p-52)
    @test atan(Interval(-42.0, 17.0)) == Interval(-0x18c079f3350d27p-52, 0x1831516233f561p-52)
end

@testset "mpfi_atan" begin
    # special values
    @test atan(Interval(-Inf, -7.0), Interval(-1.0, +8.0)) == Interval(-0x6d9cc4b34bd0dp-50, -0x1700a7c5784633p-53)
    @test atan(Interval(-Inf, 0.0), Interval(+8.0, Inf)) == Interval(-0x1921fb54442d19p-52, 0.0)
    @test atan(Interval(-Inf, +8.0), Interval(0.0, +8.0)) == Interval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)
    @test atan(entireinterval(Float64), Interval(0.0, +8.0)) == Interval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)
    @test atan(Interval(0.0, 0.0), Interval(-Inf, -7.0)) == Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)
    @test atan(Interval(0.0, +8.0), Interval(-7.0, 0.0)) == Interval(0x3243f6a8885a3p-49, 0x1921fb54442d19p-51)
    @test atan(Interval(0.0, 0.0), Interval(0.0, +8.0)) == Interval(0.0, 0.0)
    @test atan(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, 0x1921fb54442d19p-52)
    @test atan(Interval(0.0, 0.0), Interval(+8.0, Inf)) == Interval(0.0, 0.0)
    @test atan(Interval(0.0, 0.0), entireinterval(Float64)) == Interval(0.0, 0x1921fb54442d19p-51)
    @test atan(Interval(0.0, +8.0), Interval(-7.0, +8.0)) == Interval(0.0, 0x1921fb54442d19p-51)
    @test atan(Interval(0.0, 0.0), Interval(0.0, 0.0)) == ∅
    @test atan(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, 0x1921fb54442d19p-52)
    # regular values
    @test atan(Interval(-17.0, -5.0), Interval(-4002.0, -1.0)) == Interval(-0x191f6c4c09a81bp-51, -0x1a12a5465464cfp-52)
    @test atan(Interval(-17.0, -5.0), Interval(1.0, 4002.0)) == Interval(-0x1831516233f561p-52, -0xa3c20ea13f5e5p-61)
    @test atan(Interval(5.0, 17.0), Interval(1.0, 4002.0)) == Interval(0xa3c20ea13f5e5p-61, 0x1831516233f561p-52)
    @test atan(Interval(5.0, 17.0), Interval(-4002.0, -1.0)) == Interval(0x1a12a5465464cfp-52, 0x191f6c4c09a81bp-51)
    @test atan(Interval(-17.0, 5.0), Interval(-4002.0, 1.0)) == Interval(-0x1921fb54442d19p-51, 0x1921fb54442d19p-51)
end

@testset "mpfi_atanh" begin
    # special values
    @test atanh(Interval(-1.0, 0.0)) == Interval(-Inf, 0.0)
    @test atanh(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test atanh(Interval(0.0, +1.0)) == Interval(0.0, Inf)
    # regular values
    @test atanh(Interval(-1.0, -0.5)) == Interval(-Inf, -0x8c9f53d568185p-52)
    @test atanh(Interval(-0.75, -0.25)) == Interval(-0x3e44e55c64b4bp-50, -0x1058aefa811451p-54)
    @test atanh(Interval(-0.5, 0.5)) == Interval(-0x1193ea7aad030bp-53, 0x1193ea7aad030bp-53)
    @test atanh(Interval(0.25, 0.625)) == Interval(0x1058aefa811451p-54, 0x2eec3bb76c2b3p-50)
    @test atanh(Interval(-1.0, 1.0)) == entireinterval(Float64)
    @test atanh(Interval(0.125, 1.0)) == Interval(0x1015891c9eaef7p-55, Inf)
end

@testset "mpfi_bounded_p" begin
    # special values
    @test iscommon(Interval(-Inf, -8.0)) == false
    @test iscommon(Interval(-Inf, 0.0)) == false
    @test iscommon(Interval(-Inf, 5.0)) == false
    @test iscommon(entireinterval(Float64)) == false
    @test iscommon(Interval(-8.0, 0.0))
    @test iscommon(Interval(0.0, 0.0))
    @test iscommon(Interval(0.0, 5.0))
    @test iscommon(Interval(0.0, Inf)) == false
    @test iscommon(Interval(5.0, Inf)) == false
    # regular values
    @test iscommon(Interval(-34.0, -17.0))
    @test iscommon(Interval(-8.0, -1.0))
    @test iscommon(Interval(-34.0, 17.0))
    @test iscommon(Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51))
    @test iscommon(Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51))
    @test iscommon(Interval(+8.0, +0x7fffffffffffbp+51))
    @test iscommon(Interval(+0x1fffffffffffffp-53, 2.0))
end

@testset "mpfi_cbrt" begin
    # special values
    @test cbrt(Interval(-Inf, -125.0)) == Interval(-Inf, -5.0)
    @test cbrt(Interval(-Inf, 0.0)) == Interval(-Inf, 0.0)
    @test cbrt(Interval(-Inf, +64.0)) == Interval(-Inf, +4.0)
    @test cbrt(entireinterval(Float64)) == entireinterval(Float64)
    @test cbrt(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test cbrt(Interval(0.0, +27.0)) == Interval(0.0, +3.0)
    @test cbrt(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test cbrt(Interval(0x40p0, 0x7dp0)) == Interval(4.0, 5.0)
    @test cbrt(Interval(-0x1856e4be527197p-354, 0xd8p0)) == Interval(-0x2e5e58c0083b7bp-154, 6.0)
    @test cbrt(Interval(0x141a9019a2184dp-1047, 0xc29c78c66ac0fp-678)) == Interval(0x2b8172e535d44dp-385, 0x24cbd1c55aaa1p-258)
end

@testset "mpfi_cos" begin
    # special values
    @test cos(Interval(-Inf, -7.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-Inf, 0.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-Inf, +8.0)) == Interval(-1.0, 1.0)
    @test cos(entireinterval(Float64)) == Interval(-1.0, 1.0)
    @test cos(Interval(-1.0, 0.0)) == Interval(0x114a280fb5068bp-53, 1.0)
    @test cos(Interval(0.0, 0.0)) == Interval(1.0, 1.0)
    @test cos(Interval(0.0, +1.0)) == Interval(0x114a280fb5068bp-53, 1.0)
    @test cos(Interval(0.0, +8.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(0.0, Inf)) == Interval(-1.0, 1.0)
    # regular values
    @test cos(Interval(-2.0, -0.5)) == Interval(-0x1aa22657537205p-54, 0x1c1528065b7d5p-49)
    @test cos(Interval(-1.0, -0.25)) == Interval(0x114a280fb5068bp-53, 0xf80aa4fbef751p-52)
    @test cos(Interval(-0.5, 0.5)) == Interval(0x1c1528065b7d4fp-53, 1.0)
    @test cos(Interval(-4.5, 0.625)) == Interval(-1.0, 1.0)
    @test cos(Interval(1.0, 0x3243f6a8885a3p-48)) == Interval(-1.0, 0x4528a03ed41a3p-51)
    @test cos(Interval(0.125, 17.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(17.0, 42.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-7.0, 1.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-7.0, 0.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-7.0, -1.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-7.0, -2.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-7.0, -3.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-7.0, -4.0)) == Interval(-0x14eaa606db24c1p-53, 1.0)
    @test cos(Interval(-7.0, -5.0)) == Interval(0x122785706b4ad9p-54, 1.0)
    @test cos(Interval(-7.0, -6.0)) == Interval(0x181ff79ed92017p-53, 1.0)
    @test cos(Interval(-7.0, -7.0)) == Interval(0x181ff79ed92017p-53, 0x181ff79ed92018p-53)
    @test cos(Interval(-6.0, 1.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-6.0, 0.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-6.0, -1.0)) == Interval(-1.0, 0x1eb9b7097822f6p-53)
    @test cos(Interval(-6.0, -2.0)) == Interval(-1.0, 0x1eb9b7097822f6p-53)
    @test cos(Interval(-6.0, -3.0)) == Interval(-1.0, 0x1eb9b7097822f6p-53)
    @test cos(Interval(-6.0, -4.0)) == Interval(-0x14eaa606db24c1p-53, 0x1eb9b7097822f6p-53)
    @test cos(Interval(-6.0, -5.0)) == Interval(0x122785706b4ad9p-54, 0x1eb9b7097822f6p-53)
    @test cos(Interval(-6.0, -6.0)) == Interval(0x1eb9b7097822f5p-53, 0x1eb9b7097822f6p-53)
    @test cos(Interval(-5.0, 1.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-5.0, 0.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-5.0, -1.0)) == Interval(-1.0, 0x114a280fb5068cp-53)
    @test cos(Interval(-5.0, -2.0)) == Interval(-1.0, 0x122785706b4adap-54)
    @test cos(Interval(-5.0, -3.0)) == Interval(-1.0, 0x122785706b4adap-54)
    @test cos(Interval(-5.0, -4.0)) == Interval(-0x14eaa606db24c1p-53, 0x122785706b4adap-54)
    @test cos(Interval(-5.0, -5.0)) == Interval(0x122785706b4ad9p-54, 0x122785706b4adap-54)
    @test cos(Interval(-4.0, 1.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-4.0, 0.0)) == Interval(-1.0, 1.0)
    @test cos(Interval(-4.0, -1.0)) == Interval(-1.0, 0x114a280fb5068cp-53)
    @test cos(Interval(-4.0, -2.0)) == Interval(-1.0, -0x1aa22657537204p-54)
    @test cos(Interval(-4.0, -3.0)) == Interval(-1.0, -0x14eaa606db24c0p-53)
    @test cos(Interval(-4.0, -4.0)) == Interval(-0x14eaa606db24c1p-53, -0x14eaa606db24c0p-53)
end

@testset "mpfi_cosh" begin
    # special values
    @test cosh(Interval(-Inf, -7.0)) == Interval(0x11228949ba3a8bp-43, Inf)
    @test cosh(Interval(-Inf, 0.0)) == Interval(1.0, Inf)
    @test cosh(Interval(-Inf, +8.0)) == Interval(1.0, Inf)
    @test cosh(entireinterval(Float64)) == Interval(1.0, Inf)
    @test cosh(Interval(-1.0, 0.0)) == Interval(1.0, 0x18b07551d9f551p-52)
    @test cosh(Interval(0.0, 0.0)) == Interval(1.0, 1.0)
    @test cosh(Interval(0.0, +1.0)) == Interval(1.0, 0x18b07551d9f551p-52)
    @test cosh(Interval(0.0, +8.0)) == Interval(1.0, 0x1749eaa93f4e77p-42)
    @test cosh(Interval(0.0, Inf)) == Interval(1.0, Inf)
    # regular values
    @test cosh(Interval(-0.125, 0.0)) == Interval(1.0, 0x10200aac16db6fp-52)
    @test cosh(Interval(0.0, 0x10000000000001p-53)) == Interval(1.0, 0x120ac1862ae8d1p-52)
    @test cosh(Interval(-4.5, -0.625)) == Interval(0x99d310a496b6dp-51, 0x1681ceb0641359p-47)
    @test cosh(Interval(1.0, 3.0)) == Interval(0x18b07551d9f55p-48, 0x1422a497d6185fp-49)
    @test cosh(Interval(17.0, 0xb145bb71d3dbp-38)) == Interval(0x1709348c0ea503p-29, 0x3ffffffffffa34p+968)
end

@testset "mpfi_cot" begin
    # special values
    @test cot(Interval(-Inf, -7.0)) == entireinterval(Float64)
    @test cot(Interval(-Inf, 0.0)) == entireinterval(Float64)
    @test cot(Interval(-Inf, +8.0)) == entireinterval(Float64)
    @test cot(entireinterval(Float64)) == entireinterval(Float64)
    @test cot(Interval(-8.0, 0.0)) == entireinterval(Float64)
    @test cot(Interval(-3.0, 0.0)) == Interval(-Inf, 0xe07cf2eb32f0bp-49)
    @test cot(Interval(-1.0, 0.0)) == Interval(-Inf, -0x148c05d04e1cfdp-53)
    @test cot(Interval(0.0, +1.0)) == Interval(0x148c05d04e1cfdp-53, Inf)
    @test cot(Interval(0.0, +3.0)) == Interval(-0xe07cf2eb32f0bp-49, Inf)
    @test cot(Interval(0.0, +8.0)) == entireinterval(Float64)
    @test cot(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test cot(Interval(-3.0, -2.0)) == Interval(0x1d4a42e92faa4dp-54, 0xe07cf2eb32f0bp-49)
    @test cot(Interval(-3.0, -0x1921fb54442d19p-52)) == Interval(0x5cb3b399d747fp-103, 0xe07cf2eb32f0bp-49)
    @test cot(Interval(-2.0, 0x1921fb54442d19p-52)) == entireinterval(Float64)
    @test cot(Interval(0.125, 0.5)) == Interval(0xea4d6bf23e051p-51, 0x1fd549f047f2bbp-50)
    @test cot(Interval(0.125, 0x1921fb54442d19p-52)) == Interval(-0x172cece675d1fdp-105, 0x1fd549f047f2bbp-50)
    @test cot(Interval(0x1921fb54442d19p-52, 4.0)) == entireinterval(Float64)
    @test cot(Interval(4.0, 0x3243f6a8885a3p-47)) == Interval(-0x1d02967c31cdb5p-1, 0x1ba35ba1c6b75dp-53)
    @test cot(Interval(0x13a28c59d5433bp-44, 0x9d9462ceaa19dp-43)) == Interval(0x148c05d04e1fb7p-53, 0x1cefdde7c84c27p-4)
end

@testset "mpfi_coth" begin
    # special values
    @test coth(Interval(-Inf, -7.0)) == Interval(-0x100001be6c882fp-52, -1.0)
    @test coth(Interval(-Inf, 0.0)) == Interval(-Inf, -1.0)
    @test coth(Interval(-Inf, +8.0)) == entireinterval(Float64)
    @test coth(entireinterval(Float64)) == entireinterval(Float64)
    @test coth(Interval(-8.0, 0.0)) == Interval(-Inf, -0x1000003c6ab7e7p-52)
    @test coth(Interval(-3.0, 0.0)) == Interval(-Inf, -0x10145b3cc9964bp-52)
    @test coth(Interval(-1.0, 0.0)) == Interval(-Inf, -0x150231499b6b1dp-52)
    @test coth(Interval(0.0, 0.0)) == ∅
    @test coth(Interval(0.0, +1.0)) == Interval(0x150231499b6b1dp-52, Inf)
    @test coth(Interval(0.0, +3.0)) == Interval(0x10145b3cc9964bp-52, Inf)
    @test coth(Interval(0.0, +8.0)) == Interval(0x1000003c6ab7e7p-52, Inf)
    @test coth(Interval(0.0, Inf)) == Interval(1.0, Inf)
    # regular values
    @test coth(Interval(-3.0, 2.0)) == entireinterval(Float64)
    @test coth(Interval(-10.0, -8.0)) == Interval(-0x1000003c6ab7e8p-52, -0x100000011b4865p-52)
    @test coth(Interval(7.0, 17.0)) == Interval(0x1000000000000fp-52, 0x100001be6c882fp-52)
    @test coth(Interval(0x10000000000001p-58, 0x10000000000001p-53)) == Interval(0x114fc6ceb099bdp-51, 0x10005554fa502fp-46)
end

@testset "mpfi_csc" begin
    # special values
    @test csc(Interval(-Inf, -7.0)) == entireinterval(Float64)
    @test csc(Interval(-Inf, 0.0)) == entireinterval(Float64)
    @test csc(Interval(-Inf, 8.0)) == entireinterval(Float64)
    @test csc(entireinterval(Float64)) == entireinterval(Float64)
    @test csc(Interval(-8.0, 0.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 0.0)) == Interval(-Inf, -1.0)
    @test csc(Interval(-1.0, 0.0)) == Interval(-Inf, -0x1303aa9620b223p-52)
    @test csc(Interval(0.0, 0.0)) == ∅
    @test csc(Interval(0.0, +1.0)) == Interval(0x1303aa9620b223p-52, Inf)
    @test csc(Interval(0.0, 3.0)) == Interval(1.0, Inf)
    @test csc(Interval(0.0, 8.0)) == entireinterval(Float64)
    @test csc(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test csc(Interval(-6.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 3.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 2.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 1.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, 0.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, -1.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, -2.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, -3.0)) == entireinterval(Float64)
    @test csc(Interval(-6.0, -4.0)) == Interval(1.0, 0x1ca19615f903dap-51)
    @test csc(Interval(-6.0, -5.0)) == Interval(0x10af73f9df86b7p-52, 0x1ca19615f903dap-51)
    @test csc(Interval(-6.0, -6.0)) == Interval(0x1ca19615f903d9p-51, 0x1ca19615f903dap-51)
    @test csc(Interval(-5.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 3.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 2.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 1.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, 0.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, -1.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, -2.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, -3.0)) == entireinterval(Float64)
    @test csc(Interval(-5.0, -4.0)) == Interval(1.0, 0x15243e8b2f4642p-52)
    @test csc(Interval(-5.0, -5.0)) == Interval(0x10af73f9df86b7p-52, 0x10af73f9df86b8p-52)
    @test csc(Interval(-4.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 3.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 2.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 1.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, 0.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, -1.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, -2.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, -3.0)) == entireinterval(Float64)
    @test csc(Interval(-4.0, -4.0)) == Interval(0x15243e8b2f4641p-52, 0x15243e8b2f4642p-52)
    @test csc(Interval(-3.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 3.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 2.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 1.0)) == entireinterval(Float64)
    @test csc(Interval(-3.0, 0.0)) == Interval(-Inf, -1.0)
    @test csc(Interval(-3.0, -1.0)) == Interval(-0x1c583c440ab0dap-50, -1.0)
    @test csc(Interval(-3.0, -2.0)) == Interval(-0x1c583c440ab0dap-50, -0x119893a272f912p-52)
    @test csc(Interval(-3.0, -3.0)) == Interval(-0x1c583c440ab0dap-50, -0x1c583c440ab0d9p-50)
    @test csc(Interval(-2.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 3.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 2.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 1.0)) == entireinterval(Float64)
    @test csc(Interval(-2.0, 0.0)) == Interval(-Inf, -1.0)
    @test csc(Interval(-2.0, -1.0)) == Interval(-0x1303aa9620b224p-52, -1.0)
    @test csc(Interval(-2.0, -2.0)) == Interval(-0x119893a272f913p-52, -0x119893a272f912p-52)
    @test csc(Interval(-1.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 3.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 2.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 1.0)) == entireinterval(Float64)
    @test csc(Interval(-1.0, 0.0)) == Interval(-Inf, -0x1303aa9620b223p-52)
    @test csc(Interval(-1.0, -1.0)) == Interval(-0x1303aa9620b224p-52, -0x1303aa9620b223p-52)
    @test csc(Interval(1.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(1.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(1.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(1.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(1.0, 3.0)) == Interval(1.0, 0x1c583c440ab0dap-50)
    @test csc(Interval(1.0, 2.0)) == Interval(1.0, 0x1303aa9620b224p-52)
    @test csc(Interval(1.0, 1.0)) == Interval(0x1303aa9620b223p-52, 0x1303aa9620b224p-52)
    @test csc(Interval(2.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(2.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(2.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(2.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(2.0, 3.0)) == Interval(0x119893a272f912p-52, 0x1c583c440ab0dap-50)
    @test csc(Interval(2.0, 2.0)) == Interval(0x119893a272f912p-52, 0x119893a272f913p-52)
    @test csc(Interval(3.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(3.0, 6.0)) == entireinterval(Float64)
    @test csc(Interval(3.0, 5.0)) == entireinterval(Float64)
    @test csc(Interval(3.0, 4.0)) == entireinterval(Float64)
    @test csc(Interval(3.0, 3.0)) == Interval(0x1c583c440ab0d9p-50, 0x1c583c440ab0dap-50)
    @test csc(Interval(4.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(4.0, 6.0)) == Interval(-0x1ca19615f903dap-51, -1.0)
    @test csc(Interval(4.0, 5.0)) == Interval(-0x15243e8b2f4642p-52, -1.0)
    @test csc(Interval(4.0, 4.0)) == Interval(-0x15243e8b2f4642p-52, -0x15243e8b2f4641p-52)
    @test csc(Interval(5.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(5.0, 6.0)) == Interval(-0x1ca19615f903dap-51, -0x10af73f9df86b7p-52)
    @test csc(Interval(5.0, 5.0)) == Interval(-0x10af73f9df86b8p-52, -0x10af73f9df86b7p-52)
    @test csc(Interval(6.0, 7.0)) == entireinterval(Float64)
    @test csc(Interval(6.0, 6.0)) == Interval(-0x1ca19615f903dap-51, -0x1ca19615f903d9p-51)
    @test csc(Interval(7.0, 7.0)) == Interval(+0x185a86a4ceb06cp-52, +0x185a86a4ceb06dp-52)
end

@testset "mpfi_csch" begin
    # special values
    @test csch(Interval(-Inf, -7.0)) == Interval(-0x1de16d3cffcd54p-62, 0.0)
    @test csch(Interval(-Inf, 0.0)) == Interval(-Inf, 0.0)
    @test csch(Interval(-Inf, +8.0)) == entireinterval(Float64)
    @test csch(entireinterval(Float64)) == entireinterval(Float64)
    @test csch(Interval(-8.0, 0.0)) == Interval(-Inf, -0x15fc212d92371ap-63)
    @test csch(Interval(-3.0, 0.0)) == Interval(-Inf, -0x198de80929b901p-56)
    @test csch(Interval(-1.0, 0.0)) == Interval(-Inf, -0x1b3ab8a78b90c0p-53)
    @test csch(Interval(0.0, 0.0)) == ∅
    @test csch(Interval(0.0, +1.0)) == Interval(0x1b3ab8a78b90c0p-53, Inf)
    @test csch(Interval(0.0, +3.0)) == Interval(0x198de80929b901p-56, Inf)
    @test csch(Interval(0.0, +8.0)) == Interval(0x15fc212d92371ap-63, Inf)
    @test csch(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test csch(Interval(-3.0, 2.0)) == entireinterval(Float64)
    @test csch(Interval(-10.0, -8.0)) == Interval(-0x15fc212d92371bp-63, -0x17cd79b63733a0p-66)
    @test csch(Interval(7.0, 17.0)) == Interval(0x1639e3175a68a7p-76, 0x1de16d3cffcd54p-62)
    @test csch(Interval(0x10000000000001p-58, 0x10000000000001p-53)) == Interval(0x1eb45dc88defeap-52, 0x3fff555693e722p-48)
end

@testset "mpfi_d_div" begin
    # special values
    @test Interval(-0x170ef54646d496p-107, -0x170ef54646d496p-107) / Interval(-Inf, -7.0) == Interval(0.0, 0x1a5a3ce29a1787p-110)
    @test Interval(0.0, 0.0) / Interval(-Inf, -7.0) == Interval(0.0, 0.0)
    @test Interval(0x170ef54646d496p-107, 0x170ef54646d496p-107) / Interval(-Inf, -7.0) == Interval(-0x1a5a3ce29a1787p-110, 0.0)
    @test Interval(-0x170ef54646d497p-106, -0x170ef54646d497p-106) / Interval(-Inf, 0.0) == Interval(0.0, Inf)
    @test Interval(0.0, 0.0) / Interval(-Inf, 0.0) == Interval(0.0, 0.0)
    @test Interval(0x170ef54646d497p-106, 0x170ef54646d497p-106) / Interval(-Inf, 0.0) == Interval(-Inf, 0.0)
    @test Interval(-0x16345785d8a00000p0, -0x16345785d8a00000p0) / Interval(-Inf, 8.0) == entireinterval(Float64)
    @test Interval(0.0, 0.0) / Interval(-Inf, 8.0) == Interval(0.0, 0.0)
    @test Interval(0x16345785d8a00000p0, 0x16345785d8a00000p0) / Interval(-Inf, 8.0) == entireinterval(Float64)
    @test Interval(-0x170ef54646d497p-105, -0x170ef54646d497p-105) / entireinterval(Float64) == entireinterval(Float64)
    @test Interval(0.0e-17, 0.0e-17) / entireinterval(Float64) == Interval(0.0, 0.0)
    @test Interval(+0x170ef54646d497p-105, +0x170ef54646d497p-105) / entireinterval(Float64) == entireinterval(Float64)
    @test Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109) / Interval(0.0, 0.0) == ∅
    @test Interval(0.0, 0.0) / Interval(0.0, 0.0) == ∅
    @test Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109) / Interval(0.0, 0.0) == ∅
    @test Interval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107) / Interval(0.0, 7.0) == Interval(-Inf, -0x13c3ada9f391a5p-110)
    @test Interval(0.0, 0.0) / Interval(0.0, 7.0) == Interval(0.0, 0.0)
    @test Interval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107) / Interval(0.0, 7.0) == Interval(0x13c3ada9f391a5p-110, Inf)
    @test Interval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104) / Interval(0.0, Inf) == Interval(-Inf, 0.0)
    @test Interval(0.0, 0.0) / Interval(0.0, Inf) == Interval(0.0, 0.0)
    @test Interval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106) / Interval(0.0, Inf) == Interval(0.0, Inf)
    # regular values
    @test Interval(-2.5, -2.5) / Interval(-8.0, 8.0) == entireinterval(Float64)
    @test Interval(-2.5, -2.5) / Interval(-8.0, -5.0) == Interval(0x5p-4, 0.5)
    @test Interval(-2.5, -2.5) / Interval(25.0, 40.0) == Interval(-0x1999999999999ap-56, -0x1p-4)
    @test Interval(-2.5, -2.5) / Interval(-16.0, -7.0) == Interval(0x5p-5, 0x16db6db6db6db7p-54)
    @test Interval(-2.5, -2.5) / Interval(11.0, 143.0) == Interval(-0x1d1745d1745d18p-55, -0x11e6efe35b4cfap-58)
    @test Interval(33.125, 33.125) / Interval(8.28125, 530.0) == Interval(0x1p-4, 4.0)
    @test Interval(33.125, 33.125) / Interval(-530.0, -496.875) == Interval(-0x11111111111112p-56, -0x1p-4)
    @test Interval(33.125, 33.125) / Interval(54.0, 265.0) == Interval(0.125, 0x13a12f684bda13p-53)
    @test Interval(33.125, 33.125) / Interval(52.0, 54.0) == Interval(0x13a12f684bda12p-53, 0x14627627627628p-53)
end

@testset "mpfi_diam_abs" begin
    # special values
    @test diam(Interval(-Inf, -8.0)) == Inf
    @test diam(Interval(-Inf, 0.0)) == Inf
    @test diam(Interval(-Inf, 5.0)) == Inf
    @test diam(entireinterval(Float64)) == Inf
    @test diam(Interval(-Inf, 0.0)) == Inf
    @test diam(Interval(-8.0, 0.0)) == +8
    @test diam(Interval(0.0, 0.0)) == -0
    @test diam(Interval(0.0, 5.0)) == +5
    @test diam(Interval(0.0, Inf)) == Inf
    # regular values
    @test diam(Interval(-34.0, -17.0)) == 17
end

@testset "mpfi_div" begin
    # special values
    @test Interval(-Inf, -7.0) / Interval(-1.0, +8.0) == entireinterval(Float64)
    @test Interval(-Inf, 0.0) / Interval(+8.0, Inf) == Interval(-Inf, 0.0)
    @test Interval(-Inf, +8.0) / Interval(0.0, +8.0) == entireinterval(Float64)
    @test entireinterval(Float64) / Interval(0.0, +8.0) == entireinterval(Float64)
    @test Interval(0.0, 0.0) / Interval(-Inf, -7.0) == Interval(0.0, 0.0)
    @test Interval(0.0, +8.0) / Interval(-7.0, 0.0) == Interval(-Inf, 0.0)
    @test Interval(0.0, 0.0) / Interval(0.0, +8.0) == Interval(0.0, 0.0)
    @test Interval(0.0, Inf) / Interval(0.0, +8.0) == Interval(0.0, Inf)
    @test Interval(0.0, 0.0) / Interval(+8.0, Inf) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) / entireinterval(Float64) == Interval(0.0, 0.0)
    @test Interval(0.0, +8.0) / Interval(-7.0, +8.0) == entireinterval(Float64)
    @test Interval(0.0, Inf) / Interval(0.0, +8.0) == Interval(0.0, Inf)
    # regular value
    @test Interval(-0x75bcd15p0, -0x754ep0) / Interval(-0x11ep0, -0x9p0) == Interval(0x69p0, 0xd14fadp0)
    @test Interval(-0x75bcd15p0, -0x1.489c07caba163p-4) / Interval(-0x2.e8e36e560704ap+4, -0x9p0) == Interval(0x7.0ef61537b1704p-12, 0xd14fadp0)
    @test Interval(-0x1.02f0415f9f596p+0, -0x754ep-16) / Interval(-0x11ep0, -0x7.62ce64fbacd2cp-8) == Interval(0x69p-16, 0x2.30ee5eef9c36cp+4)
    @test Interval(-0x1.02f0415f9f596p+0, -0x1.489c07caba163p-4) / Interval(-0x2.e8e36e560704ap+0, -0x7.62ce64fbacd2cp-8) == Interval(0x7.0ef61537b1704p-8, 0x2.30ee5eef9c36cp+4)
    @test Interval(-0xacbp+256, -0x6f9p0) / Interval(-0x7p0, 0.0) == Interval(0xffp0, Inf)
    @test Interval(-0x100p0, -0xe.bb80d0a0824ep-4) / Interval(-0x1.7c6d760a831fap+0, 0.0) == Interval(0x9.e9f24790445fp-4, Inf)
    @test Interval(-0x1.25f2d73472753p+0, -0x9.9a19fd3c1fc18p-4) / Interval(-0x9.3b0c8074ccc18p-4, +0x4.788df5d72af78p-4) == entireinterval(Float64)
    @test Interval(-100.0, -15.0) / Interval(0.0, +3.0) == Interval(-Inf, -5.0)
    @test Interval(-2.0, -0x1.25f2d73472753p+0) / Interval(0.0, +0x9.3b0c8074ccc18p-4) == Interval(-Inf, -0x1.fd8457415f917p+0)
    @test Interval(-0x123456789p0, -0x754ep+4) / Interval(0x40bp0, 0x11ep+4) == Interval(-0x480b3bp0, -0x69p0)
    @test Interval(-0xd.67775e4b8588p-4, -0x754ep-53) / Interval(0x4.887091874ffc8p+0, 0x11ep+201) == Interval(-0x2.f5008d2df94ccp-4, -0x69p-254)
    @test Interval(-0x123456789p0, -0x1.b0a62934c76e9p+0) / Interval(0x40bp-17, 0x2.761ec797697a4p-4) == Interval(-0x480b3bp+17, -0xa.fc5e7338f3e4p+0)
    @test Interval(-0xd.67775e4b8588p+0, -0x1.b0a62934c76e9p+0) / Interval(0x4.887091874ffc8p-4, 0x2.761ec797697a4p+4) == Interval(-0x2.f5008d2df94ccp+4, -0xa.fc5e7338f3e4p-8)
    @test Interval(-0x75bcd15p0, 0.0) / Interval(-0x90p0, -0x9p0) == Interval(0.0, 0xd14fadp0)
    @test Interval(-0x1.4298b2138f2a7p-4, 0.0) / Interval(-0x1p-8, -0xf.5e4900c9c19fp-12) == Interval(0.0, 0x1.4fdb41a33d6cep+4)
    @test Interval(-0xeeeeeeeeep0, 0.0) / Interval(-0xaaaaaaaaap0, 0.0) == Interval(0.0, Inf)
    @test Interval(-0x1.25f2d73472753p+0, 0.0) / Interval(-0x9.3b0c8074ccc18p-4, +0x4.788df5d72af78p-4) == entireinterval(Float64)
    @test Interval(-0xeeeeeeeeep0, 0.0) / Interval(0.0, +0x3p0) == Interval(-Inf, 0.0)
    @test Interval(-0x75bcd15p0, 0.0) / Interval(0x9p0, 0x90p0) == Interval(-0xd14fadp0, 0.0)
    @test Interval(-0x1.4298b2138f2a7p-4, 0.0) / Interval(0xf.5e4900c9c19fp-12, 0x9p0) == Interval(-0x1.4fdb41a33d6cep+4, 0.0)
    @test Interval(-0x75bcd15p0, 0xa680p0) / Interval(-0xaf6p0, -0x9p0) == Interval(-0x1280p0, 0xd14fadp0)
    @test Interval(-0x12p0, 0x10p0) / Interval(-0xbbbbbbbbbbp0, -0x9p0) == Interval(-0x1.c71c71c71c71dp0, 2.0)
    @test Interval(-0x1p0, 0x754ep-16) / Interval(-0xccccccccccp0, -0x11ep0) == Interval(-0x69p-16, 0xe.525982af70c9p-12)
    @test Interval(-0xb.5b90b4d32136p-4, 0x6.e694ac6767394p+0) / Interval(-0xdddddddddddp0, -0xc.f459be9e80108p-4) == Interval(-0x8.85e40b3c3f63p+0, 0xe.071cbfa1de788p-4)
    @test Interval(-0xacbp+256, 0x6f9p0) / Interval(-0x7p0, 0.0) == entireinterval(Float64)
    @test Interval(-0x1.25f2d73472753p+0, +0x9.9a19fd3c1fc18p-4) / Interval(-0x9.3b0c8074ccc18p-4, +0x4.788df5d72af78p-4) == entireinterval(Float64)
    @test Interval(0.0, +15.0) / Interval(-3.0, +3.0) == entireinterval(Float64)
    @test Interval(-0x754ep0, 0xd0e9dc4p+12) / Interval(0x11ep0, 0xbbbp0) == Interval(-0x69p0, 0xbaffep+12)
    @test Interval(-0x10p0, 0xd0e9dc4p+12) / Interval(0x11ep0, 0xbbbp0) == Interval(-0xe.525982af70c9p-8, 0xbaffep+12)
    @test Interval(-0x754ep0, 0x1p+10) / Interval(0x11ep0, 0xbbbp0) == Interval(-0x69p0, 0xe.525982af70c9p-2)
    @test Interval(-0x1.18333622af827p+0, 0x2.14b836907297p+0) / Interval(0x1.263147d1f4bcbp+0, 0x111p0) == Interval(-0xf.3d2f5db8ec728p-4, 0x1.cf8fa732de129p+0)
    @test Interval(0.0, 0x75bcd15p0) / Interval(-0xap0, -0x9p0) == Interval(-0xd14fadp0, 0.0)
    @test Interval(0.0, 0x1.acbf1702af6edp+0) / Interval(-0x0.fp0, -0xe.3d7a59e2bdacp-4) == Interval(-0x1.e1bb896bfda07p+0, 0.0)
    @test Interval(0.0, 0xap0) / Interval(-0x9p0, 0.0) == Interval(-Inf, 0.0)
    @test Interval(0.0, 0xap0) / Interval(-1.0, +1.0) == entireinterval(Float64)
    @test Interval(0.0, 0x75bcd15p0) / Interval(+0x9p0, +0xap0) == Interval(0.0, 0xd14fadp0)
    @test Interval(0.0, 0x1.5f6b03dc8c66fp+0) / Interval(+0x2.39ad24e812dcep+0, 0xap0) == Interval(0.0, 0x9.deb65b02baep-4)
    @test Interval(0x754ep0, 0x75bcd15p0) / Interval(-0x11ep0, -0x9p0) == Interval(-0xd14fadp0, -0x69p0)
    @test Interval(0x754ep-16, 0x1.008a3accc766dp+4) / Interval(-0x11ep0, -0x2.497403b31d32ap+0) == Interval(-0x7.02d3edfbc8b6p+0, -0x69p-16)
    @test Interval(0x9.ac412ff1f1478p-4, 0x75bcd15p0) / Interval(-0x1.5232c83a0e726p+4, -0x9p0) == Interval(-0xd14fadp0, -0x7.52680a49e5d68p-8)
    @test Interval(0xe.1552a314d629p-4, 0x1.064c5adfd0042p+0) / Interval(-0x5.0d4d319a50b04p-4, -0x2.d8f51df1e322ep-4) == Interval(-0x5.c1d97d57d81ccp+0, -0x2.c9a600c455f5ap+0)
    @test Interval(0x754ep0, 0xeeeep0) / Interval(-0x11ep0, 0.0) == Interval(-Inf, -0x69p0)
    @test Interval(0x1.a9016514490e6p-4, 0xeeeep0) / Interval(-0xe.316e87be0b24p-4, 0.0) == Interval(-Inf, -0x1.df1cc82e6a583p-4)
    @test Interval(5.0, 6.0) / Interval(-0x5.0d4d319a50b04p-4, 0x2.d8f51df1e322ep-4) == entireinterval(Float64)
    @test Interval(0x754ep0, +0xeeeeep0) / Interval(0.0, +0x11ep0) == Interval(0x69p0, Inf)
    @test Interval(0x1.7f03f2a978865p+0, 0xeeeeep0) / Interval(0.0, 0x1.48b08624606b9p+0) == Interval(0x1.2a4fcda56843p+0, Inf)
    @test Interval(0x5efc1492p0, 0x1ba2dc763p0) / Interval(0x2fdd1fp0, 0x889b71p0) == Interval(0xb2p0, 0x93dp0)
    @test Interval(0x1.d7c06f9ff0706p-8, 0x1ba2dc763p0) / Interval(0x2fdd1fp-20, 0xe.3d7a59e2bdacp+0) == Interval(0x2.120d75be74b54p-12, 0x93dp+20)
    @test Interval(0x5.efc1492p-4, 0x1.008a3accc766dp+0) / Interval(0x2.497403b31d32ap+0, 0x8.89b71p+0) == Interval(0xb.2p-8, 0x7.02d3edfbc8b6p-4)
    @test Interval(0x8.440e7d65be6bp-8, 0x3.99982e9eae09ep+0) / Interval(0x8.29fa8d0659e48p-4, 0xc.13d2fd762e4a8p-4) == Interval(0xa.f3518768b206p-8, 0x7.0e2acad54859cp+0)
end

@testset "mpfi_div_d" begin
    # special values
    @test Interval(-Inf, -7.0) / Interval(-7.0, -7.0) == Interval(1.0, Inf)
    @test Interval(-Inf, -7.0) / Interval(0.0, 0.0) == ∅
    @test Interval(-Inf, -7.0) / Interval(7.0, 7.0) == Interval(-Inf, -1.0)
    @test Interval(-Inf, 0.0) / Interval(-0x170ef54646d497p-106, -0x170ef54646d497p-106) == Interval(0.0, Inf)
    @test Interval(-Inf, 0.0) / Interval(0x170ef54646d497p-106, 0x170ef54646d497p-106) == Interval(-Inf, 0.0)
    @test Interval(-Inf, 8.0) / Interval(-3.0, -3.0) == Interval(-0x15555555555556p-51, Inf)
    @test Interval(-Inf, 8.0) / Interval(0.0, 0.0) == ∅
    @test Interval(-Inf, 8.0) / Interval(3.0, 3.0) == Interval(-Inf, 0x15555555555556p-51)
    @test entireinterval(Float64) / Interval(-0x170ef54646d497p-105, -0x170ef54646d497p-105) == entireinterval(Float64)
    @test entireinterval(Float64) / Interval(0.0e-17, 0.0e-17) == ∅
    @test entireinterval(Float64) / Interval(+0x170ef54646d497p-105, +0x170ef54646d497p-105) == entireinterval(Float64)
    @test Interval(0.0, 0.0) / Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) / Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109) == Interval(0.0, 0.0)
    @test Interval(0.0, 8.0) / Interval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107) == Interval(-0x1d9b1f5d20d556p+5, 0.0)
    @test Interval(0.0, 8.0) / Interval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107) == Interval(0.0, 0x1d9b1f5d20d556p+5)
    @test Interval(0.0, Inf) / Interval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104) == Interval(-Inf, 0.0)
    @test Interval(0.0, Inf) / Interval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106) == Interval(0.0, Inf)
    # regular values
    @test Interval(-0x10000000000001p-20, -0x10000000000001p-53) / Interval(-1.0, -1.0) == Interval(0x10000000000001p-53, 0x10000000000001p-20)
    @test Interval(-0x10000000000002p-20, -0x10000000000001p-53) / Interval(0x10000000000001p-53, 0x10000000000001p-53) == Interval(-0x10000000000001p-19, -1.0)
    @test Interval(-0x10000000000001p-20, -0x10000020000001p-53) / Interval(0x10000000000001p-53, 0x10000000000001p-53) == Interval(-0x1p+33, -0x1000001fffffffp-52)
    @test Interval(-0x10000000000002p-20, -0x10000020000001p-53) / Interval(0x10000000000001p-53, 0x10000000000001p-53) == Interval(-0x10000000000001p-19, -0x1000001fffffffp-52)
    @test Interval(-0x123456789abcdfp-53, 0x123456789abcdfp-7) / Interval(-0x123456789abcdfp0, -0x123456789abcdfp0) == Interval(-0x1p-7, 0x1p-53)
    @test Interval(-0x123456789abcdfp-53, 0x10000000000001p-53) / Interval(-0x123456789abcdfp0, -0x123456789abcdfp0) == Interval(-0x1c200000000002p-106, 0x1p-53)
    @test Interval(-1.0, 0x123456789abcdfp-7) / Interval(-0x123456789abcdfp0, -0x123456789abcdfp0) == Interval(-0x1p-7, 0x1c200000000001p-105)
    @test Interval(-1.0, 0x10000000000001p-53) / Interval(-0x123456789abcdfp0, -0x123456789abcdfp0) == Interval(-0x1c200000000002p-106, 0x1c200000000001p-105)
end

@testset "mpfi_d_sub" begin
    # special values
    @test Interval(-0x170ef54646d497p-107, -0x170ef54646d497p-107) - Interval(-Inf, -7.0) == Interval(0x1bffffffffffffp-50, Inf)
    @test Interval(0.0, 0.0) - Interval(-Inf, -7.0) == Interval(7.0, Inf)
    @test Interval(0x170ef54646d497p-107, 0x170ef54646d497p-107) - Interval(-Inf, -7.0) == Interval(7.0, Inf)
    @test Interval(-0x170ef54646d497p-96, -0x170ef54646d497p-96) - Interval(-Inf, 0.0) == Interval(-0x170ef54646d497p-96, Inf)
    @test Interval(0.0, 0.0) - Interval(-Inf, 0.0) == Interval(0.0, Inf)
    @test Interval(0x170ef54646d497p-96, 0x170ef54646d497p-96) - Interval(-Inf, 0.0) == Interval(0x170ef54646d497p-96, Inf)
    @test Interval(-0x16345785d8a00000p0, -0x16345785d8a00000p0) - Interval(-Inf, 8.0) == Interval(-0x16345785d8a00100p0, Inf)
    @test Interval(0.0, 0.0) - Interval(-Inf, 8.0) == Interval(-8.0, Inf)
    @test Interval(0x16345785d8a00000p0, 0x16345785d8a00000p0) - Interval(-Inf, 8.0) == Interval(0x16345785d89fff00p0, Inf)
    @test Interval(-0x170ef54646d497p-105, -0x170ef54646d497p-105) - entireinterval(Float64) == entireinterval(Float64)
    @test Interval(0.0e-17, 0.0e-17) - entireinterval(Float64) == entireinterval(Float64)
    @test Interval(0x170ef54646d497p-105, 0x170ef54646d497p-105) - entireinterval(Float64) == entireinterval(Float64)
    @test Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109) - Interval(0.0, 0.0) == Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)
    @test Interval(0.0, 0.0) - Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109) - Interval(0.0, 0.0) == Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109)
    @test Interval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107) - Interval(0.0, 8.0) == Interval(-0x10000000000001p-49, -0x114b37f4b51f71p-107)
    @test Interval(0.0, 0.0) - Interval(0.0, 8.0) == Interval(-8.0, 0.0)
    @test Interval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107) - Interval(0.0, 8.0) == Interval(-8.0, 0x114b37f4b51f71p-107)
    @test Interval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104) - Interval(0.0, Inf) == Interval(-Inf, -0x50b45a75f7e81p-104)
    @test Interval(0.0, 0.0) - Interval(0.0, Inf) == Interval(-Inf, 0.0)
    @test Interval(-0x142d169d7dfa03p-106, -0x142d169d7dfa03p-106) - Interval(0.0, Inf) == Interval(-Inf, -0x142d169d7dfa03p-106)
    # regular values
    @test Interval(-0xfb53d14aa9c2fp-47, -0xfb53d14aa9c2fp-47) - Interval(17.0, 32.0) == Interval(-0x1fb53d14aa9c2fp-47, -0x18353d14aa9c2fp-47)
    @test Interval(0xfb53d14aa9c2fp-47, 0xfb53d14aa9c2fp-47) - Interval(17.0, 0xfb53d14aa9c2fp-47) == Interval(0.0, 0x7353d14aa9c2fp-47)
    @test Interval(0xfb53d14aa9c2fp-48, 0xfb53d14aa9c2fp-48) - Interval(0xfb53d14aa9c2fp-48, 32.0) == Interval(-0x104ac2eb5563d1p-48, 0.0)
    @test Interval(3.5, 3.5) - Interval(-0x123456789abcdfp-4, -0x123456789abcdfp-48) == Interval(0x15b456789abcdfp-48, 0x123456789abd17p-4)
    @test Interval(3.5, 3.5) - Interval(-0x123456789abcdfp-4, -0x123456789abcdfp-56) == Interval(0x3923456789abcdp-52, 0x123456789abd17p-4)
    @test Interval(256.5, 256.5) - Interval(-0x123456789abcdfp-52, 0xffp0) == Interval(0x18p-4, 0x101a3456789abdp-44)
    @test Interval(4097.5, 4097.5) - Interval(0x1p-550, 0x1fffffffffffffp-52) == Interval(0xfff8p-4, 0x10018p-4)
    @test Interval(-3.5, -3.5) - Interval(-0x123456789abcdfp-4, -0x123456789abcdfp-48) == Interval(0xeb456789abcdfp-48, 0x123456789abca7p-4)
    @test Interval(-3.5, -3.5) - Interval(-0x123456789abcdfp-4, -0x123456789abcdfp-56) == Interval(-0x36dcba98765434p-52, 0x123456789abca7p-4)
    @test Interval(-256.5, -256.5) - Interval(-0x123456789abcdfp-52, 0xffp0) == Interval(-0x1ff8p-4, -0xff5cba9876543p-44)
    @test Interval(-4097.5, -4097.5) - Interval(0x1p-550, 0x1fffffffffffffp-52) == Interval(-0x10038p-4, -0x10018p-4)
end

@testset "mpfi_exp" begin
    # special values
    @test exp(Interval(-Inf, -7.0)) == Interval(0.0, 0x1de16b9c24a98fp-63)
    @test exp(Interval(-Inf, 0.0)) == Interval(0.0, 1.0)
    @test exp(Interval(-Inf, +1.0)) == Interval(0.0, 0x15bf0a8b14576ap-51)
    @test exp(entireinterval(Float64)) == Interval(0.0, Inf)
    @test exp(Interval(0.0, 0.0)) == Interval(1.0, 1.0)
    @test exp(Interval(0.0, +1.0)) == Interval(1.0, 0x15bf0a8b14576ap-51)
    @test exp(Interval(0.0, Inf)) == Interval(1.0, Inf)
    # regular values
    @test exp(Interval(-123.0, -17.0)) == Interval(0x1766b45dd84f17p-230, 0x1639e3175a689dp-77)
    @test exp(Interval(-0.125, 0.25)) == Interval(0x1c3d6a24ed8221p-53, 0x148b5e3c3e8187p-52)
    @test exp(Interval(-0.125, 0.0)) == Interval(0x1c3d6a24ed8221p-53, 1.0)
    @test exp(Interval(0.0, 0.25)) == Interval(1.0, 0x148b5e3c3e8187p-52)
    @test exp(Interval(0xap-47, 0xbp-47)) == Interval(0x10000000000140p-52, 0x10000000000161p-52)
end

@testset "mpfi_exp2" begin
    # special values
    @test exp2(Interval(-Inf, -1.0)) == Interval(0.0, 0.5)
    @test exp2(Interval(-Inf, 0.0)) == Interval(0.0, 1.0)
    @test exp2(Interval(-Inf, 1.0)) == Interval(0.0, 2.0)
    @test exp2(entireinterval(Float64)) == Interval(0.0, Inf)
    @test exp2(Interval(0.0, 0.0)) == Interval(1.0, 1.0)
    @test exp2(Interval(0.0, +1.0)) == Interval(1.0, 2.0)
    @test exp2(Interval(0.0, Inf)) == Interval(1.0, Inf)
    # regular values
    @test exp2(Interval(-123.0, -17.0)) == Interval(0x1p-123, 0x1p-17)
    @test exp2(Interval(-7.0, 7.0)) == Interval(0x1p-7, 0x1p+7)
    @test exp2(Interval(-0.125, 0.25)) == Interval(0x1d5818dcfba487p-53, 0x1306fe0a31b716p-52)
    @test exp2(Interval(-0.125, 0.0)) == Interval(0x1d5818dcfba487p-53, 1.0)
    @test exp2(Interval(0.0, 0.25)) == Interval(1.0, 0x1306fe0a31b716p-52)
    @test exp2(Interval(0xap-47, 0xbp-47)) == Interval(0x100000000000ddp-52, 0x100000000000f4p-52)
end

@testset "mpfi_expm1" begin
    # special values
    @test expm1(Interval(-Inf, -7.0)) == Interval(-1.0, -0x1ff887a518f6d5p-53)
    @test expm1(Interval(-Inf, 0.0)) == Interval(-1.0, 0.0)
    @test expm1(Interval(-Inf, 1.0)) == Interval(-1.0, 0x1b7e151628aed3p-52)
    @test expm1(entireinterval(Float64)) == Interval(-1.0, Inf)
    @test expm1(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test expm1(Interval(0.0, 1.0)) == Interval(0.0, 0x1b7e151628aed3p-52)
    @test expm1(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test expm1(Interval(-36.0, -36.0)) == Interval(-0x1ffffffffffffep-53, -0x1ffffffffffffdp-53)
    @test expm1(Interval(-0.125, 0.25)) == Interval(-0x1e14aed893eef4p-56, 0x122d78f0fa061ap-54)
    @test expm1(Interval(-0.125, 0.0)) == Interval(-0x1e14aed893eef4p-56, 0.0)
    @test expm1(Interval(0.0, 0.25)) == Interval(0.0, 0x122d78f0fa061ap-54)
    @test expm1(Interval(0xap-47, 0xbp-47)) == Interval(0x140000000000c8p-96, 0x160000000000f3p-96)
end

@testset "mpfi_hypot" begin
    # special values
    @test hypot(Interval(-Inf, -7.0), Interval(-1.0, 8.0)) == Interval(7.0, Inf)
    @test hypot(Interval(-Inf, 0.0), Interval(8.0, Inf)) == Interval(8.0, Inf)
    @test hypot(Interval(-Inf, 8.0), Interval(0.0, 8.0)) == Interval(0.0, Inf)
    @test hypot(entireinterval(Float64), Interval(0.0, 8.0)) == Interval(0.0, Inf)
    @test hypot(Interval(0.0, 0.0), Interval(-Inf, -7.0)) == Interval(7.0, Inf)
    @test hypot(Interval(0.0, 3.0), Interval(-4.0, 0.0)) == Interval(0.0, 5.0)
    @test hypot(Interval(0.0, 0.0), Interval(0.0, 8.0)) == Interval(0.0, 8.0)
    @test hypot(Interval(0.0, Inf), Interval(0.0, 8.0)) == Interval(0.0, Inf)
    @test hypot(Interval(0.0, 0.0), Interval(8.0, Inf)) == Interval(8.0, Inf)
    @test hypot(Interval(0.0, 0.0), entireinterval(Float64)) == Interval(0.0, Inf)
    @test hypot(Interval(0.0, 5.0), Interval(0.0, 12.0)) == Interval(0.0, 13.0)
    @test hypot(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test hypot(Interval(0.0, Inf), Interval(-7.0, 8.0)) == Interval(0.0, Inf)
    # regular values
    @test hypot(Interval(-12.0, -5.0), Interval(-35.0, -12.0)) == Interval(13.0, 37.0)
    @test hypot(Interval(6.0, 7.0), Interval(1.0, 24.0)) == Interval(0x1854bfb363dc39p-50, 25.0)
    @test hypot(Interval(-4.0, +7.0), Interval(-25.0, 3.0)) == Interval(0.0, 0x19f625847a5899p-48)
    @test hypot(Interval(0x1854bfb363dc39p-50, 0x19f625847a5899p-48), Interval(0x1854bfb363dc39p-50, 0x19f625847a5899p-48)) == Interval(0x113463fa37014dp-49, 0x125b89092b8fc0p-47)
end

@testset "mpfi_intersect" begin
    # special values
    @test intersect(Interval(-Inf, -7.0), Interval(-1.0, +8.0)) == ∅
    @test ∩(Interval(-Inf, -7.0), Interval(-1.0, +8.0)) == ∅
    @test (Interval(-Inf, -7.0) ∩ Interval(-1.0, +8.0)) == ∅
    @test intersect(Interval(-Inf, 0.0), Interval(+8.0, Inf)) == ∅
    @test ∩(Interval(-Inf, 0.0), Interval(+8.0, Inf)) == ∅
    @test (Interval(-Inf, 0.0) ∩ Interval(+8.0, Inf)) == ∅
    @test intersect(Interval(-Inf, +8.0), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test ∩(Interval(-Inf, +8.0), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test (Interval(-Inf, +8.0) ∩ Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test intersect(entireinterval(Float64), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test ∩(entireinterval(Float64), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test (entireinterval(Float64) ∩ Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test intersect(Interval(0.0, 0.0), Interval(-Inf, -7.0)) == ∅
    @test ∩(Interval(0.0, 0.0), Interval(-Inf, -7.0)) == ∅
    @test (Interval(0.0, 0.0) ∩ Interval(-Inf, -7.0)) == ∅
    @test intersect(Interval(0.0, +8.0), Interval(-7.0, 0.0)) == Interval(0.0, 0.0)
    @test ∩(Interval(0.0, +8.0), Interval(-7.0, 0.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, +8.0) ∩ Interval(-7.0, 0.0)) == Interval(0.0, 0.0)
    @test intersect(Interval(0.0, 0.0), Interval(0.0, +8.0)) == Interval(0.0, 0.0)
    @test ∩(Interval(0.0, 0.0), Interval(0.0, +8.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0) ∩ Interval(0.0, +8.0)) == Interval(0.0, 0.0)
    @test intersect(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test ∩(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test (Interval(0.0, Inf) ∩ Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test intersect(Interval(0.0, 0.0), Interval(+8.0, Inf)) == ∅
    @test ∩(Interval(0.0, 0.0), Interval(+8.0, Inf)) == ∅
    @test (Interval(0.0, 0.0) ∩ Interval(+8.0, Inf)) == ∅
    @test intersect(Interval(0.0, 0.0), entireinterval(Float64)) == Interval(0.0, 0.0)
    @test ∩(Interval(0.0, 0.0), entireinterval(Float64)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0) ∩ entireinterval(Float64)) == Interval(0.0, 0.0)
    @test intersect(Interval(0.0, +8.0), Interval(-7.0, +8.0)) == Interval(0.0, +8.0)
    @test ∩(Interval(0.0, +8.0), Interval(-7.0, +8.0)) == Interval(0.0, +8.0)
    @test (Interval(0.0, +8.0) ∩ Interval(-7.0, +8.0)) == Interval(0.0, +8.0)
    @test intersect(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test ∩(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0) ∩ Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test intersect(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test ∩(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test (Interval(0.0, Inf) ∩ Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    # regular values
    @test intersect(Interval(0x12p0, 0x90p0), Interval(-0x0dp0, 0x34p0)) == Interval(0x12p0, 0x34p0)
    @test ∩(Interval(0x12p0, 0x90p0), Interval(-0x0dp0, 0x34p0)) == Interval(0x12p0, 0x34p0)
    @test (Interval(0x12p0, 0x90p0) ∩ Interval(-0x0dp0, 0x34p0)) == Interval(0x12p0, 0x34p0)
end

@testset "mpfi_inv" begin
    # special values
    @test inv(Interval(-Inf, -.25)) == Interval(-4.0, 0.0)
    @test (Interval(-Inf, -.25))^(-1) == Interval(-4.0, 0.0)
    @test (Interval(-Inf, -.25))^(-1//1) == Interval(-4.0, 0.0)
    @test (Interval(-Inf, -.25))^(-1.0) == Interval(-4.0, 0.0)
    @test 1 /(Interval(-Inf, -.25)) == Interval(-4.0, 0.0)
    @test inv(Interval(-Inf, 0.0)) == Interval(-Inf, 0.0)
    @test (Interval(-Inf, 0.0))^(-1) == Interval(-Inf, 0.0)
    @test (Interval(-Inf, 0.0))^(-1//1) == Interval(-Inf, 0.0)
    @test (Interval(-Inf, 0.0))^(-1.0) == Interval(-Inf, 0.0)
    @test 1 /(Interval(-Inf, 0.0)) == Interval(-Inf, 0.0)
    @test inv(Interval(-Inf, +4.0)) == entireinterval(Float64)
    @test (Interval(-Inf, +4.0))^(-1) == entireinterval(Float64)
    @test (Interval(-Inf, +4.0))^(-1//1) == entireinterval(Float64)
    @test (Interval(-Inf, +4.0))^(-1.0) == entireinterval(Float64)
    @test 1 /(Interval(-Inf, +4.0)) == entireinterval(Float64)
    @test inv(entireinterval(Float64)) == entireinterval(Float64)
    @test (entireinterval(Float64))^(-1) == entireinterval(Float64)
    @test (entireinterval(Float64))^(-1//1) == entireinterval(Float64)
    @test (entireinterval(Float64))^(-1.0) == entireinterval(Float64)
    @test 1 /(entireinterval(Float64)) == entireinterval(Float64)
    @test inv(Interval(0.0, 0.0)) == ∅
    @test (Interval(0.0, 0.0))^(-1) == ∅
    @test (Interval(0.0, 0.0))^(-1//1) == ∅
    @test (Interval(0.0, 0.0))^(-1.0) == ∅
    @test 1 /(Interval(0.0, 0.0)) == ∅
    @test inv(Interval(0.0, +2.0)) == Interval(+.5, Inf)
    @test (Interval(0.0, +2.0))^(-1) == Interval(+.5, Inf)
    @test (Interval(0.0, +2.0))^(-1//1) == Interval(+.5, Inf)
    @test (Interval(0.0, +2.0))^(-1.0) == Interval(+.5, Inf)
    @test 1 /(Interval(0.0, +2.0)) == Interval(+.5, Inf)
    @test inv(Interval(0.0, Inf)) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf))^(-1) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf))^(-1//1) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf))^(-1.0) == Interval(0.0, Inf)
    @test 1 /(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test inv(Interval(-8.0, -2.0)) == Interval(-.5, -0.125)
    @test (Interval(-8.0, -2.0))^(-1) == Interval(-.5, -0.125)
    @test (Interval(-8.0, -2.0))^(-1//1) == Interval(-.5, -0.125)
    @test (Interval(-8.0, -2.0))^(-1.0) == Interval(-.5, -0.125)
    @test 1 /(Interval(-8.0, -2.0)) == Interval(-.5, -0.125)
    @test inv(Interval(0x1p-4, 0x1440c131282cd9p-53)) == Interval(0x1947bfce1bc417p-52, 0x10p0)
    @test (Interval(0x1p-4, 0x1440c131282cd9p-53))^(-1) == Interval(0x1947bfce1bc417p-52, 0x10p0)
    @test (Interval(0x1p-4, 0x1440c131282cd9p-53))^(-1//1) == Interval(0x1947bfce1bc417p-52, 0x10p0)
    @test (Interval(0x1p-4, 0x1440c131282cd9p-53))^(-1.0) == Interval(0x1947bfce1bc417p-52, 0x10p0)
    @test 1 /(Interval(0x1p-4, 0x1440c131282cd9p-53)) == Interval(0x1947bfce1bc417p-52, 0x10p0)
    @test inv(Interval(0x19f1a539c91fddp-55, +64.0)) == Interval(0.015625, 0x13bc205a76b3fdp-50)
    @test (Interval(0x19f1a539c91fddp-55, +64.0))^(-1) == Interval(0.015625, 0x13bc205a76b3fdp-50)
    @test (Interval(0x19f1a539c91fddp-55, +64.0))^(-1//1) == Interval(0.015625, 0x13bc205a76b3fdp-50)
    @test (Interval(0x19f1a539c91fddp-55, +64.0))^(-1.0) == Interval(0.015625, 0x13bc205a76b3fdp-50)
    @test 1 /(Interval(0x19f1a539c91fddp-55, +64.0)) == Interval(0.015625, 0x13bc205a76b3fdp-50)
    @test inv(Interval(-0xae83b95effd69p-52, -0x63e3cb4ed72a3p-53)) == Interval(-0x1480a9b5772a23p-50, -0x177887d65484c9p-52)
    @test (Interval(-0xae83b95effd69p-52, -0x63e3cb4ed72a3p-53))^(-1) == Interval(-0x1480a9b5772a23p-50, -0x177887d65484c9p-52)
    @test (Interval(-0xae83b95effd69p-52, -0x63e3cb4ed72a3p-53))^(-1//1) == Interval(-0x1480a9b5772a23p-50, -0x177887d65484c9p-52)
    @test (Interval(-0xae83b95effd69p-52, -0x63e3cb4ed72a3p-53))^(-1.0) == Interval(-0x1480a9b5772a23p-50, -0x177887d65484c9p-52)
    @test 1 /(Interval(-0xae83b95effd69p-52, -0x63e3cb4ed72a3p-53)) == Interval(-0x1480a9b5772a23p-50, -0x177887d65484c9p-52)
end

@testset "mpfi_is_neg" begin
    # special values
    @test precedes(Interval(-Inf, -8.0), Interval(0.0, 0.0))
    @test precedes(Interval(-Inf, 0.0), Interval(0.0, 0.0))
    @test precedes(Interval(-Inf, 5.0), Interval(0.0, 0.0)) == false
    @test precedes(entireinterval(Float64), Interval(0.0, 0.0)) == false
    @test precedes(Interval(-8.0, 0.0), Interval(0.0, 0.0))
    @test precedes(Interval(0.0, 0.0), Interval(0.0, 0.0))
    @test precedes(Interval(0.0, 5.0), Interval(0.0, 0.0)) == false
    @test precedes(Interval(0.0, Inf), Interval(0.0, 0.0)) == false
    @test precedes(Interval(5.0, Inf), Interval(0.0, 0.0)) == false
    # regular values
    @test precedes(Interval(-34.0, -17.0), Interval(0.0, 0.0))
    @test precedes(Interval(-8.0, -1.0), Interval(0.0, 0.0))
    @test precedes(Interval(-34.0, 17.0), Interval(0.0, 0.0)) == false
    @test precedes(Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51), Interval(0.0, 0.0)) == false
    @test precedes(Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51), Interval(0.0, 0.0)) == false
    @test precedes(Interval(+8.0, +0x7fffffffffffbp+51), Interval(0.0, 0.0)) == false
    @test precedes(Interval(+0x1fffffffffffffp-53, 2.0), Interval(0.0, 0.0)) == false
end

@testset "mpfi_is_nonneg" begin
    # special values
    @test ≤(Interval(0.0, 0.0), Interval(-Inf, -8.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-Inf, -8.0)) == false
    @test ≤(Interval(0.0, 0.0), Interval(-Inf, 0.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-Inf, 0.0)) == false
    @test ≤(Interval(0.0, 0.0), Interval(-Inf, 5.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-Inf, 5.0)) == false
    @test ≤(Interval(0.0, 0.0), entireinterval(Float64)) == false
    @test (Interval(0.0, 0.0) ≤ entireinterval(Float64)) == false
    @test ≤(Interval(0.0, 0.0), Interval(-8.0, 0.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-8.0, 0.0)) == false
    @test ≤(Interval(0.0, 0.0), Interval(0.0, 0.0))
    @test (Interval(0.0, 0.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(0.0, 0.0), Interval(0.0, 5.0))
    @test (Interval(0.0, 0.0) ≤ Interval(0.0, 5.0))
    @test ≤(Interval(0.0, 0.0), Interval(0.0, Inf))
    @test (Interval(0.0, 0.0) ≤ Interval(0.0, Inf))
    @test ≤(Interval(0.0, 0.0), Interval(5.0, Inf))
    @test (Interval(0.0, 0.0) ≤ Interval(5.0, Inf))
    # regular values
    @test ≤(Interval(0.0, 0.0), Interval(-34.0, -17.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-34.0, -17.0)) == false
    @test ≤(Interval(0.0, 0.0), Interval(-8.0, -1.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-8.0, -1.0)) == false
    @test ≤(Interval(0.0, 0.0), Interval(-34.0, 17.0)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-34.0, 17.0)) == false
    @test ≤(Interval(0.0, 0.0), Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) == false
    @test (Interval(0.0, 0.0) ≤ Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) == false
    @test ≤(Interval(0.0, 0.0), Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51))
    @test (Interval(0.0, 0.0) ≤ Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51))
    @test ≤(Interval(0.0, 0.0), Interval(+8.0, +0x7fffffffffffbp+51))
    @test (Interval(0.0, 0.0) ≤ Interval(+8.0, +0x7fffffffffffbp+51))
    @test ≤(Interval(0.0, 0.0), Interval(+0x1fffffffffffffp-53, 2.0))
    @test (Interval(0.0, 0.0) ≤ Interval(+0x1fffffffffffffp-53, 2.0))
end

@testset "mpfi_is_nonpos" begin
    # special values
    @test ≤(Interval(-Inf, -8.0), Interval(0.0, 0.0))
    @test (Interval(-Inf, -8.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(-Inf, 0.0), Interval(0.0, 0.0))
    @test (Interval(-Inf, 0.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(-Inf, 5.0), Interval(0.0, 0.0)) == false
    @test (Interval(-Inf, 5.0) ≤ Interval(0.0, 0.0)) == false
    @test ≤(entireinterval(Float64), Interval(0.0, 0.0)) == false
    @test (entireinterval(Float64) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(-8.0, 0.0), Interval(0.0, 0.0))
    @test (Interval(-8.0, 0.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(0.0, 0.0), Interval(0.0, 0.0))
    @test (Interval(0.0, 0.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(0.0, 5.0), Interval(0.0, 0.0)) == false
    @test (Interval(0.0, 5.0) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(0.0, Inf), Interval(0.0, 0.0)) == false
    @test (Interval(0.0, Inf) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(5.0, Inf), Interval(0.0, 0.0)) == false
    @test (Interval(5.0, Inf) ≤ Interval(0.0, 0.0)) == false
    # regular values
    @test ≤(Interval(-34.0, -17.0), Interval(0.0, 0.0))
    @test (Interval(-34.0, -17.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(-8.0, -1.0), Interval(0.0, 0.0))
    @test (Interval(-8.0, -1.0) ≤ Interval(0.0, 0.0))
    @test ≤(Interval(-34.0, 17.0), Interval(0.0, 0.0)) == false
    @test (Interval(-34.0, 17.0) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51), Interval(0.0, 0.0)) == false
    @test (Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51), Interval(0.0, 0.0)) == false
    @test (Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(8.0, 0x7fffffffffffbp+51), Interval(0.0, 0.0)) == false
    @test (Interval(8.0, 0x7fffffffffffbp+51) ≤ Interval(0.0, 0.0)) == false
    @test ≤(Interval(0x1fffffffffffffp-53, 2.0), Interval(0.0, 0.0)) == false
    @test (Interval(0x1fffffffffffffp-53, 2.0) ≤ Interval(0.0, 0.0)) == false
end

@testset "mpfi_is_pos" begin
    # special values
    @test precedes(Interval(0.0, 0.0), Interval(-Inf, -8.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-Inf, 0.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-Inf, 5.0)) == false
    @test precedes(Interval(0.0, 0.0), entireinterval(Float64)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-8.0, 0.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(0.0, 0.0))
    @test precedes(Interval(0.0, 0.0), Interval(0.0, 5.0))
    @test precedes(Interval(0.0, 0.0), Interval(0.0, Inf))
    @test precedes(Interval(0.0, 0.0), Interval(5.0, Inf))
    # regular values
    @test precedes(Interval(0.0, 0.0), Interval(-34.0, -17.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-8.0, -1.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-34.0, 17.0)) == false
    @test precedes(Interval(0.0, 0.0), Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) == false
    @test precedes(Interval(0.0, 0.0), Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51))
    @test precedes(Interval(0.0, 0.0), Interval(+8.0, +0x7fffffffffffbp+51))
    @test precedes(Interval(0.0, 0.0), Interval(+0x1fffffffffffffp-53, 2.0))
end

@testset "mpfi_is_strictly_neg" begin
    # special values
    @test strictprecedes(Interval(-Inf, -8.0), Interval(0.0, 0.0))
    @test strictprecedes(Interval(-Inf, 0.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(-Inf, 5.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(entireinterval(Float64), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(-8.0, 0.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(0.0, 5.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(0.0, Inf), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(5.0, Inf), Interval(0.0, 0.0)) == false
    # regular values
    @test strictprecedes(Interval(-34.0, -17.0), Interval(0.0, 0.0))
    @test strictprecedes(Interval(-8.0, -1.0), Interval(0.0, 0.0))
    @test strictprecedes(Interval(-34.0, 17.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(+8.0, +0x7fffffffffffbp+51), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(+0x1fffffffffffffp-53, 2.0), Interval(0.0, 0.0)) == false
end

@testset "mpfi_is_strictly_pos" begin
    # special values
    @test strictprecedes(Interval(0.0, 0.0), Interval(-Inf, -8.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(-Inf, 0.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(-Inf, 5.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), entireinterval(Float64)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(-8.0, 0.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(0.0, 0.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(0.0, 5.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(0.0, Inf)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(5.0, Inf))
    # regular values
    @test strictprecedes(Interval(0.0, 0.0), Interval(-34.0, -17.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(-8.0, -1.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(-34.0, 17.0)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) == false
    @test strictprecedes(Interval(0.0, 0.0), Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51))
    @test strictprecedes(Interval(0.0, 0.0), Interval(+8.0, +0x7fffffffffffbp+51))
    @test strictprecedes(Interval(0.0, 0.0), Interval(+0x1fffffffffffffp-53, 2.0))
end

@testset "mpfi_log" begin
    # special values
    @test log(Interval(0.0, +1.0)) == Interval(-Inf, 0.0)
    @test log(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test log(Interval(+1.0, +1.0)) == Interval(0.0, 0.0)
    @test log(Interval(0x3a2a08c23afe3p-14, 0x1463ceb440d6bdp-14)) == Interval(0xc6dc8a2928579p-47, 0x1a9500bc7ffcc5p-48)
    @test log(Interval(0xb616ab8b683b5p-52, +1.0)) == Interval(-0x2b9b8b1fb2fb9p-51, 0.0)
    @test log(Interval(+1.0, 0x8ac74d932fae3p-21)) == Interval(0.0, 0x5380455576989p-46)
    @test log(Interval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) == Interval(0xbdee7228cfedfp-47, 0x1b3913fc99f555p-48)
end

@testset "mpfi_log1p" begin
    # special values
    @test log1p(Interval(-1.0, 0.0)) == Interval(-Inf, 0.0)
    @test log1p(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test log1p(Interval(0.0, 1.0)) == Interval(0.0, 0x162e42fefa39f0p-53)
    @test log1p(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test log1p(Interval(-0xb616ab8b683b5p-52, 0.0)) == Interval(-0x13e080325bab7bp-52, 0.0)
    @test log1p(Interval(0.0, 0x8ac74d932fae3p-21)) == Interval(0.0, 0x14e0115561569cp-48)
    @test log1p(Interval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) == Interval(0x17bdce451a337fp-48, 0x1b3913fc99f6fcp-48)
end

@testset "mpfi_log2" begin
    # special values
    @test log2(Interval(0.0, +1.0)) == Interval(-Inf, 0.0)
    @test log2(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test log2(Interval(1.0, 1.0)) == Interval(0.0, 0.0)
    @test log2(Interval(0xb616ab8b683b5p-52, 1.0)) == Interval(-0x1f74cb5d105b3ap-54, 0.0)
    @test log2(Interval(1.0, 0x8ac74d932fae3p-21)) == Interval(0.0, 0x1e1ddc27c2c70fp-48)
    @test log2(Interval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) == Interval(0x112035c9390c07p-47, 0x13a3208f61f10cp-47)
end

@testset "mpfi_log10" begin
    # special values
    @test log10(Interval(0.0, 1.0)) == Interval(-Inf, 0.0)
    @test log10(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test log10(Interval(1.0, 1.0)) == Interval(0.0, 0.0)
    @test log10(Interval(0x3a2a08c23afe3p-14, 0x1463ceb440d6bdp-14)) == Interval(0x159753104a9401p-49, 0x1716c01a04b570p-49)
    @test log10(Interval(0xb616ab8b683b5p-52, 1.0)) == Interval(-0x12f043ec00f8d6p-55, 0.0)
    @test log10(Interval(100.0, 0x8ac74d932fae3p-21)) == Interval(2.0, 0x1221cc590b9946p-49)
    @test log10(Interval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) == Interval(0x149f1d70168f49p-49, 0x17a543a94fb65ep-49)
end

@testset "mpfi_mag" begin
    # special values
    @test mag(Interval(-Inf, -8.0)) == Inf
    @test mag(Interval(-Inf, 0.0)) == Inf
    @test mag(Interval(-Inf, 5.0)) == Inf
    @test mag(entireinterval(Float64)) == Inf
    @test mag(Interval(-Inf, 0.0)) == Inf
    @test mag(Interval(-8.0, 0.0)) == +8
    @test mag(Interval(0.0, 0.0)) == +0
    @test mag(Interval(0.0, 5.0)) == +5
    @test mag(Interval(0.0, Inf)) == Inf
    # regular values
    @test mag(Interval(-34.0, -17.0)) == 34
end

@testset "mpfi_mid" begin
    # special values
    @test mid(Interval(-8.0, 0.0)) == -4
    @test mid(Interval(0.0, 0.0)) == +0
    @test mid(Interval(0.0, 5.0)) == +2.5
    # regular values
    @test mid(Interval(-34.0, -17.0)) == -0x33p-1
    @test mid(Interval(-34.0, 17.0)) == -8.5
    @test mid(Interval(0.0, +0x123456789abcdp-2)) == +0x123456789abcdp-3
    @test mid(Interval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) == 0x1921fb54442d18p-51
    @test mid(Interval(-0x1921fb54442d19p-51, -0x1921fb54442d18p-51)) == -0x1921fb54442d18p-51
    @test mid(Interval(-4.0, -0x7fffffffffffdp-51)) == -0x27fffffffffffbp-52
    @test mid(Interval(-8.0, -0x7fffffffffffbp-51)) == -0x47fffffffffffbp-52
    @test mid(Interval(-0x1fffffffffffffp-53, 2.0)) == 0.5
end

@testset "mpfi_mig" begin
    # special values
    @test mig(Interval(-Inf, -8.0)) == 8
    @test mig(Interval(-Inf, 0.0)) == +0
    @test mig(Interval(-Inf, 5.0)) == +0
    @test mig(entireinterval(Float64)) == +0
    @test mig(Interval(-Inf, 0.0)) == +0
    @test mig(Interval(-8.0, 0.0)) == +0
    @test mig(Interval(0.0, 0.0)) == +0
    @test mig(Interval(0.0, 5.0)) == +0
    @test mig(Interval(0.0, Inf)) == +0
    # regular values
    @test mig(Interval(-34.0, -17.0)) == 17
end

@testset "mpfi_mul" begin
    # special values
    @test Interval(-Inf, -7.0) * Interval(-1.0, +8.0) == entireinterval(Float64)
    @test Interval(-Inf, 0.0) * Interval(+8.0, Inf) == Interval(-Inf, 0.0)
    @test Interval(-Inf, +8.0) * Interval(0.0, +8.0) == Interval(-Inf, +64.0)
    @test entireinterval(Float64) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test entireinterval(Float64) * Interval(0.0, +8.0) == entireinterval(Float64)
    @test Interval(0.0, 0.0) * Interval(-Inf, -7.0) == Interval(0.0, 0.0)
    @test Interval(0.0, +8.0) * Interval(-7.0, 0.0) == Interval(-56.0, 0.0)
    @test Interval(0.0, 0.0) * Interval(0.0, +8.0) == Interval(0.0, 0.0)
    @test Interval(0.0, Inf) * Interval(0.0, +8.0) == Interval(0.0, Inf)
    @test Interval(0.0, 0.0) * Interval(+8.0, Inf) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) * entireinterval(Float64) == Interval(0.0, 0.0)
    @test Interval(0.0, +8.0) * Interval(-7.0, +8.0) == Interval(-56.0, +64.0)
    @test Interval(0.0, 0.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, Inf) * Interval(0.0, +8.0) == Interval(0.0, Inf)
    @test Interval(-3.0, +7.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    # regular values
    @test Interval(-0x0dp0, -0x09p0) * Interval(-0x04p0, -0x02p0) == Interval(0x12p0, 0x34p0)
    @test Interval(-0x0dp0, -0xd.f0e7927d247cp-4) * Interval(-0x04p0, -0xa.41084aff48f8p-8) == Interval(0x8.ef3aa21dba748p-8, 0x34p0)
    @test Interval(-0xe.26c9e9eb67b48p-4, -0x8.237d2eb8b1178p-4) * Interval(-0x5.8c899a0706d5p-4, -0x3.344e57a37b5e8p-4) == Interval(0x1.a142a930de328p-4, 0x4.e86c3434cd924p-4)
    @test Interval(-0x37p0, -0x07p0) * Interval(-0x01p0, 0x22p0) == Interval(-0x74ep0, 0x37p0)
    @test Interval(-0xe.063f267ed51ap-4, -0x0.33p0) * Interval(-0x01p0, 0x1.777ab178b4a1ep+0) == Interval(-0x1.491df346a9f15p+0, 0xe.063f267ed51ap-4)
    @test Interval(-0x1.cb540b71699a8p+4, -0x0.33p0) * Interval(-0x1.64dcaaa101f18p+0, 0x01p0) == Interval(-0x1.cb540b71699a8p+4, 0x2.804cce4a3f42ep+4)
    @test Interval(-0x1.cb540b71699a8p+4, -0x0.33p0) * Interval(-0x1.64dcaaa101f18p+0, 0x1.eb67a1a6ef725p+4) == Interval(-0x3.71b422ce817f4p+8, 0x2.804cce4a3f42ep+4)
    @test Interval(-0x123456789ap0, -0x01p0) * Interval(0x01p0, 0x10p0) == Interval(-0x123456789a0p0, -0x01p0)
    @test Interval(-0xb.6c67d3a37d54p-4, -0x0.8p0) * Interval(0x02p0, 0x2.0bee4e8bb3dfp+0) == Interval(-0x1.7611a672948a5p+0, -0x01p0)
    @test Interval(-0x04p0, -0xa.497d533c3b2ep-8) * Interval(0xb.d248df3373e68p-4, 0x04p0) == Interval(-0x10p0, -0x7.99b990532d434p-8)
    @test Interval(-0xb.6c67d3a37d54p-4, -0xa.497d533c3b2ep-8) * Interval(0xb.d248df3373e68p-4, 0x2.0bee4e8bb3dfp+0) == Interval(-0x1.7611a672948a5p+0, -0x7.99b990532d434p-8)
    @test Interval(-0x01p0, 0x11p0) * Interval(-0x07p0, -0x04p0) == Interval(-0x77p0, 0x07p0)
    @test Interval(-0x01p0, 0xe.ca7ddfdb8572p-4) * Interval(-0x2.3b46226145234p+0, -0x0.1p0) == Interval(-0x2.101b41d3d48b8p+0, 0x2.3b46226145234p+0)
    @test Interval(-0x1.1d069e75e8741p+8, 0x01p0) * Interval(-0x2.3b46226145234p+0, -0x0.1p0) == Interval(-0x2.3b46226145234p+0, 0x2.7c0bd9877f404p+8)
    @test Interval(-0xe.ca7ddfdb8572p-4, 0x1.1d069e75e8741p+8) * Interval(-0x2.3b46226145234p+0, -0x0.1p0) == Interval(-0x2.7c0bd9877f404p+8, 0x2.101b41d3d48b8p+0)
    @test Interval(-0x01p0, 0x10p0) * Interval(-0x02p0, 0x03p0) == Interval(-0x20p0, 0x30p0)
    @test Interval(-0x01p0, 0x2.db091cea593fap-4) * Interval(-0x2.6bff2625fb71cp-4, 0x1p-8) == Interval(-0x6.ea77a3ee43de8p-8, 0x2.6bff2625fb71cp-4)
    @test Interval(-0x01p0, 0x6.e211fefc216ap-4) * Interval(-0x1p-4, 0x1.8e3fe93a4ea52p+0) == Interval(-0x1.8e3fe93a4ea52p+0, 0xa.b52fe22d72788p-4)
    @test Interval(-0x1.15e079e49a0ddp+0, 0x1p-8) * Interval(-0x2.77fc84629a602p+0, 0x8.3885932f13fp-4) == Interval(-0x8.ec5de73125be8p-4, 0x2.adfe651d3b19ap+0)
    @test Interval(-0x07p0, 0x07p0) * Interval(0x13p0, 0x24p0) == Interval(-0xfcp0, 0xfcp0)
    @test Interval(-0xa.8071f870126cp-4, 0x10p0) * Interval(0x02p0, 0x2.3381083e7d3b4p+0) == Interval(-0x1.71dc5b5607781p+0, 0x2.3381083e7d3b4p+4)
    @test Interval(-0x01p0, 0x1.90aa487ecf153p+0) * Interval(0x01p-53, 0x1.442e2695ac81ap+0) == Interval(-0x1.442e2695ac81ap+0, 0x1.fb5fbebd0cbc6p+0)
    @test Interval(-0x1.c40db77f2f6fcp+0, 0x1.8eb70bbd94478p+0) * Interval(0x02p0, 0x3.45118635235c6p+0) == Interval(-0x5.c61fcad908df4p+0, 0x5.17b7c49130824p+0)
    @test Interval(0xcp0, 0x2dp0) * Interval(-0x679p0, -0xe5p0) == Interval(-0x12345p0, -0xabcp0)
    @test Interval(0xcp0, 0x1.1833fdcab4c4ap+10) * Interval(-0x2.4c0afc50522ccp+40, -0xe5p0) == Interval(-0x2.83a3712099234p+50, -0xabcp0)
    @test Interval(0xb.38f1fb0ef4308p+0, 0x2dp0) * Interval(-0x679p0, -0xa.4771d7d0c604p+0) == Interval(-0x12345p0, -0x7.35b3c8400ade4p+4)
    @test Interval(0xf.08367984ca1cp-4, 0xa.bcf6c6cbe341p+0) * Interval(-0x5.cbc445e9952c4p+0, -0x2.8ad05a7b988fep-8) == Interval(-0x3.e3ce52d4a139cp+4, -0x2.637164cf2f346p-8)
    @test Interval(0x01p0, 0xcp0) * Interval(-0xe5p0, 0x01p0) == Interval(-0xabcp0, 0xcp0)
    @test Interval(0x123p-52, 0x1.ec24910ac6aecp+0) * Interval(-0xa.a97267f56a9b8p-4, 0x1p+32) == Interval(-0x1.47f2dbe4ef916p+0, 0x1.ec24910ac6aecp+32)
    @test Interval(0x03p0, 0x7.2bea531ef4098p+0) * Interval(-0x01p0, 0xa.a97267f56a9b8p-4) == Interval(-0x7.2bea531ef4098p+0, 0x4.c765967f9468p+0)
    @test Interval(0x0.3p0, 0xa.a97267f56a9b8p-4) * Interval(-0x1.ec24910ac6aecp+0, 0x7.2bea531ef4098p+0) == Interval(-0x1.47f2dbe4ef916p+0, 0x4.c765967f9468p+0)
    @test Interval(0x3p0, 0x7p0) * Interval(0x5p0, 0xbp0) == Interval(0xfp0, 0x4dp0)
    @test Interval(0x2.48380232f6c16p+0, 0x7p0) * Interval(0x3.71cb6c53e68eep+0, 0xbp0) == Interval(0x7.dc58fb323ad78p+0, 0x4dp0)
    @test Interval(0x3p0, 0x3.71cb6c53e68eep+0) * Interval(0x5p-25, 0x2.48380232f6c16p+0) == Interval(0xfp-25, 0x7.dc58fb323ad7cp+0)
    @test Interval(0x3.10e8a605572p-4, 0x2.48380232f6c16p+0) * Interval(0xc.3d8e305214ecp-4, 0x2.9e7db05203c88p+0) == Interval(0x2.587a32d02bc04p-4, 0x5.fa216b7c20c6cp+0)
end

@testset "mpfi_mul_d" begin
    # special values
    @test Interval(-Inf, -7.0) * Interval(-0x17p0, -0x17p0) == Interval(+0xa1p0, Inf)
    @test Interval(-Inf, -7.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(-Inf, -7.0) * Interval(0x170ef54646d497p-107, 0x170ef54646d497p-107) == Interval(-Inf, -0xa168b4ebefd020p-107)
    @test Interval(-Inf, 0.0) * Interval(-0x170ef54646d497p-106, -0x170ef54646d497p-106) == Interval(0.0, Inf)
    @test Interval(-Inf, 0.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(-Inf, 0.0) * Interval(0x170ef54646d497p-106, 0x170ef54646d497p-106) == Interval(-Inf, 0.0)
    @test Interval(-Inf, 8.0) * Interval(-0x16345785d8a00000p0, -0x16345785d8a00000p0) == Interval(-0xb1a2bc2ec5000000p0, Inf)
    @test Interval(-Inf, 8.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(-Inf, 8.0) * Interval(0x16345785d8a00000p0, 0x16345785d8a00000p0) == Interval(-Inf, 0xb1a2bc2ec5000000p0)
    @test entireinterval(Float64) * Interval(-0x170ef54646d497p-105, -0x170ef54646d497p-105) == entireinterval(Float64)
    @test entireinterval(Float64) * Interval(0.0e-17, 0.0e-17) == Interval(0.0, 0.0)
    @test entireinterval(Float64) * Interval(+0x170ef54646d497p-105, +0x170ef54646d497p-105) == entireinterval(Float64)
    @test Interval(0.0, 0.0) * Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) * Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109) == Interval(0.0, 0.0)
    @test Interval(0.0, 7.0) * Interval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107) == Interval(-0x790e87b0f3dc18p-107, 0.0)
    @test Interval(0.0, 8.0) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, 9.0) * Interval(0x114b37f4b51f71p-103, 0x114b37f4b51f71p-103) == Interval(0.0, 0x9ba4f79a5e1b00p-103)
    @test Interval(0.0, Inf) * Interval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104) == Interval(-Inf, 0.0)
    @test Interval(0.0, Inf) * Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, Inf) * Interval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106) == Interval(0.0, Inf)
    # regular values
    @test Interval(-0x1717170p0, -0xaaaaaaaaaaaaap-123) * Interval(-1.5, -1.5) == Interval(0xfffffffffffffp-123, 0x22a2a28p0)
    @test Interval(-0xaaaaaaaaaaaaap0, 0x1717170p+401) * Interval(-1.5, -1.5) == Interval(-0x22a2a28p+401, 0xfffffffffffffp0)
    @test Interval(0x10000000000010p0, 0x888888888888p+654) * Interval(-2.125, -2.125) == Interval(-0x1222222222221p+654, -0x22000000000022p0)
    @test Interval(-0x1717170p0, -0xaaaaaaaaaaaaap-123) * Interval(1.5, 1.5) == Interval(-0x22a2a28p0, -0xfffffffffffffp-123)
    @test Interval(-0xaaaaaaaaaaaaap0, 0x1717170p+401) * Interval(1.5, 1.5) == Interval(-0xfffffffffffffp0, 0x22a2a28p+401)
    @test Interval(0x10000000000010p0, 0x888888888888p+654) * Interval(2.125, 2.125) == Interval(0x22000000000022p0, 0x1222222222221p+654)
    @test Interval(-0x1717170p+36, -0x10000000000001p0) * Interval(-1.5, -1.5) == Interval(0x18000000000001p0, 0x22a2a28p+36)
    @test Interval(-0xaaaaaaaaaaaaap0, 0x10000000000001p0) * Interval(-1.5, -1.5) == Interval(-0x18000000000002p0, 0xfffffffffffffp0)
    @test Interval(0x10000000000010p0, 0x11111111111111p0) * Interval(-2.125, -2.125) == Interval(-0x12222222222223p+1, -0x22000000000022p0)
    @test Interval(-0x10000000000001p0, -0xaaaaaaaaaaaaap-123) * Interval(1.5, 1.5) == Interval(-0x18000000000002p0, -0xfffffffffffffp-123)
    @test Interval(-0xaaaaaaaaaaaabp0, 0x1717170p+401) * Interval(1.5, 1.5) == Interval(-0x10000000000001p0, 0x22a2a28p+401)
    @test Interval(0x10000000000001p0, 0x888888888888p+654) * Interval(2.125, 2.125) == Interval(0x22000000000002p0, 0x1222222222221p+654)
    @test Interval(-0x11717171717171p0, -0xaaaaaaaaaaaaap-123) * Interval(-1.5, -1.5) == Interval(0xfffffffffffffp-123, 0x1a2a2a2a2a2a2ap0)
    @test Interval(-0x10000000000001p0, 0x1717170p+401) * Interval(-1.5, -1.5) == Interval(-0x22a2a28p+401, 0x18000000000002p0)
    @test Interval(0x10000000000001p0, 0x888888888888p+654) * Interval(-2.125, -2.125) == Interval(-0x1222222222221p+654, -0x22000000000002p0)
    @test Interval(-0x1717170p0, -0x1aaaaaaaaaaaaap-123) * Interval(1.5, 1.5) == Interval(-0x22a2a28p0, -0x27fffffffffffep-123)
    @test Interval(-0xaaaaaaaaaaaaap0, 0x11717171717171p0) * Interval(1.5, 1.5) == Interval(-0xfffffffffffffp0, 0x1a2a2a2a2a2a2ap0)
    @test Interval(0x10000000000010p0, 0x18888888888889p0) * Interval(2.125, 2.125) == Interval(0x22000000000022p0, 0x34222222222224p0)
    @test Interval(-0x11717171717171p0, -0x10000000000001p0) * Interval(-1.5, -1.5) == Interval(0x18000000000001p0, 0x1a2a2a2a2a2a2ap0)
    @test Interval(-0x10000000000001p0, 0x10000000000001p0) * Interval(-1.5, -1.5) == Interval(-0x18000000000002p0, 0x18000000000002p0)
    @test Interval(0x10000000000001p0, 0x11111111111111p0) * Interval(-2.125, -2.125) == Interval(-0x12222222222223p+1, -0x22000000000002p0)
    @test Interval(-0x10000000000001p0, -0x1aaaaaaaaaaaaap-123) * Interval(1.5, 1.5) == Interval(-0x18000000000002p0, -0x27fffffffffffep-123)
    @test Interval(-0xaaaaaaaaaaaabp0, 0x11717171717171p0) * Interval(1.5, 1.5) == Interval(-0x10000000000001p0, 0x1a2a2a2a2a2a2ap0)
    @test Interval(0x10000000000001p0, 0x18888888888889p0) * Interval(2.125, 2.125) == Interval(0x22000000000002p0, 0x34222222222224p0)
end

@testset "mpfi_neg" begin
    # special values
    @test -(Interval(-Inf, -7.0)) == Interval(+7.0, Inf)
    @test -(Interval(-Inf, 0.0)) == Interval(0.0, Inf)
    @test -(Interval(-Inf, +8.0)) == Interval(-8.0, Inf)
    @test -(entireinterval(Float64)) == entireinterval(Float64)
    @test -(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test -(Interval(0.0, +8.0)) == Interval(-8.0, 0.0)
    @test -(Interval(0.0, Inf)) == Interval(-Inf, 0.0)
    # regular values
    @test -(Interval(0x123456789p-16, 0x123456799p-16)) == Interval(-0x123456799p-16, -0x123456789p-16)
end

@testset "mpfi_put_d" begin
    # special values
    @test hull(Interval(0.0, 0.0), Interval(-8.0, -8.0)) == Interval(-8.0, 0.0)
    @test ∪(Interval(0.0, 0.0), Interval(-8.0, -8.0)) == Interval(-8.0, 0.0)
    @test (Interval(0.0, 0.0) ∪ Interval(-8.0, -8.0)) == Interval(-8.0, 0.0)
    @test hull(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test ∪(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0) ∪ Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test hull(Interval(+5.0, +5.0), Interval(0.0, 0.0)) == Interval(0.0, +5.0)
    @test ∪(Interval(+5.0, +5.0), Interval(0.0, 0.0)) == Interval(0.0, +5.0)
    @test (Interval(+5.0, +5.0) ∪ Interval(0.0, 0.0)) == Interval(0.0, +5.0)
end

@testset "mpfi_sec" begin
    # special values
    @test sec(Interval(-Inf, -7.0)) == entireinterval(Float64)
    @test sec(Interval(-Inf, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-Inf, 8.0)) == entireinterval(Float64)
    @test sec(entireinterval(Float64)) == entireinterval(Float64)
    @test sec(Interval(-8.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 0.0)) == Interval(1.0, 0x1d9cf0f125cc2ap-52)
    @test sec(Interval(0.0, 0.0)) == Interval(1.0, 1.0)
    @test sec(Interval(0.0, +1.0)) == Interval(1.0, 0x1d9cf0f125cc2ap-52)
    @test sec(Interval(0.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(0.0, 8.0)) == entireinterval(Float64)
    @test sec(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test sec(Interval(-6.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 1.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, -1.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, -2.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, -3.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, -4.0)) == entireinterval(Float64)
    @test sec(Interval(-6.0, -5.0)) == Interval(0x10a9e8f3e19df1p-52, 0x1c33db0464189bp-51)
    @test sec(Interval(-6.0, -6.0)) == Interval(0x10a9e8f3e19df1p-52, 0x10a9e8f3e19df2p-52)
    @test sec(Interval(-5.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 1.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, -1.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, -2.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, -3.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, -4.0)) == entireinterval(Float64)
    @test sec(Interval(-5.0, -5.0)) == Interval(0x1c33db0464189ap-51, 0x1c33db0464189bp-51)
    @test sec(Interval(-4.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 1.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, -1.0)) == entireinterval(Float64)
    @test sec(Interval(-4.0, -2.0)) == Interval(-0x133956fecf9e49p-51, -1.0)
    @test sec(Interval(-4.0, -3.0)) == Interval(-0x187a6961d2485fp-52, -1.0)
    @test sec(Interval(-4.0, -4.0)) == Interval(-0x187a6961d2485fp-52, -0x187a6961d2485ep-52)
    @test sec(Interval(-3.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 1.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, -1.0)) == entireinterval(Float64)
    @test sec(Interval(-3.0, -2.0)) == Interval(-0x133956fecf9e49p-51, -0x102967b457b245p-52)
    @test sec(Interval(-3.0, -3.0)) == Interval(-0x102967b457b246p-52, -0x102967b457b245p-52)
    @test sec(Interval(-2.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 1.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, 0.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, -1.0)) == entireinterval(Float64)
    @test sec(Interval(-2.0, -2.0)) == Interval(-0x133956fecf9e49p-51, -0x133956fecf9e48p-51)
    @test sec(Interval(-1.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(-1.0, 1.0)) == Interval(1.0, 0x1d9cf0f125cc2ap-52)
    @test sec(Interval(-1.0, 0.0)) == Interval(1.0, 0x1d9cf0f125cc2ap-52)
    @test sec(Interval(-1.0, -1.0)) == Interval(0x1d9cf0f125cc29p-52, 0x1d9cf0f125cc2ap-52)
    @test sec(Interval(1.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(1.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(1.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(1.0, 4.0)) == entireinterval(Float64)
    @test sec(Interval(1.0, 3.0)) == entireinterval(Float64)
    @test sec(Interval(1.0, 2.0)) == entireinterval(Float64)
    @test sec(Interval(1.0, 1.0)) == Interval(0x1d9cf0f125cc29p-52, 0x1d9cf0f125cc2ap-52)
    @test sec(Interval(2.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(2.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(2.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(2.0, 4.0)) == Interval(-0x133956fecf9e49p-51, -1.0)
    @test sec(Interval(2.0, 3.0)) == Interval(-0x133956fecf9e49p-51, -0x102967b457b245p-52)
    @test sec(Interval(2.0, 2.0)) == Interval(-0x133956fecf9e49p-51, -0x133956fecf9e48p-51)
    @test sec(Interval(3.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(3.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(3.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(3.0, 4.0)) == Interval(-0x187a6961d2485fp-52, -1.0)
    @test sec(Interval(3.0, 3.0)) == Interval(-0x102967b457b246p-52, -0x102967b457b245p-52)
    @test sec(Interval(4.0, 7.0)) == entireinterval(Float64)
    @test sec(Interval(4.0, 6.0)) == entireinterval(Float64)
    @test sec(Interval(4.0, 5.0)) == entireinterval(Float64)
    @test sec(Interval(4.0, 4.0)) == Interval(-0x187a6961d2485fp-52, -0x187a6961d2485ep-52)
    @test sec(Interval(5.0, 7.0)) == Interval(1.0, 0x1c33db0464189bp-51)
    @test sec(Interval(5.0, 6.0)) == Interval(0x10a9e8f3e19df1p-52, 0x1c33db0464189bp-51)
    @test sec(Interval(5.0, 5.0)) == Interval(0x1c33db0464189ap-51, 0x1c33db0464189bp-51)
    @test sec(Interval(6.0, 7.0)) == Interval(1.0, 0x153910a80e7db5p-52)
    @test sec(Interval(6.0, 6.0)) == Interval(0x10a9e8f3e19df1p-52, 0x10a9e8f3e19df2p-52)
    @test sec(Interval(7.0, 7.0)) == Interval(0x153910a80e7db4p-52, 0x153910a80e7db5p-52)
end

@testset "mpfi_sech" begin
    # special values
    @test sech(Interval(-Inf, -7.0)) == Interval(0.0, 0x1de169fb49b339p-62)
    @test sech(Interval(-Inf, 0.0)) == Interval(0.0, 1.0)
    @test sech(Interval(-Inf, +8.0)) == Interval(0.0, 1.0)
    @test sech(entireinterval(Float64)) == Interval(0.0, 1.0)
    @test sech(Interval(-1.0, 0.0)) == Interval(0x14bcdc50ed6be7p-53, 1.0)
    @test sech(Interval(0.0, 0.0)) == Interval(1.0, 1.0)
    @test sech(Interval(0.0, +1.0)) == Interval(0x14bcdc50ed6be7p-53, 1.0)
    @test sech(Interval(0.0, +8.0)) == Interval(0x15fc20da8e18dbp-63, 1.0)
    @test sech(Interval(0.0, Inf)) == Interval(0.0, 1.0)
    # regular values
    @test sech(Interval(-0.125, 0.0)) == Interval(0x1fc069fe3f72bep-53, 1.0)
    @test sech(Interval(0.0, 0x10000000000001p-53)) == Interval(0x1c60d1ff040dcfp-53, 1.0)
    @test sech(Interval(-4.5, -0.625)) == Interval(0x16bf984a9a2355p-58, 0x1aa0b464a5e24ap-53)
    @test sech(Interval(1.0, 3.0)) == Interval(0x196d8e17d88eb1p-56, 0x14bcdc50ed6be8p-53)
    @test sech(Interval(17.0, 0xb145bb71d3dbp-38)) == Interval(0x10000000000173p-1074, 0x1639e3175a6893p-76)
end

@testset "mpfi_sin" begin
    # special values
    @test sin(Interval(-Inf, -7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-Inf, 0.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-Inf, +8.0)) == Interval(-1.0, 1.0)
    @test sin(entireinterval(Float64)) == Interval(-1.0, 1.0)
    @test sin(Interval(-1.0, 0.0)) == Interval(-0x1aed548f090cefp-53, 0.0)
    @test sin(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test sin(Interval(0.0, +1.0)) == Interval(0.0, 0x1aed548f090cefp-53)
    @test sin(Interval(0.0, +8.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(0.0, Inf)) == Interval(-1.0, 1.0)
    # regular values
    @test sin(Interval(0.125, 17.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(0x1921fb54442d18p-52, 0x1921fb54442d19p-52)) == Interval(0x1fffffffffffffp-53, 1.0)
    @test sin(Interval(-2.0, -0.5)) == Interval(-1.0, -0x1eaee8744b05efp-54)
    @test sin(Interval(-4.5, 0.625)) == Interval(-1.0, 0x1f47ed3dc74081p-53)
    @test sin(Interval(-1.0, -0.25)) == Interval(-0x1aed548f090cefp-53, -0x1faaeed4f31576p-55)
    @test sin(Interval(-0.5, 0.5)) == Interval(-0x1eaee8744b05f0p-54, 0x1eaee8744b05f0p-54)
    @test sin(Interval(0x71p+76, 0x71p+76)) == Interval(0x1bde6c11cbfc46p-55, 0x1bde6c11cbfc47p-55)
    @test sin(Interval(-7.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 4.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 3.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 2.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 1.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, 0.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, -1.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-7.0, -2.0)) == Interval(-0x1d18f6ead1b446p-53, 1.0)
    @test sin(Interval(-7.0, -3.0)) == Interval(-0x150608c26d0a09p-53, 1.0)
    @test sin(Interval(-7.0, -4.0)) == Interval(-0x150608c26d0a09p-53, 1.0)
    @test sin(Interval(-7.0, -5.0)) == Interval(-0x150608c26d0a09p-53, 0x1eaf81f5e09934p-53)
    @test sin(Interval(-7.0, -6.0)) == Interval(-0x150608c26d0a09p-53, 0x11e1f18ab0a2c1p-54)
    @test sin(Interval(-7.0, -7.0)) == Interval(-0x150608c26d0a09p-53, -0x150608c26d0a08p-53)
    @test sin(Interval(-6.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 4.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 3.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 2.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 1.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, 0.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, -1.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-6.0, -2.0)) == Interval(-0x1d18f6ead1b446p-53, 1.0)
    @test sin(Interval(-6.0, -3.0)) == Interval(-0x1210386db6d55cp-55, 1.0)
    @test sin(Interval(-6.0, -4.0)) == Interval(0x11e1f18ab0a2c0p-54, 1.0)
    @test sin(Interval(-6.0, -5.0)) == Interval(0x11e1f18ab0a2c0p-54, 0x1eaf81f5e09934p-53)
    @test sin(Interval(-6.0, -6.0)) == Interval(0x11e1f18ab0a2c0p-54, 0x11e1f18ab0a2c1p-54)
    @test sin(Interval(-5.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 4.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 3.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 2.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 1.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, 0.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, -1.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-5.0, -2.0)) == Interval(-0x1d18f6ead1b446p-53, 1.0)
    @test sin(Interval(-5.0, -3.0)) == Interval(-0x1210386db6d55cp-55, 1.0)
    @test sin(Interval(-5.0, -4.0)) == Interval(0x1837b9dddc1eaep-53, 1.0)
    @test sin(Interval(-5.0, -5.0)) == Interval(0x1eaf81f5e09933p-53, 0x1eaf81f5e09934p-53)
    @test sin(Interval(-4.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-4.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-4.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-4.0, 4.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-4.0, 3.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-4.0, 2.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-4.0, 1.0)) == Interval(-1.0, 0x1aed548f090cefp-53)
    @test sin(Interval(-4.0, 0.0)) == Interval(-1.0, 0x1837b9dddc1eafp-53)
    @test sin(Interval(-4.0, -1.0)) == Interval(-1.0, 0x1837b9dddc1eafp-53)
    @test sin(Interval(-4.0, -2.0)) == Interval(-0x1d18f6ead1b446p-53, 0x1837b9dddc1eafp-53)
    @test sin(Interval(-4.0, -3.0)) == Interval(-0x1210386db6d55cp-55, 0x1837b9dddc1eafp-53)
    @test sin(Interval(-4.0, -4.0)) == Interval(0x1837b9dddc1eaep-53, 0x1837b9dddc1eafp-53)
    @test sin(Interval(-3.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-3.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-3.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-3.0, 4.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-3.0, 3.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-3.0, 2.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-3.0, 1.0)) == Interval(-1.0, 0x1aed548f090cefp-53)
    @test sin(Interval(-3.0, 0.0)) == Interval(-1.0, 0.0)
    @test sin(Interval(-3.0, -1.0)) == Interval(-1.0, -0x1210386db6d55bp-55)
    @test sin(Interval(-3.0, -2.0)) == Interval(-0x1d18f6ead1b446p-53, -0x1210386db6d55bp-55)
    @test sin(Interval(-3.0, -3.0)) == Interval(-0x1210386db6d55cp-55, -0x1210386db6d55bp-55)
    @test sin(Interval(-2.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-2.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-2.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-2.0, 4.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-2.0, 3.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-2.0, 2.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-2.0, 1.0)) == Interval(-1.0, 0x1aed548f090cefp-53)
    @test sin(Interval(-2.0, 0.0)) == Interval(-1.0, 0.0)
    @test sin(Interval(-2.0, -1.0)) == Interval(-1.0, -0x1aed548f090ceep-53)
    @test sin(Interval(-2.0, -2.0)) == Interval(-0x1d18f6ead1b446p-53, -0x1d18f6ead1b445p-53)
    @test sin(Interval(-1.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-1.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-1.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(-1.0, 4.0)) == Interval(-0x1aed548f090cefp-53, 1.0)
    @test sin(Interval(-1.0, 3.0)) == Interval(-0x1aed548f090cefp-53, 1.0)
    @test sin(Interval(-1.0, 2.0)) == Interval(-0x1aed548f090cefp-53, 1.0)
    @test sin(Interval(-1.0, 1.0)) == Interval(-0x1aed548f090cefp-53, 0x1aed548f090cefp-53)
    @test sin(Interval(-1.0, 0.0)) == Interval(-0x1aed548f090cefp-53, 0.0)
    @test sin(Interval(-1.0, -1.0)) == Interval(-0x1aed548f090cefp-53, -0x1aed548f090ceep-53)
    @test sin(Interval(1.0, 7.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(1.0, 6.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(1.0, 5.0)) == Interval(-1.0, 1.0)
    @test sin(Interval(1.0, 4.0)) == Interval(-0x1837b9dddc1eafp-53, 1.0)
    @test sin(Interval(1.0, 3.0)) == Interval(0x1210386db6d55bp-55, 1.0)
    @test sin(Interval(1.0, 2.0)) == Interval(0x1aed548f090ceep-53, 1.0)
    @test sin(Interval(1.0, 1.0)) == Interval(0x1aed548f090ceep-53, 0x1aed548f090cefp-53)
    @test sin(Interval(2.0, 7.0)) == Interval(-1.0, 0x1d18f6ead1b446p-53)
    @test sin(Interval(2.0, 6.0)) == Interval(-1.0, 0x1d18f6ead1b446p-53)
    @test sin(Interval(2.0, 5.0)) == Interval(-1.0, 0x1d18f6ead1b446p-53)
    @test sin(Interval(2.0, 4.0)) == Interval(-0x1837b9dddc1eafp-53, 0x1d18f6ead1b446p-53)
    @test sin(Interval(2.0, 3.0)) == Interval(0x1210386db6d55bp-55, 0x1d18f6ead1b446p-53)
    @test sin(Interval(2.0, 2.0)) == Interval(0x1d18f6ead1b445p-53, 0x1d18f6ead1b446p-53)
    @test sin(Interval(3.0, 7.0)) == Interval(-1.0, 0x150608c26d0a09p-53)
    @test sin(Interval(3.0, 6.0)) == Interval(-1.0, 0x1210386db6d55cp-55)
    @test sin(Interval(3.0, 5.0)) == Interval(-1.0, 0x1210386db6d55cp-55)
    @test sin(Interval(3.0, 4.0)) == Interval(-0x1837b9dddc1eafp-53, 0x1210386db6d55cp-55)
    @test sin(Interval(3.0, 3.0)) == Interval(0x1210386db6d55bp-55, 0x1210386db6d55cp-55)
    @test sin(Interval(4.0, 7.0)) == Interval(-1.0, 0x150608c26d0a09p-53)
    @test sin(Interval(4.0, 6.0)) == Interval(-1.0, -0x11e1f18ab0a2c0p-54)
    @test sin(Interval(4.0, 5.0)) == Interval(-1.0, -0x1837b9dddc1eaep-53)
    @test sin(Interval(4.0, 4.0)) == Interval(-0x1837b9dddc1eafp-53, -0x1837b9dddc1eaep-53)
    @test sin(Interval(5.0, 7.0)) == Interval(-0x1eaf81f5e09934p-53, 0x150608c26d0a09p-53)
    @test sin(Interval(5.0, 6.0)) == Interval(-0x1eaf81f5e09934p-53, -0x11e1f18ab0a2c0p-54)
    @test sin(Interval(5.0, 5.0)) == Interval(-0x1eaf81f5e09934p-53, -0x1eaf81f5e09933p-53)
    @test sin(Interval(6.0, 7.0)) == Interval(-0x11e1f18ab0a2c1p-54, 0x150608c26d0a09p-53)
    @test sin(Interval(6.0, 6.0)) == Interval(-0x11e1f18ab0a2c1p-54, -0x11e1f18ab0a2c0p-54)
    @test sin(Interval(7.0, 7.0)) == Interval(0x150608c26d0a08p-53, 0x150608c26d0a09p-53)
end

@testset "mpfi_sinh" begin
    # special values
    @test sinh(Interval(-Inf, -7.0)) == Interval(-Inf, -0x1122876ba380c9p-43)
    @test sinh(Interval(-Inf, 0.0)) == Interval(-Inf, 0.0)
    @test sinh(Interval(-Inf, +8.0)) == Interval(-Inf, 0x1749ea514eca66p-42)
    @test sinh(entireinterval(Float64)) == entireinterval(Float64)
    @test sinh(Interval(-1.0, 0.0)) == Interval(-0x12cd9fc44eb983p-52, 0.0)
    @test sinh(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test sinh(Interval(0.0, +1.0)) == Interval(0.0, 0x12cd9fc44eb983p-52)
    @test sinh(Interval(0.0, +8.0)) == Interval(0.0, 0x1749ea514eca66p-42)
    @test sinh(Interval(0.0, Inf)) == Interval(0.0, Inf)
    # regular values
    @test sinh(Interval(-0.125, 0.0)) == Interval(-0x100aaccd00d2f1p-55, 0.0)
    @test sinh(Interval(0.0, 0x10000000000001p-53)) == Interval(0.0, 0x10acd00fe63b98p-53)
    @test sinh(Interval(-4.5, -0.625)) == Interval(-0x168062ab5fa9fdp-47, -0x1553e795dc19ccp-53)
    @test sinh(Interval(1.0, 3.0)) == Interval(0x12cd9fc44eb982p-52, 0x140926e70949aep-49)
end

@testset "mpfi_sqr" begin
    # special values
    @test Interval(-Inf, -7.0) ^2 == Interval(+49.0, Inf)
    @test Interval(-Inf, -7.0) ^(2//1) == Interval(+49.0, Inf)
    @test Interval(-Inf, -7.0) ^(2.0) == Interval(+49.0, Inf)
    @test Interval(-Inf, 0.0) ^2 == Interval(0.0, Inf)
    @test Interval(-Inf, 0.0) ^(2//1) == Interval(0.0, Inf)
    @test Interval(-Inf, 0.0) ^(2.0) == Interval(0.0, Inf)
    @test Interval(-Inf, +8.0) ^2 == Interval(0.0, Inf)
    @test Interval(-Inf, +8.0) ^(2//1) == Interval(0.0, Inf)
    @test Interval(-Inf, +8.0) ^(2.0) == Interval(0.0, Inf)
    @test entireinterval(Float64) ^2 == Interval(0.0, Inf)
    @test entireinterval(Float64) ^(2//1) == Interval(0.0, Inf)
    @test entireinterval(Float64) ^(2.0) == Interval(0.0, Inf)
    @test Interval(0.0, 0.0) ^2 == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) ^(2//1) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) ^(2.0) == Interval(0.0, 0.0)
    @test Interval(0.0, +8.0) ^2 == Interval(0.0, +64.0)
    @test Interval(0.0, +8.0) ^(2//1) == Interval(0.0, +64.0)
    @test Interval(0.0, +8.0) ^(2.0) == Interval(0.0, +64.0)
    @test Interval(0.0, Inf) ^2 == Interval(0.0, Inf)
    @test Interval(0.0, Inf) ^(2//1) == Interval(0.0, Inf)
    @test Interval(0.0, Inf) ^(2.0) == Interval(0.0, Inf)
    # regular values
    @test Interval(0x8.6374d8p-4, 0x3.f1d929p+8) ^2 == Interval(0x4.65df11464764p-4, 0xf.8f918d688891p+16)
    @test Interval(0x8.6374d8p-4, 0x3.f1d929p+8) ^(2//1) == Interval(0x4.65df11464764p-4, 0xf.8f918d688891p+16)
    @test Interval(0x8.6374d8p-4, 0x3.f1d929p+8) ^(2.0) == Interval(0x4.65df11464764p-4, 0xf.8f918d688891p+16)
    @test Interval(0x6.61485c33c0b14p+4, 0x123456p0) ^2 == Interval(0x2.8b45c3cc03ea6p+12, 0x14b66cb0ce4p0)
    @test Interval(0x6.61485c33c0b14p+4, 0x123456p0) ^(2//1) == Interval(0x2.8b45c3cc03ea6p+12, 0x14b66cb0ce4p0)
    @test Interval(0x6.61485c33c0b14p+4, 0x123456p0) ^(2.0) == Interval(0x2.8b45c3cc03ea6p+12, 0x14b66cb0ce4p0)
    @test Interval(-0x1.64722ad2480c9p+0, 0x1p0) ^2 == Interval(0.0, 0x1.f04dba0302d4dp+0)
    @test Interval(-0x1.64722ad2480c9p+0, 0x1p0) ^(2//1) == Interval(0.0, 0x1.f04dba0302d4dp+0)
    @test Interval(-0x1.64722ad2480c9p+0, 0x1p0) ^(2.0) == Interval(0.0, 0x1.f04dba0302d4dp+0)
    @test Interval(0x1.6b079248747a2p+0, 0x2.b041176d263f6p+0) ^2 == Interval(0x2.02ce7912cddf6p+0, 0x7.3a5dee779527p+0)
    @test Interval(0x1.6b079248747a2p+0, 0x2.b041176d263f6p+0) ^(2//1) == Interval(0x2.02ce7912cddf6p+0, 0x7.3a5dee779527p+0)
    @test Interval(0x1.6b079248747a2p+0, 0x2.b041176d263f6p+0) ^(2.0) == Interval(0x2.02ce7912cddf6p+0, 0x7.3a5dee779527p+0)
end

@testset "mpfi_sqrt" begin
    # special values
    @test sqrt(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0))^(1/2) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0))^(0.5) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0))^(1//2) == Interval(0.0, 0.0)
    @test sqrt(Interval(0.0, +9.0)) == Interval(0.0, +3.0)
    @test (Interval(0.0, +9.0))^(1/2) == Interval(0.0, +3.0)
    @test (Interval(0.0, +9.0))^(0.5) == Interval(0.0, +3.0)
    @test (Interval(0.0, +9.0))^(1//2) == Interval(0.0, +3.0)
    @test sqrt(Interval(0.0, Inf)) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf))^(1/2) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf))^(0.5) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf))^(1//2) == Interval(0.0, Inf)
    # regular values
    @test sqrt(Interval(0xaaa1p0, 0x14b66cb0ce4p0)) == Interval(0xd1p0, 0x123456p0)
    @test (Interval(0xaaa1p0, 0x14b66cb0ce4p0))^(1/2) == Interval(0xd1p0, 0x123456p0)
    @test (Interval(0xaaa1p0, 0x14b66cb0ce4p0))^(0.5) == Interval(0xd1p0, 0x123456p0)
    @test (Interval(0xaaa1p0, 0x14b66cb0ce4p0))^(1//2) == Interval(0xd1p0, 0x123456p0)
    @test sqrt(Interval(0xe.49ae7969e41bp-4, 0xaaa1p0)) == Interval(0xf.1ea42821b27a8p-4, 0xd1p0)
    @test (Interval(0xe.49ae7969e41bp-4, 0xaaa1p0))^(1/2) == Interval(0xf.1ea42821b27a8p-4, 0xd1p0)
    @test (Interval(0xe.49ae7969e41bp-4, 0xaaa1p0))^(0.5) == Interval(0xf.1ea42821b27a8p-4, 0xd1p0)
    @test (Interval(0xe.49ae7969e41bp-4, 0xaaa1p0))^(1//2) == Interval(0xf.1ea42821b27a8p-4, 0xd1p0)
    @test sqrt(Interval(0xa.aa1p-4, 0x1.0c348f804c7a9p+0)) == Interval(0xd.1p-4, 0x1.06081714eef1dp+0)
    @test (Interval(0xa.aa1p-4, 0x1.0c348f804c7a9p+0))^(1/2) == Interval(0xd.1p-4, 0x1.06081714eef1dp+0)
    @test (Interval(0xa.aa1p-4, 0x1.0c348f804c7a9p+0))^(0.5) == Interval(0xd.1p-4, 0x1.06081714eef1dp+0)
    @test (Interval(0xa.aa1p-4, 0x1.0c348f804c7a9p+0))^(1//2) == Interval(0xd.1p-4, 0x1.06081714eef1dp+0)
    @test sqrt(Interval(0xe.49ae7969e41bp-4, 0x1.0c348f804c7a9p+0)) == Interval(0xf.1ea42821b27a8p-4, 0x1.06081714eef1dp+0)
    @test (Interval(0xe.49ae7969e41bp-4, 0x1.0c348f804c7a9p+0))^(1/2) == Interval(0xf.1ea42821b27a8p-4, 0x1.06081714eef1dp+0)
    @test (Interval(0xe.49ae7969e41bp-4, 0x1.0c348f804c7a9p+0))^(0.5) == Interval(0xf.1ea42821b27a8p-4, 0x1.06081714eef1dp+0)
    @test (Interval(0xe.49ae7969e41bp-4, 0x1.0c348f804c7a9p+0))^(1//2) == Interval(0xf.1ea42821b27a8p-4, 0x1.06081714eef1dp+0)
end

@testset "mpfi_sub" begin
    # special values
    @test Interval(-Inf, -7.0) - Interval(-1.0, +8.0) == Interval(-Inf, -6.0)
    @test Interval(-Inf, 0.0) - Interval(+8.0, Inf) == Interval(-Inf, -8.0)
    @test Interval(-Inf, +8.0) - Interval(0.0, +8.0) == Interval(-Inf, +8.0)
    @test entireinterval(Float64) - Interval(0.0, +8.0) == entireinterval(Float64)
    @test Interval(0.0, 0.0) - Interval(-Inf, -7.0) == Interval(+7.0, Inf)
    @test Interval(0.0, +8.0) - Interval(-7.0, 0.0) == Interval(0.0, +15.0)
    @test Interval(0.0, 0.0) - Interval(0.0, +8.0) == Interval(-8.0, 0.0)
    @test Interval(0.0, Inf) - Interval(0.0, +8.0) == Interval(-8.0, Inf)
    @test Interval(0.0, 0.0) - Interval(+8.0, Inf) == Interval(-Inf, -8.0)
    @test Interval(0.0, 0.0) - entireinterval(Float64) == entireinterval(Float64)
    @test Interval(0.0, +8.0) - Interval(-7.0, +8.0) == Interval(-8.0, +15.0)
    @test Interval(0.0, 0.0) - Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, Inf) - Interval(0.0, +8.0) == Interval(-8.0, Inf)
    # regular values
    @test Interval(-5.0, 59.0) - Interval(17.0, 81.0) == Interval(-86.0, 42.0)
    @test Interval(-0x1p-300, 0x123456p+28) - Interval(-0x789abcdp0, 0x10000000000000p-93) == Interval(-0x10000000000001p-93, 0x123456789abcdp0)
    @test Interval(-4.0, 7.0) - Interval(-3e300, 0x123456789abcdp-17) == Interval(-0x123456791abcdp-17, 0x8f596b3002c1bp+947)
    @test Interval(-0x1000100010001p+8, 0x1p+60) - Interval(-3e300, 0x1000100010001p0) == Interval(-0x10101010101011p+4, 0x8f596b3002c1bp+947)
    @test Interval(-5.0, 1.0) - Interval(1.0, 0x1p+70) == Interval(-0x10000000000001p+18, 0.0)
    @test Interval(5.0, 0x1p+70) - Interval(3.0, 5.0) == Interval(0.0, 0x1p+70)
end

@testset "mpfi_sub_d" begin
    # special values
    @test Interval(-Inf, -7.0) - Interval(-0x170ef54646d497p-107, -0x170ef54646d497p-107) == Interval(-Inf, -0x1bffffffffffffp-50)
    @test Interval(-Inf, -7.0) - Interval(0.0, 0.0) == Interval(-Inf, -7.0)
    @test Interval(-Inf, -7.0) - Interval(0x170ef54646d497p-107, 0x170ef54646d497p-107) == Interval(-Inf, -7.0)
    @test Interval(-Inf, 0.0) - Interval(-0x170ef54646d497p-106, -0x170ef54646d497p-106) == Interval(-Inf, 0x170ef54646d497p-106)
    @test Interval(-Inf, 0.0) - Interval(0.0, 0.0) == Interval(-Inf, 0.0)
    @test Interval(-Inf, 0.0) - Interval(0x170ef54646d497p-106, 0x170ef54646d497p-106) == Interval(-Inf, -8.0e-17)
    @test Interval(-Inf, 8.0) - Interval(-0x16345785d8a00000p0, -0x16345785d8a00000p0) == Interval(-Inf, 0x16345785d8a00100p0)
    @test Interval(-Inf, 8.0) - Interval(0.0, 0.0) == Interval(-Inf, 8.0)
    @test Interval(-Inf, 8.0) - Interval(0x16345785d8a00000p0, 0x16345785d8a00000p0) == Interval(-Inf, -0x16345785d89fff00p0)
    @test entireinterval(Float64) - Interval(-0x170ef54646d497p-105, -0x170ef54646d497p-105) == entireinterval(Float64)
    @test entireinterval(Float64) - Interval(0.0e-17, 0.0e-17) == entireinterval(Float64)
    @test entireinterval(Float64) - Interval(+0x170ef54646d497p-105, +0x170ef54646d497p-105) == entireinterval(Float64)
    @test Interval(0.0, 0.0) - Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109) == Interval(+0x170ef54646d497p-109, +0x170ef54646d497p-109)
    @test Interval(0.0, 0.0) - Interval(0.0, 0.0) == Interval(0.0, 0.0)
    @test Interval(0.0, 0.0) - Interval(0x170ef54646d497p-109, 0x170ef54646d497p-109) == Interval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)
    @test Interval(0.0, 8.0) - Interval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107) == Interval(0x114b37f4b51f71p-107, 0x10000000000001p-49)
    @test Interval(0.0, 8.0) - Interval(0.0, 0.0) == Interval(0.0, 8.0)
    @test Interval(0.0, 8.0) - Interval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107) == Interval(-0x114b37f4b51f71p-107, 8.0)
    @test Interval(0.0, Inf) - Interval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104) == Interval(0x50b45a75f7e81p-104, Inf)
    @test Interval(0.0, Inf) - Interval(0.0, 0.0) == Interval(0.0, Inf)
    @test Interval(0.0, Inf) - Interval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106) == Interval(-0x142d169d7dfa03p-106, Inf)
    # regular values
    @test Interval(-32.0, -17.0) - Interval(0xfb53d14aa9c2fp-47, 0xfb53d14aa9c2fp-47) == Interval(-0x1fb53d14aa9c2fp-47, -0x18353d14aa9c2fp-47)
    @test Interval(-0xfb53d14aa9c2fp-47, -17.0) - Interval(-0xfb53d14aa9c2fp-47, -0xfb53d14aa9c2fp-47) == Interval(0.0, 0x7353d14aa9c2fp-47)
    @test Interval(-32.0, -0xfb53d14aa9c2fp-48) - Interval(-0xfb53d14aa9c2fp-48, -0xfb53d14aa9c2fp-48) == Interval(-0x104ac2eb5563d1p-48, 0.0)
    @test Interval(0x123456789abcdfp-48, 0x123456789abcdfp-4) - Interval(-3.5, -3.5) == Interval(0x15b456789abcdfp-48, 0x123456789abd17p-4)
    @test Interval(0x123456789abcdfp-56, 0x123456789abcdfp-4) - Interval(-3.5, -3.5) == Interval(0x3923456789abcdp-52, 0x123456789abd17p-4)
    @test Interval(-0xffp0, 0x123456789abcdfp-52) - Interval(-256.5, -256.5) == Interval(0x18p-4, 0x101a3456789abdp-44)
    @test Interval(-0x1fffffffffffffp-52, -0x1p-550) - Interval(-4097.5, -4097.5) == Interval(0xfff8p-4, 0x10018p-4)
    @test Interval(0x123456789abcdfp-48, 0x123456789abcdfp-4) - Interval(3.5, 3.5) == Interval(0xeb456789abcdfp-48, 0x123456789abca7p-4)
    @test Interval(0x123456789abcdfp-56, 0x123456789abcdfp-4) - Interval(3.5, 3.5) == Interval(-0x36dcba98765434p-52, 0x123456789abca7p-4)
    @test Interval(-0xffp0, 0x123456789abcdfp-52) - Interval(256.5, 256.5) == Interval(-0x1ff8p-4, -0xff5cba9876543p-44)
    @test Interval(-0x1fffffffffffffp-52, -0x1p-550) - Interval(4097.5, 4097.5) == Interval(-0x10038p-4, -0x10018p-4)
end

@testset "mpfi_tan" begin
    # special values
    @test tan(Interval(-Inf, -7.0)) == entireinterval(Float64)
    @test tan(Interval(-Inf, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-Inf, +8.0)) == entireinterval(Float64)
    @test tan(entireinterval(Float64)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 0.0)) == Interval(-0x18eb245cbee3a6p-52, 0.0)
    @test tan(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test tan(Interval(0.0, +1.0)) == Interval(0.0, 0x18eb245cbee3a6p-52)
    @test tan(Interval(0.0, +8.0)) == entireinterval(Float64)
    @test tan(Interval(0.0, Inf)) == entireinterval(Float64)
    # regular values
    @test tan(Interval(0.125, 17.0)) == entireinterval(Float64)
    @test tan(Interval(0x1921fb54442d18p-52, 0x1921fb54442d19p-52)) == entireinterval(Float64)
    @test tan(Interval(-2.0, -0.5)) == entireinterval(Float64)
    @test tan(Interval(-4.5, 0.625)) == entireinterval(Float64)
    @test tan(Interval(-1.0, -0.25)) == Interval(-0x18eb245cbee3a6p-52, -0x105785a43c4c55p-54)
    @test tan(Interval(-0.5, 0.5)) == Interval(-0x117b4f5bf3474bp-53, 0x117b4f5bf3474bp-53)
    @test tan(Interval(0x71p+76, 0x71p+76)) == Interval(-0x1c8dc87ddcc134p-55, -0x1c8dc87ddcc133p-55)
    @test tan(Interval(-7.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 1.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, -1.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, -2.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, -3.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, -4.0)) == entireinterval(Float64)
    @test tan(Interval(-7.0, -5.0)) == Interval(-0x1be2e6e13eea79p-53, 0x1b0b4b739bbb07p-51)
    @test tan(Interval(-7.0, -6.0)) == Interval(-0x1be2e6e13eea79p-53, 0x129fd86ebb95bfp-54)
    @test tan(Interval(-7.0, -7.0)) == Interval(-0x1be2e6e13eea79p-53, -0x1be2e6e13eea78p-53)
    @test tan(Interval(-6.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 1.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, -1.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, -2.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, -3.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, -4.0)) == entireinterval(Float64)
    @test tan(Interval(-6.0, -5.0)) == Interval(0x129fd86ebb95bep-54, 0x1b0b4b739bbb07p-51)
    @test tan(Interval(-6.0, -6.0)) == Interval(0x129fd86ebb95bep-54, 0x129fd86ebb95bfp-54)
    @test tan(Interval(-5.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 1.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, -1.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, -2.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, -3.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, -4.0)) == entireinterval(Float64)
    @test tan(Interval(-5.0, -5.0)) == Interval(0x1b0b4b739bbb06p-51, 0x1b0b4b739bbb07p-51)
    @test tan(Interval(-4.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 1.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, -1.0)) == entireinterval(Float64)
    @test tan(Interval(-4.0, -2.0)) == Interval(-0x12866f9be4de14p-52, 0x117af62e0950f9p-51)
    @test tan(Interval(-4.0, -3.0)) == Interval(-0x12866f9be4de14p-52, 0x123ef71254b870p-55)
    @test tan(Interval(-4.0, -4.0)) == Interval(-0x12866f9be4de14p-52, -0x12866f9be4de13p-52)
    @test tan(Interval(-3.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 1.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, -1.0)) == entireinterval(Float64)
    @test tan(Interval(-3.0, -2.0)) == Interval(0x123ef71254b86fp-55, 0x117af62e0950f9p-51)
    @test tan(Interval(-3.0, -3.0)) == Interval(0x123ef71254b86fp-55, 0x123ef71254b870p-55)
    @test tan(Interval(-2.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 1.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, 0.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, -1.0)) == entireinterval(Float64)
    @test tan(Interval(-2.0, -2.0)) == Interval(0x117af62e0950f8p-51, 0x117af62e0950f9p-51)
    @test tan(Interval(-1.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(-1.0, 1.0)) == Interval(-0x18eb245cbee3a6p-52, 0x18eb245cbee3a6p-52)
    @test tan(Interval(-1.0, 0.0)) == Interval(-0x18eb245cbee3a6p-52, 0.0)
    @test tan(Interval(-1.0, -1.0)) == Interval(-0x18eb245cbee3a6p-52, -0x18eb245cbee3a5p-52)
    @test tan(Interval(1.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(1.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(1.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(1.0, 4.0)) == entireinterval(Float64)
    @test tan(Interval(1.0, 3.0)) == entireinterval(Float64)
    @test tan(Interval(1.0, 2.0)) == entireinterval(Float64)
    @test tan(Interval(1.0, 1.0)) == Interval(0x18eb245cbee3a5p-52, 0x18eb245cbee3a6p-52)
    @test tan(Interval(2.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(2.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(2.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(2.0, 4.0)) == Interval(-0x117af62e0950f9p-51, 0x12866f9be4de14p-52)
    @test tan(Interval(2.0, 3.0)) == Interval(-0x117af62e0950f9p-51, -0x123ef71254b86fp-55)
    @test tan(Interval(2.0, 2.0)) == Interval(-0x117af62e0950f9p-51, -0x117af62e0950f8p-51)
    @test tan(Interval(3.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(3.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(3.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(3.0, 4.0)) == Interval(-0x123ef71254b870p-55, 0x12866f9be4de14p-52)
    @test tan(Interval(3.0, 3.0)) == Interval(-0x123ef71254b870p-55, -0x123ef71254b86fp-55)
    @test tan(Interval(4.0, 7.0)) == entireinterval(Float64)
    @test tan(Interval(4.0, 6.0)) == entireinterval(Float64)
    @test tan(Interval(4.0, 5.0)) == entireinterval(Float64)
    @test tan(Interval(4.0, 4.0)) == Interval(0x12866f9be4de13p-52, 0x12866f9be4de14p-52)
    @test tan(Interval(5.0, 7.0)) == Interval(-0x1b0b4b739bbb07p-51, 0x1be2e6e13eea79p-53)
    @test tan(Interval(5.0, 6.0)) == Interval(-0x1b0b4b739bbb07p-51, -0x129fd86ebb95bep-54)
    @test tan(Interval(5.0, 5.0)) == Interval(-0x1b0b4b739bbb07p-51, -0x1b0b4b739bbb06p-51)
    @test tan(Interval(6.0, 7.0)) == Interval(-0x129fd86ebb95bfp-54, 0x1be2e6e13eea79p-53)
    @test tan(Interval(6.0, 6.0)) == Interval(-0x129fd86ebb95bfp-54, -0x129fd86ebb95bep-54)
    @test tan(Interval(7.0, 7.0)) == Interval(0x1be2e6e13eea78p-53, 0x1be2e6e13eea79p-53)
end

@testset "mpfi_tanh" begin
    # special values
    @test tanh(Interval(-Inf, -7.0)) == Interval(-1.0, -0x1ffffc832750f1p-53)
    @test tanh(Interval(-Inf, 0.0)) == Interval(-1.0, 0.0)
    @test tanh(Interval(-Inf, 8.0)) == Interval(-1.0, 0x1fffff872a91f9p-53)
    @test tanh(entireinterval(Float64)) == Interval(-1.0, +1.0)
    @test tanh(Interval(-1.0, 0.0)) == Interval(-0x185efab514f395p-53, 0.0)
    @test tanh(Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test tanh(Interval(0.0, 1.0)) == Interval(0.0, 0x185efab514f395p-53)
    @test tanh(Interval(0.0, 8.0)) == Interval(0.0, 0x1fffff872a91f9p-53)
    @test tanh(Interval(0.0, Inf)) == Interval(0.0, +1.0)
    # regular values
    @test tanh(Interval(-0.125, 0.0)) == Interval(-0x1fd5992bc4b835p-56, 0.0)
    @test tanh(Interval(0.0, 0x10000000000001p-53)) == Interval(0.0, 0x1d9353d7568af5p-54)
    @test tanh(Interval(-4.5, -0.625)) == Interval(-0x1ffdfa72153984p-53, -0x11bf47eabb8f95p-53)
    @test tanh(Interval(1.0, 3.0)) == Interval(0x185efab514f394p-53, 0x1fd77d111a0b00p-53)
    @test tanh(Interval(17.0, 18.0)) == Interval(0x1fffffffffffe1p-53, 0x1ffffffffffffcp-53)
end

@testset "mpfi_union" begin
    # special values
    @test hull(Interval(-Inf, -7.0), Interval(-1.0, +8.0)) == Interval(-Inf, +8.0)
    @test ∪(Interval(-Inf, -7.0), Interval(-1.0, +8.0)) == Interval(-Inf, +8.0)
    @test (Interval(-Inf, -7.0) ∪ Interval(-1.0, +8.0)) == Interval(-Inf, +8.0)
    @test hull(Interval(-Inf, 0.0), Interval(+8.0, Inf)) == entireinterval(Float64)
    @test ∪(Interval(-Inf, 0.0), Interval(+8.0, Inf)) == entireinterval(Float64)
    @test (Interval(-Inf, 0.0) ∪ Interval(+8.0, Inf)) == entireinterval(Float64)
    @test hull(Interval(-Inf, +8.0), Interval(0.0, +8.0)) == Interval(-Inf, +8.0)
    @test ∪(Interval(-Inf, +8.0), Interval(0.0, +8.0)) == Interval(-Inf, +8.0)
    @test (Interval(-Inf, +8.0) ∪ Interval(0.0, +8.0)) == Interval(-Inf, +8.0)
    @test hull(entireinterval(Float64), Interval(0.0, +8.0)) == entireinterval(Float64)
    @test ∪(entireinterval(Float64), Interval(0.0, +8.0)) == entireinterval(Float64)
    @test (entireinterval(Float64) ∪ Interval(0.0, +8.0)) == entireinterval(Float64)
    @test hull(Interval(0.0, 0.0), Interval(-Inf, -7.0)) == Interval(-Inf, 0.0)
    @test ∪(Interval(0.0, 0.0), Interval(-Inf, -7.0)) == Interval(-Inf, 0.0)
    @test (Interval(0.0, 0.0) ∪ Interval(-Inf, -7.0)) == Interval(-Inf, 0.0)
    @test hull(Interval(0.0, +8.0), Interval(-7.0, 0.0)) == Interval(-7.0, +8.0)
    @test ∪(Interval(0.0, +8.0), Interval(-7.0, 0.0)) == Interval(-7.0, +8.0)
    @test (Interval(0.0, +8.0) ∪ Interval(-7.0, 0.0)) == Interval(-7.0, +8.0)
    @test hull(Interval(0.0, 0.0), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test ∪(Interval(0.0, 0.0), Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test (Interval(0.0, 0.0) ∪ Interval(0.0, +8.0)) == Interval(0.0, +8.0)
    @test hull(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, Inf)
    @test ∪(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf) ∪ Interval(0.0, +8.0)) == Interval(0.0, Inf)
    @test hull(Interval(0.0, 0.0), Interval(+8.0, Inf)) == Interval(0.0, Inf)
    @test ∪(Interval(0.0, 0.0), Interval(+8.0, Inf)) == Interval(0.0, Inf)
    @test (Interval(0.0, 0.0) ∪ Interval(+8.0, Inf)) == Interval(0.0, Inf)
    @test hull(Interval(0.0, 0.0), entireinterval(Float64)) == entireinterval(Float64)
    @test ∪(Interval(0.0, 0.0), entireinterval(Float64)) == entireinterval(Float64)
    @test (Interval(0.0, 0.0) ∪ entireinterval(Float64)) == entireinterval(Float64)
    @test hull(Interval(0.0, +8.0), Interval(-7.0, +8.0)) == Interval(-7.0, +8.0)
    @test ∪(Interval(0.0, +8.0), Interval(-7.0, +8.0)) == Interval(-7.0, +8.0)
    @test (Interval(0.0, +8.0) ∪ Interval(-7.0, +8.0)) == Interval(-7.0, +8.0)
    @test hull(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test ∪(Interval(0.0, 0.0), Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test (Interval(0.0, 0.0) ∪ Interval(0.0, 0.0)) == Interval(0.0, 0.0)
    @test hull(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, Inf)
    @test ∪(Interval(0.0, Inf), Interval(0.0, +8.0)) == Interval(0.0, Inf)
    @test (Interval(0.0, Inf) ∪ Interval(0.0, +8.0)) == Interval(0.0, Inf)
    # regular values
    @test hull(Interval(0x12p0, 0x90p0), Interval(-0x0dp0, 0x34p0)) == Interval(-0x0dp0, 0x90p0)
    @test ∪(Interval(0x12p0, 0x90p0), Interval(-0x0dp0, 0x34p0)) == Interval(-0x0dp0, 0x90p0)
    @test (Interval(0x12p0, 0x90p0) ∪ Interval(-0x0dp0, 0x34p0)) == Interval(-0x0dp0, 0x90p0)
end
# FactCheck.exitstatus()
