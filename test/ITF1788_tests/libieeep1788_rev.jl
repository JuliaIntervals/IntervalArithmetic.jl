@testset "minimal_sqr_rev_test" begin

    @test sqr_rev(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test sqr_rev(bareinterval(-10.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test sqr_rev(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test sqr_rev(bareinterval(0.0,1.0)) === bareinterval(-1.0,1.0)

    @test sqr_rev(bareinterval(-0.5,1.0)) === bareinterval(-1.0,1.0)

    @test sqr_rev(bareinterval(-1000.0,1.0)) === bareinterval(-1.0,1.0)

    @test sqr_rev(bareinterval(0.0,25.0)) === bareinterval(-5.0,5.0)

    @test sqr_rev(bareinterval(-1.0,25.0)) === bareinterval(-5.0,5.0)

    @test sqr_rev(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7)) === bareinterval(-0x1.999999999999BP-4,0x1.999999999999BP-4)

    @test sqr_rev(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1)) === bareinterval(-0x1.ffffffffffff1p+0,0x1.ffffffffffff1p+0)

end

@testset "minimal_sqr_rev_bin_test" begin

    @test sqr_rev(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test sqr_rev(bareinterval(-10.0,-1.0), bareinterval(-5.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test sqr_rev(bareinterval(0.0,Inf), bareinterval(-5.0,1.0)) === bareinterval(-5.0,1.0)

    @test sqr_rev(bareinterval(0.0,1.0), bareinterval(-0.1,1.0)) === bareinterval(-0.1,1.0)

    @test sqr_rev(bareinterval(-0.5,1.0), bareinterval(-0.1,1.0)) === bareinterval(-0.1,1.0)

    @test sqr_rev(bareinterval(-1000.0,1.0), bareinterval(-0.1,1.0)) === bareinterval(-0.1,1.0)

    @test sqr_rev(bareinterval(0.0,25.0), bareinterval(-4.1,6.0)) === bareinterval(-4.1,5.0)

    @test sqr_rev(bareinterval(-1.0,25.0), bareinterval(-4.1,7.0)) === bareinterval(-4.1,5.0)

    @test sqr_rev(bareinterval(1.0,25.0), bareinterval(0.0,7.0)) === bareinterval(1.0,5.0)

    @test sqr_rev(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), bareinterval(-0.1,Inf)) === bareinterval(-0.1,0x1.999999999999BP-4)

    @test sqr_rev(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1), bareinterval(-0.1,Inf)) === bareinterval(-0.1,0x1.ffffffffffff1p+0)

end

@testset "minimal_sqr_rev_dec_test" begin

    @test sqr_rev(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sqr_rev(interval(bareinterval(-10.0,-1.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sqr_rev(interval(bareinterval(0.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test sqr_rev(interval(bareinterval(0.0,1.0), def)) === interval(bareinterval(-1.0,1.0), trv)

    @test sqr_rev(interval(bareinterval(-0.5,1.0), dac)) === interval(bareinterval(-1.0,1.0), trv)

    @test sqr_rev(interval(bareinterval(-1000.0,1.0), com)) === interval(bareinterval(-1.0,1.0), trv)

    @test sqr_rev(interval(bareinterval(0.0,25.0), def)) === interval(bareinterval(-5.0,5.0), trv)

    @test sqr_rev(interval(bareinterval(-1.0,25.0), dac)) === interval(bareinterval(-5.0,5.0), trv)

    @test sqr_rev(interval(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), com)) === interval(bareinterval(-0x1.999999999999BP-4,0x1.999999999999BP-4), trv)

    @test sqr_rev(interval(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1), def)) === interval(bareinterval(-0x1.ffffffffffff1p+0,0x1.ffffffffffff1p+0), trv)

end

@testset "minimal_sqr_rev_dec_bin_test" begin

    @test sqr_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-5.0,1.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sqr_rev(interval(bareinterval(-10.0,-1.0), com), interval(bareinterval(-5.0,1.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sqr_rev(interval(bareinterval(0.0,Inf), def), interval(bareinterval(-5.0,1.0), dac)) === interval(bareinterval(-5.0,1.0), trv)

    @test sqr_rev(interval(bareinterval(0.0,1.0), dac), interval(bareinterval(-0.1,1.0), def)) === interval(bareinterval(-0.1,1.0), trv)

    @test sqr_rev(interval(bareinterval(-0.5,1.0), def), interval(bareinterval(-0.1,1.0), dac)) === interval(bareinterval(-0.1,1.0), trv)

    @test sqr_rev(interval(bareinterval(-1000.0,1.0), com), interval(bareinterval(-0.1,1.0), def)) === interval(bareinterval(-0.1,1.0), trv)

    @test sqr_rev(interval(bareinterval(0.0,25.0), def), interval(bareinterval(-4.1,6.0), com)) === interval(bareinterval(-4.1,5.0), trv)

    @test sqr_rev(interval(bareinterval(-1.0,25.0), dac), interval(bareinterval(-4.1,7.0), def)) === interval(bareinterval(-4.1,5.0), trv)

    @test sqr_rev(interval(bareinterval(1.0,25.0), dac), interval(bareinterval(0.0,7.0), def)) === interval(bareinterval(1.0,5.0), trv)

    @test sqr_rev(interval(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), def), interval(bareinterval(-0.1,Inf), dac)) === interval(bareinterval(-0.1,0x1.999999999999BP-4), trv)

    @test sqr_rev(interval(bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1), dac), interval(bareinterval(-0.1,Inf), dac)) === interval(bareinterval(-0.1,0x1.ffffffffffff1p+0), trv)

end

@testset "minimal_abs_rev_test" begin

    @test abs_rev(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test abs_rev(bareinterval(-1.1,-0.4)) === emptyinterval(BareInterval{Float64})

    @test abs_rev(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test abs_rev(bareinterval(1.1,2.1)) === bareinterval(-2.1,2.1)

    @test abs_rev(bareinterval(-1.1,2.0)) === bareinterval(-2.0,2.0)

    @test abs_rev(bareinterval(-1.1,0.0)) === bareinterval(0.0,0.0)

    @test abs_rev(bareinterval(-1.9,0.2)) === bareinterval(-0.2,0.2)

    @test abs_rev(bareinterval(0.0,0.2)) === bareinterval(-0.2,0.2)

    @test abs_rev(bareinterval(-1.5,Inf)) === entireinterval(BareInterval{Float64})

end

@testset "minimal_abs_rev_bin_test" begin

    @test abs_rev(emptyinterval(BareInterval{Float64}), bareinterval(-1.1,5.0)) === emptyinterval(BareInterval{Float64})

    @test abs_rev(bareinterval(-1.1,-0.4), bareinterval(-1.1,5.0)) === emptyinterval(BareInterval{Float64})

    @test abs_rev(bareinterval(0.0,Inf), bareinterval(-1.1,5.0)) === bareinterval(-1.1,5.0)

    @test abs_rev(bareinterval(1.1,2.1), bareinterval(-1.0,5.0)) === bareinterval(1.1,2.1)

    @test abs_rev(bareinterval(-1.1,2.0), bareinterval(-1.1,5.0)) === bareinterval(-1.1,2.0)

    @test abs_rev(bareinterval(-1.1,0.0), bareinterval(-1.1,5.0)) === bareinterval(0.0,0.0)

    @test abs_rev(bareinterval(-1.9,0.2), bareinterval(-1.1,5.0)) === bareinterval(-0.2,0.2)

end

@testset "minimal_abs_rev_dec_test" begin

    @test abs_rev(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test abs_rev(interval(bareinterval(-1.1,-0.4), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test abs_rev(interval(bareinterval(0.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test abs_rev(interval(bareinterval(1.1,2.1), com)) === interval(bareinterval(-2.1,2.1), trv)

    @test abs_rev(interval(bareinterval(-1.1,2.0), def)) === interval(bareinterval(-2.0,2.0), trv)

    @test abs_rev(interval(bareinterval(-1.1,0.0), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test abs_rev(interval(bareinterval(-1.9,0.2), com)) === interval(bareinterval(-0.2,0.2), trv)

    @test abs_rev(interval(bareinterval(0.0,0.2), def)) === interval(bareinterval(-0.2,0.2), trv)

    @test abs_rev(interval(bareinterval(-1.5,Inf), def)) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_abs_rev_dec_bin_test" begin

    @test abs_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-1.1,5.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test abs_rev(interval(bareinterval(-1.1,-0.4), dac), interval(bareinterval(-1.1,5.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test abs_rev(interval(bareinterval(0.0,Inf), def), interval(bareinterval(-1.1,5.0), def)) === interval(bareinterval(-1.1,5.0), trv)

    @test abs_rev(interval(bareinterval(1.1,2.1), dac), interval(bareinterval(-1.0,5.0), def)) === interval(bareinterval(1.1,2.1), trv)

    @test abs_rev(interval(bareinterval(-1.1,2.0), com), interval(bareinterval(-1.1,5.0), def)) === interval(bareinterval(-1.1,2.0), trv)

    @test abs_rev(interval(bareinterval(-1.1,0.0), def), interval(bareinterval(-1.1,5.0), def)) === interval(bareinterval(0.0,0.0), trv)

    @test abs_rev(interval(bareinterval(-1.9,0.2), dac), interval(bareinterval(-1.1,5.0), def)) === interval(bareinterval(-0.2,0.2), trv)

end

@testset "minimal_pown_rev_test" begin

    @test pown_rev(emptyinterval(BareInterval{Float64}), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(1.0,1.0), 0) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-1.0,5.0), 0) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-1.0,0.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-1.0,-0.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(1.1,10.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(emptyinterval(BareInterval{Float64}), 1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), 1) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), 1) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(-0.0,-0.0), 1) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(13.1,13.1), 1) === bareinterval(13.1,13.1)

    @test pown_rev(bareinterval(-7451.145,-7451.145), 1) === bareinterval(-7451.145,-7451.145)

    @test pown_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1) === bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)

    @test pown_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1) === bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)

    @test pown_rev(bareinterval(0.0,Inf), 1) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-0.0,Inf), 1) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-Inf,0.0), 1) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-Inf,-0.0), 1) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-324.3,2.5), 1) === bareinterval(-324.3,2.5)

    @test pown_rev(bareinterval(0.01,2.33), 1) === bareinterval(0.01,2.33)

    @test pown_rev(bareinterval(-1.9,-0.33), 1) === bareinterval(-1.9,-0.33)

    @test pown_rev(emptyinterval(BareInterval{Float64}), 2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-5.0,-1.0), 2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,Inf), 2) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,Inf), 2) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), 2) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(-0.0,-0.0), 2) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7), 2) === bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25), 2) === bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test pown_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2) === bareinterval(-0x1p+512,0x1p+512)

    @test pown_rev(bareinterval(0.0,0x1.9AD27D70A3D72P+16), 2) === bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test pown_rev(bareinterval(-0.0,0x1.9AD27D70A3D72P+16), 2) === bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test pown_rev(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), 2) === bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), 2) === bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), 8) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), 8) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,Inf), 8) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,Inf), 8) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), 8) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(-0.0,-0.0), 8) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29), 8) === bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102), 8) === bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test pown_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8) === bareinterval(-0x1p+128,0x1p+128)

    @test pown_rev(bareinterval(0.0,0x1.A87587109655P+66), 8) === bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test pown_rev(bareinterval(-0.0,0x1.A87587109655P+66), 8) === bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test pown_rev(bareinterval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9), 8) === bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7), 8) === bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), 3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), 3) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), 3) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(-0.0,-0.0), 3) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11), 3) === bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38), 3) === bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test pown_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3) === bareinterval(0x1.428a2f98d728ap+341,0x1.428a2f98d728bp+341)

    @test pown_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3) === bareinterval(-0x1.428a2f98d728bp+341, -0x1.428a2f98d728ap+341)

    @test pown_rev(bareinterval(0.0,Inf), 3) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-0.0,Inf), 3) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-Inf,0.0), 3) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-Inf,-0.0), 3) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-0x1.0436D2F418938P+25,0x1.F4P+3), 3) === bareinterval(-0x1.444cccccccccep+8,0x1.4p+1)

    @test pown_rev(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), 3) === bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), 3) === bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)

    @test pown_rev(emptyinterval(BareInterval{Float64}), 7) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), 7) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), 7) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(-0.0,-0.0), 7) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25), 7) === bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90), 7) === bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test pown_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7) === bareinterval(0x1.381147622f886p+146,0x1.381147622f887p+146)

    @test pown_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7) === bareinterval(-0x1.381147622f887p+146,-0x1.381147622f886p+146)

    @test pown_rev(bareinterval(0.0,Inf), 7) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-0.0,Inf), 7) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-Inf,0.0), 7) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-Inf,-0.0), 7) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-0x1.4F109959E6D7FP+58,0x1.312DP+9), 7) === bareinterval(-0x1.444cccccccccep+8,0x1.4p+1)

    @test pown_rev(bareinterval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8), 7) === bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12), 7) === bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)

    @test pown_rev(emptyinterval(BareInterval{Float64}), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,Inf), -2) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,Inf), -2) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,-0.0), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-10.0,0.0), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-10.0,-0.0), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8), -2) === bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test_broken pown_rev(bareinterval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26), -2) === bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test pown_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -2) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.3F0C482C977C9P-17,Inf), -2) === bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test pown_rev(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), -2) === bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), -2) === bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), -8) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,Inf), -8) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,Inf), -8) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), -8) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,-0.0), -8) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30), -8) === bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103), -8) === bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test pown_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -8) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.34CC3764D1E0CP-67,Inf), -8) === bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test pown_rev(bareinterval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53), -8) === bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12), -8) === bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), -1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), -1) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), -1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,-0.0), -1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4), -1) === bareinterval(0x1.a333333333332p+3,0x1.a333333333335p+3)

    @test pown_rev(bareinterval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13), -1) === bareinterval(-0x1.d1b251eb851eep+12,-0x1.d1b251eb851ebp+12)

    @test pown_rev(bareinterval(0x0.4P-1022,0x0.4000000000001P-1022), -1) === bareinterval(0x1.ffffffffffff8p+1023,Inf)

    @test pown_rev(bareinterval(-0x0.4000000000001P-1022,-0x0.4P-1022), -1) === bareinterval(-Inf,-0x1.ffffffffffff8p+1023)

    @test pown_rev(bareinterval(0.0,Inf), -1) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-0.0,Inf), -1) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-Inf,0.0), -1) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-Inf,-0.0), -1) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), -1) === bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1), -1) === bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)

    @test pown_rev(emptyinterval(BareInterval{Float64}), -3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), -3) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), -3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,-0.0), -3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12), -3) === bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39), -3) === bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test pown_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -3) === bareinterval(0x1p+358,Inf)

    @test pown_rev(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), -3) === bareinterval(-Inf,-0x1p+358)

    @test pown_rev(bareinterval(0.0,Inf), -3) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-0.0,Inf), -3) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-Inf,0.0), -3) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-Inf,-0.0), -3) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(0x1.43CFBA61AACABP-4,0x1.E848P+19), -3) === bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3), -3) === bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)

    @test pown_rev(emptyinterval(BareInterval{Float64}), -7) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), -7) === entireinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,0.0), -7) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-0.0,-0.0), -7) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26), -7) === bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test pown_rev(bareinterval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91), -7) === bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test pown_rev(bareinterval(0x0P+0,0x0.0000000000001P-1022), -7) === bareinterval(0x1.588cea3f093bcp+153,Inf)

    @test pown_rev(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), -7) === bareinterval(-Inf,-0x1.588cea3f093bcp+153)

    @test pown_rev(bareinterval(0.0,Inf), -7) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-0.0,Inf), -7) === bareinterval(0.0,Inf)

    @test pown_rev(bareinterval(-Inf,0.0), -7) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(-Inf,-0.0), -7) === bareinterval(-Inf,0.0)

    @test pown_rev(bareinterval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46), -7) === bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7), -7) === bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)

end

@testset "minimal_pown_rev_bin_test" begin

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(1.0,1.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(1.0,1.0), bareinterval(1.0,1.0), 0) === bareinterval(1.0,1.0)

    @test pown_rev(bareinterval(-1.0,5.0), bareinterval(-51.0,12.0), 0) === bareinterval(-51.0,12.0)

    @test pown_rev(bareinterval(-1.0,0.0), bareinterval(5.0,10.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-1.0,-0.0), bareinterval(-1.0,1.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(1.1,10.0), bareinterval(1.0,41.0), 0) === emptyinterval(BareInterval{Float64})

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(0.0,100.1), 1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), bareinterval(-5.1,10.0), 1) === bareinterval(-5.1,10.0)

    @test pown_rev(bareinterval(0.0,0.0), bareinterval(-10.0,5.1), 1) === bareinterval(0.0,0.0)

    @test pown_rev(bareinterval(-0.0,-0.0), bareinterval(1.0,5.0), 1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(5.0,17.1), 2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-5.0,-1.0), bareinterval(5.0,17.1), 2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,Inf), bareinterval(5.6,27.544), 2) === bareinterval(5.6,27.544)

    @test pown_rev(bareinterval(0.0,0.0), bareinterval(1.0,2.0), 2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), bareinterval(1.0,Inf), 2) === bareinterval(1.0,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), bareinterval(-Inf,-1.0), 2) === bareinterval(-0x1.e666666666667p+0,-1.0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(-23.0,-1.0), 3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), bareinterval(-23.0,-1.0), 3) === bareinterval(-23.0,-1.0)

    @test pown_rev(bareinterval(0.0,0.0), bareinterval(1.0,2.0), 3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), bareinterval(1.0,Inf), 3) === bareinterval(1.0,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), bareinterval(-Inf,-1.0), 3) === bareinterval(-0x1.e666666666667p+0,-1.0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(-3.0,17.3), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0.0,Inf), bareinterval(-5.1,-0.1), -2) === bareinterval(-5.1,-0.1)

    @test pown_rev(bareinterval(0.0,0.0), bareinterval(27.2,55.1), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.3F0C482C977C9P-17,Inf), bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), -2) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), bareinterval(1.0,Inf), -2) === bareinterval(1.0,0x1.2a3d70a3d70a5p+1)

    @test pown_rev(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), bareinterval(-Inf,-1.0), -2) === bareinterval(-0x1.e666666666667p+0,-1.0)

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -1) === bareinterval(-5.1,55.5)

    @test pown_rev(bareinterval(0.0,0.0), bareinterval(-5.1,55.5), -1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-Inf,-0.0), bareinterval(-1.0,1.0), -1) === bareinterval(-1.0,0.0)

    @test pown_rev(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), bareinterval(-1.0,0.0), -1) === emptyinterval(BareInterval{Float64})

    @test pown_rev(emptyinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(entireinterval(BareInterval{Float64}), bareinterval(-5.1,55.5), -3) === bareinterval(-5.1,55.5)

    @test pown_rev(bareinterval(0.0,0.0), bareinterval(-5.1,55.5), -3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-Inf,0.0), bareinterval(5.1,55.5), -3) === emptyinterval(BareInterval{Float64})

    @test pown_rev(bareinterval(-Inf,-0.0), bareinterval(-32.0,1.1), -3) === bareinterval(-32.0,0.0)

end

@testset "minimal_pown_rev_dec_test" begin

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(1.0,1.0), com), 0) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-1.0,5.0), dac), 0) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-1.0,0.0), def), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-1.0,-0.0), dac), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(1.1,10.0), com), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), 1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), 1) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), com), 1) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), 1) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(13.1,13.1), def), 1) === interval(bareinterval(13.1,13.1), trv)

    @test pown_rev(interval(bareinterval(-7451.145,-7451.145), dac), 1) === interval(bareinterval(-7451.145,-7451.145), trv)

    @test pown_rev(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), 1) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), trv)

    @test pown_rev(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com), 1) === interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), 1) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), 1) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), def), 1) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), def), 1) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-324.3,2.5), dac), 1) === interval(bareinterval(-324.3,2.5), trv)

    @test pown_rev(interval(bareinterval(0.01,2.33), com), 1) === interval(bareinterval(0.01,2.33), trv)

    @test pown_rev(interval(bareinterval(-1.9,-0.33), def), 1) === interval(bareinterval(-1.9,-0.33), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), 2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), 2) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), def), 2) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), com), 2) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), 2) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7), def), 2) === interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25), def), 2) === interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test pown_rev(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), 2) === interval(bareinterval(-0x1p+512,0x1p+512), trv)

    @test pown_rev(interval(bareinterval(0.0,0x1.9AD27D70A3D72P+16), dac), 2) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test pown_rev(interval(bareinterval(-0.0,0x1.9AD27D70A3D72P+16), def), 2) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test pown_rev(interval(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), com), 2) === interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), def), 2) === interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), 8) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), 8) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), 8) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), 8) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), 8) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), 8) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29), com), 8) === interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102), dac), 8) === interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test pown_rev(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), def), 8) === interval(bareinterval(-0x1p+128,0x1p+128), trv)

    @test pown_rev(interval(bareinterval(0.0,0x1.A87587109655P+66), dac), 8) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test pown_rev(interval(bareinterval(-0.0,0x1.A87587109655P+66), def), 8) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test pown_rev(interval(bareinterval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9), com), 8) === interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7), dac), 8) === interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), 3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), 3) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), dac), 3) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), def), 3) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11), com), 3) === interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38), def), 3) === interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test pown_rev(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), 3) === interval(bareinterval(0x1.428a2f98d728ap+341,0x1.428a2f98d728bp+341), trv)

    @test pown_rev(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com), 3) === interval(bareinterval(-0x1.428a2f98d728bp+341, -0x1.428a2f98d728ap+341), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), def), 3) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), def), 3) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), dac), 3) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), def), 3) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-0x1.0436D2F418938P+25,0x1.F4P+3), com), 3) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.4p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), dac), 3) === interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), def), 3) === interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), 7) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), 7) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), com), 7) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), 7) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25), def), 7) === interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90), dac), 7) === interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test pown_rev(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), 7) === interval(bareinterval(0x1.381147622f886p+146,0x1.381147622f887p+146), trv)

    @test pown_rev(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), def), 7) === interval(bareinterval(-0x1.381147622f887p+146,-0x1.381147622f886p+146), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), 7) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), 7) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), def), 7) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), def), 7) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-0x1.4F109959E6D7FP+58,0x1.312DP+9), dac), 7) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.4p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8), com), 7) === interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12), def), 7) === interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), -2) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), -2) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), com), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-10.0,0.0), dac), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-10.0,-0.0), def), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8), dac), -2) === interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test_broken pown_rev(interval(bareinterval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26), def), -2) === interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test pown_rev(interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), com), -2) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.3F0C482C977C9P-17,Inf), dac), -2) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test pown_rev(interval(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), def), -2) === interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), com), -2) === interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), -8) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), def), -8) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), -8) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), -8) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), -8) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30), com), -8) === interval(bareinterval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103), def), -8) === interval(bareinterval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test pown_rev(interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), dac), -8) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.34CC3764D1E0CP-67,Inf), def), -8) === interval(bareinterval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test pown_rev(interval(bareinterval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53), com), -8) === interval(bareinterval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12), def), -8) === interval(bareinterval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), -1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), -1) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), dac), -1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), -1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4), def), -1) === interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333335p+3), trv)

    @test pown_rev(interval(bareinterval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13), dac), -1) === interval(bareinterval(-0x1.d1b251eb851eep+12,-0x1.d1b251eb851ebp+12), trv)

    @test pown_rev(interval(bareinterval(0x0.4P-1022,0x0.4000000000001P-1022), dac), -1) === interval(bareinterval(0x1.ffffffffffff8p+1023,Inf), trv)

    @test pown_rev(interval(bareinterval(-0x0.4000000000001P-1022,-0x0.4P-1022), def), -1) === interval(bareinterval(-Inf,-0x1.ffffffffffff8p+1023), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), -1) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), -1) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), dac), -1) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), def), -1) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), com), -1) === interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1), com), -1) === interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), -3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), -3) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), -3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), dac), -3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12), com), -3) === interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39), def), -3) === interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test pown_rev(interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), dac), -3) === interval(bareinterval(0x1p+358,Inf), trv)

    @test pown_rev(interval(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), def), -3) === interval(bareinterval(-Inf,-0x1p+358), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), -3) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), dac), -3) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), def), -3) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), def), -3) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.43CFBA61AACABP-4,0x1.E848P+19), com), -3) === interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3), def), -3) === interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), -7) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), -7) === interval(entireinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), com), -7) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), def), -7) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26), dac), -7) === interval(bareinterval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test pown_rev(interval(bareinterval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91), dac), -7) === interval(bareinterval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test pown_rev(interval(bareinterval(0x0P+0,0x0.0000000000001P-1022), def), -7) === interval(bareinterval(0x1.588cea3f093bcp+153,Inf), trv)

    @test pown_rev(interval(bareinterval(-0x0.0000000000001P-1022,-0x0P+0), def), -7) === interval(bareinterval(-Inf,-0x1.588cea3f093bcp+153), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), -7) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-0.0,Inf), def), -7) === interval(bareinterval(0.0,Inf), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), dac), -7) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), def), -7) === interval(bareinterval(-Inf,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46), com), -7) === interval(bareinterval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7), com), -7) === interval(bareinterval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)

end

@testset "minimal_pown_rev_dec_bin_test" begin

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0,1.0), def), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(1.0,1.0), dac), interval(bareinterval(1.0,1.0), dac), 0) === interval(bareinterval(1.0,1.0), trv)

    @test pown_rev(interval(bareinterval(-1.0,5.0), def), interval(bareinterval(-51.0,12.0), dac), 0) === interval(bareinterval(-51.0,12.0), trv)

    @test pown_rev(interval(bareinterval(-1.0,0.0), com), interval(bareinterval(5.0,10.0), dac), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-1.0,-0.0), dac), interval(bareinterval(-1.0,1.0), def), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(1.1,10.0), def), interval(bareinterval(1.0,41.0), dac), 0) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0,100.1), dac), 1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-5.1,10.0), def), 1) === interval(bareinterval(-5.1,10.0), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), com), interval(bareinterval(-10.0,5.1), dac), 1) === interval(bareinterval(0.0,0.0), trv)

    @test pown_rev(interval(bareinterval(-0.0,-0.0), def), interval(bareinterval(1.0,5.0), dac), 1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(5.0,17.1), def), 2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), interval(bareinterval(5.6,27.544), dac), 2) === interval(bareinterval(5.6,27.544), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), interval(bareinterval(1.0,2.0), def), 2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), com), interval(bareinterval(1.0,Inf), def), 2) === interval(bareinterval(1.0,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), dac), interval(bareinterval(-Inf,-1.0), def), 2) === interval(bareinterval(-0x1.e666666666667p+0,-1.0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-23.0,-1.0), dac), 3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-23.0,-1.0), com), 3) === interval(bareinterval(-23.0,-1.0), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), interval(bareinterval(1.0,2.0), dac), 3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), com), interval(bareinterval(1.0,Inf), dac), 3) === interval(bareinterval(1.0,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), com), interval(bareinterval(-Inf,-1.0), dac), 3) === interval(bareinterval(-0x1.e666666666667p+0,-1.0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-3.0,17.3), def), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0.0,Inf), dac), interval(bareinterval(-5.1,-0.1), dac), -2) === interval(bareinterval(-5.1,-0.1), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), interval(bareinterval(27.2,55.1), dac), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.3F0C482C977C9P-17,Inf), def), interval(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac), -2) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13), com), interval(bareinterval(1.0,Inf), dac), -2) === interval(bareinterval(1.0,0x1.2a3d70a3d70a5p+1), trv)

    @test pown_rev(interval(bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), com), interval(bareinterval(-Inf,-1.0), dac), -2) === interval(bareinterval(-0x1.e666666666667p+0,-1.0), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-5.1,55.5), def), -1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-5.1,55.5), dac), -1) === interval(bareinterval(-5.1,55.5), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), dac), interval(bareinterval(-5.1,55.5), def), -1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), dac), interval(bareinterval(-1.0,1.0), com), -1) === interval(bareinterval(-1.0,0.0), trv)

    @test pown_rev(interval(bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6), def), interval(bareinterval(-1.0,0.0), dac), -1) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-5.1,55.5), dac), -3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-5.1,55.5), def), -3) === interval(bareinterval(-5.1,55.5), trv)

    @test pown_rev(interval(bareinterval(0.0,0.0), def), interval(bareinterval(-5.1,55.5), def), -3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-Inf,0.0), dac), interval(bareinterval(5.1,55.5), com), -3) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pown_rev(interval(bareinterval(-Inf,-0.0), dac), interval(bareinterval(-32.0,1.1), def), -3) === interval(bareinterval(-32.0,0.0), trv)

end

@testset "minimal_sin_rev_test" begin

    @test sin_rev(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(-2.0,-1.1)) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(1.1, 2.0)) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(-1.0,1.0)) === entireinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(0.0,0.0)) === entireinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53)) === entireinterval(BareInterval{Float64})

end

@testset "minimal_sin_rev_bin_test" begin

    @test sin_rev(emptyinterval(BareInterval{Float64}), bareinterval(-1.2,12.1)) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(-2.0,-1.1), bareinterval(-5.0, 5.0)) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(1.1, 2.0), bareinterval(-5.0, 5.0)) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(-1.0,1.0), bareinterval(-1.2,12.1)) === bareinterval(-1.2,12.1)

    @test sin_rev(bareinterval(0.0,0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test sin_rev(bareinterval(-0.0,-0.0), bareinterval(2.0,2.5)) === emptyinterval(BareInterval{Float64})

    @test sin_rev(bareinterval(-0.0,-0.0), bareinterval(3.0,3.5)) === bareinterval(0x1.921fb54442d18p+1,0x1.921fb54442d19p+1)

    @test sin_rev(bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0), bareinterval(1.57,1.58, )) === bareinterval(0x1.921fb50442d18p+0,0x1.921fb58442d1ap+0)

    @test sin_rev(bareinterval(0.0,0x1P+0), bareinterval(-0.1,1.58)) === bareinterval(0.0,1.58)

    @test sin_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), bareinterval(3.14,3.15)) === bareinterval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1)

    @test sin_rev(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), bareinterval(3.14,3.15)) === bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D1aP+1)

    @test sin_rev(bareinterval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53), bareinterval(3.14,3.15)) === bareinterval(0x1.921FB54442D17P+1,0x1.921FB54442D1aP+1)

    @test sin_rev(bareinterval(0.0,1.0), bareinterval(-0.1,3.15)) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test sin_rev(bareinterval(0.0,1.0), bareinterval(-0.1,3.15)) === bareinterval(-0.0,0x1.921FB54442D19P+1)

    @test sin_rev(bareinterval(-0x1.72CECE675D1FDP-52,1.0), bareinterval(-0.1,3.15)) === bareinterval(-0x1.72cece675d1fep-52,0x1.921FB54442D1aP+1)

    @test sin_rev(bareinterval(-0x1.72CECE675D1FDP-52,1.0), bareinterval(0.0,3.15)) === bareinterval(0.0,0x1.921FB54442D1aP+1)

    @test sin_rev(bareinterval(0x1.1A62633145C06P-53,0x1P+0), bareinterval(3.14,3.15)) === bareinterval(3.14,0x1.921FB54442D19P+1)

    @test sin_rev(bareinterval(-0x1.72CECE675D1FDP-52,0x1P+0), bareinterval(1.57,3.15)) === bareinterval(1.57,0x1.921FB54442D1AP+1)

    @test sin_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), bareinterval(-Inf,3.15)) === bareinterval(-Inf,0x1.921FB54442D19P+1)

    @test sin_rev(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), bareinterval(3.14,Inf)) === bareinterval(0x1.921FB54442D18P+1,Inf)

end

@testset "minimal_sin_rev_dec_test" begin

    @test sin_rev(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(-2.0,-1.1), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(1.1, 2.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(-1.0,1.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(0.0,0.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), def)) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_sin_rev_dec_bin_test" begin

    @test sin_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-1.2,12.1), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(-2.0,-1.1), def), interval(bareinterval(-5.0, 5.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(1.1, 2.0), dac), interval(bareinterval(-5.0, 5.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(-1.0,1.0), com), interval(bareinterval(-1.2,12.1), def)) === interval(bareinterval(-1.2,12.1), trv)

    @test sin_rev(interval(bareinterval(0.0,0.0), dac), interval(bareinterval(-1.0,1.0), def)) === interval(bareinterval(0.0,0.0), trv)

    @test sin_rev(interval(bareinterval(-0.0,-0.0), def), interval(bareinterval(2.0,2.5), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test sin_rev(interval(bareinterval(-0.0,-0.0), def), interval(bareinterval(3.0,3.5), dac)) === interval(bareinterval(0x1.921fb54442d18p+1,0x1.921fb54442d19p+1), trv)

    @test sin_rev(interval(bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0), dac), interval(bareinterval(1.57,1.58), dac)) === interval(bareinterval(0x1.921fb50442d18p+0,0x1.921fb58442d1ap+0), trv)

    @test sin_rev(interval(bareinterval(0.0,0x1P+0), com), interval(bareinterval(-0.1,1.58), dac)) === interval(bareinterval(0.0,1.58), trv)

    @test sin_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com), interval(bareinterval(3.14,3.15), def)) === interval(bareinterval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1), trv)

    @test sin_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), com), interval(bareinterval(3.14,3.15), dac)) === interval(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53), dac), interval(bareinterval(3.14,3.15), com)) === interval(bareinterval(0x1.921FB54442D17P+1,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(interval(bareinterval(0.0,1.0), def), interval(bareinterval(-0.1,3.15), def)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test sin_rev(interval(bareinterval(0.0,1.0), dac), interval(bareinterval(-0.1,3.15), com)) === interval(bareinterval(-0.0,0x1.921FB54442D19P+1), trv)

    @test sin_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,1.0), def), interval(bareinterval(-0.1,3.15), def)) === interval(bareinterval(-0x1.72cece675d1fep-52,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,1.0), com), interval(bareinterval(0.0,3.15), dac)) === interval(bareinterval(0.0,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1P+0), def), interval(bareinterval(3.14,3.15), com)) === interval(bareinterval(3.14,0x1.921FB54442D19P+1), trv)

    @test sin_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,0x1P+0), dac), interval(bareinterval(1.57,3.15), com)) === interval(bareinterval(1.57,0x1.921FB54442D1AP+1), trv)

    @test sin_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com), interval(bareinterval(-Inf,3.15), dac)) === interval(bareinterval(-Inf,0x1.921FB54442D19P+1), trv)

    @test sin_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), com), interval(bareinterval(3.14,Inf), dac)) === interval(bareinterval(0x1.921FB54442D18P+1,Inf), trv)

end

@testset "minimal_cos_rev_test" begin

    @test cos_rev(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(-2.0,-1.1)) === emptyinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(1.1, 2.0)) === emptyinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(-1.0,1.0)) === entireinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(0.0,0.0)) === entireinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53)) === entireinterval(BareInterval{Float64})

end

@testset "minimal_cos_rev_bin_test" begin

    @test cos_rev(emptyinterval(BareInterval{Float64}), bareinterval(-1.2,12.1)) === emptyinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(-2.0,-1.1), bareinterval(-5.0, 5.0)) === emptyinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(1.1, 2.0), bareinterval(-5.0, 5.0)) === emptyinterval(BareInterval{Float64})

    @test cos_rev(bareinterval(-1.0,1.0), bareinterval(-1.2,12.1)) === bareinterval(-1.2,12.1)

    @test cos_rev(bareinterval(1.0,1.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test_broken cos_rev(bareinterval(-1.0,-1.0), bareinterval(3.14,3.15)) === bareinterval(0x1.921fb54442d18p+1,0x1.921fb54442d1ap+1)

    @test cos_rev(bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), bareinterval(1.57,1.58)) === bareinterval(0x1.921FB54442D17P+0,0x1.921FB54442D19P+0)

    @test cos_rev(bareinterval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53), bareinterval(1.57,1.58)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D1AP+0)

    @test cos_rev(bareinterval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54), bareinterval(1.57,1.58)) === bareinterval(0x1.921FB54442D17P+0,0x1.921FB54442D1aP+0)

    @test cos_rev(bareinterval(0x1.1A62633145C06P-54,1.0), bareinterval(-2.0,2.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test cos_rev(bareinterval(0x1.1A62633145C06P-54,1.0), bareinterval(0.0,2.0)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test cos_rev(bareinterval(-0x1.72CECE675D1FDP-53,1.0), bareinterval(-0.1,1.5708)) === bareinterval(-0.1,0x1.921FB54442D1aP+0)

    @test cos_rev(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), bareinterval(3.14,3.15)) === bareinterval(0x1.921fb52442d18p+1,0x1.921fb56442d1ap+1)

    @test cos_rev(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), bareinterval(-3.15,-3.14)) === bareinterval(-0x1.921fb56442d1ap+1,-0x1.921fb52442d18p+1)

    @test cos_rev(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), bareinterval(9.42,9.45)) === bareinterval(0x1.2d97c7eb321d2p+3,0x1.2d97c7fb321d3p+3)

    @test cos_rev(bareinterval(0x1.87996529F9D92P-1,1.0), bareinterval(-1.0,0.1)) === bareinterval(-0x1.6666666666667p-1,0.1)

    @test cos_rev(bareinterval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1), bareinterval(0.0,2.1)) === bareinterval(0x1.fffffffffffffp-1,0x1.0000000000001p+1)

    @test cos_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), bareinterval(-Inf,1.58)) === bareinterval(-Inf,0x1.921FB54442D18P+0)

    @test cos_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), bareinterval(-Inf,1.5)) === bareinterval(-Inf,-0x1.921FB54442D17P+0)

    @test cos_rev(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), bareinterval(-1.58,Inf)) === bareinterval(-0x1.921fb54442d1ap+0,Inf)

    @test cos_rev(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), bareinterval(-1.5,Inf)) === bareinterval(0x1.921fb54442d19p+0,Inf)

end

@testset "minimal_cos_rev_dec_test" begin

    @test cos_rev(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(-2.0,-1.1), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(1.1, 2.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(-1.0,1.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(0.0,0.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_cos_rev_dec_bin_test" begin

    @test cos_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-1.2,12.1), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(-2.0,-1.1), dac), interval(bareinterval(-5.0, 5.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(1.1, 2.0), dac), interval(bareinterval(-5.0, 5.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cos_rev(interval(bareinterval(-1.0,1.0), dac), interval(bareinterval(-1.2,12.1), def)) === interval(bareinterval(-1.2,12.1), trv)

    @test cos_rev(interval(bareinterval(1.0,1.0), def), interval(bareinterval(-0.1,0.1), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test_broken cos_rev(interval(bareinterval(-1.0,-1.0), com), interval(bareinterval(3.14,3.15), dac)) === interval(bareinterval(0x1.921fb54442d18p+1,0x1.921fb54442d1ap+1), trv)

    @test cos_rev(interval(bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), def), interval(bareinterval(1.57,1.58), def)) === interval(bareinterval(0x1.921FB54442D17P+0,0x1.921FB54442D19P+0), trv)

    @test cos_rev(interval(bareinterval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53), dac), interval(bareinterval(1.57,1.58), dac)) === interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D1AP+0), trv)

    @test cos_rev(interval(bareinterval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54), com), interval(bareinterval(1.57,1.58), dac)) === interval(bareinterval(0x1.921FB54442D17P+0,0x1.921FB54442D1aP+0), trv)

    @test cos_rev(interval(bareinterval(0x1.1A62633145C06P-54,1.0), def), interval(bareinterval(-2.0,2.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test cos_rev(interval(bareinterval(0x1.1A62633145C06P-54,1.0), dac), interval(bareinterval(0.0,2.0), def)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test cos_rev(interval(bareinterval(-0x1.72CECE675D1FDP-53,1.0), def), interval(bareinterval(-0.1,1.5708), dac)) === interval(bareinterval(-0.1,0x1.921FB54442D1aP+0), trv)

    @test cos_rev(interval(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), dac), interval(bareinterval(3.14,3.15), def)) === interval(bareinterval(0x1.921fb52442d18p+1,0x1.921fb56442d1ap+1), trv)

    @test cos_rev(interval(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), def), interval(bareinterval(-3.15,-3.14), com)) === interval(bareinterval(-0x1.921fb56442d1ap+1,-0x1.921fb52442d18p+1), trv)

    @test cos_rev(interval(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), def), interval(bareinterval(9.42,9.45), dac)) === interval(bareinterval(0x1.2d97c7eb321d2p+3,0x1.2d97c7fb321d3p+3), trv)

    @test cos_rev(interval(bareinterval(0x1.87996529F9D92P-1,1.0), dac), interval(bareinterval(-1.0,0.1), def)) === interval(bareinterval(-0x1.6666666666667p-1,0.1), trv)

    @test cos_rev(interval(bareinterval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1), com), interval(bareinterval(0.0,2.1), dac)) === interval(bareinterval(0x1.fffffffffffffp-1,0x1.0000000000001p+1), trv)

    @test cos_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com), interval(bareinterval(-Inf,1.58), dac)) === interval(bareinterval(-Inf,0x1.921FB54442D18P+0), trv)

    @test cos_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), def), interval(bareinterval(-Inf,1.5), dac)) === interval(bareinterval(-Inf,-0x1.921FB54442D17P+0), trv)

    @test cos_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), dac), interval(bareinterval(-1.58,Inf), dac)) === interval(bareinterval(-0x1.921fb54442d1ap+0,Inf), trv)

    @test cos_rev(interval(bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), def), interval(bareinterval(-1.5,Inf), dac)) === interval(bareinterval(0x1.921fb54442d19p+0,Inf), trv)

end

@testset "minimal_tan_rev_test" begin

    @test tan_rev(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test tan_rev(bareinterval(-1.0,1.0)) === entireinterval(BareInterval{Float64})

    @test tan_rev(bareinterval(-156.0,-12.0)) === entireinterval(BareInterval{Float64})

    @test tan_rev(bareinterval(0.0,0.0)) === entireinterval(BareInterval{Float64})

    @test tan_rev(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53)) === entireinterval(BareInterval{Float64})

end

@testset "minimal_tan_rev_bin_test" begin

    @test tan_rev(emptyinterval(BareInterval{Float64}), bareinterval(-1.5708,1.5708)) === emptyinterval(BareInterval{Float64})

    @test tan_rev(entireinterval(BareInterval{Float64}), bareinterval(-1.5708,1.5708)) === bareinterval(-1.5708,1.5708)

    @test tan_rev(bareinterval(0.0,0.0), bareinterval(-1.5708,1.5708)) === bareinterval(0.0,0.0)

    @test tan_rev(bareinterval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), bareinterval(-1.5708,1.5708)) === bareinterval(-0x1.921fb54442d1bp+0,0x1.921fb54442d19p+0)

    @test tan_rev(bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), bareinterval(3.14,3.15)) === bareinterval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1)

    @test tan_rev(bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), bareinterval(-3.15,3.15)) === bareinterval(-0x1.921FB54442D19P+1,0x1.921FB54442D1aP+1)

    @test tan_rev(bareinterval(-0x1.D02967C31p+53,0x1.D02967C31p+53), bareinterval(-Inf,1.5707965)) === bareinterval(-Inf, +0x1.921FB82C2BD7Fp0)

    @test tan_rev(bareinterval(-0x1.D02967C31p+53,0x1.D02967C31p+53), bareinterval(-1.5707965,Inf)) === bareinterval(-0x1.921FB82C2BD7Fp0, +Inf)

    @test tan_rev(bareinterval(-0x1.D02967C31p+53,0x1.D02967C31p+53), bareinterval(-1.5707965,1.5707965)) === bareinterval(-0x1.921FB82C2BD7Fp0, +0x1.921FB82C2BD7Fp0)

    @test tan_rev(bareinterval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), bareinterval(-1.5707965,1.5707965)) === bareinterval(-1.5707965,1.5707965)

end

@testset "minimal_tan_rev_dec_test" begin

    @test tan_rev(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test tan_rev(interval(bareinterval(-1.0,1.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan_rev(interval(bareinterval(-156.0,-12.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan_rev(interval(bareinterval(0.0,0.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan_rev(interval(bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com)) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_tan_rev_dec_bin_test" begin

    @test tan_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-1.5708,1.5708), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test tan_rev(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-1.5708,1.5708), dac)) === interval(bareinterval(-1.5708,1.5708), trv)

    @test tan_rev(interval(bareinterval(0.0,0.0), com), interval(bareinterval(-1.5708,1.5708), def)) === interval(bareinterval(0.0,0.0), trv)

    @test tan_rev(interval(bareinterval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), dac), interval(bareinterval(-1.5708,1.5708), def)) === interval(bareinterval(-0x1.921fb54442d1bp+0,0x1.921fb54442d19p+0), trv)

    @test tan_rev(interval(bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), def), interval(bareinterval(3.14,3.15), dac)) === interval(bareinterval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1), trv)

    @test tan_rev(interval(bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), com), interval(bareinterval(-3.15,3.15), com)) === interval(bareinterval(-0x1.921FB54442D19P+1,0x1.921FB54442D1aP+1), trv)

    @test tan_rev(interval(bareinterval(-0x1.D02967C31p+53,0x1.D02967C31p+53), def), interval(bareinterval(-Inf,1.5707965), def)) === interval(bareinterval(-Inf,0x1.921FB82C2BD7Fp0), trv)

    @test tan_rev(interval(bareinterval(-0x1.D02967C31p+53,0x1.D02967C31p+53), com), interval(bareinterval(-1.5707965,Inf), dac)) === interval(bareinterval(-0x1.921FB82C2BD7Fp0,Inf), trv)

    @test tan_rev(interval(bareinterval(-0x1.D02967C31p+53,0x1.D02967C31p+53), com), interval(bareinterval(-1.5707965,1.5707965), com)) === interval(bareinterval(-0x1.921FB82C2BD7Fp0,0x1.921FB82C2BD7Fp0), trv)

    @test tan_rev(interval(bareinterval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), dac), interval(bareinterval(-1.5707965,1.5707965), def)) === interval(bareinterval(-1.5707965,1.5707965), trv)

end

@testset "minimal_cosh_rev_test" begin

    @test cosh_rev(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test cosh_rev(bareinterval(1.0,Inf)) === entireinterval(BareInterval{Float64})

    @test cosh_rev(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test cosh_rev(bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test cosh_rev(bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432)) === bareinterval(-0x1.2C903022DD7ABP+8,0x1.2C903022DD7ABP+8)

end

@testset "minimal_cosh_rev_bin_test" begin

    @test cosh_rev(emptyinterval(BareInterval{Float64}), bareinterval(0.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test cosh_rev(bareinterval(1.0,Inf), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test cosh_rev(bareinterval(0.0,Inf), bareinterval(1.0,2.0)) === bareinterval(1.0,2.0)

    @test cosh_rev(bareinterval(1.0,1.0), bareinterval(1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test cosh_rev(bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), bareinterval(-Inf,0.0)) === bareinterval(-0x1.2C903022DD7ABP+8,-0x1.fffffffffffffp-1)

end

@testset "minimal_cosh_rev_dec_test" begin

    @test cosh_rev(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cosh_rev(interval(bareinterval(1.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cosh_rev(interval(bareinterval(0.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cosh_rev(interval(bareinterval(1.0,1.0), def)) === interval(bareinterval(0.0,0.0), trv)

    @test cosh_rev(interval(bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), com)) === interval(bareinterval(-0x1.2C903022DD7ABP+8,0x1.2C903022DD7ABP+8), trv)

end

@testset "minimal_cosh_rev_dec_bin_test" begin

    @test cosh_rev(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0,Inf), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cosh_rev(interval(bareinterval(1.0,Inf), def), interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test cosh_rev(interval(bareinterval(0.0,Inf), def), interval(bareinterval(1.0,2.0), com)) === interval(bareinterval(1.0,2.0), trv)

    @test cosh_rev(interval(bareinterval(1.0,1.0), dac), interval(bareinterval(1.0,Inf), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cosh_rev(interval(bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), com), interval(bareinterval(-Inf,0.0), dac)) === interval(bareinterval(-0x1.2C903022DD7ABP+8,-0x1.fffffffffffffp-1), trv)

end

@testset "minimal_mul_rev_test" begin

    @test mul_rev(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 2.0)) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test mul_rev(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-2.1, -0.4)) === bareinterval(0x1.999999999999AP-3, 0x1.5P+4)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-2.1, -0.4)) === bareinterval(0x1.999999999999AP-3, Inf)

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-2.1, -0.4)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-2.1, -0.4)) === bareinterval(-Inf, -0x1.745D1745D1745P-2)

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-2.1, -0.4)) === bareinterval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-2.1, -0.4)) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-2.1, -0.4)) === bareinterval(0.0, 0x1.5P+4)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-2.1, -0.4)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-2.1, -0.4)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-2.1, -0.4)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-2.1, -0.4)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-2.1, -0.4)) === bareinterval(-0x1.A400000000001P+7, 0.0)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-2.1, -0.4)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.0)) === bareinterval(0.0, 0x1.5P+4)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.0)) === bareinterval(-0x1.A400000000001P+7, 0.0)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.0)) === bareinterval(0.0, 0x1.5P+4)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-2.1, 0.0)) === bareinterval(-0x1.A400000000001P+7, 0.0)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.12)) === bareinterval(-0x1.3333333333333P+0, 0x1.5P+4)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.12)) === bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.12)) === bareinterval(-0x1.3333333333333P+0, 0x1.5P+4)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-2.1, 0.12)) === bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.12)) === bareinterval(-0x1.3333333333333P+0, 0.0)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(0.0, 0.12)) === bareinterval(0.0, 0x1.8P+3)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.12)) === bareinterval(-0x1.3333333333333P+0, 0.0)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(0.0, 0.12)) === bareinterval(0.0, 0x1.8P+3)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(0.01, 0.12)) === bareinterval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(0.01, 0.12)) === bareinterval(-Inf, -0x1.47AE147AE147BP-8)

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(0.01, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(0.01, 0.12)) === bareinterval(0x1.29E4129E4129DP-7, Inf)

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(0.01, 0.12)) === bareinterval(0x1.29E4129E4129DP-7, 0x1.8P+3)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(0.01, 0.12)) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(0.01, 0.12)) === bareinterval(-0x1.3333333333333P+0, 0.0)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(0.01, 0.12)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(0.01, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(0.01, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(0.01, 0.12)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(0.01, 0.12)) === bareinterval(0.0, 0x1.8P+3)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(0.01, 0.12)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-Inf, -0.1)) === bareinterval(0x1.999999999999AP-5, Inf)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-Inf, -0.1)) === bareinterval(0x1.999999999999AP-5 , Inf)

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-Inf, -0.1)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-Inf, -0.1)) === bareinterval(-Inf, -0x1.745D1745D1745P-4)

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-Inf, -0.1)) === bareinterval(-Inf, -0x1.745D1745D1745P-4)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-Inf, -0.1)) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-Inf, -0.1)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-Inf, -0.1)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-Inf, -0.1)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-Inf, -0.1)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-Inf, -0.1)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-Inf, -0.1)) === bareinterval(-Inf, 0.0)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.1)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.0)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.0)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.3)) === bareinterval(-0x1.8P+1, Inf)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.3)) === bareinterval(-Inf, 0x1.EP+4)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.3)) === bareinterval(-0x1.8P+1, Inf)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-Inf, 0.3)) === bareinterval(-Inf, 0x1.EP+4)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.3)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-0.21, Inf)) === bareinterval(-Inf , 0x1.0CCCCCCCCCCCDP+1)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-0.21, Inf)) === bareinterval(-0x1.5P+4, Inf)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(-0.21, Inf)) === bareinterval(-Inf, 0x1.0CCCCCCCCCCCDP+1)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(-0.21, Inf)) === bareinterval(-0x1.5P+4, Inf)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(-0.21, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(0.0, Inf)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(0.0, Inf)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(0.04, Inf)) === bareinterval(-Inf, -0x1.47AE147AE147BP-6)

    @test mul_rev(bareinterval(-2.0, 0.0), bareinterval(0.04, Inf)) === bareinterval(-Inf, -0x1.47AE147AE147BP-6)

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(0.04, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), bareinterval(0.04, Inf)) === bareinterval(0x1.29E4129E4129DP-5, Inf)

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(0.04, Inf)) === bareinterval(0x1.29E4129E4129DP-5, Inf)

    @test mul_rev(bareinterval(0.0, 0.0), bareinterval(0.04, Inf)) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(0.04, Inf)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(-Inf, 0.0), bareinterval(0.04, Inf)) === bareinterval(-Inf, 0.0)

    @test mul_rev(bareinterval(-Inf, 1.1), bareinterval(0.04, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), bareinterval(0.04, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), bareinterval(0.04, Inf)) === bareinterval(0.0, Inf)

    @test mul_rev(bareinterval(0.01, Inf), bareinterval(0.04, Inf)) === bareinterval(0.0, Inf)

    @test mul_rev(entireinterval(BareInterval{Float64}), bareinterval(0.04, Inf)) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 1.1), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, 1.1), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, -0.1), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-Inf, 1.1), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(0.01, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test mul_rev(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

end

@testset "minimal_mul_rev_ten_test" begin

    @test mul_rev(bareinterval(-2.0, -0.1), bareinterval(-2.1, -0.4), bareinterval(-2.1, -0.4)) === emptyinterval(BareInterval{Float64})

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(-2.1, -0.4), bareinterval(-2.1, -0.4)) === bareinterval(-2.1, -0.4)

    @test mul_rev(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.0), bareinterval(-2.1, 0.0)) === bareinterval(-2.1,0.0)

    @test mul_rev(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.12), bareinterval(0.0, 0.12)) === bareinterval(0.0, 0.0)

    @test mul_rev(bareinterval(-2.0, 1.1), bareinterval(0.04, Inf), bareinterval(0.04, Inf)) === bareinterval(0.04, Inf)

end

@testset "minimal_mul_rev_dec_test" begin

    @test mul_rev(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), dac)) === nai(Interval{Float64})

    @test mul_rev(interval(bareinterval(1.0,2.0), dac), nai(Interval{Float64})) === nai(Interval{Float64})

    @test mul_rev(nai(Interval{Float64}), nai(Interval{Float64})) === nai(Interval{Float64})

    @test mul_rev(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-2.1, -0.4), dac)) === interval(bareinterval(0x1.999999999999AP-3, 0x1.5P+4), trv)

    @test mul_rev(interval(bareinterval(-2.0, -0.1), def), interval(bareinterval(-2.1, 0.0), def)) === interval(bareinterval(0.0, 0x1.5P+4), trv)

    @test mul_rev(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(-2.1, 0.12), dac)) === interval(bareinterval(-0x1.3333333333333P+0, 0x1.5P+4), trv)

    @test mul_rev(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, 0.12), com)) === interval(bareinterval(-0x1.3333333333333P+0, 0.0), trv)

    @test mul_rev(interval(bareinterval(0.01, 1.1), def), interval(bareinterval(0.01, 0.12), dac)) === interval(bareinterval(0x1.29E4129E4129DP-7, 0x1.8P+3), trv)

    @test mul_rev(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, 0.3), def)) === interval(bareinterval(-Inf, 0x1.EP+4), trv)

    @test mul_rev(interval(bareinterval(-Inf, -0.1), trv), interval(bareinterval(-0.21, Inf), dac)) === interval(bareinterval(-Inf, 0x1.0CCCCCCCCCCCDP+1), trv)

end

@testset "minimal_mul_rev_dec_ten_test" begin

    @test mul_rev(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-2.1, -0.4), dac), interval(bareinterval(-2.1, -0.4), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test mul_rev(interval(bareinterval(-2.0, 1.1), def), interval(bareinterval(-2.1, -0.4), com), interval(bareinterval(-2.1, -0.4), com)) === interval(bareinterval(-2.1, -0.4), trv)

    @test mul_rev(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(-2.1, 0.0), dac), interval(bareinterval(-2.1, 0.0), dac)) === interval(bareinterval(-2.1,0.0), trv)

    @test mul_rev(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, 0.12), com), interval(bareinterval(0.0, 0.12), com)) === interval(bareinterval(0.0, 0.0), trv)

    @test mul_rev(interval(bareinterval(-2.0, 1.1), def), interval(bareinterval(0.04, Inf), dac), interval(bareinterval(0.04, Inf), dac)) === interval(bareinterval(0.04, Inf), trv)

end
