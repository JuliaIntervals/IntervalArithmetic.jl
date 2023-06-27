@testset "minimal_sqr_rev_test" begin

    @test sqr_rev(emptyinterval())[2] === emptyinterval()

    @test sqr_rev(interval(-10.0,-1.0))[2] === emptyinterval()

    @test sqr_rev(interval(0.0,Inf))[2] === entireinterval()

    @test sqr_rev(interval(0.0,1.0))[2] === interval(-1.0,1.0)

    @test sqr_rev(interval(-0.5,1.0))[2] === interval(-1.0,1.0)

    @test sqr_rev(interval(-1000.0,1.0))[2] === interval(-1.0,1.0)

    @test sqr_rev(interval(0.0,25.0))[2] === interval(-5.0,5.0)

    @test sqr_rev(interval(-1.0,25.0))[2] === interval(-5.0,5.0)

    @test sqr_rev(interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7))[2] === interval(-0x1.999999999999BP-4,0x1.999999999999BP-4)

    @test sqr_rev(interval(0.0,0x1.FFFFFFFFFFFE1P+1))[2] === interval(-0x1.ffffffffffff1p+0,0x1.ffffffffffff1p+0)


end

@testset "minimal_sqr_rev_bin_test" begin

    @test sqr_rev(emptyinterval(), interval(-5.0,1.0))[2] === emptyinterval()

    @test sqr_rev(interval(-10.0,-1.0), interval(-5.0,1.0))[2] === emptyinterval()

    @test sqr_rev(interval(0.0,Inf), interval(-5.0,1.0))[2] === interval(-5.0,1.0)

    @test sqr_rev(interval(0.0,1.0), interval(-0.1,1.0))[2] === interval(-0.1,1.0)

    @test sqr_rev(interval(-0.5,1.0), interval(-0.1,1.0))[2] === interval(-0.1,1.0)

    @test sqr_rev(interval(-1000.0,1.0), interval(-0.1,1.0))[2] === interval(-0.1,1.0)

    @test sqr_rev(interval(0.0,25.0), interval(-4.1,6.0))[2] === interval(-4.1,5.0)

    @test sqr_rev(interval(-1.0,25.0), interval(-4.1,7.0))[2] === interval(-4.1,5.0)

    @test sqr_rev(interval(1.0,25.0), interval(0.0,7.0))[2] === interval(1.0,5.0)

    @test sqr_rev(interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), interval(-0.1,Inf))[2] === interval(-0.1,0x1.999999999999BP-4)

    @test sqr_rev(interval(0.0,0x1.FFFFFFFFFFFE1P+1), interval(-0.1,Inf))[2] === interval(-0.1,0x1.ffffffffffff1p+0)


end

@testset "minimal_sqr_rev_dec_test" begin

    @test sqr_rev(DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sqr_rev(DecoratedInterval(interval(-10.0,-1.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,Inf), dac))[2] === DecoratedInterval(entireinterval(), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,1.0), def))[2] === DecoratedInterval(interval(-1.0,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(-0.5,1.0), dac))[2] === DecoratedInterval(interval(-1.0,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(-1000.0,1.0), com))[2] === DecoratedInterval(interval(-1.0,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,25.0), def))[2] === DecoratedInterval(interval(-5.0,5.0), trv)

    @test sqr_rev(DecoratedInterval(interval(-1.0,25.0), dac))[2] === DecoratedInterval(interval(-5.0,5.0), trv)

    @test sqr_rev(DecoratedInterval(interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), com))[2] === DecoratedInterval(interval(-0x1.999999999999BP-4,0x1.999999999999BP-4), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,0x1.FFFFFFFFFFFE1P+1), def))[2] === DecoratedInterval(interval(-0x1.ffffffffffff1p+0,0x1.ffffffffffff1p+0), trv)


end

@testset "minimal_sqr_rev_dec_bin_test" begin

    @test sqr_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-5.0,1.0), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sqr_rev(DecoratedInterval(interval(-10.0,-1.0), com), DecoratedInterval(interval(-5.0,1.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,Inf), def), DecoratedInterval(interval(-5.0,1.0), dac))[2] === DecoratedInterval(interval(-5.0,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,1.0), dac), DecoratedInterval(interval(-0.1,1.0), def))[2] === DecoratedInterval(interval(-0.1,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(-0.5,1.0), def), DecoratedInterval(interval(-0.1,1.0), dac))[2] === DecoratedInterval(interval(-0.1,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(-1000.0,1.0), com), DecoratedInterval(interval(-0.1,1.0), def))[2] === DecoratedInterval(interval(-0.1,1.0), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,25.0), def), DecoratedInterval(interval(-4.1,6.0), com))[2] === DecoratedInterval(interval(-4.1,5.0), trv)

    @test sqr_rev(DecoratedInterval(interval(-1.0,25.0), dac), DecoratedInterval(interval(-4.1,7.0), def))[2] === DecoratedInterval(interval(-4.1,5.0), trv)

    @test sqr_rev(DecoratedInterval(interval(1.0,25.0), dac), DecoratedInterval(interval(0.0,7.0), def))[2] === DecoratedInterval(interval(1.0,5.0), trv)

    @test sqr_rev(DecoratedInterval(interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), def), DecoratedInterval(interval(-0.1,Inf), dac))[2] === DecoratedInterval(interval(-0.1,0x1.999999999999BP-4), trv)

    @test sqr_rev(DecoratedInterval(interval(0.0,0x1.FFFFFFFFFFFE1P+1), dac), DecoratedInterval(interval(-0.1,Inf), dac))[2] === DecoratedInterval(interval(-0.1,0x1.ffffffffffff1p+0), trv)


end

@testset "minimal_abs_rev_test" begin

    @test abs_rev(emptyinterval())[2] === emptyinterval()

    @test abs_rev(interval(-1.1,-0.4))[2] === emptyinterval()

    @test abs_rev(interval(0.0,Inf))[2] === entireinterval()

    @test abs_rev(interval(1.1,2.1))[2] === interval(-2.1,2.1)

    @test abs_rev(interval(-1.1,2.0))[2] === interval(-2.0,2.0)

    @test abs_rev(interval(-1.1,0.0))[2] === interval(0.0,0.0)

    @test abs_rev(interval(-1.9,0.2))[2] === interval(-0.2,0.2)

    @test abs_rev(interval(0.0,0.2))[2] === interval(-0.2,0.2)


    @test abs_rev(interval(-1.5,Inf))[2] === entireinterval()

end

@testset "minimal_abs_rev_bin_test" begin

    @test abs_rev(emptyinterval(), interval(-1.1,5.0))[2] === emptyinterval()

    @test abs_rev(interval(-1.1,-0.4), interval(-1.1,5.0))[2] === emptyinterval()

    @test abs_rev(interval(0.0,Inf), interval(-1.1,5.0))[2] === interval(-1.1,5.0)

    @test abs_rev(interval(1.1,2.1), interval(-1.0,5.0))[2] === interval(1.1,2.1)

    @test abs_rev(interval(-1.1,2.0), interval(-1.1,5.0))[2] === interval(-1.1,2.0)

    @test abs_rev(interval(-1.1,0.0), interval(-1.1,5.0))[2] === interval(0.0,0.0)

    @test abs_rev(interval(-1.9,0.2), interval(-1.1,5.0))[2] === interval(-0.2,0.2)


end

@testset "minimal_abs_rev_dec_test" begin

    @test abs_rev(DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test abs_rev(DecoratedInterval(interval(-1.1,-0.4), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test abs_rev(DecoratedInterval(interval(0.0,Inf), dac))[2] === DecoratedInterval(entireinterval(), trv)

    @test abs_rev(DecoratedInterval(interval(1.1,2.1), com))[2] === DecoratedInterval(interval(-2.1,2.1), trv)

    @test abs_rev(DecoratedInterval(interval(-1.1,2.0), def))[2] === DecoratedInterval(interval(-2.0,2.0), trv)

    @test abs_rev(DecoratedInterval(interval(-1.1,0.0), dac))[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test abs_rev(DecoratedInterval(interval(-1.9,0.2), com))[2] === DecoratedInterval(interval(-0.2,0.2), trv)

    @test abs_rev(DecoratedInterval(interval(0.0,0.2), def))[2] === DecoratedInterval(interval(-0.2,0.2), trv)


    @test abs_rev(DecoratedInterval(interval(-1.5,Inf), def))[2] === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_abs_rev_dec_bin_test" begin

    @test abs_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-1.1,5.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test abs_rev(DecoratedInterval(interval(-1.1,-0.4), dac), DecoratedInterval(interval(-1.1,5.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test abs_rev(DecoratedInterval(interval(0.0,Inf), def), DecoratedInterval(interval(-1.1,5.0), def))[2] === DecoratedInterval(interval(-1.1,5.0), trv)

    @test abs_rev(DecoratedInterval(interval(1.1,2.1), dac), DecoratedInterval(interval(-1.0,5.0), def))[2] === DecoratedInterval(interval(1.1,2.1), trv)

    @test abs_rev(DecoratedInterval(interval(-1.1,2.0), com), DecoratedInterval(interval(-1.1,5.0), def))[2] === DecoratedInterval(interval(-1.1,2.0), trv)

    @test abs_rev(DecoratedInterval(interval(-1.1,0.0), def), DecoratedInterval(interval(-1.1,5.0), def))[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test abs_rev(DecoratedInterval(interval(-1.9,0.2), dac), DecoratedInterval(interval(-1.1,5.0), def))[2] === DecoratedInterval(interval(-0.2,0.2), trv)


end

@testset "minimal_pown_rev_test" begin

    @test power_rev(emptyinterval(), 0)[2] === emptyinterval()

    @test power_rev(interval(1.0,1.0), 0)[2] === entireinterval()

    @test power_rev(interval(-1.0,5.0), 0)[2] === entireinterval()

    @test power_rev(interval(-1.0,0.0), 0)[2] === emptyinterval()

    @test power_rev(interval(-1.0,-0.0), 0)[2] === emptyinterval()

    @test power_rev(interval(1.1,10.0), 0)[2] === emptyinterval()

    @test power_rev(emptyinterval(), 1)[2] === emptyinterval()

    @test power_rev(entireinterval(), 1)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), 1)[2] === interval(0.0,0.0)

    @test power_rev(interval(-0.0,-0.0), 1)[2] === interval(0.0,0.0)

    @test power_rev(interval(13.1,13.1), 1)[2] === interval(13.1,13.1)

    @test power_rev(interval(-7451.145,-7451.145), 1)[2] === interval(-7451.145,-7451.145)

    @test power_rev(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1)[2] === interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)

    @test power_rev(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1)[2] === interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)

    @test power_rev(interval(0.0,Inf), 1)[2] === interval(0.0,Inf)

    @test power_rev(interval(-0.0,Inf), 1)[2] === interval(0.0,Inf)

    @test power_rev(interval(-Inf,0.0), 1)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-Inf,-0.0), 1)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-324.3,2.5), 1)[2] === interval(-324.3,2.5)

    @test power_rev(interval(0.01,2.33), 1)[2] === interval(0.01,2.33)

    @test power_rev(interval(-1.9,-0.33), 1)[2] === interval(-1.9,-0.33)


    @test power_rev(emptyinterval(), 2)[2] === emptyinterval()

    @test power_rev(interval(-5.0,-1.0), 2)[2] === emptyinterval()

    @test power_rev(interval(0.0,Inf), 2)[2] === entireinterval()

    @test power_rev(interval(-0.0,Inf), 2)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), 2)[2] === interval(0.0,0.0)

    @test power_rev(interval(-0.0,-0.0), 2)[2] === interval(0.0,0.0)

    @test power_rev(interval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7), 2)[2] === interval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test power_rev(interval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25), 2)[2] === interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test power_rev(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2)[2] === interval(-0x1p+512,0x1p+512)

    @test power_rev(interval(0.0,0x1.9AD27D70A3D72P+16), 2)[2] === interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test power_rev(interval(-0.0,0x1.9AD27D70A3D72P+16), 2)[2] === interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test power_rev(interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), 2)[2] === interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), 2)[2] === interval(-0x1.e666666666667p+0,0x1.e666666666667p+0)


    @test power_rev(emptyinterval(), 8)[2] === emptyinterval()

    @test power_rev(entireinterval(), 8)[2] === entireinterval()

    @test power_rev(interval(0.0,Inf), 8)[2] === entireinterval()

    @test power_rev(interval(-0.0,Inf), 8)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), 8)[2] === interval(0.0,0.0)

    @test power_rev(interval(-0.0,-0.0), 8)[2] === interval(0.0,0.0)

    @test power_rev(interval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29), 8)[2] === interval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test power_rev(interval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102), 8)[2] === interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test power_rev(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8)[2] === interval(-0x1p+128,0x1p+128)

    @test power_rev(interval(0.0,0x1.A87587109655P+66), 8)[2] === interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test power_rev(interval(-0.0,0x1.A87587109655P+66), 8)[2] === interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test power_rev(interval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9), 8)[2] === interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7), 8)[2] === interval(-0x1.e666666666667p+0,0x1.e666666666667p+0)


    @test power_rev(emptyinterval(), 3)[2] === emptyinterval()

    @test power_rev(entireinterval(), 3)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), 3)[2] === interval(0.0,0.0)

    @test power_rev(interval(-0.0,-0.0), 3)[2] === interval(0.0,0.0)

    @test power_rev(interval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11), 3)[2] === interval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test power_rev(interval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38), 3)[2] === interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test power_rev(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3)[2] === interval(0x1.428a2f98d728ap+341,0x1.428a2f98d728bp+341)

    @test power_rev(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3)[2] === interval(-0x1.428a2f98d728bp+341, -0x1.428a2f98d728ap+341)

    @test power_rev(interval(0.0,Inf), 3)[2] === interval(0.0,Inf)

    @test power_rev(interval(-0.0,Inf), 3)[2] === interval(0.0,Inf)

    @test power_rev(interval(-Inf,0.0), 3)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-Inf,-0.0), 3)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-0x1.0436D2F418938P+25,0x1.F4P+3), 3)[2] === interval(-0x1.444cccccccccep+8,0x1.4p+1)

    @test power_rev(interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), 3)[2] === interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), 3)[2] === interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)


    @test power_rev(emptyinterval(), 7)[2] === emptyinterval()

    @test power_rev(entireinterval(), 7)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), 7)[2] === interval(0.0,0.0)

    @test power_rev(interval(-0.0,-0.0), 7)[2] === interval(0.0,0.0)

    @test power_rev(interval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25), 7)[2] === interval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test power_rev(interval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90), 7)[2] === interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test power_rev(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7)[2] === interval(0x1.381147622f886p+146,0x1.381147622f887p+146)

    @test power_rev(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7)[2] === interval(-0x1.381147622f887p+146,-0x1.381147622f886p+146)

    @test power_rev(interval(0.0,Inf), 7)[2] === interval(0.0,Inf)

    @test power_rev(interval(-0.0,Inf), 7)[2] === interval(0.0,Inf)

    @test power_rev(interval(-Inf,0.0), 7)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-Inf,-0.0), 7)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-0x1.4F109959E6D7FP+58,0x1.312DP+9), 7)[2] === interval(-0x1.444cccccccccep+8,0x1.4p+1)

    @test power_rev(interval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8), 7)[2] === interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12), 7)[2] === interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)


    @test power_rev(emptyinterval(), -2)[2] === emptyinterval()

    @test power_rev(interval(0.0,Inf), -2)[2] === entireinterval()

    @test power_rev(interval(-0.0,Inf), -2)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), -2)[2] === emptyinterval()

    @test power_rev(interval(-0.0,-0.0), -2)[2] === emptyinterval()

    @test power_rev(interval(-10.0,0.0), -2)[2] === emptyinterval()

    @test power_rev(interval(-10.0,-0.0), -2)[2] === emptyinterval()

    @test power_rev(interval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8), -2)[2] === interval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test power_rev(interval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26), -2)[2] === interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test power_rev(interval(0x0P+0,0x0.0000000000001P-1022), -2)[2] === entireinterval()

    @test power_rev(interval(0x1.3F0C482C977C9P-17,Inf), -2)[2] === interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test power_rev(interval(0x1.793D85EF38E47P-3,0x1.388P+13), -2)[2] === interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), -2)[2] === interval(-0x1.e666666666667p+0,0x1.e666666666667p+0)


    @test power_rev(emptyinterval(), -8)[2] === emptyinterval()

    @test power_rev(interval(0.0,Inf), -8)[2] === entireinterval()

    @test power_rev(interval(-0.0,Inf), -8)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), -8)[2] === emptyinterval()

    @test power_rev(interval(-0.0,-0.0), -8)[2] === emptyinterval()

    @test power_rev(interval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30), -8)[2] === interval(-0x1.a333333333334p+3,0x1.a333333333334p+3)

    @test power_rev(interval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103), -8)[2] === interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12)

    @test power_rev(interval(0x0P+0,0x0.0000000000001P-1022), -8)[2] === entireinterval()

    @test power_rev(interval(0x1.34CC3764D1E0CP-67,Inf), -8)[2] === interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8)

    @test power_rev(interval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53), -8)[2] === interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12), -8)[2] === interval(-0x1.e666666666667p+0,0x1.e666666666667p+0)


    @test power_rev(emptyinterval(), -1)[2] === emptyinterval()

    @test power_rev(entireinterval(), -1)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), -1)[2] === emptyinterval()

    @test power_rev(interval(-0.0,-0.0), -1)[2] === emptyinterval()

    @test power_rev(interval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4), -1)[2] === interval(0x1.a333333333332p+3,0x1.a333333333335p+3)

    @test power_rev(interval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13), -1)[2] === interval(-0x1.d1b251eb851eep+12,-0x1.d1b251eb851ebp+12)

    @test power_rev(interval(0x0.4P-1022,0x0.4000000000001P-1022), -1)[2] === interval(0x1.ffffffffffff8p+1023,Inf)

    @test power_rev(interval(-0x0.4000000000001P-1022,-0x0.4P-1022), -1)[2] === interval(-Inf,-0x1.ffffffffffff8p+1023)

    @test power_rev(interval(0.0,Inf), -1)[2] === interval(0.0,Inf)

    @test power_rev(interval(-0.0,Inf), -1)[2] === interval(0.0,Inf)

    @test power_rev(interval(-Inf,0.0), -1)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-Inf,-0.0), -1)[2] === interval(-Inf,0.0)

    @test power_rev(interval(0x1.B77C278DBBE13P-2,0x1.9P+6), -1)[2] === interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1), -1)[2] === interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)


    @test power_rev(emptyinterval(), -3)[2] === emptyinterval()

    @test power_rev(entireinterval(), -3)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), -3)[2] === emptyinterval()

    @test power_rev(interval(-0.0,-0.0), -3)[2] === emptyinterval()

    @test power_rev(interval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12), -3)[2] === interval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test power_rev(interval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39), -3)[2] === interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test power_rev(interval(0x0P+0,0x0.0000000000001P-1022), -3)[2] === interval(0x1p+358,Inf)

    @test power_rev(interval(-0x0.0000000000001P-1022,-0x0P+0), -3)[2] === interval(-Inf,-0x1p+358)

    @test power_rev(interval(0.0,Inf), -3)[2] === interval(0.0,Inf)

    @test power_rev(interval(-0.0,Inf), -3)[2] === interval(0.0,Inf)

    @test power_rev(interval(-Inf,0.0), -3)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-Inf,-0.0), -3)[2] === interval(-Inf,0.0)

    @test power_rev(interval(0x1.43CFBA61AACABP-4,0x1.E848P+19), -3)[2] === interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3), -3)[2] === interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)


    @test power_rev(emptyinterval(), -7)[2] === emptyinterval()

    @test power_rev(entireinterval(), -7)[2] === entireinterval()

    @test power_rev(interval(0.0,0.0), -7)[2] === emptyinterval()

    @test power_rev(interval(-0.0,-0.0), -7)[2] === emptyinterval()

    @test power_rev(interval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26), -7)[2] === interval(0x1.a333333333332p+3,0x1.a333333333334p+3)

    @test power_rev(interval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91), -7)[2] === interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12)

    @test_broken power_rev(interval(0x0P+0,0x0.0000000000001P-1022), -7)[2] === interval(0x1.588cea3f093bcp+153,Inf)

    @test_broken power_rev(interval(-0x0.0000000000001P-1022,-0x0P+0), -7)[2] === interval(-Inf,-0x1.588cea3f093bcp+153)

    @test power_rev(interval(0.0,Inf), -7)[2] === interval(0.0,Inf)

    @test power_rev(interval(-0.0,Inf), -7)[2] === interval(0.0,Inf)

    @test power_rev(interval(-Inf,0.0), -7)[2] === interval(-Inf,0.0)

    @test power_rev(interval(-Inf,-0.0), -7)[2] === interval(-Inf,0.0)

    @test power_rev(interval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46), -7)[2] === interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7), -7)[2] === interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2)


end

@testset "minimal_pown_rev_bin_test" begin

    @test power_rev(emptyinterval(), interval(1.0,1.0), 0)[2] === emptyinterval()

    @test power_rev(interval(1.0,1.0), interval(1.0,1.0), 0)[2] === interval(1.0,1.0)

    @test power_rev(interval(-1.0,5.0), interval(-51.0,12.0), 0)[2] === interval(-51.0,12.0)


    @test power_rev(interval(-1.0,0.0), interval(5.0,10.0), 0)[2] === emptyinterval()

    @test power_rev(interval(-1.0,-0.0), interval(-1.0,1.0), 0)[2] === emptyinterval()

    @test power_rev(interval(1.1,10.0), interval(1.0,41.0), 0)[2] === emptyinterval()

    @test power_rev(emptyinterval(), interval(0.0,100.1), 1)[2] === emptyinterval()

    @test power_rev(entireinterval(), interval(-5.1,10.0), 1)[2] === interval(-5.1,10.0)

    @test power_rev(interval(0.0,0.0), interval(-10.0,5.1), 1)[2] === interval(0.0,0.0)


    @test power_rev(interval(-0.0,-0.0), interval(1.0,5.0), 1)[2] === emptyinterval()

    @test power_rev(emptyinterval(), interval(5.0,17.1), 2)[2] === emptyinterval()

    @test power_rev(interval(-5.0,-1.0), interval(5.0,17.1), 2)[2] === emptyinterval()

    @test power_rev(interval(0.0,Inf), interval(5.6,27.544), 2)[2] === interval(5.6,27.544)

    @test power_rev(interval(0.0,0.0), interval(1.0,2.0), 2)[2] === emptyinterval()

    @test power_rev(interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), interval(1.0,Inf), 2)[2] === interval(1.0,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), interval(-Inf,-1.0), 2)[2] === interval(-0x1.e666666666667p+0,-1.0)

    @test power_rev(emptyinterval(), interval(-23.0,-1.0), 3)[2] === emptyinterval()

    @test power_rev(entireinterval(), interval(-23.0,-1.0), 3)[2] === interval(-23.0,-1.0)

    @test power_rev(interval(0.0,0.0), interval(1.0,2.0), 3)[2] === emptyinterval()

    @test power_rev(interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), interval(1.0,Inf), 3)[2] === interval(1.0,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), interval(-Inf,-1.0), 3)[2] === interval(-0x1.e666666666667p+0,-1.0)

    @test power_rev(emptyinterval(), interval(-3.0,17.3), -2)[2] === emptyinterval()

    @test power_rev(interval(0.0,Inf), interval(-5.1,-0.1), -2)[2] === interval(-5.1,-0.1)


    @test power_rev(interval(0.0,0.0), interval(27.2,55.1), -2)[2] === emptyinterval()

    @test power_rev(interval(0x1.3F0C482C977C9P-17,Inf), interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), -2)[2] === emptyinterval()

    @test power_rev(interval(0x1.793D85EF38E47P-3,0x1.388P+13), interval(1.0,Inf), -2)[2] === interval(1.0,0x1.2a3d70a3d70a5p+1)

    @test power_rev(interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), interval(-Inf,-1.0), -2)[2] === interval(-0x1.e666666666667p+0,-1.0)

    @test power_rev(emptyinterval(), interval(-5.1,55.5), -1)[2] === emptyinterval()

    @test power_rev(entireinterval(), interval(-5.1,55.5), -1)[2] === interval(-5.1,55.5)

    @test power_rev(interval(0.0,0.0), interval(-5.1,55.5), -1)[2] === emptyinterval()

    @test power_rev(interval(-Inf,-0.0), interval(-1.0,1.0), -1)[2] === interval(-1.0,0.0)


    @test power_rev(interval(0x1.B77C278DBBE13P-2,0x1.9P+6), interval(-1.0,0.0), -1)[2] === emptyinterval()

    @test power_rev(emptyinterval(), interval(-5.1,55.5), -3)[2] === emptyinterval()

    @test power_rev(entireinterval(), interval(-5.1,55.5), -3)[2] === interval(-5.1,55.5)


    @test power_rev(interval(0.0,0.0), interval(-5.1,55.5), -3)[2] === emptyinterval()

    @test power_rev(interval(-Inf,0.0), interval(5.1,55.5), -3)[2] === emptyinterval()

    @test power_rev(interval(-Inf,-0.0), interval(-32.0,1.1), -3)[2] === interval(-32.0,0.0)


end

@testset "minimal_pown_rev_dec_test" begin

    @test power_rev(DecoratedInterval(emptyinterval(), trv), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(1.0,1.0), com), 0)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-1.0,5.0), dac), 0)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-1.0,0.0), def), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-1.0,-0.0), dac), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(1.1,10.0), com), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), 1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), 1)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), com), 1)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), 1)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(13.1,13.1), def), 1)[2] === DecoratedInterval(interval(13.1,13.1), trv)

    @test power_rev(DecoratedInterval(interval(-7451.145,-7451.145), dac), 1)[2] === DecoratedInterval(interval(-7451.145,-7451.145), trv)

    @test power_rev(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), 1)[2] === DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com), 1)[2] === DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), 1)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), 1)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), def), 1)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), def), 1)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-324.3,2.5), dac), 1)[2] === DecoratedInterval(interval(-324.3,2.5), trv)

    @test power_rev(DecoratedInterval(interval(0.01,2.33), com), 1)[2] === DecoratedInterval(interval(0.01,2.33), trv)

    @test power_rev(DecoratedInterval(interval(-1.9,-0.33), def), 1)[2] === DecoratedInterval(interval(-1.9,-0.33), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), 2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), 2)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), def), 2)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), com), 2)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), 2)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7), def), 2)[2] === DecoratedInterval(interval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25), def), 2)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), 2)[2] === DecoratedInterval(interval(-0x1p+512,0x1p+512), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0x1.9AD27D70A3D72P+16), dac), 2)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,0x1.9AD27D70A3D72P+16), def), 2)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test power_rev(DecoratedInterval(interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), com), 2)[2] === DecoratedInterval(interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), def), 2)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), 8)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), 8)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), 8)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), 8)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), 8)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), 8)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29), com), 8)[2] === DecoratedInterval(interval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102), dac), 8)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), def), 8)[2] === DecoratedInterval(interval(-0x1p+128,0x1p+128), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0x1.A87587109655P+66), dac), 8)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,0x1.A87587109655P+66), def), 8)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test power_rev(DecoratedInterval(interval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9), com), 8)[2] === DecoratedInterval(interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7), dac), 8)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), 3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), 3)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), dac), 3)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), def), 3)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11), com), 3)[2] === DecoratedInterval(interval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38), def), 3)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), 3)[2] === DecoratedInterval(interval(0x1.428a2f98d728ap+341,0x1.428a2f98d728bp+341), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com), 3)[2] === DecoratedInterval(interval(-0x1.428a2f98d728bp+341, -0x1.428a2f98d728ap+341), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), def), 3)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), def), 3)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), dac), 3)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), def), 3)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.0436D2F418938P+25,0x1.F4P+3), com), 3)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.4p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), dac), 3)[2] === DecoratedInterval(interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), def), 3)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), 7)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), 7)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), com), 7)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), 7)[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25), def), 7)[2] === DecoratedInterval(interval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90), dac), 7)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), 7)[2] === DecoratedInterval(interval(0x1.381147622f886p+146,0x1.381147622f887p+146), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), def), 7)[2] === DecoratedInterval(interval(-0x1.381147622f887p+146,-0x1.381147622f886p+146), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), 7)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), 7)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), def), 7)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), def), 7)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.4F109959E6D7FP+58,0x1.312DP+9), dac), 7)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.4p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8), com), 7)[2] === DecoratedInterval(interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12), def), 7)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), -2)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), -2)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), com), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-10.0,0.0), dac), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-10.0,-0.0), def), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8), dac), -2)[2] === DecoratedInterval(interval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26), def), -2)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x0P+0,0x0.0000000000001P-1022), com), -2)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.3F0C482C977C9P-17,Inf), dac), -2)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test power_rev(DecoratedInterval(interval(0x1.793D85EF38E47P-3,0x1.388P+13), def), -2)[2] === DecoratedInterval(interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), com), -2)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), -8)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), def), -8)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), -8)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), -8)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), -8)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30), com), -8)[2] === DecoratedInterval(interval(-0x1.a333333333334p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103), def), -8)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,0x1.d1b251eb851edp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x0P+0,0x0.0000000000001P-1022), dac), -8)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.34CC3764D1E0CP-67,Inf), def), -8)[2] === DecoratedInterval(interval(-0x1.444cccccccccep+8,0x1.444cccccccccep+8), trv)

    @test power_rev(DecoratedInterval(interval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53), com), -8)[2] === DecoratedInterval(interval(-0x1.2a3d70a3d70a5p+1,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12), def), -8)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,0x1.e666666666667p+0), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), -1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), -1)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), dac), -1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), -1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4), def), -1)[2] === DecoratedInterval(interval(0x1.a333333333332p+3,0x1.a333333333335p+3), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13), dac), -1)[2] === DecoratedInterval(interval(-0x1.d1b251eb851eep+12,-0x1.d1b251eb851ebp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x0.4P-1022,0x0.4000000000001P-1022), dac), -1)[2] === DecoratedInterval(interval(0x1.ffffffffffff8p+1023,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0x0.4000000000001P-1022,-0x0.4P-1022), def), -1)[2] === DecoratedInterval(interval(-Inf,-0x1.ffffffffffff8p+1023), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), -1)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), -1)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), dac), -1)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), def), -1)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.B77C278DBBE13P-2,0x1.9P+6), com), -1)[2] === DecoratedInterval(interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1), com), -1)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), -3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), -3)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), -3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), dac), -3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12), com), -3)[2] === DecoratedInterval(interval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39), def), -3)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test power_rev(DecoratedInterval(interval(0x0P+0,0x0.0000000000001P-1022), dac), -3)[2] === DecoratedInterval(interval(0x1p+358,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0x0.0000000000001P-1022,-0x0P+0), def), -3)[2] === DecoratedInterval(interval(-Inf,-0x1p+358), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), -3)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), dac), -3)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), def), -3)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), def), -3)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.43CFBA61AACABP-4,0x1.E848P+19), com), -3)[2] === DecoratedInterval(interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3), def), -3)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)


    @test power_rev(DecoratedInterval(emptyinterval(), trv), -7)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), -7)[2] === DecoratedInterval(entireinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), com), -7)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), def), -7)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26), dac), -7)[2] === DecoratedInterval(interval(0x1.a333333333332p+3,0x1.a333333333334p+3), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91), dac), -7)[2] === DecoratedInterval(interval(-0x1.d1b251eb851edp+12,-0x1.d1b251eb851ebp+12), trv)

    @test_broken power_rev(DecoratedInterval(interval(0x0P+0,0x0.0000000000001P-1022), def), -7)[2] === DecoratedInterval(interval(0x1.588cea3f093bcp+153,Inf), trv)

    @test_broken power_rev(DecoratedInterval(interval(-0x0.0000000000001P-1022,-0x0P+0), def), -7)[2] === DecoratedInterval(interval(-Inf,-0x1.588cea3f093bcp+153), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), -7)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-0.0,Inf), def), -7)[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), dac), -7)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), def), -7)[2] === DecoratedInterval(interval(-Inf,0.0), trv)

    @test power_rev(DecoratedInterval(interval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46), com), -7)[2] === DecoratedInterval(interval(0x1.47ae147ae147ap-7,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7), com), -7)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-0x1.51eb851eb851ep-2), trv)


end

@testset "minimal_pown_rev_dec_bin_test" begin

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,1.0), def), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(1.0,1.0), dac), DecoratedInterval(interval(1.0,1.0), dac), 0)[2] === DecoratedInterval(interval(1.0,1.0), trv)

    @test power_rev(DecoratedInterval(interval(-1.0,5.0), def), DecoratedInterval(interval(-51.0,12.0), dac), 0)[2] === DecoratedInterval(interval(-51.0,12.0), trv)


    @test power_rev(DecoratedInterval(interval(-1.0,0.0), com), DecoratedInterval(interval(5.0,10.0), dac), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-1.0,-0.0), dac), DecoratedInterval(interval(-1.0,1.0), def), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(1.1,10.0), def), DecoratedInterval(interval(1.0,41.0), dac), 0)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,100.1), dac), 1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-5.1,10.0), def), 1)[2] === DecoratedInterval(interval(-5.1,10.0), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), com), DecoratedInterval(interval(-10.0,5.1), dac), 1)[2] === DecoratedInterval(interval(0.0,0.0), trv)


    @test power_rev(DecoratedInterval(interval(-0.0,-0.0), def), DecoratedInterval(interval(1.0,5.0), dac), 1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(5.0,17.1), def), 2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), DecoratedInterval(interval(5.6,27.544), dac), 2)[2] === DecoratedInterval(interval(5.6,27.544), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(1.0,2.0), def), 2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2), com), DecoratedInterval(interval(1.0,Inf), def), 2)[2] === DecoratedInterval(interval(1.0,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1), dac), DecoratedInterval(interval(-Inf,-1.0), def), 2)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-1.0), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-23.0,-1.0), dac), 3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-23.0,-1.0), com), 3)[2] === DecoratedInterval(interval(-23.0,-1.0), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(1.0,2.0), dac), 3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3), com), DecoratedInterval(interval(1.0,Inf), dac), 3)[2] === DecoratedInterval(interval(1.0,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5), com), DecoratedInterval(interval(-Inf,-1.0), dac), 3)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-1.0), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-3.0,17.3), def), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0.0,Inf), dac), DecoratedInterval(interval(-5.1,-0.1), dac), -2)[2] === DecoratedInterval(interval(-5.1,-0.1), trv)


    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(27.2,55.1), dac), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.3F0C482C977C9P-17,Inf), def), DecoratedInterval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac), -2)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(0x1.793D85EF38E47P-3,0x1.388P+13), com), DecoratedInterval(interval(1.0,Inf), dac), -2)[2] === DecoratedInterval(interval(1.0,0x1.2a3d70a3d70a5p+1), trv)

    @test power_rev(DecoratedInterval(interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3), com), DecoratedInterval(interval(-Inf,-1.0), dac), -2)[2] === DecoratedInterval(interval(-0x1.e666666666667p+0,-1.0), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-5.1,55.5), def), -1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-5.1,55.5), dac), -1)[2] === DecoratedInterval(interval(-5.1,55.5), trv)

    @test power_rev(DecoratedInterval(interval(0.0,0.0), dac), DecoratedInterval(interval(-5.1,55.5), def), -1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), dac), DecoratedInterval(interval(-1.0,1.0), com), -1)[2] === DecoratedInterval(interval(-1.0,0.0), trv)


    @test power_rev(DecoratedInterval(interval(0x1.B77C278DBBE13P-2,0x1.9P+6), def), DecoratedInterval(interval(-1.0,0.0), dac), -1)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-5.1,55.5), dac), -3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-5.1,55.5), def), -3)[2] === DecoratedInterval(interval(-5.1,55.5), trv)


    @test power_rev(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(-5.1,55.5), def), -3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,0.0), dac), DecoratedInterval(interval(5.1,55.5), com), -3)[2] === DecoratedInterval(emptyinterval(), trv)

    @test power_rev(DecoratedInterval(interval(-Inf,-0.0), dac), DecoratedInterval(interval(-32.0,1.1), def), -3)[2] === DecoratedInterval(interval(-32.0,0.0), trv)


end

@testset "minimal_sin_rev_test" begin

    @test sin_rev(emptyinterval())[2] === emptyinterval()

    @test sin_rev(interval(-2.0,-1.1))[2] === emptyinterval()

    @test sin_rev(interval(1.1, 2.0))[2] === emptyinterval()

    @test sin_rev(interval(-1.0,1.0))[2] === entireinterval()

    @test sin_rev(interval(0.0,0.0))[2] === entireinterval()

    @test sin_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))[2] === entireinterval()

end

@testset "minimal_sin_rev_bin_test" begin

    @test sin_rev(emptyinterval(), interval(-1.2,12.1))[2] === emptyinterval()

    @test sin_rev(interval(-2.0,-1.1), interval(-5.0, 5.0))[2] === emptyinterval()

    @test sin_rev(interval(1.1, 2.0), interval(-5.0, 5.0))[2] === emptyinterval()

    @test sin_rev(interval(-1.0,1.0), interval(-1.2,12.1))[2] === interval(-1.2,12.1)

    @test sin_rev(interval(0.0,0.0), interval(-1.0,1.0))[2] === interval(0.0,0.0)

    @test sin_rev(interval(-0.0,-0.0), interval(2.0,2.5))[2] === emptyinterval()

    @test sin_rev(interval(-0.0,-0.0), interval(3.0,3.5))[2] === interval(0x1.921fb54442d18p+1,0x1.921fb54442d19p+1)

    @test sin_rev(interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0), interval(1.57,1.58, ))[2] === interval(0x1.921fb50442d18p+0,0x1.921fb58442d1ap+0)

    @test sin_rev(interval(0.0,0x1P+0), interval(-0.1,1.58))[2] === interval(0.0,1.58)

    @test sin_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(3.14,3.15))[2] === interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1)

    @test sin_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(3.14,3.15))[2] === interval(0x1.921FB54442D18P+1,0x1.921FB54442D1aP+1)

    @test sin_rev(interval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53), interval(3.14,3.15))[2] === interval(0x1.921FB54442D17P+1,0x1.921FB54442D1aP+1)

    @test sin_rev(interval(0.0,1.0), interval(-0.1,3.15))[2] === interval(0.0,0x1.921FB54442D19P+1)

    @test sin_rev(interval(0.0,1.0), interval(-0.1,3.15))[2] === interval(-0.0,0x1.921FB54442D19P+1)

    @test sin_rev(interval(-0x1.72CECE675D1FDP-52,1.0), interval(-0.1,3.15))[2] === interval(-0x1.72cece675d1fep-52,0x1.921FB54442D1aP+1)

    @test sin_rev(interval(-0x1.72CECE675D1FDP-52,1.0), interval(0.0,3.15))[2] === interval(0.0,0x1.921FB54442D1aP+1)

    @test sin_rev(interval(0x1.1A62633145C06P-53,0x1P+0), interval(3.14,3.15))[2] === interval(3.14,0x1.921FB54442D19P+1)

    @test sin_rev(interval(-0x1.72CECE675D1FDP-52,0x1P+0), interval(1.57,3.15))[2] === interval(1.57,0x1.921FB54442D1AP+1)

    @test sin_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(-Inf,3.15))[2] === interval(-Inf,0x1.921FB54442D19P+1)

    @test sin_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(3.14,Inf))[2] === interval(0x1.921FB54442D18P+1,Inf)


end

@testset "minimal_sin_rev_dec_test" begin

    @test sin_rev(DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(-2.0,-1.1), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(1.1, 2.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(-1.0,1.0), com))[2] === DecoratedInterval(entireinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(0.0,0.0), dac))[2] === DecoratedInterval(entireinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), def))[2] === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_sin_rev_dec_bin_test" begin

    @test sin_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-1.2,12.1), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(-2.0,-1.1), def), DecoratedInterval(interval(-5.0, 5.0), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(1.1, 2.0), dac), DecoratedInterval(interval(-5.0, 5.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(-1.0,1.0), com), DecoratedInterval(interval(-1.2,12.1), def))[2] === DecoratedInterval(interval(-1.2,12.1), trv)

    @test sin_rev(DecoratedInterval(interval(0.0,0.0), dac), DecoratedInterval(interval(-1.0,1.0), def))[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test sin_rev(DecoratedInterval(interval(-0.0,-0.0), def), DecoratedInterval(interval(2.0,2.5), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test sin_rev(DecoratedInterval(interval(-0.0,-0.0), def), DecoratedInterval(interval(3.0,3.5), dac))[2] === DecoratedInterval(interval(0x1.921fb54442d18p+1,0x1.921fb54442d19p+1), trv)

    @test sin_rev(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0), dac), DecoratedInterval(interval(1.57,1.58), dac))[2] === DecoratedInterval(interval(0x1.921fb50442d18p+0,0x1.921fb58442d1ap+0), trv)

    @test sin_rev(DecoratedInterval(interval(0.0,0x1P+0), com), DecoratedInterval(interval(-0.1,1.58), dac))[2] === DecoratedInterval(interval(0.0,1.58), trv)

    @test sin_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com), DecoratedInterval(interval(3.14,3.15), def))[2] === DecoratedInterval(interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1), trv)

    @test sin_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), com), DecoratedInterval(interval(3.14,3.15), dac))[2] === DecoratedInterval(interval(0x1.921FB54442D18P+1,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53), dac), DecoratedInterval(interval(3.14,3.15), com))[2] === DecoratedInterval(interval(0x1.921FB54442D17P+1,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(interval(-0.1,3.15), def))[2] === DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv)

    @test sin_rev(DecoratedInterval(interval(0.0,1.0), dac), DecoratedInterval(interval(-0.1,3.15), com))[2] === DecoratedInterval(interval(-0.0,0x1.921FB54442D19P+1), trv)

    @test sin_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,1.0), def), DecoratedInterval(interval(-0.1,3.15), def))[2] === DecoratedInterval(interval(-0x1.72cece675d1fep-52,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,1.0), com), DecoratedInterval(interval(0.0,3.15), dac))[2] === DecoratedInterval(interval(0.0,0x1.921FB54442D1aP+1), trv)

    @test sin_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1P+0), def), DecoratedInterval(interval(3.14,3.15), com))[2] === DecoratedInterval(interval(3.14,0x1.921FB54442D19P+1), trv)

    @test sin_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,0x1P+0), dac), DecoratedInterval(interval(1.57,3.15), com))[2] === DecoratedInterval(interval(1.57,0x1.921FB54442D1AP+1), trv)

    @test sin_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com), DecoratedInterval(interval(-Inf,3.15), dac))[2] === DecoratedInterval(interval(-Inf,0x1.921FB54442D19P+1), trv)

    @test sin_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), com), DecoratedInterval(interval(3.14,Inf), dac))[2] === DecoratedInterval(interval(0x1.921FB54442D18P+1,Inf), trv)


end

@testset "minimal_cos_rev_test" begin

    @test cos_rev(emptyinterval())[2] === emptyinterval()

    @test cos_rev(interval(-2.0,-1.1))[2] === emptyinterval()

    @test cos_rev(interval(1.1, 2.0))[2] === emptyinterval()

    @test cos_rev(interval(-1.0,1.0))[2] === entireinterval()

    @test cos_rev(interval(0.0,0.0))[2] === entireinterval()

    @test cos_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))[2] === entireinterval()

end

@testset "minimal_cos_rev_bin_test" begin

    @test cos_rev(emptyinterval(), interval(-1.2,12.1))[2] === emptyinterval()

    @test cos_rev(interval(-2.0,-1.1), interval(-5.0, 5.0))[2] === emptyinterval()

    @test cos_rev(interval(1.1, 2.0), interval(-5.0, 5.0))[2] === emptyinterval()

    @test cos_rev(interval(-1.0,1.0), interval(-1.2,12.1))[2] === interval(-1.2,12.1)

    @test cos_rev(interval(1.0,1.0), interval(-0.1,0.1))[2] === interval(0.0,0.0)

    @test cos_rev(interval(-1.0,-1.0), interval(3.14,3.15))[2] === interval(0x1.921fb54442d18p+1,0x1.921fb54442d1ap+1)

    @test cos_rev(interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), interval(1.57,1.58))[2] === interval(0x1.921FB54442D17P+0,0x1.921FB54442D19P+0)

    @test cos_rev(interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53), interval(1.57,1.58))[2] === interval(0x1.921FB54442D18P+0,0x1.921FB54442D1AP+0)

    @test cos_rev(interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54), interval(1.57,1.58))[2] === interval(0x1.921FB54442D17P+0,0x1.921FB54442D1aP+0)

    @test cos_rev(interval(0x1.1A62633145C06P-54,1.0), interval(-2.0,2.0))[2] === interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test cos_rev(interval(0x1.1A62633145C06P-54,1.0), interval(0.0,2.0))[2] === interval(0.0,0x1.921FB54442D19P+0)

    @test cos_rev(interval(-0x1.72CECE675D1FDP-53,1.0), interval(-0.1,1.5708))[2] === interval(-0.1,0x1.921FB54442D1aP+0)

    @test cos_rev(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), interval(3.14,3.15))[2] === interval(0x1.921fb52442d18p+1,0x1.921fb56442d1ap+1)

    @test cos_rev(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), interval(-3.15,-3.14))[2] === interval(-0x1.921fb56442d1ap+1,-0x1.921fb52442d18p+1)

    @test cos_rev(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), interval(9.42,9.45))[2] === interval(0x1.2d97c7eb321d2p+3,0x1.2d97c7fb321d3p+3)

    @test cos_rev(interval(0x1.87996529F9D92P-1,1.0), interval(-1.0,0.1))[2] === interval(-0x1.6666666666667p-1,0.1)

    @test cos_rev(interval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1), interval(0.0,2.1))[2] === interval(0x1.fffffffffffffp-1,0x1.0000000000001p+1)

    @test cos_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(-Inf,1.58))[2] === interval(-Inf,0x1.921FB54442D18P+0)

    @test cos_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), interval(-Inf,1.5))[2] === interval(-Inf,-0x1.921FB54442D17P+0)

    @test cos_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(-1.58,Inf))[2] === interval(-0x1.921fb54442d1ap+0,Inf)

    @test cos_rev(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), interval(-1.5,Inf))[2] === interval(0x1.921fb54442d19p+0,Inf)


end

@testset "minimal_cos_rev_dec_test" begin

    @test cos_rev(DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(-2.0,-1.1), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(1.1, 2.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(-1.0,1.0), com))[2] === DecoratedInterval(entireinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(0.0,0.0), def))[2] === DecoratedInterval(entireinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), dac))[2] === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_cos_rev_dec_bin_test" begin

    @test cos_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-1.2,12.1), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(-2.0,-1.1), dac), DecoratedInterval(interval(-5.0, 5.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(1.1, 2.0), dac), DecoratedInterval(interval(-5.0, 5.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cos_rev(DecoratedInterval(interval(-1.0,1.0), dac), DecoratedInterval(interval(-1.2,12.1), def))[2] === DecoratedInterval(interval(-1.2,12.1), trv)

    @test cos_rev(DecoratedInterval(interval(1.0,1.0), def), DecoratedInterval(interval(-0.1,0.1), dac))[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test cos_rev(DecoratedInterval(interval(-1.0,-1.0), com), DecoratedInterval(interval(3.14,3.15), dac))[2] === DecoratedInterval(interval(0x1.921fb54442d18p+1,0x1.921fb54442d1ap+1), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), def), DecoratedInterval(interval(1.57,1.58), def))[2] === DecoratedInterval(interval(0x1.921FB54442D17P+0,0x1.921FB54442D19P+0), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53), dac), DecoratedInterval(interval(1.57,1.58), dac))[2] === DecoratedInterval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D1AP+0), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54), com), DecoratedInterval(interval(1.57,1.58), dac))[2] === DecoratedInterval(interval(0x1.921FB54442D17P+0,0x1.921FB54442D1aP+0), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.1A62633145C06P-54,1.0), def), DecoratedInterval(interval(-2.0,2.0), com))[2] === DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.1A62633145C06P-54,1.0), dac), DecoratedInterval(interval(0.0,2.0), def))[2] === DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-53,1.0), def), DecoratedInterval(interval(-0.1,1.5708), dac))[2] === DecoratedInterval(interval(-0.1,0x1.921FB54442D1aP+0), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), dac), DecoratedInterval(interval(3.14,3.15), def))[2] === DecoratedInterval(interval(0x1.921fb52442d18p+1,0x1.921fb56442d1ap+1), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), def), DecoratedInterval(interval(-3.15,-3.14), com))[2] === DecoratedInterval(interval(-0x1.921fb56442d1ap+1,-0x1.921fb52442d18p+1), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), def), DecoratedInterval(interval(9.42,9.45), dac))[2] === DecoratedInterval(interval(0x1.2d97c7eb321d2p+3,0x1.2d97c7fb321d3p+3), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.87996529F9D92P-1,1.0), dac), DecoratedInterval(interval(-1.0,0.1), def))[2] === DecoratedInterval(interval(-0x1.6666666666667p-1,0.1), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1), com), DecoratedInterval(interval(0.0,2.1), dac))[2] === DecoratedInterval(interval(0x1.fffffffffffffp-1,0x1.0000000000001p+1), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com), DecoratedInterval(interval(-Inf,1.58), dac))[2] === DecoratedInterval(interval(-Inf,0x1.921FB54442D18P+0), trv)

    @test cos_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), def), DecoratedInterval(interval(-Inf,1.5), dac))[2] === DecoratedInterval(interval(-Inf,-0x1.921FB54442D17P+0), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), dac), DecoratedInterval(interval(-1.58,Inf), dac))[2] === DecoratedInterval(interval(-0x1.921fb54442d1ap+0,Inf), trv)

    @test cos_rev(DecoratedInterval(interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52), def), DecoratedInterval(interval(-1.5,Inf), dac))[2] === DecoratedInterval(interval(0x1.921fb54442d19p+0,Inf), trv)


end

@testset "minimal_tan_rev_test" begin

    @test tan_rev(emptyinterval())[2] === emptyinterval()

    @test tan_rev(interval(-1.0,1.0))[2] === entireinterval()

    @test tan_rev(interval(-156.0,-12.0))[2] === entireinterval()

    @test tan_rev(interval(0.0,0.0))[2] === entireinterval()

    @test tan_rev(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))[2] === entireinterval()

end

@testset "minimal_tan_rev_bin_test" begin

    @test tan_rev(emptyinterval(), interval(-1.5708,1.5708))[2] === emptyinterval()

    @test tan_rev(entireinterval(), interval(-1.5708,1.5708))[2] === interval(-1.5708,1.5708)

    @test tan_rev(interval(0.0,0.0), interval(-1.5708,1.5708))[2] === interval(0.0,0.0)

    @test tan_rev(interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), interval(-1.5708,1.5708))[2] === interval(-0x1.921fb54442d1bp+0,0x1.921fb54442d19p+0)

    @test tan_rev(interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), interval(3.14,3.15))[2] === interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1)

    @test tan_rev(interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), interval(-3.15,3.15))[2] === interval(-0x1.921FB54442D19P+1,0x1.921FB54442D1aP+1)

    @test tan_rev(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), interval(-Inf,1.5707965))[2] === interval(-Inf, +0x1.921FB82C2BD7Fp0)

    @test tan_rev(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), interval(-1.5707965,Inf))[2] === interval(-0x1.921FB82C2BD7Fp0, +Inf)

    @test tan_rev(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), interval(-1.5707965,1.5707965))[2] === interval(-0x1.921FB82C2BD7Fp0, +0x1.921FB82C2BD7Fp0)

    @test tan_rev(interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), interval(-1.5707965,1.5707965))[2] === interval(-1.5707965,1.5707965)


end

@testset "minimal_tan_rev_dec_test" begin

    @test tan_rev(DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test tan_rev(DecoratedInterval(interval(-1.0,1.0), com))[2] === DecoratedInterval(entireinterval(), trv)

    @test tan_rev(DecoratedInterval(interval(-156.0,-12.0), dac))[2] === DecoratedInterval(entireinterval(), trv)

    @test tan_rev(DecoratedInterval(interval(0.0,0.0), def))[2] === DecoratedInterval(entireinterval(), trv)

    @test tan_rev(DecoratedInterval(interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53), com))[2] === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_tan_rev_dec_bin_test" begin

    @test tan_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-1.5708,1.5708), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test tan_rev(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-1.5708,1.5708), dac))[2] === DecoratedInterval(interval(-1.5708,1.5708), trv)

    @test tan_rev(DecoratedInterval(interval(0.0,0.0), com), DecoratedInterval(interval(-1.5708,1.5708), def))[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test tan_rev(DecoratedInterval(interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), dac), DecoratedInterval(interval(-1.5708,1.5708), def))[2] === DecoratedInterval(interval(-0x1.921fb54442d1bp+0,0x1.921fb54442d19p+0), trv)

    @test tan_rev(DecoratedInterval(interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), def), DecoratedInterval(interval(3.14,3.15), dac))[2] === DecoratedInterval(interval(0x1.921FB54442D17P+1,0x1.921FB54442D19P+1), trv)

    @test tan_rev(DecoratedInterval(interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), com), DecoratedInterval(interval(-3.15,3.15), com))[2] === DecoratedInterval(interval(-0x1.921FB54442D19P+1,0x1.921FB54442D1aP+1), trv)

    @test tan_rev(DecoratedInterval(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), def), DecoratedInterval(interval(-Inf,1.5707965), def))[2] === DecoratedInterval(interval(-Inf,0x1.921FB82C2BD7Fp0), trv)

    @test tan_rev(DecoratedInterval(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), com), DecoratedInterval(interval(-1.5707965,Inf), dac))[2] === DecoratedInterval(interval(-0x1.921FB82C2BD7Fp0,Inf), trv)

    @test tan_rev(DecoratedInterval(interval(-0x1.D02967C31p+53,0x1.D02967C31p+53), com), DecoratedInterval(interval(-1.5707965,1.5707965), com))[2] === DecoratedInterval(interval(-0x1.921FB82C2BD7Fp0,0x1.921FB82C2BD7Fp0), trv)

    @test tan_rev(DecoratedInterval(interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), dac), DecoratedInterval(interval(-1.5707965,1.5707965), def))[2] === DecoratedInterval(interval(-1.5707965,1.5707965), trv)


end

@testset "minimal_cosh_rev_test" begin

    @test cosh_rev(emptyinterval())[2] === emptyinterval()

    @test cosh_rev(interval(1.0,Inf))[2] === entireinterval()

    @test cosh_rev(interval(0.0,Inf))[2] === entireinterval()

    @test cosh_rev(interval(1.0,1.0))[2] === interval(0.0,0.0)

    @test cosh_rev(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432))[2] === interval(-0x1.2C903022DD7ABP+8,0x1.2C903022DD7ABP+8)


end

@testset "minimal_cosh_rev_bin_test" begin

    @test cosh_rev(emptyinterval(), interval(0.0,Inf))[2] === emptyinterval()

    @test cosh_rev(interval(1.0,Inf), interval(0.0,Inf))[2] === interval(0.0,Inf)

    @test cosh_rev(interval(0.0,Inf), interval(1.0,2.0))[2] === interval(1.0,2.0)

    @test cosh_rev(interval(1.0,1.0), interval(1.0,Inf))[2] === emptyinterval()

    @test cosh_rev(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), interval(-Inf,0.0))[2] === interval(-0x1.2C903022DD7ABP+8,-0x1.fffffffffffffp-1)


end

@testset "minimal_cosh_rev_dec_test" begin

    @test cosh_rev(DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cosh_rev(DecoratedInterval(interval(1.0,Inf), dac))[2] === DecoratedInterval(entireinterval(), trv)

    @test cosh_rev(DecoratedInterval(interval(0.0,Inf), dac))[2] === DecoratedInterval(entireinterval(), trv)

    @test cosh_rev(DecoratedInterval(interval(1.0,1.0), def))[2] === DecoratedInterval(interval(0.0,0.0), trv)

    @test cosh_rev(DecoratedInterval(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), com))[2] === DecoratedInterval(interval(-0x1.2C903022DD7ABP+8,0x1.2C903022DD7ABP+8), trv)


end

@testset "minimal_cosh_rev_dec_bin_test" begin

    @test cosh_rev(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cosh_rev(DecoratedInterval(interval(1.0,Inf), def), DecoratedInterval(interval(0.0,Inf), dac))[2] === DecoratedInterval(interval(0.0,Inf), trv)

    @test cosh_rev(DecoratedInterval(interval(0.0,Inf), def), DecoratedInterval(interval(1.0,2.0), com))[2] === DecoratedInterval(interval(1.0,2.0), trv)

    @test cosh_rev(DecoratedInterval(interval(1.0,1.0), dac), DecoratedInterval(interval(1.0,Inf), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test cosh_rev(DecoratedInterval(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), com), DecoratedInterval(interval(-Inf,0.0), dac))[2] === DecoratedInterval(interval(-0x1.2C903022DD7ABP+8,-0x1.fffffffffffffp-1), trv)


end

@testset "minimal_mul_rev_test" begin

    @test mul_rev_IEEE1788(emptyinterval(), interval(1.0, 2.0)) === emptyinterval()

    @test mul_rev_IEEE1788(interval(1.0, 2.0), emptyinterval()) === emptyinterval()

    @test mul_rev_IEEE1788(emptyinterval(), emptyinterval()) === emptyinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, -0.4)) === interval(0x1.999999999999AP-3, 0x1.5P+4)

    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-2.1, -0.4)) === interval(0x1.999999999999AP-3, Inf)

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, -0.4)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-2.1, -0.4)) === interval(-Inf, -0x1.745D1745D1745P-2)

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, -0.4)) === interval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-2.1, -0.4)) === emptyinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-2.1, -0.4)) === interval(0.0, 0x1.5P+4)

    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-2.1, -0.4)) === interval(0.0, Inf)


    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-2.1, -0.4)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-2.1, -0.4)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-2.1, -0.4)) === interval(-Inf, 0.0)

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-2.1, -0.4)) === interval(-0x1.A400000000001P+7, 0.0)

    @test mul_rev_IEEE1788(entireinterval(), interval(-2.1, -0.4)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, 0.0)) === interval(0.0, 0x1.5P+4)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, 0.0)) === interval(-0x1.A400000000001P+7, 0.0)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-2.1, 0.0)) === interval(0.0, 0x1.5P+4)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-2.1, 0.0)) === interval(-0x1.A400000000001P+7, 0.0)

    @test mul_rev_IEEE1788(entireinterval(), interval(-2.1, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, 0.12)) === interval(-0x1.3333333333333P+0, 0x1.5P+4)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, 0.12)) === interval(-0x1.A400000000001P+7 , 0x1.8P+3)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-2.1, 0.12)) === interval(-0x1.3333333333333P+0, 0x1.5P+4)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-2.1, 0.12)) === interval(-0x1.A400000000001P+7 , 0x1.8P+3)

    @test mul_rev_IEEE1788(entireinterval(), interval(-2.1, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.0, 0.12)) === interval(-0x1.3333333333333P+0, 0.0)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.0, 0.12)) === interval(0.0, 0x1.8P+3)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, 0.12)) === interval(-0x1.3333333333333P+0, 0.0)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(0.0, 0.12)) === interval(0.0, 0x1.8P+3)

    @test mul_rev_IEEE1788(entireinterval(), interval(0.0, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.01, 0.12)) === interval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8)

    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.01, 0.12)) === interval(-Inf, -0x1.47AE147AE147BP-8)

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.01, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.01, 0.12)) === interval(0x1.29E4129E4129DP-7, Inf)

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.01, 0.12)) === interval(0x1.29E4129E4129DP-7, 0x1.8P+3)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.01, 0.12)) === emptyinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.01, 0.12)) === interval(-0x1.3333333333333P+0, 0.0)

    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.01, 0.12)) === interval(-Inf, 0.0)


    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.01, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.01, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(0.01, 0.12)) === interval(0.0, Inf)

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(0.01, 0.12)) === interval(0.0, 0x1.8P+3)

    @test mul_rev_IEEE1788(entireinterval(), interval(0.01, 0.12)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.0, 0.0)) === interval(0.0, 0.0)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.0, 0.0)) === interval(0.0, 0.0)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, 0.0)) === interval(0.0, 0.0)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(0.0, 0.0)) === interval(0.0, 0.0)

    @test mul_rev_IEEE1788(entireinterval(), interval(0.0, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-Inf, -0.1)) === interval(0x1.999999999999AP-5, Inf)

    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-Inf, -0.1)) === interval(0x1.999999999999AP-5 , Inf)

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-Inf, -0.1)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-Inf, -0.1)) === interval(-Inf, -0x1.745D1745D1745P-4)

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-Inf, -0.1)) === interval(-Inf, -0x1.745D1745D1745P-4)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-Inf, -0.1)) === emptyinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-Inf, -0.1)) === interval(0.0, Inf)

    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-Inf, -0.1)) === interval(0.0, Inf)


    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-Inf, -0.1)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-Inf, -0.1)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-Inf, -0.1)) === interval(-Inf, 0.0)

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-Inf, -0.1)) === interval(-Inf, 0.0)

    @test mul_rev_IEEE1788(entireinterval(), interval(-Inf, -0.1)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-Inf, 0.0)) === interval(0.0, Inf)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-Inf, 0.0)) === interval(0.0, Inf)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test mul_rev_IEEE1788(entireinterval(), interval(-Inf, 0.0)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-Inf, 0.3)) === interval(-0x1.8P+1, Inf)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-Inf, 0.3)) === interval(-Inf, 0x1.EP+4)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-Inf, 0.3)) === interval(-0x1.8P+1, Inf)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-Inf, 0.3)) === interval(-Inf, 0x1.EP+4)

    @test mul_rev_IEEE1788(entireinterval(), interval(-Inf, 0.3)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-0.21, Inf)) === interval(-Inf , 0x1.0CCCCCCCCCCCDP+1)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-0.21, Inf)) === interval(-0x1.5P+4, Inf)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(-0.21, Inf)) === interval(-Inf, 0x1.0CCCCCCCCCCCDP+1)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(-0.21, Inf)) === interval(-0x1.5P+4, Inf)

    @test mul_rev_IEEE1788(entireinterval(), interval(-0.21, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.0, Inf)) === interval(-Inf, 0.0)


    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.0, Inf)) === interval(0.0, Inf)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, Inf)) === interval(-Inf, 0.0)


    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test mul_rev_IEEE1788(entireinterval(), interval(0.0, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(0.04, Inf)) === interval(-Inf, -0x1.47AE147AE147BP-6)

    @test mul_rev_IEEE1788(interval(-2.0, 0.0), interval(0.04, Inf)) === interval(-Inf, -0x1.47AE147AE147BP-6)

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.04, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), interval(0.04, Inf)) === interval(0x1.29E4129E4129DP-5, Inf)

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(0.04, Inf)) === interval(0x1.29E4129E4129DP-5, Inf)

    @test mul_rev_IEEE1788(interval(0.0, 0.0), interval(0.04, Inf)) === emptyinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.04, Inf)) === interval(-Inf, 0.0)

    @test mul_rev_IEEE1788(interval(-Inf, 0.0), interval(0.04, Inf)) === interval(-Inf, 0.0)


    @test mul_rev_IEEE1788(interval(-Inf, 1.1), interval(0.04, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), interval(0.04, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), interval(0.04, Inf)) === interval(0.0, Inf)

    @test mul_rev_IEEE1788(interval(0.01, Inf), interval(0.04, Inf)) === interval(0.0, Inf)


    @test mul_rev_IEEE1788(entireinterval(), interval(0.04, Inf)) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 0.0), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 1.1), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, 1.1), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, 0.0), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 0.0), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(-Inf, 1.1), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(-2.0, Inf), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.0, Inf), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(interval(0.01, Inf), entireinterval()) === entireinterval()

    @test mul_rev_IEEE1788(entireinterval(), entireinterval()) === entireinterval()

end

@testset "minimal_mul_rev_ten_test" begin

    @test mul_rev_IEEE1788(interval(-2.0, -0.1), interval(-2.1, -0.4), interval(-2.1, -0.4)) === emptyinterval()

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(-2.1, -0.4), interval(-2.1, -0.4)) === interval(-2.1, -0.4)

    @test mul_rev_IEEE1788(interval(0.01, 1.1), interval(-2.1, 0.0), interval(-2.1, 0.0)) === interval(-2.1,0.0)

    @test mul_rev_IEEE1788(interval(-Inf, -0.1), interval(0.0, 0.12), interval(0.0, 0.12)) === interval(0.0, 0.0)

    @test mul_rev_IEEE1788(interval(-2.0, 1.1), interval(0.04, Inf), interval(0.04, Inf)) === interval(0.04, Inf)


end

@testset "minimal_mul_rev_dec_test" begin

    @test isnai(mul_rev_IEEE1788(nai(), DecoratedInterval(interval(1.0,2.0), dac)))

    @test isnai(mul_rev_IEEE1788(DecoratedInterval(interval(1.0,2.0), dac), nai()))

    @test isnai(mul_rev_IEEE1788(nai(), nai()))

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-2.1, -0.4), dac)) === DecoratedInterval(interval(0x1.999999999999AP-3, 0x1.5P+4), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.1, 0.0), def)) === DecoratedInterval(interval(0.0, 0x1.5P+4), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.1, 0.12), dac)) === DecoratedInterval(interval(-0x1.3333333333333P+0, 0x1.5P+4), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.12), com)) === DecoratedInterval(interval(-0x1.3333333333333P+0, 0.0), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(0.01, 1.1), def), DecoratedInterval(interval(0.01, 0.12), dac)) === DecoratedInterval(interval(0x1.29E4129E4129DP-7, 0x1.8P+3), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), def)) === DecoratedInterval(interval(-Inf, 0x1.EP+4), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-Inf, -0.1), trv), DecoratedInterval(interval(-0.21, Inf), dac)) === DecoratedInterval(interval(-Inf, 0x1.0CCCCCCCCCCCDP+1), trv)


end

@testset "minimal_mul_rev_dec_ten_test" begin

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-2.1, -0.4), dac), DecoratedInterval(interval(-2.1, -0.4), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-2.0, 1.1), def), DecoratedInterval(interval(-2.1, -0.4), com), DecoratedInterval(interval(-2.1, -0.4), com)) === DecoratedInterval(interval(-2.1, -0.4), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(-2.1, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), dac)) === DecoratedInterval(interval(-2.1,0.0), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.12), com), DecoratedInterval(interval(0.0, 0.12), com)) === DecoratedInterval(interval(0.0, 0.0), trv)

    @test mul_rev_IEEE1788(DecoratedInterval(interval(-2.0, 1.1), def), DecoratedInterval(interval(0.04, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac)) === DecoratedInterval(interval(0.04, Inf), trv)


end
