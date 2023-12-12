@testset "minimal_is_common_interval_test" begin

    @test iscommon(bareinterval(-27.0,-27.0)) === true

    @test iscommon(bareinterval(-27.0, 0.0)) === true

    @test iscommon(bareinterval(0.0,0.0)) === true

    @test iscommon(bareinterval(-0.0,-0.0)) === true

    @test iscommon(bareinterval(-0.0,0.0)) === true

    @test iscommon(bareinterval(0.0,-0.0)) === true

    @test iscommon(bareinterval(5.0, 12.4)) === true

    @test iscommon(bareinterval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023)) === true

    @test iscommon(entireinterval(BareInterval{Float64})) === false

    @test iscommon(emptyinterval(BareInterval{Float64})) === false

    @test iscommon(bareinterval(-Inf, 0.0)) === false

    @test iscommon(bareinterval(0.0, Inf)) === false

end

@testset "minimal_is_common_interval_dec_test" begin

    @test iscommon(interval(bareinterval(-27.0,-27.0), com)) === true

    @test iscommon(interval(bareinterval(-27.0, 0.0), com)) === true

    @test iscommon(interval(bareinterval(0.0,0.0), com)) === true

    @test iscommon(interval(bareinterval(-0.0,-0.0), com)) === true

    @test iscommon(interval(bareinterval(-0.0,0.0), com)) === true

    @test iscommon(interval(bareinterval(0.0,-0.0), com)) === true

    @test iscommon(interval(bareinterval(5.0, 12.4), com)) === true

    @test iscommon(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), com)) === true

    @test iscommon(interval(bareinterval(-27.0,-27.0), trv)) === true

    @test iscommon(interval(bareinterval(-27.0, 0.0), def)) === true

    @test iscommon(interval(bareinterval(0.0,0.0), dac)) === true

    @test iscommon(interval(bareinterval(-0.0,-0.0), trv)) === true

    @test iscommon(interval(bareinterval(-0.0,0.0), def)) === true

    @test iscommon(interval(bareinterval(0.0,-0.0), dac)) === true

    @test iscommon(interval(bareinterval(5.0, 12.4), def)) === true

    @test iscommon(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), trv)) === true

    @test iscommon(interval(entireinterval(BareInterval{Float64}), dac)) === false

    @test iscommon(nai(Interval{Float64})) === false

    @test iscommon(interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test iscommon(interval(bareinterval(-Inf, 0.0), trv)) === false

    @test iscommon(interval(bareinterval(0.0, Inf), def)) === false

end

@testset "minimal_is_singleton_test" begin

    @test isthin(bareinterval(-27.0,-27.0)) === true

    @test isthin(bareinterval(-2.0, -2.0)) === true

    @test isthin(bareinterval(12.0,12.0)) === true

    @test isthin(bareinterval(17.1, 17.1)) === true

    @test isthin(bareinterval(-0.0,-0.0)) === true

    @test isthin(bareinterval(0.0,0.0)) === true

    @test isthin(bareinterval(-0.0, 0.0)) === true

    @test isthin(bareinterval(0.0, -0.0)) === true

    @test isthin(emptyinterval(BareInterval{Float64})) === false

    @test isthin(entireinterval(BareInterval{Float64})) === false

    @test isthin(bareinterval(-1.0, 0.0)) === false

    @test isthin(bareinterval(-1.0, -0.5)) === false

    @test isthin(bareinterval(1.0, 2.0)) === false

    @test isthin(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023)) === false

    @test isthin(bareinterval(-1.0,Inf)) === false

end

@testset "minimal_is_singleton_dec_test" begin

    @test isthin(interval(bareinterval(-27.0,-27.0), def)) === true

    @test isthin(interval(bareinterval(-2.0, -2.0), trv)) === true

    @test isthin(interval(bareinterval(12.0,12.0), dac)) === true

    @test isthin(interval(bareinterval(17.1, 17.1), com)) === true

    @test isthin(interval(bareinterval(-0.0,-0.0), def)) === true

    @test isthin(interval(bareinterval(0.0,0.0), com)) === true

    @test isthin(interval(bareinterval(-0.0, 0.0), def)) === true

    @test isthin(interval(bareinterval(0.0, -0.0), dac)) === true

    @test isthin(interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isthin(nai(Interval{Float64})) === false

    @test isthin(interval(entireinterval(BareInterval{Float64}), def)) === false

    @test isthin(interval(bareinterval(-1.0, 0.0), dac)) === false

    @test isthin(interval(bareinterval(-1.0, -0.5), com)) === false

    @test isthin(interval(bareinterval(1.0, 2.0), def)) === false

    @test isthin(interval(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac)) === false

    @test isthin(interval(bareinterval(-1.0,Inf), trv)) === false

end

@testset "minimal_is_member_test" begin

    @test in_interval(-27.0, bareinterval(-27.0,-27.0)) === true

    @test in_interval(-27.0, bareinterval(-27.0, 0.0)) === true

    @test in_interval(-7.0, bareinterval(-27.0, 0.0)) === true

    @test in_interval(0.0, bareinterval(-27.0, 0.0)) === true

    @test in_interval(-0.0, bareinterval(0.0,0.0)) === true

    @test in_interval(0.0, bareinterval(0.0,0.0)) === true

    @test in_interval(0.0, bareinterval(-0.0,-0.0)) === true

    @test in_interval(0.0, bareinterval(-0.0,0.0)) === true

    @test in_interval(0.0, bareinterval(0.0,-0.0)) === true

    @test in_interval(5.0, bareinterval(5.0, 12.4)) === true

    @test in_interval(6.3, bareinterval(5.0, 12.4)) === true

    @test in_interval(12.4, bareinterval(5.0, 12.4)) === true

    @test in_interval(0.0, entireinterval(BareInterval{Float64})) === true

    @test in_interval(5.0, entireinterval(BareInterval{Float64})) === true

    @test in_interval(6.3, entireinterval(BareInterval{Float64})) === true

    @test in_interval(12.4, entireinterval(BareInterval{Float64})) === true

    @test in_interval(0x1.FFFFFFFFFFFFFp1023, entireinterval(BareInterval{Float64})) === true

    @test in_interval(-0x1.FFFFFFFFFFFFFp1023, entireinterval(BareInterval{Float64})) === true

    @test in_interval(0x1.0p-1022, entireinterval(BareInterval{Float64})) === true

    @test in_interval(-0x1.0p-1022, entireinterval(BareInterval{Float64})) === true

    @test in_interval(-71.0, bareinterval(-27.0, 0.0)) === false

    @test in_interval(0.1, bareinterval(-27.0, 0.0)) === false

    @test in_interval(-0.01, bareinterval(0.0,0.0)) === false

    @test in_interval(0.000001, bareinterval(0.0,0.0)) === false

    @test in_interval(111110.0, bareinterval(-0.0,-0.0)) === false

    @test in_interval(4.9, bareinterval(5.0, 12.4)) === false

    @test in_interval(-6.3, bareinterval(5.0, 12.4)) === false

    @test in_interval(0.0, emptyinterval(BareInterval{Float64})) === false

    @test in_interval(-4535.3, emptyinterval(BareInterval{Float64})) === false

    @test in_interval(-Inf, emptyinterval(BareInterval{Float64})) === false

    @test in_interval(Inf, emptyinterval(BareInterval{Float64})) === false

    @test in_interval(NaN, emptyinterval(BareInterval{Float64})) === false

    @test in_interval(-Inf, entireinterval(BareInterval{Float64})) === false

    @test in_interval(Inf, entireinterval(BareInterval{Float64})) === false

    @test in_interval(NaN, entireinterval(BareInterval{Float64})) === false

end

@testset "minimal_is_member_dec_test" begin

    @test in_interval(-27.0, interval(bareinterval(-27.0,-27.0), trv)) === true

    @test in_interval(-27.0, interval(bareinterval(-27.0, 0.0), def)) === true

    @test in_interval(-7.0, interval(bareinterval(-27.0, 0.0), dac)) === true

    @test in_interval(0.0, interval(bareinterval(-27.0, 0.0), com)) === true

    @test in_interval(-0.0, interval(bareinterval(0.0,0.0), trv)) === true

    @test in_interval(0.0, interval(bareinterval(0.0,0.0), def)) === true

    @test in_interval(0.0, interval(bareinterval(-0.0,-0.0), dac)) === true

    @test in_interval(0.0, interval(bareinterval(-0.0,0.0), com)) === true

    @test in_interval(0.0, interval(bareinterval(0.0,-0.0), trv)) === true

    @test in_interval(5.0, interval(bareinterval(5.0, 12.4), def)) === true

    @test in_interval(6.3, interval(bareinterval(5.0, 12.4), dac)) === true

    @test in_interval(12.4, interval(bareinterval(5.0, 12.4), com)) === true

    @test in_interval(0.0, interval(entireinterval(BareInterval{Float64}), trv)) === true

    @test in_interval(5.0, interval(entireinterval(BareInterval{Float64}), def)) === true

    @test in_interval(6.3, interval(entireinterval(BareInterval{Float64}), dac)) === true

    @test in_interval(12.4, interval(entireinterval(BareInterval{Float64}), trv)) === true

    @test in_interval(0x1.FFFFFFFFFFFFFp1023, interval(entireinterval(BareInterval{Float64}), def)) === true

    @test in_interval(-0x1.FFFFFFFFFFFFFp1023, interval(entireinterval(BareInterval{Float64}), dac)) === true

    @test in_interval(0x1.0p-1022, interval(entireinterval(BareInterval{Float64}), trv)) === true

    @test in_interval(-0x1.0p-1022, interval(entireinterval(BareInterval{Float64}), def)) === true

    @test in_interval(-71.0, interval(bareinterval(-27.0, 0.0), trv)) === false

    @test in_interval(0.1, interval(bareinterval(-27.0, 0.0), def)) === false

    @test in_interval(-0.01, interval(bareinterval(0.0,0.0), dac)) === false

    @test in_interval(0.000001, interval(bareinterval(0.0,0.0), com)) === false

    @test in_interval(111110.0, interval(bareinterval(-0.0,-0.0), trv)) === false

    @test in_interval(4.9, interval(bareinterval(5.0, 12.4), def)) === false

    @test in_interval(-6.3, interval(bareinterval(5.0, 12.4), dac)) === false

    @test in_interval(0.0, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(0.0, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(-4535.3, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(-4535.3, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(-Inf, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(-Inf, nai(Interval{Float64})) === false

    @test in_interval(Inf, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(Inf, nai(Interval{Float64})) === false

    @test in_interval(NaN, interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(NaN, nai(Interval{Float64})) === false

    @test in_interval(-Inf, interval(entireinterval(BareInterval{Float64}), trv)) === false

    @test in_interval(Inf, interval(entireinterval(BareInterval{Float64}), def)) === false

    @test in_interval(NaN, interval(entireinterval(BareInterval{Float64}), dac)) === false

end
