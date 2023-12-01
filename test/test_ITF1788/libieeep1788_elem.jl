@testset "minimal_pos_test" begin

    @test isequal_interval(+(bareinterval(1.0,2.0)), bareinterval(1.0,2.0))

    @test isequal_interval(+(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(+(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(1.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(+(bareinterval(-Inf,-1.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(+(bareinterval(0.0,2.0)), bareinterval(0.0,2.0))

    @test isequal_interval(+(bareinterval(-0.0,2.0)), bareinterval(0.0,2.0))

    @test isequal_interval(+(bareinterval(-2.5,-0.0)), bareinterval(-2.5,0.0))

    @test isequal_interval(+(bareinterval(-2.5,0.0)), bareinterval(-2.5,0.0))

    @test isequal_interval(+(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(+(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

end

@testset "minimal_pos_dec_test" begin

    @test isnai(+(nai()))

    @test isequal_interval(+(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(+(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(+(Interval(bareinterval(1.0, 2.0), IntervalArithmetic.com)), Interval(bareinterval(1.0, 2.0), IntervalArithmetic.com))

end

@testset "minimal_neg_test" begin

    @test isequal_interval(-(bareinterval(1.0,2.0)), bareinterval(-2.0,-1.0))

    @test isequal_interval(-(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(-(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(1.0,Inf)), bareinterval(-Inf,-1.0))

    @test isequal_interval(-(bareinterval(-Inf,1.0)), bareinterval(-1.0,Inf))

    @test isequal_interval(-(bareinterval(0.0,2.0)), bareinterval(-2.0,0.0))

    @test isequal_interval(-(bareinterval(-0.0,2.0)), bareinterval(-2.0,0.0))

    @test isequal_interval(-(bareinterval(-2.0,0.0)), bareinterval(0.0,2.0))

    @test isequal_interval(-(bareinterval(-2.0,-0.0)), bareinterval(0.0,2.0))

    @test isequal_interval(-(bareinterval(0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(-(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

end

@testset "minimal_neg_dec_test" begin

    @test isnai(-(nai()))

    @test isequal_interval(-(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(-(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(-(Interval(bareinterval(1.0, 2.0), IntervalArithmetic.com)), Interval(bareinterval(-2.0, -1.0), IntervalArithmetic.com))

end

@testset "minimal_add_test" begin

    @test isequal_interval(+(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(+(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(+(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(+(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(+(entireinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(entireinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(entireinterval(BareInterval{Float64}), bareinterval(-1.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(-Inf,1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(-1.0,1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(-Inf,2.0), bareinterval(-Inf,4.0)), bareinterval(-Inf,6.0))

    @test isequal_interval(+(bareinterval(-Inf,2.0), bareinterval(3.0,4.0)), bareinterval(-Inf,6.0))

    @test isequal_interval(+(bareinterval(-Inf,2.0), bareinterval(3.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(1.0,2.0), bareinterval(-Inf,4.0)), bareinterval(-Inf,6.0))

    @test isequal_interval(+(bareinterval(1.0,2.0), bareinterval(3.0,4.0)), bareinterval(4.0,6.0))

    @test isequal_interval(+(bareinterval(1.0,2.0), bareinterval(3.0,Inf)), bareinterval(4.0,Inf))

    @test isequal_interval(+(bareinterval(1.0,Inf), bareinterval(-Inf,4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(1.0,Inf), bareinterval(3.0,4.0)), bareinterval(4.0,Inf))

    @test isequal_interval(+(bareinterval(1.0,Inf), bareinterval(3.0,Inf)), bareinterval(4.0,Inf))

    @test isequal_interval(+(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(3.0,4.0)), bareinterval(4.0,Inf))

    @test isequal_interval(+(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(-3.0,4.0)), bareinterval(-Inf,6.0))

    @test isequal_interval(+(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(+(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(0.0,0.0)), bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(+(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0.0,-0.0)), bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(+(bareinterval(0.0,0.0), bareinterval(-3.0,4.0)), bareinterval(-3.0,4.0))

    @test isequal_interval(+(bareinterval(-0.0,-0.0), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(+(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1))

    @test isequal_interval(+(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)), bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0))

    @test isequal_interval(+(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(-0x1.E666666666657P+0,0x1.0CCCCCCCCCCC5P+1))

end

@testset "minimal_add_dec_test" begin

    @test isequal_interval(+(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,7.0), IntervalArithmetic.com)), Interval(bareinterval(6.0,9.0), IntervalArithmetic.com))

    @test isequal_interval(+(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,7.0), IntervalArithmetic.def)), Interval(bareinterval(6.0,9.0), IntervalArithmetic.def))

    @test isequal_interval(+(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(6.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(+(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), IntervalArithmetic.com), Interval(bareinterval(-0.1, 5.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,7.0), IntervalArithmetic.dac))

    @test isequal_interval(+(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isnai(+(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)))

end

@testset "minimal_sub_test" begin

    @test isequal_interval(-(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(-(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(-(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(-(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(-(entireinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(entireinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(entireinterval(BareInterval{Float64}), bareinterval(-1.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(-Inf,1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(-1.0,1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(-Inf,2.0), bareinterval(-Inf,4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(-Inf,2.0), bareinterval(3.0,4.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(-(bareinterval(-Inf,2.0), bareinterval(3.0,Inf)), bareinterval(-Inf,-1.0))

    @test isequal_interval(-(bareinterval(1.0,2.0), bareinterval(-Inf,4.0)), bareinterval(-3.0,Inf))

    @test isequal_interval(-(bareinterval(1.0,2.0), bareinterval(3.0,4.0)), bareinterval(-3.0,-1.0))

    @test isequal_interval(-(bareinterval(1.0,2.0), bareinterval(3.0,Inf)), bareinterval(-Inf,-1.0))

    @test isequal_interval(-(bareinterval(1.0,Inf), bareinterval(-Inf,4.0)), bareinterval(-3.0,Inf))

    @test isequal_interval(-(bareinterval(1.0,Inf), bareinterval(3.0,4.0)), bareinterval(-3.0,Inf))

    @test isequal_interval(-(bareinterval(1.0,Inf), bareinterval(3.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(-3.0,4.0)), bareinterval(-3.0,Inf))

    @test isequal_interval(-(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(3.0,4.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(-(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(-0x1.FFFFFFFFFFFFFp1023,4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(-(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(0.0,0.0)), bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(-(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0.0,-0.0)), bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(-(bareinterval(0.0,0.0), bareinterval(-3.0,4.0)), bareinterval(-4.0,3.0))

    @test isequal_interval(-(bareinterval(-0.0,-0.0), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-0x1.FFFFFFFFFFFFFp1023,3.0))

    @test isequal_interval(-(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0))

    @test isequal_interval(-(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)), bareinterval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1))

    @test isequal_interval(-(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(-0x1.0CCCCCCCCCCC5P+1,0x1.E666666666657P+0))

end

@testset "minimal_sub_dec_test" begin

    @test isequal_interval(-(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,7.0), IntervalArithmetic.com)), Interval(bareinterval(-6.0,-3.0), IntervalArithmetic.com))

    @test isequal_interval(-(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,7.0), IntervalArithmetic.def)), Interval(bareinterval(-6.0,-3.0), IntervalArithmetic.def))

    @test isequal_interval(-(Interval(bareinterval(-1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-Inf,-3.0), IntervalArithmetic.dac))

    @test isequal_interval(-(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), IntervalArithmetic.com), Interval(bareinterval(-1.0, 5.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,3.0), IntervalArithmetic.dac))

    @test isequal_interval(-(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isnai(-(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)))

end

@testset "minimal_mul_test" begin

    @test isequal_interval(*(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(1.0, 3.0)), bareinterval(1.0,Inf))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(-5.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(1.0,Inf), bareinterval(1.0, Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(*(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0)), bareinterval(-Inf,5.0))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0)), bareinterval(-3.0,Inf))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,Inf), bareinterval(1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0)), bareinterval(-15.0,Inf))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0)), bareinterval(-Inf,9.0))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,3.0), bareinterval(1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0)), bareinterval(3.0,Inf))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0)), bareinterval(-Inf,-3.0))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0)), bareinterval(3.0,Inf))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf)), bareinterval(-Inf,-3.0))

    @test isequal_interval(*(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(1.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(-5.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), bareinterval(1.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0)), bareinterval(-25.0,-1.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0)), bareinterval(-25.0,15.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(1.0, 3.0)), bareinterval(1.0,15.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0)), bareinterval(-Inf,15.0))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(-5.0, Inf)), bareinterval(-25.0,Inf))

    @test isequal_interval(*(bareinterval(1.0,5.0), bareinterval(1.0, Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(*(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0)), bareinterval(-25.0,5.0))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0)), bareinterval(-25.0,15.0))

    @test isequal_interval(*(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0)), bareinterval(-30.0,50.0))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0)), bareinterval(-10.0,50.0))

    @test isequal_interval(*(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0)), bareinterval(-10.0,10.0))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0)), bareinterval(-3.0,15.0))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,5.0), bareinterval(1.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0)), bareinterval(5.0,50.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0)), bareinterval(-30.0,50.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0)), bareinterval(-30.0,-5.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0)), bareinterval(5.0,Inf))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0)), bareinterval(-30.0,Inf))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf)), bareinterval(-Inf,50.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf)), bareinterval(-Inf,-5.0))

    @test isequal_interval(*(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(*(bareinterval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.FFFFFFFFFFFFP+0, Inf)), bareinterval(-0x1.FFFFFFFFFFFE1P+1,Inf))

    @test isequal_interval(*(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4)), bareinterval(-0x1.FFFFFFFFFFFE1P+1,0x1.999999999998EP-3))

    @test isequal_interval(*(bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-4), bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)), bareinterval(-0x1.999999999998EP-3,0x1.999999999998EP-3))

    @test isequal_interval(*(bareinterval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4), bareinterval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)), bareinterval(-0x1.FFFFFFFFFFFE1P+1,-0x1.47AE147AE147BP-7))

end

@testset "minimal_mul_dec_test" begin

    @test isequal_interval(*(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,7.0), IntervalArithmetic.com)), Interval(bareinterval(5.0,14.0), IntervalArithmetic.com))

    @test isequal_interval(*(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,7.0), IntervalArithmetic.def)), Interval(bareinterval(5.0,14.0), IntervalArithmetic.def))

    @test isequal_interval(*(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(5.0,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(5.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(*(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), IntervalArithmetic.com), Interval(bareinterval(-1.0, 5.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac))

    @test isequal_interval(*(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isnai(*(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)))

end

@testset "minimal_div_test" begin

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), bareinterval(0.1,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(3.0, 5.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(3.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-3.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-3.0, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), bareinterval(-0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-5.0, -3.0)), bareinterval(3.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(3.0, 5.0)), bareinterval(-10.0,-3.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(3.0,Inf)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-3.0, 0.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-3.0, -0.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(0.0, 3.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-0.0, 3.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), bareinterval(-0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-15.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-5.0, -3.0)), bareinterval(-5.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(3.0, 5.0)), bareinterval(-10.0,5.0))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-Inf, -3.0)), bareinterval(-5.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(3.0,Inf)), bareinterval(-10.0,5.0))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-3.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-3.0, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-Inf, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), bareinterval(-0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,15.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-5.0, -3.0)), bareinterval(-10.0,-3.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(3.0, 5.0)), bareinterval(3.0,10.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-Inf, -3.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(3.0,Inf)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-3.0, 0.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-3.0, -0.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(0.0, 3.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-0.0, 3.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,30.0), bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,30.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-5.0, -3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(3.0, 5.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(3.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-3.0, 0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-3.0, -0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-3.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(0.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-0.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-3.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(0.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), bareinterval(-0.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-5.0, -3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(3.0, 5.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(3.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-3.0, 0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-3.0, -0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-3.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(0.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-0.0, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-3.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(0.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), bareinterval(-0.0, Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-5.0, -3.0)), bareinterval(3.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(3.0, 5.0)), bareinterval(-Inf,-3.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(3.0,Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-3.0, 0.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-3.0, -0.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(0.0, 3.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-0.0, 3.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), bareinterval(-0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-15.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-5.0, -3.0)), bareinterval(-5.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(3.0, 5.0)), bareinterval(-Inf,5.0))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-Inf, -3.0)), bareinterval(-5.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(3.0,Inf)), bareinterval(-Inf,5.0))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-3.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-3.0, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-Inf, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), bareinterval(-0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,15.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-5.0, -3.0)), bareinterval(-Inf,5.0))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(3.0, 5.0)), bareinterval(-5.0,Inf))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-Inf, -3.0)), bareinterval(-Inf,5.0))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(3.0,Inf)), bareinterval(-5.0,Inf))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-3.0, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-3.0, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-Inf, 0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-0.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-Inf, -0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), bareinterval(-0.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-15.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-5.0, -3.0)), bareinterval(-Inf,-3.0))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(3.0, 5.0)), bareinterval(3.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-Inf, -3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(3.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-3.0, 0.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-3.0, -0.0)), bareinterval(-Inf,-5.0))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(0.0, 3.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-0.0, 3.0)), bareinterval(5.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,Inf), bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(15.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-5.0, -3.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(3.0, 5.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(3.0,Inf)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-3.0, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-3.0, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), bareinterval(-0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-5.0, -3.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(3.0, 5.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(3.0,Inf)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-3.0, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-3.0, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), bareinterval(-0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-30.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-5.0, -3.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(3.0, 5.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-Inf, -3.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(3.0,Inf)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-3.0, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-3.0, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,30.0), bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,30.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-5.0, -3.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(3.0, 5.0)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-Inf, -3.0)), bareinterval(-10.0,0.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(3.0,Inf)), bareinterval(0.0,10.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-3.0, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-3.0, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,30.0), bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,30.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-5.0, -3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(3.0, 5.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(3.0,Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-3.0, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-3.0, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,0.0), bareinterval(-0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-5.0, -3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(3.0, 5.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-Inf, -3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(3.0,Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-3.0, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-3.0, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-Inf, 0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-0.0, 3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-Inf, -0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), bareinterval(-0.0, Inf)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-5.0, -3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(3.0, 5.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-Inf, -3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(3.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-3.0, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-3.0, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,Inf), bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-5.0, -3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(3.0, 5.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-Inf, -3.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(3.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-3.0, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-3.0, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-3.0, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-0.0, 3.0)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-Inf, 3.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-3.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,Inf), bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(/(bareinterval(-0.0,Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-2.0,-1.0), bareinterval(-10.0, -3.0)), bareinterval(0x1.9999999999999P-4,0x1.5555555555556P-1))

    @test isequal_interval(/(bareinterval(-2.0,-1.0), bareinterval(0.0, 10.0)), bareinterval(-Inf,-0x1.9999999999999P-4))

    @test isequal_interval(/(bareinterval(-2.0,-1.0), bareinterval(-0.0, 10.0)), bareinterval(-Inf,-0x1.9999999999999P-4))

    @test isequal_interval(/(bareinterval(-1.0,2.0), bareinterval(10.0,Inf)), bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-3))

    @test isequal_interval(/(bareinterval(1.0,3.0), bareinterval(-Inf, -10.0)), bareinterval(-0x1.3333333333334P-2,0.0))

    @test isequal_interval(/(bareinterval(-Inf,-1.0), bareinterval(1.0, 3.0)), bareinterval(-Inf,-0x1.5555555555555P-2))

end

@testset "minimal_div_dec_test" begin

    @test isequal_interval(/(Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.com), Interval(bareinterval(-10.0, -3.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.9999999999999P-4,0x1.5555555555556P-1), IntervalArithmetic.com))

    @test isequal_interval(/(Interval(bareinterval(-200.0,-1.0), IntervalArithmetic.com), Interval(bareinterval(0x0.0000000000001p-1022, 10.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,-0x1.9999999999999P-4), IntervalArithmetic.dac))

    @test isequal_interval(/(Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 10.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,-0x1.9999999999999P-4), IntervalArithmetic.trv))

    @test isequal_interval(/(Interval(bareinterval(1.0,3.0), IntervalArithmetic.def), Interval(bareinterval(-Inf, -10.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.3333333333334P-2,0.0), IntervalArithmetic.def))

    @test isequal_interval(/(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isnai(/(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)))

end

@testset "minimal_recip_test" begin

    @test isequal_interval(inv(bareinterval(-50.0, -10.0)), bareinterval(-0x1.999999999999AP-4,-0x1.47AE147AE147AP-6))

    @test isequal_interval(inv(bareinterval(10.0, 50.0)), bareinterval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4))

    @test isequal_interval(inv(bareinterval(-Inf, -10.0)), bareinterval(-0x1.999999999999AP-4,0.0))

    @test isequal_interval(inv(bareinterval(10.0,Inf)), bareinterval(0.0,0x1.999999999999AP-4))

    @test isequal_interval(inv(bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(inv(bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(inv(bareinterval(-10.0, 0.0)), bareinterval(-Inf,-0x1.9999999999999P-4))

    @test isequal_interval(inv(bareinterval(-10.0, -0.0)), bareinterval(-Inf,-0x1.9999999999999P-4))

    @test isequal_interval(inv(bareinterval(-10.0, 10.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(inv(bareinterval(0.0, 10.0)), bareinterval(0x1.9999999999999P-4,Inf))

    @test isequal_interval(inv(bareinterval(-0.0, 10.0)), bareinterval(0x1.9999999999999P-4,Inf))

    @test isequal_interval(inv(bareinterval(-Inf, 0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(inv(bareinterval(-Inf, -0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(inv(bareinterval(-Inf, 10.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(inv(bareinterval(-10.0, Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(inv(bareinterval(0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(inv(bareinterval(-0.0, Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(inv(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

end

@testset "minimal_recip_dec_test" begin

    @test isequal_interval(inv(Interval(bareinterval(10.0, 50.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4), IntervalArithmetic.com))

    @test isequal_interval(inv(Interval(bareinterval(-Inf, -10.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.999999999999AP-4,0.0), IntervalArithmetic.dac))

    @test isequal_interval(inv(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023, -0x0.0000000000001p-1022), IntervalArithmetic.def)), Interval(bareinterval(-Inf,-0x0.4P-1022), IntervalArithmetic.def))

    @test isequal_interval(inv(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(inv(Interval(bareinterval(-10.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,-0x1.9999999999999P-4), IntervalArithmetic.trv))

    @test isequal_interval(inv(Interval(bareinterval(-10.0, Inf), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(inv(Interval(bareinterval(-0.0, Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(inv(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_sqr_test" begin

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 2), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0x0.0000000000001p-1022), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-1.0,1.0), 2), bareinterval(0.0,1.0))

    @test isequal_interval(nthpow(bareinterval(0.0,1.0), 2), bareinterval(0.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,1.0), 2), bareinterval(0.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-5.0,3.0), 2), bareinterval(0.0,25.0))

    @test isequal_interval(nthpow(bareinterval(-5.0,0.0), 2), bareinterval(0.0,25.0))

    @test isequal_interval(nthpow(bareinterval(-5.0,-0.0), 2), bareinterval(0.0,25.0))

    @test isequal_interval(nthpow(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4), 2), bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4), 2), bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFP+0,-0x1.FFFFFFFFFFFFP+0), 2), bareinterval(0x1.FFFFFFFFFFFEP+1,0x1.FFFFFFFFFFFE1P+1))

end

@testset "minimal_sqr_dec_test" begin

    @test isequal_interval(nthpow(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x0.0000000000001p-1022), IntervalArithmetic.com), 2), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(nthpow(Interval(bareinterval(-1.0,1.0), IntervalArithmetic.def), 2), Interval(bareinterval(0.0,1.0), IntervalArithmetic.def))

    @test isequal_interval(nthpow(Interval(bareinterval(-5.0,3.0), IntervalArithmetic.com), 2), Interval(bareinterval(0.0,25.0), IntervalArithmetic.com))

    @test isequal_interval(nthpow(Interval(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4), IntervalArithmetic.com), 2), Interval(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), IntervalArithmetic.com))

end

@testset "minimal_sqrt_test" begin

    @test isequal_interval(sqrt(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sqrt(entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(sqrt(bareinterval(-Inf,-0x0.0000000000001p-1022)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sqrt(bareinterval(-1.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(sqrt(bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(sqrt(bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(sqrt(bareinterval(-5.0,25.0)), bareinterval(0.0,5.0))

    @test isequal_interval(sqrt(bareinterval(0.0,25.0)), bareinterval(0.0,5.0))

    @test isequal_interval(sqrt(bareinterval(-0.0,25.0)), bareinterval(0.0,5.0))

    @test isequal_interval(sqrt(bareinterval(-5.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(sqrt(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(0x1.43D136248490FP-2,0x1.43D136248491P-2))

    @test isequal_interval(sqrt(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)), bareinterval(0.0,0x1.43D136248491P-2))

    @test isequal_interval(sqrt(bareinterval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)), bareinterval(0x1.43D136248490FP-2,0x1.6A09E667F3BC7P+0))

end

@testset "minimal_sqrt_dec_test" begin

    @test isequal_interval(sqrt(Interval(bareinterval(1.0,4.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,2.0), IntervalArithmetic.com))

    @test isequal_interval(sqrt(Interval(bareinterval(-5.0,25.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,5.0), IntervalArithmetic.trv))

    @test isequal_interval(sqrt(Interval(bareinterval(0.0,25.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,5.0), IntervalArithmetic.def))

    @test isequal_interval(sqrt(Interval(bareinterval(-5.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

end

@testset "minimal_fma_test" begin

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,7.0))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,11.0))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,17.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,17.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,17.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,7.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,17.0))

    @test isequal_interval(fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,52.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,52.0))

    @test isequal_interval(fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,12.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,17.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,52.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,52.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)), bareinterval(-Inf,-3.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,52.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)), bareinterval(-Inf,-3.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,7.0))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-5.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-17.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,11.0))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(1.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), bareinterval(1.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-Inf,-1.0))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-27.0,1.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-27.0,17.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-1.0,17.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,1.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), bareinterval(-Inf,17.0))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-27.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(-27.0,7.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-27.0,17.0))

    @test isequal_interval(fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-32.0,52.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), bareinterval(-2.0,2.0)), bareinterval(-12.0,52.0))

    @test isequal_interval(fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-12.0,12.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-5.0,17.0))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)), bareinterval(3.0,52.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-32.0,52.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)), bareinterval(-32.0,-3.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)), bareinterval(3.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)), bareinterval(-32.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-Inf,52.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)), bareinterval(-Inf,-3.0))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-5.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(-17.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(-27.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-27.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-27.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), bareinterval(-1.0,Inf))

    @test isequal_interval(fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(-27.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-27.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-32.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), bareinterval(-2.0,Inf)), bareinterval(-12.0,Inf))

    @test isequal_interval(fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-12.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-5.0,Inf))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)), bareinterval(3.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-32.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)), bareinterval(-32.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)), bareinterval(3.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)), bareinterval(-32.0,Inf))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(fma(bareinterval(0.1,0.5), bareinterval(-5.0, 3.0), bareinterval(-0.1,0.1)), bareinterval(-0x1.4CCCCCCCCCCCDP+1,0x1.999999999999AP+0))

    @test isequal_interval(fma(bareinterval(-0.5,0.2), bareinterval(-5.0, 3.0), bareinterval(-0.1,0.1)), bareinterval(-0x1.999999999999AP+0,0x1.4CCCCCCCCCCCDP+1))

    @test isequal_interval(fma(bareinterval(-0.5,-0.1), bareinterval(2.0, 3.0), bareinterval(-0.1,0.1)), bareinterval(-0x1.999999999999AP+0,-0x1.999999999999AP-4))

    @test isequal_interval(fma(bareinterval(-0.5,-0.1), bareinterval(-Inf, 3.0), bareinterval(-0.1,0.1)), bareinterval(-0x1.999999999999AP+0,Inf))

end

@testset "minimal_fma_dec_test" begin

    @test isequal_interval(fma(Interval(bareinterval(-0.5,-0.1), IntervalArithmetic.com), Interval(bareinterval(-Inf, 3.0), IntervalArithmetic.dac), Interval(bareinterval(-0.1,0.1), IntervalArithmetic.com)), Interval(bareinterval(-0x1.999999999999AP+0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(fma(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(1.0, 0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com), Interval(bareinterval(0.0,1.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(fma(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(1.0, 2.0), IntervalArithmetic.com), Interval(bareinterval(2.0,5.0), IntervalArithmetic.com)), Interval(bareinterval(3.0,9.0), IntervalArithmetic.com))

end

@testset "minimal_pown_test" begin

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 0), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), 0), bareinterval(1.0,1.0))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 2), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), 2), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), 2), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), 2), bareinterval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), 2), bareinterval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 2), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), 2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), 2), bareinterval(0.0,0x1.9AD27D70A3D72P+16))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), 2), bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), 2), bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 8), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), 8), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), 8), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), 8), bareinterval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), 8), bareinterval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 8), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), 8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), 8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), 8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), 8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), 8), bareinterval(0.0,0x1.A87587109655P+66))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), 8), bareinterval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), 8), bareinterval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 1), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 1), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), 1), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), 1), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), 1), bareinterval(13.1,13.1))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), 1), bareinterval(-7451.145,-7451.145))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1), bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1), bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), 1), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), 1), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), 1), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), 1), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), 1), bareinterval(-324.3,2.5))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), 1), bareinterval(0.01,2.33))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), 1), bareinterval(-1.9,-0.33))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 3), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 3), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), 3), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), 3), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), 3), bareinterval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), 3), bareinterval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3), bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), 3), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), 3), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), 3), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), 3), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), 3), bareinterval(-0x1.0436D2F418938P+25,0x1.F4P+3))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), 3), bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), 3), bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), 7), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), 7), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), 7), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), 7), bareinterval(0.0,0.0))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), 7), bareinterval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), 7), bareinterval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7), bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), 7), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), 7), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), 7), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), 7), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), 7), bareinterval(-0x1.4F109959E6D7FP+58,0x1.312DP+9))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), 7), bareinterval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), 7), bareinterval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), -2), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), -2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), -2), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), -2), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), -2), bareinterval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), -2), bareinterval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -2), bareinterval(0x0P+0,0x0.0000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -2), bareinterval(0x0P+0,0x0.0000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), -2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), -2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), -2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), -2), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), -2), bareinterval(0x1.3F0C482C977C9P-17,Inf))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), -2), bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), -2), bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), -8), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), -8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), -8), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), -8), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), -8), bareinterval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), -8), bareinterval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -8), bareinterval(0x0P+0,0x0.0000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -8), bareinterval(0x0P+0,0x0.0000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), -8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), -8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), -8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), -8), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), -8), bareinterval(0x1.34CC3764D1E0CP-67,Inf))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), -8), bareinterval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), -8), bareinterval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), -1), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), -1), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), -1), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), -1), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), -1), bareinterval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), -1), bareinterval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -1), bareinterval(0x0.4P-1022,0x0.4000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -1), bareinterval(-0x0.4000000000001P-1022,-0x0.4P-1022))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), -1), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), -1), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), -1), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), -1), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), -1), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), -1), bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), -1), bareinterval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), -3), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), -3), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), -3), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), -3), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), -3), bareinterval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), -3), bareinterval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -3), bareinterval(0x0P+0,0x0.0000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -3), bareinterval(-0x0.0000000000001P-1022,-0x0P+0))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), -3), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), -3), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), -3), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), -3), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), -3), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), -3), bareinterval(0x1.43CFBA61AACABP-4,0x1.E848P+19))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), -3), bareinterval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3))

    @test isequal_interval(nthpow(emptyinterval(BareInterval{Float64}), -7), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(entireinterval(BareInterval{Float64}), -7), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.0,0.0), -7), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(-0.0,-0.0), -7), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(13.1,13.1), -7), bareinterval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26))

    @test isequal_interval(nthpow(bareinterval(-7451.145,-7451.145), -7), bareinterval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91))

    @test isequal_interval(nthpow(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -7), bareinterval(0x0P+0,0x0.0000000000001P-1022))

    @test isequal_interval(nthpow(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -7), bareinterval(-0x0.0000000000001P-1022,-0x0P+0))

    @test isequal_interval(nthpow(bareinterval(0.0,Inf), -7), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-0.0,Inf), -7), bareinterval(0.0,Inf))

    @test isequal_interval(nthpow(bareinterval(-Inf,0.0), -7), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-Inf,-0.0), -7), bareinterval(-Inf,0.0))

    @test isequal_interval(nthpow(bareinterval(-324.3,2.5), -7), entireinterval(BareInterval{Float64}))

    @test isequal_interval(nthpow(bareinterval(0.01,2.33), -7), bareinterval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46))

    @test isequal_interval(nthpow(bareinterval(-1.9,-0.33), -7), bareinterval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7))

end

@testset "minimal_pown_dec_test" begin

    @test isequal_interval(nthpow(Interval(bareinterval(-5.0,10.0), IntervalArithmetic.com), 0), Interval(bareinterval(1.0,1.0), IntervalArithmetic.com))

    @test isequal_interval(nthpow(Interval(bareinterval(-Inf,15.0), IntervalArithmetic.dac), 0), Interval(bareinterval(1.0,1.0), IntervalArithmetic.dac))

    @test isequal_interval(nthpow(Interval(bareinterval(-3.0,5.0), IntervalArithmetic.def), 2), Interval(bareinterval(0.0,25.0), IntervalArithmetic.def))

    @test isequal_interval(nthpow(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), IntervalArithmetic.com), 2), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(nthpow(Interval(bareinterval(-3.0,5.0), IntervalArithmetic.dac), 3), Interval(bareinterval(-27.0,125.0), IntervalArithmetic.dac))

    @test isequal_interval(nthpow(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), IntervalArithmetic.com), 3), Interval(bareinterval(-Inf, 8.0), IntervalArithmetic.dac))

    @test isequal_interval(nthpow(Interval(bareinterval(3.0,5.0), IntervalArithmetic.com), -2), Interval(bareinterval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), IntervalArithmetic.com))

    @test isequal_interval(nthpow(Interval(bareinterval(-5.0,-3.0), IntervalArithmetic.def), -2), Interval(bareinterval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), IntervalArithmetic.def))

    @test isequal_interval(nthpow(Interval(bareinterval(-5.0,3.0), IntervalArithmetic.com), -2), Interval(bareinterval(0x1.47AE147AE147AP-5,Inf), IntervalArithmetic.trv))

    @test isequal_interval(nthpow(Interval(bareinterval(3.0,5.0), IntervalArithmetic.dac), -3), Interval(bareinterval(0x1.0624DD2F1A9FBP-7 ,0x1.2F684BDA12F69P-5), IntervalArithmetic.dac))

    @test isequal_interval(nthpow(Interval(bareinterval(-3.0,5.0), IntervalArithmetic.com), -3), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_pow_test" begin

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(0.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(1.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-3.0,5.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,-5.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(emptyinterval(BareInterval{Float64}), bareinterval(5.0,5.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.1,0.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.0,1.0)), bareinterval(0x1.999999999999AP-4,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.0,1.0)), bareinterval(0x1.999999999999AP-4,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.1,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.1,1.0)), bareinterval(0x1.999999999999AP-4,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.1,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(0.1,Inf)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(1.0,1.0)), bareinterval(0x1.999999999999AP-4,0x1P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(1.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(1.0,Inf)), bareinterval(0.0,0x1P-1))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(2.5,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(2.5,Inf)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.1,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.1,1.0)), bareinterval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.1,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.1,Inf)), bareinterval(0.0,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,1.0)), bareinterval(0x1.999999999999AP-4,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,Inf)), bareinterval(0.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,1.0)), bareinterval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,Inf)), bareinterval(0.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,0.1)), bareinterval(0x1.96B230BCDC434P-1,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,1.0)), bareinterval(0x1.999999999999AP-4,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,0.0)), bareinterval(1.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,-0.0)), bareinterval(1.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,0.0)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,-0.0)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.125FBEE250664P+0,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.125FBEE250664P+0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.125FBEE250664P+0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-1.0,-1.0)), bareinterval(0x1P+1,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,-1.0)), bareinterval(0x1P+1,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,0.5), bareinterval(-Inf,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.0,1.0)), bareinterval(0x1.999999999999AP-4,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.0,1.0)), bareinterval(0x1.999999999999AP-4,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.1,0.1)), bareinterval(0x1.96B230BCDC434P-1,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.1,1.0)), bareinterval(0x1.999999999999AP-4,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.1,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(0.1,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(1.0,1.0)), bareinterval(0x1.999999999999AP-4,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(1.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(1.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(2.5,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(2.5,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,1.0)), bareinterval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,1.0)), bareinterval(0x1.999999999999AP-4,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,0.1)), bareinterval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,1.0)), bareinterval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,0.1)), bareinterval(0x1.96B230BCDC434P-1,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,1.0)), bareinterval(0x1.999999999999AP-4,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,2.5)), bareinterval(0x1.9E7C6E43390B7P-9,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,0.0)), bareinterval(1.0,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,-0.0)), bareinterval(1.0,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,0.0)), bareinterval(1.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,-0.0)), bareinterval(1.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,0.0)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,-0.0)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-0.1,-0.1)), bareinterval(1.0,0x1.4248EF8FC2604P+0))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,-0.1)), bareinterval(1.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,-0.1)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-1.0,-1.0)), bareinterval(1.0,0x1.4P+3))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,-1.0)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-2.5,-2.5)), bareinterval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequal_interval(^(bareinterval(0.1,1.0), bareinterval(-Inf,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.0,1.0)), bareinterval(0.5,1.5))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.0,1.0)), bareinterval(0.5,1.5))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.1,0.1)), bareinterval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.1,1.0)), bareinterval(0.5,1.5))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.1,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(1.0,1.0)), bareinterval(0.5,1.5))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(1.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(2.5,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.1,0.1)), bareinterval(0x1.DDB680117AB12P-1,0x1.125FBEE250665P+0))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.1,1.0)), bareinterval(0x1P-1,0x1.8P+0))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.1,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.1,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,0.1)), bareinterval(0x1.5555555555555P-1,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,1.0)), bareinterval(0x1P-1,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), entireinterval(BareInterval{Float64})), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,0.0)), bareinterval(0x1.5555555555555P-1,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,-0.0)), bareinterval(0x1.5555555555555P-1,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,-0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,0.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,-0.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.125FBEE250665P+0))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.5555555555555P-1,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,-0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-1.0,-1.0)), bareinterval(0x1.5555555555555P-1,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,-1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,-1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,1.5), bareinterval(-Inf,-2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.0,1.0)), bareinterval(0.5,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.0,1.0)), bareinterval(0.5,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.1,0.1)), bareinterval(0x1.DDB680117AB12P-1,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.1,1.0)), bareinterval(0.5,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.1,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(1.0,1.0)), bareinterval(0.5,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(1.0,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(2.5,2.5)), bareinterval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,0.0)), bareinterval(0.0,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,-0.0)), bareinterval(0.0,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,0.0)), bareinterval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,-0.0)), bareinterval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-0.1,-0.1)), bareinterval(0.0,0x1.125FBEE250665P+0))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,-0.1)), bareinterval(0.0,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,-0.1)), bareinterval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-1.0,-1.0)), bareinterval(0.0,0x1P+1))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,-1.0)), bareinterval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.5,Inf), bareinterval(-2.5,-2.5)), bareinterval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequal_interval(^(bareinterval(1.0,1.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.0,1.0)), bareinterval(1.0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.0,1.0)), bareinterval(1.0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.0,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.0,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.1,0.1)), bareinterval(1.0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.1,1.0)), bareinterval(1.0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.1,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(0.1,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(1.0,1.0)), bareinterval(1.0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(1.0,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(1.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(2.5,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(2.5,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.1,0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.1,1.0)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.1,2.5)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.1,Inf)), bareinterval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,0.1)), bareinterval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,1.0)), bareinterval(0x1.5555555555555P-1,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,2.5)), bareinterval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,Inf)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,Inf)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,0.1)), bareinterval(0x0P+0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,1.0)), bareinterval(0x0P+0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,2.5)), bareinterval(0x0P+0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.0,1.5), entireinterval(BareInterval{Float64})), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,0.0)), bareinterval(0x1.5555555555555P-1,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,-0.0)), bareinterval(0x1.5555555555555P-1,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,-0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.5555555555555P-1,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,-0.1)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-1.0,-1.0)), bareinterval(0x1.5555555555555P-1,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,-1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,-1.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.0,1.5), bareinterval(-Inf,-2.5)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.0,1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.0,1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.0,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.0,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.1,0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.1,1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.1,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(0.1,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(1.0,1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(1.0,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(1.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(2.5,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(2.5,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.1,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.1,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.1,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.1,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-0.1,-0.1)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,-0.1)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,-0.1)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,-0.1)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-1.0,-1.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,-1.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,-1.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-2.5,-2.5)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.0,Inf), bareinterval(-Inf,-2.5)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.0,1.0)), bareinterval(1.0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.0,1.0)), bareinterval(1.0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.0,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.0,2.5)), bareinterval(1.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.1,0.1)), bareinterval(0x1.02739C65D58BFP+0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.1,1.0)), bareinterval(0x1.02739C65D58BFP+0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.1,2.5)), bareinterval(0x1.02739C65D58BFP+0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(0.1,Inf)), bareinterval(0x1.02739C65D58BFP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(1.0,1.0)), bareinterval(0x1.199999999999AP+0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(1.0,2.5)), bareinterval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(1.0,Inf)), bareinterval(0x1.199999999999AP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(2.5,2.5)), bareinterval(0x1.44E1080833B25P+0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(2.5,Inf)), bareinterval(0x1.44E1080833B25P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.1,0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.1,1.0)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.1,2.5)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.1,Inf)), bareinterval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,0.1)), bareinterval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,1.0)), bareinterval(0x1.5555555555555P-1,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,2.5)), bareinterval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,Inf)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,Inf)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,0.1)), bareinterval(0x0P+0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,1.0)), bareinterval(0x0P+0,0x1.8P+0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,2.5)), bareinterval(0x0P+0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(1.1,1.5), entireinterval(BareInterval{Float64})), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,0.0)), bareinterval(0x1.5555555555555P-1,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,-0.0)), bareinterval(0x1.5555555555555P-1,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,-0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.5555555555555P-1,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,-0.1)), bareinterval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-1.0,-1.0)), bareinterval(0x1.5555555555555P-1,0x1.D1745D1745D17P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,-1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.D1745D1745D17P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,-1.0)), bareinterval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,0x1.9372D999784C8P-1))

    @test isequal_interval(^(bareinterval(1.1,1.5), bareinterval(-Inf,-2.5)), bareinterval(0x0P+0,0x1.9372D999784C8P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.0,1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.0,1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.0,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.0,2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.1,0.1)), bareinterval(0x1.02739C65D58BFP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.1,1.0)), bareinterval(0x1.02739C65D58BFP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.1,2.5)), bareinterval(0x1.02739C65D58BFP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(0.1,Inf)), bareinterval(0x1.02739C65D58BFP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(1.0,1.0)), bareinterval(0x1.199999999999AP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(1.0,2.5)), bareinterval(0x1.199999999999AP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(1.0,Inf)), bareinterval(0x1.199999999999AP+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(2.5,2.5)), bareinterval(0x1.44E1080833B25P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(2.5,Inf)), bareinterval(0x1.44E1080833B25P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.1,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.1,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.1,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.1,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,Inf)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,0.1)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,1.0)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,2.5)), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), entireinterval(BareInterval{Float64})), bareinterval(0x0P+0,Inf))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,-0.0)), bareinterval(0x0P+0,1.0))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-0.1,-0.1)), bareinterval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,-0.1)), bareinterval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,-0.1)), bareinterval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,-0.1)), bareinterval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-1.0,-1.0)), bareinterval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,-1.0)), bareinterval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,-1.0)), bareinterval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-2.5,-2.5)), bareinterval(0x0P+0,0x1.9372D999784C8P-1))

    @test isequal_interval(^(bareinterval(1.1,Inf), bareinterval(-Inf,-2.5)), bareinterval(0x0P+0,0x1.9372D999784C8P-1))

    @test isequal_interval(^(bareinterval(0.0,0.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.1,0.1)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.1,1.0)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.1,2.5)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(0.1,Inf)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(1.0,1.0)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(1.0,2.5)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(1.0,Inf)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(2.5,2.5)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(2.5,Inf)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-1.0,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.5), bareinterval(-Inf,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.1,0.1)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.1,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.1,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(0.1,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(1.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(1.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(1.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(2.5,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(2.5,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-0.1,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-1.0,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-2.5,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.0), bareinterval(-Inf,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.1,0.1)), bareinterval(0.0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.1,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.1,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(1.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(1.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(2.5,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,0.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,-0.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,-0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-1.0,-1.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,-1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(0.0,1.5), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-0.1,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-1.0,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,Inf), bareinterval(-2.5,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.1,0.1)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.1,1.0)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.1,2.5)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(0.1,Inf)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(1.0,1.0)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(1.0,2.5)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(1.0,Inf)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(2.5,2.5)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(2.5,Inf)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-1.0,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,0.5), bareinterval(-Inf,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.1,0.1)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.1,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.1,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(0.1,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(1.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(1.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(1.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(2.5,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(2.5,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-0.1,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-1.0,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-2.5,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.0), bareinterval(-Inf,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.1,0.1)), bareinterval(0.0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.1,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.1,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(1.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(1.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(2.5,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,0.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,-0.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,-0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-1.0,-1.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,-1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.0,1.5), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-0.1,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-1.0,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.0,Inf), bareinterval(-2.5,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.1,0.1)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.1,1.0)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.1,2.5)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(0.1,Inf)), bareinterval(0.0,0x1.DDB680117AB13P-1))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(1.0,1.0)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(1.0,2.5)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(1.0,Inf)), bareinterval(0.0,0.5))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(2.5,2.5)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(2.5,Inf)), bareinterval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,-0.1)), bareinterval(0x1.125FBEE250664P+0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-1.0,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,-1.0)), bareinterval(0x1P+1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,0.5), bareinterval(-Inf,-2.5)), bareinterval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.1,0.1)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.1,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.1,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(0.1,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(1.0,1.0)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(1.0,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(1.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(2.5,2.5)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(2.5,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-0.1,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,-0.1)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-1.0,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,-1.0)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-2.5,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.0), bareinterval(-Inf,-2.5)), bareinterval(1.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.1,0.1)), bareinterval(0.0,0x1.0A97DCE72A0CBP+0))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.1,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.1,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(1.0,1.0)), bareinterval(0.0,1.5))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(1.0,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(2.5,2.5)), bareinterval(0.0,0x1.60B9FD68A4555P+1))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,0.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,-0.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,-0.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-0.1,-0.1)), bareinterval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,-0.1)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,-0.1)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-1.0,-1.0)), bareinterval(0x1.5555555555555P-1,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,-1.0)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-2.5,-2.5)), bareinterval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequal_interval(^(bareinterval(-0.1,1.5), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.1,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.1,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.1,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.1,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,-0.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-0.1,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,-0.1)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-1.0,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,-1.0)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-Inf,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(-0.1,Inf), bareinterval(-2.5,-2.5)), bareinterval(0.0,Inf))

    @test isequal_interval(^(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,0.0), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,-0.0), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-0.0,0.0), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(0.0,-0.0), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,0.0), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.1,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.1,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.1,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.1,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,0.1)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,2.5)), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0.0))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.0), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.0,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.0,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.1,0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.1,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.1,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(0.1,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(1.0,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(1.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(2.5,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(2.5,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.1,0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.1,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.1,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.1,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-0.1,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,-0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-Inf,-2.5)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(^(bareinterval(-1.0,-0.1), bareinterval(-2.5,-2.5)), emptyinterval(BareInterval{Float64}))

end

@testset "minimal_pow_dec_test" begin

    @test isequal_interval(^(Interval(bareinterval(0.1,0.5), IntervalArithmetic.com), Interval(bareinterval(0.0,1.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.999999999999AP-4,1.0), IntervalArithmetic.com))

    @test isequal_interval(^(Interval(bareinterval(0.1,0.5), IntervalArithmetic.com), Interval(bareinterval(0.1,0.1), IntervalArithmetic.def)), Interval(bareinterval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(0.1,0.5), IntervalArithmetic.trv), Interval(bareinterval(-2.5,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.1,0.5), IntervalArithmetic.com), Interval(bareinterval(-2.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.3C3A4EDFA9758P+8), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.1,0.5), IntervalArithmetic.trv), Interval(bareinterval(-Inf,0.1), IntervalArithmetic.dac)), Interval(bareinterval(0x1.96B230BCDC434P-1,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.1,1.0), IntervalArithmetic.com), Interval(bareinterval(0.0,2.5), IntervalArithmetic.com)), Interval(bareinterval(0x1.9E7C6E43390B7P-9,1.0), IntervalArithmetic.com))

    @test isequal_interval(^(Interval(bareinterval(0.1,1.0), IntervalArithmetic.def), Interval(bareinterval(1.0,1.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.999999999999AP-4,1.0), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(0.1,1.0), IntervalArithmetic.trv), Interval(bareinterval(-2.5,1.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.5,1.5), IntervalArithmetic.dac), Interval(bareinterval(0.1,0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.5,1.5), IntervalArithmetic.def), Interval(bareinterval(-2.5,0.1), IntervalArithmetic.trv)), Interval(bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.5,1.5), IntervalArithmetic.com), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.com)), Interval(bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), IntervalArithmetic.com))

    @test isequal_interval(^(Interval(bareinterval(0.5,Inf), IntervalArithmetic.dac), Interval(bareinterval(0.1,0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.DDB680117AB12P-1,Inf), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.5,Inf), IntervalArithmetic.def), Interval(bareinterval(-2.5,-0.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.6A09E667F3BCDP+2), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(1.0,1.5), IntervalArithmetic.com), Interval(bareinterval(-0.1,0.1), IntervalArithmetic.def)), Interval(bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(1.0,1.5), IntervalArithmetic.trv), Interval(bareinterval(-0.1,-0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.EBA7C9E4D31E9P-1,1.0), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac), Interval(bareinterval(1.0,1.0), IntervalArithmetic.dac)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(1.0,Inf), IntervalArithmetic.def), Interval(bareinterval(-1.0,-0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x0P+0,1.0), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(1.1,1.5), IntervalArithmetic.def), Interval(bareinterval(1.0,2.5), IntervalArithmetic.com)), Interval(bareinterval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(1.1,1.5), IntervalArithmetic.com), Interval(bareinterval(-0.1,-0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1), IntervalArithmetic.com))

    @test isequal_interval(^(Interval(bareinterval(1.1,Inf), IntervalArithmetic.dac), Interval(bareinterval(0.1,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0x1.02739C65D58BFP+0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(1.1,Inf), IntervalArithmetic.def), Interval(bareinterval(-2.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0x0P+0,Inf), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(1.1,Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,-1.0), IntervalArithmetic.def)), Interval(bareinterval(0x0P+0,0x1.D1745D1745D17P-1), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,0.5), IntervalArithmetic.com), Interval(bareinterval(0.1,0.1), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.DDB680117AB13P-1), IntervalArithmetic.com))

    @test isequal_interval(^(Interval(bareinterval(0.0,0.5), IntervalArithmetic.com), Interval(bareinterval(2.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.6A09E667F3BCDP-3), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.0,0.5), IntervalArithmetic.com), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.dac)), Interval(bareinterval(0x1.6A09E667F3BCCP+2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.com), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.def), Interval(bareinterval(0.0,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.dac), Interval(bareinterval(1.0,2.5), IntervalArithmetic.com)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.com), Interval(bareinterval(-2.5,0.1), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.def), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.dac), Interval(bareinterval(-0.1,0.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.com), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.dac)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.0), IntervalArithmetic.def), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.dac)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.5), IntervalArithmetic.com), Interval(bareinterval(0.0,2.5), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.5), IntervalArithmetic.def), Interval(bareinterval(2.5,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.5), IntervalArithmetic.dac), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.5555555555555P-1,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,1.5), IntervalArithmetic.com), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.def)), Interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), Interval(bareinterval(0.1,0.1), IntervalArithmetic.com)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,-1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,0.5), IntervalArithmetic.com), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,0.5), IntervalArithmetic.def), Interval(bareinterval(0.1,Inf), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.DDB680117AB13P-1), IntervalArithmetic.def))

    @test isequal_interval(^(Interval(bareinterval(-0.0,0.5), IntervalArithmetic.dac), Interval(bareinterval(2.5,2.5), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.6A09E667F3BCDP-3), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(-0.0,0.5), IntervalArithmetic.trv), Interval(bareinterval(-2.5,-0.0), IntervalArithmetic.dac)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,0.5), IntervalArithmetic.com), Interval(bareinterval(-Inf,-0.1), IntervalArithmetic.def)), Interval(bareinterval(0x1.125FBEE250664P+0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,0.5), IntervalArithmetic.def), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.dac)), Interval(bareinterval(0x1.6A09E667F3BCCP+2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.0), IntervalArithmetic.com), Interval(bareinterval(2.5,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.0), IntervalArithmetic.dac), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.0), IntervalArithmetic.com), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.0), IntervalArithmetic.def), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.com)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.def)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.5), IntervalArithmetic.com), Interval(bareinterval(0.1,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.5), IntervalArithmetic.def), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.5555555555555P-1,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.5), IntervalArithmetic.dac), Interval(bareinterval(-2.5,-0.1), IntervalArithmetic.def)), Interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.5), IntervalArithmetic.com), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.com)), Interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,1.5), IntervalArithmetic.def), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.1,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.def), Interval(bareinterval(-2.5,-0.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.trv)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.def), Interval(bareinterval(-Inf,-1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,0.5), IntervalArithmetic.def), Interval(bareinterval(0.1,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.DDB680117AB13P-1), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,0.5), IntervalArithmetic.com), Interval(bareinterval(-0.1,-0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.125FBEE250664P+0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,0.5), IntervalArithmetic.dac), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.def)), Interval(bareinterval(0x1.6A09E667F3BCCP+2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.com), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.def), Interval(bareinterval(-Inf,-1.0), IntervalArithmetic.def)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.com), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.com)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,-2.5), IntervalArithmetic.trv)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.5), IntervalArithmetic.trv), Interval(bareinterval(0.0,2.5), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.5), IntervalArithmetic.com), Interval(bareinterval(2.5,2.5), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.5), IntervalArithmetic.dac), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.5555555555555P-1,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.5), IntervalArithmetic.com), Interval(bareinterval(-0.1,-0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.EBA7C9E4D31E9P-1,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,1.5), IntervalArithmetic.def), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.def)), Interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.1,2.5), IntervalArithmetic.com)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,Inf), IntervalArithmetic.def), Interval(bareinterval(-2.5,0.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-0.1,Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.5,-2.5), IntervalArithmetic.trv)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.dac))

    @test isequal_interval(^(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com), Interval(bareinterval(-2.5,0.1), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(0.0,0.0), IntervalArithmetic.dac), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-1.0,-0.1), IntervalArithmetic.com), Interval(bareinterval(-0.1,1.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-1.0,-0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.1,2.5), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(^(Interval(bareinterval(-1.0,-0.1), IntervalArithmetic.def), Interval(bareinterval(-0.1,Inf), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end

@testset "minimal_exp_test" begin

    @test isequal_interval(exp(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(exp(bareinterval(-Inf,0.0)), bareinterval(0.0,1.0))

    @test isequal_interval(exp(bareinterval(-Inf,-0.0)), bareinterval(0.0,1.0))

    @test isequal_interval(exp(bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(exp(bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(exp(entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(exp(bareinterval(-Inf,0x1.62E42FEFA39FP+9)), bareinterval(0.0,Inf))

    @test isequal_interval(exp(bareinterval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9)), bareinterval( 0x1.FFFFFFFFFFFFFP+1023,Inf))

    @test isequal_interval(exp(bareinterval(0.0,0x1.62E42FEFA39EP+9)), bareinterval(1.0,0x1.FFFFFFFFFC32BP+1023))

    @test isequal_interval(exp(bareinterval(-0.0,0x1.62E42FEFA39EP+9)), bareinterval(1.0,0x1.FFFFFFFFFC32BP+1023))

    @test isequal_interval(exp(bareinterval(-0x1.6232BDD7ABCD3P+9,0x1.62E42FEFA39EP+9)), bareinterval(0x0.FFFFFFFFFFE7BP-1022,0x1.FFFFFFFFFC32BP+1023))

    @test isequal_interval(exp(bareinterval(-0x1.6232BDD7ABCD3P+8,0x1.62E42FEFA39EP+9)), bareinterval(0x1.FFFFFFFFFFE7BP-512,0x1.FFFFFFFFFC32BP+1023))

    @test isequal_interval(exp(bareinterval(-0x1.6232BDD7ABCD3P+8,0.0)), bareinterval(0x1.FFFFFFFFFFE7BP-512,1.0))

    @test isequal_interval(exp(bareinterval(-0x1.6232BDD7ABCD3P+8,-0.0)), bareinterval(0x1.FFFFFFFFFFE7BP-512,1.0))

    @test isequal_interval(exp(bareinterval(-0x1.6232BDD7ABCD3P+8,1.0)), bareinterval(0x1.FFFFFFFFFFE7BP-512,0x1.5BF0A8B14576AP+1))

    @test isequal_interval(exp(bareinterval(1.0,5.0)), bareinterval(0x1.5BF0A8B145769P+1,0x1.28D389970339P+7))

    @test isequal_interval(exp(bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)), bareinterval(0x1.2797F0A337A5FP-5,0x1.86091CC9095C5P+2))

    @test isequal_interval(exp(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)), bareinterval(0x1.1337E9E45812AP+1, 0x1.805A5C88021B6P+142))

    @test isequal_interval(exp(bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)), bareinterval(0x1.EF461A783114CP+16,0x1.691D36C6B008CP+37))

end

@testset "minimal_exp_dec_test" begin

    @test isequal_interval(exp(Interval(bareinterval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9), IntervalArithmetic.com)), Interval(bareinterval( 0x1.FFFFFFFFFFFFFP+1023,Inf), IntervalArithmetic.dac))

    @test isequal_interval(exp(Interval(bareinterval(0.0,0x1.62E42FEFA39EP+9), IntervalArithmetic.def)), Interval(bareinterval(1.0,0x1.FFFFFFFFFC32BP+1023), IntervalArithmetic.def))

end

@testset "minimal_exp2_test" begin

    @test isequal_interval(exp2(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(exp2(bareinterval(-Inf,0.0)), bareinterval(0.0,1.0))

    @test isequal_interval(exp2(bareinterval(-Inf,-0.0)), bareinterval(0.0,1.0))

    @test isequal_interval(exp2(bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(exp2(bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(exp2(entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(exp2(bareinterval(-Inf,1024.0)), bareinterval(0.0,Inf))

    @test isequal_interval(exp2(bareinterval(1024.0,1024.0)), bareinterval(0x1.FFFFFFFFFFFFFP+1023,Inf))

    @test isequal_interval(exp2(bareinterval(0.0,1023.0)), bareinterval(1.0,0x1P+1023))

    @test isequal_interval(exp2(bareinterval(-0.0,1023.0)), bareinterval(1.0,0x1P+1023))

    @test isequal_interval(exp2(bareinterval(-1022.0,1023.0)), bareinterval(0x1P-1022,0x1P+1023))

    @test isequal_interval(exp2(bareinterval(-1022.0,0.0)), bareinterval(0x1P-1022,1.0))

    @test isequal_interval(exp2(bareinterval(-1022.0,-0.0)), bareinterval(0x1P-1022,1.0))

    @test isequal_interval(exp2(bareinterval(-1022.0,1.0)), bareinterval(0x1P-1022,2.0))

    @test isequal_interval(exp2(bareinterval(1.0,5.0)), bareinterval(2.0,32.0))

    @test isequal_interval(exp2(bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)), bareinterval(0x1.9999999999998P-4,0x1.C000000000001P+1))

    @test isequal_interval(exp2(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)), bareinterval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98))

    @test isequal_interval(exp2(bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)), bareinterval(0x1.AEA0000721857P+11,0x1.FCA0555555559P+25))

end

@testset "minimal_exp2_dec_test" begin

    @test isequal_interval(exp2(Interval(bareinterval(1024.0,1024.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.FFFFFFFFFFFFFP+1023,Inf), IntervalArithmetic.dac))

    @test isequal_interval(exp2(Interval(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), IntervalArithmetic.def)), Interval(bareinterval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98), IntervalArithmetic.def))

end

@testset "minimal_exp10_test" begin

    @test isequal_interval(exp10(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(exp10(bareinterval(-Inf,0.0)), bareinterval(0.0,1.0))

    @test isequal_interval(exp10(bareinterval(-Inf,-0.0)), bareinterval(0.0,1.0))

    @test isequal_interval(exp10(bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(exp10(bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(exp10(entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(exp10(bareinterval(-Inf,0x1.34413509F79FFP+8)), bareinterval(0.0,Inf))

    @test isequal_interval(exp10(bareinterval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8)), bareinterval(0x1.FFFFFFFFFFFFFP+1023,Inf))

    @test isequal_interval(exp10(bareinterval(0.0,0x1.34413509F79FEP+8)), bareinterval(1.0,0x1.FFFFFFFFFFBA1P+1023))

    @test isequal_interval(exp10(bareinterval(-0.0,0x1.34413509F79FEP+8)), bareinterval(1.0,0x1.FFFFFFFFFFBA1P+1023))

    @test isequal_interval(exp10(bareinterval(-0x1.33A7146F72A42P+8,0x1.34413509F79FEP+8)), bareinterval(0x0.FFFFFFFFFFFE3P-1022,0x1.FFFFFFFFFFBA1P+1023))

    @test isequal_interval(exp10(bareinterval(-0x1.22P+7,0x1.34413509F79FEP+8)), bareinterval(0x1.3FAAC3E3FA1F3P-482,0x1.FFFFFFFFFFBA1P+1023))

    @test isequal_interval(exp10(bareinterval(-0x1.22P+7,0.0)), bareinterval(0x1.3FAAC3E3FA1F3P-482,1.0))

    @test isequal_interval(exp10(bareinterval(-0x1.22P+7,-0.0)), bareinterval(0x1.3FAAC3E3FA1F3P-482,1.0))

    @test isequal_interval(exp10(bareinterval(-0x1.22P+7,1.0)), bareinterval(0x1.3FAAC3E3FA1F3P-482,10.0))

    @test isequal_interval(exp10(bareinterval(1.0,5.0)), bareinterval(10.0,100000.0))

    @test isequal_interval(exp10(bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)), bareinterval(0x1.F3A8254311F9AP-12,0x1.00B18AD5B7D56P+6))

    @test isequal_interval(exp10(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)), bareinterval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328))

    @test isequal_interval(exp10(bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)), bareinterval(0x1.0608D2279A811P+39,0x1.43AF5D4271CB8P+86))

end

@testset "minimal_exp10_dec_test" begin

    @test isequal_interval(exp10(Interval(bareinterval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8), IntervalArithmetic.com)), Interval(bareinterval( 0x1.FFFFFFFFFFFFFP+1023,Inf), IntervalArithmetic.dac))

    @test isequal_interval(exp10(Interval(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), IntervalArithmetic.def)), Interval(bareinterval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328), IntervalArithmetic.def))

end

@testset "minimal_log_test" begin

    @test isequal_interval(log(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log(bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log(bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log(bareinterval(0.0,1.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(log(bareinterval(-0.0,1.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(log(bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(log(bareinterval(0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log(bareinterval(-0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,0x1.62E42FEFA39FP+9))

    @test isequal_interval(log(bareinterval(-0.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,0x1.62E42FEFA39FP+9))

    @test isequal_interval(log(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0.0,0x1.62E42FEFA39FP+9))

    @test isequal_interval(log(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-0x1.74385446D71C4p9, +0x1.62E42FEFA39Fp9))

    @test isequal_interval(log(bareinterval(0x0.0000000000001p-1022,1.0)), bareinterval(-0x1.74385446D71C4p9,0.0))

    @test isequal_interval(log(bareinterval(0x1.5BF0A8B145769P+1,0x1.5BF0A8B145769P+1)), bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequal_interval(log(bareinterval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1)), bareinterval(0x1P+0,0x1.0000000000001P+0))

    @test isequal_interval(log(bareinterval(0x0.0000000000001p-1022,0x1.5BF0A8B14576AP+1)), bareinterval(-0x1.74385446D71C4p9,0x1.0000000000001P+0))

    @test isequal_interval(log(bareinterval(0x1.5BF0A8B145769P+1,32.0)), bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1.BB9D3BEB8C86CP+1))

    @test isequal_interval(log(bareinterval(0x1.999999999999AP-4,0x1.CP+1)), bareinterval(-0x1.26BB1BBB55516P+1,0x1.40B512EB53D6P+0))

    @test isequal_interval(log(bareinterval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)), bareinterval(0x1.0FAE81914A99P-1,0x1.120627F6AE7F1P+6))

    @test isequal_interval(log(bareinterval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)), bareinterval(0x1.04A1363DB1E63P+3,0x1.203E52C0256B5P+4))

end

@testset "minimal_log_dec_test" begin

    @test isequal_interval(log(Interval(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-0x1.74385446D71C4p9,0x1.62E42FEFA39FP+9), IntervalArithmetic.com))

    @test isequal_interval(log(Interval(bareinterval(0.0,1.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(log(Interval(bareinterval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1), IntervalArithmetic.def)), Interval(bareinterval(0x1P+0,0x1.0000000000001P+0), IntervalArithmetic.def))

end

@testset "minimal_log2_test" begin

    @test isequal_interval(log2(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log2(bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log2(bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log2(bareinterval(0.0,1.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(log2(bareinterval(-0.0,1.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(log2(bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(log2(bareinterval(0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log2(bareinterval(-0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log2(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log2(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,1024.0))

    @test isequal_interval(log2(bareinterval(-0.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,1024.0))

    @test isequal_interval(log2(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0.0,1024.0))

    @test isequal_interval(log2(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-1074.0,1024.0))

    @test isequal_interval(log2(bareinterval(0x0.0000000000001p-1022,1.0)), bareinterval(-1074.0,0.0))

    @test isequal_interval(log2(bareinterval(0x0.0000000000001p-1022,2.0)), bareinterval(-1074.0,1.0))

    @test isequal_interval(log2(bareinterval(2.0,32.0)), bareinterval(1.0,5.0))

    @test isequal_interval(log2(bareinterval(0x1.999999999999AP-4,0x1.CP+1)), bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0))

    @test isequal_interval(log2(bareinterval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)), bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6))

    @test isequal_interval(log2(bareinterval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)), bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4))

end

@testset "minimal_log2_dec_test" begin

    @test isequal_interval(log2(Interval(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-1074.0,1024.0), IntervalArithmetic.com))

    @test isequal_interval(log2(Interval(bareinterval(0x0.0000000000001p-1022,Inf), IntervalArithmetic.dac)), Interval(bareinterval(-1074.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(log2(Interval(bareinterval(2.0,32.0), IntervalArithmetic.def)), Interval(bareinterval(1.0,5.0), IntervalArithmetic.def))

    @test isequal_interval(log2(Interval(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-Inf,1024.0), IntervalArithmetic.trv))

end

@testset "minimal_log10_test" begin

    @test isequal_interval(log10(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log10(bareinterval(-Inf,0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log10(bareinterval(-Inf,-0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(log10(bareinterval(0.0,1.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(log10(bareinterval(-0.0,1.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(log10(bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(log10(bareinterval(0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log10(bareinterval(-0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log10(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(log10(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,0x1.34413509F79FFP+8))

    @test isequal_interval(log10(bareinterval(-0.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,0x1.34413509F79FFP+8))

    @test isequal_interval(log10(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)), bareinterval(0.0,0x1.34413509F79FFP+8))

    @test isequal_interval(log10(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)), bareinterval(-0x1.434E6420F4374p+8, +0x1.34413509F79FFp+8))

    @test isequal_interval(log10(bareinterval(0x0.0000000000001p-1022,1.0)), bareinterval(-0x1.434E6420F4374p+8 ,0.0))

    @test isequal_interval(log10(bareinterval(0x0.0000000000001p-1022,10.0)), bareinterval(-0x1.434E6420F4374p+8 ,1.0))

    @test isequal_interval(log10(bareinterval(10.0,100000.0)), bareinterval(1.0,5.0))

    @test isequal_interval(log10(bareinterval(0x1.999999999999AP-4,0x1.CP+1)), bareinterval(-0x1P+0,0x1.1690163290F4P-1))

    @test isequal_interval(log10(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(log10(bareinterval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)), bareinterval(0x1.D7F59AA5BECB9P-3,0x1.DC074D84E5AABP+4))

    @test isequal_interval(log10(bareinterval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)), bareinterval(0x1.C4C29DD829191P+1,0x1.F4BAEBBA4FA4P+2))

end

@testset "minimal_log10_dec_test" begin

    @test isequal_interval(log10(Interval(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-0x1.434E6420F4374p+8,0x1.34413509F79FFP+8), IntervalArithmetic.com))

    @test isequal_interval(log10(Interval(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac)), Interval(bareinterval(-Inf,0x1.34413509F79FFP+8), IntervalArithmetic.trv))

end

@testset "minimal_sin_test" begin

    @test isequal_interval(sin(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sin(bareinterval(0.0,Inf)), bareinterval(-1.0,1.0))

    @test isequal_interval(sin(bareinterval(-0.0,Inf)), bareinterval(-1.0,1.0))

    @test isequal_interval(sin(bareinterval(-Inf,0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(sin(bareinterval(-Inf,-0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(sin(entireinterval(BareInterval{Float64})), bareinterval(-1.0,1.0))

    @test isequal_interval(sin(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sin(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequal_interval(sin(bareinterval(0.0,0x1.921FB54442D18P+0)), bareinterval(0.0,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0.0,0x1.921FB54442D18P+0)), bareinterval(0.0,0x1P+0))

    @test isequal_interval(sin(bareinterval(0.0,0x1.921FB54442D19P+0)), bareinterval(0.0,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0.0,0x1.921FB54442D19P+0)), bareinterval(0.0,0x1P+0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)), bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)), bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)), bareinterval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53))

    @test isequal_interval(sin(bareinterval(0.0,0x1.921FB54442D18P+1)), bareinterval(0.0,1.0))

    @test isequal_interval(sin(bareinterval(-0.0,0x1.921FB54442D18P+1)), bareinterval(0.0,1.0))

    @test isequal_interval(sin(bareinterval(0.0,0x1.921FB54442D19P+1)), bareinterval(-0x1.72CECE675D1FDP-52,1.0))

    @test isequal_interval(sin(bareinterval(-0.0,0x1.921FB54442D19P+1)), bareinterval(-0x1.72CECE675D1FDP-52,1.0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)), bareinterval(0x1.1A62633145C06P-53,0x1P+0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)), bareinterval(-0x1.72CECE675D1FDP-52,0x1P+0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)), bareinterval(0x1.1A62633145C06P-53,0x1P+0))

    @test isequal_interval(sin(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)), bareinterval(-0x1.72CECE675D1FDP-52,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+0,0.0)), bareinterval(-0x1P+0,0.0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+0,-0.0)), bareinterval(-0x1P+0,0.0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+0,0.0)), bareinterval(-0x1P+0,0.0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+0,-0.0)), bareinterval(-0x1P+0,0.0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)), bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)), bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)), bareinterval(-0x1.1A62633145C07P-53,0x1.72CECE675D1FDP-52))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+1,0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+1,-0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+1,0.0)), bareinterval(-1.0,0x1.72CECE675D1FDP-52))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+1,-0.0)), bareinterval(-1.0,0x1.72CECE675D1FDP-52))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)), bareinterval(-0x1P+0,-0x1.1A62633145C06P-53))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)), bareinterval(-0x1P+0,0x1.72CECE675D1FDP-52))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)), bareinterval(-0x1P+0,-0x1.1A62633145C06P-53))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)), bareinterval(-0x1P+0,0x1.72CECE675D1FDP-52))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), bareinterval(-0x1P+0,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1P+0,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)), bareinterval(-0x1P+0,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1P+0,0x1P+0))

    @test isequal_interval(sin(bareinterval(-0.7,0.1)), bareinterval(-0x1.49D6E694619B9P-1,0x1.98EAECB8BCB2DP-4))

    @test isequal_interval(sin(bareinterval(1.0,2.0)), bareinterval(0x1.AED548F090CEEP-1,1.0))

    @test isequal_interval(sin(bareinterval(-3.2,-2.9)), bareinterval(-0x1.E9FB8D64830E3P-3,0x1.DE33739E82D33P-5))

    @test isequal_interval(sin(bareinterval(2.0,3.0)), bareinterval(0x1.210386DB6D55BP-3,0x1.D18F6EAD1B446P-1))

end

@testset "minimal_sin_dec_test" begin

    @test isequal_interval(sin(Interval(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0), IntervalArithmetic.def)), Interval(bareinterval(-0x1P+0,-0x1.1A62633145C06P-53), IntervalArithmetic.def))

    @test isequal_interval(sin(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(sin(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.dac))

end

@testset "minimal_cos_test" begin

    @test isequal_interval(cos(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cos(bareinterval(0.0,Inf)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0.0,Inf)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-Inf,0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-Inf,-0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(entireinterval(BareInterval{Float64})), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(0.0,0x1.921FB54442D18P+0)), bareinterval(0x1.1A62633145C06P-54,1.0))

    @test isequal_interval(cos(bareinterval(-0.0,0x1.921FB54442D18P+0)), bareinterval(0x1.1A62633145C06P-54,1.0))

    @test isequal_interval(cos(bareinterval(0.0,0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(-0.0,0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(cos(bareinterval(0.0,0x1.921FB54442D18P+1)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0.0,0x1.921FB54442D18P+1)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(0.0,0x1.921FB54442D19P+1)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0.0,0x1.921FB54442D19P+1)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)), bareinterval(-1.0,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)), bareinterval(-1.0,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)), bareinterval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequal_interval(cos(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)), bareinterval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)), bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)), bareinterval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+0,0.0)), bareinterval(0x1.1A62633145C06P-54,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+0,-0.0)), bareinterval(0x1.1A62633145C06P-54,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+0,0.0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+0,-0.0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+1,0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+1,-0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+1,0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+1,-0.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)), bareinterval(-1.0,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)), bareinterval(-1.0,0x1.1A62633145C07P-54))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)), bareinterval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)), bareinterval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), bareinterval(0x1.1A62633145C06P-54,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequal_interval(cos(bareinterval(-0.7,0.1)), bareinterval(0x1.87996529F9D92P-1,1.0))

    @test isequal_interval(cos(bareinterval(1.0,2.0)), bareinterval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1))

    @test isequal_interval(cos(bareinterval(-3.2,-2.9)), bareinterval(-1.0,-0x1.F1216DBA340C8P-1))

    @test isequal_interval(cos(bareinterval(2.0,3.0)), bareinterval(-0x1.FAE04BE85E5D3P-1,-0x1.AA22657537204P-2))

end

@testset "minimal_cos_dec_test" begin

    @test isequal_interval(cos(Interval(bareinterval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), IntervalArithmetic.trv))

    @test isequal_interval(cos(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.def)), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.def))

    @test isequal_interval(cos(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.dac))

end

@testset "minimal_tan_test" begin

    @test isequal_interval(tan(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0.0,Inf)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-Inf,0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-Inf,-0.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(tan(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(tan(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), bareinterval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53))

    @test isequal_interval(tan(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), bareinterval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52))

    @test isequal_interval(tan(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)), bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53))

    @test isequal_interval(tan(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)), bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52))

    @test isequal_interval(tan(bareinterval(0.0,0x1.921FB54442D18P+0)), bareinterval(0.0,0x1.D02967C31CDB5P+53))

    @test isequal_interval(tan(bareinterval(-0.0,0x1.921FB54442D18P+0)), bareinterval(0.0,0x1.D02967C31CDB5P+53))

    @test isequal_interval(tan(bareinterval(0.0,0x1.921FB54442D19P+0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0.0,0x1.921FB54442D19P+0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0.0,0x1.921FB54442D18P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0.0,0x1.921FB54442D18P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0.0,0x1.921FB54442D19P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0.0,0x1.921FB54442D19P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0x1P-51,0x1.921FB54442D18P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0x1P-51,0x1.921FB54442D19P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0x1P-52,0x1.921FB54442D18P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0x1P-52,0x1.921FB54442D19P+1)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), bareinterval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53))

    @test isequal_interval(tan(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4)), bareinterval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4))

    @test isequal_interval(tan(bareinterval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12)), bareinterval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0))

    @test isequal_interval(tan(bareinterval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(tan(bareinterval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0)), bareinterval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0))

end

@testset "minimal_tan_dec_test" begin

    @test isequal_interval(tan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com))

    @test isequal_interval(tan(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(tan(Interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), IntervalArithmetic.com)), Interval(bareinterval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), IntervalArithmetic.com))

    @test isequal_interval(tan(Interval(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52), IntervalArithmetic.def))

    @test isequal_interval(tan(Interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1), IntervalArithmetic.com)), Interval(bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), IntervalArithmetic.com))

    @test isequal_interval(tan(Interval(bareinterval(0.0,0x1.921FB54442D18P+0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.D02967C31CDB5P+53), IntervalArithmetic.dac))

    @test isequal_interval(tan(Interval(bareinterval(-0.0,0x1.921FB54442D18P+0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.D02967C31CDB5P+53), IntervalArithmetic.com))

    @test isequal_interval(tan(Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0.0,0x1.921FB54442D19P+0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0.0,0x1.921FB54442D18P+1), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0.0,0x1.921FB54442D18P+1), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0.0,0x1.921FB54442D19P+1), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1P-51,0x1.921FB54442D18P+1), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1P-51,0x1.921FB54442D19P+1), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1P-52,0x1.921FB54442D18P+1), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1P-52,0x1.921FB54442D19P+1), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), IntervalArithmetic.com))

    @test isequal_interval(tan(Interval(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), IntervalArithmetic.trv)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4), IntervalArithmetic.com)), Interval(bareinterval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4), IntervalArithmetic.com))

    @test isequal_interval(tan(Interval(bareinterval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0), IntervalArithmetic.dac))

    @test isequal_interval(tan(Interval(bareinterval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12), IntervalArithmetic.def)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(tan(Interval(bareinterval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0), IntervalArithmetic.trv))

end

@testset "minimal_asin_test" begin

    @test isequal_interval(asin(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(asin(bareinterval(0.0,Inf)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(asin(bareinterval(-0.0,Inf)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(asin(bareinterval(-Inf,0.0)), bareinterval(-0x1.921FB54442D19P+0,0.0))

    @test isequal_interval(asin(bareinterval(-Inf,-0.0)), bareinterval(-0x1.921FB54442D19P+0,0.0))

    @test isequal_interval(asin(entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(asin(bareinterval(-1.0,1.0)), bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(asin(bareinterval(-Inf,-1.0)), bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0))

    @test isequal_interval(asin(bareinterval(1.0,Inf)), bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(asin(bareinterval(-1.0,-1.0)), bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0))

    @test isequal_interval(asin(bareinterval(1.0,1.0)), bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(asin(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(asin(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(asin(bareinterval(-Inf,-0x1.0000000000001P+0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(asin(bareinterval(0x1.0000000000001P+0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(asin(bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(-0x1.9A49276037885P-4,0x1.9A49276037885P-4))

    @test isequal_interval(asin(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)), bareinterval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0))

    @test isequal_interval(asin(bareinterval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)), bareinterval(-0x1.921FB50442D19P+0,0x1.921FB50442D19P+0))

end

@testset "minimal_asin_dec_test" begin

    @test isequal_interval(asin(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(asin(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(asin(Interval(bareinterval(-1.0,1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), IntervalArithmetic.com))

    @test isequal_interval(asin(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(asin(Interval(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.def)), Interval(bareinterval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0), IntervalArithmetic.def))

end

@testset "minimal_acos_test" begin

    @test isequal_interval(acos(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(acos(bareinterval(0.0,Inf)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(acos(bareinterval(-0.0,Inf)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(acos(bareinterval(-Inf,0.0)), bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1))

    @test isequal_interval(acos(bareinterval(-Inf,-0.0)), bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1))

    @test isequal_interval(acos(entireinterval(BareInterval{Float64})), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(acos(bareinterval(-1.0,1.0)), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(acos(bareinterval(-Inf,-1.0)), bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1))

    @test isequal_interval(acos(bareinterval(1.0,Inf)), bareinterval(0.0,0.0))

    @test isequal_interval(acos(bareinterval(-1.0,-1.0)), bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1))

    @test isequal_interval(acos(bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(acos(bareinterval(0.0,0.0)), bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(acos(bareinterval(-0.0,-0.0)), bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(acos(bareinterval(-Inf,-0x1.0000000000001P+0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(acos(bareinterval(0x1.0000000000001P+0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(acos(bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-4)), bareinterval(0x1.787B22CE3F59P+0,0x1.ABC447BA464A1P+0))

    @test isequal_interval(acos(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)), bareinterval(0x1P-26,0x1.E837B2FD13428P+0))

    @test isequal_interval(acos(bareinterval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)), bareinterval(0x1P-26,0x1.921FB52442D19P+1))

end

@testset "minimal_acos_dec_test" begin

    @test isequal_interval(acos(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(acos(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(acos(Interval(bareinterval(-1.0,1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.com))

    @test isequal_interval(acos(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(acos(Interval(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.def)), Interval(bareinterval(0x1P-26,0x1.E837B2FD13428P+0), IntervalArithmetic.def))

end

@testset "minimal_atan_test" begin

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0,Inf)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0,Inf)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-Inf,0.0)), bareinterval(-0x1.921FB54442D19P+0,0.0))

    @test isequal_interval(atan(bareinterval(-Inf,-0.0)), bareinterval(-0x1.921FB54442D19P+0,0.0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(1.0,0x1.4C2463567C5ACP+25)), bareinterval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0))

    @test isequal_interval(atan(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), bareinterval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0))

end

@testset "minimal_atan_dec_test" begin

    @test isequal_interval(atan(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0,0.0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(1.0,0x1.4C2463567C5ACP+25), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0), IntervalArithmetic.com))

end

@testset "minimal_atan2_test" begin

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, -0.1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, 1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(0.0, 1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(-0.0, 1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(emptyinterval(BareInterval{Float64}), bareinterval(0.1, 1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, -0.1)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, 0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, -0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, 1.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(-0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(entireinterval(BareInterval{Float64}), bareinterval(0.1, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-2.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(-0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(0.0, 0.0), bareinterval(0.1, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(-0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0, 0.0), bareinterval(0.1, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-2.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(-0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(0.0, -0.0), bareinterval(0.1, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), entireinterval(BareInterval{Float64})), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-0.0, 0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-0.0, -0.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(-0.0, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-0.0, -0.0), bareinterval(0.1, 1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+1,0.0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(-0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, -0.1)), bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, 0.0)), bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, -0.0)), bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, 1.0)), bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(-0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4))

    @test isequal_interval(atan(bareinterval(-2.0, -0.1), bareinterval(0.1, 1.0)), bareinterval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, -0.1)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, 0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, -0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, 1.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0.0))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(-0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0.0))

    @test isequal_interval(atan(bareinterval(-2.0, 0.0), bareinterval(0.1, 1.0)), bareinterval(-0x1.8555A2787982P+0, 0.0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, -0.1)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, 0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, -0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, 1.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0.0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(-0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0.0))

    @test isequal_interval(atan(bareinterval(-2.0, -0.0), bareinterval(0.1, 1.0)), bareinterval(-0x1.8555A2787982P+0, 0.0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), entireinterval(BareInterval{Float64})), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-0.0, 0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-0.0, -0.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, -0.1)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, 0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, -0.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, 1.0)), bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(-0.0, 1.0)), bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-2.0, 1.0), bareinterval(0.1, 1.0)), bareinterval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(0.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-0.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(0.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-0.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, 1.0)), bareinterval(0.0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(0.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(-0.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(-0.0, 1.0), bareinterval(0.1, 1.0)), bareinterval(0.0, 0x1.789BD2C160054P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(0.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-0.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(0.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-0.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-2.0, 1.0)), bareinterval(0.0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(0.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(-0.0, 1.0)), bareinterval(0.0,0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.0, 1.0), bareinterval(0.1, 1.0)), bareinterval(0.0,0x1.789BD2C160054P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), entireinterval(BareInterval{Float64})), bareinterval(0.0, 0x1.921FB54442D19P+1))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(0.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-0.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(0.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-0.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-2.0, -0.1)), bareinterval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-2.0, 0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-2.0, -0.0)), bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-2.0, 1.0)), bareinterval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(0.0, 1.0)), bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(-0.0, 1.0)), bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0))

    @test isequal_interval(atan(bareinterval(0.1, 1.0), bareinterval(0.1, 1.0)), bareinterval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0))

end

@testset "minimal_atan2_dec_test" begin

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.trv)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.def), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.def), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1,0.0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.trv), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.def), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com)), Interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.trv), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.def), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.8555A2787982P+0, 0.0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.8555A2787982P+0, 0.0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.trv)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(bareinterval(0.0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com)), Interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0, 0x1.789BD2C160054P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.trv), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac)), Interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.trv)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0, 0x1.921FB54442D19P+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.trv)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.0, 1.0), IntervalArithmetic.com), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.789BD2C160054P+0), IntervalArithmetic.com))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0, 0x1.921FB54442D19P+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0, 0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.trv), Interval(bareinterval(0.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-0.0, -0.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.trv)), Interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1), IntervalArithmetic.trv))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.com), Interval(bareinterval(-2.0, -0.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), IntervalArithmetic.dac))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.def), Interval(bareinterval(-2.0, 1.0), IntervalArithmetic.dac)), Interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.def), Interval(bareinterval(0.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.dac), Interval(bareinterval(-0.0, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), IntervalArithmetic.def))

    @test isequal_interval(atan(Interval(bareinterval(0.1, 1.0), IntervalArithmetic.dac), Interval(bareinterval(0.1, 1.0), IntervalArithmetic.def)), Interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0), IntervalArithmetic.def))

end

@testset "minimal_sinh_test" begin

    @test isequal_interval(sinh(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sinh(bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(sinh(bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(sinh(bareinterval(-Inf,0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(sinh(bareinterval(-Inf,-0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(sinh(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(sinh(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sinh(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sinh(bareinterval(1.0,0x1.2C903022DD7AAP+8)), bareinterval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432))

    @test isequal_interval(sinh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), bareinterval(-Inf,-0x1.53045B4F849DEP+815))

    @test isequal_interval(sinh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), bareinterval(-0x1.55ECFE1B2B215P+0,0x1.3BF72EA61AF1BP+2))

end

@testset "minimal_sinh_dec_test" begin

    @test isequal_interval(sinh(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(sinh(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(sinh(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def))

    @test isequal_interval(sinh(Interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), IntervalArithmetic.com)), Interval(bareinterval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432), IntervalArithmetic.com))

    @test isequal_interval(sinh(Interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), IntervalArithmetic.com)), Interval(bareinterval(-Inf,-0x1.53045B4F849DEP+815), IntervalArithmetic.dac))

end

@testset "minimal_cosh_test" begin

    @test isequal_interval(cosh(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(cosh(bareinterval(0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(cosh(bareinterval(-0.0,Inf)), bareinterval(1.0,Inf))

    @test isequal_interval(cosh(bareinterval(-Inf,0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(cosh(bareinterval(-Inf,-0.0)), bareinterval(1.0,Inf))

    @test isequal_interval(cosh(entireinterval(BareInterval{Float64})), bareinterval(1.0,Inf))

    @test isequal_interval(cosh(bareinterval(0.0,0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(cosh(bareinterval(-0.0,-0.0)), bareinterval(1.0,1.0))

    @test isequal_interval(cosh(bareinterval(1.0,0x1.2C903022DD7AAP+8)), bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432))

    @test isequal_interval(cosh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), bareinterval(0x1.53045B4F849DEP+815,Inf))

    @test isequal_interval(cosh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), bareinterval(1.0,0x1.4261D2B7D6181P+2))

end

@testset "minimal_cosh_dec_test" begin

    @test isequal_interval(cosh(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(cosh(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(cosh(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(cosh(Interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), IntervalArithmetic.def)), Interval(bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), IntervalArithmetic.def))

    @test isequal_interval(cosh(Interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), IntervalArithmetic.com)), Interval(bareinterval(0x1.53045B4F849DEP+815,Inf), IntervalArithmetic.dac))

end

@testset "minimal_tanh_test" begin

    @test isequal_interval(tanh(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(tanh(bareinterval(0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(tanh(bareinterval(-0.0,Inf)), bareinterval(0.0,1.0))

    @test isequal_interval(tanh(bareinterval(-Inf,0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(tanh(bareinterval(-Inf,-0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(tanh(entireinterval(BareInterval{Float64})), bareinterval(-1.0,1.0))

    @test isequal_interval(tanh(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(tanh(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(tanh(bareinterval(1.0,0x1.2C903022DD7AAP+8)), bareinterval(0x1.85EFAB514F394P-1,0x1P+0))

    @test isequal_interval(tanh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequal_interval(tanh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), bareinterval(-0x1.99DB01FDE2406P-1,0x1.F5CF31E1C8103P-1))

end

@testset "minimal_tanh_dec_test" begin

    @test isequal_interval(tanh(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.dac))

    @test isequal_interval(tanh(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(tanh(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.dac))

    @test isequal_interval(tanh(Interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), IntervalArithmetic.com)), Interval(bareinterval(0x1.85EFAB514F394P-1,0x1P+0), IntervalArithmetic.com))

    @test isequal_interval(tanh(Interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), IntervalArithmetic.trv)), Interval(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.trv))

end

@testset "minimal_asinh_test" begin

    @test isequal_interval(asinh(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(asinh(bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(asinh(bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(asinh(bareinterval(-Inf,0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(asinh(bareinterval(-Inf,-0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(asinh(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(asinh(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(asinh(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(asinh(bareinterval(1.0,0x1.2C903022DD7AAP+8)), bareinterval(0x1.C34366179D426P-1,0x1.9986127438A87P+2))

    @test isequal_interval(asinh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), bareinterval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2))

    @test isequal_interval(asinh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), bareinterval(-0x1.E693DF6EDF1E7P-1,0x1.91FDC64DE0E51P+0))

end

@testset "minimal_asinh_dec_test" begin

    @test isequal_interval(asinh(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(asinh(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv)), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(asinh(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(asinh(Interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), IntervalArithmetic.com)), Interval(bareinterval(0x1.C34366179D426P-1,0x1.9986127438A87P+2), IntervalArithmetic.com))

    @test isequal_interval(asinh(Interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), IntervalArithmetic.def)), Interval(bareinterval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2), IntervalArithmetic.def))

end

@testset "minimal_acosh_test" begin

    @test isequal_interval(acosh(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(acosh(bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(acosh(bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(acosh(bareinterval(1.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(acosh(bareinterval(-Inf,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(acosh(bareinterval(-Inf,0x1.FFFFFFFFFFFFFP-1)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(acosh(entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(acosh(bareinterval(1.0,1.0)), bareinterval(0.0,0.0))

    @test isequal_interval(acosh(bareinterval(1.0,0x1.2C903022DD7AAP+8)), bareinterval(0.0,0x1.9985FB3D532AFP+2))

    @test isequal_interval(acosh(bareinterval(0x1.199999999999AP+0,0x1.2666666666666P+1)), bareinterval(0x1.C636C1A882F2CP-2,0x1.799C88E79140DP+0))

    @test isequal_interval(acosh(bareinterval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29)), bareinterval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4))

end

@testset "minimal_acosh_dec_test" begin

    @test isequal_interval(acosh(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(acosh(Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(acosh(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(acosh(Interval(bareinterval(1.0,1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com))

    @test isequal_interval(acosh(Interval(bareinterval(0.9,1.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(acosh(Interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0x1.9985FB3D532AFP+2), IntervalArithmetic.dac))

    @test isequal_interval(acosh(Interval(bareinterval(0.9,0x1.2C903022DD7AAP+8), IntervalArithmetic.com)), Interval(bareinterval(0.0,0x1.9985FB3D532AFP+2), IntervalArithmetic.trv))

    @test isequal_interval(acosh(Interval(bareinterval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29), IntervalArithmetic.def)), Interval(bareinterval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4), IntervalArithmetic.def))

end

@testset "minimal_atanh_test" begin

    @test isequal_interval(atanh(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(bareinterval(0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(atanh(bareinterval(-0.0,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(atanh(bareinterval(1.0,Inf)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(bareinterval(-Inf,0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(atanh(bareinterval(-Inf,-0.0)), bareinterval(-Inf,0.0))

    @test isequal_interval(atanh(bareinterval(-Inf,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(bareinterval(-1.0,1.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atanh(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(atanh(bareinterval(-1.0,-1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(bareinterval(1.0,1.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(atanh(bareinterval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1)), bareinterval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4))

    @test isequal_interval(atanh(bareinterval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4)), bareinterval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4))

end

@testset "minimal_atanh_dec_test" begin

    @test isequal_interval(atanh(Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(atanh(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.def)), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv))

    @test isequal_interval(atanh(Interval(bareinterval(-1.0,1.0), IntervalArithmetic.com)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atanh(Interval(bareinterval(0.0,0.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.com))

    @test isequal_interval(atanh(Interval(bareinterval(1.0,1.0), IntervalArithmetic.def)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(atanh(Interval(bareinterval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.com)), Interval(bareinterval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4), IntervalArithmetic.com))

    @test isequal_interval(atanh(Interval(bareinterval(-1.0,0x1.FFFFFFFFFFFFFP-1), IntervalArithmetic.com)), Interval(bareinterval(-Inf,0x1.2B708872320E2P+4), IntervalArithmetic.trv))

    @test isequal_interval(atanh(Interval(bareinterval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4), IntervalArithmetic.def)), Interval(bareinterval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4), IntervalArithmetic.def))

    @test isequal_interval(atanh(Interval(bareinterval(-0x1.FFB88E9EB6307P-1,1.0), IntervalArithmetic.com)), Interval(bareinterval(-0x1.06A3A97D7979CP+2,Inf), IntervalArithmetic.trv))

end

@testset "minimal_sign_test" begin

    @test isequal_interval(sign(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(sign(bareinterval(1.0,2.0)), bareinterval(1.0,1.0))

    @test isequal_interval(sign(bareinterval(-1.0,2.0)), bareinterval(-1.0,1.0))

    @test isequal_interval(sign(bareinterval(-1.0,0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(sign(bareinterval(0.0,2.0)), bareinterval(0.0,1.0))

    @test isequal_interval(sign(bareinterval(-0.0,2.0)), bareinterval(0.0,1.0))

    @test isequal_interval(sign(bareinterval(-5.0,-2.0)), bareinterval(-1.0,-1.0))

    @test isequal_interval(sign(bareinterval(0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sign(bareinterval(-0.0,-0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sign(bareinterval(-0.0,0.0)), bareinterval(0.0,0.0))

    @test isequal_interval(sign(entireinterval(BareInterval{Float64})), bareinterval(-1.0,1.0))

end

@testset "minimal_sign_dec_test" begin

    @test isequal_interval(sign(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,1.0), IntervalArithmetic.com))

    @test isequal_interval(sign(Interval(bareinterval(-1.0,2.0), IntervalArithmetic.com)), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.def))

    @test isequal_interval(sign(Interval(bareinterval(-1.0,0.0), IntervalArithmetic.com)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(sign(Interval(bareinterval(0.0,2.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.def))

    @test isequal_interval(sign(Interval(bareinterval(-0.0,2.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,1.0), IntervalArithmetic.def))

    @test isequal_interval(sign(Interval(bareinterval(-5.0,-2.0), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,-1.0), IntervalArithmetic.trv))

    @test isequal_interval(sign(Interval(bareinterval(0.0,0.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,0.0), IntervalArithmetic.dac))

end

@testset "minimal_ceil_test" begin

    @test isequal_interval(ceil(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(ceil(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(ceil(bareinterval(1.1,2.0)), bareinterval(2.0,2.0))

    @test isequal_interval(ceil(bareinterval(-1.1,2.0)), bareinterval(-1.0,2.0))

    @test isequal_interval(ceil(bareinterval(-1.1,0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(ceil(bareinterval(-1.1,-0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(ceil(bareinterval(-1.1,-0.4)), bareinterval(-1.0,0.0))

    @test isequal_interval(ceil(bareinterval(-1.9,2.2)), bareinterval(-1.0,3.0))

    @test isequal_interval(ceil(bareinterval(-1.0,2.2)), bareinterval(-1.0,3.0))

    @test isequal_interval(ceil(bareinterval(0.0,2.2)), bareinterval(0.0,3.0))

    @test isequal_interval(ceil(bareinterval(-0.0,2.2)), bareinterval(0.0,3.0))

    @test isequal_interval(ceil(bareinterval(-1.5,Inf)), bareinterval(-1.0,Inf))

    @test isequal_interval(ceil(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)), bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequal_interval(ceil(bareinterval(-Inf,2.2)), bareinterval(-Inf,3.0))

    @test isequal_interval(ceil(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023)), bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023))

end

@testset "minimal_ceil_dec_test" begin

    @test isequal_interval(ceil(Interval(bareinterval(1.1,2.0), IntervalArithmetic.com)), Interval(bareinterval(2.0,2.0), IntervalArithmetic.dac))

    @test isequal_interval(ceil(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.com)), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(-1.1,0.0), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(-1.1,-0.0), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(ceil(Interval(bareinterval(-1.1,-0.4), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(-1.9,2.2), IntervalArithmetic.com)), Interval(bareinterval(-1.0,3.0), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(-1.0,2.2), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,3.0), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(0.0,2.2), IntervalArithmetic.trv)), Interval(bareinterval(0.0,3.0), IntervalArithmetic.trv))

    @test isequal_interval(ceil(Interval(bareinterval(-0.0,2.2), IntervalArithmetic.def)), Interval(bareinterval(0.0,3.0), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(ceil(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), IntervalArithmetic.def))

    @test isequal_interval(ceil(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac))

    @test isequal_interval(ceil(Interval(bareinterval(-Inf,2.2), IntervalArithmetic.trv)), Interval(bareinterval(-Inf,3.0), IntervalArithmetic.trv))

    @test isequal_interval(ceil(Interval(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac)), Interval(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.def))

end

@testset "minimal_floor_test" begin

    @test isequal_interval(floor(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(floor(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(floor(bareinterval(1.1,2.0)), bareinterval(1.0,2.0))

    @test isequal_interval(floor(bareinterval(-1.1,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(floor(bareinterval(-1.1,0.0)), bareinterval(-2.0,0.0))

    @test isequal_interval(floor(bareinterval(-1.1,-0.0)), bareinterval(-2.0,0.0))

    @test isequal_interval(floor(bareinterval(-1.1,-0.4)), bareinterval(-2.0,-1.0))

    @test isequal_interval(floor(bareinterval(-1.9,2.2)), bareinterval(-2.0,2.0))

    @test isequal_interval(floor(bareinterval(-1.0,2.2)), bareinterval(-1.0,2.0))

    @test isequal_interval(floor(bareinterval(0.0,2.2)), bareinterval(0.0,2.0))

    @test isequal_interval(floor(bareinterval(-0.0,2.2)), bareinterval(0.0,2.0))

    @test isequal_interval(floor(bareinterval(-1.5,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(floor(bareinterval(-Inf,2.2)), bareinterval(-Inf,2.0))

end

@testset "minimal_floor_dec_test" begin

    @test isequal_interval(floor(Interval(bareinterval(1.1,2.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.def)), Interval(bareinterval(-2.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-1.1,0.0), IntervalArithmetic.dac)), Interval(bareinterval(-2.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-1.2,-1.1), IntervalArithmetic.com)), Interval(bareinterval(-2.0,-2.0), IntervalArithmetic.com))

    @test isequal_interval(floor(Interval(bareinterval(-1.1,-0.4), IntervalArithmetic.def)), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-1.9,2.2), IntervalArithmetic.com)), Interval(bareinterval(-2.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-1.0,2.2), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.trv))

    @test isequal_interval(floor(Interval(bareinterval(0.0,2.2), IntervalArithmetic.trv)), Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv))

    @test isequal_interval(floor(Interval(bareinterval(-0.0,2.2), IntervalArithmetic.com)), Interval(bareinterval(0.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(-2.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(floor(Interval(bareinterval(-Inf,2.2), IntervalArithmetic.trv)), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv))

    @test isequal_interval(floor(Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac))

end

@testset "minimal_trunc_test" begin

    @test isequal_interval(trunc(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(trunc(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(trunc(bareinterval(1.1,2.1)), bareinterval(1.0,2.0))

    @test isequal_interval(trunc(bareinterval(-1.1,2.0)), bareinterval(-1.0,2.0))

    @test isequal_interval(trunc(bareinterval(-1.1,0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(trunc(bareinterval(-1.1,-0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(trunc(bareinterval(-1.1,-0.4)), bareinterval(-1.0,0.0))

    @test isequal_interval(trunc(bareinterval(-1.9,2.2)), bareinterval(-1.0,2.0))

    @test isequal_interval(trunc(bareinterval(-1.0,2.2)), bareinterval(-1.0,2.0))

    @test isequal_interval(trunc(bareinterval(0.0,2.2)), bareinterval(0.0,2.0))

    @test isequal_interval(trunc(bareinterval(-0.0,2.2)), bareinterval(0.0,2.0))

    @test isequal_interval(trunc(bareinterval(-1.5,Inf)), bareinterval(-1.0,Inf))

    @test isequal_interval(trunc(bareinterval(-Inf,2.2)), bareinterval(-Inf,2.0))

end

@testset "minimal_trunc_dec_test" begin

    @test isequal_interval(trunc(Interval(bareinterval(1.1,2.1), IntervalArithmetic.com)), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(1.1,1.9), IntervalArithmetic.com)), Interval(bareinterval(1.0,1.0), IntervalArithmetic.com))

    @test isequal_interval(trunc(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(-1.1,0.0), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv))

    @test isequal_interval(trunc(Interval(bareinterval(-1.1,-0.0), IntervalArithmetic.def)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(-1.1,-0.4), IntervalArithmetic.com)), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(-1.9,2.2), IntervalArithmetic.def)), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(-1.0,2.2), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(trunc(Interval(bareinterval(-Inf,2.2), IntervalArithmetic.trv)), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv))

    @test isequal_interval(trunc(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac))

    @test isequal_interval(trunc(Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), IntervalArithmetic.def))

end

@testset "minimal_round_ties_to_even_test" begin

    @test isequal_interval(round(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(round(entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(round(bareinterval(1.1,2.1)), bareinterval(1.0,2.0))

    @test isequal_interval(round(bareinterval(-1.1,2.0)), bareinterval(-1.0,2.0))

    @test isequal_interval(round(bareinterval(-1.1,-0.4)), bareinterval(-1.0,0.0))

    @test isequal_interval(round(bareinterval(-1.1,0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(round(bareinterval(-1.1,-0.0)), bareinterval(-1.0,0.0))

    @test isequal_interval(round(bareinterval(-1.9,2.2)), bareinterval(-2.0,2.0))

    @test isequal_interval(round(bareinterval(-1.0,2.2)), bareinterval(-1.0,2.0))

    @test isequal_interval(round(bareinterval(1.5,2.1)), bareinterval(2.0,2.0))

    @test isequal_interval(round(bareinterval(-1.5,2.0)), bareinterval(-2.0,2.0))

    @test isequal_interval(round(bareinterval(-1.1,-0.5)), bareinterval(-1.0,0.0))

    @test isequal_interval(round(bareinterval(-1.9,2.5)), bareinterval(-2.0,2.0))

    @test isequal_interval(round(bareinterval(0.0,2.5)), bareinterval(0.0,2.0))

    @test isequal_interval(round(bareinterval(-0.0,2.5)), bareinterval(0.0,2.0))

    @test isequal_interval(round(bareinterval(-1.5,2.5)), bareinterval(-2.0,2.0))

    @test isequal_interval(round(bareinterval(-1.5,Inf)), bareinterval(-2.0,Inf))

    @test isequal_interval(round(bareinterval(-Inf,2.2)), bareinterval(-Inf,2.0))

end

@testset "minimal_round_ties_to_even_dec_test" begin

    @test isequal_interval(round(Interval(bareinterval(1.1,2.1), IntervalArithmetic.com)), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(round(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.trv)), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.trv))

    @test isequal_interval(round(Interval(bareinterval(-1.6,-1.5), IntervalArithmetic.com)), Interval(bareinterval(-2.0,-2.0), IntervalArithmetic.dac))

    @test isequal_interval(round(Interval(bareinterval(-1.6,-1.4), IntervalArithmetic.com)), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.def))

    @test isequal_interval(round(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(-2.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(round(Interval(bareinterval(-Inf,2.2), IntervalArithmetic.trv)), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv))

end

@testset "minimal_round_ties_to_away_test" begin

    @test isequal_interval(round(emptyinterval(BareInterval{Float64}), RoundNearestTiesAway), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(round(entireinterval(BareInterval{Float64}), RoundNearestTiesAway), entireinterval(BareInterval{Float64}))

    @test isequal_interval(round(bareinterval(1.1,2.1), RoundNearestTiesAway), bareinterval(1.0,2.0))

    @test isequal_interval(round(bareinterval(-1.1,2.0), RoundNearestTiesAway), bareinterval(-1.0,2.0))

    @test isequal_interval(round(bareinterval(-1.1,0.0), RoundNearestTiesAway), bareinterval(-1.0,0.0))

    @test isequal_interval(round(bareinterval(-1.1,-0.0), RoundNearestTiesAway), bareinterval(-1.0,-0.0))

    @test isequal_interval(round(bareinterval(-1.1,-0.4), RoundNearestTiesAway), bareinterval(-1.0,0.0))

    @test isequal_interval(round(bareinterval(-1.9,2.2), RoundNearestTiesAway), bareinterval(-2.0,2.0))

    @test isequal_interval(round(bareinterval(-1.0,2.2), RoundNearestTiesAway), bareinterval(-1.0,2.0))

    @test isequal_interval(round(bareinterval(0.5,2.1), RoundNearestTiesAway), bareinterval(1.0,2.0))

    @test isequal_interval(round(bareinterval(-2.5,2.0), RoundNearestTiesAway), bareinterval(-3.0,2.0))

    @test isequal_interval(round(bareinterval(-1.1,-0.5), RoundNearestTiesAway), bareinterval(-1.0,-1.0))

    @test isequal_interval(round(bareinterval(-1.9,2.5), RoundNearestTiesAway), bareinterval(-2.0,3.0))

    @test isequal_interval(round(bareinterval(-1.5,2.5), RoundNearestTiesAway), bareinterval(-2.0,3.0))

    @test isequal_interval(round(bareinterval(0.0,2.5), RoundNearestTiesAway), bareinterval(0.0,3.0))

    @test isequal_interval(round(bareinterval(-0.0,2.5), RoundNearestTiesAway), bareinterval(0.0,3.0))

    @test isequal_interval(round(bareinterval(-1.5,Inf), RoundNearestTiesAway), bareinterval(-2.0,Inf))

    @test isequal_interval(round(bareinterval(-Inf,2.2), RoundNearestTiesAway), bareinterval(-Inf,2.0))

end

@testset "minimal_round_ties_to_away_dec_test" begin

    @test isequal_interval(round(Interval(bareinterval(1.1,2.1), IntervalArithmetic.com), RoundNearestTiesAway), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(round(Interval(bareinterval(-1.9,2.2), IntervalArithmetic.com), RoundNearestTiesAway), Interval(bareinterval(-2.0,2.0), IntervalArithmetic.def))

    @test isequal_interval(round(Interval(bareinterval(1.9,2.2), IntervalArithmetic.com), RoundNearestTiesAway), Interval(bareinterval(2.0,2.0), IntervalArithmetic.com))

    @test isequal_interval(round(Interval(bareinterval(-1.0,2.2), IntervalArithmetic.trv), RoundNearestTiesAway), Interval(bareinterval(-1.0,2.0), IntervalArithmetic.trv))

    @test isequal_interval(round(Interval(bareinterval(2.5,2.6), IntervalArithmetic.com), RoundNearestTiesAway), Interval(bareinterval(3.0,3.0), IntervalArithmetic.dac))

    @test isequal_interval(round(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.dac), RoundNearestTiesAway), Interval(bareinterval(-2.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(round(Interval(bareinterval(-Inf,2.2), IntervalArithmetic.def), RoundNearestTiesAway), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.def))

end

@testset "minimal_abs_test" begin

    @test isequal_interval(abs(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs(entireinterval(BareInterval{Float64})), bareinterval(0.0,Inf))

    @test isequal_interval(abs(bareinterval(1.1,2.1)), bareinterval(1.1,2.1))

    @test isequal_interval(abs(bareinterval(-1.1,2.0)), bareinterval(0.0,2.0))

    @test isequal_interval(abs(bareinterval(-1.1,0.0)), bareinterval(0.0,1.1))

    @test isequal_interval(abs(bareinterval(-1.1,-0.0)), bareinterval(0.0,1.1))

    @test isequal_interval(abs(bareinterval(-1.1,-0.4)), bareinterval(0.4,1.1))

    @test isequal_interval(abs(bareinterval(-1.9,0.2)), bareinterval(0.0,1.9))

    @test isequal_interval(abs(bareinterval(0.0,0.2)), bareinterval(0.0,0.2))

    @test isequal_interval(abs(bareinterval(-0.0,0.2)), bareinterval(0.0,0.2))

    @test isequal_interval(abs(bareinterval(-1.5,Inf)), bareinterval(0.0,Inf))

    @test isequal_interval(abs(bareinterval(-Inf,-2.2)), bareinterval(2.2,Inf))

end

@testset "minimal_abs_dec_test" begin

    @test isequal_interval(abs(Interval(bareinterval(-1.1,2.0), IntervalArithmetic.com)), Interval(bareinterval(0.0,2.0), IntervalArithmetic.com))

    @test isequal_interval(abs(Interval(bareinterval(-1.1,0.0), IntervalArithmetic.dac)), Interval(bareinterval(0.0,1.1), IntervalArithmetic.dac))

    @test isequal_interval(abs(Interval(bareinterval(-1.1,-0.0), IntervalArithmetic.def)), Interval(bareinterval(0.0,1.1), IntervalArithmetic.def))

    @test isequal_interval(abs(Interval(bareinterval(-1.1,-0.4), IntervalArithmetic.trv)), Interval(bareinterval(0.4,1.1), IntervalArithmetic.trv))

    @test isequal_interval(abs(Interval(bareinterval(-1.9,0.2), IntervalArithmetic.dac)), Interval(bareinterval(0.0,1.9), IntervalArithmetic.dac))

    @test isequal_interval(abs(Interval(bareinterval(0.0,0.2), IntervalArithmetic.def)), Interval(bareinterval(0.0,0.2), IntervalArithmetic.def))

    @test isequal_interval(abs(Interval(bareinterval(-0.0,0.2), IntervalArithmetic.com)), Interval(bareinterval(0.0,0.2), IntervalArithmetic.com))

    @test isequal_interval(abs(Interval(bareinterval(-1.5,Inf), IntervalArithmetic.dac)), Interval(bareinterval(0.0,Inf), IntervalArithmetic.dac))

end

@testset "minimal_min_test" begin

    @test isequal_interval(min(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(min(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(min(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(min(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0)), bareinterval(-Inf,2.0))

    @test isequal_interval(min(bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})), bareinterval(-Inf,2.0))

    @test isequal_interval(min(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(min(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(min(bareinterval(1.0,5.0), bareinterval(2.0,4.0)), bareinterval(1.0,4.0))

    @test isequal_interval(min(bareinterval(0.0,5.0), bareinterval(2.0,4.0)), bareinterval(0.0,4.0))

    @test isequal_interval(min(bareinterval(-0.0,5.0), bareinterval(2.0,4.0)), bareinterval(0.0,4.0))

    @test isequal_interval(min(bareinterval(1.0,5.0), bareinterval(2.0,8.0)), bareinterval(1.0,5.0))

    @test isequal_interval(min(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64})), bareinterval(-Inf,5.0))

    @test isequal_interval(min(bareinterval(-7.0,-5.0), bareinterval(2.0,4.0)), bareinterval(-7.0,-5.0))

    @test isequal_interval(min(bareinterval(-7.0,0.0), bareinterval(2.0,4.0)), bareinterval(-7.0,0.0))

    @test isequal_interval(min(bareinterval(-7.0,-0.0), bareinterval(2.0,4.0)), bareinterval(-7.0,0.0))

end

@testset "minimal_min_dec_test" begin

    @test isequal_interval(min(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.dac))

    @test isequal_interval(min(Interval(bareinterval(-7.0,-5.0), IntervalArithmetic.trv), Interval(bareinterval(2.0,4.0), IntervalArithmetic.def)), Interval(bareinterval(-7.0,-5.0), IntervalArithmetic.trv))

    @test isequal_interval(min(Interval(bareinterval(-7.0,0.0), IntervalArithmetic.dac), Interval(bareinterval(2.0,4.0), IntervalArithmetic.def)), Interval(bareinterval(-7.0,0.0), IntervalArithmetic.def))

    @test isequal_interval(min(Interval(bareinterval(-7.0,-0.0), IntervalArithmetic.com), Interval(bareinterval(2.0,4.0), IntervalArithmetic.com)), Interval(bareinterval(-7.0,0.0), IntervalArithmetic.com))

end

@testset "minimal_max_test" begin

    @test isequal_interval(max(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(max(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(max(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(max(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0)), bareinterval(1.0,Inf))

    @test isequal_interval(max(bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})), bareinterval(1.0,Inf))

    @test isequal_interval(max(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

    @test isequal_interval(max(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(max(bareinterval(1.0,5.0), bareinterval(2.0,4.0)), bareinterval(2.0,5.0))

    @test isequal_interval(max(bareinterval(1.0,5.0), bareinterval(2.0,8.0)), bareinterval(2.0,8.0))

    @test isequal_interval(max(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})), bareinterval(-1.0,Inf))

    @test isequal_interval(max(bareinterval(-7.0,-5.0), bareinterval(2.0,4.0)), bareinterval(2.0,4.0))

    @test isequal_interval(max(bareinterval(-7.0,-5.0), bareinterval(0.0,4.0)), bareinterval(0.0,4.0))

    @test isequal_interval(max(bareinterval(-7.0,-5.0), bareinterval(-0.0,4.0)), bareinterval(0.0,4.0))

    @test isequal_interval(max(bareinterval(-7.0,-5.0), bareinterval(-2.0,0.0)), bareinterval(-2.0,0.0))

    @test isequal_interval(max(bareinterval(-7.0,-5.0), bareinterval(-2.0,-0.0)), bareinterval(-2.0,0.0))

end

@testset "minimal_max_dec_test" begin

    @test isequal_interval(max(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(max(Interval(bareinterval(-7.0,-5.0), IntervalArithmetic.trv), Interval(bareinterval(2.0,4.0), IntervalArithmetic.def)), Interval(bareinterval(2.0,4.0), IntervalArithmetic.trv))

    @test isequal_interval(max(Interval(bareinterval(-7.0,5.0), IntervalArithmetic.dac), Interval(bareinterval(2.0,4.0), IntervalArithmetic.def)), Interval(bareinterval(2.0,5.0), IntervalArithmetic.def))

    @test isequal_interval(max(Interval(bareinterval(3.0,3.5), IntervalArithmetic.com), Interval(bareinterval(2.0,4.0), IntervalArithmetic.com)), Interval(bareinterval(3.0,4.0), IntervalArithmetic.com))

end
