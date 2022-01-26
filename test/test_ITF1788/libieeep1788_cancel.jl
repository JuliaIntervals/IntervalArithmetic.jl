@testset "minimal_cancel_plus_test" begin

    @test cancelplus(interval(-Inf, -1.0), emptyinterval()) === entireinterval()

    @test cancelplus(interval(-1.0, Inf), emptyinterval()) === entireinterval()

    @test cancelplus(entireinterval(), emptyinterval()) === entireinterval()

    @test cancelplus(interval(-Inf, -1.0), interval(-5.0,1.0)) === entireinterval()

    @test cancelplus(interval(-1.0, Inf), interval(-5.0,1.0)) === entireinterval()

    @test cancelplus(entireinterval(), interval(-5.0,1.0)) === entireinterval()

    @test cancelplus(interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test cancelplus(interval(-1.0, Inf), entireinterval()) === entireinterval()

    @test cancelplus(emptyinterval(), interval(1.0, Inf)) === entireinterval()

    @test cancelplus(emptyinterval(), interval(-Inf,1.0)) === entireinterval()

    @test cancelplus(emptyinterval(), entireinterval()) === entireinterval()

    @test cancelplus(interval(-1.0,5.0), interval(1.0,Inf)) === entireinterval()

    @test cancelplus(interval(-1.0,5.0), interval(-Inf,1.0)) === entireinterval()

    @test cancelplus(interval(-1.0,5.0), entireinterval()) === entireinterval()

    @test cancelplus(entireinterval(), interval(1.0,Inf)) === entireinterval()

    @test cancelplus(entireinterval(), interval(-Inf,1.0)) === entireinterval()

    @test cancelplus(entireinterval(), entireinterval()) === entireinterval()

    @test cancelplus(interval(-5.0, -1.0), interval(1.0,5.1)) === entireinterval()

    @test cancelplus(interval(-5.0, -1.0), interval(0.9,5.0)) === entireinterval()

    @test cancelplus(interval(-5.0, -1.0), interval(0.9,5.1)) === entireinterval()

    @test cancelplus(interval(-10.0, 5.0), interval(-5.0,10.1)) === entireinterval()

    @test cancelplus(interval(-10.0, 5.0), interval(-5.1,10.0)) === entireinterval()

    @test cancelplus(interval(-10.0, 5.0), interval(-5.1,10.1)) === entireinterval()

    @test cancelplus(interval(1.0, 5.0), interval(-5.0,-0.9)) === entireinterval()

    @test cancelplus(interval(1.0, 5.0), interval(-5.1,-1.0)) === entireinterval()

    @test cancelplus(interval(1.0, 5.0), interval(-5.1,-0.9)) === entireinterval()

    @test cancelplus(interval(-10.0, -1.0), emptyinterval()) === entireinterval()

    @test cancelplus(interval(-10.0, 5.0), emptyinterval()) === entireinterval()

    @test cancelplus(interval(1.0, 5.0), emptyinterval()) === entireinterval()

    @test cancelplus(emptyinterval(), emptyinterval()) === emptyinterval()

    @test cancelplus(emptyinterval(), interval(1.0,10.0)) === emptyinterval()

    @test cancelplus(emptyinterval(), interval(-5.0,10.0)) === emptyinterval()

    @test cancelplus(emptyinterval(), interval(-5.0,-1.0)) === emptyinterval()

    @test cancelplus(interval(-5.1,-0.0), interval(0.0,5.0)) === Interval(-0x1.999999999998P-4,0.0)

    @test cancelplus(interval(-5.1,-1.0), interval(1.0,5.0)) === Interval(-0x1.999999999998P-4,0.0)

    @test cancelplus(interval(-5.0,-0.9), interval(1.0,5.0)) === Interval(0.0, 0x1.9999999999998P-4)

    @test cancelplus(interval(-5.1,-0.9), interval(1.0,5.0)) === Interval(-0x1.999999999998P-4,0x1.9999999999998P-4)

    @test cancelplus(interval(-5.0,-1.0), interval(1.0,5.0)) === Interval(0.0,0.0)

    @test cancelplus(interval(-10.1, 5.0), interval(-5.0,10.0)) === Interval(-0x1.999999999998P-4,0.0)

    @test cancelplus(interval(-10.0, 5.1), interval(-5.0,10.0)) === Interval(0.0,0x1.999999999998P-4)

    @test cancelplus(interval(-10.1, 5.1), interval(-5.0,10.0)) === Interval(-0x1.999999999998P-4,0x1.999999999998P-4)

    @test cancelplus(interval(-10.0, 5.0), interval(-5.0,10.0)) === Interval(0.0,0.0)

    @test cancelplus(interval(0.9, 5.0), interval(-5.0,-1.0)) === Interval(-0x1.9999999999998P-4,0.0)

    @test cancelplus(interval(1.0, 5.1), interval(-5.0,-1.0)) === Interval(0.0,0x1.999999999998P-4)

    @test cancelplus(interval(0.0, 5.1), interval(-5.0,-0.0)) === Interval(0.0,0x1.999999999998P-4)

    @test cancelplus(interval(0.9, 5.1), interval(-5.0,-1.0)) === Interval(-0x1.9999999999998P-4,0x1.999999999998P-4)

    @test cancelplus(interval(1.0, 5.0), interval(-5.0,-1.0)) === Interval(0.0,0.0)

    @test cancelplus(interval(0.0, 5.0), interval(-5.0,-0.0)) === Interval(0.0,0.0)

    @test cancelplus(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)) === Interval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test cancelplus(interval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), interval(-0x1.999999999999AP-4,0.01)) === Interval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0)

    @test cancelplus(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test cancelplus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === Interval(0.0,0.0)

    @test cancelplus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023)) === Interval(0.0,0x1P+971)

    @test cancelplus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023)) === Interval(-0x1P+971,0.0)

    @test cancelplus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval()

    @test cancelplus(interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval()

    @test cancelplus(interval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), interval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53)) === Interval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1)

    @test cancelplus(interval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), interval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53)) === entireinterval()

end

@testset "minimal_cancel_plus_dec_test" begin

    @test cancelplus(DecoratedInterval(interval(-Inf, -1.0), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-1.0, Inf), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(entireinterval(), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-Inf, -1.0), dac), DecoratedInterval(interval(-5.0,1.0), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-1.0, Inf), trv), DecoratedInterval(interval(-5.0,1.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-5.0,1.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-Inf, -1.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-1.0, Inf), def), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0, Inf), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,1.0), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-1.0,5.0), dac), DecoratedInterval(interval(1.0,Inf), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-1.0,5.0), def), DecoratedInterval(interval(-Inf,1.0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-1.0,5.0), com), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(1.0,Inf), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf,1.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-5.0, -1.0), com), DecoratedInterval(interval(1.0,5.1), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-5.0, -1.0), dac), DecoratedInterval(interval(0.9,5.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-5.0, -1.0), def), DecoratedInterval(interval(0.9,5.1), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, 5.0), trv), DecoratedInterval(interval(-5.0,10.1), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, 5.0), com), DecoratedInterval(interval(-5.1,10.0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, 5.0), dac), DecoratedInterval(interval(-5.1,10.1), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(1.0, 5.0), def), DecoratedInterval(interval(-5.0,-0.9), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(1.0, 5.0), trv), DecoratedInterval(interval(-5.1,-1.0), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(1.0, 5.0), dac), DecoratedInterval(interval(-5.1,-0.9), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, -1.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, 5.0), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(1.0, 5.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,10.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-5.0,10.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelplus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-5.0,-1.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-5.1,-0.0), com), DecoratedInterval(interval(0.0,5.0), com)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(-5.1,-1.0), com), DecoratedInterval(interval(1.0,5.0), dac)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(-5.0,-0.9), com), DecoratedInterval(interval(1.0,5.0), def)) === DecoratedInterval(Interval(0.0, 0x1.9999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(-5.1,-0.9), dac), DecoratedInterval(interval(1.0,5.0), trv)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0x1.9999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(-5.0,-1.0), dac), DecoratedInterval(interval(1.0,5.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(-10.1, 5.0), dac), DecoratedInterval(interval(-5.0,10.0), dac)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, 5.1), def), DecoratedInterval(interval(-5.0,10.0), def)) === DecoratedInterval(Interval(0.0,0x1.999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(-10.1, 5.1), def), DecoratedInterval(interval(-5.0,10.0), trv)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(-10.0, 5.0), def), DecoratedInterval(interval(-5.0,10.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(0.9, 5.0), trv), DecoratedInterval(interval(-5.0,-1.0), dac)) === DecoratedInterval(Interval(-0x1.9999999999998P-4,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(1.0, 5.1), trv), DecoratedInterval(interval(-5.0,-1.0), def)) === DecoratedInterval(Interval(0.0,0x1.999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(0.0, 5.1), trv), DecoratedInterval(interval(-5.0,-0.0), trv)) === DecoratedInterval(Interval(0.0,0x1.999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(0.9, 5.1), com), DecoratedInterval(interval(-5.0,-1.0), com)) === DecoratedInterval(Interval(-0x1.9999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelplus(DecoratedInterval(interval(1.0, 5.0), dac), DecoratedInterval(interval(-5.0,-1.0), dac)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(0.0, 5.0), def), DecoratedInterval(interval(-5.0,-0.0), trv)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), com), DecoratedInterval(interval(-0x1.999999999999AP-4,-0x1.999999999999AP-4), com)) === DecoratedInterval(Interval(0x1.E666666666656P+0,0x1.E666666666657P+0), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), dac), DecoratedInterval(interval(-0x1.999999999999AP-4,0.01), com)) === DecoratedInterval(Interval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0), trv)

    @test cancelplus(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFp1023,Inf), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0.0,0x1P+971), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com)) === DecoratedInterval(Interval(-0x1P+971,0.0), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), dac), DecoratedInterval(interval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), com)) === DecoratedInterval(Interval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1), trv)

    @test cancelplus(DecoratedInterval(interval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), def), DecoratedInterval(interval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), com)) === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_cancel_minus_test" begin

    @test cancelminus(interval(-Inf, -1.0), emptyinterval()) === entireinterval()

    @test cancelminus(interval(-1.0, Inf), emptyinterval()) === entireinterval()

    @test cancelminus(entireinterval(), emptyinterval()) === entireinterval()

    @test cancelminus(interval(-Inf, -1.0), interval(-1.0,5.0)) === entireinterval()

    @test cancelminus(interval(-1.0, Inf), interval(-1.0,5.0)) === entireinterval()

    @test cancelminus(entireinterval(), interval(-1.0,5.0)) === entireinterval()

    @test cancelminus(interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test cancelminus(interval(-1.0, Inf), entireinterval()) === entireinterval()

    @test cancelminus(emptyinterval(), interval(-Inf, -1.0)) === entireinterval()

    @test cancelminus(emptyinterval(), interval(-1.0, Inf)) === entireinterval()

    @test cancelminus(emptyinterval(), entireinterval()) === entireinterval()

    @test cancelminus(interval(-1.0,5.0), interval(-Inf, -1.0)) === entireinterval()

    @test cancelminus(interval(-1.0,5.0), interval(-1.0, Inf)) === entireinterval()

    @test cancelminus(interval(-1.0,5.0), entireinterval()) === entireinterval()

    @test cancelminus(entireinterval(), interval(-Inf, -1.0)) === entireinterval()

    @test cancelminus(entireinterval(), interval(-1.0, Inf)) === entireinterval()

    @test cancelminus(entireinterval(), entireinterval()) === entireinterval()

    @test cancelminus(interval(-5.0, -1.0), interval(-5.1,-1.0)) === entireinterval()

    @test cancelminus(interval(-5.0, -1.0), interval(-5.0,-0.9)) === entireinterval()

    @test cancelminus(interval(-5.0, -1.0), interval(-5.1,-0.9)) === entireinterval()

    @test cancelminus(interval(-10.0, 5.0), interval(-10.1, 5.0)) === entireinterval()

    @test cancelminus(interval(-10.0, 5.0), interval(-10.0, 5.1)) === entireinterval()

    @test cancelminus(interval(-10.0, 5.0), interval(-10.1, 5.1)) === entireinterval()

    @test cancelminus(interval(1.0, 5.0), interval(0.9, 5.0)) === entireinterval()

    @test cancelminus(interval(1.0, 5.0), interval(1.0, 5.1)) === entireinterval()

    @test cancelminus(interval(1.0, 5.0), interval(0.9, 5.1)) === entireinterval()

    @test cancelminus(interval(-10.0, -1.0), emptyinterval()) === entireinterval()

    @test cancelminus(interval(-10.0, 5.0), emptyinterval()) === entireinterval()

    @test cancelminus(interval(1.0, 5.0), emptyinterval()) === entireinterval()

    @test cancelminus(emptyinterval(), emptyinterval()) === emptyinterval()

    @test cancelminus(emptyinterval(), interval(-10.0, -1.0)) === emptyinterval()

    @test cancelminus(emptyinterval(), interval(-10.0, 5.0)) === emptyinterval()

    @test cancelminus(emptyinterval(), interval(1.0, 5.0)) === emptyinterval()

    @test cancelminus(interval(-5.1,-0.0), interval(-5.0, 0.0)) === Interval(-0x1.999999999998P-4,0.0)

    @test cancelminus(interval(-5.1,-1.0), interval(-5.0, -1.0)) === Interval(-0x1.999999999998P-4,0.0)

    @test cancelminus(interval(-5.0,-0.9), interval(-5.0, -1.0)) === Interval(0.0, 0x1.9999999999998P-4)

    @test cancelminus(interval(-5.1,-0.9), interval(-5.0, -1.0)) === Interval(-0x1.999999999998P-4,0x1.9999999999998P-4)

    @test cancelminus(interval(-5.0,-1.0), interval(-5.0, -1.0)) === Interval(0.0,0.0)

    @test cancelminus(interval(-10.1, 5.0), interval(-10.0, 5.0)) === Interval(-0x1.999999999998P-4,0.0)

    @test cancelminus(interval(-10.0, 5.1), interval(-10.0, 5.0)) === Interval(0.0,0x1.999999999998P-4)

    @test cancelminus(interval(-10.1, 5.1), interval(-10.0, 5.0)) === Interval(-0x1.999999999998P-4,0x1.999999999998P-4)

    @test cancelminus(interval(-10.0, 5.0), interval(-10.0, 5.0)) === Interval(0.0,0.0)

    @test cancelminus(interval(0.9, 5.0), interval(1.0, 5.0)) === Interval(-0x1.9999999999998P-4,0.0)

    @test cancelminus(interval(-0.0, 5.1), interval(0.0, 5.0)) === Interval(0.0,0x1.999999999998P-4)

    @test cancelminus(interval(1.0, 5.1), interval(1.0, 5.0)) === Interval(0.0,0x1.999999999998P-4)

    @test cancelminus(interval(0.9, 5.1), interval(1.0, 5.0)) === Interval(-0x1.9999999999998P-4,0x1.999999999998P-4)

    @test cancelminus(interval(1.0, 5.0), interval(1.0, 5.0)) === Interval(0.0,0.0)

    @test cancelminus(interval(-5.0, 1.0), interval(-1.0, 5.0)) === Interval(-4.0,-4.0)

    @test cancelminus(interval(-5.0, 0.0), interval(-0.0, 5.0)) === Interval(-5.0,-5.0)

    @test cancelminus(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test cancelminus(interval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), interval(-0.01,0x1.999999999999AP-4)) === Interval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0)

    @test cancelminus(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test cancelminus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === Interval(0.0,0.0)

    @test cancelminus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023)) === Interval(0.0,0x1P+971)

    @test cancelminus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023)) === Interval(-0x1P+971,0.0)

    @test cancelminus(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval()

    @test cancelminus(interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval()

    @test cancelminus(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)) === Interval(0.0,0.0)

    @test cancelminus(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)) === Interval(0x0.0000000000002p-1022,0x0.0000000000002p-1022)

    @test cancelminus(interval(0x1P-1022,0x1.0000000000002P-1022), interval(0x1P-1022,0x1.0000000000001P-1022)) === Interval(0.0,0x0.0000000000001P-1022)

    @test cancelminus(interval(0x1P-1022,0x1.0000000000001P-1022), interval(0x1P-1022,0x1.0000000000002P-1022)) === entireinterval()

    @test cancelminus(interval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), interval(-0x1.FFFFFFFFFFFFEP-53,0x1P+0)) === Interval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1)

    @test cancelminus(interval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), interval(-0x1.FFFFFFFFFFFFFP-53,0x1P+0)) === entireinterval()

end

@testset "minimal_cancel_minus_dec_test" begin

    @test cancelminus(DecoratedInterval(interval(-Inf, -1.0), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-1.0, Inf), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-Inf, -1.0), trv), DecoratedInterval(interval(-1.0,5.0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-1.0, Inf), dac), DecoratedInterval(interval(-1.0,5.0), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-1.0,5.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-Inf, -1.0), def), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-1.0, Inf), trv), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf, -1.0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-1.0, Inf), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(entireinterval(), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-1.0,5.0), dac), DecoratedInterval(interval(-Inf, -1.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-1.0,5.0), def), DecoratedInterval(interval(-1.0, Inf), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-1.0,5.0), com), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, -1.0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-1.0, Inf), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0, -1.0), com), DecoratedInterval(interval(-5.1,-1.0), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0, -1.0), dac), DecoratedInterval(interval(-5.0,-0.9), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0, -1.0), def), DecoratedInterval(interval(-5.1,-0.9), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, 5.0), trv), DecoratedInterval(interval(-10.1, 5.0), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, 5.0), com), DecoratedInterval(interval(-10.0, 5.1), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, 5.0), dac), DecoratedInterval(interval(-10.1, 5.1), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(1.0, 5.0), def), DecoratedInterval(interval(0.9, 5.0), def)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(1.0, 5.0), trv), DecoratedInterval(interval(1.0, 5.1), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(1.0, 5.0), com), DecoratedInterval(interval(0.9, 5.1), dac)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, -1.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, 5.0), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(1.0, 5.0), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-10.0, -1.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-10.0, 5.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelminus(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0, 5.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-5.1,-0.0), com), DecoratedInterval(interval(-5.0, 0.0), com)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-5.1,-1.0), dac), DecoratedInterval(interval(-5.0, -1.0), com)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0,-0.9), def), DecoratedInterval(interval(-5.0, -1.0), com)) === DecoratedInterval(Interval(0.0, 0x1.9999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(-5.1,-0.9), trv), DecoratedInterval(interval(-5.0, -1.0), com)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0x1.9999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0,-1.0), com), DecoratedInterval(interval(-5.0, -1.0), dac)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-10.1, 5.0), dac), DecoratedInterval(interval(-10.0, 5.0), dac)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, 5.1), def), DecoratedInterval(interval(-10.0, 5.0), dac)) === DecoratedInterval(Interval(0.0,0x1.999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(-10.1, 5.1), trv), DecoratedInterval(interval(-10.0, 5.0), def)) === DecoratedInterval(Interval(-0x1.999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(-10.0, 5.0), com), DecoratedInterval(interval(-10.0, 5.0), def)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(0.9, 5.0), dac), DecoratedInterval(interval(1.0, 5.0), def)) === DecoratedInterval(Interval(-0x1.9999999999998P-4,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-0.0, 5.1), def), DecoratedInterval(interval(0.0, 5.0), def)) === DecoratedInterval(Interval(0.0,0x1.999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(1.0, 5.1), trv), DecoratedInterval(interval(1.0, 5.0), trv)) === DecoratedInterval(Interval(0.0,0x1.999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(0.9, 5.1), com), DecoratedInterval(interval(1.0, 5.0), trv)) === DecoratedInterval(Interval(-0x1.9999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelminus(DecoratedInterval(interval(1.0, 5.0), dac), DecoratedInterval(interval(1.0, 5.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0, 1.0), def), DecoratedInterval(interval(-1.0, 5.0), def)) === DecoratedInterval(Interval(-4.0,-4.0), trv)

    @test cancelminus(DecoratedInterval(interval(-5.0, 0.0), trv), DecoratedInterval(interval(-0.0, 5.0), trv)) === DecoratedInterval(Interval(-5.0,-5.0), trv)

    @test cancelminus(DecoratedInterval(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), com), DecoratedInterval(interval(0x1.999999999999AP-4,0x1.999999999999AP-4), com)) === DecoratedInterval(Interval(0x1.E666666666656P+0,0x1.E666666666657P+0), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), def), DecoratedInterval(interval(-0.01,0x1.999999999999AP-4), dac)) === DecoratedInterval(Interval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0), trv)

    @test cancelminus(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFp1023,Inf), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com)) === DecoratedInterval(Interval(0.0,0x1P+971), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-0x1P+971,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com), DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test cancelminus(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com), DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), dac)) === DecoratedInterval(Interval(0x0.0000000000002p-1022,0x0.0000000000002p-1022), trv)

    @test cancelminus(DecoratedInterval(interval(0x1P-1022,0x1.0000000000002P-1022), dac), DecoratedInterval(interval(0x1P-1022,0x1.0000000000001P-1022), dac)) === DecoratedInterval(Interval(0.0,0x0.0000000000001P-1022), trv)

    @test cancelminus(DecoratedInterval(interval(0x1P-1022,0x1.0000000000001P-1022), def), DecoratedInterval(interval(0x1P-1022,0x1.0000000000002P-1022), com)) === DecoratedInterval(entireinterval(), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), com), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFEP-53,0x1P+0), dac)) === DecoratedInterval(Interval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1), trv)

    @test cancelminus(DecoratedInterval(interval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), def), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFP-53,0x1P+0), dac)) === DecoratedInterval(entireinterval(), trv)

end

