@testset "minimal_inf_test" begin

    @test inf(emptyinterval()) === +Inf

    @test inf(interval(-Inf,+Inf)) === -Inf

    @test inf(interval(1.0,2.0)) === 1.0

    @test inf(interval(-3.0,-2.0)) === -3.0

    @test inf(interval(-Inf,2.0)) === -Inf

    @test inf(interval(-Inf,0.0)) === -Inf

    @test inf(interval(-Inf,-0.0)) === -Inf

    @test inf(interval(-2.0,Inf)) === -2.0

    @test inf(interval(0.0,Inf)) === -0.0

    @test inf(interval(-0.0,Inf)) === -0.0

    @test inf(interval(-0.0,0.0)) === -0.0

    @test inf(interval(0.0,-0.0)) === -0.0

    @test inf(interval(0.0,0.0)) === -0.0

    @test inf(interval(-0.0,-0.0)) === -0.0

end

@testset "minimal_inf_dec_test" begin

    @test isnan(inf(nai()))

    @test inf(DecoratedInterval(emptyinterval(), trv)) === +Inf

    @test inf(DecoratedInterval(interval(-Inf,+Inf), def)) === -Inf

    @test inf(DecoratedInterval(interval(1.0,2.0), com)) === 1.0

    @test inf(DecoratedInterval(interval(-3.0,-2.0), trv)) === -3.0

    @test inf(DecoratedInterval(interval(-Inf,2.0), dac)) === -Inf

    @test inf(DecoratedInterval(interval(-Inf,0.0), def)) === -Inf

    @test inf(DecoratedInterval(interval(-Inf,-0.0), trv)) === -Inf

    @test inf(DecoratedInterval(interval(-2.0,Inf), trv)) === -2.0

    @test inf(DecoratedInterval(interval(0.0,Inf), def)) === -0.0

    @test inf(DecoratedInterval(interval(-0.0,Inf), trv)) === -0.0

    @test inf(DecoratedInterval(interval(-0.0,0.0), dac)) === -0.0

    @test inf(DecoratedInterval(interval(0.0,-0.0), trv)) === -0.0

    @test inf(DecoratedInterval(interval(0.0,0.0), trv)) === -0.0

    @test inf(DecoratedInterval(interval(-0.0,-0.0), trv)) === -0.0

end

@testset "minimal_sup_test" begin

    @test sup(emptyinterval()) === -Inf

    @test sup(interval(-Inf,+Inf)) === +Inf

    @test sup(interval(1.0,2.0)) === 2.0

    @test sup(interval(-3.0,-2.0)) === -2.0

    @test sup(interval(-Inf,2.0)) === 2.0

    @test sup(interval(-Inf,0.0)) === 0.0

    @test sup(interval(-Inf,-0.0)) === 0.0

    @test sup(interval(-2.0,Inf)) === Inf

    @test sup(interval(0.0,Inf)) === Inf

    @test sup(interval(-0.0,Inf)) === Inf

    @test sup(interval(-0.0,0.0)) === 0.0

    @test sup(interval(0.0,-0.0)) === 0.0

    @test sup(interval(0.0,0.0)) === 0.0

    @test sup(interval(-0.0,-0.0)) === 0.0

end

@testset "minimal_sup_dec_test" begin

    @test isnan(sup(nai()))

    @test sup(DecoratedInterval(emptyinterval(), trv)) === -Inf

    @test sup(DecoratedInterval(interval(-Inf,+Inf), def)) === +Inf

    @test sup(DecoratedInterval(interval(1.0,2.0), com)) === 2.0

    @test sup(DecoratedInterval(interval(-3.0,-2.0), trv)) === -2.0

    @test sup(DecoratedInterval(interval(-Inf,2.0), dac)) === 2.0

    @test sup(DecoratedInterval(interval(-Inf,0.0), def)) === 0.0

    @test sup(DecoratedInterval(interval(-Inf,-0.0), trv)) === 0.0

    @test sup(DecoratedInterval(interval(-2.0,Inf), trv)) === Inf

    @test sup(DecoratedInterval(interval(0.0,Inf), def)) === Inf

    @test sup(DecoratedInterval(interval(-0.0,Inf), trv)) === Inf

    @test sup(DecoratedInterval(interval(-0.0,0.0), dac)) === +0.0

    @test sup(DecoratedInterval(interval(0.0,-0.0), trv)) === +0.0

    @test sup(DecoratedInterval(interval(0.0,0.0), trv)) === +0.0

    @test sup(DecoratedInterval(interval(-0.0,-0.0), trv)) === +0.0

end

@testset "minimal_mid_test" begin

    @test isnan(mid(emptyinterval()))

    @test mid(interval(-Inf,+Inf)) === 0.0

    @test mid(interval(-0x1.FFFFFFFFFFFFFp1023,+0x1.FFFFFFFFFFFFFp1023)) === 0.0

    @test mid(interval(0.0,2.0)) === 1.0

    @test mid(interval(2.0,2.0)) === 2.0

    @test mid(interval(-2.0,2.0)) === 0.0

    @test mid(interval(0.0,Inf)) === 0x1.FFFFFFFFFFFFFp1023

    @test mid(interval(-Inf,1.2)) === -0x1.FFFFFFFFFFFFFp1023

    @test_broken mid(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022)) === 0.0

    @test mid(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022)) === 0.0

    @test mid(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023)) === 0x1.7FFFFFFFFFFFFP+1023

    @test mid(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022)) === 0x0.0000000000002P-1022

end

@testset "minimal_mid_dec_test" begin

    @test isnan(mid(DecoratedInterval(emptyinterval(), trv)))

    @test isnan(mid(nai()))

    @test mid(DecoratedInterval(interval(-Inf,+Inf), def)) === 0.0

    @test mid(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,+0x1.FFFFFFFFFFFFFp1023), trv)) === 0.0

    @test mid(DecoratedInterval(interval(0.0,2.0), com)) === 1.0

    @test mid(DecoratedInterval(interval(2.0,2.0), dac)) === 2.0

    @test mid(DecoratedInterval(interval(-2.0,2.0), trv)) === 0.0

    @test mid(DecoratedInterval(interval(0.0,Inf), trv)) === 0x1.FFFFFFFFFFFFFp1023

    @test mid(DecoratedInterval(interval(-Inf,1.2), trv)) === -0x1.FFFFFFFFFFFFFp1023

    @test_broken mid(DecoratedInterval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv)) === 0.0

    @test mid(DecoratedInterval(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv)) === 0.0

    @test mid(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), trv)) === 0x1.7FFFFFFFFFFFFP+1023

    @test mid(DecoratedInterval(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), trv)) === 0x0.0000000000002P-1022

end

@testset "minimal_rad_test" begin

    @test radius(interval(0.0,2.0)) === 1.0

    @test radius(interval(2.0,2.0)) === 0.0

    @test isnan(radius(emptyinterval()))

    @test radius(interval(-Inf,+Inf)) === Inf

    @test radius(interval(0.0,Inf)) === Inf

    @test radius(interval(-Inf, 1.2)) === Inf

    @test radius(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022)) === 0x0.0000000000002P-1022

    @test radius(interval(0x0.0000000000001P-1022,0x0.0000000000002P-1022)) === 0x0.0000000000001P-1022

    @test radius(interval(0x1P+0,0x1.0000000000003P+0)) === 0x1P-51

end

@testset "minimal_rad_dec_test" begin

    @test radius(DecoratedInterval(interval(0.0,2.0), trv)) === 1.0

    @test radius(DecoratedInterval(interval(2.0,2.0), com)) === 0.0

    @test isnan(radius(DecoratedInterval(emptyinterval(), trv)))

    @test isnan(radius(nai()))

    @test radius(DecoratedInterval(interval(-Inf,+Inf), trv)) === Inf

    @test radius(DecoratedInterval(interval(0.0,Inf), def)) === Inf

    @test radius(DecoratedInterval(interval(-Inf, 1.2), trv)) === Inf

    @test radius(DecoratedInterval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv)) === 0x0.0000000000002P-1022

    @test radius(DecoratedInterval(interval(0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv)) === 0x0.0000000000001P-1022

    @test radius(DecoratedInterval(interval(0x1P+0,0x1.0000000000003P+0), trv)) === 0x1P-51

end

@testset "minimal_mid_rad_test" begin

    @test isnan(midpoint_radius(emptyinterval())[1]) && isnan(midpoint_radius(emptyinterval())[2])

    @test midpoint_radius(interval(-Inf,Inf))[1] === 0.0 && midpoint_radius(interval(-Inf,Inf))[2] === Inf

    @test midpoint_radius(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023))[1] === 0.0 && midpoint_radius(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023))[2] === 0x1.FFFFFFFFFFFFFP+1023

    @test midpoint_radius(interval(0.0,2.0))[1] === 1.0 && midpoint_radius(interval(0.0,2.0))[2] === 1.0

    @test midpoint_radius(interval(2.0,2.0))[1] === 2.0 && midpoint_radius(interval(2.0,2.0))[2] === 0.0

    @test midpoint_radius(interval(-2.0,2.0))[1] === 0.0 && midpoint_radius(interval(-2.0,2.0))[2] === 2.0

    @test midpoint_radius(interval(0.0,Inf))[1] === 0x1.FFFFFFFFFFFFFP+1023 && midpoint_radius(interval(0.0,Inf))[2] === Inf

    @test midpoint_radius(interval(-Inf, 1.2))[1] === -0x1.FFFFFFFFFFFFFP+1023 && midpoint_radius(interval(-Inf, 1.2))[2] === Inf

    @test_broken midpoint_radius(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022))[1] === 0.0 && midpoint_radius(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022))[2] === 0x0.0000000000002P-1022

    @test midpoint_radius(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022))[1] === 0.0 && midpoint_radius(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022))[2] === 0x0.0000000000002P-1022

    @test midpoint_radius(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023))[1] === 0x1.7FFFFFFFFFFFFP+1023 && midpoint_radius(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023))[2] === 0x1.0p+1022

    @test midpoint_radius(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022))[1] === 0x0.0000000000002P-1022 && midpoint_radius(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022))[2] === 0x0.0000000000001P-1022

end

@testset "minimal_mid_rad_dec_test" begin

    @test isnan(midpoint_radius(emptyinterval())[1]) && isnan(midpoint_radius(emptyinterval())[2])

    @test isnan(midpoint_radius(nai())[1]) && isnan(midpoint_radius(nai())[2])

    @test midpoint_radius(DecoratedInterval(interval(-Inf,Inf), def))[1] === 0.0 && midpoint_radius(DecoratedInterval(interval(-Inf,Inf), def))[2] === Inf

    @test midpoint_radius(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023), trv))[1] === 0.0 && midpoint_radius(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023), trv))[2] === 0x1.FFFFFFFFFFFFFP+1023

    @test midpoint_radius(DecoratedInterval(interval(0.0,2.0), com))[1] === 1.0 && midpoint_radius(DecoratedInterval(interval(0.0,2.0), com))[2] === 1.0

    @test midpoint_radius(DecoratedInterval(interval(2.0,2.0), dac))[1] === 2.0 && midpoint_radius(DecoratedInterval(interval(2.0,2.0), dac))[2] === 0.0

    @test midpoint_radius(DecoratedInterval(interval(-2.0,2.0), trv))[1] === 0.0 && midpoint_radius(DecoratedInterval(interval(-2.0,2.0), trv))[2] === 2.0

    @test midpoint_radius(DecoratedInterval(interval(0.0,Inf), trv))[1] === 0x1.FFFFFFFFFFFFFP+1023 && midpoint_radius(DecoratedInterval(interval(0.0,Inf), trv))[2] === Inf

    @test midpoint_radius(DecoratedInterval(interval(-Inf, 1.2), trv))[1] === -0x1.FFFFFFFFFFFFFP+1023 && midpoint_radius(DecoratedInterval(interval(-Inf, 1.2), trv))[2] === Inf

    @test_broken midpoint_radius(DecoratedInterval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv))[1] === 0.0 && midpoint_radius(DecoratedInterval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv))[2] === 0x0.0000000000002P-1022

    @test midpoint_radius(DecoratedInterval(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv))[1] === 0.0 && midpoint_radius(DecoratedInterval(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv))[2] === 0x0.0000000000002P-1022

    @test midpoint_radius(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), trv))[1] === 0x1.7FFFFFFFFFFFFP+1023 && midpoint_radius(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), trv))[2] === 0x1.0p+1022

    @test midpoint_radius(DecoratedInterval(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), trv))[1] === 0x0.0000000000002P-1022 && midpoint_radius(DecoratedInterval(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), trv))[2] === 0x0.0000000000001P-1022

end

@testset "minimal_wid_test" begin

    @test diam(interval(2.0,2.0)) === 0.0

    @test diam(interval(1.0,2.0)) === 1.0

    @test diam(interval(1.0,Inf)) === Inf

    @test diam(interval(-Inf,2.0)) === Inf

    @test diam(interval(-Inf,+Inf)) === Inf

    @test isnan(diam(emptyinterval()))

    @test diam(interval(0x1P+0,0x1.0000000000001P+0)) === 0x1P-52

    @test diam(interval(0x1P-1022,0x1.0000000000001P-1022)) === 0x0.0000000000001P-1022

end

@testset "minimal_wid_dec_test" begin

    @test diam(DecoratedInterval(interval(2.0,2.0), com)) === 0.0

    @test diam(DecoratedInterval(interval(1.0,2.0), trv)) === 1.0

    @test diam(DecoratedInterval(interval(1.0,Inf), trv)) === Inf

    @test diam(DecoratedInterval(interval(-Inf,2.0), def)) === Inf

    @test diam(DecoratedInterval(interval(-Inf,+Inf), trv)) === Inf

    @test isnan(diam(DecoratedInterval(emptyinterval(), trv)))

    @test isnan(diam(nai()))

    @test diam(DecoratedInterval(interval(0x1P+0,0x1.0000000000001P+0), trv)) === 0x1P-52

    @test diam(DecoratedInterval(interval(0x1P-1022,0x1.0000000000001P-1022), trv)) === 0x0.0000000000001P-1022

end

@testset "minimal_mag_test" begin

    @test mag(interval(1.0,2.0)) === 2.0

    @test mag(interval(-4.0,2.0)) === 4.0

    @test mag(interval(-Inf,2.0)) === Inf

    @test mag(interval(1.0,Inf)) === Inf

    @test mag(interval(-Inf,+Inf)) === Inf

    @test isnan(mag(emptyinterval()))

    @test mag(interval(-0.0,0.0)) === 0.0

    @test mag(interval(-0.0,-0.0)) === 0.0

end

@testset "minimal_mag_dec_test" begin

    @test mag(DecoratedInterval(interval(1.0,2.0), com)) === 2.0

    @test mag(DecoratedInterval(interval(-4.0,2.0), trv)) === 4.0

    @test mag(DecoratedInterval(interval(-Inf,2.0), trv)) === Inf

    @test mag(DecoratedInterval(interval(1.0,Inf), def)) === Inf

    @test mag(DecoratedInterval(interval(-Inf,+Inf), trv)) === Inf

    @test isnan(mag(DecoratedInterval(emptyinterval(), trv)))

    @test isnan(mag(nai()))

    @test mag(DecoratedInterval(interval(-0.0,0.0), trv)) === 0.0

    @test mag(DecoratedInterval(interval(-0.0,-0.0), trv)) === 0.0

end

@testset "minimal_mig_test" begin

    @test mig(interval(1.0,2.0)) === 1.0

    @test mig(interval(-4.0,2.0)) === 0.0

    @test mig(interval(-4.0,-2.0)) === 2.0

    @test mig(interval(-Inf,2.0)) === 0.0

    @test mig(interval(-Inf,-2.0)) === 2.0

    @test mig(interval(-1.0,Inf)) === 0.0

    @test mig(interval(1.0,Inf)) === 1.0

    @test mig(interval(-Inf,+Inf)) === 0.0

    @test isnan(mig(emptyinterval()))

    @test mig(interval(-0.0,0.0)) === 0.0

    @test mig(interval(-0.0,-0.0)) === 0.0

end

@testset "minimal_mig_dec_test" begin

    @test mig(DecoratedInterval(interval(1.0,2.0), com)) === 1.0

    @test mig(DecoratedInterval(interval(-4.0,2.0), trv)) === 0.0

    @test mig(DecoratedInterval(interval(-4.0,-2.0), trv)) === 2.0

    @test mig(DecoratedInterval(interval(-Inf,2.0), def)) === 0.0

    @test mig(DecoratedInterval(interval(-Inf,-2.0), trv)) === 2.0

    @test mig(DecoratedInterval(interval(-1.0,Inf), trv)) === 0.0

    @test mig(DecoratedInterval(interval(1.0,Inf), trv)) === 1.0

    @test mig(DecoratedInterval(interval(-Inf,+Inf), trv)) === 0.0

    @test isnan(mig(DecoratedInterval(emptyinterval(), trv)))

    @test isnan(mig(nai()))

    @test mig(DecoratedInterval(interval(-0.0,0.0), trv)) === 0.0

    @test mig(DecoratedInterval(interval(-0.0,-0.0), trv)) === 0.0

end

