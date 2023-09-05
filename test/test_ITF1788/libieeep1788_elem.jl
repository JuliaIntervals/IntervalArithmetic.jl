@testset "minimal_pos_test" begin

    @test isequalinterval(+(interval(1.0,2.0)), interval(1.0,2.0))

    @test isequalinterval(+(emptyinterval()), emptyinterval())

    @test isequalinterval(+(entireinterval()), entireinterval())

    @test isequalinterval(+(interval(1.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(+(interval(-Inf,-1.0)), interval(-Inf,-1.0))

    @test isequalinterval(+(interval(0.0,2.0)), interval(0.0,2.0))

    @test isequalinterval(+(interval(-0.0,2.0)), interval(0.0,2.0))

    @test isequalinterval(+(interval(-2.5,-0.0)), interval(-2.5,0.0))

    @test isequalinterval(+(interval(-2.5,0.0)), interval(-2.5,0.0))

    @test isequalinterval(+(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(+(interval(0.0,0.0)), interval(0.0,0.0))

end

@testset "minimal_pos_dec_test" begin

    @test isnai(+(nai()))

    @test isequalinterval(+(DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(+(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), dac))

    @test isequalinterval(+(DecoratedInterval(interval(1.0, 2.0), com)), DecoratedInterval(interval(1.0, 2.0), com))

end

@testset "minimal_neg_test" begin

    @test isequalinterval(-(interval(1.0,2.0)), interval(-2.0,-1.0))

    @test isequalinterval(-(emptyinterval()), emptyinterval())

    @test isequalinterval(-(entireinterval()), entireinterval())

    @test isequalinterval(-(interval(1.0,Inf)), interval(-Inf,-1.0))

    @test isequalinterval(-(interval(-Inf,1.0)), interval(-1.0,Inf))

    @test isequalinterval(-(interval(0.0,2.0)), interval(-2.0,0.0))

    @test isequalinterval(-(interval(-0.0,2.0)), interval(-2.0,0.0))

    @test isequalinterval(-(interval(-2.0,0.0)), interval(0.0,2.0))

    @test isequalinterval(-(interval(-2.0,-0.0)), interval(0.0,2.0))

    @test isequalinterval(-(interval(0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(-(interval(-0.0,-0.0)), interval(0.0,0.0))

end

@testset "minimal_neg_dec_test" begin

    @test isnai(-(nai()))

    @test isequalinterval(-(DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(-(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), dac))

    @test isequalinterval(-(DecoratedInterval(interval(1.0, 2.0), com)), DecoratedInterval(interval(-2.0, -1.0), com))

end

@testset "minimal_add_test" begin

    @test isequalinterval(+(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(+(interval(-1.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(+(emptyinterval(), interval(-1.0,1.0)), emptyinterval())

    @test isequalinterval(+(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(+(entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(+(entireinterval(), interval(-Inf,1.0)), entireinterval())

    @test isequalinterval(+(entireinterval(), interval(-1.0,1.0)), entireinterval())

    @test isequalinterval(+(entireinterval(), interval(-1.0,Inf)), entireinterval())

    @test isequalinterval(+(entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(+(interval(-Inf,1.0), entireinterval()), entireinterval())

    @test isequalinterval(+(interval(-1.0,1.0), entireinterval()), entireinterval())

    @test isequalinterval(+(interval(-1.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(+(interval(-Inf,2.0), interval(-Inf,4.0)), interval(-Inf,6.0))

    @test isequalinterval(+(interval(-Inf,2.0), interval(3.0,4.0)), interval(-Inf,6.0))

    @test isequalinterval(+(interval(-Inf,2.0), interval(3.0,Inf)), entireinterval())

    @test isequalinterval(+(interval(1.0,2.0), interval(-Inf,4.0)), interval(-Inf,6.0))

    @test isequalinterval(+(interval(1.0,2.0), interval(3.0,4.0)), interval(4.0,6.0))

    @test isequalinterval(+(interval(1.0,2.0), interval(3.0,Inf)), interval(4.0,Inf))

    @test isequalinterval(+(interval(1.0,Inf), interval(-Inf,4.0)), entireinterval())

    @test isequalinterval(+(interval(1.0,Inf), interval(3.0,4.0)), interval(4.0,Inf))

    @test isequalinterval(+(interval(1.0,Inf), interval(3.0,Inf)), interval(4.0,Inf))

    @test isequalinterval(+(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(3.0,4.0)), interval(4.0,Inf))

    @test isequalinterval(+(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(-3.0,4.0)), interval(-Inf,6.0))

    @test isequalinterval(+(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(-3.0,0x1.FFFFFFFFFFFFFp1023)), entireinterval())

    @test isequalinterval(+(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(0.0,0.0)), interval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(+(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(-0.0,-0.0)), interval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(+(interval(0.0,0.0), interval(-3.0,4.0)), interval(-3.0,4.0))

    @test isequalinterval(+(interval(-0.0,-0.0), interval(-3.0,0x1.FFFFFFFFFFFFFp1023)), interval(-3.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(+(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1))

    @test isequalinterval(+(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)), interval(0x1.E666666666656P+0,0x1.E666666666657P+0))

    @test isequalinterval(+(interval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(-0x1.E666666666657P+0,0x1.0CCCCCCCCCCC5P+1))

end

@testset "minimal_add_dec_test" begin

    @test isequalinterval(+(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), com)), DecoratedInterval(interval(6.0,9.0), com))

    @test isequalinterval(+(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), def)), DecoratedInterval(interval(6.0,9.0), def))

    @test isequalinterval(+(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(6.0,Inf), dac))

    @test isequalinterval(+(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), DecoratedInterval(interval(-0.1, 5.0), com)), DecoratedInterval(interval(-Inf,7.0), dac))

    @test isequalinterval(+(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isnai(+(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_sub_test" begin

    @test isequalinterval(-(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(-(interval(-1.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(-(emptyinterval(), interval(-1.0,1.0)), emptyinterval())

    @test isequalinterval(-(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(-(entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(-(entireinterval(), interval(-Inf,1.0)), entireinterval())

    @test isequalinterval(-(entireinterval(), interval(-1.0,1.0)), entireinterval())

    @test isequalinterval(-(entireinterval(), interval(-1.0,Inf)), entireinterval())

    @test isequalinterval(-(entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(-(interval(-Inf,1.0), entireinterval()), entireinterval())

    @test isequalinterval(-(interval(-1.0,1.0), entireinterval()), entireinterval())

    @test isequalinterval(-(interval(-1.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(-(interval(-Inf,2.0), interval(-Inf,4.0)), entireinterval())

    @test isequalinterval(-(interval(-Inf,2.0), interval(3.0,4.0)), interval(-Inf,-1.0))

    @test isequalinterval(-(interval(-Inf,2.0), interval(3.0,Inf)), interval(-Inf,-1.0))

    @test isequalinterval(-(interval(1.0,2.0), interval(-Inf,4.0)), interval(-3.0,Inf))

    @test isequalinterval(-(interval(1.0,2.0), interval(3.0,4.0)), interval(-3.0,-1.0))

    @test isequalinterval(-(interval(1.0,2.0), interval(3.0,Inf)), interval(-Inf,-1.0))

    @test isequalinterval(-(interval(1.0,Inf), interval(-Inf,4.0)), interval(-3.0,Inf))

    @test isequalinterval(-(interval(1.0,Inf), interval(3.0,4.0)), interval(-3.0,Inf))

    @test isequalinterval(-(interval(1.0,Inf), interval(3.0,Inf)), entireinterval())

    @test isequalinterval(-(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(-3.0,4.0)), interval(-3.0,Inf))

    @test isequalinterval(-(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(3.0,4.0)), interval(-Inf,-1.0))

    @test isequalinterval(-(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(-0x1.FFFFFFFFFFFFFp1023,4.0)), entireinterval())

    @test isequalinterval(-(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(0.0,0.0)), interval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(-(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(-0.0,-0.0)), interval(1.0,0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(-(interval(0.0,0.0), interval(-3.0,4.0)), interval(-4.0,3.0))

    @test isequalinterval(-(interval(-0.0,-0.0), interval(-3.0,0x1.FFFFFFFFFFFFFp1023)), interval(-0x1.FFFFFFFFFFFFFp1023,3.0))

    @test isequalinterval(-(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(0x1.E666666666656P+0,0x1.E666666666657P+0))

    @test isequalinterval(-(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)), interval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1))

    @test isequalinterval(-(interval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(-0x1.0CCCCCCCCCCC5P+1,0x1.E666666666657P+0))

end

@testset "minimal_sub_dec_test" begin

    @test isequalinterval(-(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), com)), DecoratedInterval(interval(-6.0,-3.0), com))

    @test isequalinterval(-(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), def)), DecoratedInterval(interval(-6.0,-3.0), def))

    @test isequalinterval(-(DecoratedInterval(interval(-1.0,2.0), com), DecoratedInterval(interval(5.0,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(-Inf,-3.0), dac))

    @test isequalinterval(-(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), DecoratedInterval(interval(-1.0, 5.0), com)), DecoratedInterval(interval(-Inf,3.0), dac))

    @test isequalinterval(-(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isnai(-(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_mul_test" begin

    @test isequalinterval(*(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(*(interval(-1.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(*(emptyinterval(), interval(-1.0,1.0)), emptyinterval())

    @test isequalinterval(*(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(*(entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(*(interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(*(emptyinterval(), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(*(interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(*(emptyinterval(), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(*(entireinterval(), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(entireinterval(), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(entireinterval(), interval(-5.0, -1.0)), entireinterval())

    @test isequalinterval(*(entireinterval(), interval(-5.0, 3.0)), entireinterval())

    @test isequalinterval(*(entireinterval(), interval(1.0, 3.0)), entireinterval())

    @test isequalinterval(*(entireinterval(), interval(-Inf, -1.0)), entireinterval())

    @test isequalinterval(*(entireinterval(), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(*(entireinterval(), interval(-5.0, Inf)), entireinterval())

    @test isequalinterval(*(entireinterval(), interval(1.0, Inf)), entireinterval())

    @test isequalinterval(*(entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(1.0,Inf), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(1.0,Inf), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(1.0,Inf), interval(-5.0, -1.0)), interval(-Inf,-1.0))

    @test isequalinterval(*(interval(1.0,Inf), interval(-5.0, 3.0)), entireinterval())

    @test isequalinterval(*(interval(1.0,Inf), interval(1.0, 3.0)), interval(1.0,Inf))

    @test isequalinterval(*(interval(1.0,Inf), interval(-Inf, -1.0)), interval(-Inf,-1.0))

    @test isequalinterval(*(interval(1.0,Inf), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(*(interval(1.0,Inf), interval(-5.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(1.0,Inf), interval(1.0, Inf)), interval(1.0,Inf))

    @test isequalinterval(*(interval(1.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(-1.0,Inf), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-1.0,Inf), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-1.0,Inf), interval(-5.0, -1.0)), interval(-Inf,5.0))

    @test isequalinterval(*(interval(-1.0,Inf), interval(-5.0, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-1.0,Inf), interval(1.0, 3.0)), interval(-3.0,Inf))

    @test isequalinterval(*(interval(-1.0,Inf), interval(-Inf, -1.0)), entireinterval())

    @test isequalinterval(*(interval(-1.0,Inf), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-1.0,Inf), interval(-5.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-1.0,Inf), interval(1.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-1.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(-Inf,3.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-Inf,3.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-Inf,3.0), interval(-5.0, -1.0)), interval(-15.0,Inf))

    @test isequalinterval(*(interval(-Inf,3.0), interval(-5.0, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-Inf,3.0), interval(1.0, 3.0)), interval(-Inf,9.0))

    @test isequalinterval(*(interval(-Inf,3.0), interval(-Inf, -1.0)), entireinterval())

    @test isequalinterval(*(interval(-Inf,3.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-Inf,3.0), interval(-5.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-Inf,3.0), interval(1.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-Inf,3.0), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(-Inf,-3.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-Inf,-3.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-Inf,-3.0), interval(-5.0, -1.0)), interval(3.0,Inf))

    @test isequalinterval(*(interval(-Inf,-3.0), interval(-5.0, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-Inf,-3.0), interval(1.0, 3.0)), interval(-Inf,-3.0))

    @test isequalinterval(*(interval(-Inf,-3.0), interval(-Inf, -1.0)), interval(3.0,Inf))

    @test isequalinterval(*(interval(-Inf,-3.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-Inf,-3.0), interval(-5.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-Inf,-3.0), interval(1.0, Inf)), interval(-Inf,-3.0))

    @test isequalinterval(*(interval(-Inf,-3.0), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(0.0,0.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(-5.0, -1.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(-5.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(1.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(-Inf, -1.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(-Inf, 3.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(-5.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), interval(1.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(*(interval(0.0,0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(-5.0, -1.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(-5.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(1.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(-Inf, -1.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(-Inf, 3.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(-5.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), interval(1.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-0.0,-0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(-5.0, -1.0)), interval(-25.0,-1.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(-5.0, 3.0)), interval(-25.0,15.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(1.0, 3.0)), interval(1.0,15.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(-Inf, -1.0)), interval(-Inf,-1.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(-Inf, 3.0)), interval(-Inf,15.0))

    @test isequalinterval(*(interval(1.0,5.0), interval(-5.0, Inf)), interval(-25.0,Inf))

    @test isequalinterval(*(interval(1.0,5.0), interval(1.0, Inf)), interval(1.0,Inf))

    @test isequalinterval(*(interval(1.0,5.0), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(-1.0,5.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-1.0,5.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-1.0,5.0), interval(-5.0, -1.0)), interval(-25.0,5.0))

    @test isequalinterval(*(interval(-1.0,5.0), interval(-5.0, 3.0)), interval(-25.0,15.0))

    @test isequalinterval(*(interval(-10.0,2.0), interval(-5.0, 3.0)), interval(-30.0,50.0))

    @test isequalinterval(*(interval(-1.0,5.0), interval(-1.0, 10.0)), interval(-10.0,50.0))

    @test isequalinterval(*(interval(-2.0,2.0), interval(-5.0, 3.0)), interval(-10.0,10.0))

    @test isequalinterval(*(interval(-1.0,5.0), interval(1.0, 3.0)), interval(-3.0,15.0))

    @test isequalinterval(*(interval(-1.0,5.0), interval(-Inf, -1.0)), entireinterval())

    @test isequalinterval(*(interval(-1.0,5.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(*(interval(-1.0,5.0), interval(-5.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-1.0,5.0), interval(1.0, Inf)), entireinterval())

    @test isequalinterval(*(interval(-1.0,5.0), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(-10.0,-5.0), interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(-5.0, -1.0)), interval(5.0,50.0))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(-5.0, 3.0)), interval(-30.0,50.0))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(1.0, 3.0)), interval(-30.0,-5.0))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(-Inf, -1.0)), interval(5.0,Inf))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(-Inf, 3.0)), interval(-30.0,Inf))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(-5.0, Inf)), interval(-Inf,50.0))

    @test isequalinterval(*(interval(-10.0,-5.0), interval(1.0, Inf)), interval(-Inf,-5.0))

    @test isequalinterval(*(interval(-10.0,-5.0), entireinterval()), entireinterval())

    @test isequalinterval(*(interval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), interval(-0x1.FFFFFFFFFFFFP+0, Inf)), interval(-0x1.FFFFFFFFFFFE1P+1,Inf))

    @test isequalinterval(*(interval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), interval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4)), interval(-0x1.FFFFFFFFFFFE1P+1,0x1.999999999998EP-3))

    @test isequalinterval(*(interval(-0x1.999999999999AP-4,0x1.999999999999AP-4), interval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)), interval(-0x1.999999999998EP-3,0x1.999999999998EP-3))

    @test isequalinterval(*(interval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4), interval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)), interval(-0x1.FFFFFFFFFFFE1P+1,-0x1.47AE147AE147BP-7))

end

@testset "minimal_mul_dec_test" begin

    @test isequalinterval(*(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), com)), DecoratedInterval(interval(5.0,14.0), com))

    @test isequalinterval(*(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), def)), DecoratedInterval(interval(5.0,14.0), def))

    @test isequalinterval(*(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(5.0,Inf), dac))

    @test isequalinterval(*(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), DecoratedInterval(interval(-1.0, 5.0), com)), DecoratedInterval(interval(-Inf,0x1.FFFFFFFFFFFFFp1023), dac))

    @test isequalinterval(*(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isnai(*(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_div_test" begin

    @test isequalinterval(/(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(/(interval(-1.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(/(emptyinterval(), interval(-1.0,1.0)), emptyinterval())

    @test isequalinterval(/(emptyinterval(), interval(0.1,1.0)), emptyinterval())

    @test isequalinterval(/(emptyinterval(), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(/(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(/(entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(/(interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(/(emptyinterval(), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(/(emptyinterval(), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(entireinterval(), interval(-5.0, -3.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(3.0, 5.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-Inf, -3.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(3.0,Inf)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(entireinterval(), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(entireinterval(), interval(-3.0, 0.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-3.0, -0.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(0.0, 3.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-Inf, 0.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-0.0, 3.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-Inf, -0.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(0.0, Inf)), entireinterval())

    @test isequalinterval(/(entireinterval(), interval(-0.0, Inf)), entireinterval())

    @test isequalinterval(/(entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-5.0, -3.0)), interval(3.0,10.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(3.0, 5.0)), interval(-10.0,-3.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-Inf, -3.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(3.0,Inf)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-3.0, 0.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-3.0, -0.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,-15.0), interval(0.0, 3.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-Inf, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-0.0, 3.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-Inf, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-30.0,-15.0), interval(0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,-15.0), interval(-0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,-15.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-5.0, -3.0)), interval(-5.0,10.0))

    @test isequalinterval(/(interval(-30.0,15.0), interval(3.0, 5.0)), interval(-10.0,5.0))

    @test isequalinterval(/(interval(-30.0,15.0), interval(-Inf, -3.0)), interval(-5.0,10.0))

    @test isequalinterval(/(interval(-30.0,15.0), interval(3.0,Inf)), interval(-10.0,5.0))

    @test isequalinterval(/(interval(-30.0,15.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-3.0, 0.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-3.0, -0.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(0.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-Inf, 0.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-0.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-Inf, -0.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(0.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), interval(-0.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-30.0,15.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(15.0,30.0), interval(-5.0, -3.0)), interval(-10.0,-3.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(3.0, 5.0)), interval(3.0,10.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(-Inf, -3.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(3.0,Inf)), interval(0.0,10.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(15.0,30.0), interval(-3.0, 0.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(15.0,30.0), interval(-3.0, -0.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(15.0,30.0), interval(0.0, 3.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(15.0,30.0), interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(-0.0, 3.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(15.0,30.0), interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(15.0,30.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(15.0,30.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(15.0,30.0), interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(15.0,30.0), interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(15.0,30.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(0.0,0.0), interval(-5.0, -3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(3.0, 5.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-Inf, -3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(3.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(0.0,0.0), interval(-3.0, 0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(0.0,0.0), interval(-3.0, -0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-3.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(0.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-Inf, 0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-0.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-Inf, -0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-Inf, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-3.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(0.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), interval(-0.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(0.0,0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-5.0, -3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(3.0, 5.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-Inf, -3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(3.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-3.0, 0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-3.0, -0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-3.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(0.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-Inf, 0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-0.0, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-Inf, -0.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-Inf, 3.0)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-3.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(0.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), interval(-0.0, Inf)), interval(0.0,0.0))

    @test isequalinterval(/(interval(-0.0,-0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-5.0, -3.0)), interval(3.0,Inf))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(3.0, 5.0)), interval(-Inf,-3.0))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-Inf, -3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(3.0,Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-3.0, 0.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-3.0, -0.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,-15.0), interval(0.0, 3.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-Inf, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-0.0, 3.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-Inf, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-Inf,-15.0), interval(0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-15.0), interval(-0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-15.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-5.0, -3.0)), interval(-5.0,Inf))

    @test isequalinterval(/(interval(-Inf,15.0), interval(3.0, 5.0)), interval(-Inf,5.0))

    @test isequalinterval(/(interval(-Inf,15.0), interval(-Inf, -3.0)), interval(-5.0,Inf))

    @test isequalinterval(/(interval(-Inf,15.0), interval(3.0,Inf)), interval(-Inf,5.0))

    @test isequalinterval(/(interval(-Inf,15.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-3.0, 0.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-3.0, -0.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(0.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-Inf, 0.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-0.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-Inf, -0.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(0.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), interval(-0.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-Inf,15.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-5.0, -3.0)), interval(-Inf,5.0))

    @test isequalinterval(/(interval(-15.0,Inf), interval(3.0, 5.0)), interval(-5.0,Inf))

    @test isequalinterval(/(interval(-15.0,Inf), interval(-Inf, -3.0)), interval(-Inf,5.0))

    @test isequalinterval(/(interval(-15.0,Inf), interval(3.0,Inf)), interval(-5.0,Inf))

    @test isequalinterval(/(interval(-15.0,Inf), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-3.0, 0.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-3.0, -0.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(0.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-Inf, 0.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-0.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-Inf, -0.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(0.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), interval(-0.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-15.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(15.0,Inf), interval(-5.0, -3.0)), interval(-Inf,-3.0))

    @test isequalinterval(/(interval(15.0,Inf), interval(3.0, 5.0)), interval(3.0,Inf))

    @test isequalinterval(/(interval(15.0,Inf), interval(-Inf, -3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(15.0,Inf), interval(3.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(15.0,Inf), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(15.0,Inf), interval(-3.0, 0.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(15.0,Inf), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(15.0,Inf), interval(-3.0, -0.0)), interval(-Inf,-5.0))

    @test isequalinterval(/(interval(15.0,Inf), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(15.0,Inf), interval(0.0, 3.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(15.0,Inf), interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(15.0,Inf), interval(-0.0, 3.0)), interval(5.0,Inf))

    @test isequalinterval(/(interval(15.0,Inf), interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(15.0,Inf), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(15.0,Inf), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(15.0,Inf), interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(15.0,Inf), interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(15.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-30.0,0.0), interval(-5.0, -3.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(3.0, 5.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-Inf, -3.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(3.0,Inf)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,0.0), interval(-3.0, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,0.0), interval(-3.0, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,0.0), interval(0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-Inf, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-Inf, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,0.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-30.0,0.0), interval(0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,0.0), interval(-0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-5.0, -3.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(3.0, 5.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-Inf, -3.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(3.0,Inf)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-3.0, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-3.0, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,-0.0), interval(0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-Inf, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-Inf, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-30.0,-0.0), interval(0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,-0.0), interval(-0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-30.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(0.0,30.0), interval(-5.0, -3.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(3.0, 5.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(-Inf, -3.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(3.0,Inf)), interval(0.0,10.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(0.0,30.0), interval(-3.0, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(0.0,30.0), interval(-3.0, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(0.0,30.0), interval(0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,30.0), interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(-0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,30.0), interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,30.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(0.0,30.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(0.0,30.0), interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,30.0), interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,30.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-0.0,30.0), interval(-5.0, -3.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(3.0, 5.0)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-Inf, -3.0)), interval(-10.0,0.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(3.0,Inf)), interval(0.0,10.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,30.0), interval(-3.0, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,30.0), interval(-3.0, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-0.0,30.0), interval(0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-0.0,30.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-0.0,30.0), interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,30.0), interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,30.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-Inf,0.0), interval(-5.0, -3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,0.0), interval(3.0, 5.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-Inf, -3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,0.0), interval(3.0,Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,0.0), interval(-3.0, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,0.0), interval(-3.0, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,0.0), interval(0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-Inf, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-Inf, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,0.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-Inf,0.0), interval(0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,0.0), interval(-0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,0.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-5.0, -3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(3.0, 5.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-Inf, -3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(3.0,Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-3.0, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-3.0, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,-0.0), interval(0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-Inf, 0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-0.0, 3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-Inf, -0.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-Inf,-0.0), interval(0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-0.0), interval(-0.0, Inf)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-Inf,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(0.0,Inf), interval(-5.0, -3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,Inf), interval(3.0, 5.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,Inf), interval(-Inf, -3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,Inf), interval(3.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,Inf), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(0.0,Inf), interval(-3.0, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,Inf), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(0.0,Inf), interval(-3.0, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,Inf), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(0.0,Inf), interval(0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,Inf), interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,Inf), interval(-0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,Inf), interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(0.0,Inf), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(0.0,Inf), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(0.0,Inf), interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,Inf), interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(0.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-0.0,Inf), interval(-5.0, -3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,Inf), interval(3.0, 5.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-Inf, -3.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,Inf), interval(3.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,Inf), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,Inf), interval(-3.0, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(/(interval(-0.0,Inf), interval(-3.0, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-3.0, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-0.0,Inf), interval(0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-0.0, 3.0)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-Inf, 3.0)), entireinterval())

    @test isequalinterval(/(interval(-0.0,Inf), interval(-3.0, Inf)), entireinterval())

    @test isequalinterval(/(interval(-0.0,Inf), interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,Inf), interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(/(interval(-0.0,Inf), entireinterval()), entireinterval())

    @test isequalinterval(/(interval(-2.0,-1.0), interval(-10.0, -3.0)), interval(0x1.9999999999999P-4,0x1.5555555555556P-1))

    @test isequalinterval(/(interval(-2.0,-1.0), interval(0.0, 10.0)), interval(-Inf,-0x1.9999999999999P-4))

    @test isequalinterval(/(interval(-2.0,-1.0), interval(-0.0, 10.0)), interval(-Inf,-0x1.9999999999999P-4))

    @test isequalinterval(/(interval(-1.0,2.0), interval(10.0,Inf)), interval(-0x1.999999999999AP-4,0x1.999999999999AP-3))

    @test isequalinterval(/(interval(1.0,3.0), interval(-Inf, -10.0)), interval(-0x1.3333333333334P-2,0.0))

    @test isequalinterval(/(interval(-Inf,-1.0), interval(1.0, 3.0)), interval(-Inf,-0x1.5555555555555P-2))

end

@testset "minimal_div_dec_test" begin

    @test isequalinterval(/(DecoratedInterval(interval(-2.0,-1.0), com), DecoratedInterval(interval(-10.0, -3.0), com)), DecoratedInterval(interval(0x1.9999999999999P-4,0x1.5555555555556P-1), com))

    @test isequalinterval(/(DecoratedInterval(interval(-200.0,-1.0), com), DecoratedInterval(interval(0x0.0000000000001p-1022, 10.0), com)), DecoratedInterval(interval(-Inf,-0x1.9999999999999P-4), dac))

    @test isequalinterval(/(DecoratedInterval(interval(-2.0,-1.0), com), DecoratedInterval(interval(0.0, 10.0), com)), DecoratedInterval(interval(-Inf,-0x1.9999999999999P-4), trv))

    @test isequalinterval(/(DecoratedInterval(interval(1.0,3.0), def), DecoratedInterval(interval(-Inf, -10.0), dac)), DecoratedInterval(interval(-0x1.3333333333334P-2,0.0), def))

    @test isequalinterval(/(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isnai(/(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_recip_test" begin

    @test isequalinterval(inv(interval(-50.0, -10.0)), interval(-0x1.999999999999AP-4,-0x1.47AE147AE147AP-6))

    @test isequalinterval(inv(interval(10.0, 50.0)), interval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4))

    @test isequalinterval(inv(interval(-Inf, -10.0)), interval(-0x1.999999999999AP-4,0.0))

    @test isequalinterval(inv(interval(10.0,Inf)), interval(0.0,0x1.999999999999AP-4))

    @test isequalinterval(inv(interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(inv(interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(inv(interval(-10.0, 0.0)), interval(-Inf,-0x1.9999999999999P-4))

    @test isequalinterval(inv(interval(-10.0, -0.0)), interval(-Inf,-0x1.9999999999999P-4))

    @test isequalinterval(inv(interval(-10.0, 10.0)), entireinterval())

    @test isequalinterval(inv(interval(0.0, 10.0)), interval(0x1.9999999999999P-4,Inf))

    @test isequalinterval(inv(interval(-0.0, 10.0)), interval(0x1.9999999999999P-4,Inf))

    @test isequalinterval(inv(interval(-Inf, 0.0)), interval(-Inf,0.0))

    @test isequalinterval(inv(interval(-Inf, -0.0)), interval(-Inf,0.0))

    @test isequalinterval(inv(interval(-Inf, 10.0)), entireinterval())

    @test isequalinterval(inv(interval(-10.0, Inf)), entireinterval())

    @test isequalinterval(inv(interval(0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(inv(interval(-0.0, Inf)), interval(0.0,Inf))

    @test isequalinterval(inv(entireinterval()), entireinterval())

end

@testset "minimal_recip_dec_test" begin

    @test isequalinterval(inv(DecoratedInterval(interval(10.0, 50.0), com)), DecoratedInterval(interval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4), com))

    @test isequalinterval(inv(DecoratedInterval(interval(-Inf, -10.0), dac)), DecoratedInterval(interval(-0x1.999999999999AP-4,0.0), dac))

    @test isequalinterval(inv(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023, -0x0.0000000000001p-1022), def)), DecoratedInterval(interval(-Inf,-0x0.4P-1022), def))

    @test isequalinterval(inv(DecoratedInterval(interval(0.0,0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(inv(DecoratedInterval(interval(-10.0, 0.0), com)), DecoratedInterval(interval(-Inf,-0x1.9999999999999P-4), trv))

    @test isequalinterval(inv(DecoratedInterval(interval(-10.0, Inf), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(inv(DecoratedInterval(interval(-0.0, Inf), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(inv(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), trv))

end

@testset "minimal_sqr_test" begin

    @test isequalinterval(emptyinterval()^2, emptyinterval())

    @test isequalinterval(entireinterval()^2, interval(0.0,Inf))

    @test isequalinterval(interval(-Inf,-0x0.0000000000001p-1022)^2, interval(0.0,Inf))

    @test isequalinterval(interval(-1.0,1.0)^2, interval(0.0,1.0))

    @test isequalinterval(interval(0.0,1.0)^2, interval(0.0,1.0))

    @test isequalinterval(interval(-0.0,1.0)^2, interval(0.0,1.0))

    @test isequalinterval(interval(-5.0,3.0)^2, interval(0.0,25.0))

    @test isequalinterval(interval(-5.0,0.0)^2, interval(0.0,25.0))

    @test isequalinterval(interval(-5.0,-0.0)^2, interval(0.0,25.0))

    @test isequalinterval(interval(0x1.999999999999AP-4,0x1.999999999999AP-4)^2, interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7))

    @test isequalinterval(interval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)^2, interval(0.0,0x1.FFFFFFFFFFFE1P+1))

    @test isequalinterval(interval(-0x1.FFFFFFFFFFFFP+0,-0x1.FFFFFFFFFFFFP+0)^2, interval(0x1.FFFFFFFFFFFEP+1,0x1.FFFFFFFFFFFE1P+1))

end

@testset "minimal_sqr_dec_test" begin

    @test isequalinterval(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x0.0000000000001p-1022), com)^2, DecoratedInterval(interval(0.0,Inf), dac))

    @test isequalinterval(DecoratedInterval(interval(-1.0,1.0), def)^2, DecoratedInterval(interval(0.0,1.0), def))

    @test isequalinterval(DecoratedInterval(interval(-5.0,3.0), com)^2, DecoratedInterval(interval(0.0,25.0), com))

    @test isequalinterval(DecoratedInterval(interval(0x1.999999999999AP-4,0x1.999999999999AP-4), com)^2, DecoratedInterval(interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), com))

end

@testset "minimal_sqrt_test" begin

    @test isequalinterval(sqrt(emptyinterval()), emptyinterval())

    @test isequalinterval(sqrt(entireinterval()), interval(0.0,Inf))

    @test isequalinterval(sqrt(interval(-Inf,-0x0.0000000000001p-1022)), emptyinterval())

    @test isequalinterval(sqrt(interval(-1.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(sqrt(interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(sqrt(interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(sqrt(interval(-5.0,25.0)), interval(0.0,5.0))

    @test isequalinterval(sqrt(interval(0.0,25.0)), interval(0.0,5.0))

    @test isequalinterval(sqrt(interval(-0.0,25.0)), interval(0.0,5.0))

    @test isequalinterval(sqrt(interval(-5.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(sqrt(interval(0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(0x1.43D136248490FP-2,0x1.43D136248491P-2))

    @test isequalinterval(sqrt(interval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)), interval(0.0,0x1.43D136248491P-2))

    @test isequalinterval(sqrt(interval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)), interval(0x1.43D136248490FP-2,0x1.6A09E667F3BC7P+0))

end

@testset "minimal_sqrt_dec_test" begin

    @test isequalinterval(sqrt(DecoratedInterval(interval(1.0,4.0), com)), DecoratedInterval(interval(1.0,2.0), com))

    @test isequalinterval(sqrt(DecoratedInterval(interval(-5.0,25.0), com)), DecoratedInterval(interval(0.0,5.0), trv))

    @test isequalinterval(sqrt(DecoratedInterval(interval(0.0,25.0), def)), DecoratedInterval(interval(0.0,5.0), def))

    @test isequalinterval(sqrt(DecoratedInterval(interval(-5.0,Inf), dac)), DecoratedInterval(interval(0.0,Inf), trv))

end

@testset "minimal_fma_test" begin

    @test isequalinterval(fma(emptyinterval(), emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,1.0), emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-1.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,Inf), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(1.0,5.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,2.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-1.0, 10.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-2.0,2.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, -1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, 3.0), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), emptyinterval(), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,1.0), emptyinterval(), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-1.0,1.0), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), entireinterval(), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(entireinterval(), emptyinterval(), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), emptyinterval(), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), emptyinterval(), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(0.0,0.0), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-0.0,-0.0), interval(-Inf,2.0)), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(entireinterval(), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(entireinterval(), interval(-5.0, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, -1.0), interval(-Inf,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,7.0))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,11.0))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,-1.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, Inf), interval(-Inf,2.0)), interval(-Inf,-1.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, -1.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, 3.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, Inf), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, Inf), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), entireinterval(), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, -1.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, 3.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, Inf), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, Inf), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), entireinterval(), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,17.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,17.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, -1.0), interval(-Inf,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, 3.0), interval(-Inf,2.0)), interval(-Inf,17.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,7.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,17.0))

    @test isequalinterval(fma(interval(-10.0,2.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,52.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-1.0, 10.0), interval(-Inf,2.0)), interval(-Inf,52.0))

    @test isequalinterval(fma(interval(-2.0,2.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,12.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,17.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, Inf), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(0.0,0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-0.0,-0.0), interval(-Inf,2.0)), interval(-Inf,2.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, -1.0), interval(-Inf,2.0)), interval(-Inf,52.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, 3.0), interval(-Inf,2.0)), interval(-Inf,52.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, 3.0), interval(-Inf,2.0)), interval(-Inf,-3.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, -1.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, 3.0), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, Inf), interval(-Inf,2.0)), interval(-Inf,52.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, Inf), interval(-Inf,2.0)), interval(-Inf,-3.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), entireinterval(), interval(-Inf,2.0)), entireinterval())

    @test isequalinterval(fma(emptyinterval(), emptyinterval(), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,1.0), emptyinterval(), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-1.0,1.0), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), entireinterval(), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(entireinterval(), emptyinterval(), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), emptyinterval(), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), emptyinterval(), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(0.0,0.0), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-0.0,-0.0), interval(-2.0,2.0)), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(entireinterval(), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(entireinterval(), interval(-5.0, -1.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, -1.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(entireinterval(), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, -1.0), interval(-2.0,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, Inf), interval(-2.0,2.0)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,Inf), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-Inf,7.0))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-5.0,Inf))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, -1.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-17.0,Inf))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-Inf,11.0))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, -1.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(1.0,Inf))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-Inf,-1.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, -1.0), interval(-2.0,2.0)), interval(1.0,Inf))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, Inf), interval(-2.0,2.0)), interval(-Inf,-1.0))

    @test isequalinterval(fma(interval(-Inf,-3.0), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, -1.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, 3.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, Inf), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, Inf), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(0.0,0.0), entireinterval(), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, -1.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, 3.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, Inf), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, Inf), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-0.0,-0.0), entireinterval(), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-27.0,1.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-27.0,17.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-1.0,17.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, -1.0), interval(-2.0,2.0)), interval(-Inf,1.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, 3.0), interval(-2.0,2.0)), interval(-Inf,17.0))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, Inf), interval(-2.0,2.0)), interval(-27.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, Inf), interval(-2.0,2.0)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(-27.0,7.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-27.0,17.0))

    @test isequalinterval(fma(interval(-10.0,2.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-32.0,52.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-1.0, 10.0), interval(-2.0,2.0)), interval(-12.0,52.0))

    @test isequalinterval(fma(interval(-2.0,2.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-12.0,12.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-5.0,17.0))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, -1.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, 3.0), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, Inf), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(0.0,0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-0.0,-0.0), interval(-2.0,2.0)), interval(-2.0,2.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, -1.0), interval(-2.0,2.0)), interval(3.0,52.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, 3.0), interval(-2.0,2.0)), interval(-32.0,52.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, 3.0), interval(-2.0,2.0)), interval(-32.0,-3.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, -1.0), interval(-2.0,2.0)), interval(3.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, 3.0), interval(-2.0,2.0)), interval(-32.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, Inf), interval(-2.0,2.0)), interval(-Inf,52.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, Inf), interval(-2.0,2.0)), interval(-Inf,-3.0))

    @test isequalinterval(fma(interval(-10.0,-5.0), entireinterval(), interval(-2.0,2.0)), entireinterval())

    @test isequalinterval(fma(emptyinterval(), emptyinterval(), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,1.0), emptyinterval(), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-1.0,1.0), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), entireinterval(), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(entireinterval(), emptyinterval(), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), emptyinterval(), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), emptyinterval(), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(0.0,0.0), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-0.0,-0.0), interval(-2.0,Inf)), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(entireinterval(), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(entireinterval(), interval(-5.0, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(entireinterval(), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, Inf), interval(-2.0,Inf)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,Inf), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-5.0,Inf))

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(-17.0,Inf))

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, -1.0), interval(-2.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, -1.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, 3.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, Inf), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, Inf), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(0.0,0.0), entireinterval(), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, -1.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, 3.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, Inf), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, Inf), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-0.0,-0.0), entireinterval(), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(-27.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-27.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, Inf), interval(-2.0,Inf)), interval(-27.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, Inf), interval(-2.0,Inf)), interval(-1.0,Inf))

    @test isequalinterval(fma(interval(1.0,5.0), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(-27.0,Inf))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-27.0,Inf))

    @test isequalinterval(fma(interval(-10.0,2.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-32.0,Inf))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-1.0, 10.0), interval(-2.0,Inf)), interval(-12.0,Inf))

    @test isequalinterval(fma(interval(-2.0,2.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-12.0,Inf))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-5.0,Inf))

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, -1.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, 3.0), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(0.0,0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-0.0,-0.0), interval(-2.0,Inf)), interval(-2.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, -1.0), interval(-2.0,Inf)), interval(3.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, 3.0), interval(-2.0,Inf)), interval(-32.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, 3.0), interval(-2.0,Inf)), interval(-32.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, -1.0), interval(-2.0,Inf)), interval(3.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, 3.0), interval(-2.0,Inf)), interval(-32.0,Inf))

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, Inf), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), entireinterval(), interval(-2.0,Inf)), entireinterval())

    @test isequalinterval(fma(emptyinterval(), emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-1.0,1.0), emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-1.0,1.0), entireinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), entireinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(fma(interval(0.0,0.0), emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(0.0,0.0), entireinterval()), emptyinterval())

    @test isequalinterval(fma(emptyinterval(), interval(-0.0,-0.0), entireinterval()), emptyinterval())

    @test isequalinterval(fma(entireinterval(), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(entireinterval(), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,Inf), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,Inf), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,3.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-Inf,-3.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.0,0.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-0.0,-0.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(1.0,5.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,2.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-1.0, 10.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-2.0,2.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-1.0,5.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(0.0,0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-0.0,-0.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, -1.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-Inf, 3.0), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(-5.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), interval(1.0, Inf), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(-10.0,-5.0), entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(fma(interval(0.1,0.5), interval(-5.0, 3.0), interval(-0.1,0.1)), interval(-0x1.4CCCCCCCCCCCDP+1,0x1.999999999999AP+0))

    @test isequalinterval(fma(interval(-0.5,0.2), interval(-5.0, 3.0), interval(-0.1,0.1)), interval(-0x1.999999999999AP+0,0x1.4CCCCCCCCCCCDP+1))

    @test isequalinterval(fma(interval(-0.5,-0.1), interval(2.0, 3.0), interval(-0.1,0.1)), interval(-0x1.999999999999AP+0,-0x1.999999999999AP-4))

    @test isequalinterval(fma(interval(-0.5,-0.1), interval(-Inf, 3.0), interval(-0.1,0.1)), interval(-0x1.999999999999AP+0,Inf))

end

@testset "minimal_fma_dec_test" begin

    @test isequalinterval(fma(DecoratedInterval(interval(-0.5,-0.1), com), DecoratedInterval(interval(-Inf, 3.0), dac), DecoratedInterval(interval(-0.1,0.1), com)), DecoratedInterval(interval(-0x1.999999999999AP+0,Inf), dac))

    @test isequalinterval(fma(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(1.0, 0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(0.0,1.0), com)), DecoratedInterval(interval(1.0,Inf), dac))

    @test isequalinterval(fma(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(1.0, 2.0), com), DecoratedInterval(interval(2.0,5.0), com)), DecoratedInterval(interval(3.0,9.0), com))

end

@testset "minimal_pown_test" begin

    @test isequalinterval(^(emptyinterval(), 0), emptyinterval())

    @test isequalinterval(^(entireinterval(), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,0.0), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,-0.0), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(13.1,13.1), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-7451.145,-7451.145), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,Inf), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,Inf), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-Inf,0.0), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-Inf,-0.0), 0), interval(1.0,1.0))

    @test isequalinterval(^(interval(-324.3,2.5), 0), interval(1.0,1.0))

    @test isequalinterval(^(emptyinterval(), 2), emptyinterval())

    @test isequalinterval(^(entireinterval(), 2), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.0), 2), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), 2), interval(0.0,0.0))

    @test isequalinterval(^(interval(13.1,13.1), 2), interval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7))

    @test isequalinterval(^(interval(-7451.145,-7451.145), 2), interval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 2), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(^(interval(0.0,Inf), 2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), 2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), 2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,-0.0), 2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-324.3,2.5), 2), interval(0.0,0x1.9AD27D70A3D72P+16))

    @test isequalinterval(^(interval(0.01,2.33), 2), interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2))

    @test isequalinterval(^(interval(-1.9,-0.33), 2), interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1))

    @test isequalinterval(^(emptyinterval(), 8), emptyinterval())

    @test isequalinterval(^(entireinterval(), 8), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.0), 8), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), 8), interval(0.0,0.0))

    @test isequalinterval(^(interval(13.1,13.1), 8), interval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29))

    @test isequalinterval(^(interval(-7451.145,-7451.145), 8), interval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 8), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(^(interval(0.0,Inf), 8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), 8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), 8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,-0.0), 8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-324.3,2.5), 8), interval(0.0,0x1.A87587109655P+66))

    @test isequalinterval(^(interval(0.01,2.33), 8), interval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9))

    @test isequalinterval(^(interval(-1.9,-0.33), 8), interval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7))

    @test isequalinterval(^(emptyinterval(), 1), emptyinterval())

    @test isequalinterval(^(entireinterval(), 1), entireinterval())

    @test isequalinterval(^(interval(0.0,0.0), 1), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), 1), interval(0.0,0.0))

    @test isequalinterval(^(interval(13.1,13.1), 1), interval(13.1,13.1))

    @test isequalinterval(^(interval(-7451.145,-7451.145), 1), interval(-7451.145,-7451.145))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1), interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1), interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(^(interval(0.0,Inf), 1), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), 1), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), 1), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-Inf,-0.0), 1), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-324.3,2.5), 1), interval(-324.3,2.5))

    @test isequalinterval(^(interval(0.01,2.33), 1), interval(0.01,2.33))

    @test isequalinterval(^(interval(-1.9,-0.33), 1), interval(-1.9,-0.33))

    @test isequalinterval(^(emptyinterval(), 3), emptyinterval())

    @test isequalinterval(^(entireinterval(), 3), entireinterval())

    @test isequalinterval(^(interval(0.0,0.0), 3), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), 3), interval(0.0,0.0))

    @test isequalinterval(^(interval(13.1,13.1), 3), interval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11))

    @test isequalinterval(^(interval(-7451.145,-7451.145), 3), interval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3), interval(-Inf,-0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(^(interval(0.0,Inf), 3), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), 3), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), 3), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-Inf,-0.0), 3), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-324.3,2.5), 3), interval(-0x1.0436D2F418938P+25,0x1.F4P+3))

    @test isequalinterval(^(interval(0.01,2.33), 3), interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3))

    @test isequalinterval(^(interval(-1.9,-0.33), 3), interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5))

    @test isequalinterval(^(emptyinterval(), 7), emptyinterval())

    @test isequalinterval(^(entireinterval(), 7), entireinterval())

    @test isequalinterval(^(interval(0.0,0.0), 7), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), 7), interval(0.0,0.0))

    @test isequalinterval(^(interval(13.1,13.1), 7), interval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25))

    @test isequalinterval(^(interval(-7451.145,-7451.145), 7), interval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7), interval(-Inf,-0x1.FFFFFFFFFFFFFp1023))

    @test isequalinterval(^(interval(0.0,Inf), 7), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), 7), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), 7), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-Inf,-0.0), 7), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-324.3,2.5), 7), interval(-0x1.4F109959E6D7FP+58,0x1.312DP+9))

    @test isequalinterval(^(interval(0.01,2.33), 7), interval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8))

    @test isequalinterval(^(interval(-1.9,-0.33), 7), interval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12))

    @test isequalinterval(^(emptyinterval(), -2), emptyinterval())

    @test isequalinterval(^(entireinterval(), -2), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.0), -2), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), -2), emptyinterval())

    @test isequalinterval(^(interval(13.1,13.1), -2), interval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8))

    @test isequalinterval(^(interval(-7451.145,-7451.145), -2), interval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -2), interval(0x0P+0,0x0.0000000000001P-1022))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -2), interval(0x0P+0,0x0.0000000000001P-1022))

    @test isequalinterval(^(interval(0.0,Inf), -2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), -2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), -2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,-0.0), -2), interval(0.0,Inf))

    @test isequalinterval(^(interval(-324.3,2.5), -2), interval(0x1.3F0C482C977C9P-17,Inf))

    @test isequalinterval(^(interval(0.01,2.33), -2), interval(0x1.793D85EF38E47P-3,0x1.388P+13))

    @test isequalinterval(^(interval(-1.9,-0.33), -2), interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3))

    @test isequalinterval(^(emptyinterval(), -8), emptyinterval())

    @test isequalinterval(^(entireinterval(), -8), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.0), -8), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), -8), emptyinterval())

    @test isequalinterval(^(interval(13.1,13.1), -8), interval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30))

    @test isequalinterval(^(interval(-7451.145,-7451.145), -8), interval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -8), interval(0x0P+0,0x0.0000000000001P-1022))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -8), interval(0x0P+0,0x0.0000000000001P-1022))

    @test isequalinterval(^(interval(0.0,Inf), -8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), -8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), -8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,-0.0), -8), interval(0.0,Inf))

    @test isequalinterval(^(interval(-324.3,2.5), -8), interval(0x1.34CC3764D1E0CP-67,Inf))

    @test isequalinterval(^(interval(0.01,2.33), -8), interval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53))

    @test isequalinterval(^(interval(-1.9,-0.33), -8), interval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12))

    @test isequalinterval(^(emptyinterval(), -1), emptyinterval())

    @test isequalinterval(^(entireinterval(), -1), entireinterval())

    @test isequalinterval(^(interval(0.0,0.0), -1), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), -1), emptyinterval())

    @test isequalinterval(^(interval(13.1,13.1), -1), interval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4))

    @test isequalinterval(^(interval(-7451.145,-7451.145), -1), interval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -1), interval(0x0.4P-1022,0x0.4000000000001P-1022))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -1), interval(-0x0.4000000000001P-1022,-0x0.4P-1022))

    @test isequalinterval(^(interval(0.0,Inf), -1), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), -1), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), -1), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-Inf,-0.0), -1), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-324.3,2.5), -1), entireinterval())

    @test isequalinterval(^(interval(0.01,2.33), -1), interval(0x1.B77C278DBBE13P-2,0x1.9P+6))

    @test isequalinterval(^(interval(-1.9,-0.33), -1), interval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1))

    @test isequalinterval(^(emptyinterval(), -3), emptyinterval())

    @test isequalinterval(^(entireinterval(), -3), entireinterval())

    @test isequalinterval(^(interval(0.0,0.0), -3), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), -3), emptyinterval())

    @test isequalinterval(^(interval(13.1,13.1), -3), interval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12))

    @test isequalinterval(^(interval(-7451.145,-7451.145), -3), interval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -3), interval(0x0P+0,0x0.0000000000001P-1022))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -3), interval(-0x0.0000000000001P-1022,-0x0P+0))

    @test isequalinterval(^(interval(0.0,Inf), -3), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), -3), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), -3), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-Inf,-0.0), -3), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-324.3,2.5), -3), entireinterval())

    @test isequalinterval(^(interval(0.01,2.33), -3), interval(0x1.43CFBA61AACABP-4,0x1.E848P+19))

    @test isequalinterval(^(interval(-1.9,-0.33), -3), interval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3))

    @test isequalinterval(^(emptyinterval(), -7), emptyinterval())

    @test isequalinterval(^(entireinterval(), -7), entireinterval())

    @test isequalinterval(^(interval(0.0,0.0), -7), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), -7), emptyinterval())

    @test isequalinterval(^(interval(13.1,13.1), -7), interval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26))

    @test isequalinterval(^(interval(-7451.145,-7451.145), -7), interval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91))

    @test isequalinterval(^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -7), interval(0x0P+0,0x0.0000000000001P-1022))

    @test isequalinterval(^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -7), interval(-0x0.0000000000001P-1022,-0x0P+0))

    @test isequalinterval(^(interval(0.0,Inf), -7), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), -7), interval(0.0,Inf))

    @test isequalinterval(^(interval(-Inf,0.0), -7), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-Inf,-0.0), -7), interval(-Inf,0.0))

    @test isequalinterval(^(interval(-324.3,2.5), -7), entireinterval())

    @test isequalinterval(^(interval(0.01,2.33), -7), interval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46))

    @test isequalinterval(^(interval(-1.9,-0.33), -7), interval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7))

end

@testset "minimal_pown_dec_test" begin

    @test isequalinterval(^(DecoratedInterval(interval(-5.0,10.0), com), 0), DecoratedInterval(interval(1.0,1.0), com))

    @test isequalinterval(^(DecoratedInterval(interval(-Inf,15.0), dac), 0), DecoratedInterval(interval(1.0,1.0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-3.0,5.0), def), 2), DecoratedInterval(interval(0.0,25.0), def))

    @test isequalinterval(^(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), 2), DecoratedInterval(interval(0.0,Inf), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-3.0,5.0), dac), 3), DecoratedInterval(interval(-27.0,125.0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), 3), DecoratedInterval(interval(-Inf, 8.0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(3.0,5.0), com), -2), DecoratedInterval(interval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), com))

    @test isequalinterval(^(DecoratedInterval(interval(-5.0,-3.0), def), -2), DecoratedInterval(interval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), def))

    @test isequalinterval(^(DecoratedInterval(interval(-5.0,3.0), com), -2), DecoratedInterval(interval(0x1.47AE147AE147AP-5,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(3.0,5.0), dac), -3), DecoratedInterval(interval(0x1.0624DD2F1A9FBP-7 ,0x1.2F684BDA12F69P-5), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-3.0,5.0), com), -3), DecoratedInterval(entireinterval(), trv))

end

@testset "minimal_pow_test" begin

    @test isequalinterval(^(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(^(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(0.0,Inf)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-0.0,Inf)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(1.0,Inf)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-3.0,5.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(-5.0,-5.0)), emptyinterval())

    @test isequalinterval(^(emptyinterval(), interval(5.0,5.0)), emptyinterval())

    @test isequalinterval(^(interval(0.1,0.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.1,0.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.0,1.0)), interval(0x1.999999999999AP-4,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.0,1.0)), interval(0x1.999999999999AP-4,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.0,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.0,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.1,0.1)), interval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.1,1.0)), interval(0x1.999999999999AP-4,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.1,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(0.1,Inf)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(1.0,1.0)), interval(0x1.999999999999AP-4,0x1P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(1.0,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(1.0,Inf)), interval(0.0,0x1P-1))

    @test isequalinterval(^(interval(0.1,0.5), interval(2.5,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(0.1,0.5), interval(2.5,Inf)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.1,0.1)), interval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.1,1.0)), interval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.1,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.1,Inf)), interval(0.0,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,0.1)), interval(0x1.96B230BCDC434P-1,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,1.0)), interval(0x1.999999999999AP-4,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,Inf)), interval(0.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,0.1)), interval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,1.0)), interval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,Inf)), interval(0.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,0.1)), interval(0x1.96B230BCDC434P-1,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,1.0)), interval(0x1.999999999999AP-4,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,2.5)), interval(0x1.9E7C6E43390B7P-9,Inf))

    @test isequalinterval(^(interval(0.1,0.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,0.0)), interval(1.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,-0.0)), interval(1.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,0.0)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,-0.0)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-0.1,-0.1)), interval(0x1.125FBEE250664P+0,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,-0.1)), interval(0x1.125FBEE250664P+0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,-0.1)), interval(0x1.125FBEE250664P+0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-1.0,-1.0)), interval(0x1P+1,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,-1.0)), interval(0x1P+1,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(0.1,0.5), interval(-2.5,-2.5)), interval(0x1.6A09E667F3BCCP+2,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,0.5), interval(-Inf,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(0.1,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.1,1.0), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.0,1.0)), interval(0x1.999999999999AP-4,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.0,1.0)), interval(0x1.999999999999AP-4,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.0,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.0,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.1,0.1)), interval(0x1.96B230BCDC434P-1,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.1,1.0)), interval(0x1.999999999999AP-4,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.1,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(0.1,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(1.0,1.0)), interval(0x1.999999999999AP-4,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(1.0,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(1.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(2.5,2.5)), interval(0x1.9E7C6E43390B7P-9,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(2.5,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,0.1)), interval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,1.0)), interval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,Inf)), interval(0.0,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,0.1)), interval(0x1.96B230BCDC434P-1,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,1.0)), interval(0x1.999999999999AP-4,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,Inf)), interval(0.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,0.1)), interval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,1.0)), interval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,2.5)), interval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,Inf)), interval(0.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,0.1)), interval(0x1.96B230BCDC434P-1,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,1.0)), interval(0x1.999999999999AP-4,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,2.5)), interval(0x1.9E7C6E43390B7P-9,Inf))

    @test isequalinterval(^(interval(0.1,1.0), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,0.0)), interval(1.0,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,-0.0)), interval(1.0,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,0.0)), interval(1.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,-0.0)), interval(1.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,0.0)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,-0.0)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-0.1,-0.1)), interval(1.0,0x1.4248EF8FC2604P+0))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,-0.1)), interval(1.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,-0.1)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-1.0,-1.0)), interval(1.0,0x1.4P+3))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,-1.0)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.1,1.0), interval(-2.5,-2.5)), interval(1.0,0x1.3C3A4EDFA9758P+8))

    @test isequalinterval(^(interval(0.1,1.0), interval(-Inf,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.5,1.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.0,1.0)), interval(0.5,1.5))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.0,1.0)), interval(0.5,1.5))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.0,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.0,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.1,0.1)), interval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.1,1.0)), interval(0.5,1.5))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.1,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(1.0,1.0)), interval(0.5,1.5))

    @test isequalinterval(^(interval(0.5,1.5), interval(1.0,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(2.5,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.1,0.1)), interval(0x1.DDB680117AB12P-1,0x1.125FBEE250665P+0))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.1,1.0)), interval(0x1P-1,0x1.8P+0))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.1,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.1,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,0.1)), interval(0x1.5555555555555P-1,0x1P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,1.0)), interval(0x1P-1,0x1P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,0.1)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,1.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,2.5)), interval(0x1.6A09E667F3BCCP-3,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), entireinterval()), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,0.0)), interval(0x1.5555555555555P-1,0x1P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,-0.0)), interval(0x1.5555555555555P-1,0x1P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,0.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,-0.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,0.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,-0.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-0.1,-0.1)), interval(0x1.EBA7C9E4D31E9P-1,0x1.125FBEE250665P+0))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,-0.1)), interval(0x1.5555555555555P-1,0x1P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,-0.1)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,-0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-1.0,-1.0)), interval(0x1.5555555555555P-1,0x1P+1))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,-1.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,-1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,1.5), interval(-2.5,-2.5)), interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,1.5), interval(-Inf,-2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.5,Inf), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.0,1.0)), interval(0.5,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.0,1.0)), interval(0.5,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.0,2.5)), interval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.0,2.5)), interval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.1,0.1)), interval(0x1.DDB680117AB12P-1,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.1,1.0)), interval(0.5,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.1,2.5)), interval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(1.0,1.0)), interval(0.5,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(1.0,2.5)), interval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(2.5,2.5)), interval(0x1.6A09E667F3BCCP-3,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,0.0)), interval(0.0,0x1P+1))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,-0.0)), interval(0.0,0x1P+1))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,0.0)), interval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,-0.0)), interval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-0.1,-0.1)), interval(0.0,0x1.125FBEE250665P+0))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,-0.1)), interval(0.0,0x1P+1))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,-0.1)), interval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-1.0,-1.0)), interval(0.0,0x1P+1))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,-1.0)), interval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.5,Inf), interval(-2.5,-2.5)), interval(0.0,0x1.6A09E667F3BCDP+2))

    @test isequalinterval(^(interval(1.0,1.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(1.0,1.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.0,1.0)), interval(1.0,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.0,1.0)), interval(1.0,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.0,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.0,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.1,0.1)), interval(1.0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.1,1.0)), interval(1.0,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.1,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(0.1,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(1.0,1.0)), interval(1.0,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(1.0,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(1.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(2.5,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(2.5,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.1,0.1)), interval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.1,1.0)), interval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.1,2.5)), interval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.1,Inf)), interval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,0.1)), interval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,1.0)), interval(0x1.5555555555555P-1,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,2.5)), interval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,Inf)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,0.1)), interval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,1.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,2.5)), interval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,Inf)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,0.1)), interval(0x0P+0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,1.0)), interval(0x0P+0,0x1.8P+0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,2.5)), interval(0x0P+0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.0,1.5), entireinterval()), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,0.0)), interval(0x1.5555555555555P-1,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,-0.0)), interval(0x1.5555555555555P-1,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,0.0)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,-0.0)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-0.1,-0.1)), interval(0x1.EBA7C9E4D31E9P-1,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,-0.1)), interval(0x1.5555555555555P-1,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,-0.1)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,-0.1)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-1.0,-1.0)), interval(0x1.5555555555555P-1,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,-1.0)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,-1.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-2.5,-2.5)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.0,1.5), interval(-Inf,-2.5)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(1.0,Inf), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.0,1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.0,1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.0,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.0,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.1,0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.1,1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.1,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(0.1,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(1.0,1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(1.0,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(1.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(2.5,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(2.5,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.1,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.1,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.1,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.1,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), entireinterval()), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-0.1,-0.1)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,-0.1)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,-0.1)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,-0.1)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-1.0,-1.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,-1.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,-1.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-2.5,-2.5)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.0,Inf), interval(-Inf,-2.5)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,1.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(1.1,1.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.0,1.0)), interval(1.0,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.0,1.0)), interval(1.0,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.0,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.0,2.5)), interval(1.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.1,0.1)), interval(0x1.02739C65D58BFP+0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.1,1.0)), interval(0x1.02739C65D58BFP+0,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.1,2.5)), interval(0x1.02739C65D58BFP+0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(0.1,Inf)), interval(0x1.02739C65D58BFP+0,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(1.0,1.0)), interval(0x1.199999999999AP+0,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(1.0,2.5)), interval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(1.0,Inf)), interval(0x1.199999999999AP+0,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(2.5,2.5)), interval(0x1.44E1080833B25P+0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(2.5,Inf)), interval(0x1.44E1080833B25P+0,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.1,0.1)), interval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.1,1.0)), interval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.1,2.5)), interval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.1,Inf)), interval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,0.1)), interval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,1.0)), interval(0x1.5555555555555P-1,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,2.5)), interval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,Inf)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,0.1)), interval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,1.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,2.5)), interval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,Inf)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,0.1)), interval(0x0P+0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,1.0)), interval(0x0P+0,0x1.8P+0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,2.5)), interval(0x0P+0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(1.1,1.5), entireinterval()), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,0.0)), interval(0x1.5555555555555P-1,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,-0.0)), interval(0x1.5555555555555P-1,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,0.0)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,-0.0)), interval(0x1.7398BF1D1EE6FP-2,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,1.5), interval(-0.1,-0.1)), interval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,-0.1)), interval(0x1.5555555555555P-1,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,-0.1)), interval(0x1.7398BF1D1EE6FP-2,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,-0.1)), interval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-1.0,-1.0)), interval(0x1.5555555555555P-1,0x1.D1745D1745D17P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,-1.0)), interval(0x1.7398BF1D1EE6FP-2,0x1.D1745D1745D17P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,-1.0)), interval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-2.5,-2.5)), interval(0x1.7398BF1D1EE6FP-2,0x1.9372D999784C8P-1))

    @test isequalinterval(^(interval(1.1,1.5), interval(-Inf,-2.5)), interval(0x0P+0,0x1.9372D999784C8P-1))

    @test isequalinterval(^(interval(1.1,Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(1.1,Inf), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.0,1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.0,1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.0,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.0,2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.1,0.1)), interval(0x1.02739C65D58BFP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.1,1.0)), interval(0x1.02739C65D58BFP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.1,2.5)), interval(0x1.02739C65D58BFP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(0.1,Inf)), interval(0x1.02739C65D58BFP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(1.0,1.0)), interval(0x1.199999999999AP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(1.0,2.5)), interval(0x1.199999999999AP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(1.0,Inf)), interval(0x1.199999999999AP+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(2.5,2.5)), interval(0x1.44E1080833B25P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(2.5,Inf)), interval(0x1.44E1080833B25P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.1,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.1,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.1,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.1,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,Inf)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,0.1)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,1.0)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,2.5)), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), entireinterval()), interval(0x0P+0,Inf))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,-0.0)), interval(0x0P+0,1.0))

    @test isequalinterval(^(interval(1.1,Inf), interval(-0.1,-0.1)), interval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,-0.1)), interval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,-0.1)), interval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,-0.1)), interval(0x0P+0,0x1.FB24AF5281928P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-1.0,-1.0)), interval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,-1.0)), interval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,-1.0)), interval(0x0P+0,0x1.D1745D1745D17P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-2.5,-2.5)), interval(0x0P+0,0x1.9372D999784C8P-1))

    @test isequalinterval(^(interval(1.1,Inf), interval(-Inf,-2.5)), interval(0x0P+0,0x1.9372D999784C8P-1))

    @test isequalinterval(^(interval(0.0,0.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.1,0.1)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.1,1.0)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.1,2.5)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.0,0.5), interval(0.1,Inf)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(0.0,0.5), interval(1.0,1.0)), interval(0.0,0.5))

    @test isequalinterval(^(interval(0.0,0.5), interval(1.0,2.5)), interval(0.0,0.5))

    @test isequalinterval(^(interval(0.0,0.5), interval(1.0,Inf)), interval(0.0,0.5))

    @test isequalinterval(^(interval(0.0,0.5), interval(2.5,2.5)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(0.0,0.5), interval(2.5,Inf)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-0.1,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-1.0,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-2.5,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(0.0,0.5), interval(-Inf,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(0.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.0,1.0), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.1,0.1)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.1,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.1,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(0.1,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(1.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(1.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(1.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(2.5,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(2.5,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-0.1,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-1.0,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-2.5,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.0), interval(-Inf,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.0,1.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.1,0.1)), interval(0.0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.1,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.1,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.0,1.5), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(1.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(0.0,1.5), interval(1.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.0,1.5), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(2.5,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(0.0,1.5), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,0.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,-0.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,0.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,-0.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-0.1,-0.1)), interval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,-0.1)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,-0.1)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-1.0,-1.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,-1.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-2.5,-2.5)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(0.0,1.5), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.0,Inf), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-0.1,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-1.0,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,Inf), interval(-2.5,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.1,0.1)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.1,1.0)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.1,2.5)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.0,0.5), interval(0.1,Inf)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.0,0.5), interval(1.0,1.0)), interval(0.0,0.5))

    @test isequalinterval(^(interval(-0.0,0.5), interval(1.0,2.5)), interval(0.0,0.5))

    @test isequalinterval(^(interval(-0.0,0.5), interval(1.0,Inf)), interval(0.0,0.5))

    @test isequalinterval(^(interval(-0.0,0.5), interval(2.5,2.5)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(-0.0,0.5), interval(2.5,Inf)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-0.1,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-1.0,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-2.5,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(-0.0,0.5), interval(-Inf,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.1,0.1)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.1,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.1,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(0.1,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(1.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(1.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(1.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(2.5,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(2.5,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-0.1,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-1.0,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-2.5,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.0), interval(-Inf,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.1,0.1)), interval(0.0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.1,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.1,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.0,1.5), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(1.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.0,1.5), interval(1.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.0,1.5), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(2.5,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.0,1.5), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,0.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,-0.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,0.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,-0.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-0.1,-0.1)), interval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,-0.1)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,-0.1)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-1.0,-1.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,-1.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-2.5,-2.5)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.0,1.5), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-0.1,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-1.0,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.0,Inf), interval(-2.5,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.1,0.1)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.1,1.0)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.1,2.5)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.1,0.5), interval(0.1,Inf)), interval(0.0,0x1.DDB680117AB13P-1))

    @test isequalinterval(^(interval(-0.1,0.5), interval(1.0,1.0)), interval(0.0,0.5))

    @test isequalinterval(^(interval(-0.1,0.5), interval(1.0,2.5)), interval(0.0,0.5))

    @test isequalinterval(^(interval(-0.1,0.5), interval(1.0,Inf)), interval(0.0,0.5))

    @test isequalinterval(^(interval(-0.1,0.5), interval(2.5,2.5)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(-0.1,0.5), interval(2.5,Inf)), interval(0.0,0x1.6A09E667F3BCDP-3))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-0.1,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,-0.1)), interval(0x1.125FBEE250664P+0,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-1.0,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,-1.0)), interval(0x1P+1,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-2.5,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(-0.1,0.5), interval(-Inf,-2.5)), interval(0x1.6A09E667F3BCCP+2,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.1,0.1)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.1,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.1,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(0.1,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(1.0,1.0)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(1.0,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(1.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(2.5,2.5)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(2.5,Inf)), interval(0.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-0.1,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,-0.1)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-1.0,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,-1.0)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-2.5,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.0), interval(-Inf,-2.5)), interval(1.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.1,0.1)), interval(0.0,0x1.0A97DCE72A0CBP+0))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.1,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.1,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.1,1.5), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(1.0,1.0)), interval(0.0,1.5))

    @test isequalinterval(^(interval(-0.1,1.5), interval(1.0,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.1,1.5), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(2.5,2.5)), interval(0.0,0x1.60B9FD68A4555P+1))

    @test isequalinterval(^(interval(-0.1,1.5), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,0.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,-0.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,0.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,-0.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-0.1,-0.1)), interval(0x1.EBA7C9E4D31E9P-1,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,-0.1)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,-0.1)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-1.0,-1.0)), interval(0x1.5555555555555P-1,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,-1.0)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-2.5,-2.5)), interval(0x1.7398BF1D1EE6FP-2,Inf))

    @test isequalinterval(^(interval(-0.1,1.5), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.1,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.1,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.1,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.1,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), entireinterval()), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,-0.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-0.1,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,-0.1)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-1.0,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,-1.0)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-Inf,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(-0.1,Inf), interval(-2.5,-2.5)), interval(0.0,Inf))

    @test isequalinterval(^(interval(0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(0.0,0.0), interval(-2.5,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,-0.0), interval(-2.5,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-0.0,0.0), interval(-2.5,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(0.0,-0.0), interval(-2.5,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,0.0), interval(-2.5,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.1,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.1,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.1,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.1,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,Inf)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,0.1)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,2.5)), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), entireinterval()), interval(0.0,0.0))

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.0), interval(-2.5,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), emptyinterval()), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.0,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.0,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.0,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.0,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.0,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.0,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.1,0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.1,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.1,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(0.1,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(1.0,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(1.0,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(1.0,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(2.5,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(2.5,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.1,0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.1,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.1,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.1,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,Inf)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), entireinterval()), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-0.1,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,-0.1)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-Inf,-2.5)), emptyinterval())

    @test isequalinterval(^(interval(-1.0,-0.1), interval(-2.5,-2.5)), emptyinterval())

end

@testset "minimal_pow_dec_test" begin

    @test isequalinterval(^(DecoratedInterval(interval(0.1,0.5), com), DecoratedInterval(interval(0.0,1.0), com)), DecoratedInterval(interval(0x1.999999999999AP-4,1.0), com))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,0.5), com), DecoratedInterval(interval(0.1,0.1), def)), DecoratedInterval(interval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1), def))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,0.5), trv), DecoratedInterval(interval(-2.5,2.5), dac)), DecoratedInterval(interval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,0.5), com), DecoratedInterval(interval(-2.5,Inf), dac)), DecoratedInterval(interval(0.0,0x1.3C3A4EDFA9758P+8), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,0.5), trv), DecoratedInterval(interval(-Inf,0.1), dac)), DecoratedInterval(interval(0x1.96B230BCDC434P-1,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,1.0), com), DecoratedInterval(interval(0.0,2.5), com)), DecoratedInterval(interval(0x1.9E7C6E43390B7P-9,1.0), com))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,1.0), def), DecoratedInterval(interval(1.0,1.0), dac)), DecoratedInterval(interval(0x1.999999999999AP-4,1.0), def))

    @test isequalinterval(^(DecoratedInterval(interval(0.1,1.0), trv), DecoratedInterval(interval(-2.5,1.0), def)), DecoratedInterval(interval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.5,1.5), dac), DecoratedInterval(interval(0.1,0.1), com)), DecoratedInterval(interval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.5,1.5), def), DecoratedInterval(interval(-2.5,0.1), trv)), DecoratedInterval(interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.5,1.5), com), DecoratedInterval(interval(-2.5,-2.5), com)), DecoratedInterval(interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), com))

    @test isequalinterval(^(DecoratedInterval(interval(0.5,Inf), dac), DecoratedInterval(interval(0.1,0.1), com)), DecoratedInterval(interval(0x1.DDB680117AB12P-1,Inf), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.5,Inf), def), DecoratedInterval(interval(-2.5,-0.0), com)), DecoratedInterval(interval(0.0,0x1.6A09E667F3BCDP+2), def))

    @test isequalinterval(^(DecoratedInterval(interval(1.0,1.5), com), DecoratedInterval(interval(-0.1,0.1), def)), DecoratedInterval(interval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0), def))

    @test isequalinterval(^(DecoratedInterval(interval(1.0,1.5), trv), DecoratedInterval(interval(-0.1,-0.1), com)), DecoratedInterval(interval(0x1.EBA7C9E4D31E9P-1,1.0), trv))

    @test isequalinterval(^(DecoratedInterval(interval(1.0,Inf), dac), DecoratedInterval(interval(1.0,1.0), dac)), DecoratedInterval(interval(1.0,Inf), dac))

    @test isequalinterval(^(DecoratedInterval(interval(1.0,Inf), def), DecoratedInterval(interval(-1.0,-0.0), dac)), DecoratedInterval(interval(0x0P+0,1.0), def))

    @test isequalinterval(^(DecoratedInterval(interval(1.1,1.5), def), DecoratedInterval(interval(1.0,2.5), com)), DecoratedInterval(interval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1), def))

    @test isequalinterval(^(DecoratedInterval(interval(1.1,1.5), com), DecoratedInterval(interval(-0.1,-0.1), com)), DecoratedInterval(interval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1), com))

    @test isequalinterval(^(DecoratedInterval(interval(1.1,Inf), dac), DecoratedInterval(interval(0.1,Inf), dac)), DecoratedInterval(interval(0x1.02739C65D58BFP+0,Inf), dac))

    @test isequalinterval(^(DecoratedInterval(interval(1.1,Inf), def), DecoratedInterval(interval(-2.5,Inf), dac)), DecoratedInterval(interval(0x0P+0,Inf), def))

    @test isequalinterval(^(DecoratedInterval(interval(1.1,Inf), trv), DecoratedInterval(interval(-Inf,-1.0), def)), DecoratedInterval(interval(0x0P+0,0x1.D1745D1745D17P-1), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,0.5), com), DecoratedInterval(interval(0.1,0.1), com)), DecoratedInterval(interval(0.0,0x1.DDB680117AB13P-1), com))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,0.5), com), DecoratedInterval(interval(2.5,Inf), dac)), DecoratedInterval(interval(0.0,0x1.6A09E667F3BCDP-3), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,0.5), com), DecoratedInterval(interval(-Inf,-2.5), dac)), DecoratedInterval(interval(0x1.6A09E667F3BCCP+2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), com), DecoratedInterval(interval(0.0,0.0), com)), DecoratedInterval(interval(1.0,1.0), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(interval(0.0,2.5), dac)), DecoratedInterval(interval(0.0,1.0), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), dac), DecoratedInterval(interval(1.0,2.5), com)), DecoratedInterval(interval(0.0,1.0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), com), DecoratedInterval(interval(-2.5,0.1), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(entireinterval(), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), dac), DecoratedInterval(interval(-0.1,0.0), com)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), com), DecoratedInterval(interval(-Inf,0.0), dac)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(interval(-Inf,-2.5), dac)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.5), com), DecoratedInterval(interval(0.0,2.5), com)), DecoratedInterval(interval(0.0,0x1.60B9FD68A4555P+1), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.5), def), DecoratedInterval(interval(2.5,2.5), dac)), DecoratedInterval(interval(0.0,0x1.60B9FD68A4555P+1), def))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.5), dac), DecoratedInterval(interval(-1.0,0.0), com)), DecoratedInterval(interval(0x1.5555555555555P-1,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,1.5), com), DecoratedInterval(interval(-2.5,-2.5), def)), DecoratedInterval(interval(0x1.7398BF1D1EE6FP-2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,Inf), dac), DecoratedInterval(interval(0.1,0.1), com)), DecoratedInterval(interval(0.0,Inf), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,Inf), def), DecoratedInterval(interval(-1.0,1.0), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,Inf), trv), DecoratedInterval(interval(-Inf,-1.0), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,Inf), dac), DecoratedInterval(interval(-2.5,-2.5), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,0.5), com), DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,1.0), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,0.5), def), DecoratedInterval(interval(0.1,Inf), def)), DecoratedInterval(interval(0.0,0x1.DDB680117AB13P-1), def))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,0.5), dac), DecoratedInterval(interval(2.5,2.5), com)), DecoratedInterval(interval(0.0,0x1.6A09E667F3BCDP-3), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,0.5), trv), DecoratedInterval(interval(-2.5,-0.0), dac)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,0.5), com), DecoratedInterval(interval(-Inf,-0.1), def)), DecoratedInterval(interval(0x1.125FBEE250664P+0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,0.5), def), DecoratedInterval(interval(-Inf,-2.5), dac)), DecoratedInterval(interval(0x1.6A09E667F3BCCP+2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.0), com), DecoratedInterval(interval(2.5,2.5), dac)), DecoratedInterval(interval(0.0,1.0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.0), dac), DecoratedInterval(interval(-1.0,Inf), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.0), com), DecoratedInterval(entireinterval(), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.0), def), DecoratedInterval(interval(-2.5,-2.5), com)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.0), dac), DecoratedInterval(interval(-Inf,-2.5), def)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.5), com), DecoratedInterval(interval(0.1,2.5), dac)), DecoratedInterval(interval(0.0,0x1.60B9FD68A4555P+1), dac))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.5), def), DecoratedInterval(interval(-1.0,0.0), trv)), DecoratedInterval(interval(0x1.5555555555555P-1,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.5), dac), DecoratedInterval(interval(-2.5,-0.1), def)), DecoratedInterval(interval(0x1.7398BF1D1EE6FP-2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.5), com), DecoratedInterval(interval(-2.5,-2.5), com)), DecoratedInterval(interval(0x1.7398BF1D1EE6FP-2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,1.5), def), DecoratedInterval(interval(-Inf,-2.5), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,Inf), dac), DecoratedInterval(interval(-0.1,Inf), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,Inf), def), DecoratedInterval(interval(-2.5,-0.0), com)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,Inf), trv), DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,Inf), dac), DecoratedInterval(interval(-Inf,-0.0), trv)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.0,Inf), def), DecoratedInterval(interval(-Inf,-1.0), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,0.5), def), DecoratedInterval(interval(0.1,Inf), dac)), DecoratedInterval(interval(0.0,0x1.DDB680117AB13P-1), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,0.5), com), DecoratedInterval(interval(-0.1,-0.1), com)), DecoratedInterval(interval(0x1.125FBEE250664P+0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,0.5), dac), DecoratedInterval(interval(-Inf,-2.5), def)), DecoratedInterval(interval(0x1.6A09E667F3BCCP+2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.0), com), DecoratedInterval(interval(0.0,0.0), com)), DecoratedInterval(interval(1.0,1.0), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.0), dac), DecoratedInterval(interval(-Inf,2.5), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.0), def), DecoratedInterval(interval(-Inf,-1.0), def)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.0), com), DecoratedInterval(interval(-2.5,-2.5), com)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(interval(-Inf,-2.5), trv)), DecoratedInterval(interval(1.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.5), trv), DecoratedInterval(interval(0.0,2.5), com)), DecoratedInterval(interval(0.0,0x1.60B9FD68A4555P+1), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.5), com), DecoratedInterval(interval(2.5,2.5), dac)), DecoratedInterval(interval(0.0,0x1.60B9FD68A4555P+1), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.5), dac), DecoratedInterval(interval(-1.0,0.0), trv)), DecoratedInterval(interval(0x1.5555555555555P-1,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.5), com), DecoratedInterval(interval(-0.1,-0.1), com)), DecoratedInterval(interval(0x1.EBA7C9E4D31E9P-1,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,1.5), def), DecoratedInterval(interval(-2.5,-2.5), def)), DecoratedInterval(interval(0x1.7398BF1D1EE6FP-2,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,Inf), dac), DecoratedInterval(interval(-0.1,2.5), com)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,Inf), def), DecoratedInterval(interval(-2.5,0.0), def)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-0.1,Inf), dac), DecoratedInterval(interval(-2.5,-2.5), trv)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,0.0), com), DecoratedInterval(interval(1.0,Inf), dac)), DecoratedInterval(interval(0.0,0.0), dac))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,0.0), com), DecoratedInterval(interval(-2.5,0.1), com)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(^(DecoratedInterval(interval(0.0,0.0), dac), DecoratedInterval(interval(-1.0,0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-1.0,-0.1), com), DecoratedInterval(interval(-0.1,1.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-1.0,-0.1), dac), DecoratedInterval(interval(-0.1,2.5), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(^(DecoratedInterval(interval(-1.0,-0.1), def), DecoratedInterval(interval(-0.1,Inf), trv)), DecoratedInterval(emptyinterval(), trv))

end

@testset "minimal_exp_test" begin

    @test isequalinterval(exp(emptyinterval()), emptyinterval())

    @test isequalinterval(exp(interval(-Inf,0.0)), interval(0.0,1.0))

    @test isequalinterval(exp(interval(-Inf,-0.0)), interval(0.0,1.0))

    @test isequalinterval(exp(interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(exp(interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(exp(entireinterval()), interval(0.0,Inf))

    @test isequalinterval(exp(interval(-Inf,0x1.62E42FEFA39FP+9)), interval(0.0,Inf))

    @test isequalinterval(exp(interval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9)), interval( 0x1.FFFFFFFFFFFFFP+1023,Inf))

    @test isequalinterval(exp(interval(0.0,0x1.62E42FEFA39EP+9)), interval(1.0,0x1.FFFFFFFFFC32BP+1023))

    @test isequalinterval(exp(interval(-0.0,0x1.62E42FEFA39EP+9)), interval(1.0,0x1.FFFFFFFFFC32BP+1023))

    @test isequalinterval(exp(interval(-0x1.6232BDD7ABCD3P+9,0x1.62E42FEFA39EP+9)), interval(0x0.FFFFFFFFFFE7BP-1022,0x1.FFFFFFFFFC32BP+1023))

    @test isequalinterval(exp(interval(-0x1.6232BDD7ABCD3P+8,0x1.62E42FEFA39EP+9)), interval(0x1.FFFFFFFFFFE7BP-512,0x1.FFFFFFFFFC32BP+1023))

    @test isequalinterval(exp(interval(-0x1.6232BDD7ABCD3P+8,0.0)), interval(0x1.FFFFFFFFFFE7BP-512,1.0))

    @test isequalinterval(exp(interval(-0x1.6232BDD7ABCD3P+8,-0.0)), interval(0x1.FFFFFFFFFFE7BP-512,1.0))

    @test isequalinterval(exp(interval(-0x1.6232BDD7ABCD3P+8,1.0)), interval(0x1.FFFFFFFFFFE7BP-512,0x1.5BF0A8B14576AP+1))

    @test isequalinterval(exp(interval(1.0,5.0)), interval(0x1.5BF0A8B145769P+1,0x1.28D389970339P+7))

    @test isequalinterval(exp(interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)), interval(0x1.2797F0A337A5FP-5,0x1.86091CC9095C5P+2))

    @test isequalinterval(exp(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)), interval(0x1.1337E9E45812AP+1, 0x1.805A5C88021B6P+142))

    @test isequalinterval(exp(interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)), interval(0x1.EF461A783114CP+16,0x1.691D36C6B008CP+37))

end

@testset "minimal_exp_dec_test" begin

    @test isequalinterval(exp(DecoratedInterval(interval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9), com)), DecoratedInterval(interval( 0x1.FFFFFFFFFFFFFP+1023,Inf), dac))

    @test isequalinterval(exp(DecoratedInterval(interval(0.0,0x1.62E42FEFA39EP+9), def)), DecoratedInterval(interval(1.0,0x1.FFFFFFFFFC32BP+1023), def))

end

@testset "minimal_exp2_test" begin

    @test isequalinterval(exp2(emptyinterval()), emptyinterval())

    @test isequalinterval(exp2(interval(-Inf,0.0)), interval(0.0,1.0))

    @test isequalinterval(exp2(interval(-Inf,-0.0)), interval(0.0,1.0))

    @test isequalinterval(exp2(interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(exp2(interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(exp2(entireinterval()), interval(0.0,Inf))

    @test isequalinterval(exp2(interval(-Inf,1024.0)), interval(0.0,Inf))

    @test isequalinterval(exp2(interval(1024.0,1024.0)), interval(0x1.FFFFFFFFFFFFFP+1023,Inf))

    @test isequalinterval(exp2(interval(0.0,1023.0)), interval(1.0,0x1P+1023))

    @test isequalinterval(exp2(interval(-0.0,1023.0)), interval(1.0,0x1P+1023))

    @test isequalinterval(exp2(interval(-1022.0,1023.0)), interval(0x1P-1022,0x1P+1023))

    @test isequalinterval(exp2(interval(-1022.0,0.0)), interval(0x1P-1022,1.0))

    @test isequalinterval(exp2(interval(-1022.0,-0.0)), interval(0x1P-1022,1.0))

    @test isequalinterval(exp2(interval(-1022.0,1.0)), interval(0x1P-1022,2.0))

    @test isequalinterval(exp2(interval(1.0,5.0)), interval(2.0,32.0))

    @test isequalinterval(exp2(interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)), interval(0x1.9999999999998P-4,0x1.C000000000001P+1))

    @test isequalinterval(exp2(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)), interval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98))

    @test isequalinterval(exp2(interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)), interval(0x1.AEA0000721857P+11,0x1.FCA0555555559P+25))

end

@testset "minimal_exp2_dec_test" begin

    @test isequalinterval(exp2(DecoratedInterval(interval(1024.0,1024.0), com)), DecoratedInterval(interval(0x1.FFFFFFFFFFFFFP+1023,Inf), dac))

    @test isequalinterval(exp2(DecoratedInterval(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), def)), DecoratedInterval(interval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98), def))

end

@testset "minimal_exp10_test" begin

    @test isequalinterval(exp10(emptyinterval()), emptyinterval())

    @test isequalinterval(exp10(interval(-Inf,0.0)), interval(0.0,1.0))

    @test isequalinterval(exp10(interval(-Inf,-0.0)), interval(0.0,1.0))

    @test isequalinterval(exp10(interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(exp10(interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(exp10(entireinterval()), interval(0.0,Inf))

    @test isequalinterval(exp10(interval(-Inf,0x1.34413509F79FFP+8)), interval(0.0,Inf))

    @test isequalinterval(exp10(interval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8)), interval(0x1.FFFFFFFFFFFFFP+1023,Inf))

    @test isequalinterval(exp10(interval(0.0,0x1.34413509F79FEP+8)), interval(1.0,0x1.FFFFFFFFFFBA1P+1023))

    @test isequalinterval(exp10(interval(-0.0,0x1.34413509F79FEP+8)), interval(1.0,0x1.FFFFFFFFFFBA1P+1023))

    @test isequalinterval(exp10(interval(-0x1.33A7146F72A42P+8,0x1.34413509F79FEP+8)), interval(0x0.FFFFFFFFFFFE3P-1022,0x1.FFFFFFFFFFBA1P+1023))

    @test isequalinterval(exp10(interval(-0x1.22P+7,0x1.34413509F79FEP+8)), interval(0x1.3FAAC3E3FA1F3P-482,0x1.FFFFFFFFFFBA1P+1023))

    @test isequalinterval(exp10(interval(-0x1.22P+7,0.0)), interval(0x1.3FAAC3E3FA1F3P-482,1.0))

    @test isequalinterval(exp10(interval(-0x1.22P+7,-0.0)), interval(0x1.3FAAC3E3FA1F3P-482,1.0))

    @test isequalinterval(exp10(interval(-0x1.22P+7,1.0)), interval(0x1.3FAAC3E3FA1F3P-482,10.0))

    @test isequalinterval(exp10(interval(1.0,5.0)), interval(10.0,100000.0))

    @test isequalinterval(exp10(interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)), interval(0x1.F3A8254311F9AP-12,0x1.00B18AD5B7D56P+6))

    @test isequalinterval(exp10(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)), interval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328))

    @test isequalinterval(exp10(interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)), interval(0x1.0608D2279A811P+39,0x1.43AF5D4271CB8P+86))

end

@testset "minimal_exp10_dec_test" begin

    @test isequalinterval(exp10(DecoratedInterval(interval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8), com)), DecoratedInterval(interval( 0x1.FFFFFFFFFFFFFP+1023,Inf), dac))

    @test isequalinterval(exp10(DecoratedInterval(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), def)), DecoratedInterval(interval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328), def))

end

@testset "minimal_log_test" begin

    @test isequalinterval(log(emptyinterval()), emptyinterval())

    @test isequalinterval(log(interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(log(interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(log(interval(0.0,1.0)), interval(-Inf,0.0))

    @test isequalinterval(log(interval(-0.0,1.0)), interval(-Inf,0.0))

    @test isequalinterval(log(interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(log(interval(0.0,Inf)), entireinterval())

    @test isequalinterval(log(interval(-0.0,Inf)), entireinterval())

    @test isequalinterval(log(entireinterval()), entireinterval())

    @test isequalinterval(log(interval(0.0,0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,0x1.62E42FEFA39FP+9))

    @test isequalinterval(log(interval(-0.0,0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,0x1.62E42FEFA39FP+9))

    @test isequalinterval(log(interval(1.0,0x1.FFFFFFFFFFFFFp1023)), interval(0.0,0x1.62E42FEFA39FP+9))

    @test isequalinterval(log(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)), interval(-0x1.74385446D71C4p9, +0x1.62E42FEFA39Fp9))

    @test isequalinterval(log(interval(0x0.0000000000001p-1022,1.0)), interval(-0x1.74385446D71C4p9,0.0))

    @test isequalinterval(log(interval(0x1.5BF0A8B145769P+1,0x1.5BF0A8B145769P+1)), interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequalinterval(log(interval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1)), interval(0x1P+0,0x1.0000000000001P+0))

    @test isequalinterval(log(interval(0x0.0000000000001p-1022,0x1.5BF0A8B14576AP+1)), interval(-0x1.74385446D71C4p9,0x1.0000000000001P+0))

    @test isequalinterval(log(interval(0x1.5BF0A8B145769P+1,32.0)), interval(0x1.FFFFFFFFFFFFFP-1,0x1.BB9D3BEB8C86CP+1))

    @test isequalinterval(log(interval(0x1.999999999999AP-4,0x1.CP+1)), interval(-0x1.26BB1BBB55516P+1,0x1.40B512EB53D6P+0))

    @test isequalinterval(log(interval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)), interval(0x1.0FAE81914A99P-1,0x1.120627F6AE7F1P+6))

    @test isequalinterval(log(interval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)), interval(0x1.04A1363DB1E63P+3,0x1.203E52C0256B5P+4))

end

@testset "minimal_log_dec_test" begin

    @test isequalinterval(log(DecoratedInterval(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(-0x1.74385446D71C4p9,0x1.62E42FEFA39FP+9), com))

    @test isequalinterval(log(DecoratedInterval(interval(0.0,1.0), com)), DecoratedInterval(interval(-Inf,0.0), trv))

    @test isequalinterval(log(DecoratedInterval(interval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1), def)), DecoratedInterval(interval(0x1P+0,0x1.0000000000001P+0), def))

end

@testset "minimal_log2_test" begin

    @test isequalinterval(log2(emptyinterval()), emptyinterval())

    @test isequalinterval(log2(interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(log2(interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(log2(interval(0.0,1.0)), interval(-Inf,0.0))

    @test isequalinterval(log2(interval(-0.0,1.0)), interval(-Inf,0.0))

    @test isequalinterval(log2(interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(log2(interval(0.0,Inf)), entireinterval())

    @test isequalinterval(log2(interval(-0.0,Inf)), entireinterval())

    @test isequalinterval(log2(entireinterval()), entireinterval())

    @test isequalinterval(log2(interval(0.0,0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,1024.0))

    @test isequalinterval(log2(interval(-0.0,0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,1024.0))

    @test isequalinterval(log2(interval(1.0,0x1.FFFFFFFFFFFFFp1023)), interval(0.0,1024.0))

    @test isequalinterval(log2(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)), interval(-1074.0,1024.0))

    @test isequalinterval(log2(interval(0x0.0000000000001p-1022,1.0)), interval(-1074.0,0.0))

    @test isequalinterval(log2(interval(0x0.0000000000001p-1022,2.0)), interval(-1074.0,1.0))

    @test isequalinterval(log2(interval(2.0,32.0)), interval(1.0,5.0))

    @test isequalinterval(log2(interval(0x1.999999999999AP-4,0x1.CP+1)), interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0))

    @test isequalinterval(log2(interval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)), interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6))

    @test isequalinterval(log2(interval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)), interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4))

end

@testset "minimal_log2_dec_test" begin

    @test isequalinterval(log2(DecoratedInterval(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(-1074.0,1024.0), com))

    @test isequalinterval(log2(DecoratedInterval(interval(0x0.0000000000001p-1022,Inf), dac)), DecoratedInterval(interval(-1074.0,Inf), dac))

    @test isequalinterval(log2(DecoratedInterval(interval(2.0,32.0), def)), DecoratedInterval(interval(1.0,5.0), def))

    @test isequalinterval(log2(DecoratedInterval(interval(0.0,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(-Inf,1024.0), trv))

end

@testset "minimal_log10_test" begin

    @test isequalinterval(log10(emptyinterval()), emptyinterval())

    @test isequalinterval(log10(interval(-Inf,0.0)), emptyinterval())

    @test isequalinterval(log10(interval(-Inf,-0.0)), emptyinterval())

    @test isequalinterval(log10(interval(0.0,1.0)), interval(-Inf,0.0))

    @test isequalinterval(log10(interval(-0.0,1.0)), interval(-Inf,0.0))

    @test isequalinterval(log10(interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(log10(interval(0.0,Inf)), entireinterval())

    @test isequalinterval(log10(interval(-0.0,Inf)), entireinterval())

    @test isequalinterval(log10(entireinterval()), entireinterval())

    @test isequalinterval(log10(interval(0.0,0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,0x1.34413509F79FFP+8))

    @test isequalinterval(log10(interval(-0.0,0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,0x1.34413509F79FFP+8))

    @test isequalinterval(log10(interval(1.0,0x1.FFFFFFFFFFFFFp1023)), interval(0.0,0x1.34413509F79FFP+8))

    @test isequalinterval(log10(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)), interval(-0x1.434E6420F4374p+8, +0x1.34413509F79FFp+8))

    @test isequalinterval(log10(interval(0x0.0000000000001p-1022,1.0)), interval(-0x1.434E6420F4374p+8 ,0.0))

    @test isequalinterval(log10(interval(0x0.0000000000001p-1022,10.0)), interval(-0x1.434E6420F4374p+8 ,1.0))

    @test isequalinterval(log10(interval(10.0,100000.0)), interval(1.0,5.0))

    @test isequalinterval(log10(interval(0x1.999999999999AP-4,0x1.CP+1)), interval(-0x1P+0,0x1.1690163290F4P-1))

    @test isequalinterval(log10(interval(0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(log10(interval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)), interval(0x1.D7F59AA5BECB9P-3,0x1.DC074D84E5AABP+4))

    @test isequalinterval(log10(interval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)), interval(0x1.C4C29DD829191P+1,0x1.F4BAEBBA4FA4P+2))

end

@testset "minimal_log10_dec_test" begin

    @test isequalinterval(log10(DecoratedInterval(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(-0x1.434E6420F4374p+8,0x1.34413509F79FFP+8), com))

    @test isequalinterval(log10(DecoratedInterval(interval(0.0,0x1.FFFFFFFFFFFFFp1023), dac)), DecoratedInterval(interval(-Inf,0x1.34413509F79FFP+8), trv))

end

@testset "minimal_sin_test" begin

    @test isequalinterval(sin(emptyinterval()), emptyinterval())

    @test isequalinterval(sin(interval(0.0,Inf)), interval(-1.0,1.0))

    @test isequalinterval(sin(interval(-0.0,Inf)), interval(-1.0,1.0))

    @test isequalinterval(sin(interval(-Inf,0.0)), interval(-1.0,1.0))

    @test isequalinterval(sin(interval(-Inf,-0.0)), interval(-1.0,1.0))

    @test isequalinterval(sin(entireinterval()), interval(-1.0,1.0))

    @test isequalinterval(sin(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(sin(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequalinterval(sin(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequalinterval(sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0))

    @test isequalinterval(sin(interval(0.0,0x1.921FB54442D18P+0)), interval(0.0,0x1P+0))

    @test isequalinterval(sin(interval(-0.0,0x1.921FB54442D18P+0)), interval(0.0,0x1P+0))

    @test isequalinterval(sin(interval(0.0,0x1.921FB54442D19P+0)), interval(0.0,0x1P+0))

    @test isequalinterval(sin(interval(-0.0,0x1.921FB54442D19P+0)), interval(0.0,0x1P+0))

    @test isequalinterval(sin(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)), interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53))

    @test isequalinterval(sin(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)), interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52))

    @test isequalinterval(sin(interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)), interval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53))

    @test isequalinterval(sin(interval(0.0,0x1.921FB54442D18P+1)), interval(0.0,1.0))

    @test isequalinterval(sin(interval(-0.0,0x1.921FB54442D18P+1)), interval(0.0,1.0))

    @test isequalinterval(sin(interval(0.0,0x1.921FB54442D19P+1)), interval(-0x1.72CECE675D1FDP-52,1.0))

    @test isequalinterval(sin(interval(-0.0,0x1.921FB54442D19P+1)), interval(-0x1.72CECE675D1FDP-52,1.0))

    @test isequalinterval(sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)), interval(0x1.1A62633145C06P-53,0x1P+0))

    @test isequalinterval(sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)), interval(-0x1.72CECE675D1FDP-52,0x1P+0))

    @test isequalinterval(sin(interval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)), interval(0x1.1A62633145C06P-53,0x1P+0))

    @test isequalinterval(sin(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)), interval(-0x1.72CECE675D1FDP-52,0x1P+0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+0,0.0)), interval(-0x1P+0,0.0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+0,-0.0)), interval(-0x1P+0,0.0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+0,0.0)), interval(-0x1P+0,0.0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+0,-0.0)), interval(-0x1P+0,0.0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)), interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)), interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)), interval(-0x1.1A62633145C07P-53,0x1.72CECE675D1FDP-52))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+1,0.0)), interval(-1.0,0.0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+1,-0.0)), interval(-1.0,0.0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+1,0.0)), interval(-1.0,0x1.72CECE675D1FDP-52))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+1,-0.0)), interval(-1.0,0x1.72CECE675D1FDP-52))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)), interval(-0x1P+0,-0x1.1A62633145C06P-53))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)), interval(-0x1P+0,0x1.72CECE675D1FDP-52))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)), interval(-0x1P+0,-0x1.1A62633145C06P-53))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)), interval(-0x1P+0,0x1.72CECE675D1FDP-52))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), interval(-0x1P+0,0x1P+0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), interval(-0x1P+0,0x1P+0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)), interval(-0x1P+0,0x1P+0))

    @test isequalinterval(sin(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), interval(-0x1P+0,0x1P+0))

    @test isequalinterval(sin(interval(-0.7,0.1)), interval(-0x1.49D6E694619B9P-1,0x1.98EAECB8BCB2DP-4))

    @test isequalinterval(sin(interval(1.0,2.0)), interval(0x1.AED548F090CEEP-1,1.0))

    @test isequalinterval(sin(interval(-3.2,-2.9)), interval(-0x1.E9FB8D64830E3P-3,0x1.DE33739E82D33P-5))

    @test isequalinterval(sin(interval(2.0,3.0)), interval(0x1.210386DB6D55BP-3,0x1.D18F6EAD1B446P-1))

end

@testset "minimal_sin_dec_test" begin

    @test isequalinterval(sin(DecoratedInterval(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0), def)), DecoratedInterval(interval(-0x1P+0,-0x1.1A62633145C06P-53), def))

    @test isequalinterval(sin(DecoratedInterval(interval(-Inf,-0.0), trv)), DecoratedInterval(interval(-1.0,1.0), trv))

    @test isequalinterval(sin(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-1.0,1.0), dac))

end

@testset "minimal_cos_test" begin

    @test isequalinterval(cos(emptyinterval()), emptyinterval())

    @test isequalinterval(cos(interval(0.0,Inf)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0.0,Inf)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-Inf,0.0)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-Inf,-0.0)), interval(-1.0,1.0))

    @test isequalinterval(cos(entireinterval()), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(cos(interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53))

    @test isequalinterval(cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(0.0,0x1.921FB54442D18P+0)), interval(0x1.1A62633145C06P-54,1.0))

    @test isequalinterval(cos(interval(-0.0,0x1.921FB54442D18P+0)), interval(0x1.1A62633145C06P-54,1.0))

    @test isequalinterval(cos(interval(0.0,0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(-0.0,0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(cos(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(cos(interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(cos(interval(0.0,0x1.921FB54442D18P+1)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0.0,0x1.921FB54442D18P+1)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(0.0,0x1.921FB54442D19P+1)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0.0,0x1.921FB54442D19P+1)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)), interval(-1.0,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)), interval(-1.0,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)), interval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequalinterval(cos(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)), interval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)), interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)), interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+0,0.0)), interval(0x1.1A62633145C06P-54,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+0,-0.0)), interval(0x1.1A62633145C06P-54,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+0,0.0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+0,-0.0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+1,0.0)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+1,-0.0)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+1,0.0)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+1,-0.0)), interval(-1.0,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)), interval(-1.0,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)), interval(-1.0,0x1.1A62633145C07P-54))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)), interval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)), interval(-1.0,-0x1.72CECE675D1FCP-53))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), interval(0x1.1A62633145C06P-54,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), interval(-0x1.72CECE675D1FDP-53,1.0))

    @test isequalinterval(cos(interval(-0.7,0.1)), interval(0x1.87996529F9D92P-1,1.0))

    @test isequalinterval(cos(interval(1.0,2.0)), interval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1))

    @test isequalinterval(cos(interval(-3.2,-2.9)), interval(-1.0,-0x1.F1216DBA340C8P-1))

    @test isequalinterval(cos(interval(2.0,3.0)), interval(-0x1.FAE04BE85E5D3P-1,-0x1.AA22657537204P-2))

end

@testset "minimal_cos_dec_test" begin

    @test isequalinterval(cos(DecoratedInterval(interval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0), trv)), DecoratedInterval(interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), trv))

    @test isequalinterval(cos(DecoratedInterval(interval(-Inf,-0.0), def)), DecoratedInterval(interval(-1.0,1.0), def))

    @test isequalinterval(cos(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-1.0,1.0), dac))

end

@testset "minimal_tan_test" begin

    @test isequalinterval(tan(emptyinterval()), emptyinterval())

    @test isequalinterval(tan(interval(0.0,Inf)), entireinterval())

    @test isequalinterval(tan(interval(-0.0,Inf)), entireinterval())

    @test isequalinterval(tan(interval(-Inf,0.0)), entireinterval())

    @test isequalinterval(tan(interval(-Inf,-0.0)), entireinterval())

    @test isequalinterval(tan(entireinterval()), entireinterval())

    @test isequalinterval(tan(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(tan(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(tan(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53))

    @test isequalinterval(tan(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), interval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52))

    @test isequalinterval(tan(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), entireinterval())

    @test isequalinterval(tan(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)), interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53))

    @test isequalinterval(tan(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)), interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52))

    @test isequalinterval(tan(interval(0.0,0x1.921FB54442D18P+0)), interval(0.0,0x1.D02967C31CDB5P+53))

    @test isequalinterval(tan(interval(-0.0,0x1.921FB54442D18P+0)), interval(0.0,0x1.D02967C31CDB5P+53))

    @test isequalinterval(tan(interval(0.0,0x1.921FB54442D19P+0)), entireinterval())

    @test isequalinterval(tan(interval(-0.0,0x1.921FB54442D19P+0)), entireinterval())

    @test isequalinterval(tan(interval(0.0,0x1.921FB54442D18P+1)), entireinterval())

    @test isequalinterval(tan(interval(-0.0,0x1.921FB54442D18P+1)), entireinterval())

    @test isequalinterval(tan(interval(0.0,0x1.921FB54442D19P+1)), entireinterval())

    @test isequalinterval(tan(interval(-0.0,0x1.921FB54442D19P+1)), entireinterval())

    @test isequalinterval(tan(interval(0x1P-51,0x1.921FB54442D18P+1)), entireinterval())

    @test isequalinterval(tan(interval(0x1P-51,0x1.921FB54442D19P+1)), entireinterval())

    @test isequalinterval(tan(interval(0x1P-52,0x1.921FB54442D18P+1)), entireinterval())

    @test isequalinterval(tan(interval(0x1P-52,0x1.921FB54442D19P+1)), entireinterval())

    @test isequalinterval(tan(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)), interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53))

    @test isequalinterval(tan(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)), entireinterval())

    @test isequalinterval(tan(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)), entireinterval())

    @test isequalinterval(tan(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)), entireinterval())

    @test isequalinterval(tan(interval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4)), interval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4))

    @test isequalinterval(tan(interval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12)), interval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0))

    @test isequalinterval(tan(interval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12)), entireinterval())

    @test isequalinterval(tan(interval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0)), interval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0))

end

@testset "minimal_tan_dec_test" begin

    @test isequalinterval(tan(DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0.0,Inf), def)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-Inf,0.0), trv)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-Inf,-0.0), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0.0,0.0), com)), DecoratedInterval(interval(0.0,0.0), com))

    @test isequalinterval(tan(DecoratedInterval(interval(-0.0,-0.0), def)), DecoratedInterval(interval(0.0,0.0), def))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), com)), DecoratedInterval(interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), com))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), def)), DecoratedInterval(interval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52), def))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1), trv)), DecoratedInterval(interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1), com)), DecoratedInterval(interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), com))

    @test isequalinterval(tan(DecoratedInterval(interval(0.0,0x1.921FB54442D18P+0), dac)), DecoratedInterval(interval(0.0,0x1.D02967C31CDB5P+53), dac))

    @test isequalinterval(tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D18P+0), com)), DecoratedInterval(interval(0.0,0x1.D02967C31CDB5P+53), com))

    @test isequalinterval(tan(DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D19P+0), def)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0.0,0x1.921FB54442D18P+1), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D18P+1), com)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D19P+1), def)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1P-51,0x1.921FB54442D18P+1), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1P-51,0x1.921FB54442D19P+1), com)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1P-52,0x1.921FB54442D18P+1), trv)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1P-52,0x1.921FB54442D19P+1), def)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), com)), DecoratedInterval(interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), com))

    @test isequalinterval(tan(DecoratedInterval(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), trv)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0), def)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), dac)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4), com)), DecoratedInterval(interval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4), com))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12), dac)), DecoratedInterval(interval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0), dac))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12), def)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(tan(DecoratedInterval(interval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0), trv)), DecoratedInterval(interval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0), trv))

end

@testset "minimal_asin_test" begin

    @test isequalinterval(asin(emptyinterval()), emptyinterval())

    @test isequalinterval(asin(interval(0.0,Inf)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(asin(interval(-0.0,Inf)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(asin(interval(-Inf,0.0)), interval(-0x1.921FB54442D19P+0,0.0))

    @test isequalinterval(asin(interval(-Inf,-0.0)), interval(-0x1.921FB54442D19P+0,0.0))

    @test isequalinterval(asin(entireinterval()), interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(asin(interval(-1.0,1.0)), interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(asin(interval(-Inf,-1.0)), interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0))

    @test isequalinterval(asin(interval(1.0,Inf)), interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(asin(interval(-1.0,-1.0)), interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0))

    @test isequalinterval(asin(interval(1.0,1.0)), interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(asin(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(asin(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(asin(interval(-Inf,-0x1.0000000000001P+0)), emptyinterval())

    @test isequalinterval(asin(interval(0x1.0000000000001P+0,Inf)), emptyinterval())

    @test isequalinterval(asin(interval(-0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(-0x1.9A49276037885P-4,0x1.9A49276037885P-4))

    @test isequalinterval(asin(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)), interval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0))

    @test isequalinterval(asin(interval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)), interval(-0x1.921FB50442D19P+0,0x1.921FB50442D19P+0))

end

@testset "minimal_asin_dec_test" begin

    @test isequalinterval(asin(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(asin(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0,0.0), trv))

    @test isequalinterval(asin(DecoratedInterval(interval(-1.0,1.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), com))

    @test isequalinterval(asin(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(asin(DecoratedInterval(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), def)), DecoratedInterval(interval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0), def))

end

@testset "minimal_acos_test" begin

    @test isequalinterval(acos(emptyinterval()), emptyinterval())

    @test isequalinterval(acos(interval(0.0,Inf)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(acos(interval(-0.0,Inf)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(acos(interval(-Inf,0.0)), interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1))

    @test isequalinterval(acos(interval(-Inf,-0.0)), interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1))

    @test isequalinterval(acos(entireinterval()), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(acos(interval(-1.0,1.0)), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(acos(interval(-Inf,-1.0)), interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1))

    @test isequalinterval(acos(interval(1.0,Inf)), interval(0.0,0.0))

    @test isequalinterval(acos(interval(-1.0,-1.0)), interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1))

    @test isequalinterval(acos(interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(acos(interval(0.0,0.0)), interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(acos(interval(-0.0,-0.0)), interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(acos(interval(-Inf,-0x1.0000000000001P+0)), emptyinterval())

    @test isequalinterval(acos(interval(0x1.0000000000001P+0,Inf)), emptyinterval())

    @test isequalinterval(acos(interval(-0x1.999999999999AP-4,0x1.999999999999AP-4)), interval(0x1.787B22CE3F59P+0,0x1.ABC447BA464A1P+0))

    @test isequalinterval(acos(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)), interval(0x1P-26,0x1.E837B2FD13428P+0))

    @test isequalinterval(acos(interval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)), interval(0x1P-26,0x1.921FB52442D19P+1))

end

@testset "minimal_acos_dec_test" begin

    @test isequalinterval(acos(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(acos(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(acos(DecoratedInterval(interval(-1.0,1.0), com)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), com))

    @test isequalinterval(acos(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(acos(DecoratedInterval(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), def)), DecoratedInterval(interval(0x1P-26,0x1.E837B2FD13428P+0), def))

end

@testset "minimal_atan_test" begin

    @test isequalinterval(atan(emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(0.0,Inf)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0,Inf)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-Inf,0.0)), interval(-0x1.921FB54442D19P+0,0.0))

    @test isequalinterval(atan(interval(-Inf,-0.0)), interval(-0x1.921FB54442D19P+0,0.0))

    @test isequalinterval(atan(entireinterval()), interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(1.0,0x1.4C2463567C5ACP+25)), interval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0))

    @test isequalinterval(atan(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), interval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0))

end

@testset "minimal_atan_dec_test" begin

    @test isequalinterval(atan(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0,0.0), def))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(1.0,0x1.4C2463567C5ACP+25), trv)), DecoratedInterval(interval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)), DecoratedInterval(interval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0), com))

end

@testset "minimal_atan2_test" begin

    @test isequalinterval(atan(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-2.0, -0.1)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-2.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-2.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-2.0, 1.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(0.0, 1.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(-0.0, 1.0)), emptyinterval())

    @test isequalinterval(atan(emptyinterval(), interval(0.1, 1.0)), emptyinterval())

    @test isequalinterval(atan(entireinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(entireinterval(), entireinterval()), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(entireinterval(), interval(0.0, 0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(entireinterval(), interval(0.0, -0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(entireinterval(), interval(-0.0, 0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(entireinterval(), interval(-0.0, -0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(entireinterval(), interval(-2.0, -0.1)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(entireinterval(), interval(-2.0, 0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(entireinterval(), interval(-2.0, -0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(entireinterval(), interval(-2.0, 1.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(entireinterval(), interval(0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(entireinterval(), interval(-0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(entireinterval(), interval(0.1, 1.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(0.0, 0.0), entireinterval()), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, 0.0), interval(0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-2.0, -0.1)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-2.0, 1.0)), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(-0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(0.0, 0.0), interval(0.1, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0, 0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, 0.0), entireinterval()), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-2.0, -0.1)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-2.0, 1.0)), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(-0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0, 0.0), interval(0.1, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(0.0, -0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(0.0, -0.0), entireinterval()), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, -0.0), interval(0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-2.0, -0.1)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-2.0, 1.0)), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(-0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(0.0, -0.0), interval(0.1, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0, -0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, -0.0), entireinterval()), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-0.0, 0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-0.0, -0.0)), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-2.0, -0.1)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-2.0, 1.0)), interval(0.0,0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(-0.0, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-0.0, -0.0), interval(0.1, 1.0)), interval(0.0,0.0))

    @test isequalinterval(atan(interval(-2.0, -0.1), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-2.0, -0.1), entireinterval()), interval(-0x1.921FB54442D19P+1,0.0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(0.0, 0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(0.0, -0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(-0.0, 0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(0.0, -0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(-2.0, -0.1)), interval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(-2.0, 0.0)), interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(-2.0, -0.0)), interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(-2.0, 1.0)), interval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(0.0, 1.0)), interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(-0.0, 1.0)), interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4))

    @test isequalinterval(atan(interval(-2.0, -0.1), interval(0.1, 1.0)), interval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4))

    @test isequalinterval(atan(interval(-2.0, 0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-2.0, 0.0), entireinterval()), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(0.0, 0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-0.0, 0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(0.0, -0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-0.0, -0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-2.0, -0.1)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-2.0, 0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-2.0, -0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-2.0, 1.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0.0))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(-0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0.0))

    @test isequalinterval(atan(interval(-2.0, 0.0), interval(0.1, 1.0)), interval(-0x1.8555A2787982P+0, 0.0))

    @test isequalinterval(atan(interval(-2.0, -0.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-2.0, -0.0), entireinterval()), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(0.0, 0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-0.0, 0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(0.0, -0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-0.0, -0.0)), interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-2.0, -0.1)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-2.0, 0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-2.0, -0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-2.0, 1.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0.0))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(-0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0.0))

    @test isequalinterval(atan(interval(-2.0, -0.0), interval(0.1, 1.0)), interval(-0x1.8555A2787982P+0, 0.0))

    @test isequalinterval(atan(interval(-2.0, 1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-2.0, 1.0), entireinterval()), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(0.0, 0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-0.0, 0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(0.0, -0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-0.0, -0.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-2.0, -0.1)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-2.0, 0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-2.0, -0.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-2.0, 1.0)), interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(-0.0, 1.0)), interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-2.0, 1.0), interval(0.1, 1.0)), interval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(-0.0, 1.0), entireinterval()), interval(0.0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(0.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-0.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(0.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-0.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-2.0, -0.1)), interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-2.0, 1.0)), interval(0.0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(0.0, 1.0)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(-0.0, 1.0)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(-0.0, 1.0), interval(0.1, 1.0)), interval(0.0, 0x1.789BD2C160054P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(0.0, 1.0), entireinterval()), interval(0.0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(0.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-0.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(0.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-0.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-2.0, -0.1)), interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-2.0, 1.0)), interval(0.0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(0.0, 1.0)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(-0.0, 1.0)), interval(0.0,0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.0, 1.0), interval(0.1, 1.0)), interval(0.0,0x1.789BD2C160054P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), emptyinterval()), emptyinterval())

    @test isequalinterval(atan(interval(0.1, 1.0), entireinterval()), interval(0.0, 0x1.921FB54442D19P+1))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(0.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-0.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(0.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-0.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-2.0, -0.1)), interval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-2.0, 0.0)), interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-2.0, -0.0)), interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-2.0, 1.0)), interval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(0.0, 1.0)), interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(-0.0, 1.0)), interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0))

    @test isequalinterval(atan(interval(0.1, 1.0), interval(0.1, 1.0)), interval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0))

end

@testset "minimal_atan2_dec_test" begin

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0, 0.0), dac)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0, -0.0), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, -0.1), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, 0.0), dac)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, -0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, 1.0), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0, 1.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0, 1.0), dac)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.1, 1.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.0, 0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.0, -0.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, -0.1), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, 0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, -0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, 1.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 1.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.0, 1.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(0.0, 0.0), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), trv), DecoratedInterval(interval(-0.0, 0.0), dac)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-0.0, -0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), trv), DecoratedInterval(interval(-2.0, 0.0), com)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.0), trv)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.0, 1.0), def)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(0.0, 1.0), com)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), trv), DecoratedInterval(interval(-0.0, 1.0), dac)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(0.0,0.0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), def), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), trv), DecoratedInterval(interval(-0.0, 0.0), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(interval(-0.0, -0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), trv), DecoratedInterval(interval(-2.0, 0.0), com)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.0), trv)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(interval(-2.0, 1.0), def)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(0.0, 1.0), com)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), def), DecoratedInterval(interval(-0.0, 1.0), dac)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(0.0,0.0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), def), DecoratedInterval(interval(0.0, 0.0), dac)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), trv), DecoratedInterval(interval(-0.0, 0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), dac), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(-0.0, -0.0), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), def), DecoratedInterval(interval(-2.0, 0.0), com)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(-2.0, -0.0), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), dac), DecoratedInterval(interval(-2.0, 1.0), com)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(0.0, 1.0), trv)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), def), DecoratedInterval(interval(-0.0, 1.0), com)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(0.1, 1.0), def)), DecoratedInterval(interval(0.0,0.0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), def), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), dac), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), trv), DecoratedInterval(interval(-0.0, 0.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(interval(0.0, -0.0), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), dac), DecoratedInterval(interval(-0.0, -0.0), com)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), def), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), trv), DecoratedInterval(interval(-2.0, 0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), dac), DecoratedInterval(interval(-2.0, -0.0), trv)), DecoratedInterval(interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), def), DecoratedInterval(interval(-2.0, 1.0), com)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(interval(0.0, 1.0), com)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), trv), DecoratedInterval(interval(-0.0, 1.0), dac)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(0.0,0.0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1,0.0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), trv), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, -0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.0, 0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, -0.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.0, -0.1), com)), DecoratedInterval(interval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.0, 0.0), def)), DecoratedInterval(interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), trv), DecoratedInterval(interval(-2.0, -0.0), dac)), DecoratedInterval(interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.0, 1.0), trv)), DecoratedInterval(interval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 1.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.0, 1.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4), com))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.0, 0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), trv), DecoratedInterval(interval(-0.0, 0.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, -0.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(-0.0, -0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.0, 0.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), trv), DecoratedInterval(interval(-2.0, 1.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(0.0, 1.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(-0.0, 1.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(-0x1.8555A2787982P+0, 0.0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), trv), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), dac), DecoratedInterval(entireinterval(), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), def), DecoratedInterval(interval(-0.0, 0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), dac), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(-0.0, -0.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), def), DecoratedInterval(interval(-2.0, -0.1), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(-2.0, 0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), dac), DecoratedInterval(interval(-2.0, -0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), def), DecoratedInterval(interval(-2.0, 1.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), trv), DecoratedInterval(interval(0.0, 1.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(-0.0, 1.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0.0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(-0x1.8555A2787982P+0, 0.0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), def), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), def), DecoratedInterval(interval(0.0, 0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(-0.0, 0.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), trv), DecoratedInterval(interval(0.0, -0.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(-0.0, -0.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), dac), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), def), DecoratedInterval(interval(-2.0, 0.0), def)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), trv), DecoratedInterval(interval(-2.0, -0.0), trv)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), dac), DecoratedInterval(interval(-2.0, 1.0), com)), DecoratedInterval(interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(0.0, 1.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), trv), DecoratedInterval(interval(-0.0, 1.0), dac)), DecoratedInterval(interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), com), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(entireinterval(), def)), DecoratedInterval(interval(0.0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), def), DecoratedInterval(interval(0.0, 0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), trv), DecoratedInterval(interval(-0.0, 0.0), trv)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(interval(0.0, -0.0), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), com), DecoratedInterval(interval(-0.0, -0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), com), DecoratedInterval(interval(-2.0, -0.1), com)), DecoratedInterval(interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), def), DecoratedInterval(interval(-2.0, 0.0), com)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), def), DecoratedInterval(interval(-2.0, -0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(interval(-2.0, 1.0), dac)), DecoratedInterval(interval(0.0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(interval(0.0, 1.0), dac)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), trv), DecoratedInterval(interval(-0.0, 1.0), com)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(-0.0, 1.0), trv), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(0.0, 0x1.789BD2C160054P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), def), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(0.0, 0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), trv), DecoratedInterval(interval(-0.0, 0.0), trv)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), trv), DecoratedInterval(interval(0.0, -0.0), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), def), DecoratedInterval(interval(-0.0, -0.0), com)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-2.0, -0.1), dac)), DecoratedInterval(interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), def), DecoratedInterval(interval(-2.0, 0.0), trv)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-2.0, -0.0), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-2.0, 1.0), def)), DecoratedInterval(interval(0.0, 0x1.921FB54442D19P+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(0.0, 1.0), trv)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-0.0, 1.0), def)), DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.0, 1.0), com), DecoratedInterval(interval(0.1, 1.0), com)), DecoratedInterval(interval(0.0,0x1.789BD2C160054P+0), com))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(emptyinterval(), trv)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0, 0x1.921FB54442D19P+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), def), DecoratedInterval(interval(0.0, 0.0), com)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), trv), DecoratedInterval(interval(-0.0, 0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), trv), DecoratedInterval(interval(0.0, -0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(interval(-0.0, -0.0), def)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), com), DecoratedInterval(interval(-2.0, -0.1), trv)), DecoratedInterval(interval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1), trv))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), com), DecoratedInterval(interval(-2.0, 0.0), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), com), DecoratedInterval(interval(-2.0, -0.0), dac)), DecoratedInterval(interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), dac))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), def), DecoratedInterval(interval(-2.0, 1.0), dac)), DecoratedInterval(interval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1), def))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), def), DecoratedInterval(interval(0.0, 1.0), def)), DecoratedInterval(interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(interval(-0.0, 1.0), def)), DecoratedInterval(interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), def))

    @test isequalinterval(atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(interval(0.1, 1.0), def)), DecoratedInterval(interval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0), def))

end

@testset "minimal_sinh_test" begin

    @test isequalinterval(sinh(emptyinterval()), emptyinterval())

    @test isequalinterval(sinh(interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(sinh(interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(sinh(interval(-Inf,0.0)), interval(-Inf,0.0))

    @test isequalinterval(sinh(interval(-Inf,-0.0)), interval(-Inf,0.0))

    @test isequalinterval(sinh(entireinterval()), entireinterval())

    @test isequalinterval(sinh(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(sinh(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(sinh(interval(1.0,0x1.2C903022DD7AAP+8)), interval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432))

    @test isequalinterval(sinh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), interval(-Inf,-0x1.53045B4F849DEP+815))

    @test isequalinterval(sinh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), interval(-0x1.55ECFE1B2B215P+0,0x1.3BF72EA61AF1BP+2))

end

@testset "minimal_sinh_dec_test" begin

    @test isequalinterval(sinh(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), dac))

    @test isequalinterval(sinh(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,Inf), dac))

    @test isequalinterval(sinh(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(-Inf,0.0), def))

    @test isequalinterval(sinh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), com)), DecoratedInterval(interval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432), com))

    @test isequalinterval(sinh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)), DecoratedInterval(interval(-Inf,-0x1.53045B4F849DEP+815), dac))

end

@testset "minimal_cosh_test" begin

    @test isequalinterval(cosh(emptyinterval()), emptyinterval())

    @test isequalinterval(cosh(interval(0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(cosh(interval(-0.0,Inf)), interval(1.0,Inf))

    @test isequalinterval(cosh(interval(-Inf,0.0)), interval(1.0,Inf))

    @test isequalinterval(cosh(interval(-Inf,-0.0)), interval(1.0,Inf))

    @test isequalinterval(cosh(entireinterval()), interval(1.0,Inf))

    @test isequalinterval(cosh(interval(0.0,0.0)), interval(1.0,1.0))

    @test isequalinterval(cosh(interval(-0.0,-0.0)), interval(1.0,1.0))

    @test isequalinterval(cosh(interval(1.0,0x1.2C903022DD7AAP+8)), interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432))

    @test isequalinterval(cosh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), interval(0x1.53045B4F849DEP+815,Inf))

    @test isequalinterval(cosh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), interval(1.0,0x1.4261D2B7D6181P+2))

end

@testset "minimal_cosh_dec_test" begin

    @test isequalinterval(cosh(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(1.0,Inf), dac))

    @test isequalinterval(cosh(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(1.0,Inf), def))

    @test isequalinterval(cosh(DecoratedInterval(entireinterval(), def)), DecoratedInterval(interval(1.0,Inf), def))

    @test isequalinterval(cosh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), def)), DecoratedInterval(interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), def))

    @test isequalinterval(cosh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)), DecoratedInterval(interval(0x1.53045B4F849DEP+815,Inf), dac))

end

@testset "minimal_tanh_test" begin

    @test isequalinterval(tanh(emptyinterval()), emptyinterval())

    @test isequalinterval(tanh(interval(0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(tanh(interval(-0.0,Inf)), interval(0.0,1.0))

    @test isequalinterval(tanh(interval(-Inf,0.0)), interval(-1.0,0.0))

    @test isequalinterval(tanh(interval(-Inf,-0.0)), interval(-1.0,0.0))

    @test isequalinterval(tanh(entireinterval()), interval(-1.0,1.0))

    @test isequalinterval(tanh(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(tanh(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(tanh(interval(1.0,0x1.2C903022DD7AAP+8)), interval(0x1.85EFAB514F394P-1,0x1P+0))

    @test isequalinterval(tanh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1))

    @test isequalinterval(tanh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), interval(-0x1.99DB01FDE2406P-1,0x1.F5CF31E1C8103P-1))

end

@testset "minimal_tanh_dec_test" begin

    @test isequalinterval(tanh(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,1.0), dac))

    @test isequalinterval(tanh(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(-1.0,0.0), def))

    @test isequalinterval(tanh(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(-1.0,1.0), dac))

    @test isequalinterval(tanh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), com)), DecoratedInterval(interval(0x1.85EFAB514F394P-1,0x1P+0), com))

    @test isequalinterval(tanh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), trv)), DecoratedInterval(interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), trv))

end

@testset "minimal_asinh_test" begin

    @test isequalinterval(asinh(emptyinterval()), emptyinterval())

    @test isequalinterval(asinh(interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(asinh(interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(asinh(interval(-Inf,0.0)), interval(-Inf,0.0))

    @test isequalinterval(asinh(interval(-Inf,-0.0)), interval(-Inf,0.0))

    @test isequalinterval(asinh(entireinterval()), entireinterval())

    @test isequalinterval(asinh(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(asinh(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(asinh(interval(1.0,0x1.2C903022DD7AAP+8)), interval(0x1.C34366179D426P-1,0x1.9986127438A87P+2))

    @test isequalinterval(asinh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)), interval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2))

    @test isequalinterval(asinh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)), interval(-0x1.E693DF6EDF1E7P-1,0x1.91FDC64DE0E51P+0))

end

@testset "minimal_asinh_dec_test" begin

    @test isequalinterval(asinh(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,Inf), dac))

    @test isequalinterval(asinh(DecoratedInterval(interval(-Inf,0.0), trv)), DecoratedInterval(interval(-Inf,0.0), trv))

    @test isequalinterval(asinh(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(entireinterval(), dac))

    @test isequalinterval(asinh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), com)), DecoratedInterval(interval(0x1.C34366179D426P-1,0x1.9986127438A87P+2), com))

    @test isequalinterval(asinh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), def)), DecoratedInterval(interval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2), def))

end

@testset "minimal_acosh_test" begin

    @test isequalinterval(acosh(emptyinterval()), emptyinterval())

    @test isequalinterval(acosh(interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(acosh(interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(acosh(interval(1.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(acosh(interval(-Inf,1.0)), interval(0.0,0.0))

    @test isequalinterval(acosh(interval(-Inf,0x1.FFFFFFFFFFFFFP-1)), emptyinterval())

    @test isequalinterval(acosh(entireinterval()), interval(0.0,Inf))

    @test isequalinterval(acosh(interval(1.0,1.0)), interval(0.0,0.0))

    @test isequalinterval(acosh(interval(1.0,0x1.2C903022DD7AAP+8)), interval(0.0,0x1.9985FB3D532AFP+2))

    @test isequalinterval(acosh(interval(0x1.199999999999AP+0,0x1.2666666666666P+1)), interval(0x1.C636C1A882F2CP-2,0x1.799C88E79140DP+0))

    @test isequalinterval(acosh(interval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29)), interval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4))

end

@testset "minimal_acosh_dec_test" begin

    @test isequalinterval(acosh(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(acosh(DecoratedInterval(interval(1.0,Inf), dac)), DecoratedInterval(interval(0.0,Inf), dac))

    @test isequalinterval(acosh(DecoratedInterval(entireinterval(), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(acosh(DecoratedInterval(interval(1.0,1.0), com)), DecoratedInterval(interval(0.0,0.0), com))

    @test isequalinterval(acosh(DecoratedInterval(interval(0.9,1.0), com)), DecoratedInterval(interval(0.0,0.0), trv))

    @test isequalinterval(acosh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), dac)), DecoratedInterval(interval(0.0,0x1.9985FB3D532AFP+2), dac))

    @test isequalinterval(acosh(DecoratedInterval(interval(0.9,0x1.2C903022DD7AAP+8), com)), DecoratedInterval(interval(0.0,0x1.9985FB3D532AFP+2), trv))

    @test isequalinterval(acosh(DecoratedInterval(interval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29), def)), DecoratedInterval(interval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4), def))

end

@testset "minimal_atanh_test" begin

    @test isequalinterval(atanh(emptyinterval()), emptyinterval())

    @test isequalinterval(atanh(interval(0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(atanh(interval(-0.0,Inf)), interval(0.0,Inf))

    @test isequalinterval(atanh(interval(1.0,Inf)), emptyinterval())

    @test isequalinterval(atanh(interval(-Inf,0.0)), interval(-Inf,0.0))

    @test isequalinterval(atanh(interval(-Inf,-0.0)), interval(-Inf,0.0))

    @test isequalinterval(atanh(interval(-Inf,-1.0)), emptyinterval())

    @test isequalinterval(atanh(interval(-1.0,1.0)), entireinterval())

    @test isequalinterval(atanh(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(atanh(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(atanh(interval(-1.0,-1.0)), emptyinterval())

    @test isequalinterval(atanh(interval(1.0,1.0)), emptyinterval())

    @test isequalinterval(atanh(entireinterval()), entireinterval())

    @test isequalinterval(atanh(interval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1)), interval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4))

    @test isequalinterval(atanh(interval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4)), interval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4))

end

@testset "minimal_atanh_dec_test" begin

    @test isequalinterval(atanh(DecoratedInterval(interval(0.0,Inf), dac)), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequalinterval(atanh(DecoratedInterval(interval(-Inf,0.0), def)), DecoratedInterval(interval(-Inf,0.0), trv))

    @test isequalinterval(atanh(DecoratedInterval(interval(-1.0,1.0), com)), DecoratedInterval(entireinterval(), trv))

    @test isequalinterval(atanh(DecoratedInterval(interval(0.0,0.0), com)), DecoratedInterval(interval(0.0,0.0), com))

    @test isequalinterval(atanh(DecoratedInterval(interval(1.0,1.0), def)), DecoratedInterval(emptyinterval(), trv))

    @test isequalinterval(atanh(DecoratedInterval(interval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1), com)), DecoratedInterval(interval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4), com))

    @test isequalinterval(atanh(DecoratedInterval(interval(-1.0,0x1.FFFFFFFFFFFFFP-1), com)), DecoratedInterval(interval(-Inf,0x1.2B708872320E2P+4), trv))

    @test isequalinterval(atanh(DecoratedInterval(interval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4), def)), DecoratedInterval(interval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4), def))

    @test isequalinterval(atanh(DecoratedInterval(interval(-0x1.FFB88E9EB6307P-1,1.0), com)), DecoratedInterval(interval(-0x1.06A3A97D7979CP+2,Inf), trv))

end

@testset "minimal_sign_test" begin

    @test isequalinterval(sign(emptyinterval()), emptyinterval())

    @test isequalinterval(sign(interval(1.0,2.0)), interval(1.0,1.0))

    @test isequalinterval(sign(interval(-1.0,2.0)), interval(-1.0,1.0))

    @test isequalinterval(sign(interval(-1.0,0.0)), interval(-1.0,0.0))

    @test isequalinterval(sign(interval(0.0,2.0)), interval(0.0,1.0))

    @test isequalinterval(sign(interval(-0.0,2.0)), interval(0.0,1.0))

    @test isequalinterval(sign(interval(-5.0,-2.0)), interval(-1.0,-1.0))

    @test isequalinterval(sign(interval(0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(sign(interval(-0.0,-0.0)), interval(0.0,0.0))

    @test isequalinterval(sign(interval(-0.0,0.0)), interval(0.0,0.0))

    @test isequalinterval(sign(entireinterval()), interval(-1.0,1.0))

end

@testset "minimal_sign_dec_test" begin

    @test isequalinterval(sign(DecoratedInterval(interval(1.0,2.0), com)), DecoratedInterval(interval(1.0,1.0), com))

    @test isequalinterval(sign(DecoratedInterval(interval(-1.0,2.0), com)), DecoratedInterval(interval(-1.0,1.0), def))

    @test isequalinterval(sign(DecoratedInterval(interval(-1.0,0.0), com)), DecoratedInterval(interval(-1.0,0.0), def))

    @test isequalinterval(sign(DecoratedInterval(interval(0.0,2.0), com)), DecoratedInterval(interval(0.0,1.0), def))

    @test isequalinterval(sign(DecoratedInterval(interval(-0.0,2.0), def)), DecoratedInterval(interval(0.0,1.0), def))

    @test isequalinterval(sign(DecoratedInterval(interval(-5.0,-2.0), trv)), DecoratedInterval(interval(-1.0,-1.0), trv))

    @test isequalinterval(sign(DecoratedInterval(interval(0.0,0.0), dac)), DecoratedInterval(interval(0.0,0.0), dac))

end

@testset "minimal_ceil_test" begin

    @test isequalinterval(ceil(emptyinterval()), emptyinterval())

    @test isequalinterval(ceil(entireinterval()), entireinterval())

    @test isequalinterval(ceil(interval(1.1,2.0)), interval(2.0,2.0))

    @test isequalinterval(ceil(interval(-1.1,2.0)), interval(-1.0,2.0))

    @test isequalinterval(ceil(interval(-1.1,0.0)), interval(-1.0,0.0))

    @test isequalinterval(ceil(interval(-1.1,-0.0)), interval(-1.0,0.0))

    @test isequalinterval(ceil(interval(-1.1,-0.4)), interval(-1.0,0.0))

    @test isequalinterval(ceil(interval(-1.9,2.2)), interval(-1.0,3.0))

    @test isequalinterval(ceil(interval(-1.0,2.2)), interval(-1.0,3.0))

    @test isequalinterval(ceil(interval(0.0,2.2)), interval(0.0,3.0))

    @test isequalinterval(ceil(interval(-0.0,2.2)), interval(0.0,3.0))

    @test isequalinterval(ceil(interval(-1.5,Inf)), interval(-1.0,Inf))

    @test isequalinterval(ceil(interval(0x1.FFFFFFFFFFFFFp1023,Inf)), interval(0x1.FFFFFFFFFFFFFp1023,Inf))

    @test isequalinterval(ceil(interval(-Inf,2.2)), interval(-Inf,3.0))

    @test isequalinterval(ceil(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)), interval(-Inf,-0x1.FFFFFFFFFFFFFp1023))

end

@testset "minimal_ceil_dec_test" begin

    @test isequalinterval(ceil(DecoratedInterval(interval(1.1,2.0), com)), DecoratedInterval(interval(2.0,2.0), dac))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.1,2.0), com)), DecoratedInterval(interval(-1.0,2.0), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.1,0.0), dac)), DecoratedInterval(interval(-1.0,0.0), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.1,-0.0), trv)), DecoratedInterval(interval(-1.0,0.0), trv))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.1,-0.4), dac)), DecoratedInterval(interval(-1.0,0.0), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.9,2.2), com)), DecoratedInterval(interval(-1.0,3.0), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.0,2.2), dac)), DecoratedInterval(interval(-1.0,3.0), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(0.0,2.2), trv)), DecoratedInterval(interval(0.0,3.0), trv))

    @test isequalinterval(ceil(DecoratedInterval(interval(-0.0,2.2), def)), DecoratedInterval(interval(0.0,3.0), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(-1.5,Inf), trv)), DecoratedInterval(interval(-1.0,Inf), trv))

    @test isequalinterval(ceil(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,Inf), dac)), DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,Inf), def))

    @test isequalinterval(ceil(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac))

    @test isequalinterval(ceil(DecoratedInterval(interval(-Inf,2.2), trv)), DecoratedInterval(interval(-Inf,3.0), trv))

    @test isequalinterval(ceil(DecoratedInterval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac)), DecoratedInterval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), def))

end

@testset "minimal_floor_test" begin

    @test isequalinterval(floor(emptyinterval()), emptyinterval())

    @test isequalinterval(floor(entireinterval()), entireinterval())

    @test isequalinterval(floor(interval(1.1,2.0)), interval(1.0,2.0))

    @test isequalinterval(floor(interval(-1.1,2.0)), interval(-2.0,2.0))

    @test isequalinterval(floor(interval(-1.1,0.0)), interval(-2.0,0.0))

    @test isequalinterval(floor(interval(-1.1,-0.0)), interval(-2.0,0.0))

    @test isequalinterval(floor(interval(-1.1,-0.4)), interval(-2.0,-1.0))

    @test isequalinterval(floor(interval(-1.9,2.2)), interval(-2.0,2.0))

    @test isequalinterval(floor(interval(-1.0,2.2)), interval(-1.0,2.0))

    @test isequalinterval(floor(interval(0.0,2.2)), interval(0.0,2.0))

    @test isequalinterval(floor(interval(-0.0,2.2)), interval(0.0,2.0))

    @test isequalinterval(floor(interval(-1.5,Inf)), interval(-2.0,Inf))

    @test isequalinterval(floor(interval(-Inf,2.2)), interval(-Inf,2.0))

end

@testset "minimal_floor_dec_test" begin

    @test isequalinterval(floor(DecoratedInterval(interval(1.1,2.0), com)), DecoratedInterval(interval(1.0,2.0), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.1,2.0), def)), DecoratedInterval(interval(-2.0,2.0), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.1,0.0), dac)), DecoratedInterval(interval(-2.0,0.0), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.2,-1.1), com)), DecoratedInterval(interval(-2.0,-2.0), com))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.1,-0.4), def)), DecoratedInterval(interval(-2.0,-1.0), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.9,2.2), com)), DecoratedInterval(interval(-2.0,2.0), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.0,2.2), trv)), DecoratedInterval(interval(-1.0,2.0), trv))

    @test isequalinterval(floor(DecoratedInterval(interval(0.0,2.2), trv)), DecoratedInterval(interval(0.0,2.0), trv))

    @test isequalinterval(floor(DecoratedInterval(interval(-0.0,2.2), com)), DecoratedInterval(interval(0.0,2.0), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-1.5,Inf), dac)), DecoratedInterval(interval(-2.0,Inf), def))

    @test isequalinterval(floor(DecoratedInterval(interval(-Inf,2.2), trv)), DecoratedInterval(interval(-Inf,2.0), trv))

    @test isequalinterval(floor(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), dac))

end

@testset "minimal_trunc_test" begin

    @test isequalinterval(trunc(emptyinterval()), emptyinterval())

    @test isequalinterval(trunc(entireinterval()), entireinterval())

    @test isequalinterval(trunc(interval(1.1,2.1)), interval(1.0,2.0))

    @test isequalinterval(trunc(interval(-1.1,2.0)), interval(-1.0,2.0))

    @test isequalinterval(trunc(interval(-1.1,0.0)), interval(-1.0,0.0))

    @test isequalinterval(trunc(interval(-1.1,-0.0)), interval(-1.0,0.0))

    @test isequalinterval(trunc(interval(-1.1,-0.4)), interval(-1.0,0.0))

    @test isequalinterval(trunc(interval(-1.9,2.2)), interval(-1.0,2.0))

    @test isequalinterval(trunc(interval(-1.0,2.2)), interval(-1.0,2.0))

    @test isequalinterval(trunc(interval(0.0,2.2)), interval(0.0,2.0))

    @test isequalinterval(trunc(interval(-0.0,2.2)), interval(0.0,2.0))

    @test isequalinterval(trunc(interval(-1.5,Inf)), interval(-1.0,Inf))

    @test isequalinterval(trunc(interval(-Inf,2.2)), interval(-Inf,2.0))

end

@testset "minimal_trunc_dec_test" begin

    @test isequalinterval(trunc(DecoratedInterval(interval(1.1,2.1), com)), DecoratedInterval(interval(1.0,2.0), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(1.1,1.9), com)), DecoratedInterval(interval(1.0,1.0), com))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.1,2.0), dac)), DecoratedInterval(interval(-1.0,2.0), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.1,0.0), trv)), DecoratedInterval(interval(-1.0,0.0), trv))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.1,-0.0), def)), DecoratedInterval(interval(-1.0,0.0), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.1,-0.4), com)), DecoratedInterval(interval(-1.0,0.0), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.9,2.2), def)), DecoratedInterval(interval(-1.0,2.0), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.0,2.2), dac)), DecoratedInterval(interval(-1.0,2.0), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(-1.5,Inf), dac)), DecoratedInterval(interval(-1.0,Inf), def))

    @test isequalinterval(trunc(DecoratedInterval(interval(-Inf,2.2), trv)), DecoratedInterval(interval(-Inf,2.0), trv))

    @test isequalinterval(trunc(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)), DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac))

    @test isequalinterval(trunc(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,Inf), dac)), DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,Inf), def))

end

@testset "minimal_round_ties_to_even_test" begin

    @test isequalinterval(round(emptyinterval()), emptyinterval())

    @test isequalinterval(round(entireinterval()), entireinterval())

    @test isequalinterval(round(interval(1.1,2.1)), interval(1.0,2.0))

    @test isequalinterval(round(interval(-1.1,2.0)), interval(-1.0,2.0))

    @test isequalinterval(round(interval(-1.1,-0.4)), interval(-1.0,0.0))

    @test isequalinterval(round(interval(-1.1,0.0)), interval(-1.0,0.0))

    @test isequalinterval(round(interval(-1.1,-0.0)), interval(-1.0,0.0))

    @test isequalinterval(round(interval(-1.9,2.2)), interval(-2.0,2.0))

    @test isequalinterval(round(interval(-1.0,2.2)), interval(-1.0,2.0))

    @test isequalinterval(round(interval(1.5,2.1)), interval(2.0,2.0))

    @test isequalinterval(round(interval(-1.5,2.0)), interval(-2.0,2.0))

    @test isequalinterval(round(interval(-1.1,-0.5)), interval(-1.0,0.0))

    @test isequalinterval(round(interval(-1.9,2.5)), interval(-2.0,2.0))

    @test isequalinterval(round(interval(0.0,2.5)), interval(0.0,2.0))

    @test isequalinterval(round(interval(-0.0,2.5)), interval(0.0,2.0))

    @test isequalinterval(round(interval(-1.5,2.5)), interval(-2.0,2.0))

    @test isequalinterval(round(interval(-1.5,Inf)), interval(-2.0,Inf))

    @test isequalinterval(round(interval(-Inf,2.2)), interval(-Inf,2.0))

end

@testset "minimal_round_ties_to_even_dec_test" begin

    @test isequalinterval(round(DecoratedInterval(interval(1.1,2.1), com)), DecoratedInterval(interval(1.0,2.0), def))

    @test isequalinterval(round(DecoratedInterval(interval(-1.1,2.0), trv)), DecoratedInterval(interval(-1.0,2.0), trv))

    @test isequalinterval(round(DecoratedInterval(interval(-1.6,-1.5), com)), DecoratedInterval(interval(-2.0,-2.0), dac))

    @test isequalinterval(round(DecoratedInterval(interval(-1.6,-1.4), com)), DecoratedInterval(interval(-2.0,-1.0), def))

    @test isequalinterval(round(DecoratedInterval(interval(-1.5,Inf), dac)), DecoratedInterval(interval(-2.0,Inf), def))

    @test isequalinterval(round(DecoratedInterval(interval(-Inf,2.2), trv)), DecoratedInterval(interval(-Inf,2.0), trv))

end

@testset "minimal_round_ties_to_away_test" begin

    @test isequalinterval(round(emptyinterval(), RoundNearestTiesAway), emptyinterval())

    @test isequalinterval(round(entireinterval(), RoundNearestTiesAway), entireinterval())

    @test isequalinterval(round(interval(1.1,2.1), RoundNearestTiesAway), interval(1.0,2.0))

    @test isequalinterval(round(interval(-1.1,2.0), RoundNearestTiesAway), interval(-1.0,2.0))

    @test isequalinterval(round(interval(-1.1,0.0), RoundNearestTiesAway), interval(-1.0,0.0))

    @test isequalinterval(round(interval(-1.1,-0.0), RoundNearestTiesAway), interval(-1.0,-0.0))

    @test isequalinterval(round(interval(-1.1,-0.4), RoundNearestTiesAway), interval(-1.0,0.0))

    @test isequalinterval(round(interval(-1.9,2.2), RoundNearestTiesAway), interval(-2.0,2.0))

    @test isequalinterval(round(interval(-1.0,2.2), RoundNearestTiesAway), interval(-1.0,2.0))

    @test isequalinterval(round(interval(0.5,2.1), RoundNearestTiesAway), interval(1.0,2.0))

    @test isequalinterval(round(interval(-2.5,2.0), RoundNearestTiesAway), interval(-3.0,2.0))

    @test isequalinterval(round(interval(-1.1,-0.5), RoundNearestTiesAway), interval(-1.0,-1.0))

    @test isequalinterval(round(interval(-1.9,2.5), RoundNearestTiesAway), interval(-2.0,3.0))

    @test isequalinterval(round(interval(-1.5,2.5), RoundNearestTiesAway), interval(-2.0,3.0))

    @test isequalinterval(round(interval(0.0,2.5), RoundNearestTiesAway), interval(0.0,3.0))

    @test isequalinterval(round(interval(-0.0,2.5), RoundNearestTiesAway), interval(0.0,3.0))

    @test isequalinterval(round(interval(-1.5,Inf), RoundNearestTiesAway), interval(-2.0,Inf))

    @test isequalinterval(round(interval(-Inf,2.2), RoundNearestTiesAway), interval(-Inf,2.0))

end

@testset "minimal_round_ties_to_away_dec_test" begin

    @test isequalinterval(round(DecoratedInterval(interval(1.1,2.1), com), RoundNearestTiesAway), DecoratedInterval(interval(1.0,2.0), def))

    @test isequalinterval(round(DecoratedInterval(interval(-1.9,2.2), com), RoundNearestTiesAway), DecoratedInterval(interval(-2.0,2.0), def))

    @test isequalinterval(round(DecoratedInterval(interval(1.9,2.2), com), RoundNearestTiesAway), DecoratedInterval(interval(2.0,2.0), com))

    @test isequalinterval(round(DecoratedInterval(interval(-1.0,2.2), trv), RoundNearestTiesAway), DecoratedInterval(interval(-1.0,2.0), trv))

    @test isequalinterval(round(DecoratedInterval(interval(2.5,2.6), com), RoundNearestTiesAway), DecoratedInterval(interval(3.0,3.0), dac))

    @test isequalinterval(round(DecoratedInterval(interval(-1.5,Inf), dac), RoundNearestTiesAway), DecoratedInterval(interval(-2.0,Inf), def))

    @test isequalinterval(round(DecoratedInterval(interval(-Inf,2.2), def), RoundNearestTiesAway), DecoratedInterval(interval(-Inf,2.0), def))

end

@testset "minimal_abs_test" begin

    @test isequalinterval(abs(emptyinterval()), emptyinterval())

    @test isequalinterval(abs(entireinterval()), interval(0.0,Inf))

    @test isequalinterval(abs(interval(1.1,2.1)), interval(1.1,2.1))

    @test isequalinterval(abs(interval(-1.1,2.0)), interval(0.0,2.0))

    @test isequalinterval(abs(interval(-1.1,0.0)), interval(0.0,1.1))

    @test isequalinterval(abs(interval(-1.1,-0.0)), interval(0.0,1.1))

    @test isequalinterval(abs(interval(-1.1,-0.4)), interval(0.4,1.1))

    @test isequalinterval(abs(interval(-1.9,0.2)), interval(0.0,1.9))

    @test isequalinterval(abs(interval(0.0,0.2)), interval(0.0,0.2))

    @test isequalinterval(abs(interval(-0.0,0.2)), interval(0.0,0.2))

    @test isequalinterval(abs(interval(-1.5,Inf)), interval(0.0,Inf))

    @test isequalinterval(abs(interval(-Inf,-2.2)), interval(2.2,Inf))

end

@testset "minimal_abs_dec_test" begin

    @test isequalinterval(abs(DecoratedInterval(interval(-1.1,2.0), com)), DecoratedInterval(interval(0.0,2.0), com))

    @test isequalinterval(abs(DecoratedInterval(interval(-1.1,0.0), dac)), DecoratedInterval(interval(0.0,1.1), dac))

    @test isequalinterval(abs(DecoratedInterval(interval(-1.1,-0.0), def)), DecoratedInterval(interval(0.0,1.1), def))

    @test isequalinterval(abs(DecoratedInterval(interval(-1.1,-0.4), trv)), DecoratedInterval(interval(0.4,1.1), trv))

    @test isequalinterval(abs(DecoratedInterval(interval(-1.9,0.2), dac)), DecoratedInterval(interval(0.0,1.9), dac))

    @test isequalinterval(abs(DecoratedInterval(interval(0.0,0.2), def)), DecoratedInterval(interval(0.0,0.2), def))

    @test isequalinterval(abs(DecoratedInterval(interval(-0.0,0.2), com)), DecoratedInterval(interval(0.0,0.2), com))

    @test isequalinterval(abs(DecoratedInterval(interval(-1.5,Inf), dac)), DecoratedInterval(interval(0.0,Inf), dac))

end

@testset "minimal_min_test" begin

    @test isequalinterval(min(emptyinterval(), interval(1.0,2.0)), emptyinterval())

    @test isequalinterval(min(interval(1.0,2.0), emptyinterval()), emptyinterval())

    @test isequalinterval(min(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(min(entireinterval(), interval(1.0,2.0)), interval(-Inf,2.0))

    @test isequalinterval(min(interval(1.0,2.0), entireinterval()), interval(-Inf,2.0))

    @test isequalinterval(min(entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(min(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(min(interval(1.0,5.0), interval(2.0,4.0)), interval(1.0,4.0))

    @test isequalinterval(min(interval(0.0,5.0), interval(2.0,4.0)), interval(0.0,4.0))

    @test isequalinterval(min(interval(-0.0,5.0), interval(2.0,4.0)), interval(0.0,4.0))

    @test isequalinterval(min(interval(1.0,5.0), interval(2.0,8.0)), interval(1.0,5.0))

    @test isequalinterval(min(interval(1.0,5.0), entireinterval()), interval(-Inf,5.0))

    @test isequalinterval(min(interval(-7.0,-5.0), interval(2.0,4.0)), interval(-7.0,-5.0))

    @test isequalinterval(min(interval(-7.0,0.0), interval(2.0,4.0)), interval(-7.0,0.0))

    @test isequalinterval(min(interval(-7.0,-0.0), interval(2.0,4.0)), interval(-7.0,0.0))

end

@testset "minimal_min_dec_test" begin

    @test isequalinterval(min(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(1.0,2.0), com)), DecoratedInterval(interval(-Inf,2.0), dac))

    @test isequalinterval(min(DecoratedInterval(interval(-7.0,-5.0), trv), DecoratedInterval(interval(2.0,4.0), def)), DecoratedInterval(interval(-7.0,-5.0), trv))

    @test isequalinterval(min(DecoratedInterval(interval(-7.0,0.0), dac), DecoratedInterval(interval(2.0,4.0), def)), DecoratedInterval(interval(-7.0,0.0), def))

    @test isequalinterval(min(DecoratedInterval(interval(-7.0,-0.0), com), DecoratedInterval(interval(2.0,4.0), com)), DecoratedInterval(interval(-7.0,0.0), com))

end

@testset "minimal_max_test" begin

    @test isequalinterval(max(emptyinterval(), interval(1.0,2.0)), emptyinterval())

    @test isequalinterval(max(interval(1.0,2.0), emptyinterval()), emptyinterval())

    @test isequalinterval(max(emptyinterval(), emptyinterval()), emptyinterval())

    @test isequalinterval(max(entireinterval(), interval(1.0,2.0)), interval(1.0,Inf))

    @test isequalinterval(max(interval(1.0,2.0), entireinterval()), interval(1.0,Inf))

    @test isequalinterval(max(entireinterval(), entireinterval()), entireinterval())

    @test isequalinterval(max(emptyinterval(), entireinterval()), emptyinterval())

    @test isequalinterval(max(interval(1.0,5.0), interval(2.0,4.0)), interval(2.0,5.0))

    @test isequalinterval(max(interval(1.0,5.0), interval(2.0,8.0)), interval(2.0,8.0))

    @test isequalinterval(max(interval(-1.0,5.0), entireinterval()), interval(-1.0,Inf))

    @test isequalinterval(max(interval(-7.0,-5.0), interval(2.0,4.0)), interval(2.0,4.0))

    @test isequalinterval(max(interval(-7.0,-5.0), interval(0.0,4.0)), interval(0.0,4.0))

    @test isequalinterval(max(interval(-7.0,-5.0), interval(-0.0,4.0)), interval(0.0,4.0))

    @test isequalinterval(max(interval(-7.0,-5.0), interval(-2.0,0.0)), interval(-2.0,0.0))

    @test isequalinterval(max(interval(-7.0,-5.0), interval(-2.0,-0.0)), interval(-2.0,0.0))

end

@testset "minimal_max_dec_test" begin

    @test isequalinterval(max(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(1.0,2.0), com)), DecoratedInterval(interval(1.0,Inf), dac))

    @test isequalinterval(max(DecoratedInterval(interval(-7.0,-5.0), trv), DecoratedInterval(interval(2.0,4.0), def)), DecoratedInterval(interval(2.0,4.0), trv))

    @test isequalinterval(max(DecoratedInterval(interval(-7.0,5.0), dac), DecoratedInterval(interval(2.0,4.0), def)), DecoratedInterval(interval(2.0,5.0), def))

    @test isequalinterval(max(DecoratedInterval(interval(3.0,3.5), com), DecoratedInterval(interval(2.0,4.0), com)), DecoratedInterval(interval(3.0,4.0), com))

end
