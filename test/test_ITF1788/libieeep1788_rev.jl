@testset "minimal_sqr_rev_test" begin

    @test isequal_interval(sqr_rev(emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sqr_rev(bareinterval(-10.0,-1.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sqr_rev(bareinterval(0.0,Inf))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(sqr_rev(bareinterval(0.0,1.0))[2], bareinterval(-1.0,1.0))

    @test isequal_interval(sqr_rev(bareinterval(-0.5,1.0))[2], bareinterval(-1.0,1.0))

    @test isequal_interval(sqr_rev(bareinterval(-1000.0,1.0))[2], bareinterval(-1.0,1.0))

    @test isequal_interval(sqr_rev(bareinterval(0.0,25.0))[2], bareinterval(-5.0,5.0))

    @test isequal_interval(sqr_rev(bareinterval(-1.0,25.0))[2], bareinterval(-5.0,5.0))

    @test isequal_interval(sqr_rev(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7))[2], bareinterval(-0x1.999999999999BP-4,0x1.999999999999BP-4))

    @test isequal_interval(sqr_rev(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1))[2], bareinterval(-0x1.ffffffffffff1p+0,0x1.ffffffffffff1p+0))

end

@testset "minimal_sqr_rev_bin_test" begin

    @test isequal_interval(sqr_rev(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,1.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sqr_rev(bareinterval(-10.0,-1.0), bareinterval(-5.0,1.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sqr_rev(bareinterval(0.0,Inf), bareinterval(-5.0,1.0))[2], bareinterval(-5.0,1.0))

    @test isequal_interval(sqr_rev(bareinterval(0.0,1.0), bareinterval(-0.1,1.0))[2], bareinterval(-0.1,1.0))

    @test isequal_interval(sqr_rev(bareinterval(-0.5,1.0), bareinterval(-0.1,1.0))[2], bareinterval(-0.1,1.0))

    @test isequal_interval(sqr_rev(bareinterval(-1000.0,1.0), bareinterval(-0.1,1.0))[2], bareinterval(-0.1,1.0))

    @test isequal_interval(sqr_rev(bareinterval(0.0,25.0), bareinterval(-4.1,6.0))[2], bareinterval(-4.1,5.0))

    @test isequal_interval(sqr_rev(bareinterval(-1.0,25.0), bareinterval(-4.1,7.0))[2], bareinterval(-4.1,5.0))

    @test isequal_interval(sqr_rev(bareinterval(1.0,25.0), bareinterval(0.0,7.0))[2], bareinterval(1.0,5.0))

    @test isequal_interval(sqr_rev(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), bareinterval(-0.1,Inf))[2], bareinterval(-0.1,0x1.999999999999BP-4))

    @test isequal_interval(sqr_rev(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1), bareinterval(-0.1,Inf))[2], bareinterval(-0.1,0x1.ffffffffffff1p+0))

end

@testset "minimal_sqr_rev_dec_test" begin

    @test isequal_interval(sqr_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-10.0,-1.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,1.0), IntervalArithmetic.def))[2], Interval(bareinterval(-1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-0.5,1.0), IntervalArithmetic.dac))[2], Interval(bareinterval(-1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-1000.0,1.0), IntervalArithmetic.com))[2], Interval(bareinterval(-1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,25.0), IntervalArithmetic.def))[2], Interval(bareinterval(-5.0,5.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-1.0,25.0), IntervalArithmetic.dac))[2], Interval(bareinterval(-5.0,5.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), IntervalArithmetic.com))[2], Interval(bareinterval(-0x1.999999999999BP-4,0x1.999999999999BP-4), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1), IntervalArithmetic.def))[2], Interval(bareinterval(-0x1.ffffffffffff1p+0,0x1.ffffffffffff1p+0), IntervalArithmetic.trv))

end

@testset "minimal_sqr_rev_dec_bin_test" begin

    @test isequal_interval(sqr_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-5.0,1.0), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-10.0,-1.0), IntervalArithmetic.com), Interval(bareinterval(-5.0,1.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def), Interval(bareinterval(-5.0,1.0), IntervalArithmetic.dac))[2], Interval(bareinterval(-5.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,1.0), IntervalArithmetic.dac), Interval(bareinterval(-0.1,1.0), IntervalArithmetic.def))[2], Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-0.5,1.0), IntervalArithmetic.def), Interval(bareinterval(-0.1,1.0), IntervalArithmetic.dac))[2], Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-1000.0,1.0), IntervalArithmetic.com), Interval(bareinterval(-0.1,1.0), IntervalArithmetic.def))[2], Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,25.0), IntervalArithmetic.def), Interval(bareinterval(-4.1,6.0), IntervalArithmetic.com))[2], Interval(bareinterval(-4.1,5.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(-1.0,25.0), IntervalArithmetic.dac), Interval(bareinterval(-4.1,7.0), IntervalArithmetic.def))[2], Interval(bareinterval(-4.1,5.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(1.0,25.0), IntervalArithmetic.dac), Interval(bareinterval(0.0,7.0), IntervalArithmetic.def))[2], Interval(bareinterval(1.0,5.0), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), IntervalArithmetic.def), Interval(bareinterval(-0.1,Inf), IntervalArithmetic.dac))[2], Interval(bareinterval(-0.1,0x1.999999999999BP-4), IntervalArithmetic.trv))

    @test isequal_interval(sqr_rev(Interval(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1), IntervalArithmetic.dac), Interval(bareinterval(-0.1,Inf), IntervalArithmetic.dac))[2], Interval(bareinterval(-0.1,0x1.ffffffffffff1p+0), IntervalArithmetic.trv))

end

@testset "minimal_abs_rev_test" begin

    @test isequal_interval(abs_rev(emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-1.1,-0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(0.0,Inf))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(1.1,2.1))[2], bareinterval(-2.1,2.1))

    @test isequal_interval(abs_rev(bareinterval(-1.1,2.0))[2], bareinterval(-2.0,2.0))

    @test isequal_interval(abs_rev(bareinterval(-1.1,0.0))[2], bareinterval(0.0,0.0))

    @test isequal_interval(abs_rev(bareinterval(-1.9,0.2))[2], bareinterval(-0.2,0.2))

    @test isequal_interval(abs_rev(bareinterval(0.0,0.2))[2], bareinterval(-0.2,0.2))

    @test isequal_interval(abs_rev(bareinterval(-1.5,Inf))[2], entireinterval(BareInterval{Float64}))

end

@testset "minimal_abs_rev_bin_test" begin

    @test isequal_interval(abs_rev(emptyinterval(BareInterval{Float64}), bareinterval(-1.1,5.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-1.1,-0.4), bareinterval(-1.1,5.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(0.0,Inf), bareinterval(-1.1,5.0))[2], bareinterval(-1.1,5.0))

    @test isequal_interval(abs_rev(bareinterval(1.1,2.1), bareinterval(-1.0,5.0))[2], bareinterval(1.1,2.1))

    @test isequal_interval(abs_rev(bareinterval(-1.1,2.0), bareinterval(-1.1,5.0))[2], bareinterval(-1.1,2.0))

    @test isequal_interval(abs_rev(bareinterval(-1.1,0.0), bareinterval(-1.1,5.0))[2], bareinterval(0.0,0.0))

    @test isequal_interval(abs_rev(bareinterval(-1.9,0.2), bareinterval(-1.1,5.0))[2], bareinterval(-0.2,0.2))

end

@testset "minimal_abs_rev_dec_test" begin

    @test isequal_interval(abs_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.1,-0.4), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(1.1,2.1), IntervalArithmetic.com))[2], Interval(bareinterval(-2.1,2.1), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.def))[2], Interval(bareinterval(-2.0,2.0), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.1,0.0), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.9,0.2), IntervalArithmetic.com))[2], Interval(bareinterval(-0.2,0.2), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(0.0,0.2), IntervalArithmetic.def))[2], Interval(bareinterval(-0.2,0.2), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.def))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_abs_rev_dec_bin_test" begin

    @test isequal_interval(abs_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-1.1,5.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.1,-0.4), IntervalArithmetic.dac), Interval(bareinterval(-1.1,5.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def), Interval(bareinterval(-1.1,5.0), IntervalArithmetic.def))[2], Interval(bareinterval(-1.1,5.0), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(1.1,2.1), IntervalArithmetic.dac), Interval(bareinterval(-1.0,5.0), IntervalArithmetic.def))[2], Interval(bareinterval(1.1,2.1), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.com), Interval(bareinterval(-1.1,5.0), IntervalArithmetic.def))[2], Interval(bareinterval(-1.1,2.0), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.1,0.0), IntervalArithmetic.def), Interval(bareinterval(-1.1,5.0), IntervalArithmetic.def))[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(abs_rev(Interval(bareinterval(-1.9,0.2), IntervalArithmetic.dac), Interval(bareinterval(-1.1,5.0), IntervalArithmetic.def))[2], Interval(bareinterval(-0.2,0.2), IntervalArithmetic.trv))

end

@testset "minimal_pown_rev_test" begin

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(1.0,1.0), 0)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-1.0,5.0), 0)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-1.0,0.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-1.0,-0.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(1.1,10.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), 1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), 1)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), 1)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), 1)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(13.1,13.1), 1)[2], bareinterval(13.1,13.1))

    @test isequal_interval(power_rev(bareinterval(-7451.145,-7451.145), 1)[2], bareinterval(-7451.145,-7451.145))

    @test isequal_interval(power_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1)[2], bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(power_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1)[2], bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), 1)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), 1)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), 1)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), 1)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-324.3,2.5), 1)[2], bareinterval(-324.3,2.5))

    @test isequal_interval(power_rev(bareinterval(0.01,2.33), 1)[2], bareinterval(0.01,2.33))

    @test isequal_interval(power_rev(bareinterval(-1.9,-0.33), 1)[2], bareinterval(-1.9,-0.33))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), 2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-5.0,-1.0), 2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), 2)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), 2)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), 2)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), 2)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7), 2)[2], bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3))

    @test isequal_interval(power_rev(bareinterval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25), 2)[2], bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12))

    @test isequal_interval(power_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2)[2], bareinterval(-0x1p+512,0x1p+512))

    @test isequal_interval(power_rev(bareinterval(0.0,0x1.9AD27D70A3D72P+16), 2)[2], bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8))

    @test isequal_interval(power_rev(bareinterval(-0.0,0x1.9AD27D70A3D72P+16), 2)[2], bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8))

    @test isequal_interval(power_rev(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), 2)[2], bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), 2)[2], bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), 8)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), 8)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), 8)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), 8)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), 8)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), 8)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29), 8)[2], bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3))

    @test isequal_interval(power_rev(bareinterval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102), 8)[2], bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12))

    @test isequal_interval(power_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8)[2], bareinterval(-0x1p+128,0x1p+128))

    @test isequal_interval(power_rev(bareinterval(0.0,0x1.A87587109655P+66), 8)[2], bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8))

    @test isequal_interval(power_rev(bareinterval(-0.0,0x1.A87587109655P+66), 8)[2], bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8))

    @test isequal_interval(power_rev(bareinterval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9), 8)[2], bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7), 8)[2], bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), 3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), 3)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), 3)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), 3)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11), 3)[2], bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3))

    @test isequal_interval(power_rev(bareinterval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38), 3)[2], bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12))

    @test isequal_interval(power_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3)[2], bareinterval(0x1.428a2f98d728ap+341,0x1.428a2f98d728bp+341))

    @test isequal_interval(power_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3)[2], bareinterval(-0x1.428a2f98d728bp+341, -0x1.428a2f98d728ap+341))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), 3)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), 3)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), 3)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), 3)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-0x1.0436D2F418938P+25,0x1.F4P+3), 3)[2], bareinterval(-0x1.444cccccccccep+8,0x1.4p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), 3)[2], bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), 3)[2], bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), 7)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), 7)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), 7)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), 7)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25), 7)[2], bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3))

    @test isequal_interval(power_rev(bareinterval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90), 7)[2], bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12))

    @test isequal_interval(power_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7)[2], bareinterval(0x1.381147622f886p+146,0x1.381147622f887p+146))

    @test isequal_interval(power_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7)[2], bareinterval(-0x1.381147622f887p+146,-0x1.381147622f886p+146))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), 7)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), 7)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), 7)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), 7)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-0x1.4F109959E6D7FP+58,0x1.312DP+9), 7)[2], bareinterval(-0x1.444cccccccccep+8,0x1.4p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8), 7)[2], bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12), 7)[2], bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), -2)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), -2)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-10.0,0.0), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-10.0,-0.0), -2)[2], emptyinterval(BareInterval{Float64}))

    @test_broken isequal_interval(power_rev(bareinterval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8), -2)[2], bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3))

    @test_broken isequal_interval(power_rev(bareinterval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26), -2)[2], bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12))

    @test isequal_interval(power_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -2)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.3F0C482C977C9P-17,Inf), -2)[2], bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8))

    @test isequal_interval(power_rev(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), -2)[2], bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), -2)[2], bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), -8)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), -8)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), -8)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), -8)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), -8)[2], emptyinterval(BareInterval{Float64}))

    @test_broken isequal_interval(power_rev(bareinterval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30), -8)[2], bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3))

    @test_broken isequal_interval(power_rev(bareinterval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103), -8)[2], bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12))

    @test isequal_interval(power_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -8)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.34CC3764D1E0CP-67,Inf), -8)[2], bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8))

    @test isequal_interval(power_rev(bareinterval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53), -8)[2], bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12), -8)[2], bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), -1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), -1)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), -1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), -1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4), -1)[2], bareinterval(0x1.a333333333332p+3,0x1.a333333333335p+3))

    @test isequal_interval(power_rev(bareinterval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13), -1)[2], bareinterval(-0x1.d1b251eb851eep+12,-0x1.d1b251eb851ebp+12))

    @test isequal_interval(power_rev(bareinterval(0x0.4P-1022,0x0.4000000000001P-1022), -1)[2], bareinterval(0x1.ffffffffffff8p+1023,Inf))

    @test isequal_interval(power_rev(bareinterval(-0x0.4000000000001P-1022,-0x0.4P-1022), -1)[2], bareinterval(-Inf,-0x1.ffffffffffff8p+1023))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), -1)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), -1)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), -1)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), -1)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), -1)[2], bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1), -1)[2], bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), -3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), -3)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), -3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), -3)[2], emptyinterval(BareInterval{Float64}))

    @test_broken isequal_interval(power_rev(bareinterval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12), -3)[2], bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3))

    @test_broken isequal_interval(power_rev(bareinterval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39), -3)[2], bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12))

    @test isequal_interval(power_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -3)[2], bareinterval(0x1p+358,Inf))

    @test isequal_interval(power_rev(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), -3)[2], bareinterval(-Inf,-0x1p+358))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), -3)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), -3)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), -3)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), -3)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.43CFBA61AACABP-4,0x1.E848P+19), -3)[2], bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3), -3)[2], bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), -7)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), -7)[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), -7)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), -7)[2], emptyinterval(BareInterval{Float64}))

    @test_broken isequal_interval(power_rev(bareinterval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26), -7)[2], bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3))

    @test_broken isequal_interval(power_rev(bareinterval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91), -7)[2], bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12))

    @test isequal_interval(power_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -7)[2], bareinterval(0x1.588cea3f093bcp+153,Inf))

    @test isequal_interval(power_rev(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), -7)[2], bareinterval(-Inf,-0x1.588cea3f093bcp+153))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), -7)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-0.0,Inf), -7)[2], bareinterval(0.0,Inf))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), -7)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), -7)[2], bareinterval(-Inf,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46), -7)[2], bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7), -7)[2], bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2))

end

@testset "minimal_pown_rev_bin_test" begin

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(1.0,1.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(1.0,1.0), bareinterval(1.0,1.0), 0)[2], bareinterval(1.0,1.0))

    @test isequal_interval(power_rev(bareinterval(-1.0,5.0), bareinterval(-51.0,12.0), 0)[2], bareinterval(-51.0,12.0))

    @test isequal_interval(power_rev(bareinterval(-1.0,0.0), bareinterval(5.0,10.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-1.0,-0.0), bareinterval(-1.0,1.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(1.1,10.0), bareinterval(1.0,41.0), 0)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(0.0,100.1), 1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), bareinterval(-5.1,10.0), 1)[2], bareinterval(-5.1,10.0))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), bareinterval(-10.0,5.1), 1)[2], bareinterval(0.0,0.0))

    @test isequal_interval(power_rev(bareinterval(-0.0,-0.0), bareinterval(1.0,5.0), 1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(5.0,17.1), 2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-5.0,-1.0), bareinterval(5.0,17.1), 2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), bareinterval(5.6,27.544), 2)[2], bareinterval(5.6,27.544))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), bareinterval(1.0,2.0), 2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), bareinterval(1.0,Inf), 2)[2], bareinterval(1.0,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), bareinterval(-Inf,-1.0), 2)[2], bareinterval(-0x1.e666666666667p+0,-1.0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(-23.0,-1.0), 3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), bareinterval(-23.0,-1.0), 3)[2], bareinterval(-23.0,-1.0))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), bareinterval(1.0,2.0), 3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), bareinterval(1.0,Inf), 3)[2], bareinterval(1.0,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), bareinterval(-Inf,-1.0), 3)[2], bareinterval(-0x1.e666666666667p+0,-1.0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(-3.0,17.3), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0.0,Inf), bareinterval(-5.1,-0.1), -2)[2], bareinterval(-5.1,-0.1))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), bareinterval(27.2,55.1), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.3F0C482C977C9P-17,Inf), bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), -2)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), bareinterval(1.0,Inf), -2)[2], bareinterval(1.0,0x1.2a3d70a3d70a5p+1))

    @test isequal_interval(power_rev(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), bareinterval(-Inf,-1.0), -2)[2], bareinterval(-0x1.e666666666667p+0,-1.0))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -1)[2], bareinterval(-5.1,55.5))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), bareinterval(-5.1,55.5), -1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), bareinterval(-1.0,1.0), -1)[2], bareinterval(-1.0,0.0))

    @test isequal_interval(power_rev(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), bareinterval(-1.0,0.0), -1)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(emptyinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(entireinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -3)[2], bareinterval(-5.1,55.5))

    @test isequal_interval(power_rev(bareinterval(0.0,0.0), bareinterval(-5.1,55.5), -3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-Inf,0.0), bareinterval(5.1,55.5), -3)[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(power_rev(bareinterval(-Inf,-0.0), bareinterval(-32.0,1.1), -3)[2], bareinterval(-32.0,0.0))

end

@testset "minimal_pown_rev_dec_test" begin

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(1.0,1.0), IntervalArithmetic.com), 0)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.dac), 0)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-1.0,-0.0), IntervalArithmetic.dac), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(1.1,10.0), IntervalArithmetic.com), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), 1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), 1)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com), 1)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), 1)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(13.1,13.1), IntervalArithmetic.def), 1)[2], Interval(bareinterval(13.1,13.1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-7451.145,-7451.145), IntervalArithmetic.dac), 1)[2], Interval(bareinterval(-7451.145,-7451.145), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), 1)[2], Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), 1)[2], Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), 1)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), 1)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def), 1)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def), 1)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-324.3,2.5), IntervalArithmetic.dac), 1)[2], Interval(bareinterval(-324.3,2.5), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.01,2.33), IntervalArithmetic.com), 1)[2], Interval(bareinterval(0.01,2.33), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-1.9,-0.33), IntervalArithmetic.def), 1)[2], Interval(bareinterval(-1.9,-0.33), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), 2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), 2)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.def), 2)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com), 2)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), 2)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7), IntervalArithmetic.def), 2)[2], Interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25), IntervalArithmetic.def), 2)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac), 2)[2], Interval(bareinterval(-0x1p+512,0x1p+512), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0x1.9AD27D70A3D72P+16), IntervalArithmetic.dac), 2)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,0x1.9AD27D70A3D72P+16), IntervalArithmetic.def), 2)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), IntervalArithmetic.com), 2)[2], Interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), IntervalArithmetic.def), 2)[2], Interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), 8)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), 8)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), 8)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), 8)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.def), 8)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), 8)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29), IntervalArithmetic.com), 8)[2], Interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102), IntervalArithmetic.dac), 8)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.def), 8)[2], Interval(bareinterval(-0x1p+128,0x1p+128), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0x1.A87587109655P+66), IntervalArithmetic.dac), 8)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,0x1.A87587109655P+66), IntervalArithmetic.def), 8)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9), IntervalArithmetic.com), 8)[2], Interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7), IntervalArithmetic.dac), 8)[2], Interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), 3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), 3)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.dac), 3)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.def), 3)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11), IntervalArithmetic.com), 3)[2], Interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38), IntervalArithmetic.def), 3)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac), 3)[2], Interval(bareinterval(0x1.428a2f98d728ap+341,0x1.428a2f98d728bp+341), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), 3)[2], Interval(bareinterval(-0x1.428a2f98d728bp+341, -0x1.428a2f98d728ap+341), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def), 3)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.def), 3)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.dac), 3)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def), 3)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.0436D2F418938P+25,0x1.F4P+3), IntervalArithmetic.com), 3)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.4p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), IntervalArithmetic.dac), 3)[2], Interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), IntervalArithmetic.def), 3)[2], Interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), 7)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), 7)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com), 7)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), 7)[2], Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25), IntervalArithmetic.def), 7)[2], Interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90), IntervalArithmetic.dac), 7)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), 7)[2], Interval(bareinterval(0x1.381147622f886p+146,0x1.381147622f887p+146), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.def), 7)[2], Interval(bareinterval(-0x1.381147622f887p+146,-0x1.381147622f886p+146), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), 7)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), 7)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def), 7)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def), 7)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.4F109959E6D7FP+58,0x1.312DP+9), IntervalArithmetic.dac), 7)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.4p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8), IntervalArithmetic.com), 7)[2], Interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12), IntervalArithmetic.def), 7)[2], Interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), -2)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), -2)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.def), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.com), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-10.0,0.0), IntervalArithmetic.dac), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-10.0,-0.0), IntervalArithmetic.def), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8), IntervalArithmetic.dac), -2)[2], Interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26), IntervalArithmetic.def), -2)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), IntervalArithmetic.com), -2)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.3F0C482C977C9P-17,Inf), IntervalArithmetic.dac), -2)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), IntervalArithmetic.def), -2)[2], Interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), IntervalArithmetic.com), -2)[2], Interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), -8)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def), -8)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), -8)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.def), -8)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), -8)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30), IntervalArithmetic.com), -8)[2], Interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103), IntervalArithmetic.def), -8)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), IntervalArithmetic.dac), -8)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.34CC3764D1E0CP-67,Inf), IntervalArithmetic.def), -8)[2], Interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53), IntervalArithmetic.com), -8)[2], Interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12), IntervalArithmetic.def), -8)[2], Interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), -1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), -1)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.dac), -1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), -1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4), IntervalArithmetic.def), -1)[2], Interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333335p+3), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13), IntervalArithmetic.dac), -1)[2], Interval(bareinterval(-0x1.d1b251eb851eep+12,-0x1.d1b251eb851ebp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x0.4P-1022,0x0.4000000000001P-1022), IntervalArithmetic.dac), -1)[2], Interval(bareinterval(0x1.ffffffffffff8p+1023,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x0.4000000000001P-1022,-0x0.4P-1022), IntervalArithmetic.def), -1)[2], Interval(bareinterval(-Inf,-0x1.ffffffffffff8p+1023), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), -1)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), -1)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.dac), -1)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def), -1)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), IntervalArithmetic.com), -1)[2], Interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1), IntervalArithmetic.com), -1)[2], Interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), -3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), -3)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.def), -3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.dac), -3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12), IntervalArithmetic.com), -3)[2], Interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39), IntervalArithmetic.def), -3)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), IntervalArithmetic.dac), -3)[2], Interval(bareinterval(0x1p+358,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), IntervalArithmetic.def), -3)[2], Interval(bareinterval(-Inf,-0x1p+358), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), -3)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), -3)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def), -3)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def), -3)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x1.43CFBA61AACABP-4,0x1.E848P+19), IntervalArithmetic.com), -3)[2], Interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3), IntervalArithmetic.def), -3)[2], Interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), -7)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), -7)[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com), -7)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.def), -7)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26), IntervalArithmetic.dac), -7)[2], Interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), IntervalArithmetic.trv))

    @test_broken isequal_interval(power_rev(Interval(bareinterval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91), IntervalArithmetic.dac), -7)[2], Interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), IntervalArithmetic.def), -7)[2], Interval(bareinterval(0x1.588cea3f093bcp+153,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), IntervalArithmetic.def), -7)[2], Interval(bareinterval(-Inf,-0x1.588cea3f093bcp+153), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), -7)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.def), -7)[2], Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.dac), -7)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def), -7)[2], Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46), IntervalArithmetic.com), -7)[2], Interval(interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7), IntervalArithmetic.com), -7)[2], Interval(interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), IntervalArithmetic.trv))

end

@testset "minimal_pown_rev_dec_bin_test" begin

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(1.0,1.0), IntervalArithmetic.def), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(1.0,1.0), IntervalArithmetic.dac), Interval(interval(1.0,1.0), IntervalArithmetic.dac), 0)[2], Interval(interval(1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-1.0,5.0), IntervalArithmetic.def), Interval(interval(-51.0,12.0), IntervalArithmetic.dac), 0)[2], Interval(interval(-51.0,12.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-1.0,0.0), IntervalArithmetic.com), Interval(interval(5.0,10.0), IntervalArithmetic.dac), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-1.0,-0.0), IntervalArithmetic.dac), Interval(interval(-1.0,1.0), IntervalArithmetic.def), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(1.1,10.0), IntervalArithmetic.def), Interval(interval(1.0,41.0), IntervalArithmetic.dac), 0)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(0.0,100.1), IntervalArithmetic.dac), 1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(interval(-5.1,10.0), IntervalArithmetic.def), 1)[2], Interval(interval(-5.1,10.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,0.0), IntervalArithmetic.com), Interval(interval(-10.0,5.1), IntervalArithmetic.dac), 1)[2], Interval(interval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-0.0,-0.0), IntervalArithmetic.def), Interval(interval(1.0,5.0), IntervalArithmetic.dac), 1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(5.0,17.1), IntervalArithmetic.def), 2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,Inf), IntervalArithmetic.dac), Interval(interval(5.6,27.544), IntervalArithmetic.dac), 2)[2], Interval(interval(5.6,27.544), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,0.0), IntervalArithmetic.def), Interval(interval(1.0,2.0), IntervalArithmetic.def), 2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), IntervalArithmetic.com), Interval(interval(1.0,Inf), IntervalArithmetic.def), 2)[2], Interval(interval(1.0,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), IntervalArithmetic.dac), Interval(interval(-Inf,-1.0), IntervalArithmetic.def), 2)[2], Interval(interval(-0x1.e666666666667p+0,-1.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-23.0,-1.0), IntervalArithmetic.dac), 3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(interval(-23.0,-1.0), IntervalArithmetic.com), 3)[2], Interval(interval(-23.0,-1.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,0.0), IntervalArithmetic.def), Interval(interval(1.0,2.0), IntervalArithmetic.dac), 3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), IntervalArithmetic.com), Interval(interval(1.0,Inf), IntervalArithmetic.dac), 3)[2], Interval(interval(1.0,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), IntervalArithmetic.com), Interval(interval(-Inf,-1.0), IntervalArithmetic.dac), 3)[2], Interval(interval(-0x1.e666666666667p+0,-1.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-3.0,17.3), IntervalArithmetic.def), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,Inf), IntervalArithmetic.dac), Interval(interval(-5.1,-0.1), IntervalArithmetic.dac), -2)[2], Interval(interval(-5.1,-0.1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,0.0), IntervalArithmetic.def), Interval(interval(27.2,55.1), IntervalArithmetic.dac), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.3F0C482C977C9P-17,Inf), IntervalArithmetic.def), Interval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac), -2)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.793D85EF38E47P-3,0x1.388P+13), IntervalArithmetic.com), Interval(interval(1.0,Inf), IntervalArithmetic.dac), -2)[2], Interval(interval(1.0,0x1.2a3d70a3d70a5p+1), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), IntervalArithmetic.com), Interval(interval(-Inf,-1.0), IntervalArithmetic.dac), -2)[2], Interval(interval(-0x1.e666666666667p+0,-1.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-5.1,55.5), IntervalArithmetic.def), -1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(interval(-5.1,55.5), IntervalArithmetic.dac), -1)[2], Interval(interval(-5.1,55.5), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,0.0), IntervalArithmetic.dac), Interval(interval(-5.1,55.5), IntervalArithmetic.def), -1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-Inf,-0.0), IntervalArithmetic.dac), Interval(interval(-1.0,1.0), IntervalArithmetic.com), -1)[2], Interval(interval(-1.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0x1.B77C278DBBE13P-2,0x1.9P+6), IntervalArithmetic.def), Interval(interval(-1.0,0.0), IntervalArithmetic.dac), -1)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-5.1,55.5), IntervalArithmetic.dac), -3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(interval(-5.1,55.5), IntervalArithmetic.def), -3)[2], Interval(interval(-5.1,55.5), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(0.0,0.0), IntervalArithmetic.def), Interval(interval(-5.1,55.5), IntervalArithmetic.def), -3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-Inf,0.0), IntervalArithmetic.dac), Interval(interval(5.1,55.5), IntervalArithmetic.com), -3)[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(power_rev(Interval(interval(-Inf,-0.0), IntervalArithmetic.dac), Interval(interval(-32.0,1.1), IntervalArithmetic.def), -3)[2], Interval(interval(-32.0,0.0), IntervalArithmetic.trv))

end

@testset "minimal_sin_rev_test" begin

    @test isequal_interval(sin_rev(emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(-2.0,-1.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(1.1, 2.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(-1.0,1.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(0.0,0.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))[2], entireinterval(BareInterval{Float64}))

end

@testset "minimal_sin_rev_bin_test" begin

    @test isequal_interval(sin_rev(emptyinterval(BareInterval{Float64}), interval(-1.2,12.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(-2.0,-1.1), interval(-5.0, 5.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(1.1, 2.0), interval(-5.0, 5.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(-1.0,1.0), interval(-1.2,12.1))[2], interval(-1.2,12.1))

    @test isequal_interval(sin_rev(interval(0.0,0.0), interval(-1.0,1.0))[2], interval(0.0,0.0))

    @test isequal_interval(sin_rev(interval(-0.0,-0.0), interval(2.0,2.5))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin_rev(interval(-0.0,-0.0), interval(3.0,3.5))[2], interval(0x1.921fb54442d18p+1,0x1.921fb54442d19p+1))

    @test isequal_interval(sin_rev(interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0), interval(1.57,1.58))[2], interval(0x1.921fb50442d18p+0,0x1.921fb58442d1ap+0))

    @test isequal_interval(sin_rev(interval(0.0,0x1P+0), interval(-0.1,1.58))[2], interval(0.0,1.58))

    @test isequal_interval(sin_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(3.14,3.15))[2], interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1))

    @test isequal_interval(sin_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(3.14,3.15))[2], interval(0x1.921FB54442D18P+1,0x1.921FB54442D1aP+1))

    @test isequal_interval(sin_rev(interval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53), interval(3.14,3.15))[2], interval(0x1.921FB54442D17P+1,0x1.921FB54442D1aP+1))

    @test isequal_interval(sin_rev(interval(0.0,1.0), interval(-0.1,3.15))[2], interval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(sin_rev(interval(0.0,1.0), interval(-0.1,3.15))[2], interval(-0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(sin_rev(interval(-0x1.72CECE675D1FDP-52,1.0), interval(-0.1,3.15))[2], interval(-0x1.72cece675d1fep-52,0x1.921FB54442D1aP+1))

    @test isequal_interval(sin_rev(interval(-0x1.72CECE675D1FDP-52,1.0), interval(0.0,3.15))[2], interval(0.0,0x1.921FB54442D1aP+1))

    @test isequal_interval(sin_rev(interval(0x1.1A62633145C06P-53,0x1P+0), interval(3.14,3.15))[2], interval(3.14,0x1.921FB54442D19P+1))

    @test isequal_interval(sin_rev(interval(-0x1.72CECE675D1FDP-52,0x1P+0), interval(1.57,3.15))[2], interval(1.57,0x1.921FB54442D1AP+1))

    @test isequal_interval(sin_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(-Inf,3.15))[2], interval(-Inf,0x1.921FB54442D19P+1))

    @test isequal_interval(sin_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(3.14,Inf))[2], interval(0x1.921FB54442D18P+1,Inf))

end

@testset "minimal_sin_rev_dec_test" begin

    @test isequal_interval(sin_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-2.0,-1.1), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(1.1, 2.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-1.0,1.0), IntervalArithmetic.com))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0.0,0.0), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.def))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_sin_rev_dec_bin_test" begin

    @test isequal_interval(sin_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-1.2,12.1), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-2.0,-1.1), IntervalArithmetic.def), Interval(interval(-5.0, 5.0), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(1.1, 2.0), IntervalArithmetic.dac), Interval(interval(-5.0, 5.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-1.0,1.0), IntervalArithmetic.com), Interval(interval(-1.2,12.1), IntervalArithmetic.def))[2], Interval(interval(-1.2,12.1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0.0,0.0), IntervalArithmetic.dac), Interval(interval(-1.0,1.0), IntervalArithmetic.def))[2], Interval(interval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0.0,-0.0), IntervalArithmetic.def), Interval(interval(2.0,2.5), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0.0,-0.0), IntervalArithmetic.def), Interval(interval(3.0,3.5), IntervalArithmetic.dac))[2], Interval(interval(0x1.921fb54442d18p+1,0x1.921fb54442d19p+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0), IntervalArithmetic.dac), Interval(interval(1.57,1.58), IntervalArithmetic.dac))[2], Interval(interval(0x1.921fb50442d18p+0,0x1.921fb58442d1ap+0), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0.0,0x1P+0), IntervalArithmetic.com), Interval(interval(-0.1,1.58), IntervalArithmetic.dac))[2], Interval(interval(0.0,1.58), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.com), Interval(interval(3.14,3.15), IntervalArithmetic.def))[2], Interval(interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), IntervalArithmetic.com), Interval(interval(3.14,3.15), IntervalArithmetic.dac))[2], Interval(interval(0x1.921FB54442D18P+1,0x1.921FB54442D1aP+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53), IntervalArithmetic.dac), Interval(interval(3.14,3.15), IntervalArithmetic.com))[2], Interval(interval(0x1.921FB54442D17P+1,0x1.921FB54442D1aP+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0.0,1.0), IntervalArithmetic.def), Interval(interval(-0.1,3.15), IntervalArithmetic.def))[2], Interval(interval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0.0,1.0), IntervalArithmetic.dac), Interval(interval(-0.1,3.15), IntervalArithmetic.com))[2], Interval(interval(-0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0x1.72CECE675D1FDP-52,1.0), IntervalArithmetic.def), Interval(interval(-0.1,3.15), IntervalArithmetic.def))[2], Interval(interval(-0x1.72cece675d1fep-52,0x1.921FB54442D1aP+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0x1.72CECE675D1FDP-52,1.0), IntervalArithmetic.com), Interval(interval(0.0,3.15), IntervalArithmetic.dac))[2], Interval(interval(0.0,0x1.921FB54442D1aP+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0x1.1A62633145C06P-53,0x1P+0), IntervalArithmetic.def), Interval(interval(3.14,3.15), IntervalArithmetic.com))[2], Interval(interval(3.14,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0x1.72CECE675D1FDP-52,0x1P+0), IntervalArithmetic.dac), Interval(interval(1.57,3.15), IntervalArithmetic.com))[2], Interval(interval(1.57,0x1.921FB54442D1AP+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.com), Interval(interval(-Inf,3.15), IntervalArithmetic.dac))[2], Interval(interval(-Inf,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(sin_rev(Interval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), IntervalArithmetic.com), Interval(interval(3.14,Inf), IntervalArithmetic.dac))[2], Interval(interval(0x1.921FB54442D18P+1,Inf), IntervalArithmetic.trv))

end

@testset "minimal_cos_rev_test" begin

    @test isequal_interval(cos_rev(emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(-2.0,-1.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(1.1, 2.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(-1.0,1.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(0.0,0.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))[2], entireinterval(BareInterval{Float64}))

end

@testset "minimal_cos_rev_bin_test" begin

    @test isequal_interval(cos_rev(emptyinterval(BareInterval{Float64}), interval(-1.2,12.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(-2.0,-1.1), interval(-5.0, 5.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(1.1, 2.0), interval(-5.0, 5.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos_rev(interval(-1.0,1.0), interval(-1.2,12.1))[2], interval(-1.2,12.1))

    @test isequal_interval(cos_rev(interval(1.0,1.0), interval(-0.1,0.1))[2], interval(0.0,0.0))

    @test isequal_interval(cos_rev(interval(-1.0,-1.0), interval(3.14,3.15))[2], interval(0x1.921fb54442d18p+1,0x1.921fb54442d1ap+1))

    @test isequal_interval(cos_rev(interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), interval(1.57,1.58))[2], interval(0x1.921FB54442D17P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(cos_rev(interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53), interval(1.57,1.58))[2], interval(0x1.921FB54442D18P+0,0x1.921FB54442D1AP+0))

    @test isequal_interval(cos_rev(interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54), interval(1.57,1.58))[2], interval(0x1.921FB54442D17P+0,0x1.921FB54442D1aP+0))

    @test isequal_interval(cos_rev(interval(0x1.1A62633145C06P-54,1.0), interval(-2.0,2.0))[2], interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(cos_rev(interval(0x1.1A62633145C06P-54,1.0), interval(0.0,2.0))[2], interval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(cos_rev(interval(-0x1.72CECE675D1FDP-53,1.0), interval(-0.1,1.5708))[2], interval(-0.1,0x1.921FB54442D1aP+0))

    @test isequal_interval(cos_rev(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), interval(3.14,3.15))[2], interval(0x1.921fb52442d18p+1,0x1.921fb56442d1ap+1))

    @test isequal_interval(cos_rev(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), interval(-3.15,-3.14))[2], interval(-0x1.921fb56442d1ap+1,-0x1.921fb52442d18p+1))

    @test isequal_interval(cos_rev(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), interval(9.42,9.45))[2], interval(0x1.2d97c7eb321d2p+3,0x1.2d97c7fb321d3p+3))

    @test isequal_interval(cos_rev(interval(0x1.87996529F9D92P-1,1.0), interval(-1.0,0.1))[2], interval(-0x1.6666666666667p-1,0.1))

    @test isequal_interval(cos_rev(interval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1), interval(0.0,2.1))[2], interval(0x1.fffffffffffffp-1,0x1.0000000000001p+1))

    @test isequal_interval(cos_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(-Inf,1.58))[2], interval(-Inf,0x1.921FB54442D18P+0))

    @test isequal_interval(cos_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(-Inf,1.5))[2], interval(-Inf,-0x1.921FB54442D17P+0))

    @test isequal_interval(cos_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(-1.58,Inf))[2], interval(-0x1.921fb54442d1ap+0,Inf))

    @test isequal_interval(cos_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(-1.5,Inf))[2], interval(0x1.921fb54442d19p+0,Inf))

end

@testset "minimal_cos_rev_dec_test" begin

    @test isequal_interval(cos_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-2.0,-1.1), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(1.1, 2.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-1.0,1.0), IntervalArithmetic.com))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0.0,0.0), IntervalArithmetic.def))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_cos_rev_dec_bin_test" begin

    @test isequal_interval(cos_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-1.2,12.1), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-2.0,-1.1), IntervalArithmetic.dac), Interval(interval(-5.0, 5.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(1.1, 2.0), IntervalArithmetic.dac), Interval(interval(-5.0, 5.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-1.0,1.0), IntervalArithmetic.dac), Interval(interval(-1.2,12.1), IntervalArithmetic.def))[2], Interval(interval(-1.2,12.1), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(1.0,1.0), IntervalArithmetic.def), Interval(interval(-0.1,0.1), IntervalArithmetic.dac))[2], Interval(interval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-1.0,-1.0), IntervalArithmetic.com), Interval(interval(3.14,3.15), IntervalArithmetic.dac))[2], Interval(interval(0x1.921fb54442d18p+1,0x1.921fb54442d1ap+1), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), IntervalArithmetic.def), Interval(interval(1.57,1.58), IntervalArithmetic.def))[2], Interval(interval(0x1.921FB54442D17P+0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53), IntervalArithmetic.dac), Interval(interval(1.57,1.58), IntervalArithmetic.dac))[2], Interval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D1AP+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54), IntervalArithmetic.com), Interval(interval(1.57,1.58), IntervalArithmetic.dac))[2], Interval(interval(0x1.921FB54442D17P+0,0x1.921FB54442D1aP+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.1A62633145C06P-54,1.0), IntervalArithmetic.def), Interval(interval(-2.0,2.0), IntervalArithmetic.com))[2], Interval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.1A62633145C06P-54,1.0), IntervalArithmetic.dac), Interval(interval(0.0,2.0), IntervalArithmetic.def))[2], Interval(interval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1.72CECE675D1FDP-53,1.0), IntervalArithmetic.def), Interval(interval(-0.1,1.5708), IntervalArithmetic.dac))[2], Interval(interval(-0.1,0x1.921FB54442D1aP+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.dac), Interval(interval(3.14,3.15), IntervalArithmetic.def))[2], Interval(interval(0x1.921fb52442d18p+1,0x1.921fb56442d1ap+1), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.def), Interval(interval(-3.15,-3.14), IntervalArithmetic.com))[2], Interval(interval(-0x1.921fb56442d1ap+1,-0x1.921fb52442d18p+1), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.def), Interval(interval(9.42,9.45), IntervalArithmetic.dac))[2], Interval(interval(0x1.2d97c7eb321d2p+3,0x1.2d97c7fb321d3p+3), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.87996529F9D92P-1,1.0), IntervalArithmetic.dac), Interval(interval(-1.0,0.1), IntervalArithmetic.def))[2], Interval(interval(-0x1.6666666666667p-1,0.1), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1), IntervalArithmetic.com), Interval(interval(0.0,2.1), IntervalArithmetic.dac))[2], Interval(interval(0x1.fffffffffffffp-1,0x1.0000000000001p+1), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.com), Interval(interval(-Inf,1.58), IntervalArithmetic.dac))[2], Interval(interval(-Inf,0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.def), Interval(interval(-Inf,1.5), IntervalArithmetic.dac))[2], Interval(interval(-Inf,-0x1.921FB54442D17P+0), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), IntervalArithmetic.dac), Interval(interval(-1.58,Inf), IntervalArithmetic.dac))[2], Interval(interval(-0x1.921fb54442d1ap+0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(cos_rev(Interval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), IntervalArithmetic.def), Interval(interval(-1.5,Inf), IntervalArithmetic.dac))[2], Interval(interval(0x1.921fb54442d19p+0,Inf), IntervalArithmetic.trv))

end

@testset "minimal_tan_rev_test" begin

    @test isequal_interval(tan_rev(emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(tan_rev(interval(-1.0,1.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan_rev(interval(-156.0,-12.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan_rev(interval(0.0,0.0))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))[2], entireinterval(BareInterval{Float64}))

end

@testset "minimal_tan_rev_bin_test" begin

    @test isequal_interval(tan_rev(emptyinterval(BareInterval{Float64}), interval(-1.5708,1.5708))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(tan_rev(entireinterval(BareInterval{Float64}), interval(-1.5708,1.5708))[2], interval(-1.5708,1.5708))

    @test isequal_interval(tan_rev(interval(0.0,0.0), interval(-1.5708,1.5708))[2], interval(0.0,0.0))

    @test isequal_interval(tan_rev(interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), interval(-1.5708,1.5708))[2], interval(-0x1.921fb54442d1bp+0,0x1.921fb54442d19p+0))

    @test isequal_interval(tan_rev(interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), interval(3.14,3.15))[2], interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1))

    @test isequal_interval(tan_rev(interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), interval(-3.15,3.15))[2], interval(-0x1.921FB54442D19P+1,0x1.921FB54442D1aP+1))

    @test isequal_interval(tan_rev(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), interval(-Inf,1.5707965))[2], interval(-Inf, +0x1.921FB82C2BD7Fp0))

    @test isequal_interval(tan_rev(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), interval(-1.5707965,Inf))[2], interval(-0x1.921FB82C2BD7Fp0, +Inf))

    @test isequal_interval(tan_rev(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), interval(-1.5707965,1.5707965))[2], interval(-0x1.921FB82C2BD7Fp0, +0x1.921FB82C2BD7Fp0))

    @test isequal_interval(tan_rev(interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), interval(-1.5707965,1.5707965))[2], interval(-1.5707965,1.5707965))

end

@testset "minimal_tan_rev_dec_test" begin

    @test isequal_interval(tan_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-1.0,1.0), IntervalArithmetic.com))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-156.0,-12.0), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(0.0,0.0), IntervalArithmetic.def))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), IntervalArithmetic.com))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_tan_rev_dec_bin_test" begin

    @test isequal_interval(tan_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(-1.5708,1.5708), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(interval(-1.5708,1.5708), IntervalArithmetic.dac))[2], Interval(interval(-1.5708,1.5708), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(0.0,0.0), IntervalArithmetic.com), Interval(interval(-1.5708,1.5708), IntervalArithmetic.def))[2], Interval(interval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), IntervalArithmetic.dac), Interval(interval(-1.5708,1.5708), IntervalArithmetic.def))[2], Interval(interval(-0x1.921fb54442d1bp+0,0x1.921fb54442d19p+0), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), IntervalArithmetic.def), Interval(interval(3.14,3.15), IntervalArithmetic.dac))[2], Interval(interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), IntervalArithmetic.com), Interval(interval(-3.15,3.15), IntervalArithmetic.com))[2], Interval(interval(-0x1.921FB54442D19P+1,0x1.921FB54442D1aP+1), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), IntervalArithmetic.def), Interval(interval(-Inf,1.5707965), IntervalArithmetic.def))[2], Interval(interval(-Inf,0x1.921FB82C2BD7Fp0), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), IntervalArithmetic.com), Interval(interval(-1.5707965,Inf), IntervalArithmetic.dac))[2], Interval(interval(-0x1.921FB82C2BD7Fp0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), IntervalArithmetic.com), Interval(interval(-1.5707965,1.5707965), IntervalArithmetic.com))[2], Interval(interval(-0x1.921FB82C2BD7Fp0,0x1.921FB82C2BD7Fp0), IntervalArithmetic.trv))

    @test isequal_interval(tan_rev(Interval(interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), IntervalArithmetic.dac), Interval(interval(-1.5707965,1.5707965), IntervalArithmetic.def))[2], Interval(interval(-1.5707965,1.5707965), IntervalArithmetic.trv))

end

@testset "minimal_cosh_rev_test" begin

    @test isequal_interval(cosh_rev(emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cosh_rev(interval(1.0,Inf))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(cosh_rev(interval(0.0,Inf))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(cosh_rev(interval(1.0,1.0))[2], interval(0.0,0.0))

    @test isequal_interval(cosh_rev(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432))[2], interval(-0x1.2C903022DD7ABP+8,0x1.2C903022DD7ABP+8))

end

@testset "minimal_cosh_rev_bin_test" begin

    @test isequal_interval(cosh_rev(emptyinterval(BareInterval{Float64}), interval(0.0,Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cosh_rev(interval(1.0,Inf), interval(0.0,Inf))[2], interval(0.0,Inf))

    @test isequal_interval(cosh_rev(interval(0.0,Inf), interval(1.0,2.0))[2], interval(1.0,2.0))

    @test isequal_interval(cosh_rev(interval(1.0,1.0), interval(1.0,Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cosh_rev(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), interval(-Inf,0.0))[2], interval(-0x1.2C903022DD7ABP+8,-0x1.fffffffffffffp-1))

end

@testset "minimal_cosh_rev_dec_test" begin

    @test isequal_interval(cosh_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(1.0,Inf), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(0.0,Inf), IntervalArithmetic.dac))[2], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(1.0,1.0), IntervalArithmetic.def))[2], Interval(interval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), IntervalArithmetic.com))[2], Interval(interval(-0x1.2C903022DD7ABP+8,0x1.2C903022DD7ABP+8), IntervalArithmetic.trv))

end

@testset "minimal_cosh_rev_dec_bin_test" begin

    @test isequal_interval(cosh_rev(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(interval(0.0,Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(1.0,Inf), IntervalArithmetic.def), Interval(interval(0.0,Inf), IntervalArithmetic.dac))[2], Interval(interval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(0.0,Inf), IntervalArithmetic.def), Interval(interval(1.0,2.0), IntervalArithmetic.com))[2], Interval(interval(1.0,2.0), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(1.0,1.0), IntervalArithmetic.dac), Interval(interval(1.0,Inf), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cosh_rev(Interval(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), IntervalArithmetic.com), Interval(interval(-Inf,0.0), IntervalArithmetic.dac))[2], Interval(interval(-0x1.2C903022DD7ABP+8,-0x1.fffffffffffffp-1), IntervalArithmetic.trv))

end

@testset "minimal_mul_rev_test" begin

    @test isequal_interval(mul_rev_IEEE1788(emptyinterval(BareInterval{Float64}), interval(1.0, 2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(1.0, 2.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, -0.4)), interval(0x1.999999999999AP-3, 0x1.5P+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-2.1, -0.4)), interval(0x1.999999999999AP-3, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, -0.4)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-2.1, -0.4)), interval(-Inf, -0x1.745D1745D1745P-2))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, -0.4)), interval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-2.1, -0.4)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-2.1, -0.4)), interval(0.0, 0x1.5P+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-2.1, -0.4)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-2.1, -0.4)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-2.1, -0.4)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-2.1, -0.4)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-2.1, -0.4)), interval(-0x1.A400000000001P+7, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-2.1, -0.4)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, 0.0)), interval(0.0, 0x1.5P+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, 0.0)), interval(-0x1.A400000000001P+7, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-2.1, 0.0)), interval(0.0, 0x1.5P+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-2.1, 0.0)), interval(-0x1.A400000000001P+7, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-2.1, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, 0.12)), interval(-0x1.3333333333333P+0, 0x1.5P+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, 0.12)), interval(-0x1.A400000000001P+7 , 0x1.8P+3))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-2.1, 0.12)), interval(-0x1.3333333333333P+0, 0x1.5P+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-2.1, 0.12)), interval(-0x1.A400000000001P+7 , 0x1.8P+3))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-2.1, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.0, 0.12)), interval(-0x1.3333333333333P+0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.0, 0.12)), interval(0.0, 0x1.8P+3))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, 0.12)), interval(-0x1.3333333333333P+0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(0.0, 0.12)), interval(0.0, 0x1.8P+3))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(0.0, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.01, 0.12)), interval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.01, 0.12)), interval(-Inf, -0x1.47AE147AE147BP-8))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.01, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.01, 0.12)), interval(0x1.29E4129E4129DP-7, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.01, 0.12)), interval(0x1.29E4129E4129DP-7, 0x1.8P+3))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.01, 0.12)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.01, 0.12)), interval(-0x1.3333333333333P+0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.01, 0.12)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.01, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.01, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(0.01, 0.12)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(0.01, 0.12)), interval(0.0, 0x1.8P+3))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(0.01, 0.12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.0, 0.0)), interval(0.0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.0, 0.0)), interval(0.0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, 0.0)), interval(0.0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(0.0, 0.0)), interval(0.0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(0.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-Inf, -0.1)), interval(0x1.999999999999AP-5, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-Inf, -0.1)), interval(0x1.999999999999AP-5 , Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-Inf, -0.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-Inf, -0.1)), interval(-Inf, -0x1.745D1745D1745P-4))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-Inf, -0.1)), interval(-Inf, -0x1.745D1745D1745P-4))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-Inf, -0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-Inf, -0.1)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-Inf, -0.1)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-Inf, -0.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-Inf, -0.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-Inf, -0.1)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-Inf, -0.1)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-Inf, -0.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-Inf, 0.0)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-Inf, 0.0)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-Inf, 0.0)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-Inf, 0.0)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-Inf, 0.3)), interval(-0x1.8P+1, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-Inf, 0.3)), interval(-Inf, 0x1.EP+4))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-Inf, 0.3)), interval(-0x1.8P+1, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-Inf, 0.3)), interval(-Inf, 0x1.EP+4))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-Inf, 0.3)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-0.21, Inf)), interval(-Inf , 0x1.0CCCCCCCCCCCDP+1))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-0.21, Inf)), interval(-0x1.5P+4, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-0.21, Inf)), interval(-Inf, 0x1.0CCCCCCCCCCCDP+1))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(-0.21, Inf)), interval(-0x1.5P+4, Inf))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(-0.21, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.0, Inf)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.0, Inf)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, Inf)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(0.0, Inf)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.04, Inf)), interval(-Inf, -0x1.47AE147AE147BP-6))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.04, Inf)), interval(-Inf, -0x1.47AE147AE147BP-6))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.04, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.04, Inf)), interval(0x1.29E4129E4129DP-5, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.04, Inf)), interval(0x1.29E4129E4129DP-5, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.04, Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.04, Inf)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.04, Inf)), interval(-Inf, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.04, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.04, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), interval(0.04, Inf)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), interval(0.04, Inf)), interval(0.0, Inf))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), interval(0.04, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 1.1), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, 0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, 1.1), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

end

@testset "minimal_mul_rev_ten_test" begin

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, -0.4), interval(-2.1, -0.4)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, -0.4), interval(-2.1, -0.4)), interval(-2.1, -0.4))

    @test isequal_interval(mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, 0.0), interval(-2.1, 0.0)), interval(-2.1,0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, 0.12), interval(0.0, 0.12)), interval(0.0, 0.0))

    @test isequal_interval(mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.04, Inf), interval(0.04, Inf)), interval(0.04, Inf))

end

@testset "minimal_mul_rev_dec_test" begin

    @test isnai(mul_rev_IEEE1788(nai(), Interval(interval(1.0,2.0), IntervalArithmetic.dac)))

    @test isnai(mul_rev_IEEE1788(Interval(interval(1.0,2.0), IntervalArithmetic.dac), nai()))

    @test isnai(mul_rev_IEEE1788(nai(), nai()))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-2.0, -0.1), IntervalArithmetic.dac), Interval(interval(-2.1, -0.4), IntervalArithmetic.dac)), Interval(interval(0x1.999999999999AP-3, 0x1.5P+4), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-2.0, -0.1), IntervalArithmetic.def), Interval(interval(-2.1, 0.0), IntervalArithmetic.def)), Interval(interval(0.0, 0x1.5P+4), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-2.0, -0.1), IntervalArithmetic.com), Interval(interval(-2.1, 0.12), IntervalArithmetic.dac)), Interval(interval(-0x1.3333333333333P+0, 0x1.5P+4), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-Inf, -0.1), IntervalArithmetic.dac), Interval(interval(0.0, 0.12), IntervalArithmetic.com)), Interval(interval(-0x1.3333333333333P+0, 0.0), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(0.01, 1.1), IntervalArithmetic.def), Interval(interval(0.01, 0.12), IntervalArithmetic.dac)), Interval(interval(0x1.29E4129E4129DP-7, 0x1.8P+3), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(0.01, 1.1), IntervalArithmetic.dac), Interval(interval(-Inf, 0.3), IntervalArithmetic.def)), Interval(interval(-Inf, 0x1.EP+4), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-Inf, -0.1), IntervalArithmetic.trv), Interval(interval(-0.21, Inf), IntervalArithmetic.dac)), Interval(interval(-Inf, 0x1.0CCCCCCCCCCCDP+1), IntervalArithmetic.trv))

end

@testset "minimal_mul_rev_dec_ten_test" begin

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-2.0, -0.1), IntervalArithmetic.dac), Interval(interval(-2.1, -0.4), IntervalArithmetic.dac), Interval(interval(-2.1, -0.4), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-2.0, 1.1), IntervalArithmetic.def), Interval(interval(-2.1, -0.4), IntervalArithmetic.com), Interval(interval(-2.1, -0.4), IntervalArithmetic.com)), Interval(interval(-2.1, -0.4), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(0.01, 1.1), IntervalArithmetic.com), Interval(interval(-2.1, 0.0), IntervalArithmetic.dac), Interval(interval(-2.1, 0.0), IntervalArithmetic.dac)), Interval(interval(-2.1,0.0), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-Inf, -0.1), IntervalArithmetic.dac), Interval(interval(0.0, 0.12), IntervalArithmetic.com), Interval(interval(0.0, 0.12), IntervalArithmetic.com)), Interval(interval(0.0, 0.0), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_IEEE1788(Interval(interval(-2.0, 1.1), IntervalArithmetic.def), Interval(interval(0.04, Inf), IntervalArithmetic.dac), Interval(interval(0.04, Inf), IntervalArithmetic.dac)), Interval(interval(0.04, Inf), IntervalArithmetic.trv))

end
