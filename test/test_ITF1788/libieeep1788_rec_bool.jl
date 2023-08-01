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

    @test issingleton(interval(-27.0,-27.0)) == true

    @test issingleton(interval(-2.0, -2.0)) == true

    @test issingleton(interval(12.0,12.0)) == true

    @test issingleton(interval(17.1, 17.1)) == true

    @test issingleton(interval(-0.0,-0.0)) == true

    @test issingleton(interval(0.0,0.0)) == true

    @test issingleton(interval(-0.0, 0.0)) == true

    @test issingleton(interval(0.0, -0.0)) == true

    @test issingleton(emptyinterval()) == false

    @test issingleton(entireinterval()) == false

    @test issingleton(interval(-1.0, 0.0)) == false

    @test issingleton(interval(-1.0, -0.5)) == false

    @test issingleton(interval(1.0, 2.0)) == false

    @test issingleton(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)) == false

    @test issingleton(interval(-1.0,Inf)) == false

end

@testset "minimal_is_singleton_dec_test" begin

    @test issingleton(DecoratedInterval(interval(-27.0,-27.0), def)) == true

    @test issingleton(DecoratedInterval(interval(-2.0, -2.0), trv)) == true

    @test issingleton(DecoratedInterval(interval(12.0,12.0), dac)) == true

    @test issingleton(DecoratedInterval(interval(17.1, 17.1), com)) == true

    @test issingleton(DecoratedInterval(interval(-0.0,-0.0), def)) == true

    @test issingleton(DecoratedInterval(interval(0.0,0.0), com)) == true

    @test issingleton(DecoratedInterval(interval(-0.0, 0.0), def)) == true

    @test issingleton(DecoratedInterval(interval(0.0, -0.0), dac)) == true

    @test issingleton(DecoratedInterval(emptyinterval(), trv)) == false

    @test issingleton(nai()) == false

    @test issingleton(DecoratedInterval(entireinterval(), def)) == false

    @test issingleton(DecoratedInterval(interval(-1.0, 0.0), dac)) == false

    @test issingleton(DecoratedInterval(interval(-1.0, -0.5), com)) == false

    @test issingleton(DecoratedInterval(interval(1.0, 2.0), def)) == false

    @test issingleton(DecoratedInterval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac)) == false

    @test issingleton(DecoratedInterval(interval(-1.0,Inf), trv)) == false

end

@testset "minimal_is_member_test" begin

    @test ismember(-27.0, interval(-27.0,-27.0)) == true

    @test ismember(-27.0, interval(-27.0, 0.0)) == true

    @test ismember(-7.0, interval(-27.0, 0.0)) == true

    @test ismember(0.0, interval(-27.0, 0.0)) == true

    @test ismember(-0.0, interval(0.0,0.0)) == true

    @test ismember(0.0, interval(0.0,0.0)) == true

    @test ismember(0.0, interval(-0.0,-0.0)) == true

    @test ismember(0.0, interval(-0.0,0.0)) == true

    @test ismember(0.0, interval(0.0,-0.0)) == true

    @test ismember(5.0, interval(5.0, 12.4)) == true

    @test ismember(6.3, interval(5.0, 12.4)) == true

    @test ismember(12.4, interval(5.0, 12.4)) == true

    @test ismember(0.0, entireinterval()) == true

    @test ismember(5.0, entireinterval()) == true

    @test ismember(6.3, entireinterval()) == true

    @test ismember(12.4, entireinterval()) == true

    @test ismember(0x1.FFFFFFFFFFFFFp1023, entireinterval()) == true

    @test ismember(-0x1.FFFFFFFFFFFFFp1023, entireinterval()) == true

    @test ismember(0x1.0p-1022, entireinterval()) == true

    @test ismember(-0x1.0p-1022, entireinterval()) == true

    @test ismember(-71.0, interval(-27.0, 0.0)) == false

    @test ismember(0.1, interval(-27.0, 0.0)) == false

    @test ismember(-0.01, interval(0.0,0.0)) == false

    @test ismember(0.000001, interval(0.0,0.0)) == false

    @test ismember(111110.0, interval(-0.0,-0.0)) == false

    @test ismember(4.9, interval(5.0, 12.4)) == false

    @test ismember(-6.3, interval(5.0, 12.4)) == false

    @test ismember(0.0, emptyinterval()) == false

    @test ismember(-4535.3, emptyinterval()) == false

    @test ismember(-Inf, emptyinterval()) == false

    @test ismember(Inf, emptyinterval()) == false

    @test ismember(NaN, emptyinterval()) == false

    @test ismember(-Inf, entireinterval()) == false

    @test ismember(Inf, entireinterval()) == false

    @test ismember(NaN, entireinterval()) == false

end

@testset "minimal_is_member_dec_test" begin

    @test ismember(-27.0, DecoratedInterval(interval(-27.0,-27.0), trv)) == true

    @test ismember(-27.0, DecoratedInterval(interval(-27.0, 0.0), def)) == true

    @test ismember(-7.0, DecoratedInterval(interval(-27.0, 0.0), dac)) == true

    @test ismember(0.0, DecoratedInterval(interval(-27.0, 0.0), com)) == true

    @test ismember(-0.0, DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test ismember(0.0, DecoratedInterval(interval(0.0,0.0), def)) == true

    @test ismember(0.0, DecoratedInterval(interval(-0.0,-0.0), dac)) == true

    @test ismember(0.0, DecoratedInterval(interval(-0.0,0.0), com)) == true

    @test ismember(0.0, DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test ismember(5.0, DecoratedInterval(interval(5.0, 12.4), def)) == true

    @test ismember(6.3, DecoratedInterval(interval(5.0, 12.4), dac)) == true

    @test ismember(12.4, DecoratedInterval(interval(5.0, 12.4), com)) == true

    @test ismember(0.0, DecoratedInterval(entireinterval(), trv)) == true

    @test ismember(5.0, DecoratedInterval(entireinterval(), def)) == true

    @test ismember(6.3, DecoratedInterval(entireinterval(), dac)) == true

    @test ismember(12.4, DecoratedInterval(entireinterval(), trv)) == true

    @test ismember(0x1.FFFFFFFFFFFFFp1023, DecoratedInterval(entireinterval(), def)) == true

    @test ismember(-0x1.FFFFFFFFFFFFFp1023, DecoratedInterval(entireinterval(), dac)) == true

    @test ismember(0x1.0p-1022, DecoratedInterval(entireinterval(), trv)) == true

    @test ismember(-0x1.0p-1022, DecoratedInterval(entireinterval(), def)) == true

    @test ismember(-71.0, DecoratedInterval(interval(-27.0, 0.0), trv)) == false

    @test ismember(0.1, DecoratedInterval(interval(-27.0, 0.0), def)) == false

    @test ismember(-0.01, DecoratedInterval(interval(0.0,0.0), dac)) == false

    @test ismember(0.000001, DecoratedInterval(interval(0.0,0.0), com)) == false

    @test ismember(111110.0, DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test ismember(4.9, DecoratedInterval(interval(5.0, 12.4), def)) == false

    @test ismember(-6.3, DecoratedInterval(interval(5.0, 12.4), dac)) == false

    @test ismember(0.0, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(0.0, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(-4535.3, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(-4535.3, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(-Inf, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(-Inf, nai()) == false

    @test ismember(Inf, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(Inf, nai()) == false

    @test ismember(NaN, DecoratedInterval(emptyinterval(), trv)) == false

    @test ismember(NaN, nai()) == false

    @test ismember(-Inf, DecoratedInterval(entireinterval(), trv)) == false

    @test ismember(Inf, DecoratedInterval(entireinterval(), def)) == false

    @test ismember(NaN, DecoratedInterval(entireinterval(), dac)) == false

end
