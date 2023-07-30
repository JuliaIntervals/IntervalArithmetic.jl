@testset "minimal_is_common_interval_test" begin

    @test iscommon(interval(-27.0,-27.0)) == true

    @test iscommon(interval(-27.0, 0.0)) == true

    @test iscommon(interval(0.0,0.0)) == true

    @test iscommon(interval(-0.0,-0.0)) == true

    @test iscommon(interval(-0.0,0.0)) == true

    @test iscommon(interval(0.0,-0.0)) == true

    @test iscommon(interval(5.0, 12.4)) == true

    @test iscommon(interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023)) == true

    @test iscommon(entireinterval()) == false

    @test iscommon(emptyinterval()) == false

    @test iscommon(interval(-Inf, 0.0)) == false

    @test iscommon(interval(0.0, Inf)) == false

end

@testset "minimal_is_common_interval_dec_test" begin

    @test iscommon(DecoratedInterval(interval(-27.0,-27.0), com)) == true

    @test iscommon(DecoratedInterval(interval(-27.0, 0.0), com)) == true

    @test iscommon(DecoratedInterval(interval(0.0,0.0), com)) == true

    @test iscommon(DecoratedInterval(interval(-0.0,-0.0), com)) == true

    @test iscommon(DecoratedInterval(interval(-0.0,0.0), com)) == true

    @test iscommon(DecoratedInterval(interval(0.0,-0.0), com)) == true

    @test iscommon(DecoratedInterval(interval(5.0, 12.4), com)) == true

    @test iscommon(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), com)) == true

    @test iscommon(DecoratedInterval(interval(-27.0,-27.0), trv)) == true

    @test iscommon(DecoratedInterval(interval(-27.0, 0.0), def)) == true

    @test iscommon(DecoratedInterval(interval(0.0,0.0), dac)) == true

    @test iscommon(DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test iscommon(DecoratedInterval(interval(-0.0,0.0), def)) == true

    @test iscommon(DecoratedInterval(interval(0.0,-0.0), dac)) == true

    @test iscommon(DecoratedInterval(interval(5.0, 12.4), def)) == true

    @test iscommon(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), trv)) == true

    @test iscommon(DecoratedInterval(entireinterval(), dac)) == false

    @test iscommon(nai()) == false

    @test iscommon(DecoratedInterval(emptyinterval(), trv)) == false

    @test iscommon(DecoratedInterval(interval(-Inf, 0.0), trv)) == false

    @test iscommon(DecoratedInterval(interval(0.0, Inf), def)) == false

end

@testset "minimal_is_singleton_test" begin

    @test isthin(interval(-27.0,-27.0)) == true

    @test isthin(interval(-2.0, -2.0)) == true

    @test isthin(interval(12.0,12.0)) == true

    @test isthin(interval(17.1, 17.1)) == true

    @test isthin(interval(-0.0,-0.0)) == true

    @test isthin(interval(0.0,0.0)) == true

    @test isthin(interval(-0.0, 0.0)) == true

    @test isthin(interval(0.0, -0.0)) == true

    @test isthin(emptyinterval()) == false

    @test isthin(entireinterval()) == false

    @test isthin(interval(-1.0, 0.0)) == false

    @test isthin(interval(-1.0, -0.5)) == false

    @test isthin(interval(1.0, 2.0)) == false

    @test isthin(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)) == false

    @test isthin(interval(-1.0,Inf)) == false

end

@testset "minimal_is_singleton_dec_test" begin

    @test isthin(DecoratedInterval(interval(-27.0,-27.0), def)) == true

    @test isthin(DecoratedInterval(interval(-2.0, -2.0), trv)) == true

    @test isthin(DecoratedInterval(interval(12.0,12.0), dac)) == true

    @test isthin(DecoratedInterval(interval(17.1, 17.1), com)) == true

    @test isthin(DecoratedInterval(interval(-0.0,-0.0), def)) == true

    @test isthin(DecoratedInterval(interval(0.0,0.0), com)) == true

    @test isthin(DecoratedInterval(interval(-0.0, 0.0), def)) == true

    @test isthin(DecoratedInterval(interval(0.0, -0.0), dac)) == true

    @test isthin(DecoratedInterval(emptyinterval(), trv)) == false

    @test isthin(nai()) == false

    @test isthin(DecoratedInterval(entireinterval(), def)) == false

    @test isthin(DecoratedInterval(interval(-1.0, 0.0), dac)) == false

    @test isthin(DecoratedInterval(interval(-1.0, -0.5), com)) == false

    @test isthin(DecoratedInterval(interval(1.0, 2.0), def)) == false

    @test isthin(DecoratedInterval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac)) == false

    @test isthin(DecoratedInterval(interval(-1.0,Inf), trv)) == false

end

@testset "minimal_is_member_test" begin

    @test in(-27.0, interval(-27.0,-27.0)) == true

    @test in(-27.0, interval(-27.0, 0.0)) == true

    @test in(-7.0, interval(-27.0, 0.0)) == true

    @test in(0.0, interval(-27.0, 0.0)) == true

    @test in(-0.0, interval(0.0,0.0)) == true

    @test in(0.0, interval(0.0,0.0)) == true

    @test in(0.0, interval(-0.0,-0.0)) == true

    @test in(0.0, interval(-0.0,0.0)) == true

    @test in(0.0, interval(0.0,-0.0)) == true

    @test in(5.0, interval(5.0, 12.4)) == true

    @test in(6.3, interval(5.0, 12.4)) == true

    @test in(12.4, interval(5.0, 12.4)) == true

    @test in(0.0, entireinterval()) == true

    @test in(5.0, entireinterval()) == true

    @test in(6.3, entireinterval()) == true

    @test in(12.4, entireinterval()) == true

    @test in(0x1.FFFFFFFFFFFFFp1023, entireinterval()) == true

    @test in(-0x1.FFFFFFFFFFFFFp1023, entireinterval()) == true

    @test in(0x1.0p-1022, entireinterval()) == true

    @test in(-0x1.0p-1022, entireinterval()) == true

    @test in(-71.0, interval(-27.0, 0.0)) == false

    @test in(0.1, interval(-27.0, 0.0)) == false

    @test in(-0.01, interval(0.0,0.0)) == false

    @test in(0.000001, interval(0.0,0.0)) == false

    @test in(111110.0, interval(-0.0,-0.0)) == false

    @test in(4.9, interval(5.0, 12.4)) == false

    @test in(-6.3, interval(5.0, 12.4)) == false

    @test in(0.0, emptyinterval()) == false

    @test in(-4535.3, emptyinterval()) == false

    @test in(-Inf, emptyinterval()) == false

    @test in(Inf, emptyinterval()) == false

    @test in(NaN, emptyinterval()) == false

    @test in(-Inf, entireinterval()) == false

    @test in(Inf, entireinterval()) == false

    @test in(NaN, entireinterval()) == false

end

@testset "minimal_is_member_dec_test" begin

    @test in(-27.0, DecoratedInterval(interval(-27.0,-27.0), trv)) == true

    @test in(-27.0, DecoratedInterval(interval(-27.0, 0.0), def)) == true

    @test in(-7.0, DecoratedInterval(interval(-27.0, 0.0), dac)) == true

    @test in(0.0, DecoratedInterval(interval(-27.0, 0.0), com)) == true

    @test in(-0.0, DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test in(0.0, DecoratedInterval(interval(0.0,0.0), def)) == true

    @test in(0.0, DecoratedInterval(interval(-0.0,-0.0), dac)) == true

    @test in(0.0, DecoratedInterval(interval(-0.0,0.0), com)) == true

    @test in(0.0, DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test in(5.0, DecoratedInterval(interval(5.0, 12.4), def)) == true

    @test in(6.3, DecoratedInterval(interval(5.0, 12.4), dac)) == true

    @test in(12.4, DecoratedInterval(interval(5.0, 12.4), com)) == true

    @test in(0.0, DecoratedInterval(entireinterval(), trv)) == true

    @test in(5.0, DecoratedInterval(entireinterval(), def)) == true

    @test in(6.3, DecoratedInterval(entireinterval(), dac)) == true

    @test in(12.4, DecoratedInterval(entireinterval(), trv)) == true

    @test in(0x1.FFFFFFFFFFFFFp1023, DecoratedInterval(entireinterval(), def)) == true

    @test in(-0x1.FFFFFFFFFFFFFp1023, DecoratedInterval(entireinterval(), dac)) == true

    @test in(0x1.0p-1022, DecoratedInterval(entireinterval(), trv)) == true

    @test in(-0x1.0p-1022, DecoratedInterval(entireinterval(), def)) == true

    @test in(-71.0, DecoratedInterval(interval(-27.0, 0.0), trv)) == false

    @test in(0.1, DecoratedInterval(interval(-27.0, 0.0), def)) == false

    @test in(-0.01, DecoratedInterval(interval(0.0,0.0), dac)) == false

    @test in(0.000001, DecoratedInterval(interval(0.0,0.0), com)) == false

    @test in(111110.0, DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test in(4.9, DecoratedInterval(interval(5.0, 12.4), def)) == false

    @test in(-6.3, DecoratedInterval(interval(5.0, 12.4), dac)) == false

    @test in(0.0, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(0.0, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(-4535.3, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(-4535.3, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(-Inf, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(-Inf, nai()) == false

    @test in(Inf, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(Inf, nai()) == false

    @test in(NaN, DecoratedInterval(emptyinterval(), trv)) == false

    @test in(NaN, nai()) == false

    @test in(-Inf, DecoratedInterval(entireinterval(), trv)) == false

    @test in(Inf, DecoratedInterval(entireinterval(), def)) == false

    @test in(NaN, DecoratedInterval(entireinterval(), dac)) == false

end
