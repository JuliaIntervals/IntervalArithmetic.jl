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
    using Base.Test
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

@testset "minimal_sqrRev_test" begin

end

@testset "minimal_sqrRevBin_test" begin

end

@testset "minimal_sqrRev_dec_test" begin

end

@testset "minimal_sqrRev_dec_bin_test" begin

end

@testset "minimal_absRev_test" begin

end

@testset "minimal_absRevBin_test" begin

end

@testset "minimal_absRev_dec_test" begin

end

@testset "minimal_absRev_dec_bin_test" begin

end

@testset "minimal_pownRev_test" begin

end

@testset "minimal_pownRevBin_test" begin

end

@testset "minimal_pownRev_dec_test" begin

end

@testset "minimal_pownRev_dec_bin_test" begin

end

@testset "minimal_sinRev_test" begin

end

@testset "minimal_sinRevBin_test" begin

end

@testset "minimal_sinRev_dec_test" begin

end

@testset "minimal_sinRev_dec_bin_test" begin

end

@testset "minimal_cosRev_test" begin

end

@testset "minimal_cosRevBin_test" begin

end

@testset "minimal_cosRev_dec_test" begin

end

@testset "minimal_cosRev_dec_bin_test" begin

end

@testset "minimal_tanRev_test" begin

end

@testset "minimal_tanRevBin_test" begin

end

@testset "minimal_tanRev_dec_test" begin

end

@testset "minimal_tanRev_dec_bin_test" begin

end

@testset "minimal_coshRev_test" begin

end

@testset "minimal_coshRevBin_test" begin

end

@testset "minimal_coshRev_dec_test" begin

end

@testset "minimal_coshRev_dec_bin_test" begin

end

@testset "minimal_mulRev_test" begin

end

@testset "minimal_mulRevTen_test" begin

end

@testset "minimal_mulRev_dec_test" begin

end

@testset "minimal_mulRev_dec_ten_test" begin

end
# FactCheck.exitstatus()
