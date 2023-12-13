@testset "minimal_inf_test" begin

    @test inf(emptyinterval(BareInterval{Float64})) === +Inf

    @test inf(bareinterval(-Inf,+Inf)) === -Inf

    @test inf(bareinterval(1.0,2.0)) === 1.0

    @test inf(bareinterval(-3.0,-2.0)) === -3.0

    @test inf(bareinterval(-Inf,2.0)) === -Inf

    @test inf(bareinterval(-Inf,0.0)) === -Inf

    @test inf(bareinterval(-Inf,-0.0)) === -Inf

    @test inf(bareinterval(-2.0,Inf)) === -2.0

    @test inf(bareinterval(0.0,Inf)) === -0.0

    @test inf(bareinterval(-0.0,Inf)) === -0.0

    @test inf(bareinterval(-0.0,0.0)) === -0.0

    @test inf(bareinterval(0.0,-0.0)) === -0.0

    @test inf(bareinterval(0.0,0.0)) === -0.0

    @test inf(bareinterval(-0.0,-0.0)) === -0.0

end

@testset "minimal_inf_dec_test" begin

    @test isnan(inf(nai(Interval{Float64})))

    @test inf(interval(emptyinterval(BareInterval{Float64}), trv)) === +Inf

    @test inf(interval(bareinterval(-Inf,+Inf), def)) === -Inf

    @test inf(interval(bareinterval(1.0,2.0), com)) === 1.0

    @test inf(interval(bareinterval(-3.0,-2.0), trv)) === -3.0

    @test inf(interval(bareinterval(-Inf,2.0), dac)) === -Inf

    @test inf(interval(bareinterval(-Inf,0.0), def)) === -Inf

    @test inf(interval(bareinterval(-Inf,-0.0), trv)) === -Inf

    @test inf(interval(bareinterval(-2.0,Inf), trv)) === -2.0

    @test inf(interval(bareinterval(0.0,Inf), def)) === -0.0

    @test inf(interval(bareinterval(-0.0,Inf), trv)) === -0.0

    @test inf(interval(bareinterval(-0.0,0.0), dac)) === -0.0

    @test inf(interval(bareinterval(0.0,-0.0), trv)) === -0.0

    @test inf(interval(bareinterval(0.0,0.0), trv)) === -0.0

    @test inf(interval(bareinterval(-0.0,-0.0), trv)) === -0.0

end

@testset "minimal_sup_test" begin

    @test sup(emptyinterval(BareInterval{Float64})) === -Inf

    @test sup(bareinterval(-Inf,+Inf)) === +Inf

    @test sup(bareinterval(1.0,2.0)) === 2.0

    @test sup(bareinterval(-3.0,-2.0)) === -2.0

    @test sup(bareinterval(-Inf,2.0)) === 2.0

    @test sup(bareinterval(-Inf,0.0)) === 0.0

    @test sup(bareinterval(-Inf,-0.0)) === 0.0

    @test sup(bareinterval(-2.0,Inf)) === Inf

    @test sup(bareinterval(0.0,Inf)) === Inf

    @test sup(bareinterval(-0.0,Inf)) === Inf

    @test sup(bareinterval(-0.0,0.0)) === 0.0

    @test sup(bareinterval(0.0,-0.0)) === 0.0

    @test sup(bareinterval(0.0,0.0)) === 0.0

    @test sup(bareinterval(-0.0,-0.0)) === 0.0

end

@testset "minimal_sup_dec_test" begin

    @test isnan(sup(nai(Interval{Float64})))

    @test sup(interval(emptyinterval(BareInterval{Float64}), trv)) === -Inf

    @test sup(interval(bareinterval(-Inf,+Inf), def)) === +Inf

    @test sup(interval(bareinterval(1.0,2.0), com)) === 2.0

    @test sup(interval(bareinterval(-3.0,-2.0), trv)) === -2.0

    @test sup(interval(bareinterval(-Inf,2.0), dac)) === 2.0

    @test sup(interval(bareinterval(-Inf,0.0), def)) === 0.0

    @test sup(interval(bareinterval(-Inf,-0.0), trv)) === 0.0

    @test sup(interval(bareinterval(-2.0,Inf), trv)) === Inf

    @test sup(interval(bareinterval(0.0,Inf), def)) === Inf

    @test sup(interval(bareinterval(-0.0,Inf), trv)) === Inf

    @test sup(interval(bareinterval(-0.0,0.0), dac)) === +0.0

    @test sup(interval(bareinterval(0.0,-0.0), trv)) === +0.0

    @test sup(interval(bareinterval(0.0,0.0), trv)) === +0.0

    @test sup(interval(bareinterval(-0.0,-0.0), trv)) === +0.0

end

@testset "minimal_mid_test" begin

    @test isnan(mid(emptyinterval(BareInterval{Float64})))

    @test mid(bareinterval(-Inf,+Inf)) === 0.0

    @test mid(bareinterval(-0x1.FFFFFFFFFFFFFp1023,+0x1.FFFFFFFFFFFFFp1023)) === 0.0

    @test mid(bareinterval(0.0,2.0)) === 1.0

    @test mid(bareinterval(2.0,2.0)) === 2.0

    @test mid(bareinterval(-2.0,2.0)) === 0.0

    @test mid(bareinterval(0.0,Inf)) === 0x1.FFFFFFFFFFFFFp1023

    @test mid(bareinterval(-Inf,1.2)) === -0x1.FFFFFFFFFFFFFp1023

    @test mid(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022)) === 0.0

    @test mid(bareinterval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022)) === 0.0

    @test mid(bareinterval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023)) === 0x1.7FFFFFFFFFFFFP+1023

    @test mid(bareinterval(0x0.0000000000001P-1022,0x0.0000000000003P-1022)) === 0x0.0000000000002P-1022

end

@testset "minimal_mid_dec_test" begin

    @test isnan(mid(interval(emptyinterval(BareInterval{Float64}), trv)))

    @test isnan(mid(nai(Interval{Float64})))

    @test mid(interval(bareinterval(-Inf,+Inf), def)) === 0.0

    @test mid(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,+0x1.FFFFFFFFFFFFFp1023), trv)) === 0.0

    @test mid(interval(bareinterval(0.0,2.0), com)) === 1.0

    @test mid(interval(bareinterval(2.0,2.0), dac)) === 2.0

    @test mid(interval(bareinterval(-2.0,2.0), trv)) === 0.0

    @test mid(interval(bareinterval(0.0,Inf), trv)) === 0x1.FFFFFFFFFFFFFp1023

    @test mid(interval(bareinterval(-Inf,1.2), trv)) === -0x1.FFFFFFFFFFFFFp1023

    @test mid(interval(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv)) === 0.0

    @test mid(interval(bareinterval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv)) === 0.0

    @test mid(interval(bareinterval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), trv)) === 0x1.7FFFFFFFFFFFFP+1023

    @test mid(interval(bareinterval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), trv)) === 0x0.0000000000002P-1022

end

@testset "minimal_rad_test" begin

    @test radius(bareinterval(0.0,2.0)) === 1.0

    @test radius(bareinterval(2.0,2.0)) === 0.0

    @test isnan(radius(emptyinterval(BareInterval{Float64})))

    @test radius(bareinterval(-Inf,+Inf)) === Inf

    @test radius(bareinterval(0.0,Inf)) === Inf

    @test radius(bareinterval(-Inf, 1.2)) === Inf

    @test radius(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022)) === 0x0.0000000000002P-1022

    @test radius(bareinterval(0x0.0000000000001P-1022,0x0.0000000000002P-1022)) === 0x0.0000000000001P-1022

    @test radius(bareinterval(0x1P+0,0x1.0000000000003P+0)) === 0x1P-51

end

@testset "minimal_rad_dec_test" begin

    @test radius(interval(bareinterval(0.0,2.0), trv)) === 1.0

    @test radius(interval(bareinterval(2.0,2.0), com)) === 0.0

    @test isnan(radius(interval(emptyinterval(BareInterval{Float64}), trv)))

    @test isnan(radius(nai(Interval{Float64})))

    @test radius(interval(bareinterval(-Inf,+Inf), trv)) === Inf

    @test radius(interval(bareinterval(0.0,Inf), def)) === Inf

    @test radius(interval(bareinterval(-Inf, 1.2), trv)) === Inf

    @test radius(interval(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv)) === 0x0.0000000000002P-1022

    @test radius(interval(bareinterval(0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv)) === 0x0.0000000000001P-1022

    @test radius(interval(bareinterval(0x1P+0,0x1.0000000000003P+0), trv)) === 0x1P-51

end

@testset "minimal_mid_rad_test" begin

    @test isnan(midradius(emptyinterval(BareInterval{Float64}))[1]) && isnan(midradius(emptyinterval(BareInterval{Float64}))[2])

    @test midradius(bareinterval(-Inf,Inf))[1] === 0.0 && midradius(bareinterval(-Inf,Inf))[2] === Inf

    @test midradius(bareinterval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023))[1] === 0.0 && midradius(bareinterval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023))[2] === 0x1.FFFFFFFFFFFFFP+1023

    @test midradius(bareinterval(0.0,2.0))[1] === 1.0 && midradius(bareinterval(0.0,2.0))[2] === 1.0

    @test midradius(bareinterval(2.0,2.0))[1] === 2.0 && midradius(bareinterval(2.0,2.0))[2] === 0.0

    @test midradius(bareinterval(-2.0,2.0))[1] === 0.0 && midradius(bareinterval(-2.0,2.0))[2] === 2.0

    @test midradius(bareinterval(0.0,Inf))[1] === 0x1.FFFFFFFFFFFFFP+1023 && midradius(bareinterval(0.0,Inf))[2] === Inf

    @test midradius(bareinterval(-Inf, 1.2))[1] === -0x1.FFFFFFFFFFFFFP+1023 && midradius(bareinterval(-Inf, 1.2))[2] === Inf

    @test midradius(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022))[1] === 0.0 && midradius(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022))[2] === 0x0.0000000000002P-1022

    @test midradius(bareinterval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022))[1] === 0.0 && midradius(bareinterval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022))[2] === 0x0.0000000000002P-1022

    @test midradius(bareinterval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023))[1] === 0x1.7FFFFFFFFFFFFP+1023 && midradius(bareinterval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023))[2] === 0x1.0p+1022

    @test midradius(bareinterval(0x0.0000000000001P-1022,0x0.0000000000003P-1022))[1] === 0x0.0000000000002P-1022 && midradius(bareinterval(0x0.0000000000001P-1022,0x0.0000000000003P-1022))[2] === 0x0.0000000000001P-1022

end

@testset "minimal_mid_rad_dec_test" begin

    @test isnan(midradius(emptyinterval(BareInterval{Float64}))[1]) && isnan(midradius(emptyinterval(BareInterval{Float64}))[2])

    @test isnan(midradius(nai(Interval{Float64}))[1]) && isnan(midradius(nai(Interval{Float64}))[2])

    @test midradius(interval(bareinterval(-Inf,Inf), def))[1] === 0.0 && midradius(interval(bareinterval(-Inf,Inf), def))[2] === Inf

    @test midradius(interval(bareinterval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023), trv))[1] === 0.0 && midradius(interval(bareinterval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023), trv))[2] === 0x1.FFFFFFFFFFFFFP+1023

    @test midradius(interval(bareinterval(0.0,2.0), com))[1] === 1.0 && midradius(interval(bareinterval(0.0,2.0), com))[2] === 1.0

    @test midradius(interval(bareinterval(2.0,2.0), dac))[1] === 2.0 && midradius(interval(bareinterval(2.0,2.0), dac))[2] === 0.0

    @test midradius(interval(bareinterval(-2.0,2.0), trv))[1] === 0.0 && midradius(interval(bareinterval(-2.0,2.0), trv))[2] === 2.0

    @test midradius(interval(bareinterval(0.0,Inf), trv))[1] === 0x1.FFFFFFFFFFFFFP+1023 && midradius(interval(bareinterval(0.0,Inf), trv))[2] === Inf

    @test midradius(interval(bareinterval(-Inf, 1.2), trv))[1] === -0x1.FFFFFFFFFFFFFP+1023 && midradius(interval(bareinterval(-Inf, 1.2), trv))[2] === Inf

    @test midradius(interval(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv))[1] === 0.0 && midradius(interval(bareinterval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), trv))[2] === 0x0.0000000000002P-1022

    @test midradius(interval(bareinterval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv))[1] === 0.0 && midradius(interval(bareinterval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), trv))[2] === 0x0.0000000000002P-1022

    @test midradius(interval(bareinterval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), trv))[1] === 0x1.7FFFFFFFFFFFFP+1023 && midradius(interval(bareinterval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), trv))[2] === 0x1.0p+1022

    @test midradius(interval(bareinterval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), trv))[1] === 0x0.0000000000002P-1022 && midradius(interval(bareinterval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), trv))[2] === 0x0.0000000000001P-1022

end

@testset "minimal_wid_test" begin

    @test diam(bareinterval(2.0,2.0)) === 0.0

    @test diam(bareinterval(1.0,2.0)) === 1.0

    @test diam(bareinterval(1.0,Inf)) === Inf

    @test diam(bareinterval(-Inf,2.0)) === Inf

    @test diam(bareinterval(-Inf,+Inf)) === Inf

    @test isnan(diam(emptyinterval(BareInterval{Float64})))

    @test diam(bareinterval(0x1P+0,0x1.0000000000001P+0)) === 0x1P-52

    @test diam(bareinterval(0x1P-1022,0x1.0000000000001P-1022)) === 0x0.0000000000001P-1022

end

@testset "minimal_wid_dec_test" begin

    @test diam(interval(bareinterval(2.0,2.0), com)) === 0.0

    @test diam(interval(bareinterval(1.0,2.0), trv)) === 1.0

    @test diam(interval(bareinterval(1.0,Inf), trv)) === Inf

    @test diam(interval(bareinterval(-Inf,2.0), def)) === Inf

    @test diam(interval(bareinterval(-Inf,+Inf), trv)) === Inf

    @test isnan(diam(interval(emptyinterval(BareInterval{Float64}), trv)))

    @test isnan(diam(nai(Interval{Float64})))

    @test diam(interval(bareinterval(0x1P+0,0x1.0000000000001P+0), trv)) === 0x1P-52

    @test diam(interval(bareinterval(0x1P-1022,0x1.0000000000001P-1022), trv)) === 0x0.0000000000001P-1022

end

@testset "minimal_mag_test" begin

    @test mag(bareinterval(1.0,2.0)) === 2.0

    @test mag(bareinterval(-4.0,2.0)) === 4.0

    @test mag(bareinterval(-Inf,2.0)) === Inf

    @test mag(bareinterval(1.0,Inf)) === Inf

    @test mag(bareinterval(-Inf,+Inf)) === Inf

    @test isnan(mag(emptyinterval(BareInterval{Float64})))

    @test mag(bareinterval(-0.0,0.0)) === 0.0

    @test mag(bareinterval(-0.0,-0.0)) === 0.0

end

@testset "minimal_mag_dec_test" begin

    @test mag(interval(bareinterval(1.0,2.0), com)) === 2.0

    @test mag(interval(bareinterval(-4.0,2.0), trv)) === 4.0

    @test mag(interval(bareinterval(-Inf,2.0), trv)) === Inf

    @test mag(interval(bareinterval(1.0,Inf), def)) === Inf

    @test mag(interval(bareinterval(-Inf,+Inf), trv)) === Inf

    @test isnan(mag(interval(emptyinterval(BareInterval{Float64}), trv)))

    @test isnan(mag(nai(Interval{Float64})))

    @test mag(interval(bareinterval(-0.0,0.0), trv)) === 0.0

    @test mag(interval(bareinterval(-0.0,-0.0), trv)) === 0.0

end

@testset "minimal_mig_test" begin

    @test mig(bareinterval(1.0,2.0)) === 1.0

    @test mig(bareinterval(-4.0,2.0)) === 0.0

    @test mig(bareinterval(-4.0,-2.0)) === 2.0

    @test mig(bareinterval(-Inf,2.0)) === 0.0

    @test mig(bareinterval(-Inf,-2.0)) === 2.0

    @test mig(bareinterval(-1.0,Inf)) === 0.0

    @test mig(bareinterval(1.0,Inf)) === 1.0

    @test mig(bareinterval(-Inf,+Inf)) === 0.0

    @test isnan(mig(emptyinterval(BareInterval{Float64})))

    @test mig(bareinterval(-0.0,0.0)) === 0.0

    @test mig(bareinterval(-0.0,-0.0)) === 0.0

end

@testset "minimal_mig_dec_test" begin

    @test mig(interval(bareinterval(1.0,2.0), com)) === 1.0

    @test mig(interval(bareinterval(-4.0,2.0), trv)) === 0.0

    @test mig(interval(bareinterval(-4.0,-2.0), trv)) === 2.0

    @test mig(interval(bareinterval(-Inf,2.0), def)) === 0.0

    @test mig(interval(bareinterval(-Inf,-2.0), trv)) === 2.0

    @test mig(interval(bareinterval(-1.0,Inf), trv)) === 0.0

    @test mig(interval(bareinterval(1.0,Inf), trv)) === 1.0

    @test mig(interval(bareinterval(-Inf,+Inf), trv)) === 0.0

    @test isnan(mig(interval(emptyinterval(BareInterval{Float64}), trv)))

    @test isnan(mig(nai(Interval{Float64})))

    @test mig(interval(bareinterval(-0.0,0.0), trv)) === 0.0

    @test mig(interval(bareinterval(-0.0,-0.0), trv)) === 0.0

end
