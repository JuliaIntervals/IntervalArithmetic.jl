@testset "minimal_cancel_plus_test" begin

    @test cancelplus(bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-1.0, Inf), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-Inf, -1.0), bareinterval(-5.0,1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-1.0, Inf), bareinterval(-5.0,1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(entireinterval(BareInterval{Float64}), bareinterval(-5.0,1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-1.0,5.0), bareinterval(1.0,Inf)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-1.0,5.0), bareinterval(-Inf,1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(entireinterval(BareInterval{Float64}), bareinterval(1.0,Inf)) === entireinterval(BareInterval{Float64})

    @test cancelplus(entireinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-5.0, -1.0), bareinterval(1.0,5.1)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-5.0, -1.0), bareinterval(0.9,5.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-5.0, -1.0), bareinterval(0.9,5.1)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.0,10.1)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.1,10.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.1,10.1)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.0,-0.9)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.1,-1.0)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.1,-0.9)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-10.0, -1.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-10.0, 5.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(1.0, 5.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(1.0,10.0)) === emptyinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,10.0)) === emptyinterval(BareInterval{Float64})

    @test cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-5.1,-0.0), bareinterval(0.0,5.0)) === bareinterval(-0x1.999999999998P-4,0.0)

    @test cancelplus(bareinterval(-5.1,-1.0), bareinterval(1.0,5.0)) === bareinterval(-0x1.999999999998P-4,0.0)

    @test cancelplus(bareinterval(-5.0,-0.9), bareinterval(1.0,5.0)) === bareinterval(0.0, 0x1.9999999999998P-4)

    @test cancelplus(bareinterval(-5.1,-0.9), bareinterval(1.0,5.0)) === bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4)

    @test cancelplus(bareinterval(-5.0,-1.0), bareinterval(1.0,5.0)) === bareinterval(0.0,0.0)

    @test cancelplus(bareinterval(-10.1, 5.0), bareinterval(-5.0,10.0)) === bareinterval(-0x1.999999999998P-4,0.0)

    @test cancelplus(bareinterval(-10.0, 5.1), bareinterval(-5.0,10.0)) === bareinterval(0.0,0x1.999999999998P-4)

    @test cancelplus(bareinterval(-10.1, 5.1), bareinterval(-5.0,10.0)) === bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4)

    @test cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.0,10.0)) === bareinterval(0.0,0.0)

    @test cancelplus(bareinterval(0.9, 5.0), bareinterval(-5.0,-1.0)) === bareinterval(-0x1.9999999999998P-4,0.0)

    @test cancelplus(bareinterval(1.0, 5.1), bareinterval(-5.0,-1.0)) === bareinterval(0.0,0x1.999999999998P-4)

    @test cancelplus(bareinterval(0.0, 5.1), bareinterval(-5.0,-0.0)) === bareinterval(0.0,0x1.999999999998P-4)

    @test cancelplus(bareinterval(0.9, 5.1), bareinterval(-5.0,-1.0)) === bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4)

    @test cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.0,-1.0)) === bareinterval(0.0,0.0)

    @test cancelplus(bareinterval(0.0, 5.0), bareinterval(-5.0,-0.0)) === bareinterval(0.0,0.0)

    @test cancelplus(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)) === bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test cancelplus(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,0.01)) === bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0)

    @test cancelplus(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0.0,0.0)

    @test cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0.0,0x1P+971)

    @test cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023)) === bareinterval(-0x1P+971,0.0)

    @test cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval(BareInterval{Float64})

    @test cancelplus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53)) === bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1)

    @test cancelplus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53)) === entireinterval(BareInterval{Float64})

end

@testset "minimal_cancel_plus_dec_test" begin

    @test cancelplus(interval(bareinterval(-Inf, -1.0), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-1.0, Inf), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(entireinterval(BareInterval{Float64}), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-Inf, -1.0), dac), interval(bareinterval(-5.0,1.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-1.0, Inf), trv), interval(bareinterval(-5.0,1.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-5.0,1.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-Inf, -1.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-1.0, Inf), def), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0, Inf), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-Inf,1.0), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-1.0,5.0), dac), interval(bareinterval(1.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-1.0,5.0), def), interval(bareinterval(-Inf,1.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-1.0,5.0), com), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(1.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf,1.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(entireinterval(BareInterval{Float64}), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-5.0, -1.0), com), interval(bareinterval(1.0,5.1), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-5.0, -1.0), dac), interval(bareinterval(0.9,5.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-5.0, -1.0), def), interval(bareinterval(0.9,5.1), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-10.0, 5.0), trv), interval(bareinterval(-5.0,10.1), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-10.0, 5.0), com), interval(bareinterval(-5.1,10.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-10.0, 5.0), dac), interval(bareinterval(-5.1,10.1), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(1.0, 5.0), def), interval(bareinterval(-5.0,-0.9), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(1.0, 5.0), trv), interval(bareinterval(-5.1,-1.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(1.0, 5.0), dac), interval(bareinterval(-5.1,-0.9), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-10.0, -1.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-10.0, 5.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(1.0, 5.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0,10.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-5.0,10.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-5.0,-1.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-5.1,-0.0), com), interval(bareinterval(0.0,5.0), com)) === interval(bareinterval(-0x1.999999999998P-4,0.0), trv)

    @test cancelplus(interval(bareinterval(-5.1,-1.0), com), interval(bareinterval(1.0,5.0), dac)) === interval(bareinterval(-0x1.999999999998P-4,0.0), trv)

    @test cancelplus(interval(bareinterval(-5.0,-0.9), com), interval(bareinterval(1.0,5.0), def)) === interval(bareinterval(0.0, 0x1.9999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(-5.1,-0.9), dac), interval(bareinterval(1.0,5.0), trv)) === interval(bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(-5.0,-1.0), dac), interval(bareinterval(1.0,5.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelplus(interval(bareinterval(-10.1, 5.0), dac), interval(bareinterval(-5.0,10.0), dac)) === interval(bareinterval(-0x1.999999999998P-4,0.0), trv)

    @test cancelplus(interval(bareinterval(-10.0, 5.1), def), interval(bareinterval(-5.0,10.0), def)) === interval(bareinterval(0.0,0x1.999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(-10.1, 5.1), def), interval(bareinterval(-5.0,10.0), trv)) === interval(bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(-10.0, 5.0), def), interval(bareinterval(-5.0,10.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelplus(interval(bareinterval(0.9, 5.0), trv), interval(bareinterval(-5.0,-1.0), dac)) === interval(bareinterval(-0x1.9999999999998P-4,0.0), trv)

    @test cancelplus(interval(bareinterval(1.0, 5.1), trv), interval(bareinterval(-5.0,-1.0), def)) === interval(bareinterval(0.0,0x1.999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(0.0, 5.1), trv), interval(bareinterval(-5.0,-0.0), trv)) === interval(bareinterval(0.0,0x1.999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(0.9, 5.1), com), interval(bareinterval(-5.0,-1.0), com)) === interval(bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelplus(interval(bareinterval(1.0, 5.0), dac), interval(bareinterval(-5.0,-1.0), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelplus(interval(bareinterval(0.0, 5.0), def), interval(bareinterval(-5.0,-0.0), trv)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelplus(interval(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), com), interval(bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4), com)) === interval(bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0), trv)

    @test cancelplus(interval(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), dac), interval(bareinterval(-0x1.999999999999AP-4,0.01), com)) === interval(bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0), trv)

    @test cancelplus(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), trv)

    @test cancelplus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelplus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0.0,0x1P+971), trv)

    @test cancelplus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com)) === interval(bareinterval(-0x1P+971,0.0), trv)

    @test cancelplus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelplus(interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), dac), interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), com)) === interval(bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1), trv)

    @test cancelplus(interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), def), interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), com)) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_cancel_minus_test" begin

    @test cancelminus(bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-1.0, Inf), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-Inf, -1.0), bareinterval(-1.0,5.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-1.0, Inf), bareinterval(-1.0,5.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(entireinterval(BareInterval{Float64}), bareinterval(-1.0,5.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-1.0,5.0), bareinterval(-1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(entireinterval(BareInterval{Float64}), bareinterval(-1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test cancelminus(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-5.0, -1.0), bareinterval(-5.1,-1.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-5.0, -1.0), bareinterval(-5.0,-0.9)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-5.0, -1.0), bareinterval(-5.1,-0.9)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.1, 5.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.0, 5.1)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.1, 5.1)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(1.0, 5.0), bareinterval(0.9, 5.0)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(1.0, 5.0), bareinterval(1.0, 5.1)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(1.0, 5.0), bareinterval(0.9, 5.1)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-10.0, -1.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-10.0, 5.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(1.0, 5.0), emptyinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-10.0, -1.0)) === emptyinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-10.0, 5.0)) === emptyinterval(BareInterval{Float64})

    @test cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 5.0)) === emptyinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-5.1,-0.0), bareinterval(-5.0, 0.0)) === bareinterval(-0x1.999999999998P-4,0.0)

    @test cancelminus(bareinterval(-5.1,-1.0), bareinterval(-5.0, -1.0)) === bareinterval(-0x1.999999999998P-4,0.0)

    @test cancelminus(bareinterval(-5.0,-0.9), bareinterval(-5.0, -1.0)) === bareinterval(0.0, 0x1.9999999999998P-4)

    @test cancelminus(bareinterval(-5.1,-0.9), bareinterval(-5.0, -1.0)) === bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4)

    @test cancelminus(bareinterval(-5.0,-1.0), bareinterval(-5.0, -1.0)) === bareinterval(0.0,0.0)

    @test cancelminus(bareinterval(-10.1, 5.0), bareinterval(-10.0, 5.0)) === bareinterval(-0x1.999999999998P-4,0.0)

    @test cancelminus(bareinterval(-10.0, 5.1), bareinterval(-10.0, 5.0)) === bareinterval(0.0,0x1.999999999998P-4)

    @test cancelminus(bareinterval(-10.1, 5.1), bareinterval(-10.0, 5.0)) === bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4)

    @test cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.0, 5.0)) === bareinterval(0.0,0.0)

    @test cancelminus(bareinterval(0.9, 5.0), bareinterval(1.0, 5.0)) === bareinterval(-0x1.9999999999998P-4,0.0)

    @test cancelminus(bareinterval(-0.0, 5.1), bareinterval(0.0, 5.0)) === bareinterval(0.0,0x1.999999999998P-4)

    @test cancelminus(bareinterval(1.0, 5.1), bareinterval(1.0, 5.0)) === bareinterval(0.0,0x1.999999999998P-4)

    @test cancelminus(bareinterval(0.9, 5.1), bareinterval(1.0, 5.0)) === bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4)

    @test cancelminus(bareinterval(1.0, 5.0), bareinterval(1.0, 5.0)) === bareinterval(0.0,0.0)

    @test cancelminus(bareinterval(-5.0, 1.0), bareinterval(-1.0, 5.0)) === bareinterval(-4.0,-4.0)

    @test cancelminus(bareinterval(-5.0, 0.0), bareinterval(-0.0, 5.0)) === bareinterval(-5.0,-5.0)

    @test cancelminus(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test cancelminus(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0.01,0x1.999999999999AP-4)) === bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0)

    @test cancelminus(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0.0,0.0)

    @test cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023)) === bareinterval(0.0,0x1P+971)

    @test cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-0x1P+971,0.0)

    @test cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)) === bareinterval(0.0,0.0)

    @test cancelminus(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)) === bareinterval(0x0.0000000000002p-1022,0x0.0000000000002p-1022)

    @test cancelminus(bareinterval(0x1P-1022,0x1.0000000000002P-1022), bareinterval(0x1P-1022,0x1.0000000000001P-1022)) === bareinterval(0.0,0x0.0000000000001P-1022)

    @test cancelminus(bareinterval(0x1P-1022,0x1.0000000000001P-1022), bareinterval(0x1P-1022,0x1.0000000000002P-1022)) === entireinterval(BareInterval{Float64})

    @test cancelminus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), bareinterval(-0x1.FFFFFFFFFFFFEP-53,0x1P+0)) === bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1)

    @test cancelminus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), bareinterval(-0x1.FFFFFFFFFFFFFP-53,0x1P+0)) === entireinterval(BareInterval{Float64})

end

@testset "minimal_cancel_minus_dec_test" begin

    @test cancelminus(interval(bareinterval(-Inf, -1.0), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-1.0, Inf), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(entireinterval(BareInterval{Float64}), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-Inf, -1.0), trv), interval(bareinterval(-1.0,5.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-1.0, Inf), dac), interval(bareinterval(-1.0,5.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-1.0,5.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-Inf, -1.0), def), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-1.0, Inf), trv), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-Inf, -1.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-1.0, Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(entireinterval(BareInterval{Float64}), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-1.0,5.0), dac), interval(bareinterval(-Inf, -1.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-1.0,5.0), def), interval(bareinterval(-1.0, Inf), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-1.0,5.0), com), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, -1.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-1.0, Inf), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(entireinterval(BareInterval{Float64}), dac), interval(entireinterval(BareInterval{Float64}), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-5.0, -1.0), com), interval(bareinterval(-5.1,-1.0), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-5.0, -1.0), dac), interval(bareinterval(-5.0,-0.9), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-5.0, -1.0), def), interval(bareinterval(-5.1,-0.9), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-10.0, 5.0), trv), interval(bareinterval(-10.1, 5.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-10.0, 5.0), com), interval(bareinterval(-10.0, 5.1), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-10.0, 5.0), dac), interval(bareinterval(-10.1, 5.1), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(1.0, 5.0), def), interval(bareinterval(0.9, 5.0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(1.0, 5.0), trv), interval(bareinterval(1.0, 5.1), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(1.0, 5.0), com), interval(bareinterval(0.9, 5.1), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-10.0, -1.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-10.0, 5.0), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(1.0, 5.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-10.0, -1.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-10.0, 5.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0, 5.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-5.1,-0.0), com), interval(bareinterval(-5.0, 0.0), com)) === interval(bareinterval(-0x1.999999999998P-4,0.0), trv)

    @test cancelminus(interval(bareinterval(-5.1,-1.0), dac), interval(bareinterval(-5.0, -1.0), com)) === interval(bareinterval(-0x1.999999999998P-4,0.0), trv)

    @test cancelminus(interval(bareinterval(-5.0,-0.9), def), interval(bareinterval(-5.0, -1.0), com)) === interval(bareinterval(0.0, 0x1.9999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(-5.1,-0.9), trv), interval(bareinterval(-5.0, -1.0), com)) === interval(bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(-5.0,-1.0), com), interval(bareinterval(-5.0, -1.0), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelminus(interval(bareinterval(-10.1, 5.0), dac), interval(bareinterval(-10.0, 5.0), dac)) === interval(bareinterval(-0x1.999999999998P-4,0.0), trv)

    @test cancelminus(interval(bareinterval(-10.0, 5.1), def), interval(bareinterval(-10.0, 5.0), dac)) === interval(bareinterval(0.0,0x1.999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(-10.1, 5.1), trv), interval(bareinterval(-10.0, 5.0), def)) === interval(bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(-10.0, 5.0), com), interval(bareinterval(-10.0, 5.0), def)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelminus(interval(bareinterval(0.9, 5.0), dac), interval(bareinterval(1.0, 5.0), def)) === interval(bareinterval(-0x1.9999999999998P-4,0.0), trv)

    @test cancelminus(interval(bareinterval(-0.0, 5.1), def), interval(bareinterval(0.0, 5.0), def)) === interval(bareinterval(0.0,0x1.999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(1.0, 5.1), trv), interval(bareinterval(1.0, 5.0), trv)) === interval(bareinterval(0.0,0x1.999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(0.9, 5.1), com), interval(bareinterval(1.0, 5.0), trv)) === interval(bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4), trv)

    @test cancelminus(interval(bareinterval(1.0, 5.0), dac), interval(bareinterval(1.0, 5.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelminus(interval(bareinterval(-5.0, 1.0), def), interval(bareinterval(-1.0, 5.0), def)) === interval(bareinterval(-4.0,-4.0), trv)

    @test cancelminus(interval(bareinterval(-5.0, 0.0), trv), interval(bareinterval(-0.0, 5.0), trv)) === interval(bareinterval(-5.0,-5.0), trv)

    @test cancelminus(interval(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), com), interval(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4), com)) === interval(bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0), trv)

    @test cancelminus(interval(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), def), interval(bareinterval(-0.01,0x1.999999999999AP-4), dac)) === interval(bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0), trv)

    @test cancelminus(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), trv)

    @test cancelminus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelminus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com)) === interval(bareinterval(0.0,0x1P+971), trv)

    @test cancelminus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-0x1P+971,0.0), trv)

    @test cancelminus(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com), interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com)) === interval(bareinterval(0.0,0.0), trv)

    @test cancelminus(interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com), interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), dac)) === interval(bareinterval(0x0.0000000000002p-1022,0x0.0000000000002p-1022), trv)

    @test cancelminus(interval(bareinterval(0x1P-1022,0x1.0000000000002P-1022), dac), interval(bareinterval(0x1P-1022,0x1.0000000000001P-1022), dac)) === interval(bareinterval(0.0,0x0.0000000000001P-1022), trv)

    @test cancelminus(interval(bareinterval(0x1P-1022,0x1.0000000000001P-1022), def), interval(bareinterval(0x1P-1022,0x1.0000000000002P-1022), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test cancelminus(interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), com), interval(bareinterval(-0x1.FFFFFFFFFFFFEP-53,0x1P+0), dac)) === interval(bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1), trv)

    @test cancelminus(interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), def), interval(bareinterval(-0x1.FFFFFFFFFFFFFP-53,0x1P+0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

end
