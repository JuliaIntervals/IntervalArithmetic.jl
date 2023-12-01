@testset "minimal_cancel_plus_test" begin

    @test isequal_interval(cancelplus(bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-1.0, Inf), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-Inf, -1.0), bareinterval(-5.0,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-1.0, Inf), bareinterval(-5.0,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(entireinterval(BareInterval{Float64}), bareinterval(-5.0,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-1.0,5.0), bareinterval(1.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-1.0,5.0), bareinterval(-Inf,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(entireinterval(BareInterval{Float64}), bareinterval(1.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(entireinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-5.0, -1.0), bareinterval(1.0,5.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-5.0, -1.0), bareinterval(0.9,5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-5.0, -1.0), bareinterval(0.9,5.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.0,10.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.1,10.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.1,10.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.0,-0.9)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.1,-1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.1,-0.9)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-10.0, -1.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-10.0, 5.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(1.0, 5.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(1.0,10.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,10.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-5.1,-0.0), bareinterval(0.0,5.0)), bareinterval(-0x1.999999999998P-4,0.0))

    @test isequal_interval(cancelplus(bareinterval(-5.1,-1.0), bareinterval(1.0,5.0)), bareinterval(-0x1.999999999998P-4,0.0))

    @test isequal_interval(cancelplus(bareinterval(-5.0,-0.9), bareinterval(1.0,5.0)), bareinterval(0.0, 0x1.9999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(-5.1,-0.9), bareinterval(1.0,5.0)), bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(-5.0,-1.0), bareinterval(1.0,5.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelplus(bareinterval(-10.1, 5.0), bareinterval(-5.0,10.0)), bareinterval(-0x1.999999999998P-4,0.0))

    @test isequal_interval(cancelplus(bareinterval(-10.0, 5.1), bareinterval(-5.0,10.0)), bareinterval(0.0,0x1.999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(-10.1, 5.1), bareinterval(-5.0,10.0)), bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(-10.0, 5.0), bareinterval(-5.0,10.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelplus(bareinterval(0.9, 5.0), bareinterval(-5.0,-1.0)), bareinterval(-0x1.9999999999998P-4,0.0))

    @test isequal_interval(cancelplus(bareinterval(1.0, 5.1), bareinterval(-5.0,-1.0)), bareinterval(0.0,0x1.999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(0.0, 5.1), bareinterval(-5.0,-0.0)), bareinterval(0.0,0x1.999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(0.9, 5.1), bareinterval(-5.0,-1.0)), bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4))

    @test isequal_interval(cancelplus(bareinterval(1.0, 5.0), bareinterval(-5.0,-1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelplus(bareinterval(0.0, 5.0), bareinterval(-5.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelplus(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)), bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0))

    @test isequal_interval(cancelplus(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,0.01)), bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0))

    @test isequal_interval(cancelplus(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0.0,0x1P+971))

    @test isequal_interval(cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023)), bareinterval(-0x1P+971,0.0))

    @test isequal_interval(cancelplus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelplus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53)), bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1))

    @test isequal_interval(cancelplus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53)), entireinterval(BareInterval{Float64}))

end

@testset "minimal_cancel_plus_dec_test" begin

    @test isequal_interval(cancelplus(Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-1.0, Inf), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.dac), Interval(bareinterval(-5.0,1.0), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-1.0, Inf), IntervalArithmetic.trv), Interval(bareinterval(-5.0,1.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-5.0,1.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-1.0, Inf), IntervalArithmetic.def), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0, Inf), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-Inf,1.0), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.dac), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.def), Interval(bareinterval(-Inf,1.0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.com), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf,1.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.com), Interval(bareinterval(1.0,5.1), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.dac), Interval(bareinterval(0.9,5.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.def), Interval(bareinterval(0.9,5.1), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.trv), Interval(bareinterval(-5.0,10.1), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.com), Interval(bareinterval(-5.1,10.0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.dac), Interval(bareinterval(-5.1,10.1), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.def), Interval(bareinterval(-5.0,-0.9), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.trv), Interval(bareinterval(-5.1,-1.0), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.dac), Interval(bareinterval(-5.1,-0.9), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, -1.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0,10.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-5.0,10.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.1,-0.0), IntervalArithmetic.com), Interval(bareinterval(0.0,5.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.1,-1.0), IntervalArithmetic.com), Interval(bareinterval(1.0,5.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.0,-0.9), IntervalArithmetic.com), Interval(bareinterval(1.0,5.0), IntervalArithmetic.def)), Interval(bareinterval(0.0, 0x1.9999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.1,-0.9), IntervalArithmetic.dac), Interval(bareinterval(1.0,5.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.dac), Interval(bareinterval(1.0,5.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.1, 5.0), IntervalArithmetic.dac), Interval(bareinterval(-5.0,10.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, 5.1), IntervalArithmetic.def), Interval(bareinterval(-5.0,10.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.1, 5.1), IntervalArithmetic.def), Interval(bareinterval(-5.0,10.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.def), Interval(bareinterval(-5.0,10.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(0.9, 5.0), IntervalArithmetic.trv), Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.9999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(1.0, 5.1), IntervalArithmetic.trv), Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(0.0, 5.1), IntervalArithmetic.trv), Interval(bareinterval(-5.0,-0.0), IntervalArithmetic.trv)), Interval(bareinterval(0.0,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(0.9, 5.1), IntervalArithmetic.com), Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.dac), Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(0.0, 5.0), IntervalArithmetic.def), Interval(bareinterval(-5.0,-0.0), IntervalArithmetic.trv)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), IntervalArithmetic.com), Interval(bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4), IntervalArithmetic.com)), Interval(bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), IntervalArithmetic.dac), Interval(bareinterval(-0x1.999999999999AP-4,0.01), IntervalArithmetic.com)), Interval(bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac), Interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1P+971), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), IntervalArithmetic.com)), Interval(bareinterval(-0x1P+971,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), IntervalArithmetic.dac), Interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), IntervalArithmetic.com)), Interval(bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1), IntervalArithmetic.trv))

    @test isequal_interval(cancelplus(Interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), IntervalArithmetic.def), Interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_cancel_minus_test" begin

    @test isequal_interval(cancelminus(bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-1.0, Inf), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-Inf, -1.0), bareinterval(-1.0,5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-1.0, Inf), bareinterval(-1.0,5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(entireinterval(BareInterval{Float64}), bareinterval(-1.0,5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-1.0,5.0), bareinterval(-1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(entireinterval(BareInterval{Float64}), bareinterval(-1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-5.0, -1.0), bareinterval(-5.1,-1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-5.0, -1.0), bareinterval(-5.0,-0.9)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-5.0, -1.0), bareinterval(-5.1,-0.9)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.1, 5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.0, 5.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.1, 5.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(1.0, 5.0), bareinterval(0.9, 5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(1.0, 5.0), bareinterval(1.0, 5.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(1.0, 5.0), bareinterval(0.9, 5.1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-10.0, -1.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-10.0, 5.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(1.0, 5.0), emptyinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-10.0, -1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(-10.0, 5.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 5.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-5.1,-0.0), bareinterval(-5.0, 0.0)), bareinterval(-0x1.999999999998P-4,0.0))

    @test isequal_interval(cancelminus(bareinterval(-5.1,-1.0), bareinterval(-5.0, -1.0)), bareinterval(-0x1.999999999998P-4,0.0))

    @test isequal_interval(cancelminus(bareinterval(-5.0,-0.9), bareinterval(-5.0, -1.0)), bareinterval(0.0, 0x1.9999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(-5.1,-0.9), bareinterval(-5.0, -1.0)), bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(-5.0,-1.0), bareinterval(-5.0, -1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelminus(bareinterval(-10.1, 5.0), bareinterval(-10.0, 5.0)), bareinterval(-0x1.999999999998P-4,0.0))

    @test isequal_interval(cancelminus(bareinterval(-10.0, 5.1), bareinterval(-10.0, 5.0)), bareinterval(0.0,0x1.999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(-10.1, 5.1), bareinterval(-10.0, 5.0)), bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(-10.0, 5.0), bareinterval(-10.0, 5.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelminus(bareinterval(0.9, 5.0), bareinterval(1.0, 5.0)), bareinterval(-0x1.9999999999998P-4,0.0))

    @test isequal_interval(cancelminus(bareinterval(-0.0, 5.1), bareinterval(0.0, 5.0)), bareinterval(0.0,0x1.999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(1.0, 5.1), bareinterval(1.0, 5.0)), bareinterval(0.0,0x1.999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(0.9, 5.1), bareinterval(1.0, 5.0)), bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4))

    @test isequal_interval(cancelminus(bareinterval(1.0, 5.0), bareinterval(1.0, 5.0)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelminus(bareinterval(-5.0, 1.0), bareinterval(-1.0, 5.0)), bareinterval(-4.0,-4.0))

    @test isequal_interval(cancelminus(bareinterval(-5.0, 0.0), bareinterval(-0.0, 5.0)), bareinterval(-5.0,-5.0))

    @test isequal_interval(cancelminus(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0))

    @test isequal_interval(cancelminus(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0.01,0x1.999999999999AP-4)), bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0))

    @test isequal_interval(cancelminus(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023)), bareinterval(0.0,0x1P+971))

    @test isequal_interval(cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-0x1P+971,0.0))

    @test isequal_interval(cancelminus(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)), bareinterval(0.0,0.0))

    @test isequal_interval(cancelminus(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)), bareinterval(0x0.0000000000002p-1022,0x0.0000000000002p-1022))

    @test isequal_interval(cancelminus(bareinterval(0x1P-1022,0x1.0000000000002P-1022), bareinterval(0x1P-1022,0x1.0000000000001P-1022)), bareinterval(0.0,0x0.0000000000001P-1022))

    @test isequal_interval(cancelminus(bareinterval(0x1P-1022,0x1.0000000000001P-1022), bareinterval(0x1P-1022,0x1.0000000000002P-1022)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(cancelminus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), bareinterval(-0x1.FFFFFFFFFFFFEP-53,0x1P+0)), bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1))

    @test isequal_interval(cancelminus(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), bareinterval(-0x1.FFFFFFFFFFFFFP-53,0x1P+0)), entireinterval(BareInterval{Float64}))

end

@testset "minimal_cancel_minus_dec_test" begin

    @test isequal_interval(cancelminus(Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-1.0, Inf), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.trv), Interval(bareinterval(-1.0,5.0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-1.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-1.0,5.0), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-1.0,5.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.def), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-1.0, Inf), IntervalArithmetic.trv), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-1.0, Inf), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.def), Interval(bareinterval(-1.0, Inf), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-1.0,5.0), IntervalArithmetic.com), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -1.0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-1.0, Inf), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.com), Interval(bareinterval(-5.1,-1.0), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.dac), Interval(bareinterval(-5.0,-0.9), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.def), Interval(bareinterval(-5.1,-0.9), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.trv), Interval(bareinterval(-10.1, 5.0), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.com), Interval(bareinterval(-10.0, 5.1), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.dac), Interval(bareinterval(-10.1, 5.1), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.def), Interval(bareinterval(0.9, 5.0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.trv), Interval(bareinterval(1.0, 5.1), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.com), Interval(bareinterval(0.9, 5.1), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, -1.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-10.0, -1.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0, 5.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.1,-0.0), IntervalArithmetic.com), Interval(bareinterval(-5.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.1,-1.0), IntervalArithmetic.dac), Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0,-0.9), IntervalArithmetic.def), Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0, 0x1.9999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.1,-0.9), IntervalArithmetic.trv), Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.999999999998P-4,0x1.9999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0,-1.0), IntervalArithmetic.com), Interval(bareinterval(-5.0, -1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.1, 5.0), IntervalArithmetic.dac), Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, 5.1), IntervalArithmetic.def), Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.1, 5.1), IntervalArithmetic.trv), Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.999999999998P-4,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.com), Interval(bareinterval(-10.0, 5.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0.9, 5.0), IntervalArithmetic.dac), Interval(bareinterval(1.0, 5.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.9999999999998P-4,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0.0, 5.1), IntervalArithmetic.def), Interval(bareinterval(0.0, 5.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(1.0, 5.1), IntervalArithmetic.trv), Interval(bareinterval(1.0, 5.0), IntervalArithmetic.trv)), Interval(bareinterval(0.0,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0.9, 5.1), IntervalArithmetic.com), Interval(bareinterval(1.0, 5.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.9999999999998P-4,0x1.999999999998P-4), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(1.0, 5.0), IntervalArithmetic.dac), Interval(bareinterval(1.0, 5.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(-1.0, 5.0), IntervalArithmetic.def)), Interval(bareinterval(-4.0,-4.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-5.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 5.0), IntervalArithmetic.trv)), Interval(bareinterval(-5.0,-5.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), IntervalArithmetic.com), Interval(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4), IntervalArithmetic.com)), Interval(bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), IntervalArithmetic.def), Interval(bareinterval(-0.01,0x1.999999999999AP-4), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.70A3D70A3D70BP-4,0x1.E666666666657P+0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1P+971), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-0x1P+971,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFEP+1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1.FFFFFFFFFFFFEP+1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.com), Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.com), Interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), IntervalArithmetic.dac)), Interval(bareinterval(0x0.0000000000002p-1022,0x0.0000000000002p-1022), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0x1P-1022,0x1.0000000000002P-1022), IntervalArithmetic.dac), Interval(bareinterval(0x1P-1022,0x1.0000000000001P-1022), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x0.0000000000001P-1022), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(0x1P-1022,0x1.0000000000001P-1022), IntervalArithmetic.def), Interval(bareinterval(0x1P-1022,0x1.0000000000002P-1022), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFFP-53), IntervalArithmetic.com), Interval(bareinterval(-0x1.FFFFFFFFFFFFEP-53,0x1P+0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.FFFFFFFFFFFFFP-1,-0x1.FFFFFFFFFFFFEP-1), IntervalArithmetic.trv))

    @test isequal_interval(cancelminus(Interval(bareinterval(-0x1P+0,0x1.FFFFFFFFFFFFEP-53), IntervalArithmetic.def), Interval(bareinterval(-0x1.FFFFFFFFFFFFFP-53,0x1P+0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end
