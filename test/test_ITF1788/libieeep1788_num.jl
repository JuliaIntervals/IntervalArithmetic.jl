@testset "minimal_inf_test" begin

    @test inf(emptyinterval(BareInterval{Float64})) === +Inf

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

    @test inf(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) === +Inf

    @test inf(Interval(interval(-Inf,+Inf), IntervalArithmetic.def)) === -Inf

    @test inf(Interval(interval(1.0,2.0), IntervalArithmetic.com)) === 1.0

    @test inf(Interval(interval(-3.0,-2.0), IntervalArithmetic.trv)) === -3.0

    @test inf(Interval(interval(-Inf,2.0), IntervalArithmetic.dac)) === -Inf

    @test inf(Interval(interval(-Inf,0.0), IntervalArithmetic.def)) === -Inf

    @test inf(Interval(interval(-Inf,-0.0), IntervalArithmetic.trv)) === -Inf

    @test inf(Interval(interval(-2.0,Inf), IntervalArithmetic.trv)) === -2.0

    @test inf(Interval(interval(0.0,Inf), IntervalArithmetic.def)) === -0.0

    @test inf(Interval(interval(-0.0,Inf), IntervalArithmetic.trv)) === -0.0

    @test inf(Interval(interval(-0.0,0.0), IntervalArithmetic.dac)) === -0.0

    @test inf(Interval(interval(0.0,-0.0), IntervalArithmetic.trv)) === -0.0

    @test inf(Interval(interval(0.0,0.0), IntervalArithmetic.trv)) === -0.0

    @test inf(Interval(interval(-0.0,-0.0), IntervalArithmetic.trv)) === -0.0

end

@testset "minimal_sup_test" begin

    @test sup(emptyinterval(BareInterval{Float64})) === -Inf

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

    @test sup(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) === -Inf

    @test sup(Interval(interval(-Inf,+Inf), IntervalArithmetic.def)) === +Inf

    @test sup(Interval(interval(1.0,2.0), IntervalArithmetic.com)) === 2.0

    @test sup(Interval(interval(-3.0,-2.0), IntervalArithmetic.trv)) === -2.0

    @test sup(Interval(interval(-Inf,2.0), IntervalArithmetic.dac)) === 2.0

    @test sup(Interval(interval(-Inf,0.0), IntervalArithmetic.def)) === 0.0

    @test sup(Interval(interval(-Inf,-0.0), IntervalArithmetic.trv)) === 0.0

    @test sup(Interval(interval(-2.0,Inf), IntervalArithmetic.trv)) === Inf

    @test sup(Interval(interval(0.0,Inf), IntervalArithmetic.def)) === Inf

    @test sup(Interval(interval(-0.0,Inf), IntervalArithmetic.trv)) === Inf

    @test sup(Interval(interval(-0.0,0.0), IntervalArithmetic.dac)) === +0.0

    @test sup(Interval(interval(0.0,-0.0), IntervalArithmetic.trv)) === +0.0

    @test sup(Interval(interval(0.0,0.0), IntervalArithmetic.trv)) === +0.0

    @test sup(Interval(interval(-0.0,-0.0), IntervalArithmetic.trv)) === +0.0

end

@testset "minimal_mid_test" begin

    @test isnan(mid(emptyinterval(BareInterval{Float64})))

    @test mid(interval(-Inf,+Inf)) === 0.0

    @test mid(interval(-0x1.FFFFFFFFFFFFFp1023,+0x1.FFFFFFFFFFFFFp1023)) === 0.0

    @test mid(interval(0.0,2.0)) === 1.0

    @test mid(interval(2.0,2.0)) === 2.0

    @test mid(interval(-2.0,2.0)) === 0.0

    @test mid(interval(0.0,Inf)) === 0x1.FFFFFFFFFFFFFp1023

    @test mid(interval(-Inf,1.2)) === -0x1.FFFFFFFFFFFFFp1023

    @test mid(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022)) === 0.0

    @test mid(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022)) === 0.0

    @test mid(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023)) === 0x1.7FFFFFFFFFFFFP+1023

    @test mid(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022)) === 0x0.0000000000002P-1022

end

@testset "minimal_mid_dec_test" begin

    @test isnan(mid(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)))

    @test isnan(mid(nai()))

    @test mid(Interval(interval(-Inf,+Inf), IntervalArithmetic.def)) === 0.0

    @test mid(Interval(interval(-0x1.FFFFFFFFFFFFFp1023,+0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.trv)) === 0.0

    @test mid(Interval(interval(0.0,2.0), IntervalArithmetic.com)) === 1.0

    @test mid(Interval(interval(2.0,2.0), IntervalArithmetic.dac)) === 2.0

    @test mid(Interval(interval(-2.0,2.0), IntervalArithmetic.trv)) === 0.0

    @test mid(Interval(interval(0.0,Inf), IntervalArithmetic.trv)) === 0x1.FFFFFFFFFFFFFp1023

    @test mid(Interval(interval(-Inf,1.2), IntervalArithmetic.trv)) === -0x1.FFFFFFFFFFFFFp1023

    @test mid(Interval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), IntervalArithmetic.trv)) === 0.0

    @test mid(Interval(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), IntervalArithmetic.trv)) === 0.0

    @test mid(Interval(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), IntervalArithmetic.trv)) === 0x1.7FFFFFFFFFFFFP+1023

    @test mid(Interval(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), IntervalArithmetic.trv)) === 0x0.0000000000002P-1022

end

@testset "minimal_rad_test" begin

    @test radius(interval(0.0,2.0)) === 1.0

    @test radius(interval(2.0,2.0)) === 0.0

    @test isnan(radius(emptyinterval(BareInterval{Float64})))

    @test radius(interval(-Inf,+Inf)) === Inf

    @test radius(interval(0.0,Inf)) === Inf

    @test radius(interval(-Inf, 1.2)) === Inf

    @test radius(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022)) === 0x0.0000000000002P-1022

    @test radius(interval(0x0.0000000000001P-1022,0x0.0000000000002P-1022)) === 0x0.0000000000001P-1022

    @test radius(interval(0x1P+0,0x1.0000000000003P+0)) === 0x1P-51

end

@testset "minimal_rad_dec_test" begin

    @test radius(Interval(interval(0.0,2.0), IntervalArithmetic.trv)) === 1.0

    @test radius(Interval(interval(2.0,2.0), IntervalArithmetic.com)) === 0.0

    @test isnan(radius(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)))

    @test isnan(radius(nai()))

    @test radius(Interval(interval(-Inf,+Inf), IntervalArithmetic.trv)) === Inf

    @test radius(Interval(interval(0.0,Inf), IntervalArithmetic.def)) === Inf

    @test radius(Interval(interval(-Inf, 1.2), IntervalArithmetic.trv)) === Inf

    @test radius(Interval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), IntervalArithmetic.trv)) === 0x0.0000000000002P-1022

    @test radius(Interval(interval(0x0.0000000000001P-1022,0x0.0000000000002P-1022), IntervalArithmetic.trv)) === 0x0.0000000000001P-1022

    @test radius(Interval(interval(0x1P+0,0x1.0000000000003P+0), IntervalArithmetic.trv)) === 0x1P-51

end

@testset "minimal_mid_rad_test" begin

    @test isnan(midradius(emptyinterval(BareInterval{Float64}))[1]) && isnan(midradius(emptyinterval(BareInterval{Float64}))[2])

    @test midradius(interval(-Inf,Inf))[1] === 0.0 && midradius(interval(-Inf,Inf))[2] === Inf

    @test midradius(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023))[1] === 0.0 && midradius(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023))[2] === 0x1.FFFFFFFFFFFFFP+1023

    @test midradius(interval(0.0,2.0))[1] === 1.0 && midradius(interval(0.0,2.0))[2] === 1.0

    @test midradius(interval(2.0,2.0))[1] === 2.0 && midradius(interval(2.0,2.0))[2] === 0.0

    @test midradius(interval(-2.0,2.0))[1] === 0.0 && midradius(interval(-2.0,2.0))[2] === 2.0

    @test midradius(interval(0.0,Inf))[1] === 0x1.FFFFFFFFFFFFFP+1023 && midradius(interval(0.0,Inf))[2] === Inf

    @test midradius(interval(-Inf, 1.2))[1] === -0x1.FFFFFFFFFFFFFP+1023 && midradius(interval(-Inf, 1.2))[2] === Inf

    @test midradius(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022))[1] === 0.0 && midradius(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022))[2] === 0x0.0000000000002P-1022

    @test midradius(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022))[1] === 0.0 && midradius(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022))[2] === 0x0.0000000000002P-1022

    @test midradius(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023))[1] === 0x1.7FFFFFFFFFFFFP+1023 && midradius(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023))[2] === 0x1.0p+1022

    @test midradius(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022))[1] === 0x0.0000000000002P-1022 && midradius(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022))[2] === 0x0.0000000000001P-1022

end

@testset "minimal_mid_rad_dec_test" begin

    @test isnan(midradius(emptyinterval(BareInterval{Float64}))[1]) && isnan(midradius(emptyinterval(BareInterval{Float64}))[2])

    @test isnan(midradius(nai())[1]) && isnan(midradius(nai())[2])

    @test midradius(Interval(interval(-Inf,Inf), IntervalArithmetic.def))[1] === 0.0 && midradius(Interval(interval(-Inf,Inf), IntervalArithmetic.def))[2] === Inf

    @test midradius(Interval(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023), IntervalArithmetic.trv))[1] === 0.0 && midradius(Interval(interval(-0x1.FFFFFFFFFFFFFP+1023,0x1.FFFFFFFFFFFFFP+1023), IntervalArithmetic.trv))[2] === 0x1.FFFFFFFFFFFFFP+1023

    @test midradius(Interval(interval(0.0,2.0), IntervalArithmetic.com))[1] === 1.0 && midradius(Interval(interval(0.0,2.0), IntervalArithmetic.com))[2] === 1.0

    @test midradius(Interval(interval(2.0,2.0), IntervalArithmetic.dac))[1] === 2.0 && midradius(Interval(interval(2.0,2.0), IntervalArithmetic.dac))[2] === 0.0

    @test midradius(Interval(interval(-2.0,2.0), IntervalArithmetic.trv))[1] === 0.0 && midradius(Interval(interval(-2.0,2.0), IntervalArithmetic.trv))[2] === 2.0

    @test midradius(Interval(interval(0.0,Inf), IntervalArithmetic.trv))[1] === 0x1.FFFFFFFFFFFFFP+1023 && midradius(Interval(interval(0.0,Inf), IntervalArithmetic.trv))[2] === Inf

    @test midradius(Interval(interval(-Inf, 1.2), IntervalArithmetic.trv))[1] === -0x1.FFFFFFFFFFFFFP+1023 && midradius(Interval(interval(-Inf, 1.2), IntervalArithmetic.trv))[2] === Inf

    @test midradius(Interval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), IntervalArithmetic.trv))[1] === 0.0 && midradius(Interval(interval(-0x0.0000000000002P-1022,0x0.0000000000001P-1022), IntervalArithmetic.trv))[2] === 0x0.0000000000002P-1022

    @test midradius(Interval(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), IntervalArithmetic.trv))[1] === 0.0 && midradius(Interval(interval(-0x0.0000000000001P-1022,0x0.0000000000002P-1022), IntervalArithmetic.trv))[2] === 0x0.0000000000002P-1022

    @test midradius(Interval(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), IntervalArithmetic.trv))[1] === 0x1.7FFFFFFFFFFFFP+1023 && midradius(Interval(interval(0x1.FFFFFFFFFFFFFP+1022,0x1.FFFFFFFFFFFFFP+1023), IntervalArithmetic.trv))[2] === 0x1.0p+1022

    @test midradius(Interval(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), IntervalArithmetic.trv))[1] === 0x0.0000000000002P-1022 && midradius(Interval(interval(0x0.0000000000001P-1022,0x0.0000000000003P-1022), IntervalArithmetic.trv))[2] === 0x0.0000000000001P-1022

end

@testset "minimal_wid_test" begin

    @test diam(interval(2.0,2.0)) === 0.0

    @test diam(interval(1.0,2.0)) === 1.0

    @test diam(interval(1.0,Inf)) === Inf

    @test diam(interval(-Inf,2.0)) === Inf

    @test diam(interval(-Inf,+Inf)) === Inf

    @test isnan(diam(emptyinterval(BareInterval{Float64})))

    @test diam(interval(0x1P+0,0x1.0000000000001P+0)) === 0x1P-52

    @test diam(interval(0x1P-1022,0x1.0000000000001P-1022)) === 0x0.0000000000001P-1022

end

@testset "minimal_wid_dec_test" begin

    @test diam(Interval(interval(2.0,2.0), IntervalArithmetic.com)) === 0.0

    @test diam(Interval(interval(1.0,2.0), IntervalArithmetic.trv)) === 1.0

    @test diam(Interval(interval(1.0,Inf), IntervalArithmetic.trv)) === Inf

    @test diam(Interval(interval(-Inf,2.0), IntervalArithmetic.def)) === Inf

    @test diam(Interval(interval(-Inf,+Inf), IntervalArithmetic.trv)) === Inf

    @test isnan(diam(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)))

    @test isnan(diam(nai()))

    @test diam(Interval(interval(0x1P+0,0x1.0000000000001P+0), IntervalArithmetic.trv)) === 0x1P-52

    @test diam(Interval(interval(0x1P-1022,0x1.0000000000001P-1022), IntervalArithmetic.trv)) === 0x0.0000000000001P-1022

end

@testset "minimal_mag_test" begin

    @test mag(interval(1.0,2.0)) === 2.0

    @test mag(interval(-4.0,2.0)) === 4.0

    @test mag(interval(-Inf,2.0)) === Inf

    @test mag(interval(1.0,Inf)) === Inf

    @test mag(interval(-Inf,+Inf)) === Inf

    @test isnan(mag(emptyinterval(BareInterval{Float64})))

    @test mag(interval(-0.0,0.0)) === 0.0

    @test mag(interval(-0.0,-0.0)) === 0.0

end

@testset "minimal_mag_dec_test" begin

    @test mag(Interval(interval(1.0,2.0), IntervalArithmetic.com)) === 2.0

    @test mag(Interval(interval(-4.0,2.0), IntervalArithmetic.trv)) === 4.0

    @test mag(Interval(interval(-Inf,2.0), IntervalArithmetic.trv)) === Inf

    @test mag(Interval(interval(1.0,Inf), IntervalArithmetic.def)) === Inf

    @test mag(Interval(interval(-Inf,+Inf), IntervalArithmetic.trv)) === Inf

    @test isnan(mag(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)))

    @test isnan(mag(nai()))

    @test mag(Interval(interval(-0.0,0.0), IntervalArithmetic.trv)) === 0.0

    @test mag(Interval(interval(-0.0,-0.0), IntervalArithmetic.trv)) === 0.0

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

    @test isnan(mig(emptyinterval(BareInterval{Float64})))

    @test mig(interval(-0.0,0.0)) === 0.0

    @test mig(interval(-0.0,-0.0)) === 0.0

end

@testset "minimal_mig_dec_test" begin

    @test mig(Interval(interval(1.0,2.0), IntervalArithmetic.com)) === 1.0

    @test mig(Interval(interval(-4.0,2.0), IntervalArithmetic.trv)) === 0.0

    @test mig(Interval(interval(-4.0,-2.0), IntervalArithmetic.trv)) === 2.0

    @test mig(Interval(interval(-Inf,2.0), IntervalArithmetic.def)) === 0.0

    @test mig(Interval(interval(-Inf,-2.0), IntervalArithmetic.trv)) === 2.0

    @test mig(Interval(interval(-1.0,Inf), IntervalArithmetic.trv)) === 0.0

    @test mig(Interval(interval(1.0,Inf), IntervalArithmetic.trv)) === 1.0

    @test mig(Interval(interval(-Inf,+Inf), IntervalArithmetic.trv)) === 0.0

    @test isnan(mig(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)))

    @test isnan(mig(nai()))

    @test mig(Interval(interval(-0.0,0.0), IntervalArithmetic.trv)) === 0.0

    @test mig(Interval(interval(-0.0,-0.0), IntervalArithmetic.trv)) === 0.0

end
