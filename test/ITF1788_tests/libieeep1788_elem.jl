@testset "minimal_pos_test" begin

    @test +(bareinterval(1.0,2.0)) === bareinterval(1.0,2.0)

    @test +(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(1.0,Inf)) === bareinterval(1.0,Inf)

    @test +(bareinterval(-Inf,-1.0)) === bareinterval(-Inf,-1.0)

    @test +(bareinterval(0.0,2.0)) === bareinterval(0.0,2.0)

    @test +(bareinterval(-0.0,2.0)) === bareinterval(0.0,2.0)

    @test +(bareinterval(-2.5,-0.0)) === bareinterval(-2.5,0.0)

    @test +(bareinterval(-2.5,0.0)) === bareinterval(-2.5,0.0)

    @test +(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test +(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

end

@testset "minimal_pos_dec_test" begin

    @test +(nai(Interval{Float64})) === nai(Interval{Float64})

    @test +(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test +(interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), dac)

    @test +(interval(bareinterval(1.0, 2.0), com)) === interval(bareinterval(1.0, 2.0), com)

end

@testset "minimal_neg_test" begin

    @test -(bareinterval(1.0,2.0)) === bareinterval(-2.0,-1.0)

    @test -(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(1.0,Inf)) === bareinterval(-Inf,-1.0)

    @test -(bareinterval(-Inf,1.0)) === bareinterval(-1.0,Inf)

    @test -(bareinterval(0.0,2.0)) === bareinterval(-2.0,0.0)

    @test -(bareinterval(-0.0,2.0)) === bareinterval(-2.0,0.0)

    @test -(bareinterval(-2.0,0.0)) === bareinterval(0.0,2.0)

    @test -(bareinterval(-2.0,-0.0)) === bareinterval(0.0,2.0)

    @test -(bareinterval(0.0,-0.0)) === bareinterval(0.0,0.0)

    @test -(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

end

@testset "minimal_neg_dec_test" begin

    @test -(nai(Interval{Float64})) === nai(Interval{Float64})

    @test -(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test -(interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), dac)

    @test -(interval(bareinterval(1.0, 2.0), com)) === interval(bareinterval(-2.0, -1.0), com)

end

@testset "minimal_add_test" begin

    @test +(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test +(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test +(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test +(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)) === entireinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)) === entireinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), bareinterval(-1.0,Inf)) === entireinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(-Inf,1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(-1.0,1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(-Inf,2.0), bareinterval(-Inf,4.0)) === bareinterval(-Inf,6.0)

    @test +(bareinterval(-Inf,2.0), bareinterval(3.0,4.0)) === bareinterval(-Inf,6.0)

    @test +(bareinterval(-Inf,2.0), bareinterval(3.0,Inf)) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(1.0,2.0), bareinterval(-Inf,4.0)) === bareinterval(-Inf,6.0)

    @test +(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === bareinterval(4.0,6.0)

    @test +(bareinterval(1.0,2.0), bareinterval(3.0,Inf)) === bareinterval(4.0,Inf)

    @test +(bareinterval(1.0,Inf), bareinterval(-Inf,4.0)) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(1.0,Inf), bareinterval(3.0,4.0)) === bareinterval(4.0,Inf)

    @test +(bareinterval(1.0,Inf), bareinterval(3.0,Inf)) === bareinterval(4.0,Inf)

    @test +(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(3.0,4.0)) === bareinterval(4.0,Inf)

    @test +(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(-3.0,4.0)) === bareinterval(-Inf,6.0)

    @test +(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(0.0,0.0)) === bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test +(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0.0,-0.0)) === bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test +(bareinterval(0.0,0.0), bareinterval(-3.0,4.0)) === bareinterval(-3.0,4.0)

    @test +(bareinterval(-0.0,-0.0), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)

    @test +(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1)

    @test +(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)) === bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test +(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(-0x1.E666666666657P+0,0x1.0CCCCCCCCCCC5P+1)

end

@testset "minimal_add_dec_test" begin

    @test +(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,7.0), com)) === interval(bareinterval(6.0,9.0), com)

    @test +(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,7.0), def)) === interval(bareinterval(6.0,9.0), def)

    @test +(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(6.0,Inf), dac)

    @test +(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), interval(bareinterval(-0.1, 5.0), com)) === interval(bareinterval(-Inf,7.0), dac)

    @test +(interval(bareinterval(1.0,2.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test +(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), trv)) === nai(Interval{Float64})

end

@testset "minimal_sub_test" begin

    @test -(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test -(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test -(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test -(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), bareinterval(-Inf,1.0)) === entireinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)) === entireinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), bareinterval(-1.0,Inf)) === entireinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(-Inf,1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(-1.0,1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(-Inf,2.0), bareinterval(-Inf,4.0)) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(-Inf,2.0), bareinterval(3.0,4.0)) === bareinterval(-Inf,-1.0)

    @test -(bareinterval(-Inf,2.0), bareinterval(3.0,Inf)) === bareinterval(-Inf,-1.0)

    @test -(bareinterval(1.0,2.0), bareinterval(-Inf,4.0)) === bareinterval(-3.0,Inf)

    @test -(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === bareinterval(-3.0,-1.0)

    @test -(bareinterval(1.0,2.0), bareinterval(3.0,Inf)) === bareinterval(-Inf,-1.0)

    @test -(bareinterval(1.0,Inf), bareinterval(-Inf,4.0)) === bareinterval(-3.0,Inf)

    @test -(bareinterval(1.0,Inf), bareinterval(3.0,4.0)) === bareinterval(-3.0,Inf)

    @test -(bareinterval(1.0,Inf), bareinterval(3.0,Inf)) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(-3.0,4.0)) === bareinterval(-3.0,Inf)

    @test -(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(3.0,4.0)) === bareinterval(-Inf,-1.0)

    @test -(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), bareinterval(-0x1.FFFFFFFFFFFFFp1023,4.0)) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(0.0,0.0)) === bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test -(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023), bareinterval(-0.0,-0.0)) === bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test -(bareinterval(0.0,0.0), bareinterval(-3.0,4.0)) === bareinterval(-4.0,3.0)

    @test -(bareinterval(-0.0,-0.0), bareinterval(-3.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-0x1.FFFFFFFFFFFFFp1023,3.0)

    @test -(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test -(bareinterval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)) === bareinterval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1)

    @test -(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(-0x1.0CCCCCCCCCCC5P+1,0x1.E666666666657P+0)

end

@testset "minimal_sub_dec_test" begin

    @test -(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,7.0), com)) === interval(bareinterval(-6.0,-3.0), com)

    @test -(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,7.0), def)) === interval(bareinterval(-6.0,-3.0), def)

    @test -(interval(bareinterval(-1.0,2.0), com), interval(bareinterval(5.0,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-Inf,-3.0), dac)

    @test -(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), interval(bareinterval(-1.0, 5.0), com)) === interval(bareinterval(-Inf,3.0), dac)

    @test -(interval(bareinterval(1.0,2.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test -(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), trv)) === nai(Interval{Float64})

end

@testset "minimal_mul_test" begin

    @test *(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test *(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test *(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test *(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test *(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test *(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test *(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(1.0,Inf), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0)) === bareinterval(-Inf,-1.0)

    @test *(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(1.0,Inf), bareinterval(1.0, 3.0)) === bareinterval(1.0,Inf)

    @test *(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0)) === bareinterval(-Inf,-1.0)

    @test *(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(1.0,Inf), bareinterval(-5.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(1.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0,Inf)

    @test *(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,Inf), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0)) === bareinterval(-Inf,5.0)

    @test *(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0)) === bareinterval(-3.0,Inf)

    @test *(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,Inf), bareinterval(1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,3.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0)) === bareinterval(-15.0,Inf)

    @test *(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0)) === bareinterval(-Inf,9.0)

    @test *(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,3.0), bareinterval(1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0)) === bareinterval(3.0,Inf)

    @test *(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0)) === bareinterval(-Inf,-3.0)

    @test *(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0)) === bareinterval(3.0,Inf)

    @test *(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf)) === bareinterval(-Inf,-3.0)

    @test *(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(0.0,0.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(1.0, 3.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(-5.0, Inf)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), bareinterval(1.0, Inf)) === bareinterval(0.0,0.0)

    @test *(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test *(bareinterval(1.0,5.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0)) === bareinterval(-25.0,-1.0)

    @test *(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0)) === bareinterval(-25.0,15.0)

    @test *(bareinterval(1.0,5.0), bareinterval(1.0, 3.0)) === bareinterval(1.0,15.0)

    @test *(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0)) === bareinterval(-Inf,-1.0)

    @test *(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0)) === bareinterval(-Inf,15.0)

    @test *(bareinterval(1.0,5.0), bareinterval(-5.0, Inf)) === bareinterval(-25.0,Inf)

    @test *(bareinterval(1.0,5.0), bareinterval(1.0, Inf)) === bareinterval(1.0,Inf)

    @test *(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,5.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0)) === bareinterval(-25.0,5.0)

    @test *(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0)) === bareinterval(-25.0,15.0)

    @test *(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0)) === bareinterval(-30.0,50.0)

    @test *(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0)) === bareinterval(-10.0,50.0)

    @test *(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0)) === bareinterval(-10.0,10.0)

    @test *(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0)) === bareinterval(-3.0,15.0)

    @test *(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,5.0), bareinterval(1.0, Inf)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test *(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0)) === bareinterval(5.0,50.0)

    @test *(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0)) === bareinterval(-30.0,50.0)

    @test *(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0)) === bareinterval(-30.0,-5.0)

    @test *(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0)) === bareinterval(5.0,Inf)

    @test *(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0)) === bareinterval(-30.0,Inf)

    @test *(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf)) === bareinterval(-Inf,50.0)

    @test *(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf)) === bareinterval(-Inf,-5.0)

    @test *(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.FFFFFFFFFFFFP+0, Inf)) === bareinterval(-0x1.FFFFFFFFFFFE1P+1,Inf)

    @test *(bareinterval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), bareinterval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4)) === bareinterval(-0x1.FFFFFFFFFFFE1P+1,0x1.999999999998EP-3)

    @test *(bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-4), bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)) === bareinterval(-0x1.999999999998EP-3,0x1.999999999998EP-3)

    @test *(bareinterval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4), bareinterval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)) === bareinterval(-0x1.FFFFFFFFFFFE1P+1,-0x1.47AE147AE147BP-7)

end

@testset "minimal_mul_dec_test" begin

    @test *(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,7.0), com)) === interval(bareinterval(5.0,14.0), com)

    @test *(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,7.0), def)) === interval(bareinterval(5.0,14.0), def)

    @test *(interval(bareinterval(1.0,2.0), com), interval(bareinterval(5.0,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(5.0,Inf), dac)

    @test *(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), interval(bareinterval(-1.0, 5.0), com)) === interval(bareinterval(-Inf,0x1.FFFFFFFFFFFFFp1023), dac)

    @test *(interval(bareinterval(1.0,2.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test *(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), trv)) === nai(Interval{Float64})

end

@testset "minimal_div_test" begin

    @test /(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test /(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test /(emptyinterval(BareInterval{Float64}), bareinterval(0.1,1.0)) === emptyinterval(BareInterval{Float64})

    @test /(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test /(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test /(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test /(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -3.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(3.0,Inf)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-3.0, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-15.0), bareinterval(-5.0, -3.0)) === bareinterval(3.0,10.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(3.0, 5.0)) === bareinterval(-10.0,-3.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(3.0,Inf)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-15.0), bareinterval(-3.0, 0.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-15.0), bareinterval(-3.0, -0.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-15.0), bareinterval(0.0, 3.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-0.0, 3.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-15.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-15.0), bareinterval(0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,-15.0), bareinterval(-0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,-15.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-5.0, -3.0)) === bareinterval(-5.0,10.0)

    @test /(bareinterval(-30.0,15.0), bareinterval(3.0, 5.0)) === bareinterval(-10.0,5.0)

    @test /(bareinterval(-30.0,15.0), bareinterval(-Inf, -3.0)) === bareinterval(-5.0,10.0)

    @test /(bareinterval(-30.0,15.0), bareinterval(3.0,Inf)) === bareinterval(-10.0,5.0)

    @test /(bareinterval(-30.0,15.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-3.0, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-Inf, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), bareinterval(-0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,15.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,30.0), bareinterval(-5.0, -3.0)) === bareinterval(-10.0,-3.0)

    @test /(bareinterval(15.0,30.0), bareinterval(3.0, 5.0)) === bareinterval(3.0,10.0)

    @test /(bareinterval(15.0,30.0), bareinterval(-Inf, -3.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(15.0,30.0), bareinterval(3.0,Inf)) === bareinterval(0.0,10.0)

    @test /(bareinterval(15.0,30.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,30.0), bareinterval(-3.0, 0.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(15.0,30.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,30.0), bareinterval(-3.0, -0.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(15.0,30.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,30.0), bareinterval(0.0, 3.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(15.0,30.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(15.0,30.0), bareinterval(-0.0, 3.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(15.0,30.0), bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(15.0,30.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,30.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,30.0), bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(15.0,30.0), bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(15.0,30.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,0.0), bareinterval(-5.0, -3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(3.0, 5.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(3.0,Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,0.0), bareinterval(-3.0, 0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,0.0), bareinterval(-3.0, -0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-3.0, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(0.0, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-0.0, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-3.0, Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(0.0, Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), bareinterval(-0.0, Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-5.0, -3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(3.0, 5.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(3.0,Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,-0.0), bareinterval(-3.0, 0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,-0.0), bareinterval(-3.0, -0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-3.0, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(0.0, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-0.0, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-3.0, Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(0.0, Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), bareinterval(-0.0, Inf)) === bareinterval(0.0,0.0)

    @test /(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-5.0, -3.0)) === bareinterval(3.0,Inf)

    @test /(bareinterval(-Inf,-15.0), bareinterval(3.0, 5.0)) === bareinterval(-Inf,-3.0)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-15.0), bareinterval(3.0,Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-15.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-15.0), bareinterval(-3.0, 0.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-15.0), bareinterval(-3.0, -0.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-15.0), bareinterval(0.0, 3.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-0.0, 3.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-15.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-15.0), bareinterval(0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-15.0), bareinterval(-0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-15.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-5.0, -3.0)) === bareinterval(-5.0,Inf)

    @test /(bareinterval(-Inf,15.0), bareinterval(3.0, 5.0)) === bareinterval(-Inf,5.0)

    @test /(bareinterval(-Inf,15.0), bareinterval(-Inf, -3.0)) === bareinterval(-5.0,Inf)

    @test /(bareinterval(-Inf,15.0), bareinterval(3.0,Inf)) === bareinterval(-Inf,5.0)

    @test /(bareinterval(-Inf,15.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-3.0, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-Inf, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), bareinterval(-0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,15.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-5.0, -3.0)) === bareinterval(-Inf,5.0)

    @test /(bareinterval(-15.0,Inf), bareinterval(3.0, 5.0)) === bareinterval(-5.0,Inf)

    @test /(bareinterval(-15.0,Inf), bareinterval(-Inf, -3.0)) === bareinterval(-Inf,5.0)

    @test /(bareinterval(-15.0,Inf), bareinterval(3.0,Inf)) === bareinterval(-5.0,Inf)

    @test /(bareinterval(-15.0,Inf), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-3.0, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-Inf, -0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), bareinterval(-0.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-15.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,Inf), bareinterval(-5.0, -3.0)) === bareinterval(-Inf,-3.0)

    @test /(bareinterval(15.0,Inf), bareinterval(3.0, 5.0)) === bareinterval(3.0,Inf)

    @test /(bareinterval(15.0,Inf), bareinterval(-Inf, -3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(15.0,Inf), bareinterval(3.0,Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(15.0,Inf), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,Inf), bareinterval(-3.0, 0.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(15.0,Inf), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,Inf), bareinterval(-3.0, -0.0)) === bareinterval(-Inf,-5.0)

    @test /(bareinterval(15.0,Inf), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,Inf), bareinterval(0.0, 3.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(15.0,Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(15.0,Inf), bareinterval(-0.0, 3.0)) === bareinterval(5.0,Inf)

    @test /(bareinterval(15.0,Inf), bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(15.0,Inf), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,Inf), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(15.0,Inf), bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(15.0,Inf), bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(15.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,0.0), bareinterval(-5.0, -3.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(3.0, 5.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(3.0,Inf)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,0.0), bareinterval(-3.0, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,0.0), bareinterval(-3.0, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,0.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,0.0), bareinterval(0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,0.0), bareinterval(-0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,0.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,0.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,0.0), bareinterval(0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,0.0), bareinterval(-0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-0.0), bareinterval(-5.0, -3.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(3.0, 5.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(3.0,Inf)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-0.0), bareinterval(-3.0, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-0.0), bareinterval(-3.0, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-0.0), bareinterval(0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-0.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-30.0,-0.0), bareinterval(0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,-0.0), bareinterval(-0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-30.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,30.0), bareinterval(-5.0, -3.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(0.0,30.0), bareinterval(3.0, 5.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(0.0,30.0), bareinterval(-Inf, -3.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(0.0,30.0), bareinterval(3.0,Inf)) === bareinterval(0.0,10.0)

    @test /(bareinterval(0.0,30.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,30.0), bareinterval(-3.0, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,30.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,30.0), bareinterval(-3.0, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,30.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,30.0), bareinterval(0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,30.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,30.0), bareinterval(-0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,30.0), bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,30.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,30.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,30.0), bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,30.0), bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,30.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,30.0), bareinterval(-5.0, -3.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(3.0, 5.0)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(-Inf, -3.0)) === bareinterval(-10.0,0.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(3.0,Inf)) === bareinterval(0.0,10.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,30.0), bareinterval(-3.0, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,30.0), bareinterval(-3.0, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,30.0), bareinterval(0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,30.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(-0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,30.0), bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,30.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,30.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,30.0), bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,30.0), bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,30.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,0.0), bareinterval(-5.0, -3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,0.0), bareinterval(3.0, 5.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,0.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,0.0), bareinterval(3.0,Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,0.0), bareinterval(-3.0, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,0.0), bareinterval(-3.0, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,0.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,0.0), bareinterval(0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,0.0), bareinterval(-0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,0.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,0.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,0.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,0.0), bareinterval(0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,0.0), bareinterval(-0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-0.0), bareinterval(-5.0, -3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-0.0), bareinterval(3.0, 5.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-Inf, -3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-0.0), bareinterval(3.0,Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-0.0), bareinterval(-3.0, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-0.0), bareinterval(-3.0, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-0.0), bareinterval(0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-0.0, 3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-Inf, -0.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-0.0), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf,-0.0), bareinterval(0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-0.0), bareinterval(-0.0, Inf)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-Inf,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,Inf), bareinterval(-5.0, -3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,Inf), bareinterval(3.0, 5.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,Inf), bareinterval(-Inf, -3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,Inf), bareinterval(3.0,Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,Inf), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,Inf), bareinterval(-3.0, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,Inf), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,Inf), bareinterval(-3.0, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,Inf), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,Inf), bareinterval(0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,Inf), bareinterval(-0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,Inf), bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(0.0,Inf), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,Inf), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0,Inf), bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,Inf), bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,Inf), bareinterval(-5.0, -3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,Inf), bareinterval(3.0, 5.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,Inf), bareinterval(-Inf, -3.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,Inf), bareinterval(3.0,Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,Inf), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,Inf), bareinterval(-3.0, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,Inf), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,Inf), bareinterval(-3.0, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,Inf), bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,Inf), bareinterval(0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,Inf), bareinterval(-0.0, 3.0)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,Inf), bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test /(bareinterval(-0.0,Inf), bareinterval(-Inf, 3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,Inf), bareinterval(-3.0, Inf)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0.0,Inf), bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,Inf), bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test /(bareinterval(-0.0,Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-2.0,-1.0), bareinterval(-10.0, -3.0)) === bareinterval(0x1.9999999999999P-4,0x1.5555555555556P-1)

    @test /(bareinterval(-2.0,-1.0), bareinterval(0.0, 10.0)) === bareinterval(-Inf,-0x1.9999999999999P-4)

    @test /(bareinterval(-2.0,-1.0), bareinterval(-0.0, 10.0)) === bareinterval(-Inf,-0x1.9999999999999P-4)

    @test /(bareinterval(-1.0,2.0), bareinterval(10.0,Inf)) === bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-3)

    @test /(bareinterval(1.0,3.0), bareinterval(-Inf, -10.0)) === bareinterval(-0x1.3333333333334P-2,0.0)

    @test /(bareinterval(-Inf,-1.0), bareinterval(1.0, 3.0)) === bareinterval(-Inf,-0x1.5555555555555P-2)

end

@testset "minimal_div_dec_test" begin

    @test /(interval(bareinterval(-2.0,-1.0), com), interval(bareinterval(-10.0, -3.0), com)) === interval(bareinterval(0x1.9999999999999P-4,0x1.5555555555556P-1), com)

    @test /(interval(bareinterval(-200.0,-1.0), com), interval(bareinterval(0x0.0000000000001p-1022, 10.0), com)) === interval(bareinterval(-Inf,-0x1.9999999999999P-4), dac)

    @test /(interval(bareinterval(-2.0,-1.0), com), interval(bareinterval(0.0, 10.0), com)) === interval(bareinterval(-Inf,-0x1.9999999999999P-4), trv)

    @test /(interval(bareinterval(1.0,3.0), def), interval(bareinterval(-Inf, -10.0), dac)) === interval(bareinterval(-0x1.3333333333334P-2,0.0), def)

    @test /(interval(bareinterval(1.0,2.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test /(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), trv)) === nai(Interval{Float64})

end

@testset "minimal_recip_test" begin

    @test inv(bareinterval(-50.0, -10.0)) === bareinterval(-0x1.999999999999AP-4,-0x1.47AE147AE147AP-6)

    @test inv(bareinterval(10.0, 50.0)) === bareinterval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4)

    @test inv(bareinterval(-Inf, -10.0)) === bareinterval(-0x1.999999999999AP-4,0.0)

    @test inv(bareinterval(10.0,Inf)) === bareinterval(0.0,0x1.999999999999AP-4)

    @test inv(bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test inv(bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test inv(bareinterval(-10.0, 0.0)) === bareinterval(-Inf,-0x1.9999999999999P-4)

    @test inv(bareinterval(-10.0, -0.0)) === bareinterval(-Inf,-0x1.9999999999999P-4)

    @test inv(bareinterval(-10.0, 10.0)) === entireinterval(BareInterval{Float64})

    @test inv(bareinterval(0.0, 10.0)) === bareinterval(0x1.9999999999999P-4,Inf)

    @test inv(bareinterval(-0.0, 10.0)) === bareinterval(0x1.9999999999999P-4,Inf)

    @test inv(bareinterval(-Inf, 0.0)) === bareinterval(-Inf,0.0)

    @test inv(bareinterval(-Inf, -0.0)) === bareinterval(-Inf,0.0)

    @test inv(bareinterval(-Inf, 10.0)) === entireinterval(BareInterval{Float64})

    @test inv(bareinterval(-10.0, Inf)) === entireinterval(BareInterval{Float64})

    @test inv(bareinterval(0.0, Inf)) === bareinterval(0.0,Inf)

    @test inv(bareinterval(-0.0, Inf)) === bareinterval(0.0,Inf)

    @test inv(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

end

@testset "minimal_recip_dec_test" begin

    @test inv(interval(bareinterval(10.0, 50.0), com)) === interval(bareinterval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4), com)

    @test inv(interval(bareinterval(-Inf, -10.0), dac)) === interval(bareinterval(-0x1.999999999999AP-4,0.0), dac)

    @test inv(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023, -0x0.0000000000001p-1022), def)) === interval(bareinterval(-Inf,-0x0.4P-1022), def)

    @test inv(interval(bareinterval(0.0,0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test inv(interval(bareinterval(-10.0, 0.0), com)) === interval(bareinterval(-Inf,-0x1.9999999999999P-4), trv)

    @test inv(interval(bareinterval(-10.0, Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test inv(interval(bareinterval(-0.0, Inf), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test inv(interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_sqr_test" begin

    @test pown(emptyinterval(BareInterval{Float64}), 2) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,-0x0.0000000000001p-1022), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-1.0,1.0), 2) === bareinterval(0.0,1.0)

    @test pown(bareinterval(0.0,1.0), 2) === bareinterval(0.0,1.0)

    @test pown(bareinterval(-0.0,1.0), 2) === bareinterval(0.0,1.0)

    @test pown(bareinterval(-5.0,3.0), 2) === bareinterval(0.0,25.0)

    @test pown(bareinterval(-5.0,0.0), 2) === bareinterval(0.0,25.0)

    @test pown(bareinterval(-5.0,-0.0), 2) === bareinterval(0.0,25.0)

    @test pown(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4), 2) === bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4), 2) === bareinterval(0.0,0x1.FFFFFFFFFFFE1P+1)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFP+0,-0x1.FFFFFFFFFFFFP+0), 2) === bareinterval(0x1.FFFFFFFFFFFEP+1,0x1.FFFFFFFFFFFE1P+1)

end

@testset "minimal_sqr_dec_test" begin

    @test pown(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x0.0000000000001p-1022), com), 2) === interval(bareinterval(0.0,Inf), dac)

    @test pown(interval(bareinterval(-1.0,1.0), def), 2) === interval(bareinterval(0.0,1.0), def)

    @test pown(interval(bareinterval(-5.0,3.0), com), 2) === interval(bareinterval(0.0,25.0), com)

    @test pown(interval(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4), com), 2) === interval(bareinterval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), com)

end

@testset "minimal_sqrt_test" begin

    @test sqrt(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test sqrt(entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test sqrt(bareinterval(-Inf,-0x0.0000000000001p-1022)) === emptyinterval(BareInterval{Float64})

    @test sqrt(bareinterval(-1.0,1.0)) === bareinterval(0.0,1.0)

    @test sqrt(bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test sqrt(bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test sqrt(bareinterval(-5.0,25.0)) === bareinterval(0.0,5.0)

    @test sqrt(bareinterval(0.0,25.0)) === bareinterval(0.0,5.0)

    @test sqrt(bareinterval(-0.0,25.0)) === bareinterval(0.0,5.0)

    @test sqrt(bareinterval(-5.0,Inf)) === bareinterval(0.0,Inf)

    @test sqrt(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(0x1.43D136248490FP-2,0x1.43D136248491P-2)

    @test sqrt(bareinterval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)) === bareinterval(0.0,0x1.43D136248491P-2)

    @test sqrt(bareinterval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)) === bareinterval(0x1.43D136248490FP-2,0x1.6A09E667F3BC7P+0)

end

@testset "minimal_sqrt_dec_test" begin

    @test sqrt(interval(bareinterval(1.0,4.0), com)) === interval(bareinterval(1.0,2.0), com)

    @test sqrt(interval(bareinterval(-5.0,25.0), com)) === interval(bareinterval(0.0,5.0), trv)

    @test sqrt(interval(bareinterval(0.0,25.0), def)) === interval(bareinterval(0.0,5.0), def)

    @test sqrt(interval(bareinterval(-5.0,Inf), dac)) === interval(bareinterval(0.0,Inf), trv)

end

@testset "minimal_fma_test" begin

    @test fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,7.0)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,11.0)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,-1.0)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,-1.0)

    @test fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,17.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,17.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,17.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,7.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,17.0)

    @test fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,52.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,52.0)

    @test fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,12.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,17.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,2.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,52.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,52.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), bareinterval(-Inf,2.0)) === bareinterval(-Inf,-3.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,52.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), bareinterval(-Inf,2.0)) === bareinterval(-Inf,-3.0)

    @test fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,7.0)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-5.0,Inf)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-17.0,Inf)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,11.0)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(1.0,Inf)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,-1.0)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === bareinterval(1.0,Inf)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-Inf,-1.0)

    @test fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-27.0,1.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-27.0,17.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-1.0,17.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,1.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-Inf,17.0)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-27.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(-27.0,7.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-27.0,17.0)

    @test fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-32.0,52.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), bareinterval(-2.0,2.0)) === bareinterval(-12.0,52.0)

    @test fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-12.0,12.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-5.0,17.0)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,2.0)) === bareinterval(-2.0,2.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,2.0)) === bareinterval(3.0,52.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-32.0,52.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-32.0,-3.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,2.0)) === bareinterval(3.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,2.0)) === bareinterval(-32.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-Inf,52.0)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), bareinterval(-2.0,2.0)) === bareinterval(-Inf,-3.0)

    @test fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,2.0)) === entireinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-5.0,Inf)

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-17.0,Inf)

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(1.0,Inf)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === bareinterval(1.0,Inf)

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-27.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-27.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-27.0,Inf)

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === bareinterval(-1.0,Inf)

    @test fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(-27.0,Inf)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-27.0,Inf)

    @test fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-32.0,Inf)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), bareinterval(-2.0,Inf)) === bareinterval(-12.0,Inf)

    @test fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-12.0,Inf)

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-5.0,Inf)

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), bareinterval(-2.0,Inf)) === bareinterval(-2.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), bareinterval(-2.0,Inf)) === bareinterval(3.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-32.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-32.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), bareinterval(-2.0,Inf)) === bareinterval(3.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), bareinterval(-2.0,Inf)) === bareinterval(-32.0,Inf)

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), bareinterval(-2.0,Inf)) === entireinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,1.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-1.0,1.0), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,Inf), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,3.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-Inf,-3.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,2.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-1.0, 10.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-2.0,2.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-Inf, 3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(-5.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(-10.0,-5.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test fma(bareinterval(0.1,0.5), bareinterval(-5.0, 3.0), bareinterval(-0.1,0.1)) === bareinterval(-0x1.4CCCCCCCCCCCDP+1,0x1.999999999999AP+0)

    @test fma(bareinterval(-0.5,0.2), bareinterval(-5.0, 3.0), bareinterval(-0.1,0.1)) === bareinterval(-0x1.999999999999AP+0,0x1.4CCCCCCCCCCCDP+1)

    @test fma(bareinterval(-0.5,-0.1), bareinterval(2.0, 3.0), bareinterval(-0.1,0.1)) === bareinterval(-0x1.999999999999AP+0,-0x1.999999999999AP-4)

    @test fma(bareinterval(-0.5,-0.1), bareinterval(-Inf, 3.0), bareinterval(-0.1,0.1)) === bareinterval(-0x1.999999999999AP+0,Inf)

end

@testset "minimal_fma_dec_test" begin

    @test fma(interval(bareinterval(-0.5,-0.1), com), interval(bareinterval(-Inf, 3.0), dac), interval(bareinterval(-0.1,0.1), com)) === interval(bareinterval(-0x1.999999999999AP+0,Inf), dac)

    @test fma(interval(bareinterval(1.0,2.0), com), interval(bareinterval(1.0, 0x1.FFFFFFFFFFFFFp1023), com), interval(bareinterval(0.0,1.0), com)) === interval(bareinterval(1.0,Inf), dac)

    @test fma(interval(bareinterval(1.0,2.0), com), interval(bareinterval(1.0, 2.0), com), interval(bareinterval(2.0,5.0), com)) === interval(bareinterval(3.0,9.0), com)

end

@testset "minimal_pown_test" begin

    @test pown(emptyinterval(BareInterval{Float64}), 0) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(0.0,0.0), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-0.0,-0.0), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(13.1,13.1), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-7451.145,-7451.145), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(0.0,Inf), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-0.0,Inf), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-Inf,0.0), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-Inf,-0.0), 0) === bareinterval(1.0,1.0)

    @test pown(bareinterval(-324.3,2.5), 0) === bareinterval(1.0,1.0)

    @test pown(emptyinterval(BareInterval{Float64}), 2) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(0.0,0.0), 2) === bareinterval(0.0,0.0)

    @test pown(bareinterval(-0.0,-0.0), 2) === bareinterval(0.0,0.0)

    @test pown(bareinterval(13.1,13.1), 2) === bareinterval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7)

    @test pown(bareinterval(-7451.145,-7451.145), 2) === bareinterval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 2) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test pown(bareinterval(0.0,Inf), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,-0.0), 2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-324.3,2.5), 2) === bareinterval(0.0,0x1.9AD27D70A3D72P+16)

    @test pown(bareinterval(0.01,2.33), 2) === bareinterval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2)

    @test pown(bareinterval(-1.9,-0.33), 2) === bareinterval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1)

    @test pown(emptyinterval(BareInterval{Float64}), 8) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(0.0,0.0), 8) === bareinterval(0.0,0.0)

    @test pown(bareinterval(-0.0,-0.0), 8) === bareinterval(0.0,0.0)

    @test pown(bareinterval(13.1,13.1), 8) === bareinterval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29)

    @test pown(bareinterval(-7451.145,-7451.145), 8) === bareinterval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 8) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test pown(bareinterval(0.0,Inf), 8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), 8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), 8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,-0.0), 8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-324.3,2.5), 8) === bareinterval(0.0,0x1.A87587109655P+66)

    @test pown(bareinterval(0.01,2.33), 8) === bareinterval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9)

    @test pown(bareinterval(-1.9,-0.33), 8) === bareinterval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7)

    @test pown(emptyinterval(BareInterval{Float64}), 1) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 1) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.0,0.0), 1) === bareinterval(0.0,0.0)

    @test pown(bareinterval(-0.0,-0.0), 1) === bareinterval(0.0,0.0)

    @test pown(bareinterval(13.1,13.1), 1) === bareinterval(13.1,13.1)

    @test pown(bareinterval(-7451.145,-7451.145), 1) === bareinterval(-7451.145,-7451.145)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1) === bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1) === bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)

    @test pown(bareinterval(0.0,Inf), 1) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), 1) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), 1) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-Inf,-0.0), 1) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-324.3,2.5), 1) === bareinterval(-324.3,2.5)

    @test pown(bareinterval(0.01,2.33), 1) === bareinterval(0.01,2.33)

    @test pown(bareinterval(-1.9,-0.33), 1) === bareinterval(-1.9,-0.33)

    @test pown(emptyinterval(BareInterval{Float64}), 3) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 3) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.0,0.0), 3) === bareinterval(0.0,0.0)

    @test pown(bareinterval(-0.0,-0.0), 3) === bareinterval(0.0,0.0)

    @test pown(bareinterval(13.1,13.1), 3) === bareinterval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11)

    @test pown(bareinterval(-7451.145,-7451.145), 3) === bareinterval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3) === bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023)

    @test pown(bareinterval(0.0,Inf), 3) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), 3) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), 3) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-Inf,-0.0), 3) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-324.3,2.5), 3) === bareinterval(-0x1.0436D2F418938P+25,0x1.F4P+3)

    @test pown(bareinterval(0.01,2.33), 3) === bareinterval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3)

    @test pown(bareinterval(-1.9,-0.33), 3) === bareinterval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5)

    @test pown(emptyinterval(BareInterval{Float64}), 7) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), 7) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.0,0.0), 7) === bareinterval(0.0,0.0)

    @test pown(bareinterval(-0.0,-0.0), 7) === bareinterval(0.0,0.0)

    @test pown(bareinterval(13.1,13.1), 7) === bareinterval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25)

    @test pown(bareinterval(-7451.145,-7451.145), 7) === bareinterval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7) === bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023)

    @test pown(bareinterval(0.0,Inf), 7) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), 7) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), 7) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-Inf,-0.0), 7) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-324.3,2.5), 7) === bareinterval(-0x1.4F109959E6D7FP+58,0x1.312DP+9)

    @test pown(bareinterval(0.01,2.33), 7) === bareinterval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8)

    @test pown(bareinterval(-1.9,-0.33), 7) === bareinterval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12)

    @test pown(emptyinterval(BareInterval{Float64}), -2) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), -2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(0.0,0.0), -2) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(-0.0,-0.0), -2) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(13.1,13.1), -2) === bareinterval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8)

    @test pown(bareinterval(-7451.145,-7451.145), -2) === bareinterval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -2) === bareinterval(0x0P+0,0x0.0000000000001P-1022)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -2) === bareinterval(0x0P+0,0x0.0000000000001P-1022)

    @test pown(bareinterval(0.0,Inf), -2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), -2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), -2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,-0.0), -2) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-324.3,2.5), -2) === bareinterval(0x1.3F0C482C977C9P-17,Inf)

    @test pown(bareinterval(0.01,2.33), -2) === bareinterval(0x1.793D85EF38E47P-3,0x1.388P+13)

    @test pown(bareinterval(-1.9,-0.33), -2) === bareinterval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3)

    @test pown(emptyinterval(BareInterval{Float64}), -8) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), -8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(0.0,0.0), -8) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(-0.0,-0.0), -8) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(13.1,13.1), -8) === bareinterval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30)

    @test pown(bareinterval(-7451.145,-7451.145), -8) === bareinterval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -8) === bareinterval(0x0P+0,0x0.0000000000001P-1022)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -8) === bareinterval(0x0P+0,0x0.0000000000001P-1022)

    @test pown(bareinterval(0.0,Inf), -8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), -8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), -8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,-0.0), -8) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-324.3,2.5), -8) === bareinterval(0x1.34CC3764D1E0CP-67,Inf)

    @test pown(bareinterval(0.01,2.33), -8) === bareinterval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53)

    @test pown(bareinterval(-1.9,-0.33), -8) === bareinterval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12)

    @test pown(emptyinterval(BareInterval{Float64}), -1) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), -1) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.0,0.0), -1) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(-0.0,-0.0), -1) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(13.1,13.1), -1) === bareinterval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4)

    @test pown(bareinterval(-7451.145,-7451.145), -1) === bareinterval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -1) === bareinterval(0x0.4P-1022,0x0.4000000000001P-1022)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -1) === bareinterval(-0x0.4000000000001P-1022,-0x0.4P-1022)

    @test pown(bareinterval(0.0,Inf), -1) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), -1) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), -1) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-Inf,-0.0), -1) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-324.3,2.5), -1) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.01,2.33), -1) === bareinterval(0x1.B77C278DBBE13P-2,0x1.9P+6)

    @test pown(bareinterval(-1.9,-0.33), -1) === bareinterval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1)

    @test pown(emptyinterval(BareInterval{Float64}), -3) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), -3) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.0,0.0), -3) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(-0.0,-0.0), -3) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(13.1,13.1), -3) === bareinterval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12)

    @test pown(bareinterval(-7451.145,-7451.145), -3) === bareinterval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -3) === bareinterval(0x0P+0,0x0.0000000000001P-1022)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -3) === bareinterval(-0x0.0000000000001P-1022,-0x0P+0)

    @test pown(bareinterval(0.0,Inf), -3) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), -3) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), -3) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-Inf,-0.0), -3) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-324.3,2.5), -3) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.01,2.33), -3) === bareinterval(0x1.43CFBA61AACABP-4,0x1.E848P+19)

    @test pown(bareinterval(-1.9,-0.33), -3) === bareinterval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3)

    @test pown(emptyinterval(BareInterval{Float64}), -7) === emptyinterval(BareInterval{Float64})

    @test pown(entireinterval(BareInterval{Float64}), -7) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.0,0.0), -7) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(-0.0,-0.0), -7) === emptyinterval(BareInterval{Float64})

    @test pown(bareinterval(13.1,13.1), -7) === bareinterval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26)

    @test pown(bareinterval(-7451.145,-7451.145), -7) === bareinterval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91)

    @test pown(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -7) === bareinterval(0x0P+0,0x0.0000000000001P-1022)

    @test pown(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -7) === bareinterval(-0x0.0000000000001P-1022,-0x0P+0)

    @test pown(bareinterval(0.0,Inf), -7) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-0.0,Inf), -7) === bareinterval(0.0,Inf)

    @test pown(bareinterval(-Inf,0.0), -7) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-Inf,-0.0), -7) === bareinterval(-Inf,0.0)

    @test pown(bareinterval(-324.3,2.5), -7) === entireinterval(BareInterval{Float64})

    @test pown(bareinterval(0.01,2.33), -7) === bareinterval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46)

    @test pown(bareinterval(-1.9,-0.33), -7) === bareinterval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7)

end

@testset "minimal_pown_dec_test" begin

    @test pown(interval(bareinterval(-5.0,10.0), com), 0) === interval(bareinterval(1.0,1.0), com)

    @test pown(interval(bareinterval(-Inf,15.0), dac), 0) === interval(bareinterval(1.0,1.0), dac)

    @test pown(interval(bareinterval(-3.0,5.0), def), 2) === interval(bareinterval(0.0,25.0), def)

    @test pown(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), 2) === interval(bareinterval(0.0,Inf), dac)

    @test pown(interval(bareinterval(-3.0,5.0), dac), 3) === interval(bareinterval(-27.0,125.0), dac)

    @test pown(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), 3) === interval(bareinterval(-Inf, 8.0), dac)

    @test pown(interval(bareinterval(3.0,5.0), com), -2) === interval(bareinterval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), com)

    @test pown(interval(bareinterval(-5.0,-3.0), def), -2) === interval(bareinterval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), def)

    @test pown(interval(bareinterval(-5.0,3.0), com), -2) === interval(bareinterval(0x1.47AE147AE147AP-5,Inf), trv)

    @test pown(interval(bareinterval(3.0,5.0), dac), -3) === interval(bareinterval(0x1.0624DD2F1A9FBP-7 ,0x1.2F684BDA12F69P-5), dac)

    @test pown(interval(bareinterval(-3.0,5.0), com), -3) === interval(entireinterval(BareInterval{Float64}), trv)

end

@testset "minimal_pow_test" begin

    @test pow(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(0.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-3.0,5.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(-5.0,-5.0)) === emptyinterval(BareInterval{Float64})

    @test pow(emptyinterval(BareInterval{Float64}), bareinterval(5.0,5.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.1,0.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.1,0.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.0,1.0)) === bareinterval(0x1.999999999999AP-4,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.0,1.0)) === bareinterval(0x1.999999999999AP-4,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.1,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.1,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.1,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(0.1,Inf)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(1.0,1.0)) === bareinterval(0x1.999999999999AP-4,0x1P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(1.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(1.0,Inf)) === bareinterval(0.0,0x1P-1)

    @test pow(bareinterval(0.1,0.5), bareinterval(2.5,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(0.1,0.5), bareinterval(2.5,Inf)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.1,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.1,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.1,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,0.1)) === bareinterval(0x1.96B230BCDC434P-1,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,1.0)) === bareinterval(0x1.999999999999AP-4,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,Inf)

    @test pow(bareinterval(0.1,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,0.0)) === bareinterval(1.0,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,-0.0)) === bareinterval(1.0,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,0.0)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,-0.0)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.125FBEE250664P+0,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.125FBEE250664P+0,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.125FBEE250664P+0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1P+1,0x1.4P+3)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1P+1,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(0.1,0.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,0.5), bareinterval(-Inf,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(0.1,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.1,1.0), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.0,1.0)) === bareinterval(0x1.999999999999AP-4,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.0,1.0)) === bareinterval(0x1.999999999999AP-4,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.1,0.1)) === bareinterval(0x1.96B230BCDC434P-1,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.1,1.0)) === bareinterval(0x1.999999999999AP-4,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.1,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(0.1,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(1.0,1.0)) === bareinterval(0x1.999999999999AP-4,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(1.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(1.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(2.5,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(2.5,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,0.1)) === bareinterval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,1.0)) === bareinterval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,0.1)) === bareinterval(0x1.96B230BCDC434P-1,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,1.0)) === bareinterval(0x1.999999999999AP-4,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,2.5)) === bareinterval(0x1.9E7C6E43390B7P-9,Inf)

    @test pow(bareinterval(0.1,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,0.0)) === bareinterval(1.0,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,-0.0)) === bareinterval(1.0,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,0.0)) === bareinterval(1.0,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,-0.0)) === bareinterval(1.0,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,0.0)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,-0.0)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-0.1,-0.1)) === bareinterval(1.0,0x1.4248EF8FC2604P+0)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,-0.1)) === bareinterval(1.0,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,-0.1)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-1.0,-1.0)) === bareinterval(1.0,0x1.4P+3)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,-1.0)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.1,1.0), bareinterval(-2.5,-2.5)) === bareinterval(1.0,0x1.3C3A4EDFA9758P+8)

    @test pow(bareinterval(0.1,1.0), bareinterval(-Inf,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.5,1.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.5,1.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.0,1.0)) === bareinterval(0.5,1.5)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.0,1.0)) === bareinterval(0.5,1.5)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.1,0.1)) === bareinterval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.1,1.0)) === bareinterval(0.5,1.5)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.1,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(1.0,1.0)) === bareinterval(0.5,1.5)

    @test pow(bareinterval(0.5,1.5), bareinterval(1.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(2.5,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.1,0.1)) === bareinterval(0x1.DDB680117AB12P-1,0x1.125FBEE250665P+0)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.1,1.0)) === bareinterval(0x1P-1,0x1.8P+0)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.1,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.1,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,0.1)) === bareinterval(0x1.5555555555555P-1,0x1P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,1.0)) === bareinterval(0x1P-1,0x1P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), entireinterval(BareInterval{Float64})) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,0.0)) === bareinterval(0x1.5555555555555P-1,0x1P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,-0.0)) === bareinterval(0x1.5555555555555P-1,0x1P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,-0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,0.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,-0.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.125FBEE250665P+0)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.5555555555555P-1,0x1P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,-0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1.5555555555555P-1,0x1P+1)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,-1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,1.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,1.5), bareinterval(-Inf,-2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(0.5,Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.5,Inf), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.5,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.0,1.0)) === bareinterval(0.5,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.1,0.1)) === bareinterval(0x1.DDB680117AB12P-1,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.1,1.0)) === bareinterval(0.5,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.1,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(1.0,1.0)) === bareinterval(0.5,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(1.0,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(2.5,2.5)) === bareinterval(0x1.6A09E667F3BCCP-3,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,0.0)) === bareinterval(0.0,0x1P+1)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,-0.0)) === bareinterval(0.0,0x1P+1)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,0.0)) === bareinterval(0.0,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,-0.0)) === bareinterval(0.0,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-0.1,-0.1)) === bareinterval(0.0,0x1.125FBEE250665P+0)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,-0.1)) === bareinterval(0.0,0x1P+1)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,-0.1)) === bareinterval(0.0,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-1.0,-1.0)) === bareinterval(0.0,0x1P+1)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,-1.0)) === bareinterval(0.0,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.5,Inf), bareinterval(-2.5,-2.5)) === bareinterval(0.0,0x1.6A09E667F3BCDP+2)

    @test pow(bareinterval(1.0,1.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(1.0,1.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.0,1.0)) === bareinterval(1.0,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.0,1.0)) === bareinterval(1.0,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.0,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.0,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.1,0.1)) === bareinterval(1.0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.1,1.0)) === bareinterval(1.0,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.1,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(0.1,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(1.0,1.0)) === bareinterval(1.0,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(1.0,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(1.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(2.5,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(2.5,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.1,0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.1,1.0)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.1,2.5)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.1,Inf)) === bareinterval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,0.1)) === bareinterval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,1.0)) === bareinterval(0x1.5555555555555P-1,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,2.5)) === bareinterval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,Inf)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,Inf)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,0.1)) === bareinterval(0x0P+0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,1.0)) === bareinterval(0x0P+0,0x1.8P+0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,2.5)) === bareinterval(0x0P+0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.0,1.5), entireinterval(BareInterval{Float64})) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,0.0)) === bareinterval(0x1.5555555555555P-1,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,-0.0)) === bareinterval(0x1.5555555555555P-1,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,-0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.5555555555555P-1,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,-0.1)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1.5555555555555P-1,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,-1.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.0,1.5), bareinterval(-Inf,-2.5)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(1.0,Inf), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.0,1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.0,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.0,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.1,0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.1,1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.1,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(0.1,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(1.0,1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(1.0,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(2.5,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(2.5,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.1,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.1,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.1,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.1,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-0.1,-0.1)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,-0.1)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,-0.1)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,-0.1)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-1.0,-1.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,-1.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,-1.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-2.5,-2.5)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.0,Inf), bareinterval(-Inf,-2.5)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,1.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(1.1,1.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.0,1.0)) === bareinterval(1.0,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.0,1.0)) === bareinterval(1.0,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.0,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.0,2.5)) === bareinterval(1.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.1,0.1)) === bareinterval(0x1.02739C65D58BFP+0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.1,1.0)) === bareinterval(0x1.02739C65D58BFP+0,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.1,2.5)) === bareinterval(0x1.02739C65D58BFP+0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(0.1,Inf)) === bareinterval(0x1.02739C65D58BFP+0,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(1.0,1.0)) === bareinterval(0x1.199999999999AP+0,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(1.0,2.5)) === bareinterval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(1.0,Inf)) === bareinterval(0x1.199999999999AP+0,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(2.5,2.5)) === bareinterval(0x1.44E1080833B25P+0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(2.5,Inf)) === bareinterval(0x1.44E1080833B25P+0,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.1,0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.1,1.0)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.1,2.5)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.1,Inf)) === bareinterval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,0.1)) === bareinterval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,1.0)) === bareinterval(0x1.5555555555555P-1,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,2.5)) === bareinterval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,Inf)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,Inf)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,0.1)) === bareinterval(0x0P+0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,1.0)) === bareinterval(0x0P+0,0x1.8P+0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,2.5)) === bareinterval(0x0P+0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(1.1,1.5), entireinterval(BareInterval{Float64})) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,0.0)) === bareinterval(0x1.5555555555555P-1,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,-0.0)) === bareinterval(0x1.5555555555555P-1,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,-0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,1.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.5555555555555P-1,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,-0.1)) === bareinterval(0x0P+0,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1.5555555555555P-1,0x1.D1745D1745D17P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.D1745D1745D17P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,-1.0)) === bareinterval(0x0P+0,0x1.D1745D1745D17P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,0x1.9372D999784C8P-1)

    @test pow(bareinterval(1.1,1.5), bareinterval(-Inf,-2.5)) === bareinterval(0x0P+0,0x1.9372D999784C8P-1)

    @test pow(bareinterval(1.1,Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(1.1,Inf), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.0,1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.0,1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.0,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.0,2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.1,0.1)) === bareinterval(0x1.02739C65D58BFP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.1,1.0)) === bareinterval(0x1.02739C65D58BFP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.1,2.5)) === bareinterval(0x1.02739C65D58BFP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(0.1,Inf)) === bareinterval(0x1.02739C65D58BFP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(1.0,1.0)) === bareinterval(0x1.199999999999AP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(1.0,2.5)) === bareinterval(0x1.199999999999AP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(1.0,Inf)) === bareinterval(0x1.199999999999AP+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(2.5,2.5)) === bareinterval(0x1.44E1080833B25P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(2.5,Inf)) === bareinterval(0x1.44E1080833B25P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.1,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.1,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.1,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.1,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,Inf)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,0.1)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,1.0)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,2.5)) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0x0P+0,Inf)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,-0.0)) === bareinterval(0x0P+0,1.0)

    @test pow(bareinterval(1.1,Inf), bareinterval(-0.1,-0.1)) === bareinterval(0x0P+0,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,-0.1)) === bareinterval(0x0P+0,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,-0.1)) === bareinterval(0x0P+0,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,-0.1)) === bareinterval(0x0P+0,0x1.FB24AF5281928P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-1.0,-1.0)) === bareinterval(0x0P+0,0x1.D1745D1745D17P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,-1.0)) === bareinterval(0x0P+0,0x1.D1745D1745D17P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,-1.0)) === bareinterval(0x0P+0,0x1.D1745D1745D17P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-2.5,-2.5)) === bareinterval(0x0P+0,0x1.9372D999784C8P-1)

    @test pow(bareinterval(1.1,Inf), bareinterval(-Inf,-2.5)) === bareinterval(0x0P+0,0x1.9372D999784C8P-1)

    @test pow(bareinterval(0.0,0.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.1,0.1)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.1,1.0)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.1,2.5)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.0,0.5), bareinterval(0.1,Inf)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(0.0,0.5), bareinterval(1.0,1.0)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(0.0,0.5), bareinterval(1.0,2.5)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(0.0,0.5), bareinterval(1.0,Inf)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(0.0,0.5), bareinterval(2.5,2.5)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(0.0,0.5), bareinterval(2.5,Inf)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(0.0,0.5), bareinterval(-Inf,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(0.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,1.0), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.1,0.1)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.1,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.1,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(0.1,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(1.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(1.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(1.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(2.5,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(2.5,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-0.1,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-1.0,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-2.5,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.0), bareinterval(-Inf,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(0.0,1.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,1.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.1,0.1)) === bareinterval(0.0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.1,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.1,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.0,1.5), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(1.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(0.0,1.5), bareinterval(1.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.0,1.5), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(2.5,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(0.0,1.5), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,0.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,-0.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,-0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(0.0,1.5), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,Inf), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-0.1,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-1.0,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,Inf), bareinterval(-2.5,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.1,0.1)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.1,1.0)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.1,2.5)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.0,0.5), bareinterval(0.1,Inf)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.0,0.5), bareinterval(1.0,1.0)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(-0.0,0.5), bareinterval(1.0,2.5)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(-0.0,0.5), bareinterval(1.0,Inf)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(-0.0,0.5), bareinterval(2.5,2.5)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(-0.0,0.5), bareinterval(2.5,Inf)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(-0.0,0.5), bareinterval(-Inf,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(-0.0,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.1,0.1)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.1,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.1,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(0.1,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(1.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(1.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(1.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(2.5,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(2.5,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-0.1,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-1.0,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-2.5,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.0), bareinterval(-Inf,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.0,1.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.1,0.1)) === bareinterval(0.0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.1,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.1,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.0,1.5), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(1.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.0,1.5), bareinterval(1.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.0,1.5), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(2.5,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.0,1.5), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,0.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,-0.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,-0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.0,1.5), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-0.1,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-1.0,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.0,Inf), bareinterval(-2.5,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.1,0.1)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.1,1.0)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.1,2.5)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.1,0.5), bareinterval(0.1,Inf)) === bareinterval(0.0,0x1.DDB680117AB13P-1)

    @test pow(bareinterval(-0.1,0.5), bareinterval(1.0,1.0)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(-0.1,0.5), bareinterval(1.0,2.5)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(-0.1,0.5), bareinterval(1.0,Inf)) === bareinterval(0.0,0.5)

    @test pow(bareinterval(-0.1,0.5), bareinterval(2.5,2.5)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(-0.1,0.5), bareinterval(2.5,Inf)) === bareinterval(0.0,0x1.6A09E667F3BCDP-3)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,-0.1)) === bareinterval(0x1.125FBEE250664P+0,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,-1.0)) === bareinterval(0x1P+1,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(-0.1,0.5), bareinterval(-Inf,-2.5)) === bareinterval(0x1.6A09E667F3BCCP+2,Inf)

    @test pow(bareinterval(-0.1,1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.1,0.1)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.1,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.1,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(0.1,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(1.0,1.0)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(1.0,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(1.0,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(2.5,2.5)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(2.5,Inf)) === bareinterval(0.0,1.0)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-0.1,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,-0.1)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-1.0,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,-1.0)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-2.5,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.0), bareinterval(-Inf,-2.5)) === bareinterval(1.0,Inf)

    @test pow(bareinterval(-0.1,1.5), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.1,0.1)) === bareinterval(0.0,0x1.0A97DCE72A0CBP+0)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.1,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.1,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.1,1.5), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(1.0,1.0)) === bareinterval(0.0,1.5)

    @test pow(bareinterval(-0.1,1.5), bareinterval(1.0,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.1,1.5), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(2.5,2.5)) === bareinterval(0.0,0x1.60B9FD68A4555P+1)

    @test pow(bareinterval(-0.1,1.5), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,0.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,-0.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,-0.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-0.1,-0.1)) === bareinterval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,-0.1)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,-0.1)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-1.0,-1.0)) === bareinterval(0x1.5555555555555P-1,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,-1.0)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-2.5,-2.5)) === bareinterval(0x1.7398BF1D1EE6FP-2,Inf)

    @test pow(bareinterval(-0.1,1.5), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.1,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.1,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.1,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.1,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,Inf)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,-0.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-0.1,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,-0.1)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-1.0,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,-1.0)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-Inf,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(-0.1,Inf), bareinterval(-2.5,-2.5)) === bareinterval(0.0,Inf)

    @test pow(bareinterval(0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,0.0), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,-0.0), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-0.0,0.0), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(0.0,-0.0), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,0.0), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.1,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.1,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.1,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.1,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,Inf)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,0.1)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,2.5)) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.0), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.0,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.0,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.1,0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.1,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.1,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(0.1,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(1.0,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(2.5,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(2.5,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.1,0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.1,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.1,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.1,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-0.1,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,-0.1)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-Inf,-2.5)) === emptyinterval(BareInterval{Float64})

    @test pow(bareinterval(-1.0,-0.1), bareinterval(-2.5,-2.5)) === emptyinterval(BareInterval{Float64})

end

@testset "minimal_pow_dec_test" begin

    @test pow(interval(bareinterval(0.1,0.5), com), interval(bareinterval(0.0,1.0), com)) === interval(bareinterval(0x1.999999999999AP-4,1.0), com)

    @test pow(interval(bareinterval(0.1,0.5), com), interval(bareinterval(0.1,0.1), def)) === interval(bareinterval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1), def)

    @test pow(interval(bareinterval(0.1,0.5), trv), interval(bareinterval(-2.5,2.5), dac)) === interval(bareinterval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8), trv)

    @test pow(interval(bareinterval(0.1,0.5), com), interval(bareinterval(-2.5,Inf), dac)) === interval(bareinterval(0.0,0x1.3C3A4EDFA9758P+8), dac)

    @test pow(interval(bareinterval(0.1,0.5), trv), interval(bareinterval(-Inf,0.1), dac)) === interval(bareinterval(0x1.96B230BCDC434P-1,Inf), trv)

    @test pow(interval(bareinterval(0.1,1.0), com), interval(bareinterval(0.0,2.5), com)) === interval(bareinterval(0x1.9E7C6E43390B7P-9,1.0), com)

    @test pow(interval(bareinterval(0.1,1.0), def), interval(bareinterval(1.0,1.0), dac)) === interval(bareinterval(0x1.999999999999AP-4,1.0), def)

    @test pow(interval(bareinterval(0.1,1.0), trv), interval(bareinterval(-2.5,1.0), def)) === interval(bareinterval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8), trv)

    @test pow(interval(bareinterval(0.5,1.5), dac), interval(bareinterval(0.1,0.1), com)) === interval(bareinterval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0), dac)

    @test pow(interval(bareinterval(0.5,1.5), def), interval(bareinterval(-2.5,0.1), trv)) === interval(bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), trv)

    @test pow(interval(bareinterval(0.5,1.5), com), interval(bareinterval(-2.5,-2.5), com)) === interval(bareinterval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), com)

    @test pow(interval(bareinterval(0.5,Inf), dac), interval(bareinterval(0.1,0.1), com)) === interval(bareinterval(0x1.DDB680117AB12P-1,Inf), dac)

    @test pow(interval(bareinterval(0.5,Inf), def), interval(bareinterval(-2.5,-0.0), com)) === interval(bareinterval(0.0,0x1.6A09E667F3BCDP+2), def)

    @test pow(interval(bareinterval(1.0,1.5), com), interval(bareinterval(-0.1,0.1), def)) === interval(bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0), def)

    @test pow(interval(bareinterval(1.0,1.5), trv), interval(bareinterval(-0.1,-0.1), com)) === interval(bareinterval(0x1.EBA7C9E4D31E9P-1,1.0), trv)

    @test pow(interval(bareinterval(1.0,Inf), dac), interval(bareinterval(1.0,1.0), dac)) === interval(bareinterval(1.0,Inf), dac)

    @test pow(interval(bareinterval(1.0,Inf), def), interval(bareinterval(-1.0,-0.0), dac)) === interval(bareinterval(0x0P+0,1.0), def)

    @test pow(interval(bareinterval(1.1,1.5), def), interval(bareinterval(1.0,2.5), com)) === interval(bareinterval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1), def)

    @test pow(interval(bareinterval(1.1,1.5), com), interval(bareinterval(-0.1,-0.1), com)) === interval(bareinterval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1), com)

    @test pow(interval(bareinterval(1.1,Inf), dac), interval(bareinterval(0.1,Inf), dac)) === interval(bareinterval(0x1.02739C65D58BFP+0,Inf), dac)

    @test pow(interval(bareinterval(1.1,Inf), def), interval(bareinterval(-2.5,Inf), dac)) === interval(bareinterval(0x0P+0,Inf), def)

    @test pow(interval(bareinterval(1.1,Inf), trv), interval(bareinterval(-Inf,-1.0), def)) === interval(bareinterval(0x0P+0,0x1.D1745D1745D17P-1), trv)

    @test pow(interval(bareinterval(0.0,0.5), com), interval(bareinterval(0.1,0.1), com)) === interval(bareinterval(0.0,0x1.DDB680117AB13P-1), com)

    @test pow(interval(bareinterval(0.0,0.5), com), interval(bareinterval(2.5,Inf), dac)) === interval(bareinterval(0.0,0x1.6A09E667F3BCDP-3), dac)

    @test pow(interval(bareinterval(0.0,0.5), com), interval(bareinterval(-Inf,-2.5), dac)) === interval(bareinterval(0x1.6A09E667F3BCCP+2,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.0), com), interval(bareinterval(0.0,0.0), com)) === interval(bareinterval(1.0,1.0), trv)

    @test pow(interval(bareinterval(0.0,1.0), def), interval(bareinterval(0.0,2.5), dac)) === interval(bareinterval(0.0,1.0), trv)

    @test pow(interval(bareinterval(0.0,1.0), dac), interval(bareinterval(1.0,2.5), com)) === interval(bareinterval(0.0,1.0), dac)

    @test pow(interval(bareinterval(0.0,1.0), com), interval(bareinterval(-2.5,0.1), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.0), def), interval(entireinterval(BareInterval{Float64}), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.0), dac), interval(bareinterval(-0.1,0.0), com)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.0), com), interval(bareinterval(-Inf,0.0), dac)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.0), def), interval(bareinterval(-Inf,-2.5), dac)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.5), com), interval(bareinterval(0.0,2.5), com)) === interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), trv)

    @test pow(interval(bareinterval(0.0,1.5), def), interval(bareinterval(2.5,2.5), dac)) === interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), def)

    @test pow(interval(bareinterval(0.0,1.5), dac), interval(bareinterval(-1.0,0.0), com)) === interval(bareinterval(0x1.5555555555555P-1,Inf), trv)

    @test pow(interval(bareinterval(0.0,1.5), com), interval(bareinterval(-2.5,-2.5), def)) === interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test pow(interval(bareinterval(0.0,Inf), dac), interval(bareinterval(0.1,0.1), com)) === interval(bareinterval(0.0,Inf), dac)

    @test pow(interval(bareinterval(0.0,Inf), def), interval(bareinterval(-1.0,1.0), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,Inf), trv), interval(bareinterval(-Inf,-1.0), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,Inf), dac), interval(bareinterval(-2.5,-2.5), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,0.5), com), interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,1.0), trv)

    @test pow(interval(bareinterval(-0.0,0.5), def), interval(bareinterval(0.1,Inf), def)) === interval(bareinterval(0.0,0x1.DDB680117AB13P-1), def)

    @test pow(interval(bareinterval(-0.0,0.5), dac), interval(bareinterval(2.5,2.5), com)) === interval(bareinterval(0.0,0x1.6A09E667F3BCDP-3), dac)

    @test pow(interval(bareinterval(-0.0,0.5), trv), interval(bareinterval(-2.5,-0.0), dac)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,0.5), com), interval(bareinterval(-Inf,-0.1), def)) === interval(bareinterval(0x1.125FBEE250664P+0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,0.5), def), interval(bareinterval(-Inf,-2.5), dac)) === interval(bareinterval(0x1.6A09E667F3BCCP+2,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.0), com), interval(bareinterval(2.5,2.5), dac)) === interval(bareinterval(0.0,1.0), dac)

    @test pow(interval(bareinterval(-0.0,1.0), dac), interval(bareinterval(-1.0,Inf), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.0), com), interval(entireinterval(BareInterval{Float64}), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.0), def), interval(bareinterval(-2.5,-2.5), com)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.0), dac), interval(bareinterval(-Inf,-2.5), def)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.5), com), interval(bareinterval(0.1,2.5), dac)) === interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), dac)

    @test pow(interval(bareinterval(-0.0,1.5), def), interval(bareinterval(-1.0,0.0), trv)) === interval(bareinterval(0x1.5555555555555P-1,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.5), dac), interval(bareinterval(-2.5,-0.1), def)) === interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.5), com), interval(bareinterval(-2.5,-2.5), com)) === interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test pow(interval(bareinterval(-0.0,1.5), def), interval(bareinterval(-Inf,-2.5), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,Inf), dac), interval(bareinterval(-0.1,Inf), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,Inf), def), interval(bareinterval(-2.5,-0.0), com)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,Inf), trv), interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,Inf), dac), interval(bareinterval(-Inf,-0.0), trv)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.0,Inf), def), interval(bareinterval(-Inf,-1.0), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,0.5), def), interval(bareinterval(0.1,Inf), dac)) === interval(bareinterval(0.0,0x1.DDB680117AB13P-1), trv)

    @test pow(interval(bareinterval(-0.1,0.5), com), interval(bareinterval(-0.1,-0.1), com)) === interval(bareinterval(0x1.125FBEE250664P+0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,0.5), dac), interval(bareinterval(-Inf,-2.5), def)) === interval(bareinterval(0x1.6A09E667F3BCCP+2,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.0), com), interval(bareinterval(0.0,0.0), com)) === interval(bareinterval(1.0,1.0), trv)

    @test pow(interval(bareinterval(-0.1,1.0), dac), interval(bareinterval(-Inf,2.5), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.0), def), interval(bareinterval(-Inf,-1.0), def)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.0), com), interval(bareinterval(-2.5,-2.5), com)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.0), trv), interval(bareinterval(-Inf,-2.5), trv)) === interval(bareinterval(1.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.5), trv), interval(bareinterval(0.0,2.5), com)) === interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), trv)

    @test pow(interval(bareinterval(-0.1,1.5), com), interval(bareinterval(2.5,2.5), dac)) === interval(bareinterval(0.0,0x1.60B9FD68A4555P+1), trv)

    @test pow(interval(bareinterval(-0.1,1.5), dac), interval(bareinterval(-1.0,0.0), trv)) === interval(bareinterval(0x1.5555555555555P-1,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.5), com), interval(bareinterval(-0.1,-0.1), com)) === interval(bareinterval(0x1.EBA7C9E4D31E9P-1,Inf), trv)

    @test pow(interval(bareinterval(-0.1,1.5), def), interval(bareinterval(-2.5,-2.5), def)) === interval(bareinterval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test pow(interval(bareinterval(-0.1,Inf), dac), interval(bareinterval(-0.1,2.5), com)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,Inf), def), interval(bareinterval(-2.5,0.0), def)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(-0.1,Inf), dac), interval(bareinterval(-2.5,-2.5), trv)) === interval(bareinterval(0.0,Inf), trv)

    @test pow(interval(bareinterval(0.0,0.0), com), interval(bareinterval(1.0,Inf), dac)) === interval(bareinterval(0.0,0.0), dac)

    @test pow(interval(bareinterval(0.0,0.0), com), interval(bareinterval(-2.5,0.1), com)) === interval(bareinterval(0.0,0.0), trv)

    @test pow(interval(bareinterval(0.0,0.0), dac), interval(bareinterval(-1.0,0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pow(interval(bareinterval(-1.0,-0.1), com), interval(bareinterval(-0.1,1.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pow(interval(bareinterval(-1.0,-0.1), dac), interval(bareinterval(-0.1,2.5), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test pow(interval(bareinterval(-1.0,-0.1), def), interval(bareinterval(-0.1,Inf), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

end

@testset "minimal_exp_test" begin

    @test exp(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test exp(bareinterval(-Inf,0.0)) === bareinterval(0.0,1.0)

    @test exp(bareinterval(-Inf,-0.0)) === bareinterval(0.0,1.0)

    @test exp(bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test exp(bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test exp(entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test exp(bareinterval(-Inf,0x1.62E42FEFA39FP+9)) === bareinterval(0.0,Inf)

    @test exp(bareinterval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9)) === bareinterval( 0x1.FFFFFFFFFFFFFP+1023,Inf)

    @test exp(bareinterval(0.0,0x1.62E42FEFA39EP+9)) === bareinterval(1.0,0x1.FFFFFFFFFC32BP+1023)

    @test exp(bareinterval(-0.0,0x1.62E42FEFA39EP+9)) === bareinterval(1.0,0x1.FFFFFFFFFC32BP+1023)

    @test exp(bareinterval(-0x1.6232BDD7ABCD3P+9,0x1.62E42FEFA39EP+9)) === bareinterval(0x0.FFFFFFFFFFE7BP-1022,0x1.FFFFFFFFFC32BP+1023)

    @test exp(bareinterval(-0x1.6232BDD7ABCD3P+8,0x1.62E42FEFA39EP+9)) === bareinterval(0x1.FFFFFFFFFFE7BP-512,0x1.FFFFFFFFFC32BP+1023)

    @test exp(bareinterval(-0x1.6232BDD7ABCD3P+8,0.0)) === bareinterval(0x1.FFFFFFFFFFE7BP-512,1.0)

    @test exp(bareinterval(-0x1.6232BDD7ABCD3P+8,-0.0)) === bareinterval(0x1.FFFFFFFFFFE7BP-512,1.0)

    @test exp(bareinterval(-0x1.6232BDD7ABCD3P+8,1.0)) === bareinterval(0x1.FFFFFFFFFFE7BP-512,0x1.5BF0A8B14576AP+1)

    @test exp(bareinterval(1.0,5.0)) === bareinterval(0x1.5BF0A8B145769P+1,0x1.28D389970339P+7)

    @test exp(bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)) === bareinterval(0x1.2797F0A337A5FP-5,0x1.86091CC9095C5P+2)

    @test exp(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)) === bareinterval(0x1.1337E9E45812AP+1, 0x1.805A5C88021B6P+142)

    @test exp(bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)) === bareinterval(0x1.EF461A783114CP+16,0x1.691D36C6B008CP+37)

end

@testset "minimal_exp_dec_test" begin

    @test exp(interval(bareinterval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9), com)) === interval(bareinterval( 0x1.FFFFFFFFFFFFFP+1023,Inf), dac)

    @test exp(interval(bareinterval(0.0,0x1.62E42FEFA39EP+9), def)) === interval(bareinterval(1.0,0x1.FFFFFFFFFC32BP+1023), def)

end

@testset "minimal_exp2_test" begin

    @test exp2(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test exp2(bareinterval(-Inf,0.0)) === bareinterval(0.0,1.0)

    @test exp2(bareinterval(-Inf,-0.0)) === bareinterval(0.0,1.0)

    @test exp2(bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test exp2(bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test exp2(entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test exp2(bareinterval(-Inf,1024.0)) === bareinterval(0.0,Inf)

    @test exp2(bareinterval(1024.0,1024.0)) === bareinterval(0x1.FFFFFFFFFFFFFP+1023,Inf)

    @test exp2(bareinterval(0.0,1023.0)) === bareinterval(1.0,0x1P+1023)

    @test exp2(bareinterval(-0.0,1023.0)) === bareinterval(1.0,0x1P+1023)

    @test exp2(bareinterval(-1022.0,1023.0)) === bareinterval(0x1P-1022,0x1P+1023)

    @test exp2(bareinterval(-1022.0,0.0)) === bareinterval(0x1P-1022,1.0)

    @test exp2(bareinterval(-1022.0,-0.0)) === bareinterval(0x1P-1022,1.0)

    @test exp2(bareinterval(-1022.0,1.0)) === bareinterval(0x1P-1022,2.0)

    @test exp2(bareinterval(1.0,5.0)) === bareinterval(2.0,32.0)

    @test exp2(bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)) === bareinterval(0x1.9999999999998P-4,0x1.C000000000001P+1)

    @test exp2(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)) === bareinterval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98)

    @test exp2(bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)) === bareinterval(0x1.AEA0000721857P+11,0x1.FCA0555555559P+25)

end

@testset "minimal_exp2_dec_test" begin

    @test exp2(interval(bareinterval(1024.0,1024.0), com)) === interval(bareinterval(0x1.FFFFFFFFFFFFFP+1023,Inf), dac)

    @test exp2(interval(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), def)) === interval(bareinterval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98), def)

end

@testset "minimal_exp10_test" begin

    @test exp10(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test exp10(bareinterval(-Inf,0.0)) === bareinterval(0.0,1.0)

    @test exp10(bareinterval(-Inf,-0.0)) === bareinterval(0.0,1.0)

    @test exp10(bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test exp10(bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test exp10(entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test exp10(bareinterval(-Inf,0x1.34413509F79FFP+8)) === bareinterval(0.0,Inf)

    @test exp10(bareinterval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8)) === bareinterval(0x1.FFFFFFFFFFFFFP+1023,Inf)

    @test exp10(bareinterval(0.0,0x1.34413509F79FEP+8)) === bareinterval(1.0,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(bareinterval(-0.0,0x1.34413509F79FEP+8)) === bareinterval(1.0,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(bareinterval(-0x1.33A7146F72A42P+8,0x1.34413509F79FEP+8)) === bareinterval(0x0.FFFFFFFFFFFE3P-1022,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(bareinterval(-0x1.22P+7,0x1.34413509F79FEP+8)) === bareinterval(0x1.3FAAC3E3FA1F3P-482,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(bareinterval(-0x1.22P+7,0.0)) === bareinterval(0x1.3FAAC3E3FA1F3P-482,1.0)

    @test exp10(bareinterval(-0x1.22P+7,-0.0)) === bareinterval(0x1.3FAAC3E3FA1F3P-482,1.0)

    @test exp10(bareinterval(-0x1.22P+7,1.0)) === bareinterval(0x1.3FAAC3E3FA1F3P-482,10.0)

    @test exp10(bareinterval(1.0,5.0)) === bareinterval(10.0,100000.0)

    @test exp10(bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)) === bareinterval(0x1.F3A8254311F9AP-12,0x1.00B18AD5B7D56P+6)

    @test exp10(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)) === bareinterval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328)

    @test exp10(bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)) === bareinterval(0x1.0608D2279A811P+39,0x1.43AF5D4271CB8P+86)

end

@testset "minimal_exp10_dec_test" begin

    @test exp10(interval(bareinterval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8), com)) === interval(bareinterval( 0x1.FFFFFFFFFFFFFP+1023,Inf), dac)

    @test exp10(interval(bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), def)) === interval(bareinterval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328), def)

end

@testset "minimal_log_test" begin

    @test log(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test log(bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test log(bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test log(bareinterval(0.0,1.0)) === bareinterval(-Inf,0.0)

    @test log(bareinterval(-0.0,1.0)) === bareinterval(-Inf,0.0)

    @test log(bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test log(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test log(bareinterval(-0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test log(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test log(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,0x1.62E42FEFA39FP+9)

    @test log(bareinterval(-0.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,0x1.62E42FEFA39FP+9)

    @test log(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0.0,0x1.62E42FEFA39FP+9)

    @test log(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-0x1.74385446D71C4p9, +0x1.62E42FEFA39Fp9)

    @test log(bareinterval(0x0.0000000000001p-1022,1.0)) === bareinterval(-0x1.74385446D71C4p9,0.0)

    @test log(bareinterval(0x1.5BF0A8B145769P+1,0x1.5BF0A8B145769P+1)) === bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test log(bareinterval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1)) === bareinterval(0x1P+0,0x1.0000000000001P+0)

    @test log(bareinterval(0x0.0000000000001p-1022,0x1.5BF0A8B14576AP+1)) === bareinterval(-0x1.74385446D71C4p9,0x1.0000000000001P+0)

    @test log(bareinterval(0x1.5BF0A8B145769P+1,32.0)) === bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1.BB9D3BEB8C86CP+1)

    @test log(bareinterval(0x1.999999999999AP-4,0x1.CP+1)) === bareinterval(-0x1.26BB1BBB55516P+1,0x1.40B512EB53D6P+0)

    @test log(bareinterval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)) === bareinterval(0x1.0FAE81914A99P-1,0x1.120627F6AE7F1P+6)

    @test log(bareinterval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)) === bareinterval(0x1.04A1363DB1E63P+3,0x1.203E52C0256B5P+4)

end

@testset "minimal_log_dec_test" begin

    @test log(interval(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-0x1.74385446D71C4p9,0x1.62E42FEFA39FP+9), com)

    @test log(interval(bareinterval(0.0,1.0), com)) === interval(bareinterval(-Inf,0.0), trv)

    @test log(interval(bareinterval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1), def)) === interval(bareinterval(0x1P+0,0x1.0000000000001P+0), def)

end

@testset "minimal_log2_test" begin

    @test log2(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test log2(bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test log2(bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test log2(bareinterval(0.0,1.0)) === bareinterval(-Inf,0.0)

    @test log2(bareinterval(-0.0,1.0)) === bareinterval(-Inf,0.0)

    @test log2(bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test log2(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test log2(bareinterval(-0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test log2(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test log2(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,1024.0)

    @test log2(bareinterval(-0.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,1024.0)

    @test log2(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0.0,1024.0)

    @test log2(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-1074.0,1024.0)

    @test log2(bareinterval(0x0.0000000000001p-1022,1.0)) === bareinterval(-1074.0,0.0)

    @test log2(bareinterval(0x0.0000000000001p-1022,2.0)) === bareinterval(-1074.0,1.0)

    @test log2(bareinterval(2.0,32.0)) === bareinterval(1.0,5.0)

    @test log2(bareinterval(0x1.999999999999AP-4,0x1.CP+1)) === bareinterval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)

    @test log2(bareinterval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)) === bareinterval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)

    @test log2(bareinterval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)) === bareinterval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)

end

@testset "minimal_log2_dec_test" begin

    @test log2(interval(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-1074.0,1024.0), com)

    @test log2(interval(bareinterval(0x0.0000000000001p-1022,Inf), dac)) === interval(bareinterval(-1074.0,Inf), dac)

    @test log2(interval(bareinterval(2.0,32.0), def)) === interval(bareinterval(1.0,5.0), def)

    @test log2(interval(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-Inf,1024.0), trv)

end

@testset "minimal_log10_test" begin

    @test log10(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test log10(bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test log10(bareinterval(-Inf,-0.0)) === emptyinterval(BareInterval{Float64})

    @test log10(bareinterval(0.0,1.0)) === bareinterval(-Inf,0.0)

    @test log10(bareinterval(-0.0,1.0)) === bareinterval(-Inf,0.0)

    @test log10(bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test log10(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test log10(bareinterval(-0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test log10(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test log10(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,0x1.34413509F79FFP+8)

    @test log10(bareinterval(-0.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,0x1.34413509F79FFP+8)

    @test log10(bareinterval(1.0,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(0.0,0x1.34413509F79FFP+8)

    @test log10(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-0x1.434E6420F4374p+8, +0x1.34413509F79FFp+8)

    @test log10(bareinterval(0x0.0000000000001p-1022,1.0)) === bareinterval(-0x1.434E6420F4374p+8 ,0.0)

    @test log10(bareinterval(0x0.0000000000001p-1022,10.0)) === bareinterval(-0x1.434E6420F4374p+8 ,1.0)

    @test log10(bareinterval(10.0,100000.0)) === bareinterval(1.0,5.0)

    @test log10(bareinterval(0x1.999999999999AP-4,0x1.CP+1)) === bareinterval(-0x1P+0,0x1.1690163290F4P-1)

    @test log10(bareinterval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test log10(bareinterval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)) === bareinterval(0x1.D7F59AA5BECB9P-3,0x1.DC074D84E5AABP+4)

    @test log10(bareinterval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)) === bareinterval(0x1.C4C29DD829191P+1,0x1.F4BAEBBA4FA4P+2)

end

@testset "minimal_log10_dec_test" begin

    @test log10(interval(bareinterval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-0x1.434E6420F4374p+8,0x1.34413509F79FFP+8), com)

    @test log10(interval(bareinterval(0.0,0x1.FFFFFFFFFFFFFp1023), dac)) === interval(bareinterval(-Inf,0x1.34413509F79FFP+8), trv)

end

@testset "minimal_sin_test" begin

    @test sin(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test sin(bareinterval(0.0,Inf)) === bareinterval(-1.0,1.0)

    @test sin(bareinterval(-0.0,Inf)) === bareinterval(-1.0,1.0)

    @test sin(bareinterval(-Inf,0.0)) === bareinterval(-1.0,1.0)

    @test sin(bareinterval(-Inf,-0.0)) === bareinterval(-1.0,1.0)

    @test sin(entireinterval(BareInterval{Float64})) === bareinterval(-1.0,1.0)

    @test sin(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test sin(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test sin(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === bareinterval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test sin(bareinterval(0.0,0x1.921FB54442D18P+0)) === bareinterval(0.0,0x1P+0)

    @test sin(bareinterval(-0.0,0x1.921FB54442D18P+0)) === bareinterval(0.0,0x1P+0)

    @test sin(bareinterval(0.0,0x1.921FB54442D19P+0)) === bareinterval(0.0,0x1P+0)

    @test sin(bareinterval(-0.0,0x1.921FB54442D19P+0)) === bareinterval(0.0,0x1P+0)

    @test sin(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)) === bareinterval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53)

    @test sin(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)) === bareinterval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52)

    @test sin(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)) === bareinterval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53)

    @test sin(bareinterval(0.0,0x1.921FB54442D18P+1)) === bareinterval(0.0,1.0)

    @test sin(bareinterval(-0.0,0x1.921FB54442D18P+1)) === bareinterval(0.0,1.0)

    @test sin(bareinterval(0.0,0x1.921FB54442D19P+1)) === bareinterval(-0x1.72CECE675D1FDP-52,1.0)

    @test sin(bareinterval(-0.0,0x1.921FB54442D19P+1)) === bareinterval(-0x1.72CECE675D1FDP-52,1.0)

    @test sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)) === bareinterval(0x1.1A62633145C06P-53,0x1P+0)

    @test sin(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)) === bareinterval(-0x1.72CECE675D1FDP-52,0x1P+0)

    @test sin(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)) === bareinterval(0x1.1A62633145C06P-53,0x1P+0)

    @test sin(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)) === bareinterval(-0x1.72CECE675D1FDP-52,0x1P+0)

    @test sin(bareinterval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test sin(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test sin(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test sin(bareinterval(-0x1.921FB54442D18P+0,0.0)) === bareinterval(-0x1P+0,0.0)

    @test sin(bareinterval(-0x1.921FB54442D18P+0,-0.0)) === bareinterval(-0x1P+0,0.0)

    @test sin(bareinterval(-0x1.921FB54442D19P+0,0.0)) === bareinterval(-0x1P+0,0.0)

    @test sin(bareinterval(-0x1.921FB54442D19P+0,-0.0)) === bareinterval(-0x1P+0,0.0)

    @test sin(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)) === bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53)

    @test sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)) === bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52)

    @test sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)) === bareinterval(-0x1.1A62633145C07P-53,0x1.72CECE675D1FDP-52)

    @test sin(bareinterval(-0x1.921FB54442D18P+1,0.0)) === bareinterval(-1.0,0.0)

    @test sin(bareinterval(-0x1.921FB54442D18P+1,-0.0)) === bareinterval(-1.0,0.0)

    @test sin(bareinterval(-0x1.921FB54442D19P+1,0.0)) === bareinterval(-1.0,0x1.72CECE675D1FDP-52)

    @test sin(bareinterval(-0x1.921FB54442D19P+1,-0.0)) === bareinterval(-1.0,0x1.72CECE675D1FDP-52)

    @test sin(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)) === bareinterval(-0x1P+0,-0x1.1A62633145C06P-53)

    @test sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)) === bareinterval(-0x1P+0,0x1.72CECE675D1FDP-52)

    @test sin(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)) === bareinterval(-0x1P+0,-0x1.1A62633145C06P-53)

    @test sin(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)) === bareinterval(-0x1P+0,0x1.72CECE675D1FDP-52)

    @test sin(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === bareinterval(-0x1P+0,0x1P+0)

    @test sin(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1P+0,0x1P+0)

    @test sin(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)) === bareinterval(-0x1P+0,0x1P+0)

    @test sin(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1P+0,0x1P+0)

    @test sin(bareinterval(-0.7,0.1)) === bareinterval(-0x1.49D6E694619B9P-1,0x1.98EAECB8BCB2DP-4)

    @test sin(bareinterval(1.0,2.0)) === bareinterval(0x1.AED548F090CEEP-1,1.0)

    @test sin(bareinterval(-3.2,-2.9)) === bareinterval(-0x1.E9FB8D64830E3P-3,0x1.DE33739E82D33P-5)

    @test sin(bareinterval(2.0,3.0)) === bareinterval(0x1.210386DB6D55BP-3,0x1.D18F6EAD1B446P-1)

end

@testset "minimal_sin_dec_test" begin

    @test sin(interval(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0), def)) === interval(bareinterval(-0x1P+0,-0x1.1A62633145C06P-53), def)

    @test sin(interval(bareinterval(-Inf,-0.0), trv)) === interval(bareinterval(-1.0,1.0), trv)

    @test sin(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-1.0,1.0), dac)

end

@testset "minimal_cos_test" begin

    @test cos(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test cos(bareinterval(0.0,Inf)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0.0,Inf)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-Inf,0.0)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-Inf,-0.0)) === bareinterval(-1.0,1.0)

    @test cos(entireinterval(BareInterval{Float64})) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test cos(bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54)

    @test cos(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53)

    @test cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54)

    @test cos(bareinterval(0.0,0x1.921FB54442D18P+0)) === bareinterval(0x1.1A62633145C06P-54,1.0)

    @test cos(bareinterval(-0.0,0x1.921FB54442D18P+0)) === bareinterval(0x1.1A62633145C06P-54,1.0)

    @test cos(bareinterval(0.0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(-0.0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(bareinterval(0.0,0x1.921FB54442D18P+1)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0.0,0x1.921FB54442D18P+1)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(0.0,0x1.921FB54442D19P+1)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0.0,0x1.921FB54442D19P+1)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)) === bareinterval(-1.0,0x1.1A62633145C07P-54)

    @test cos(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)) === bareinterval(-1.0,0x1.1A62633145C07P-54)

    @test cos(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)) === bareinterval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)) === bareinterval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(bareinterval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)) === bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54)

    @test cos(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53)

    @test cos(bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54)

    @test cos(bareinterval(-0x1.921FB54442D18P+0,0.0)) === bareinterval(0x1.1A62633145C06P-54,1.0)

    @test cos(bareinterval(-0x1.921FB54442D18P+0,-0.0)) === bareinterval(0x1.1A62633145C06P-54,1.0)

    @test cos(bareinterval(-0x1.921FB54442D19P+0,0.0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(-0x1.921FB54442D19P+0,-0.0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(bareinterval(-0x1.921FB54442D18P+1,0.0)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0x1.921FB54442D18P+1,-0.0)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0x1.921FB54442D19P+1,0.0)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0x1.921FB54442D19P+1,-0.0)) === bareinterval(-1.0,1.0)

    @test cos(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)) === bareinterval(-1.0,0x1.1A62633145C07P-54)

    @test cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)) === bareinterval(-1.0,0x1.1A62633145C07P-54)

    @test cos(bareinterval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)) === bareinterval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(bareinterval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)) === bareinterval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === bareinterval(0x1.1A62633145C06P-54,1.0)

    @test cos(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(bareinterval(-0.7,0.1)) === bareinterval(0x1.87996529F9D92P-1,1.0)

    @test cos(bareinterval(1.0,2.0)) === bareinterval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1)

    @test cos(bareinterval(-3.2,-2.9)) === bareinterval(-1.0,-0x1.F1216DBA340C8P-1)

    @test cos(bareinterval(2.0,3.0)) === bareinterval(-0x1.FAE04BE85E5D3P-1,-0x1.AA22657537204P-2)

end

@testset "minimal_cos_dec_test" begin

    @test cos(interval(bareinterval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0), trv)) === interval(bareinterval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), trv)

    @test cos(interval(bareinterval(-Inf,-0.0), def)) === interval(bareinterval(-1.0,1.0), def)

    @test cos(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-1.0,1.0), dac)

end

@testset "minimal_tan_test" begin

    @test tan(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test tan(bareinterval(0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0.0,Inf)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-Inf,0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-Inf,-0.0)) === entireinterval(BareInterval{Float64})

    @test tan(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test tan(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test tan(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === bareinterval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53)

    @test tan(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === bareinterval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52)

    @test tan(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)) === bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53)

    @test tan(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)) === bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52)

    @test tan(bareinterval(0.0,0x1.921FB54442D18P+0)) === bareinterval(0.0,0x1.D02967C31CDB5P+53)

    @test tan(bareinterval(-0.0,0x1.921FB54442D18P+0)) === bareinterval(0.0,0x1.D02967C31CDB5P+53)

    @test tan(bareinterval(0.0,0x1.921FB54442D19P+0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0.0,0x1.921FB54442D19P+0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0.0,0x1.921FB54442D18P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0.0,0x1.921FB54442D18P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0.0,0x1.921FB54442D19P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0.0,0x1.921FB54442D19P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1P-51,0x1.921FB54442D18P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1P-51,0x1.921FB54442D19P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1P-52,0x1.921FB54442D18P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1P-52,0x1.921FB54442D19P+1)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === bareinterval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53)

    @test tan(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4)) === bareinterval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4)

    @test tan(bareinterval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12)) === bareinterval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0)

    @test tan(bareinterval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0)) === bareinterval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0)

end

@testset "minimal_tan_dec_test" begin

    @test tan(interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0.0,Inf), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0.0,Inf), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-Inf,0.0), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-Inf,-0.0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0.0,0.0), com)) === interval(bareinterval(0.0,0.0), com)

    @test tan(interval(bareinterval(-0.0,-0.0), def)) === interval(bareinterval(0.0,0.0), def)

    @test tan(interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), com)) === interval(bareinterval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), com)

    @test tan(interval(bareinterval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), def)) === interval(bareinterval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52), def)

    @test tan(interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1), trv)) === interval(bareinterval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), trv)

    @test tan(interval(bareinterval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1), com)) === interval(bareinterval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), com)

    @test tan(interval(bareinterval(0.0,0x1.921FB54442D18P+0), dac)) === interval(bareinterval(0.0,0x1.D02967C31CDB5P+53), dac)

    @test tan(interval(bareinterval(-0.0,0x1.921FB54442D18P+0), com)) === interval(bareinterval(0.0,0x1.D02967C31CDB5P+53), com)

    @test tan(interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0.0,0x1.921FB54442D19P+0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0.0,0x1.921FB54442D18P+1), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0.0,0x1.921FB54442D18P+1), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0.0,0x1.921FB54442D19P+1), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0x1P-51,0x1.921FB54442D18P+1), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0x1P-51,0x1.921FB54442D19P+1), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0x1P-52,0x1.921FB54442D18P+1), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0x1P-52,0x1.921FB54442D19P+1), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), com)) === interval(bareinterval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), com)

    @test tan(interval(bareinterval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), trv)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4), com)) === interval(bareinterval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4), com)

    @test tan(interval(bareinterval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12), dac)) === interval(bareinterval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0), dac)

    @test tan(interval(bareinterval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12), def)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test tan(interval(bareinterval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0), trv)) === interval(bareinterval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0), trv)

end

@testset "minimal_asin_test" begin

    @test asin(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test asin(bareinterval(0.0,Inf)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test asin(bareinterval(-0.0,Inf)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test asin(bareinterval(-Inf,0.0)) === bareinterval(-0x1.921FB54442D19P+0,0.0)

    @test asin(bareinterval(-Inf,-0.0)) === bareinterval(-0x1.921FB54442D19P+0,0.0)

    @test asin(entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)

    @test asin(bareinterval(-1.0,1.0)) === bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)

    @test asin(bareinterval(-Inf,-1.0)) === bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)

    @test asin(bareinterval(1.0,Inf)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test asin(bareinterval(-1.0,-1.0)) === bareinterval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)

    @test asin(bareinterval(1.0,1.0)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test asin(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test asin(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test asin(bareinterval(-Inf,-0x1.0000000000001P+0)) === emptyinterval(BareInterval{Float64})

    @test asin(bareinterval(0x1.0000000000001P+0,Inf)) === emptyinterval(BareInterval{Float64})

    @test asin(bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(-0x1.9A49276037885P-4,0x1.9A49276037885P-4)

    @test asin(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)) === bareinterval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0)

    @test asin(bareinterval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)) === bareinterval(-0x1.921FB50442D19P+0,0x1.921FB50442D19P+0)

end

@testset "minimal_asin_dec_test" begin

    @test asin(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test asin(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0,0.0), trv)

    @test asin(interval(bareinterval(-1.0,1.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), com)

    @test asin(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), trv)

    @test asin(interval(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), def)) === interval(bareinterval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0), def)

end

@testset "minimal_acos_test" begin

    @test acos(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test acos(bareinterval(0.0,Inf)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test acos(bareinterval(-0.0,Inf)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test acos(bareinterval(-Inf,0.0)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)

    @test acos(bareinterval(-Inf,-0.0)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)

    @test acos(entireinterval(BareInterval{Float64})) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test acos(bareinterval(-1.0,1.0)) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test acos(bareinterval(-Inf,-1.0)) === bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)

    @test acos(bareinterval(1.0,Inf)) === bareinterval(0.0,0.0)

    @test acos(bareinterval(-1.0,-1.0)) === bareinterval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)

    @test acos(bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test acos(bareinterval(0.0,0.0)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test acos(bareinterval(-0.0,-0.0)) === bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test acos(bareinterval(-Inf,-0x1.0000000000001P+0)) === emptyinterval(BareInterval{Float64})

    @test acos(bareinterval(0x1.0000000000001P+0,Inf)) === emptyinterval(BareInterval{Float64})

    @test acos(bareinterval(-0x1.999999999999AP-4,0x1.999999999999AP-4)) === bareinterval(0x1.787B22CE3F59P+0,0x1.ABC447BA464A1P+0)

    @test acos(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)) === bareinterval(0x1P-26,0x1.E837B2FD13428P+0)

    @test acos(bareinterval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)) === bareinterval(0x1P-26,0x1.921FB52442D19P+1)

end

@testset "minimal_acos_dec_test" begin

    @test acos(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test acos(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1), trv)

    @test acos(interval(bareinterval(-1.0,1.0), com)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), com)

    @test acos(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test acos(interval(bareinterval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), def)) === interval(bareinterval(0x1P-26,0x1.E837B2FD13428P+0), def)

end

@testset "minimal_atan_test" begin

    @test atan(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0,Inf)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0,Inf)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(-Inf,0.0)) === bareinterval(-0x1.921FB54442D19P+0,0.0)

    @test atan(bareinterval(-Inf,-0.0)) === bareinterval(-0x1.921FB54442D19P+0,0.0)

    @test atan(entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(1.0,0x1.4C2463567C5ACP+25)) === bareinterval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0)

    @test atan(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === bareinterval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0)

end

@testset "minimal_atan_dec_test" begin

    @test atan(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), dac)

    @test atan(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0,0.0), def)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), dac)

    @test atan(interval(bareinterval(1.0,0x1.4C2463567C5ACP+25), trv)) === interval(bareinterval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0), trv)

    @test atan(interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)) === interval(bareinterval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0), com)

end

@testset "minimal_atan2_test" begin

    @test atan(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, -0.1)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-2.0, 1.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(0.0, 1.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(-0.0, 1.0)) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), bareinterval(0.1, 1.0)) === emptyinterval(BareInterval{Float64})

    @test atan(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, -0.1)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-2.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(-0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(0.1, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 0.0), bareinterval(-0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 0.0), bareinterval(-0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 0.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(-2.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(0.0, 0.0), bareinterval(-0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.1, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0, 0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, 0.0), bareinterval(0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-2.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(-0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0, 0.0), bareinterval(0.1, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(0.0, -0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, -0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, -0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, -0.0), bareinterval(-0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, -0.0), bareinterval(0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, -0.0), bareinterval(-0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, -0.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, -0.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, -0.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, -0.0), bareinterval(-2.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, -0.0), bareinterval(0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(0.0, -0.0), bareinterval(-0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(0.0, -0.0), bareinterval(0.1, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0, -0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, -0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, -0.0), bareinterval(0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-0.0, -0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-2.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(-0.0, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-0.0, -0.0), bareinterval(0.1, 1.0)) === bareinterval(0.0,0.0)

    @test atan(bareinterval(-2.0, -0.1), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+1,0.0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(-0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, -0.1)) === bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, 0.0)) === bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, -0.0)) === bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(-2.0, 1.0)) === bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(-0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4)

    @test atan(bareinterval(-2.0, -0.1), bareinterval(0.1, 1.0)) === bareinterval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4)

    @test atan(bareinterval(-2.0, 0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, -0.1)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-2.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(0.1, 1.0)) === bareinterval(-0x1.8555A2787982P+0, 0.0)

    @test atan(bareinterval(-2.0, -0.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-2.0, -0.0), entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, -0.1)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-2.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(-0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(bareinterval(-2.0, -0.0), bareinterval(0.1, 1.0)) === bareinterval(-0x1.8555A2787982P+0, 0.0)

    @test atan(bareinterval(-2.0, 1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-2.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-0.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-0.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, -0.1)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, 0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, -0.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-2.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(-0.0, 1.0)) === bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-2.0, 1.0), bareinterval(0.1, 1.0)) === bareinterval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0)

    @test atan(bareinterval(-0.0, 1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(-0.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(0.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-0.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(0.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-0.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-2.0, 1.0)) === bareinterval(0.0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(-0.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(-0.0, 1.0), bareinterval(0.1, 1.0)) === bareinterval(0.0, 0x1.789BD2C160054P+0)

    @test atan(bareinterval(0.0, 1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 1.0), bareinterval(0.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-0.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 1.0), bareinterval(0.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-0.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-2.0, 1.0)) === bareinterval(0.0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.0, 1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 1.0), bareinterval(-0.0, 1.0)) === bareinterval(0.0,0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.0, 1.0), bareinterval(0.1, 1.0)) === bareinterval(0.0,0x1.789BD2C160054P+0)

    @test atan(bareinterval(0.1, 1.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.1, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.921FB54442D19P+1)

    @test atan(bareinterval(0.1, 1.0), bareinterval(0.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-0.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.1, 1.0), bareinterval(0.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-0.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-2.0, -0.1)) === bareinterval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-2.0, -0.0)) === bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-2.0, 1.0)) === bareinterval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1)

    @test atan(bareinterval(0.1, 1.0), bareinterval(0.0, 1.0)) === bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.1, 1.0), bareinterval(-0.0, 1.0)) === bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0)

    @test atan(bareinterval(0.1, 1.0), bareinterval(0.1, 1.0)) === bareinterval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0)

end

@testset "minimal_atan2_dec_test" begin

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(entireinterval(BareInterval{Float64}), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0, 0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.0, 0.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0, -0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.0, -0.0), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-2.0, -0.1), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-2.0, 0.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-2.0, -0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-2.0, 1.0), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0, 1.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.0, 1.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.1, 1.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, 0.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, -0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-0.0, 0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-0.0, -0.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.0, -0.1), com)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.0, 0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.0, -0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.0, 1.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, 1.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-0.0, 1.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), dac)

    @test atan(interval(bareinterval(0.0, 0.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 0.0), def), interval(bareinterval(0.0, 0.0), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, 0.0), trv), interval(bareinterval(-0.0, 0.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(0.0, -0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-0.0, -0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac)

    @test atan(interval(bareinterval(0.0, 0.0), trv), interval(bareinterval(-2.0, 0.0), com)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(-2.0, -0.0), trv)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-2.0, 1.0), def)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 0.0), def), interval(bareinterval(0.0, 1.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(0.0, 0.0), trv), interval(bareinterval(-0.0, 1.0), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(0.0,0.0), com)

    @test atan(interval(bareinterval(-0.0, 0.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), def), interval(bareinterval(0.0, 0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), trv), interval(bareinterval(-0.0, 0.0), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), com), interval(bareinterval(0.0, -0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), dac), interval(bareinterval(-0.0, -0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), dac), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac)

    @test atan(interval(bareinterval(-0.0, 0.0), trv), interval(bareinterval(-2.0, 0.0), com)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), com), interval(bareinterval(-2.0, -0.0), trv)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), dac), interval(bareinterval(-2.0, 1.0), def)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), com), interval(bareinterval(0.0, 1.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), def), interval(bareinterval(-0.0, 1.0), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(-0.0, 0.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(0.0,0.0), com)

    @test atan(interval(bareinterval(0.0, -0.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, -0.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, -0.0), def), interval(bareinterval(0.0, 0.0), dac)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, -0.0), trv), interval(bareinterval(-0.0, 0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, -0.0), dac), interval(bareinterval(0.0, -0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, -0.0), com), interval(bareinterval(-0.0, -0.0), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, -0.0), com), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac)

    @test atan(interval(bareinterval(0.0, -0.0), def), interval(bareinterval(-2.0, 0.0), com)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, -0.0), com), interval(bareinterval(-2.0, -0.0), dac)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, -0.0), dac), interval(bareinterval(-2.0, 1.0), com)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, -0.0), com), interval(bareinterval(0.0, 1.0), trv)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(0.0, -0.0), def), interval(bareinterval(-0.0, 1.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(0.0, -0.0), com), interval(bareinterval(0.1, 1.0), def)) === interval(bareinterval(0.0,0.0), def)

    @test atan(interval(bareinterval(-0.0, -0.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), def), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), dac), interval(bareinterval(0.0, 0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), trv), interval(bareinterval(-0.0, 0.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), com), interval(bareinterval(0.0, -0.0), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), dac), interval(bareinterval(-0.0, -0.0), com)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), def), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), def)

    @test atan(interval(bareinterval(-0.0, -0.0), trv), interval(bareinterval(-2.0, 0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), dac), interval(bareinterval(-2.0, -0.0), trv)) === interval(bareinterval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), def), interval(bareinterval(-2.0, 1.0), com)) === interval(bareinterval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), com), interval(bareinterval(0.0, 1.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), trv), interval(bareinterval(-0.0, 1.0), dac)) === interval(bareinterval(0.0,0.0), trv)

    @test atan(interval(bareinterval(-0.0, -0.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(0.0,0.0), com)

    @test atan(interval(bareinterval(-2.0, -0.1), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-2.0, -0.1), def), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1,0.0), def)

    @test atan(interval(bareinterval(-2.0, -0.1), trv), interval(bareinterval(0.0, 0.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, -0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), dac)

    @test atan(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-0.0, 0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), def)

    @test atan(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, -0.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.1), def), interval(bareinterval(-2.0, -0.1), com)) === interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0), def)

    @test atan(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(-2.0, 0.0), def)) === interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), def)

    @test atan(interval(bareinterval(-2.0, -0.1), trv), interval(bareinterval(-2.0, -0.0), dac)) === interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.1), def), interval(bareinterval(-2.0, 1.0), trv)) === interval(bareinterval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4), trv)

    @test atan(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, 1.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), def)

    @test atan(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-0.0, 1.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), dac)

    @test atan(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4), com)

    @test atan(interval(bareinterval(-2.0, 0.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), def), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.0, 0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), trv), interval(bareinterval(-0.0, 0.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(0.0, -0.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), def), interval(bareinterval(-0.0, -0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-2.0, 0.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(-2.0, -0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), trv), interval(bareinterval(-2.0, 1.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), def), interval(bareinterval(0.0, 1.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(-0.0, 1.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(-0x1.8555A2787982P+0, 0.0), com)

    @test atan(interval(bareinterval(-2.0, -0.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), dac), interval(entireinterval(BareInterval{Float64}), def)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), com), interval(bareinterval(0.0, 0.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), def), interval(bareinterval(-0.0, 0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), dac), interval(bareinterval(0.0, -0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), com), interval(bareinterval(-0.0, -0.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), def), interval(bareinterval(-2.0, -0.1), com)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(interval(bareinterval(-2.0, -0.0), com), interval(bareinterval(-2.0, 0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), dac), interval(bareinterval(-2.0, -0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), def), interval(bareinterval(-2.0, 1.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), trv), interval(bareinterval(0.0, 1.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), com), interval(bareinterval(-0.0, 1.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(interval(bareinterval(-2.0, -0.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(-0x1.8555A2787982P+0, 0.0), com)

    @test atan(interval(bareinterval(-2.0, 1.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), def), interval(bareinterval(0.0, 0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), com), interval(bareinterval(-0.0, 0.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), trv), interval(bareinterval(0.0, -0.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), com), interval(bareinterval(-0.0, -0.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), dac), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(interval(bareinterval(-2.0, 1.0), def), interval(bareinterval(-2.0, 0.0), def)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), trv), interval(bareinterval(-2.0, -0.0), trv)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), dac), interval(bareinterval(-2.0, 1.0), com)) === interval(bareinterval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), com), interval(bareinterval(0.0, 1.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), trv), interval(bareinterval(-0.0, 1.0), dac)) === interval(bareinterval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-2.0, 1.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0), com)

    @test atan(interval(bareinterval(-0.0, 1.0), com), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), dac), interval(entireinterval(BareInterval{Float64}), def)) === interval(bareinterval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), def), interval(bareinterval(0.0, 0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), trv), interval(bareinterval(-0.0, 0.0), trv)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), dac), interval(bareinterval(0.0, -0.0), dac)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), com), interval(bareinterval(-0.0, -0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @warn "The original test `atan2 [-0.0, 1.0]_com [-2.0, -0.1]_com = [0X1.ABA397C7259DDP+0, 0X1.921FB54442D19P+1]_dac` is wrong and has been modified. The result should have the decoration `com`"
    @test atan(interval(bareinterval(-0.0, 1.0), com), interval(bareinterval(-2.0, -0.1), com)) === interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), com)

    @test atan(interval(bareinterval(-0.0, 1.0), def), interval(bareinterval(-2.0, 0.0), com)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), def), interval(bareinterval(-2.0, -0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), dac), interval(bareinterval(-2.0, 1.0), dac)) === interval(bareinterval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), dac), interval(bareinterval(0.0, 1.0), dac)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), trv), interval(bareinterval(-0.0, 1.0), com)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(-0.0, 1.0), trv), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(0.0, 0x1.789BD2C160054P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(bareinterval(0.0, 0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), trv), interval(bareinterval(-0.0, 0.0), trv)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), trv), interval(bareinterval(0.0, -0.0), dac)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), def), interval(bareinterval(-0.0, -0.0), com)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(bareinterval(-2.0, -0.1), dac)) === interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), dac)

    @test atan(interval(bareinterval(0.0, 1.0), def), interval(bareinterval(-2.0, 0.0), trv)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(bareinterval(-2.0, -0.0), dac)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(bareinterval(-2.0, 1.0), def)) === interval(bareinterval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(bareinterval(0.0, 1.0), trv)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), dac), interval(bareinterval(-0.0, 1.0), def)) === interval(bareinterval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.0, 1.0), com), interval(bareinterval(0.1, 1.0), com)) === interval(bareinterval(0.0,0x1.789BD2C160054P+0), com)

    @test atan(interval(bareinterval(0.1, 1.0), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atan(interval(bareinterval(0.1, 1.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0, 0x1.921FB54442D19P+1), dac)

    @test atan(interval(bareinterval(0.1, 1.0), def), interval(bareinterval(0.0, 0.0), com)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), def)

    @test atan(interval(bareinterval(0.1, 1.0), trv), interval(bareinterval(-0.0, 0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.1, 1.0), trv), interval(bareinterval(0.0, -0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(interval(bareinterval(0.1, 1.0), dac), interval(bareinterval(-0.0, -0.0), def)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), def)

    @test atan(interval(bareinterval(0.1, 1.0), com), interval(bareinterval(-2.0, -0.1), trv)) === interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1), trv)

    @test atan(interval(bareinterval(0.1, 1.0), com), interval(bareinterval(-2.0, 0.0), dac)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), dac)

    @test atan(interval(bareinterval(0.1, 1.0), com), interval(bareinterval(-2.0, -0.0), dac)) === interval(bareinterval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), dac)

    @test atan(interval(bareinterval(0.1, 1.0), def), interval(bareinterval(-2.0, 1.0), dac)) === interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1), def)

    @test atan(interval(bareinterval(0.1, 1.0), def), interval(bareinterval(0.0, 1.0), def)) === interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), def)

    @test atan(interval(bareinterval(0.1, 1.0), dac), interval(bareinterval(-0.0, 1.0), def)) === interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), def)

    @test atan(interval(bareinterval(0.1, 1.0), dac), interval(bareinterval(0.1, 1.0), def)) === interval(bareinterval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0), def)

end

@testset "minimal_sinh_test" begin

    @test sinh(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test sinh(bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test sinh(bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test sinh(bareinterval(-Inf,0.0)) === bareinterval(-Inf,0.0)

    @test sinh(bareinterval(-Inf,-0.0)) === bareinterval(-Inf,0.0)

    @test sinh(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test sinh(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test sinh(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test sinh(bareinterval(1.0,0x1.2C903022DD7AAP+8)) === bareinterval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432)

    @test sinh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === bareinterval(-Inf,-0x1.53045B4F849DEP+815)

    @test sinh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === bareinterval(-0x1.55ECFE1B2B215P+0,0x1.3BF72EA61AF1BP+2)

end

@testset "minimal_sinh_dec_test" begin

    @test sinh(interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), dac)

    @test sinh(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,Inf), dac)

    @test sinh(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(-Inf,0.0), def)

    @test sinh(interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), com)) === interval(bareinterval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432), com)

    @test sinh(interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)) === interval(bareinterval(-Inf,-0x1.53045B4F849DEP+815), dac)

end

@testset "minimal_cosh_test" begin

    @test cosh(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test cosh(bareinterval(0.0,Inf)) === bareinterval(1.0,Inf)

    @test cosh(bareinterval(-0.0,Inf)) === bareinterval(1.0,Inf)

    @test cosh(bareinterval(-Inf,0.0)) === bareinterval(1.0,Inf)

    @test cosh(bareinterval(-Inf,-0.0)) === bareinterval(1.0,Inf)

    @test cosh(entireinterval(BareInterval{Float64})) === bareinterval(1.0,Inf)

    @test cosh(bareinterval(0.0,0.0)) === bareinterval(1.0,1.0)

    @test cosh(bareinterval(-0.0,-0.0)) === bareinterval(1.0,1.0)

    @test cosh(bareinterval(1.0,0x1.2C903022DD7AAP+8)) === bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432)

    @test cosh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === bareinterval(0x1.53045B4F849DEP+815,Inf)

    @test cosh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === bareinterval(1.0,0x1.4261D2B7D6181P+2)

end

@testset "minimal_cosh_dec_test" begin

    @test cosh(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(1.0,Inf), dac)

    @test cosh(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(1.0,Inf), def)

    @test cosh(interval(entireinterval(BareInterval{Float64}), def)) === interval(bareinterval(1.0,Inf), def)

    @test cosh(interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), def)) === interval(bareinterval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), def)

    @test cosh(interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)) === interval(bareinterval(0x1.53045B4F849DEP+815,Inf), dac)

end

@testset "minimal_tanh_test" begin

    @test tanh(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test tanh(bareinterval(0.0,Inf)) === bareinterval(0.0,1.0)

    @test tanh(bareinterval(-0.0,Inf)) === bareinterval(0.0,1.0)

    @test tanh(bareinterval(-Inf,0.0)) === bareinterval(-1.0,0.0)

    @test tanh(bareinterval(-Inf,-0.0)) === bareinterval(-1.0,0.0)

    @test tanh(entireinterval(BareInterval{Float64})) === bareinterval(-1.0,1.0)

    @test tanh(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test tanh(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test tanh(bareinterval(1.0,0x1.2C903022DD7AAP+8)) === bareinterval(0x1.85EFAB514F394P-1,0x1P+0)

    @test tanh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test tanh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === bareinterval(-0x1.99DB01FDE2406P-1,0x1.F5CF31E1C8103P-1)

end

@testset "minimal_tanh_dec_test" begin

    @test tanh(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,1.0), dac)

    @test tanh(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(-1.0,0.0), def)

    @test tanh(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(-1.0,1.0), dac)

    @test tanh(interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), com)) === interval(bareinterval(0x1.85EFAB514F394P-1,0x1P+0), com)

    @test tanh(interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), trv)) === interval(bareinterval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), trv)

end

@testset "minimal_asinh_test" begin

    @test asinh(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test asinh(bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test asinh(bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test asinh(bareinterval(-Inf,0.0)) === bareinterval(-Inf,0.0)

    @test asinh(bareinterval(-Inf,-0.0)) === bareinterval(-Inf,0.0)

    @test asinh(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test asinh(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test asinh(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test asinh(bareinterval(1.0,0x1.2C903022DD7AAP+8)) === bareinterval(0x1.C34366179D426P-1,0x1.9986127438A87P+2)

    @test asinh(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === bareinterval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2)

    @test asinh(bareinterval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === bareinterval(-0x1.E693DF6EDF1E7P-1,0x1.91FDC64DE0E51P+0)

end

@testset "minimal_asinh_dec_test" begin

    @test asinh(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,Inf), dac)

    @test asinh(interval(bareinterval(-Inf,0.0), trv)) === interval(bareinterval(-Inf,0.0), trv)

    @test asinh(interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), dac)

    @test asinh(interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), com)) === interval(bareinterval(0x1.C34366179D426P-1,0x1.9986127438A87P+2), com)

    @test asinh(interval(bareinterval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), def)) === interval(bareinterval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2), def)

end

@testset "minimal_acosh_test" begin

    @test acosh(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test acosh(bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test acosh(bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test acosh(bareinterval(1.0,Inf)) === bareinterval(0.0,Inf)

    @test acosh(bareinterval(-Inf,1.0)) === bareinterval(0.0,0.0)

    @test acosh(bareinterval(-Inf,0x1.FFFFFFFFFFFFFP-1)) === emptyinterval(BareInterval{Float64})

    @test acosh(entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test acosh(bareinterval(1.0,1.0)) === bareinterval(0.0,0.0)

    @test acosh(bareinterval(1.0,0x1.2C903022DD7AAP+8)) === bareinterval(0.0,0x1.9985FB3D532AFP+2)

    @test acosh(bareinterval(0x1.199999999999AP+0,0x1.2666666666666P+1)) === bareinterval(0x1.C636C1A882F2CP-2,0x1.799C88E79140DP+0)

    @test acosh(bareinterval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29)) === bareinterval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4)

end

@testset "minimal_acosh_dec_test" begin

    @test acosh(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test acosh(interval(bareinterval(1.0,Inf), dac)) === interval(bareinterval(0.0,Inf), dac)

    @test acosh(interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test acosh(interval(bareinterval(1.0,1.0), com)) === interval(bareinterval(0.0,0.0), com)

    @test acosh(interval(bareinterval(0.9,1.0), com)) === interval(bareinterval(0.0,0.0), trv)

    @test acosh(interval(bareinterval(1.0,0x1.2C903022DD7AAP+8), dac)) === interval(bareinterval(0.0,0x1.9985FB3D532AFP+2), dac)

    @test acosh(interval(bareinterval(0.9,0x1.2C903022DD7AAP+8), com)) === interval(bareinterval(0.0,0x1.9985FB3D532AFP+2), trv)

    @test acosh(interval(bareinterval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29), def)) === interval(bareinterval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4), def)

end

@testset "minimal_atanh_test" begin

    @test atanh(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atanh(bareinterval(0.0,Inf)) === bareinterval(0.0,Inf)

    @test atanh(bareinterval(-0.0,Inf)) === bareinterval(0.0,Inf)

    @test atanh(bareinterval(1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test atanh(bareinterval(-Inf,0.0)) === bareinterval(-Inf,0.0)

    @test atanh(bareinterval(-Inf,-0.0)) === bareinterval(-Inf,0.0)

    @test atanh(bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test atanh(bareinterval(-1.0,1.0)) === entireinterval(BareInterval{Float64})

    @test atanh(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test atanh(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test atanh(bareinterval(-1.0,-1.0)) === emptyinterval(BareInterval{Float64})

    @test atanh(bareinterval(1.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test atanh(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test atanh(bareinterval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1)) === bareinterval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4)

    @test atanh(bareinterval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4)) === bareinterval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4)

end

@testset "minimal_atanh_dec_test" begin

    @test atanh(interval(bareinterval(0.0,Inf), dac)) === interval(bareinterval(0.0,Inf), trv)

    @test atanh(interval(bareinterval(-Inf,0.0), def)) === interval(bareinterval(-Inf,0.0), trv)

    @test atanh(interval(bareinterval(-1.0,1.0), com)) === interval(entireinterval(BareInterval{Float64}), trv)

    @test atanh(interval(bareinterval(0.0,0.0), com)) === interval(bareinterval(0.0,0.0), com)

    @test atanh(interval(bareinterval(1.0,1.0), def)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test atanh(interval(bareinterval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1), com)) === interval(bareinterval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4), com)

    @test atanh(interval(bareinterval(-1.0,0x1.FFFFFFFFFFFFFP-1), com)) === interval(bareinterval(-Inf,0x1.2B708872320E2P+4), trv)

    @test atanh(interval(bareinterval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4), def)) === interval(bareinterval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4), def)

    @test atanh(interval(bareinterval(-0x1.FFB88E9EB6307P-1,1.0), com)) === interval(bareinterval(-0x1.06A3A97D7979CP+2,Inf), trv)

end

@testset "minimal_sign_test" begin

    @test sign(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test sign(bareinterval(1.0,2.0)) === bareinterval(1.0,1.0)

    @test sign(bareinterval(-1.0,2.0)) === bareinterval(-1.0,1.0)

    @test sign(bareinterval(-1.0,0.0)) === bareinterval(-1.0,0.0)

    @test sign(bareinterval(0.0,2.0)) === bareinterval(0.0,1.0)

    @test sign(bareinterval(-0.0,2.0)) === bareinterval(0.0,1.0)

    @test sign(bareinterval(-5.0,-2.0)) === bareinterval(-1.0,-1.0)

    @test sign(bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test sign(bareinterval(-0.0,-0.0)) === bareinterval(0.0,0.0)

    @test sign(bareinterval(-0.0,0.0)) === bareinterval(0.0,0.0)

    @test sign(entireinterval(BareInterval{Float64})) === bareinterval(-1.0,1.0)

end

@testset "minimal_sign_dec_test" begin

    @test sign(interval(bareinterval(1.0,2.0), com)) === interval(bareinterval(1.0,1.0), com)

    @test sign(interval(bareinterval(-1.0,2.0), com)) === interval(bareinterval(-1.0,1.0), def)

    @test sign(interval(bareinterval(-1.0,0.0), com)) === interval(bareinterval(-1.0,0.0), def)

    @test sign(interval(bareinterval(0.0,2.0), com)) === interval(bareinterval(0.0,1.0), def)

    @test sign(interval(bareinterval(-0.0,2.0), def)) === interval(bareinterval(0.0,1.0), def)

    @test sign(interval(bareinterval(-5.0,-2.0), trv)) === interval(bareinterval(-1.0,-1.0), trv)

    @test sign(interval(bareinterval(0.0,0.0), dac)) === interval(bareinterval(0.0,0.0), dac)

end

@testset "minimal_ceil_test" begin

    @test ceil(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test ceil(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test ceil(bareinterval(1.1,2.0)) === bareinterval(2.0,2.0)

    @test ceil(bareinterval(-1.1,2.0)) === bareinterval(-1.0,2.0)

    @test ceil(bareinterval(-1.1,0.0)) === bareinterval(-1.0,0.0)

    @test ceil(bareinterval(-1.1,-0.0)) === bareinterval(-1.0,0.0)

    @test ceil(bareinterval(-1.1,-0.4)) === bareinterval(-1.0,0.0)

    @test ceil(bareinterval(-1.9,2.2)) === bareinterval(-1.0,3.0)

    @test ceil(bareinterval(-1.0,2.2)) === bareinterval(-1.0,3.0)

    @test ceil(bareinterval(0.0,2.2)) === bareinterval(0.0,3.0)

    @test ceil(bareinterval(-0.0,2.2)) === bareinterval(0.0,3.0)

    @test ceil(bareinterval(-1.5,Inf)) === bareinterval(-1.0,Inf)

    @test ceil(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)) === bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ceil(bareinterval(-Inf,2.2)) === bareinterval(-Inf,3.0)

    @test ceil(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023)) === bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023)

end

@testset "minimal_ceil_dec_test" begin

    @test ceil(interval(bareinterval(1.1,2.0), com)) === interval(bareinterval(2.0,2.0), dac)

    @test ceil(interval(bareinterval(-1.1,2.0), com)) === interval(bareinterval(-1.0,2.0), def)

    @test ceil(interval(bareinterval(-1.1,0.0), dac)) === interval(bareinterval(-1.0,0.0), def)

    @test ceil(interval(bareinterval(-1.1,-0.0), trv)) === interval(bareinterval(-1.0,0.0), trv)

    @test ceil(interval(bareinterval(-1.1,-0.4), dac)) === interval(bareinterval(-1.0,0.0), def)

    @test ceil(interval(bareinterval(-1.9,2.2), com)) === interval(bareinterval(-1.0,3.0), def)

    @test ceil(interval(bareinterval(-1.0,2.2), dac)) === interval(bareinterval(-1.0,3.0), def)

    @test ceil(interval(bareinterval(0.0,2.2), trv)) === interval(bareinterval(0.0,3.0), trv)

    @test ceil(interval(bareinterval(-0.0,2.2), def)) === interval(bareinterval(0.0,3.0), def)

    @test ceil(interval(bareinterval(-1.5,Inf), trv)) === interval(bareinterval(-1.0,Inf), trv)

    @test ceil(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), dac)) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), def)

    @test ceil(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac)

    @test ceil(interval(bareinterval(-Inf,2.2), trv)) === interval(bareinterval(-Inf,3.0), trv)

    @test ceil(interval(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac)) === interval(bareinterval(-Inf,-0x1.FFFFFFFFFFFFFp1023), def)

end

@testset "minimal_floor_test" begin

    @test floor(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test floor(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test floor(bareinterval(1.1,2.0)) === bareinterval(1.0,2.0)

    @test floor(bareinterval(-1.1,2.0)) === bareinterval(-2.0,2.0)

    @test floor(bareinterval(-1.1,0.0)) === bareinterval(-2.0,0.0)

    @test floor(bareinterval(-1.1,-0.0)) === bareinterval(-2.0,0.0)

    @test floor(bareinterval(-1.1,-0.4)) === bareinterval(-2.0,-1.0)

    @test floor(bareinterval(-1.9,2.2)) === bareinterval(-2.0,2.0)

    @test floor(bareinterval(-1.0,2.2)) === bareinterval(-1.0,2.0)

    @test floor(bareinterval(0.0,2.2)) === bareinterval(0.0,2.0)

    @test floor(bareinterval(-0.0,2.2)) === bareinterval(0.0,2.0)

    @test floor(bareinterval(-1.5,Inf)) === bareinterval(-2.0,Inf)

    @test floor(bareinterval(-Inf,2.2)) === bareinterval(-Inf,2.0)

end

@testset "minimal_floor_dec_test" begin

    @test floor(interval(bareinterval(1.1,2.0), com)) === interval(bareinterval(1.0,2.0), def)

    @test floor(interval(bareinterval(-1.1,2.0), def)) === interval(bareinterval(-2.0,2.0), def)

    @test floor(interval(bareinterval(-1.1,0.0), dac)) === interval(bareinterval(-2.0,0.0), def)

    @test floor(interval(bareinterval(-1.2,-1.1), com)) === interval(bareinterval(-2.0,-2.0), com)

    @test floor(interval(bareinterval(-1.1,-0.4), def)) === interval(bareinterval(-2.0,-1.0), def)

    @test floor(interval(bareinterval(-1.9,2.2), com)) === interval(bareinterval(-2.0,2.0), def)

    @test floor(interval(bareinterval(-1.0,2.2), trv)) === interval(bareinterval(-1.0,2.0), trv)

    @test floor(interval(bareinterval(0.0,2.2), trv)) === interval(bareinterval(0.0,2.0), trv)

    @test floor(interval(bareinterval(-0.0,2.2), com)) === interval(bareinterval(0.0,2.0), def)

    @test floor(interval(bareinterval(-1.5,Inf), dac)) === interval(bareinterval(-2.0,Inf), def)

    @test floor(interval(bareinterval(-Inf,2.2), trv)) === interval(bareinterval(-Inf,2.0), trv)

    @test floor(interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), dac)

end

@testset "minimal_trunc_test" begin

    @test trunc(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test trunc(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test trunc(bareinterval(1.1,2.1)) === bareinterval(1.0,2.0)

    @test trunc(bareinterval(-1.1,2.0)) === bareinterval(-1.0,2.0)

    @test trunc(bareinterval(-1.1,0.0)) === bareinterval(-1.0,0.0)

    @test trunc(bareinterval(-1.1,-0.0)) === bareinterval(-1.0,0.0)

    @test trunc(bareinterval(-1.1,-0.4)) === bareinterval(-1.0,0.0)

    @test trunc(bareinterval(-1.9,2.2)) === bareinterval(-1.0,2.0)

    @test trunc(bareinterval(-1.0,2.2)) === bareinterval(-1.0,2.0)

    @test trunc(bareinterval(0.0,2.2)) === bareinterval(0.0,2.0)

    @test trunc(bareinterval(-0.0,2.2)) === bareinterval(0.0,2.0)

    @test trunc(bareinterval(-1.5,Inf)) === bareinterval(-1.0,Inf)

    @test trunc(bareinterval(-Inf,2.2)) === bareinterval(-Inf,2.0)

end

@testset "minimal_trunc_dec_test" begin

    @test trunc(interval(bareinterval(1.1,2.1), com)) === interval(bareinterval(1.0,2.0), def)

    @test trunc(interval(bareinterval(1.1,1.9), com)) === interval(bareinterval(1.0,1.0), com)

    @test trunc(interval(bareinterval(-1.1,2.0), dac)) === interval(bareinterval(-1.0,2.0), def)

    @test trunc(interval(bareinterval(-1.1,0.0), trv)) === interval(bareinterval(-1.0,0.0), trv)

    @test trunc(interval(bareinterval(-1.1,-0.0), def)) === interval(bareinterval(-1.0,0.0), def)

    @test trunc(interval(bareinterval(-1.1,-0.4), com)) === interval(bareinterval(-1.0,0.0), def)

    @test trunc(interval(bareinterval(-1.9,2.2), def)) === interval(bareinterval(-1.0,2.0), def)

    @test trunc(interval(bareinterval(-1.0,2.2), dac)) === interval(bareinterval(-1.0,2.0), def)

    @test trunc(interval(bareinterval(-1.5,Inf), dac)) === interval(bareinterval(-1.0,Inf), def)

    @test trunc(interval(bareinterval(-Inf,2.2), trv)) === interval(bareinterval(-Inf,2.0), trv)

    @test trunc(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac)

    @test trunc(interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), dac)) === interval(bareinterval(0x1.FFFFFFFFFFFFFp1023,Inf), def)

end

@testset "minimal_round_ties_to_even_test" begin

    @test round(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test round(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test round(bareinterval(1.1,2.1)) === bareinterval(1.0,2.0)

    @test round(bareinterval(-1.1,2.0)) === bareinterval(-1.0,2.0)

    @test round(bareinterval(-1.1,-0.4)) === bareinterval(-1.0,0.0)

    @test round(bareinterval(-1.1,0.0)) === bareinterval(-1.0,0.0)

    @test round(bareinterval(-1.1,-0.0)) === bareinterval(-1.0,0.0)

    @test round(bareinterval(-1.9,2.2)) === bareinterval(-2.0,2.0)

    @test round(bareinterval(-1.0,2.2)) === bareinterval(-1.0,2.0)

    @test round(bareinterval(1.5,2.1)) === bareinterval(2.0,2.0)

    @test round(bareinterval(-1.5,2.0)) === bareinterval(-2.0,2.0)

    @test round(bareinterval(-1.1,-0.5)) === bareinterval(-1.0,0.0)

    @test round(bareinterval(-1.9,2.5)) === bareinterval(-2.0,2.0)

    @test round(bareinterval(0.0,2.5)) === bareinterval(0.0,2.0)

    @test round(bareinterval(-0.0,2.5)) === bareinterval(0.0,2.0)

    @test round(bareinterval(-1.5,2.5)) === bareinterval(-2.0,2.0)

    @test round(bareinterval(-1.5,Inf)) === bareinterval(-2.0,Inf)

    @test round(bareinterval(-Inf,2.2)) === bareinterval(-Inf,2.0)

end

@testset "minimal_round_ties_to_even_dec_test" begin

    @test round(interval(bareinterval(1.1,2.1), com)) === interval(bareinterval(1.0,2.0), def)

    @test round(interval(bareinterval(-1.1,2.0), trv)) === interval(bareinterval(-1.0,2.0), trv)

    @test round(interval(bareinterval(-1.6,-1.5), com)) === interval(bareinterval(-2.0,-2.0), dac)

    @test round(interval(bareinterval(-1.6,-1.4), com)) === interval(bareinterval(-2.0,-1.0), def)

    @test round(interval(bareinterval(-1.5,Inf), dac)) === interval(bareinterval(-2.0,Inf), def)

    @test round(interval(bareinterval(-Inf,2.2), trv)) === interval(bareinterval(-Inf,2.0), trv)

end

@testset "minimal_round_ties_to_away_test" begin

    @test round(emptyinterval(BareInterval{Float64}), RoundNearestTiesAway) === emptyinterval(BareInterval{Float64})

    @test round(entireinterval(BareInterval{Float64}), RoundNearestTiesAway) === entireinterval(BareInterval{Float64})

    @test round(bareinterval(1.1,2.1), RoundNearestTiesAway) === bareinterval(1.0,2.0)

    @test round(bareinterval(-1.1,2.0), RoundNearestTiesAway) === bareinterval(-1.0,2.0)

    @test round(bareinterval(-1.1,0.0), RoundNearestTiesAway) === bareinterval(-1.0,0.0)

    @test round(bareinterval(-1.1,-0.0), RoundNearestTiesAway) === bareinterval(-1.0,-0.0)

    @test round(bareinterval(-1.1,-0.4), RoundNearestTiesAway) === bareinterval(-1.0,0.0)

    @test round(bareinterval(-1.9,2.2), RoundNearestTiesAway) === bareinterval(-2.0,2.0)

    @test round(bareinterval(-1.0,2.2), RoundNearestTiesAway) === bareinterval(-1.0,2.0)

    @test round(bareinterval(0.5,2.1), RoundNearestTiesAway) === bareinterval(1.0,2.0)

    @test round(bareinterval(-2.5,2.0), RoundNearestTiesAway) === bareinterval(-3.0,2.0)

    @test round(bareinterval(-1.1,-0.5), RoundNearestTiesAway) === bareinterval(-1.0,-1.0)

    @test round(bareinterval(-1.9,2.5), RoundNearestTiesAway) === bareinterval(-2.0,3.0)

    @test round(bareinterval(-1.5,2.5), RoundNearestTiesAway) === bareinterval(-2.0,3.0)

    @test round(bareinterval(0.0,2.5), RoundNearestTiesAway) === bareinterval(0.0,3.0)

    @test round(bareinterval(-0.0,2.5), RoundNearestTiesAway) === bareinterval(0.0,3.0)

    @test round(bareinterval(-1.5,Inf), RoundNearestTiesAway) === bareinterval(-2.0,Inf)

    @test round(bareinterval(-Inf,2.2), RoundNearestTiesAway) === bareinterval(-Inf,2.0)

end

@testset "minimal_round_ties_to_away_dec_test" begin

    @test round(interval(bareinterval(1.1,2.1), com), RoundNearestTiesAway) === interval(bareinterval(1.0,2.0), def)

    @test round(interval(bareinterval(-1.9,2.2), com), RoundNearestTiesAway) === interval(bareinterval(-2.0,2.0), def)

    @test round(interval(bareinterval(1.9,2.2), com), RoundNearestTiesAway) === interval(bareinterval(2.0,2.0), com)

    @test round(interval(bareinterval(-1.0,2.2), trv), RoundNearestTiesAway) === interval(bareinterval(-1.0,2.0), trv)

    @test round(interval(bareinterval(2.5,2.6), com), RoundNearestTiesAway) === interval(bareinterval(3.0,3.0), dac)

    @test round(interval(bareinterval(-1.5,Inf), dac), RoundNearestTiesAway) === interval(bareinterval(-2.0,Inf), def)

    @test round(interval(bareinterval(-Inf,2.2), def), RoundNearestTiesAway) === interval(bareinterval(-Inf,2.0), def)

end

@testset "minimal_abs_test" begin

    @test abs(emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test abs(entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test abs(bareinterval(1.1,2.1)) === bareinterval(1.1,2.1)

    @test abs(bareinterval(-1.1,2.0)) === bareinterval(0.0,2.0)

    @test abs(bareinterval(-1.1,0.0)) === bareinterval(0.0,1.1)

    @test abs(bareinterval(-1.1,-0.0)) === bareinterval(0.0,1.1)

    @test abs(bareinterval(-1.1,-0.4)) === bareinterval(0.4,1.1)

    @test abs(bareinterval(-1.9,0.2)) === bareinterval(0.0,1.9)

    @test abs(bareinterval(0.0,0.2)) === bareinterval(0.0,0.2)

    @test abs(bareinterval(-0.0,0.2)) === bareinterval(0.0,0.2)

    @test abs(bareinterval(-1.5,Inf)) === bareinterval(0.0,Inf)

    @test abs(bareinterval(-Inf,-2.2)) === bareinterval(2.2,Inf)

end

@testset "minimal_abs_dec_test" begin

    @test abs(interval(bareinterval(-1.1,2.0), com)) === interval(bareinterval(0.0,2.0), com)

    @test abs(interval(bareinterval(-1.1,0.0), dac)) === interval(bareinterval(0.0,1.1), dac)

    @test abs(interval(bareinterval(-1.1,-0.0), def)) === interval(bareinterval(0.0,1.1), def)

    @test abs(interval(bareinterval(-1.1,-0.4), trv)) === interval(bareinterval(0.4,1.1), trv)

    @test abs(interval(bareinterval(-1.9,0.2), dac)) === interval(bareinterval(0.0,1.9), dac)

    @test abs(interval(bareinterval(0.0,0.2), def)) === interval(bareinterval(0.0,0.2), def)

    @test abs(interval(bareinterval(-0.0,0.2), com)) === interval(bareinterval(0.0,0.2), com)

    @test abs(interval(bareinterval(-1.5,Inf), dac)) === interval(bareinterval(0.0,Inf), dac)

end

@testset "minimal_min_test" begin

    @test min(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test min(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test min(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test min(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === bareinterval(-Inf,2.0)

    @test min(bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf,2.0)

    @test min(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test min(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test min(bareinterval(1.0,5.0), bareinterval(2.0,4.0)) === bareinterval(1.0,4.0)

    @test min(bareinterval(0.0,5.0), bareinterval(2.0,4.0)) === bareinterval(0.0,4.0)

    @test min(bareinterval(-0.0,5.0), bareinterval(2.0,4.0)) === bareinterval(0.0,4.0)

    @test min(bareinterval(1.0,5.0), bareinterval(2.0,8.0)) === bareinterval(1.0,5.0)

    @test min(bareinterval(1.0,5.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf,5.0)

    @test min(bareinterval(-7.0,-5.0), bareinterval(2.0,4.0)) === bareinterval(-7.0,-5.0)

    @test min(bareinterval(-7.0,0.0), bareinterval(2.0,4.0)) === bareinterval(-7.0,0.0)

    @test min(bareinterval(-7.0,-0.0), bareinterval(2.0,4.0)) === bareinterval(-7.0,0.0)

end

@testset "minimal_min_dec_test" begin

    @test min(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(1.0,2.0), com)) === interval(bareinterval(-Inf,2.0), dac)

    @test min(interval(bareinterval(-7.0,-5.0), trv), interval(bareinterval(2.0,4.0), def)) === interval(bareinterval(-7.0,-5.0), trv)

    @test min(interval(bareinterval(-7.0,0.0), dac), interval(bareinterval(2.0,4.0), def)) === interval(bareinterval(-7.0,0.0), def)

    @test min(interval(bareinterval(-7.0,-0.0), com), interval(bareinterval(2.0,4.0), com)) === interval(bareinterval(-7.0,0.0), com)

end

@testset "minimal_max_test" begin

    @test max(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === emptyinterval(BareInterval{Float64})

    @test max(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test max(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test max(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === bareinterval(1.0,Inf)

    @test max(bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0,Inf)

    @test max(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test max(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test max(bareinterval(1.0,5.0), bareinterval(2.0,4.0)) === bareinterval(2.0,5.0)

    @test max(bareinterval(1.0,5.0), bareinterval(2.0,8.0)) === bareinterval(2.0,8.0)

    @test max(bareinterval(-1.0,5.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0,Inf)

    @test max(bareinterval(-7.0,-5.0), bareinterval(2.0,4.0)) === bareinterval(2.0,4.0)

    @test max(bareinterval(-7.0,-5.0), bareinterval(0.0,4.0)) === bareinterval(0.0,4.0)

    @test max(bareinterval(-7.0,-5.0), bareinterval(-0.0,4.0)) === bareinterval(0.0,4.0)

    @test max(bareinterval(-7.0,-5.0), bareinterval(-2.0,0.0)) === bareinterval(-2.0,0.0)

    @test max(bareinterval(-7.0,-5.0), bareinterval(-2.0,-0.0)) === bareinterval(-2.0,0.0)

end

@testset "minimal_max_dec_test" begin

    @test max(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(1.0,2.0), com)) === interval(bareinterval(1.0,Inf), dac)

    @test max(interval(bareinterval(-7.0,-5.0), trv), interval(bareinterval(2.0,4.0), def)) === interval(bareinterval(2.0,4.0), trv)

    @test max(interval(bareinterval(-7.0,5.0), dac), interval(bareinterval(2.0,4.0), def)) === interval(bareinterval(2.0,5.0), def)

    @test max(interval(bareinterval(3.0,3.5), com), interval(bareinterval(2.0,4.0), com)) === interval(bareinterval(3.0,4.0), com)

end
