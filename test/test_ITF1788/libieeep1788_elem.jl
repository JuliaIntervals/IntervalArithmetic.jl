@testset "minimal_pos_test" begin

    @test +(interval(1.0,2.0)) === Interval(1.0,2.0)

    @test +(emptyinterval()) === emptyinterval()

    @test +(entireinterval()) === entireinterval()

    @test +(interval(1.0,Inf)) === Interval(1.0,Inf)

    @test +(interval(-Inf,-1.0)) === Interval(-Inf,-1.0)

    @test +(interval(0.0,2.0)) === Interval(0.0,2.0)

    @test +(interval(-0.0,2.0)) === Interval(0.0,2.0)

    @test +(interval(-2.5,-0.0)) === Interval(-2.5,0.0)

    @test +(interval(-2.5,0.0)) === Interval(-2.5,0.0)

    @test +(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test +(interval(0.0,0.0)) === Interval(0.0,0.0)

end

@testset "minimal_pos_dec_test" begin

    @test isnai(+(nai()))

    @test +(DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test +(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), dac)

    @test +(DecoratedInterval(interval(1.0, 2.0), com)) === DecoratedInterval(Interval(1.0, 2.0), com)

end

@testset "minimal_neg_test" begin

    @test -(interval(1.0,2.0)) === Interval(-2.0,-1.0)

    @test -(emptyinterval()) === emptyinterval()

    @test -(entireinterval()) === entireinterval()

    @test -(interval(1.0,Inf)) === Interval(-Inf,-1.0)

    @test -(interval(-Inf,1.0)) === Interval(-1.0,Inf)

    @test -(interval(0.0,2.0)) === Interval(-2.0,0.0)

    @test -(interval(-0.0,2.0)) === Interval(-2.0,0.0)

    @test -(interval(-2.0,0.0)) === Interval(0.0,2.0)

    @test -(interval(-2.0,-0.0)) === Interval(0.0,2.0)

    @test -(interval(0.0,-0.0)) === Interval(0.0,0.0)

    @test -(interval(-0.0,-0.0)) === Interval(0.0,0.0)

end

@testset "minimal_neg_dec_test" begin

    @test isnai(-(nai()))

    @test -(DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test -(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), dac)

    @test -(DecoratedInterval(interval(1.0, 2.0), com)) === DecoratedInterval(Interval(-2.0, -1.0), com)

end

@testset "minimal_add_test" begin

    @test +(emptyinterval(), emptyinterval()) === emptyinterval()

    @test +(interval(-1.0,1.0), emptyinterval()) === emptyinterval()

    @test +(emptyinterval(), interval(-1.0,1.0)) === emptyinterval()

    @test +(emptyinterval(), entireinterval()) === emptyinterval()

    @test +(entireinterval(), emptyinterval()) === emptyinterval()

    @test +(entireinterval(), interval(-Inf,1.0)) === entireinterval()

    @test +(entireinterval(), interval(-1.0,1.0)) === entireinterval()

    @test +(entireinterval(), interval(-1.0,Inf)) === entireinterval()

    @test +(entireinterval(), entireinterval()) === entireinterval()

    @test +(interval(-Inf,1.0), entireinterval()) === entireinterval()

    @test +(interval(-1.0,1.0), entireinterval()) === entireinterval()

    @test +(interval(-1.0,Inf), entireinterval()) === entireinterval()

    @test +(interval(-Inf,2.0), interval(-Inf,4.0)) === Interval(-Inf,6.0)

    @test +(interval(-Inf,2.0), interval(3.0,4.0)) === Interval(-Inf,6.0)

    @test +(interval(-Inf,2.0), interval(3.0,Inf)) === entireinterval()

    @test +(interval(1.0,2.0), interval(-Inf,4.0)) === Interval(-Inf,6.0)

    @test +(interval(1.0,2.0), interval(3.0,4.0)) === Interval(4.0,6.0)

    @test +(interval(1.0,2.0), interval(3.0,Inf)) === Interval(4.0,Inf)

    @test +(interval(1.0,Inf), interval(-Inf,4.0)) === entireinterval()

    @test +(interval(1.0,Inf), interval(3.0,4.0)) === Interval(4.0,Inf)

    @test +(interval(1.0,Inf), interval(3.0,Inf)) === Interval(4.0,Inf)

    @test +(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(3.0,4.0)) === Interval(4.0,Inf)

    @test +(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(-3.0,4.0)) === Interval(-Inf,6.0)

    @test +(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(-3.0,0x1.FFFFFFFFFFFFFp1023)) === entireinterval()

    @test +(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(0.0,0.0)) === Interval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test +(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(-0.0,-0.0)) === Interval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test +(interval(0.0,0.0), interval(-3.0,4.0)) === Interval(-3.0,4.0)

    @test +(interval(-0.0,-0.0), interval(-3.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-3.0,0x1.FFFFFFFFFFFFFp1023)

    @test +(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1)

    @test +(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)) === Interval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test +(interval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(-0x1.E666666666657P+0,0x1.0CCCCCCCCCCC5P+1)

end

@testset "minimal_add_dec_test" begin

    @test +(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), com)) === DecoratedInterval(Interval(6.0,9.0), com)

    @test +(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), def)) === DecoratedInterval(Interval(6.0,9.0), def)

    @test +(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(6.0,Inf), dac)

    @test +(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), DecoratedInterval(interval(-0.1, 5.0), com)) === DecoratedInterval(Interval(-Inf,7.0), dac)

    @test +(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test isnai(+(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_sub_test" begin

    @test -(emptyinterval(), emptyinterval()) === emptyinterval()

    @test -(interval(-1.0,1.0), emptyinterval()) === emptyinterval()

    @test -(emptyinterval(), interval(-1.0,1.0)) === emptyinterval()

    @test -(emptyinterval(), entireinterval()) === emptyinterval()

    @test -(entireinterval(), emptyinterval()) === emptyinterval()

    @test -(entireinterval(), interval(-Inf,1.0)) === entireinterval()

    @test -(entireinterval(), interval(-1.0,1.0)) === entireinterval()

    @test -(entireinterval(), interval(-1.0,Inf)) === entireinterval()

    @test -(entireinterval(), entireinterval()) === entireinterval()

    @test -(interval(-Inf,1.0), entireinterval()) === entireinterval()

    @test -(interval(-1.0,1.0), entireinterval()) === entireinterval()

    @test -(interval(-1.0,Inf), entireinterval()) === entireinterval()

    @test -(interval(-Inf,2.0), interval(-Inf,4.0)) === entireinterval()

    @test -(interval(-Inf,2.0), interval(3.0,4.0)) === Interval(-Inf,-1.0)

    @test -(interval(-Inf,2.0), interval(3.0,Inf)) === Interval(-Inf,-1.0)

    @test -(interval(1.0,2.0), interval(-Inf,4.0)) === Interval(-3.0,Inf)

    @test -(interval(1.0,2.0), interval(3.0,4.0)) === Interval(-3.0,-1.0)

    @test -(interval(1.0,2.0), interval(3.0,Inf)) === Interval(-Inf,-1.0)

    @test -(interval(1.0,Inf), interval(-Inf,4.0)) === Interval(-3.0,Inf)

    @test -(interval(1.0,Inf), interval(3.0,4.0)) === Interval(-3.0,Inf)

    @test -(interval(1.0,Inf), interval(3.0,Inf)) === entireinterval()

    @test -(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(-3.0,4.0)) === Interval(-3.0,Inf)

    @test -(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(3.0,4.0)) === Interval(-Inf,-1.0)

    @test -(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), interval(-0x1.FFFFFFFFFFFFFp1023,4.0)) === entireinterval()

    @test -(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(0.0,0.0)) === Interval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test -(interval(1.0,0x1.FFFFFFFFFFFFFp1023), interval(-0.0,-0.0)) === Interval(1.0,0x1.FFFFFFFFFFFFFp1023)

    @test -(interval(0.0,0.0), interval(-3.0,4.0)) === Interval(-4.0,3.0)

    @test -(interval(-0.0,-0.0), interval(-3.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-0x1.FFFFFFFFFFFFFp1023,3.0)

    @test -(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(0x1.E666666666656P+0,0x1.E666666666657P+0)

    @test -(interval(0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(-0x1.999999999999AP-4,-0x1.999999999999AP-4)) === Interval(0x1.0CCCCCCCCCCC4P+1,0x1.0CCCCCCCCCCC5P+1)

    @test -(interval(-0x1.FFFFFFFFFFFFP+0,0x1.FFFFFFFFFFFFP+0), interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(-0x1.0CCCCCCCCCCC5P+1,0x1.E666666666657P+0)

end

@testset "minimal_sub_dec_test" begin

    @test -(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), com)) === DecoratedInterval(Interval(-6.0,-3.0), com)

    @test -(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), def)) === DecoratedInterval(Interval(-6.0,-3.0), def)

    @test -(DecoratedInterval(interval(-1.0,2.0), com), DecoratedInterval(interval(5.0,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-Inf,-3.0), dac)

    @test -(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), DecoratedInterval(interval(-1.0, 5.0), com)) === DecoratedInterval(Interval(-Inf,3.0), dac)

    @test -(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test isnai(-(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_mul_test" begin

    @test *(emptyinterval(), emptyinterval()) === emptyinterval()

    @test *(interval(-1.0,1.0), emptyinterval()) === emptyinterval()

    @test *(emptyinterval(), interval(-1.0,1.0)) === emptyinterval()

    @test *(emptyinterval(), entireinterval()) === emptyinterval()

    @test *(entireinterval(), emptyinterval()) === emptyinterval()

    @test *(interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test *(emptyinterval(), interval(0.0,0.0)) === emptyinterval()

    @test *(interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test *(emptyinterval(), interval(-0.0,-0.0)) === emptyinterval()

    @test *(entireinterval(), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(entireinterval(), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(entireinterval(), interval(-5.0, -1.0)) === entireinterval()

    @test *(entireinterval(), interval(-5.0, 3.0)) === entireinterval()

    @test *(entireinterval(), interval(1.0, 3.0)) === entireinterval()

    @test *(entireinterval(), interval(-Inf, -1.0)) === entireinterval()

    @test *(entireinterval(), interval(-Inf, 3.0)) === entireinterval()

    @test *(entireinterval(), interval(-5.0, Inf)) === entireinterval()

    @test *(entireinterval(), interval(1.0, Inf)) === entireinterval()

    @test *(entireinterval(), entireinterval()) === entireinterval()

    @test *(interval(1.0,Inf), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(1.0,Inf), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(1.0,Inf), interval(-5.0, -1.0)) === Interval(-Inf,-1.0)

    @test *(interval(1.0,Inf), interval(-5.0, 3.0)) === entireinterval()

    @test *(interval(1.0,Inf), interval(1.0, 3.0)) === Interval(1.0,Inf)

    @test *(interval(1.0,Inf), interval(-Inf, -1.0)) === Interval(-Inf,-1.0)

    @test *(interval(1.0,Inf), interval(-Inf, 3.0)) === entireinterval()

    @test *(interval(1.0,Inf), interval(-5.0, Inf)) === entireinterval()

    @test *(interval(1.0,Inf), interval(1.0, Inf)) === Interval(1.0,Inf)

    @test *(interval(1.0,Inf), entireinterval()) === entireinterval()

    @test *(interval(-1.0,Inf), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(-1.0,Inf), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(-1.0,Inf), interval(-5.0, -1.0)) === Interval(-Inf,5.0)

    @test *(interval(-1.0,Inf), interval(-5.0, 3.0)) === entireinterval()

    @test *(interval(-1.0,Inf), interval(1.0, 3.0)) === Interval(-3.0,Inf)

    @test *(interval(-1.0,Inf), interval(-Inf, -1.0)) === entireinterval()

    @test *(interval(-1.0,Inf), interval(-Inf, 3.0)) === entireinterval()

    @test *(interval(-1.0,Inf), interval(-5.0, Inf)) === entireinterval()

    @test *(interval(-1.0,Inf), interval(1.0, Inf)) === entireinterval()

    @test *(interval(-1.0,Inf), entireinterval()) === entireinterval()

    @test *(interval(-Inf,3.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(-Inf,3.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(-Inf,3.0), interval(-5.0, -1.0)) === Interval(-15.0,Inf)

    @test *(interval(-Inf,3.0), interval(-5.0, 3.0)) === entireinterval()

    @test *(interval(-Inf,3.0), interval(1.0, 3.0)) === Interval(-Inf,9.0)

    @test *(interval(-Inf,3.0), interval(-Inf, -1.0)) === entireinterval()

    @test *(interval(-Inf,3.0), interval(-Inf, 3.0)) === entireinterval()

    @test *(interval(-Inf,3.0), interval(-5.0, Inf)) === entireinterval()

    @test *(interval(-Inf,3.0), interval(1.0, Inf)) === entireinterval()

    @test *(interval(-Inf,3.0), entireinterval()) === entireinterval()

    @test *(interval(-Inf,-3.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(-Inf,-3.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(-Inf,-3.0), interval(-5.0, -1.0)) === Interval(3.0,Inf)

    @test *(interval(-Inf,-3.0), interval(-5.0, 3.0)) === entireinterval()

    @test *(interval(-Inf,-3.0), interval(1.0, 3.0)) === Interval(-Inf,-3.0)

    @test *(interval(-Inf,-3.0), interval(-Inf, -1.0)) === Interval(3.0,Inf)

    @test *(interval(-Inf,-3.0), interval(-Inf, 3.0)) === entireinterval()

    @test *(interval(-Inf,-3.0), interval(-5.0, Inf)) === entireinterval()

    @test *(interval(-Inf,-3.0), interval(1.0, Inf)) === Interval(-Inf,-3.0)

    @test *(interval(-Inf,-3.0), entireinterval()) === entireinterval()

    @test *(interval(0.0,0.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(-5.0, -1.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(-5.0, 3.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(1.0, 3.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(-Inf, -1.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(-Inf, 3.0)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(-5.0, Inf)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), interval(1.0, Inf)) === Interval(0.0,0.0)

    @test *(interval(0.0,0.0), entireinterval()) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(-5.0, -1.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(-5.0, 3.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(1.0, 3.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(-Inf, -1.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(-Inf, 3.0)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(-5.0, Inf)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), interval(1.0, Inf)) === Interval(0.0,0.0)

    @test *(interval(-0.0,-0.0), entireinterval()) === Interval(0.0,0.0)

    @test *(interval(1.0,5.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(1.0,5.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(1.0,5.0), interval(-5.0, -1.0)) === Interval(-25.0,-1.0)

    @test *(interval(1.0,5.0), interval(-5.0, 3.0)) === Interval(-25.0,15.0)

    @test *(interval(1.0,5.0), interval(1.0, 3.0)) === Interval(1.0,15.0)

    @test *(interval(1.0,5.0), interval(-Inf, -1.0)) === Interval(-Inf,-1.0)

    @test *(interval(1.0,5.0), interval(-Inf, 3.0)) === Interval(-Inf,15.0)

    @test *(interval(1.0,5.0), interval(-5.0, Inf)) === Interval(-25.0,Inf)

    @test *(interval(1.0,5.0), interval(1.0, Inf)) === Interval(1.0,Inf)

    @test *(interval(1.0,5.0), entireinterval()) === entireinterval()

    @test *(interval(-1.0,5.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(-1.0,5.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(-1.0,5.0), interval(-5.0, -1.0)) === Interval(-25.0,5.0)

    @test *(interval(-1.0,5.0), interval(-5.0, 3.0)) === Interval(-25.0,15.0)

    @test *(interval(-10.0,2.0), interval(-5.0, 3.0)) === Interval(-30.0,50.0)

    @test *(interval(-1.0,5.0), interval(-1.0, 10.0)) === Interval(-10.0,50.0)

    @test *(interval(-2.0,2.0), interval(-5.0, 3.0)) === Interval(-10.0,10.0)

    @test *(interval(-1.0,5.0), interval(1.0, 3.0)) === Interval(-3.0,15.0)

    @test *(interval(-1.0,5.0), interval(-Inf, -1.0)) === entireinterval()

    @test *(interval(-1.0,5.0), interval(-Inf, 3.0)) === entireinterval()

    @test *(interval(-1.0,5.0), interval(-5.0, Inf)) === entireinterval()

    @test *(interval(-1.0,5.0), interval(1.0, Inf)) === entireinterval()

    @test *(interval(-1.0,5.0), entireinterval()) === entireinterval()

    @test *(interval(-10.0,-5.0), interval(0.0,0.0)) === Interval(0.0,0.0)

    @test *(interval(-10.0,-5.0), interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test *(interval(-10.0,-5.0), interval(-5.0, -1.0)) === Interval(5.0,50.0)

    @test *(interval(-10.0,-5.0), interval(-5.0, 3.0)) === Interval(-30.0,50.0)

    @test *(interval(-10.0,-5.0), interval(1.0, 3.0)) === Interval(-30.0,-5.0)

    @test *(interval(-10.0,-5.0), interval(-Inf, -1.0)) === Interval(5.0,Inf)

    @test *(interval(-10.0,-5.0), interval(-Inf, 3.0)) === Interval(-30.0,Inf)

    @test *(interval(-10.0,-5.0), interval(-5.0, Inf)) === Interval(-Inf,50.0)

    @test *(interval(-10.0,-5.0), interval(1.0, Inf)) === Interval(-Inf,-5.0)

    @test *(interval(-10.0,-5.0), entireinterval()) === entireinterval()

    @test *(interval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), interval(-0x1.FFFFFFFFFFFFP+0, Inf)) === Interval(-0x1.FFFFFFFFFFFE1P+1,Inf)

    @test *(interval(-0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0), interval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4)) === Interval(-0x1.FFFFFFFFFFFE1P+1,0x1.999999999998EP-3)

    @test *(interval(-0x1.999999999999AP-4,0x1.999999999999AP-4), interval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)) === Interval(-0x1.999999999998EP-3,0x1.999999999998EP-3)

    @test *(interval(-0x1.FFFFFFFFFFFFP+0,-0x1.999999999999AP-4), interval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)) === Interval(-0x1.FFFFFFFFFFFE1P+1,-0x1.47AE147AE147BP-7)

end

@testset "minimal_mul_dec_test" begin

    @test *(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), com)) === DecoratedInterval(Interval(5.0,14.0), com)

    @test *(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,7.0), def)) === DecoratedInterval(Interval(5.0,14.0), def)

    @test *(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(5.0,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(5.0,Inf), dac)

    @test *(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), DecoratedInterval(interval(-1.0, 5.0), com)) === DecoratedInterval(Interval(-Inf,0x1.FFFFFFFFFFFFFp1023), dac)

    @test *(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test isnai(*(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_div_test" begin

    @test /(emptyinterval(), emptyinterval()) === emptyinterval()

    @test /(interval(-1.0,1.0), emptyinterval()) === emptyinterval()

    @test /(emptyinterval(), interval(-1.0,1.0)) === emptyinterval()

    @test /(emptyinterval(), interval(0.1,1.0)) === emptyinterval()

    @test /(emptyinterval(), interval(-1.0,-0.1)) === emptyinterval()

    @test /(emptyinterval(), entireinterval()) === emptyinterval()

    @test /(entireinterval(), emptyinterval()) === emptyinterval()

    @test /(interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test /(emptyinterval(), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test /(emptyinterval(), interval(-0.0,-0.0)) === emptyinterval()

    @test /(entireinterval(), interval(-5.0, -3.0)) === entireinterval()

    @test /(entireinterval(), interval(3.0, 5.0)) === entireinterval()

    @test /(entireinterval(), interval(-Inf, -3.0)) === entireinterval()

    @test /(entireinterval(), interval(3.0,Inf)) === entireinterval()

    @test /(entireinterval(), interval(0.0,0.0)) === emptyinterval()

    @test /(entireinterval(), interval(-0.0,-0.0)) === emptyinterval()

    @test /(entireinterval(), interval(-3.0, 0.0)) === entireinterval()

    @test /(entireinterval(), interval(-3.0, -0.0)) === entireinterval()

    @test /(entireinterval(), interval(-3.0, 3.0)) === entireinterval()

    @test /(entireinterval(), interval(0.0, 3.0)) === entireinterval()

    @test /(entireinterval(), interval(-Inf, 0.0)) === entireinterval()

    @test /(entireinterval(), interval(-0.0, 3.0)) === entireinterval()

    @test /(entireinterval(), interval(-Inf, -0.0)) === entireinterval()

    @test /(entireinterval(), interval(-Inf, 3.0)) === entireinterval()

    @test /(entireinterval(), interval(-3.0, Inf)) === entireinterval()

    @test /(entireinterval(), interval(0.0, Inf)) === entireinterval()

    @test /(entireinterval(), interval(-0.0, Inf)) === entireinterval()

    @test /(entireinterval(), entireinterval()) === entireinterval()

    @test /(interval(-30.0,-15.0), interval(-5.0, -3.0)) === Interval(3.0,10.0)

    @test /(interval(-30.0,-15.0), interval(3.0, 5.0)) === Interval(-10.0,-3.0)

    @test /(interval(-30.0,-15.0), interval(-Inf, -3.0)) === Interval(0.0,10.0)

    @test /(interval(-30.0,-15.0), interval(3.0,Inf)) === Interval(-10.0,0.0)

    @test /(interval(-30.0,-15.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-30.0,-15.0), interval(-3.0, 0.0)) === Interval(5.0,Inf)

    @test /(interval(-30.0,-15.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-30.0,-15.0), interval(-3.0, -0.0)) === Interval(5.0,Inf)

    @test /(interval(-30.0,-15.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-30.0,-15.0), interval(0.0, 3.0)) === Interval(-Inf,-5.0)

    @test /(interval(-30.0,-15.0), interval(-Inf, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,-15.0), interval(-0.0, 3.0)) === Interval(-Inf,-5.0)

    @test /(interval(-30.0,-15.0), interval(-Inf, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,-15.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-30.0,-15.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-30.0,-15.0), interval(0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,-15.0), interval(-0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,-15.0), entireinterval()) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-5.0, -3.0)) === Interval(-5.0,10.0)

    @test /(interval(-30.0,15.0), interval(3.0, 5.0)) === Interval(-10.0,5.0)

    @test /(interval(-30.0,15.0), interval(-Inf, -3.0)) === Interval(-5.0,10.0)

    @test /(interval(-30.0,15.0), interval(3.0,Inf)) === Interval(-10.0,5.0)

    @test /(interval(-30.0,15.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-30.0,15.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-30.0,15.0), interval(-3.0, 0.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-3.0, -0.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(0.0, 3.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-Inf, 0.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-0.0, 3.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-Inf, -0.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(0.0, Inf)) === entireinterval()

    @test /(interval(-30.0,15.0), interval(-0.0, Inf)) === entireinterval()

    @test /(interval(-30.0,15.0), entireinterval()) === entireinterval()

    @test /(interval(15.0,30.0), interval(-5.0, -3.0)) === Interval(-10.0,-3.0)

    @test /(interval(15.0,30.0), interval(3.0, 5.0)) === Interval(3.0,10.0)

    @test /(interval(15.0,30.0), interval(-Inf, -3.0)) === Interval(-10.0,0.0)

    @test /(interval(15.0,30.0), interval(3.0,Inf)) === Interval(0.0,10.0)

    @test /(interval(15.0,30.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(15.0,30.0), interval(-3.0, 0.0)) === Interval(-Inf,-5.0)

    @test /(interval(15.0,30.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(15.0,30.0), interval(-3.0, -0.0)) === Interval(-Inf,-5.0)

    @test /(interval(15.0,30.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(15.0,30.0), interval(0.0, 3.0)) === Interval(5.0,Inf)

    @test /(interval(15.0,30.0), interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(15.0,30.0), interval(-0.0, 3.0)) === Interval(5.0,Inf)

    @test /(interval(15.0,30.0), interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(15.0,30.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(15.0,30.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(15.0,30.0), interval(0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(15.0,30.0), interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(15.0,30.0), entireinterval()) === entireinterval()

    @test /(interval(0.0,0.0), interval(-5.0, -3.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(3.0, 5.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-Inf, -3.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(3.0,Inf)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(0.0,0.0), interval(-3.0, 0.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(0.0,0.0), interval(-3.0, -0.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-3.0, 3.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(0.0, 3.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-Inf, 0.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-0.0, 3.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-Inf, -0.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-Inf, 3.0)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-3.0, Inf)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(0.0, Inf)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), interval(-0.0, Inf)) === Interval(0.0,0.0)

    @test /(interval(0.0,0.0), entireinterval()) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-5.0, -3.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(3.0, 5.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-Inf, -3.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(3.0,Inf)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-0.0,-0.0), interval(-3.0, 0.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-0.0,-0.0), interval(-3.0, -0.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-3.0, 3.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(0.0, 3.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-Inf, 0.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-0.0, 3.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-Inf, -0.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-Inf, 3.0)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-3.0, Inf)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(0.0, Inf)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), interval(-0.0, Inf)) === Interval(0.0,0.0)

    @test /(interval(-0.0,-0.0), entireinterval()) === Interval(0.0,0.0)

    @test /(interval(-Inf,-15.0), interval(-5.0, -3.0)) === Interval(3.0,Inf)

    @test /(interval(-Inf,-15.0), interval(3.0, 5.0)) === Interval(-Inf,-3.0)

    @test /(interval(-Inf,-15.0), interval(-Inf, -3.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-15.0), interval(3.0,Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-15.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-Inf,-15.0), interval(-3.0, 0.0)) === Interval(5.0,Inf)

    @test /(interval(-Inf,-15.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-Inf,-15.0), interval(-3.0, -0.0)) === Interval(5.0,Inf)

    @test /(interval(-Inf,-15.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-Inf,-15.0), interval(0.0, 3.0)) === Interval(-Inf,-5.0)

    @test /(interval(-Inf,-15.0), interval(-Inf, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-15.0), interval(-0.0, 3.0)) === Interval(-Inf,-5.0)

    @test /(interval(-Inf,-15.0), interval(-Inf, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-15.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-Inf,-15.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-Inf,-15.0), interval(0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-15.0), interval(-0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-15.0), entireinterval()) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-5.0, -3.0)) === Interval(-5.0,Inf)

    @test /(interval(-Inf,15.0), interval(3.0, 5.0)) === Interval(-Inf,5.0)

    @test /(interval(-Inf,15.0), interval(-Inf, -3.0)) === Interval(-5.0,Inf)

    @test /(interval(-Inf,15.0), interval(3.0,Inf)) === Interval(-Inf,5.0)

    @test /(interval(-Inf,15.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-Inf,15.0), interval(-3.0, 0.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-Inf,15.0), interval(-3.0, -0.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(0.0, 3.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-Inf, 0.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-0.0, 3.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-Inf, -0.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(0.0, Inf)) === entireinterval()

    @test /(interval(-Inf,15.0), interval(-0.0, Inf)) === entireinterval()

    @test /(interval(-Inf,15.0), entireinterval()) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-5.0, -3.0)) === Interval(-Inf,5.0)

    @test /(interval(-15.0,Inf), interval(3.0, 5.0)) === Interval(-5.0,Inf)

    @test /(interval(-15.0,Inf), interval(-Inf, -3.0)) === Interval(-Inf,5.0)

    @test /(interval(-15.0,Inf), interval(3.0,Inf)) === Interval(-5.0,Inf)

    @test /(interval(-15.0,Inf), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-15.0,Inf), interval(-3.0, 0.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-15.0,Inf), interval(-3.0, -0.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(0.0, 3.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-Inf, 0.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-0.0, 3.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-Inf, -0.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(0.0, Inf)) === entireinterval()

    @test /(interval(-15.0,Inf), interval(-0.0, Inf)) === entireinterval()

    @test /(interval(-15.0,Inf), entireinterval()) === entireinterval()

    @test /(interval(15.0,Inf), interval(-5.0, -3.0)) === Interval(-Inf,-3.0)

    @test /(interval(15.0,Inf), interval(3.0, 5.0)) === Interval(3.0,Inf)

    @test /(interval(15.0,Inf), interval(-Inf, -3.0)) === Interval(-Inf,0.0)

    @test /(interval(15.0,Inf), interval(3.0,Inf)) === Interval(0.0,Inf)

    @test /(interval(15.0,Inf), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(15.0,Inf), interval(-3.0, 0.0)) === Interval(-Inf,-5.0)

    @test /(interval(15.0,Inf), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(15.0,Inf), interval(-3.0, -0.0)) === Interval(-Inf,-5.0)

    @test /(interval(15.0,Inf), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(15.0,Inf), interval(0.0, 3.0)) === Interval(5.0,Inf)

    @test /(interval(15.0,Inf), interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(15.0,Inf), interval(-0.0, 3.0)) === Interval(5.0,Inf)

    @test /(interval(15.0,Inf), interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(15.0,Inf), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(15.0,Inf), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(15.0,Inf), interval(0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(15.0,Inf), interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(15.0,Inf), entireinterval()) === entireinterval()

    @test /(interval(-30.0,0.0), interval(-5.0, -3.0)) === Interval(0.0,10.0)

    @test /(interval(-30.0,0.0), interval(3.0, 5.0)) === Interval(-10.0,0.0)

    @test /(interval(-30.0,0.0), interval(-Inf, -3.0)) === Interval(0.0,10.0)

    @test /(interval(-30.0,0.0), interval(3.0,Inf)) === Interval(-10.0,0.0)

    @test /(interval(-30.0,0.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-30.0,0.0), interval(-3.0, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-30.0,0.0), interval(-3.0, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,0.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-30.0,0.0), interval(0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,0.0), interval(-Inf, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,0.0), interval(-0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,0.0), interval(-Inf, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,0.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-30.0,0.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-30.0,0.0), interval(0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,0.0), interval(-0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,0.0), entireinterval()) === entireinterval()

    @test /(interval(-30.0,-0.0), interval(-5.0, -3.0)) === Interval(0.0,10.0)

    @test /(interval(-30.0,-0.0), interval(3.0, 5.0)) === Interval(-10.0,0.0)

    @test /(interval(-30.0,-0.0), interval(-Inf, -3.0)) === Interval(0.0,10.0)

    @test /(interval(-30.0,-0.0), interval(3.0,Inf)) === Interval(-10.0,0.0)

    @test /(interval(-30.0,-0.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-30.0,-0.0), interval(-3.0, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,-0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-30.0,-0.0), interval(-3.0, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,-0.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-30.0,-0.0), interval(0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,-0.0), interval(-Inf, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,-0.0), interval(-0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,-0.0), interval(-Inf, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-30.0,-0.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-30.0,-0.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-30.0,-0.0), interval(0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,-0.0), interval(-0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-30.0,-0.0), entireinterval()) === entireinterval()

    @test /(interval(0.0,30.0), interval(-5.0, -3.0)) === Interval(-10.0,0.0)

    @test /(interval(0.0,30.0), interval(3.0, 5.0)) === Interval(0.0,10.0)

    @test /(interval(0.0,30.0), interval(-Inf, -3.0)) === Interval(-10.0,0.0)

    @test /(interval(0.0,30.0), interval(3.0,Inf)) === Interval(0.0,10.0)

    @test /(interval(0.0,30.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(0.0,30.0), interval(-3.0, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,30.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(0.0,30.0), interval(-3.0, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,30.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(0.0,30.0), interval(0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(0.0,30.0), interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,30.0), interval(-0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(0.0,30.0), interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,30.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(0.0,30.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(0.0,30.0), interval(0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(0.0,30.0), interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(0.0,30.0), entireinterval()) === entireinterval()

    @test /(interval(-0.0,30.0), interval(-5.0, -3.0)) === Interval(-10.0,0.0)

    @test /(interval(-0.0,30.0), interval(3.0, 5.0)) === Interval(0.0,10.0)

    @test /(interval(-0.0,30.0), interval(-Inf, -3.0)) === Interval(-10.0,0.0)

    @test /(interval(-0.0,30.0), interval(3.0,Inf)) === Interval(0.0,10.0)

    @test /(interval(-0.0,30.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-0.0,30.0), interval(-3.0, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,30.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-0.0,30.0), interval(-3.0, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,30.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-0.0,30.0), interval(0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(-0.0,30.0), interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,30.0), interval(-0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(-0.0,30.0), interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,30.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-0.0,30.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-0.0,30.0), interval(0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(-0.0,30.0), interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(-0.0,30.0), entireinterval()) === entireinterval()

    @test /(interval(-Inf,0.0), interval(-5.0, -3.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,0.0), interval(3.0, 5.0)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,0.0), interval(-Inf, -3.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,0.0), interval(3.0,Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,0.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-Inf,0.0), interval(-3.0, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-Inf,0.0), interval(-3.0, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,0.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-Inf,0.0), interval(0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,0.0), interval(-Inf, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,0.0), interval(-0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,0.0), interval(-Inf, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,0.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-Inf,0.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-Inf,0.0), interval(0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,0.0), interval(-0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,0.0), entireinterval()) === entireinterval()

    @test /(interval(-Inf,-0.0), interval(-5.0, -3.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-0.0), interval(3.0, 5.0)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-0.0), interval(-Inf, -3.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-0.0), interval(3.0,Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-0.0), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-Inf,-0.0), interval(-3.0, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-Inf,-0.0), interval(-3.0, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-0.0), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-Inf,-0.0), interval(0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-0.0), interval(-Inf, 0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-0.0), interval(-0.0, 3.0)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-0.0), interval(-Inf, -0.0)) === Interval(0.0,Inf)

    @test /(interval(-Inf,-0.0), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-Inf,-0.0), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-Inf,-0.0), interval(0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-0.0), interval(-0.0, Inf)) === Interval(-Inf,0.0)

    @test /(interval(-Inf,-0.0), entireinterval()) === entireinterval()

    @test /(interval(0.0,Inf), interval(-5.0, -3.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,Inf), interval(3.0, 5.0)) === Interval(0.0,Inf)

    @test /(interval(0.0,Inf), interval(-Inf, -3.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,Inf), interval(3.0,Inf)) === Interval(0.0,Inf)

    @test /(interval(0.0,Inf), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(0.0,Inf), interval(-3.0, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,Inf), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(0.0,Inf), interval(-3.0, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,Inf), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(0.0,Inf), interval(0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(0.0,Inf), interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,Inf), interval(-0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(0.0,Inf), interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(0.0,Inf), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(0.0,Inf), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(0.0,Inf), interval(0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(0.0,Inf), interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(0.0,Inf), entireinterval()) === entireinterval()

    @test /(interval(-0.0,Inf), interval(-5.0, -3.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,Inf), interval(3.0, 5.0)) === Interval(0.0,Inf)

    @test /(interval(-0.0,Inf), interval(-Inf, -3.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,Inf), interval(3.0,Inf)) === Interval(0.0,Inf)

    @test /(interval(-0.0,Inf), interval(0.0,0.0)) === emptyinterval()

    @test /(interval(-0.0,Inf), interval(-3.0, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,Inf), interval(-0.0,-0.0)) === emptyinterval()

    @test /(interval(-0.0,Inf), interval(-3.0, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,Inf), interval(-3.0, 3.0)) === entireinterval()

    @test /(interval(-0.0,Inf), interval(0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(-0.0,Inf), interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,Inf), interval(-0.0, 3.0)) === Interval(0.0,Inf)

    @test /(interval(-0.0,Inf), interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test /(interval(-0.0,Inf), interval(-Inf, 3.0)) === entireinterval()

    @test /(interval(-0.0,Inf), interval(-3.0, Inf)) === entireinterval()

    @test /(interval(-0.0,Inf), interval(0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(-0.0,Inf), interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test /(interval(-0.0,Inf), entireinterval()) === entireinterval()

    @test /(interval(-2.0,-1.0), interval(-10.0, -3.0)) === Interval(0x1.9999999999999P-4,0x1.5555555555556P-1)

    @test /(interval(-2.0,-1.0), interval(0.0, 10.0)) === Interval(-Inf,-0x1.9999999999999P-4)

    @test /(interval(-2.0,-1.0), interval(-0.0, 10.0)) === Interval(-Inf,-0x1.9999999999999P-4)

    @test /(interval(-1.0,2.0), interval(10.0,Inf)) === Interval(-0x1.999999999999AP-4,0x1.999999999999AP-3)

    @test /(interval(1.0,3.0), interval(-Inf, -10.0)) === Interval(-0x1.3333333333334P-2,0.0)

    @test /(interval(-Inf,-1.0), interval(1.0, 3.0)) === Interval(-Inf,-0x1.5555555555555P-2)

end

@testset "minimal_div_dec_test" begin

    @test /(DecoratedInterval(interval(-2.0,-1.0), com), DecoratedInterval(interval(-10.0, -3.0), com)) === DecoratedInterval(Interval(0x1.9999999999999P-4,0x1.5555555555556P-1), com)

    @test /(DecoratedInterval(interval(-200.0,-1.0), com), DecoratedInterval(interval(0x0.0000000000001p-1022, 10.0), com)) === DecoratedInterval(Interval(-Inf,-0x1.9999999999999P-4), dac)

    @test /(DecoratedInterval(interval(-2.0,-1.0), com), DecoratedInterval(interval(0.0, 10.0), com)) === DecoratedInterval(Interval(-Inf,-0x1.9999999999999P-4), trv)

    @test /(DecoratedInterval(interval(1.0,3.0), def), DecoratedInterval(interval(-Inf, -10.0), dac)) === DecoratedInterval(Interval(-0x1.3333333333334P-2,0.0), def)

    @test /(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test isnai(/(nai(), DecoratedInterval(interval(1.0,2.0), trv)))

end

@testset "minimal_recip_test" begin

    @test inv(interval(-50.0, -10.0)) === Interval(-0x1.999999999999AP-4,-0x1.47AE147AE147AP-6)

    @test inv(interval(10.0, 50.0)) === Interval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4)

    @test inv(interval(-Inf, -10.0)) === Interval(-0x1.999999999999AP-4,0.0)

    @test inv(interval(10.0,Inf)) === Interval(0.0,0x1.999999999999AP-4)

    @test inv(interval(0.0,0.0)) === emptyinterval()

    @test inv(interval(-0.0,-0.0)) === emptyinterval()

    @test inv(interval(-10.0, 0.0)) === Interval(-Inf,-0x1.9999999999999P-4)

    @test inv(interval(-10.0, -0.0)) === Interval(-Inf,-0x1.9999999999999P-4)

    @test inv(interval(-10.0, 10.0)) === entireinterval()

    @test inv(interval(0.0, 10.0)) === Interval(0x1.9999999999999P-4,Inf)

    @test inv(interval(-0.0, 10.0)) === Interval(0x1.9999999999999P-4,Inf)

    @test inv(interval(-Inf, 0.0)) === Interval(-Inf,0.0)

    @test inv(interval(-Inf, -0.0)) === Interval(-Inf,0.0)

    @test inv(interval(-Inf, 10.0)) === entireinterval()

    @test inv(interval(-10.0, Inf)) === entireinterval()

    @test inv(interval(0.0, Inf)) === Interval(0.0,Inf)

    @test inv(interval(-0.0, Inf)) === Interval(0.0,Inf)

    @test inv(entireinterval()) === entireinterval()

end

@testset "minimal_recip_dec_test" begin

    @test inv(DecoratedInterval(interval(10.0, 50.0), com)) === DecoratedInterval(Interval(0x1.47AE147AE147AP-6,0x1.999999999999AP-4), com)

    @test inv(DecoratedInterval(interval(-Inf, -10.0), dac)) === DecoratedInterval(Interval(-0x1.999999999999AP-4,0.0), dac)

    @test inv(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023, -0x0.0000000000001p-1022), def)) === DecoratedInterval(Interval(-Inf,-0x0.4P-1022), def)

    @test inv(DecoratedInterval(interval(0.0,0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test inv(DecoratedInterval(interval(-10.0, 0.0), com)) === DecoratedInterval(Interval(-Inf,-0x1.9999999999999P-4), trv)

    @test inv(DecoratedInterval(interval(-10.0, Inf), dac)) === DecoratedInterval(entireinterval(), trv)

    @test inv(DecoratedInterval(interval(-0.0, Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test inv(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_sqr_test" begin

    @test emptyinterval()^2 === emptyinterval()

    @test entireinterval()^2 === Interval(0.0,Inf)

    @test interval(-Inf,-0x0.0000000000001p-1022)^2 === Interval(0.0,Inf)

    @test interval(-1.0,1.0)^2 === Interval(0.0,1.0)

    @test interval(0.0,1.0)^2 === Interval(0.0,1.0)

    @test interval(-0.0,1.0)^2 === Interval(0.0,1.0)

    @test interval(-5.0,3.0)^2 === Interval(0.0,25.0)

    @test interval(-5.0,0.0)^2 === Interval(0.0,25.0)

    @test interval(-5.0,-0.0)^2 === Interval(0.0,25.0)

    @test interval(0x1.999999999999AP-4,0x1.999999999999AP-4)^2 === Interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7)

    @test interval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)^2 === Interval(0.0,0x1.FFFFFFFFFFFE1P+1)

    @test interval(-0x1.FFFFFFFFFFFFP+0,-0x1.FFFFFFFFFFFFP+0)^2 === Interval(0x1.FFFFFFFFFFFEP+1,0x1.FFFFFFFFFFFE1P+1)

end

@testset "minimal_sqr_dec_test" begin

    @test DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x0.0000000000001p-1022), com)^2 === DecoratedInterval(Interval(0.0,Inf), dac)

    @test DecoratedInterval(interval(-1.0,1.0), def)^2 === DecoratedInterval(Interval(0.0,1.0), def)

    @test DecoratedInterval(interval(-5.0,3.0), com)^2 === DecoratedInterval(Interval(0.0,25.0), com)

    @test DecoratedInterval(interval(0x1.999999999999AP-4,0x1.999999999999AP-4), com)^2 === DecoratedInterval(Interval(0x1.47AE147AE147BP-7,0x1.47AE147AE147CP-7), com)

end

@testset "minimal_sqrt_test" begin

    @test sqrt(emptyinterval()) === emptyinterval()

    @test sqrt(entireinterval()) === Interval(0.0,Inf)

    @test sqrt(interval(-Inf,-0x0.0000000000001p-1022)) === emptyinterval()

    @test sqrt(interval(-1.0,1.0)) === Interval(0.0,1.0)

    @test sqrt(interval(0.0,1.0)) === Interval(0.0,1.0)

    @test sqrt(interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test sqrt(interval(-5.0,25.0)) === Interval(0.0,5.0)

    @test sqrt(interval(0.0,25.0)) === Interval(0.0,5.0)

    @test sqrt(interval(-0.0,25.0)) === Interval(0.0,5.0)

    @test sqrt(interval(-5.0,Inf)) === Interval(0.0,Inf)

    @test sqrt(interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(0x1.43D136248490FP-2,0x1.43D136248491P-2)

    @test sqrt(interval(-0x1.FFFFFFFFFFFFP+0,0x1.999999999999AP-4)) === Interval(0.0,0x1.43D136248491P-2)

    @test sqrt(interval(0x1.999999999999AP-4,0x1.FFFFFFFFFFFFP+0)) === Interval(0x1.43D136248490FP-2,0x1.6A09E667F3BC7P+0)

end

@testset "minimal_sqrt_dec_test" begin

    @test sqrt(DecoratedInterval(interval(1.0,4.0), com)) === DecoratedInterval(Interval(1.0,2.0), com)

    @test sqrt(DecoratedInterval(interval(-5.0,25.0), com)) === DecoratedInterval(Interval(0.0,5.0), trv)

    @test sqrt(DecoratedInterval(interval(0.0,25.0), def)) === DecoratedInterval(Interval(0.0,5.0), def)

    @test sqrt(DecoratedInterval(interval(-5.0,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

end

@testset "minimal_fma_test" begin

    @test fma(emptyinterval(), emptyinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,1.0), emptyinterval(), emptyinterval()) === emptyinterval()

    @test fma(emptyinterval(), interval(-1.0,1.0), emptyinterval()) === emptyinterval()

    @test fma(emptyinterval(), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), emptyinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), emptyinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), emptyinterval(), emptyinterval()) === emptyinterval()

    @test fma(emptyinterval(), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(emptyinterval(), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(entireinterval(), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,Inf), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,Inf), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,3.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-Inf,-3.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(1.0,5.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,2.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-1.0, 10.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-2.0,2.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-1.0,5.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(1.0, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(-Inf, -1.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(-Inf, 3.0), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), interval(1.0, Inf), emptyinterval()) === emptyinterval()

    @test fma(interval(-10.0,-5.0), entireinterval(), emptyinterval()) === emptyinterval()

    @test fma(emptyinterval(), emptyinterval(), interval(-Inf,2.0)) === emptyinterval()

    @test fma(interval(-1.0,1.0), emptyinterval(), interval(-Inf,2.0)) === emptyinterval()

    @test fma(emptyinterval(), interval(-1.0,1.0), interval(-Inf,2.0)) === emptyinterval()

    @test fma(emptyinterval(), entireinterval(), interval(-Inf,2.0)) === emptyinterval()

    @test fma(entireinterval(), emptyinterval(), interval(-Inf,2.0)) === emptyinterval()

    @test fma(interval(0.0,0.0), emptyinterval(), interval(-Inf,2.0)) === emptyinterval()

    @test fma(interval(-0.0,-0.0), emptyinterval(), interval(-Inf,2.0)) === emptyinterval()

    @test fma(emptyinterval(), interval(0.0,0.0), interval(-Inf,2.0)) === emptyinterval()

    @test fma(emptyinterval(), interval(-0.0,-0.0), interval(-Inf,2.0)) === emptyinterval()

    @test fma(entireinterval(), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(entireinterval(), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(entireinterval(), interval(-5.0, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(1.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(1.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(entireinterval(), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(1.0,Inf), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(1.0,Inf), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,Inf), interval(-5.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-Inf, -1.0), interval(-Inf,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,Inf), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-1.0,Inf), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-1.0,Inf), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,7.0)

    @test fma(interval(-1.0,Inf), interval(-5.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-Inf,3.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-Inf,3.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,11.0)

    @test fma(interval(-Inf,3.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-Inf,-3.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-Inf,-3.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,-1.0)

    @test fma(interval(-Inf,-3.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,-1.0)

    @test fma(interval(-Inf,-3.0), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(0.0,0.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(-5.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), interval(1.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(0.0,0.0), entireinterval(), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(-5.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), interval(1.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-0.0,-0.0), entireinterval(), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(1.0,5.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(1.0,5.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(1.0,5.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,5.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,17.0)

    @test fma(interval(1.0,5.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,17.0)

    @test fma(interval(1.0,5.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,5.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === Interval(-Inf,17.0)

    @test fma(interval(1.0,5.0), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,5.0), interval(1.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(1.0,5.0), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-1.0,5.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-1.0,5.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,7.0)

    @test fma(interval(-1.0,5.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,17.0)

    @test fma(interval(-10.0,2.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,52.0)

    @test fma(interval(-1.0,5.0), interval(-1.0, 10.0), interval(-Inf,2.0)) === Interval(-Inf,52.0)

    @test fma(interval(-2.0,2.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,12.0)

    @test fma(interval(-1.0,5.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,17.0)

    @test fma(interval(-1.0,5.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, Inf), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(0.0,0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-10.0,-5.0), interval(-0.0,-0.0), interval(-Inf,2.0)) === Interval(-Inf,2.0)

    @test fma(interval(-10.0,-5.0), interval(-5.0, -1.0), interval(-Inf,2.0)) === Interval(-Inf,52.0)

    @test fma(interval(-10.0,-5.0), interval(-5.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,52.0)

    @test fma(interval(-10.0,-5.0), interval(1.0, 3.0), interval(-Inf,2.0)) === Interval(-Inf,-3.0)

    @test fma(interval(-10.0,-5.0), interval(-Inf, -1.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-Inf, 3.0), interval(-Inf,2.0)) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,52.0)

    @test fma(interval(-10.0,-5.0), interval(1.0, Inf), interval(-Inf,2.0)) === Interval(-Inf,-3.0)

    @test fma(interval(-10.0,-5.0), entireinterval(), interval(-Inf,2.0)) === entireinterval()

    @test fma(emptyinterval(), emptyinterval(), interval(-2.0,2.0)) === emptyinterval()

    @test fma(interval(-1.0,1.0), emptyinterval(), interval(-2.0,2.0)) === emptyinterval()

    @test fma(emptyinterval(), interval(-1.0,1.0), interval(-2.0,2.0)) === emptyinterval()

    @test fma(emptyinterval(), entireinterval(), interval(-2.0,2.0)) === emptyinterval()

    @test fma(entireinterval(), emptyinterval(), interval(-2.0,2.0)) === emptyinterval()

    @test fma(interval(0.0,0.0), emptyinterval(), interval(-2.0,2.0)) === emptyinterval()

    @test fma(interval(-0.0,-0.0), emptyinterval(), interval(-2.0,2.0)) === emptyinterval()

    @test fma(emptyinterval(), interval(0.0,0.0), interval(-2.0,2.0)) === emptyinterval()

    @test fma(emptyinterval(), interval(-0.0,-0.0), interval(-2.0,2.0)) === emptyinterval()

    @test fma(entireinterval(), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(entireinterval(), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(entireinterval(), interval(-5.0, -1.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(1.0, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, -1.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), interval(1.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(entireinterval(), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(1.0,Inf), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(1.0,Inf), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,Inf), interval(-5.0, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,Inf), interval(-Inf, -1.0), interval(-2.0,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,Inf), interval(-Inf, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, Inf), interval(-2.0,2.0)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,Inf), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-1.0,Inf), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-1.0,Inf), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-Inf,7.0)

    @test fma(interval(-1.0,Inf), interval(-5.0, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-5.0,Inf)

    @test fma(interval(-1.0,Inf), interval(-Inf, -1.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,Inf), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-Inf,3.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-Inf,3.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-17.0,Inf)

    @test fma(interval(-Inf,3.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-Inf,11.0)

    @test fma(interval(-Inf,3.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,3.0), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-Inf,-3.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-Inf,-3.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(1.0,Inf)

    @test fma(interval(-Inf,-3.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-Inf,-1.0)

    @test fma(interval(-Inf,-3.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === Interval(1.0,Inf)

    @test fma(interval(-Inf,-3.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, Inf), interval(-2.0,2.0)) === Interval(-Inf,-1.0)

    @test fma(interval(-Inf,-3.0), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(0.0,0.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(-5.0, Inf), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), interval(1.0, Inf), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(0.0,0.0), entireinterval(), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(-5.0, Inf), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), interval(1.0, Inf), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-0.0,-0.0), entireinterval(), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(1.0,5.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(1.0,5.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(1.0,5.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-27.0,1.0)

    @test fma(interval(1.0,5.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-27.0,17.0)

    @test fma(interval(1.0,5.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-1.0,17.0)

    @test fma(interval(1.0,5.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === Interval(-Inf,1.0)

    @test fma(interval(1.0,5.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === Interval(-Inf,17.0)

    @test fma(interval(1.0,5.0), interval(-5.0, Inf), interval(-2.0,2.0)) === Interval(-27.0,Inf)

    @test fma(interval(1.0,5.0), interval(1.0, Inf), interval(-2.0,2.0)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,5.0), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-1.0,5.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-1.0,5.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(-27.0,7.0)

    @test fma(interval(-1.0,5.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-27.0,17.0)

    @test fma(interval(-10.0,2.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-32.0,52.0)

    @test fma(interval(-1.0,5.0), interval(-1.0, 10.0), interval(-2.0,2.0)) === Interval(-12.0,52.0)

    @test fma(interval(-2.0,2.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-12.0,12.0)

    @test fma(interval(-1.0,5.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-5.0,17.0)

    @test fma(interval(-1.0,5.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, Inf), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-1.0,5.0), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(0.0,0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-10.0,-5.0), interval(-0.0,-0.0), interval(-2.0,2.0)) === Interval(-2.0,2.0)

    @test fma(interval(-10.0,-5.0), interval(-5.0, -1.0), interval(-2.0,2.0)) === Interval(3.0,52.0)

    @test fma(interval(-10.0,-5.0), interval(-5.0, 3.0), interval(-2.0,2.0)) === Interval(-32.0,52.0)

    @test fma(interval(-10.0,-5.0), interval(1.0, 3.0), interval(-2.0,2.0)) === Interval(-32.0,-3.0)

    @test fma(interval(-10.0,-5.0), interval(-Inf, -1.0), interval(-2.0,2.0)) === Interval(3.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-Inf, 3.0), interval(-2.0,2.0)) === Interval(-32.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-5.0, Inf), interval(-2.0,2.0)) === Interval(-Inf,52.0)

    @test fma(interval(-10.0,-5.0), interval(1.0, Inf), interval(-2.0,2.0)) === Interval(-Inf,-3.0)

    @test fma(interval(-10.0,-5.0), entireinterval(), interval(-2.0,2.0)) === entireinterval()

    @test fma(emptyinterval(), emptyinterval(), interval(-2.0,Inf)) === emptyinterval()

    @test fma(interval(-1.0,1.0), emptyinterval(), interval(-2.0,Inf)) === emptyinterval()

    @test fma(emptyinterval(), interval(-1.0,1.0), interval(-2.0,Inf)) === emptyinterval()

    @test fma(emptyinterval(), entireinterval(), interval(-2.0,Inf)) === emptyinterval()

    @test fma(entireinterval(), emptyinterval(), interval(-2.0,Inf)) === emptyinterval()

    @test fma(interval(0.0,0.0), emptyinterval(), interval(-2.0,Inf)) === emptyinterval()

    @test fma(interval(-0.0,-0.0), emptyinterval(), interval(-2.0,Inf)) === emptyinterval()

    @test fma(emptyinterval(), interval(0.0,0.0), interval(-2.0,Inf)) === emptyinterval()

    @test fma(emptyinterval(), interval(-0.0,-0.0), interval(-2.0,Inf)) === emptyinterval()

    @test fma(entireinterval(), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(entireinterval(), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(entireinterval(), interval(-5.0, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), interval(1.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), interval(1.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(entireinterval(), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(1.0,Inf), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(1.0,Inf), interval(-5.0, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,Inf), interval(-Inf, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, Inf), interval(-2.0,Inf)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,Inf), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-1.0,Inf), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-1.0,Inf), interval(-5.0, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-5.0,Inf)

    @test fma(interval(-1.0,Inf), interval(-Inf, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,Inf), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-Inf,3.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-Inf,3.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(-17.0,Inf)

    @test fma(interval(-Inf,3.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,3.0), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-Inf,-3.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-Inf,-3.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(1.0,Inf)

    @test fma(interval(-Inf,-3.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === Interval(1.0,Inf)

    @test fma(interval(-Inf,-3.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-Inf,-3.0), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(0.0,0.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(-5.0, Inf), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), interval(1.0, Inf), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(0.0,0.0), entireinterval(), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(-5.0, Inf), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), interval(1.0, Inf), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-0.0,-0.0), entireinterval(), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(1.0,5.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(1.0,5.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(1.0,5.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(-27.0,Inf)

    @test fma(interval(1.0,5.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-27.0,Inf)

    @test fma(interval(1.0,5.0), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,5.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, Inf), interval(-2.0,Inf)) === Interval(-27.0,Inf)

    @test fma(interval(1.0,5.0), interval(1.0, Inf), interval(-2.0,Inf)) === Interval(-1.0,Inf)

    @test fma(interval(1.0,5.0), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-1.0,5.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-1.0,5.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(-27.0,Inf)

    @test fma(interval(-1.0,5.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-27.0,Inf)

    @test fma(interval(-10.0,2.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-32.0,Inf)

    @test fma(interval(-1.0,5.0), interval(-1.0, 10.0), interval(-2.0,Inf)) === Interval(-12.0,Inf)

    @test fma(interval(-2.0,2.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-12.0,Inf)

    @test fma(interval(-1.0,5.0), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-5.0,Inf)

    @test fma(interval(-1.0,5.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-1.0,5.0), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(0.0,0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-0.0,-0.0), interval(-2.0,Inf)) === Interval(-2.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-5.0, -1.0), interval(-2.0,Inf)) === Interval(3.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-5.0, 3.0), interval(-2.0,Inf)) === Interval(-32.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(1.0, 3.0), interval(-2.0,Inf)) === Interval(-32.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-Inf, -1.0), interval(-2.0,Inf)) === Interval(3.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-Inf, 3.0), interval(-2.0,Inf)) === Interval(-32.0,Inf)

    @test fma(interval(-10.0,-5.0), interval(-5.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(1.0, Inf), interval(-2.0,Inf)) === entireinterval()

    @test fma(interval(-10.0,-5.0), entireinterval(), interval(-2.0,Inf)) === entireinterval()

    @test fma(emptyinterval(), emptyinterval(), entireinterval()) === emptyinterval()

    @test fma(interval(-1.0,1.0), emptyinterval(), entireinterval()) === emptyinterval()

    @test fma(emptyinterval(), interval(-1.0,1.0), entireinterval()) === emptyinterval()

    @test fma(emptyinterval(), entireinterval(), entireinterval()) === emptyinterval()

    @test fma(entireinterval(), emptyinterval(), entireinterval()) === emptyinterval()

    @test fma(interval(0.0,0.0), emptyinterval(), entireinterval()) === emptyinterval()

    @test fma(interval(-0.0,-0.0), emptyinterval(), entireinterval()) === emptyinterval()

    @test fma(emptyinterval(), interval(0.0,0.0), entireinterval()) === emptyinterval()

    @test fma(emptyinterval(), interval(-0.0,-0.0), entireinterval()) === emptyinterval()

    @test fma(entireinterval(), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(entireinterval(), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(entireinterval(), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(1.0,Inf), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,Inf), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,3.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-Inf,-3.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(0.0,0.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-0.0,-0.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(1.0,5.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,2.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-1.0, 10.0), entireinterval()) === entireinterval()

    @test fma(interval(-2.0,2.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-1.0,5.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(0.0,0.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-0.0,-0.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(1.0, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-Inf, -1.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-Inf, 3.0), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(-5.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test fma(interval(-10.0,-5.0), entireinterval(), entireinterval()) === entireinterval()

    @test fma(interval(0.1,0.5), interval(-5.0, 3.0), interval(-0.1,0.1)) === Interval(-0x1.4CCCCCCCCCCCDP+1,0x1.999999999999AP+0)

    @test fma(interval(-0.5,0.2), interval(-5.0, 3.0), interval(-0.1,0.1)) === Interval(-0x1.999999999999AP+0,0x1.4CCCCCCCCCCCDP+1)

    @test fma(interval(-0.5,-0.1), interval(2.0, 3.0), interval(-0.1,0.1)) === Interval(-0x1.999999999999AP+0,-0x1.999999999999AP-4)

    @test fma(interval(-0.5,-0.1), interval(-Inf, 3.0), interval(-0.1,0.1)) === Interval(-0x1.999999999999AP+0,Inf)

end

@testset "minimal_fma_dec_test" begin

    @test fma(DecoratedInterval(interval(-0.5,-0.1), com), DecoratedInterval(interval(-Inf, 3.0), dac), DecoratedInterval(interval(-0.1,0.1), com)) === DecoratedInterval(Interval(-0x1.999999999999AP+0,Inf), dac)

    @test fma(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(1.0, 0x1.FFFFFFFFFFFFFp1023), com), DecoratedInterval(interval(0.0,1.0), com)) === DecoratedInterval(Interval(1.0,Inf), dac)

    @test fma(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(1.0, 2.0), com), DecoratedInterval(interval(2.0,5.0), com)) === DecoratedInterval(Interval(3.0,9.0), com)

end

@testset "minimal_pown_test" begin

    @test ^(emptyinterval(), 0) === emptyinterval()

    @test ^(entireinterval(), 0) === Interval(1.0,1.0)

    @test ^(interval(0.0,0.0), 0) === Interval(1.0,1.0)

    @test ^(interval(-0.0,-0.0), 0) === Interval(1.0,1.0)

    @test ^(interval(13.1,13.1), 0) === Interval(1.0,1.0)

    @test ^(interval(-7451.145,-7451.145), 0) === Interval(1.0,1.0)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 0) === Interval(1.0,1.0)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 0) === Interval(1.0,1.0)

    @test ^(interval(0.0,Inf), 0) === Interval(1.0,1.0)

    @test ^(interval(-0.0,Inf), 0) === Interval(1.0,1.0)

    @test ^(interval(-Inf,0.0), 0) === Interval(1.0,1.0)

    @test ^(interval(-Inf,-0.0), 0) === Interval(1.0,1.0)

    @test ^(interval(-324.3,2.5), 0) === Interval(1.0,1.0)

    @test ^(emptyinterval(), 2) === emptyinterval()

    @test ^(entireinterval(), 2) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.0), 2) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), 2) === Interval(0.0,0.0)

    @test ^(interval(13.1,13.1), 2) === Interval(0x1.573851EB851EBP+7,0x1.573851EB851ECP+7)

    @test ^(interval(-7451.145,-7451.145), 2) === Interval(0x1.A794A4E7CFAADP+25,0x1.A794A4E7CFAAEP+25)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 2) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 2) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ^(interval(0.0,Inf), 2) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), 2) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), 2) === Interval(0.0,Inf)

    @test ^(interval(-Inf,-0.0), 2) === Interval(0.0,Inf)

    @test ^(interval(-324.3,2.5), 2) === Interval(0.0,0x1.9AD27D70A3D72P+16)

    @test ^(interval(0.01,2.33), 2) === Interval(0x1.A36E2EB1C432CP-14,0x1.5B7318FC50482P+2)

    @test ^(interval(-1.9,-0.33), 2) === Interval(0x1.BE0DED288CE7P-4,0x1.CE147AE147AE1P+1)

    @test ^(emptyinterval(), 8) === emptyinterval()

    @test ^(entireinterval(), 8) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.0), 8) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), 8) === Interval(0.0,0.0)

    @test ^(interval(13.1,13.1), 8) === Interval(0x1.9D8FD495853F5P+29,0x1.9D8FD495853F6P+29)

    @test ^(interval(-7451.145,-7451.145), 8) === Interval(0x1.DFB1BB622E70DP+102,0x1.DFB1BB622E70EP+102)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 8) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 8) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ^(interval(0.0,Inf), 8) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), 8) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), 8) === Interval(0.0,Inf)

    @test ^(interval(-Inf,-0.0), 8) === Interval(0.0,Inf)

    @test ^(interval(-324.3,2.5), 8) === Interval(0.0,0x1.A87587109655P+66)

    @test ^(interval(0.01,2.33), 8) === Interval(0x1.CD2B297D889BDP-54,0x1.B253D9F33CE4DP+9)

    @test ^(interval(-1.9,-0.33), 8) === Interval(0x1.26F1FCDD502A3P-13,0x1.53ABD7BFC4FC6P+7)

    @test ^(emptyinterval(), 1) === emptyinterval()

    @test ^(entireinterval(), 1) === entireinterval()

    @test ^(interval(0.0,0.0), 1) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), 1) === Interval(0.0,0.0)

    @test ^(interval(13.1,13.1), 1) === Interval(13.1,13.1)

    @test ^(interval(-7451.145,-7451.145), 1) === Interval(-7451.145,-7451.145)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 1) === Interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 1) === Interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023)

    @test ^(interval(0.0,Inf), 1) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), 1) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), 1) === Interval(-Inf,0.0)

    @test ^(interval(-Inf,-0.0), 1) === Interval(-Inf,0.0)

    @test ^(interval(-324.3,2.5), 1) === Interval(-324.3,2.5)

    @test ^(interval(0.01,2.33), 1) === Interval(0.01,2.33)

    @test ^(interval(-1.9,-0.33), 1) === Interval(-1.9,-0.33)

    @test ^(emptyinterval(), 3) === emptyinterval()

    @test ^(entireinterval(), 3) === entireinterval()

    @test ^(interval(0.0,0.0), 3) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), 3) === Interval(0.0,0.0)

    @test ^(interval(13.1,13.1), 3) === Interval(0x1.1902E978D4FDEP+11,0x1.1902E978D4FDFP+11)

    @test ^(interval(-7451.145,-7451.145), 3) === Interval(-0x1.81460637B9A3DP+38,-0x1.81460637B9A3CP+38)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 3) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 3) === Interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)

    @test ^(interval(0.0,Inf), 3) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), 3) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), 3) === Interval(-Inf,0.0)

    @test ^(interval(-Inf,-0.0), 3) === Interval(-Inf,0.0)

    @test ^(interval(-324.3,2.5), 3) === Interval(-0x1.0436D2F418938P+25,0x1.F4P+3)

    @test ^(interval(0.01,2.33), 3) === Interval(0x1.0C6F7A0B5ED8DP-20,0x1.94C75E6362A6P+3)

    @test ^(interval(-1.9,-0.33), 3) === Interval(-0x1.B6F9DB22D0E55P+2,-0x1.266559F6EC5B1P-5)

    @test ^(emptyinterval(), 7) === emptyinterval()

    @test ^(entireinterval(), 7) === entireinterval()

    @test ^(interval(0.0,0.0), 7) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), 7) === Interval(0.0,0.0)

    @test ^(interval(13.1,13.1), 7) === Interval(0x1.F91D1B185493BP+25,0x1.F91D1B185493CP+25)

    @test ^(interval(-7451.145,-7451.145), 7) === Interval(-0x1.07B1DA32F9B59P+90,-0x1.07B1DA32F9B58P+90)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), 7) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), 7) === Interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)

    @test ^(interval(0.0,Inf), 7) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), 7) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), 7) === Interval(-Inf,0.0)

    @test ^(interval(-Inf,-0.0), 7) === Interval(-Inf,0.0)

    @test ^(interval(-324.3,2.5), 7) === Interval(-0x1.4F109959E6D7FP+58,0x1.312DP+9)

    @test ^(interval(0.01,2.33), 7) === Interval(0x1.6849B86A12B9BP-47,0x1.74D0373C76313P+8)

    @test ^(interval(-1.9,-0.33), 7) === Interval(-0x1.658C775099757P+6,-0x1.BEE30301BF47AP-12)

    @test ^(emptyinterval(), -2) === emptyinterval()

    @test ^(entireinterval(), -2) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.0), -2) === emptyinterval()

    @test ^(interval(-0.0,-0.0), -2) === emptyinterval()

    @test ^(interval(13.1,13.1), -2) === Interval(0x1.7DE3A077D1568P-8,0x1.7DE3A077D1569P-8)

    @test ^(interval(-7451.145,-7451.145), -2) === Interval(0x1.3570290CD6E14P-26,0x1.3570290CD6E15P-26)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -2) === Interval(0x0P+0,0x0.0000000000001P-1022)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -2) === Interval(0x0P+0,0x0.0000000000001P-1022)

    @test ^(interval(0.0,Inf), -2) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), -2) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), -2) === Interval(0.0,Inf)

    @test ^(interval(-Inf,-0.0), -2) === Interval(0.0,Inf)

    @test ^(interval(-324.3,2.5), -2) === Interval(0x1.3F0C482C977C9P-17,Inf)

    @test ^(interval(0.01,2.33), -2) === Interval(0x1.793D85EF38E47P-3,0x1.388P+13)

    @test ^(interval(-1.9,-0.33), -2) === Interval(0x1.1BA81104F6C8P-2,0x1.25D8FA1F801E1P+3)

    @test ^(emptyinterval(), -8) === emptyinterval()

    @test ^(entireinterval(), -8) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.0), -8) === emptyinterval()

    @test ^(interval(-0.0,-0.0), -8) === emptyinterval()

    @test ^(interval(13.1,13.1), -8) === Interval(0x1.3CEF39247CA6DP-30,0x1.3CEF39247CA6EP-30)

    @test ^(interval(-7451.145,-7451.145), -8) === Interval(0x1.113D9EF0A99ACP-103,0x1.113D9EF0A99ADP-103)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -8) === Interval(0x0P+0,0x0.0000000000001P-1022)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -8) === Interval(0x0P+0,0x0.0000000000001P-1022)

    @test ^(interval(0.0,Inf), -8) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), -8) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), -8) === Interval(0.0,Inf)

    @test ^(interval(-Inf,-0.0), -8) === Interval(0.0,Inf)

    @test ^(interval(-324.3,2.5), -8) === Interval(0x1.34CC3764D1E0CP-67,Inf)

    @test ^(interval(0.01,2.33), -8) === Interval(0x1.2DC80DB11AB7CP-10,0x1.1C37937E08P+53)

    @test ^(interval(-1.9,-0.33), -8) === Interval(0x1.81E104E61630DP-8,0x1.BC64F21560E34P+12)

    @test ^(emptyinterval(), -1) === emptyinterval()

    @test ^(entireinterval(), -1) === entireinterval()

    @test ^(interval(0.0,0.0), -1) === emptyinterval()

    @test ^(interval(-0.0,-0.0), -1) === emptyinterval()

    @test ^(interval(13.1,13.1), -1) === Interval(0x1.38ABF82EE6986P-4,0x1.38ABF82EE6987P-4)

    @test ^(interval(-7451.145,-7451.145), -1) === Interval(-0x1.197422C9048BFP-13,-0x1.197422C9048BEP-13)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -1) === Interval(0x0.4P-1022,0x0.4000000000001P-1022)

    @test ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -1) === Interval(-0x0.4000000000001P-1022,-0x0.4P-1022)

    @test ^(interval(0.0,Inf), -1) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), -1) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), -1) === Interval(-Inf,0.0)

    @test ^(interval(-Inf,-0.0), -1) === Interval(-Inf,0.0)

    @test ^(interval(-324.3,2.5), -1) === entireinterval()

    @test ^(interval(0.01,2.33), -1) === Interval(0x1.B77C278DBBE13P-2,0x1.9P+6)

    @test ^(interval(-1.9,-0.33), -1) === Interval(-0x1.83E0F83E0F83EP+1,-0x1.0D79435E50D79P-1)

    @test ^(emptyinterval(), -3) === emptyinterval()

    @test ^(entireinterval(), -3) === entireinterval()

    @test ^(interval(0.0,0.0), -3) === emptyinterval()

    @test ^(interval(-0.0,-0.0), -3) === emptyinterval()

    @test ^(interval(13.1,13.1), -3) === Interval(0x1.D26DF4D8B1831P-12,0x1.D26DF4D8B1832P-12)

    @test ^(interval(-7451.145,-7451.145), -3) === Interval(-0x1.54347DED91B19P-39,-0x1.54347DED91B18P-39)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -3) === Interval(0x0P+0,0x0.0000000000001P-1022)

    @test_skip ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -3) === Interval(-0x0.0000000000001P-1022,-0x0P+0)

    @test ^(interval(0.0,Inf), -3) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), -3) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), -3) === Interval(-Inf,0.0)

    @test ^(interval(-Inf,-0.0), -3) === Interval(-Inf,0.0)

    @test ^(interval(-324.3,2.5), -3) === entireinterval()

    @test ^(interval(0.01,2.33), -3) === Interval(0x1.43CFBA61AACABP-4,0x1.E848P+19)

    @test ^(interval(-1.9,-0.33), -3) === Interval(-0x1.BD393CE9E8E7CP+4,-0x1.2A95F6F7C066CP-3)

    @test ^(emptyinterval(), -7) === emptyinterval()

    @test ^(entireinterval(), -7) === entireinterval()

    @test ^(interval(0.0,0.0), -7) === emptyinterval()

    @test ^(interval(-0.0,-0.0), -7) === emptyinterval()

    @test ^(interval(13.1,13.1), -7) === Interval(0x1.037D76C912DBCP-26,0x1.037D76C912DBDP-26)

    @test ^(interval(-7451.145,-7451.145), -7) === Interval(-0x1.F10F41FB8858FP-91,-0x1.F10F41FB8858EP-91)

    @test ^(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), -7) === Interval(0x0P+0,0x0.0000000000001P-1022)

    @test_skip ^(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), -7) === Interval(-0x0.0000000000001P-1022,-0x0P+0)

    @test ^(interval(0.0,Inf), -7) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), -7) === Interval(0.0,Inf)

    @test ^(interval(-Inf,0.0), -7) === Interval(-Inf,0.0)

    @test ^(interval(-Inf,-0.0), -7) === Interval(-Inf,0.0)

    @test ^(interval(-324.3,2.5), -7) === entireinterval()

    @test ^(interval(0.01,2.33), -7) === Interval(0x1.5F934D64162A9P-9,0x1.6BCC41E9P+46)

    @test ^(interval(-1.9,-0.33), -7) === Interval(-0x1.254CDD3711DDBP+11,-0x1.6E95C4A761E19P-7)

end

@testset "minimal_pown_dec_test" begin

    @test ^(DecoratedInterval(interval(-5.0,10.0), com), 0) === DecoratedInterval(Interval(1.0,1.0), com)

    @test ^(DecoratedInterval(interval(-Inf,15.0), dac), 0) === DecoratedInterval(Interval(1.0,1.0), dac)

    @test ^(DecoratedInterval(interval(-3.0,5.0), def), 2) === DecoratedInterval(Interval(0.0,25.0), def)

    @test ^(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), 2) === DecoratedInterval(Interval(0.0,Inf), dac)

    @test ^(DecoratedInterval(interval(-3.0,5.0), dac), 3) === DecoratedInterval(Interval(-27.0,125.0), dac)

    @test ^(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,2.0), com), 3) === DecoratedInterval(Interval(-Inf, 8.0), dac)

    @test ^(DecoratedInterval(interval(3.0,5.0), com), -2) === DecoratedInterval(Interval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), com)

    @test ^(DecoratedInterval(interval(-5.0,-3.0), def), -2) === DecoratedInterval(Interval(0x1.47AE147AE147AP-5,0x1.C71C71C71C71DP-4), def)

    @test ^(DecoratedInterval(interval(-5.0,3.0), com), -2) === DecoratedInterval(Interval(0x1.47AE147AE147AP-5,Inf), trv)

    @test ^(DecoratedInterval(interval(3.0,5.0), dac), -3) === DecoratedInterval(Interval(0x1.0624DD2F1A9FBP-7 ,0x1.2F684BDA12F69P-5), dac)

    @test ^(DecoratedInterval(interval(-3.0,5.0), com), -3) === DecoratedInterval(entireinterval(), trv)

end

@testset "minimal_pow_test" begin

    @test ^(emptyinterval(), emptyinterval()) === emptyinterval()

    @test ^(emptyinterval(), entireinterval()) === emptyinterval()

    @test ^(emptyinterval(), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(-Inf,0.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(0.0,Inf)) === emptyinterval()

    @test ^(emptyinterval(), interval(-0.0,Inf)) === emptyinterval()

    @test ^(emptyinterval(), interval(1.0,Inf)) === emptyinterval()

    @test ^(emptyinterval(), interval(-3.0,5.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(0.0,0.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(-5.0,-5.0)) === emptyinterval()

    @test ^(emptyinterval(), interval(5.0,5.0)) === emptyinterval()

    @test ^(interval(0.1,0.5), emptyinterval()) === emptyinterval()

    @test ^(interval(0.1,0.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.1,0.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.1,0.5), interval(0.0,1.0)) === Interval(0x1.999999999999AP-4,1.0)

    @test ^(interval(0.1,0.5), interval(-0.0,1.0)) === Interval(0x1.999999999999AP-4,1.0)

    @test ^(interval(0.1,0.5), interval(0.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,0.5), interval(-0.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,0.5), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,0.5), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,0.5), interval(0.1,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1)

    @test ^(interval(0.1,0.5), interval(0.1,1.0)) === Interval(0x1.999999999999AP-4,0x1.DDB680117AB13P-1)

    @test ^(interval(0.1,0.5), interval(0.1,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.DDB680117AB13P-1)

    @test ^(interval(0.1,0.5), interval(0.1,Inf)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(0.1,0.5), interval(1.0,1.0)) === Interval(0x1.999999999999AP-4,0x1P-1)

    @test ^(interval(0.1,0.5), interval(1.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1P-1)

    @test ^(interval(0.1,0.5), interval(1.0,Inf)) === Interval(0.0,0x1P-1)

    @test ^(interval(0.1,0.5), interval(2.5,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.6A09E667F3BCDP-3)

    @test ^(interval(0.1,0.5), interval(2.5,Inf)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(0.1,0.5), interval(-0.1,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,0.5), interval(-0.1,1.0)) === Interval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,0.5), interval(-0.1,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,0.5), interval(-0.1,Inf)) === Interval(0.0,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,0.5), interval(-1.0,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-1.0,1.0)) === Interval(0x1.999999999999AP-4,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-1.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-1.0,Inf)) === Interval(0.0,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-2.5,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-2.5,1.0)) === Interval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-2.5,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-2.5,Inf)) === Interval(0.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-Inf,0.1)) === Interval(0x1.96B230BCDC434P-1,Inf)

    @test ^(interval(0.1,0.5), interval(-Inf,1.0)) === Interval(0x1.999999999999AP-4,Inf)

    @test ^(interval(0.1,0.5), interval(-Inf,2.5)) === Interval(0x1.9E7C6E43390B7P-9,Inf)

    @test ^(interval(0.1,0.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.1,0.5), interval(-1.0,0.0)) === Interval(1.0,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-1.0,-0.0)) === Interval(1.0,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-2.5,0.0)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-2.5,-0.0)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.1,0.5), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.1,0.5), interval(-0.1,-0.1)) === Interval(0x1.125FBEE250664P+0,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,0.5), interval(-1.0,-0.1)) === Interval(0x1.125FBEE250664P+0,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-2.5,-0.1)) === Interval(0x1.125FBEE250664P+0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-Inf,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(0.1,0.5), interval(-1.0,-1.0)) === Interval(0x1P+1,0x1.4P+3)

    @test ^(interval(0.1,0.5), interval(-2.5,-1.0)) === Interval(0x1P+1,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-Inf,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(0.1,0.5), interval(-2.5,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,0.5), interval(-Inf,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(0.1,1.0), emptyinterval()) === emptyinterval()

    @test ^(interval(0.1,1.0), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.1,1.0), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.1,1.0), interval(0.0,1.0)) === Interval(0x1.999999999999AP-4,1.0)

    @test ^(interval(0.1,1.0), interval(-0.0,1.0)) === Interval(0x1.999999999999AP-4,1.0)

    @test ^(interval(0.1,1.0), interval(0.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,1.0), interval(-0.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,1.0), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,1.0), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,1.0), interval(0.1,0.1)) === Interval(0x1.96B230BCDC434P-1,1.0)

    @test ^(interval(0.1,1.0), interval(0.1,1.0)) === Interval(0x1.999999999999AP-4,1.0)

    @test ^(interval(0.1,1.0), interval(0.1,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,1.0), interval(0.1,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,1.0), interval(1.0,1.0)) === Interval(0x1.999999999999AP-4,1.0)

    @test ^(interval(0.1,1.0), interval(1.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,1.0), interval(1.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,1.0), interval(2.5,2.5)) === Interval(0x1.9E7C6E43390B7P-9,1.0)

    @test ^(interval(0.1,1.0), interval(2.5,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.1,1.0), interval(-0.1,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-0.1,1.0)) === Interval(0x1.999999999999AP-4,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-0.1,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-0.1,Inf)) === Interval(0.0,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-1.0,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-1.0,1.0)) === Interval(0x1.999999999999AP-4,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-1.0,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-1.0,Inf)) === Interval(0.0,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-2.5,0.1)) === Interval(0x1.96B230BCDC434P-1,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-2.5,1.0)) === Interval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-2.5,2.5)) === Interval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-2.5,Inf)) === Interval(0.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-Inf,0.1)) === Interval(0x1.96B230BCDC434P-1,Inf)

    @test ^(interval(0.1,1.0), interval(-Inf,1.0)) === Interval(0x1.999999999999AP-4,Inf)

    @test ^(interval(0.1,1.0), interval(-Inf,2.5)) === Interval(0x1.9E7C6E43390B7P-9,Inf)

    @test ^(interval(0.1,1.0), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.1,1.0), interval(-0.1,0.0)) === Interval(1.0,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-0.1,-0.0)) === Interval(1.0,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-1.0,0.0)) === Interval(1.0,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-1.0,-0.0)) === Interval(1.0,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-2.5,0.0)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-2.5,-0.0)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.1,1.0), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.1,1.0), interval(-0.1,-0.1)) === Interval(1.0,0x1.4248EF8FC2604P+0)

    @test ^(interval(0.1,1.0), interval(-1.0,-0.1)) === Interval(1.0,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-2.5,-0.1)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-Inf,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(0.1,1.0), interval(-1.0,-1.0)) === Interval(1.0,0x1.4P+3)

    @test ^(interval(0.1,1.0), interval(-2.5,-1.0)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-Inf,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(0.1,1.0), interval(-2.5,-2.5)) === Interval(1.0,0x1.3C3A4EDFA9758P+8)

    @test ^(interval(0.1,1.0), interval(-Inf,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(0.5,1.5), emptyinterval()) === emptyinterval()

    @test ^(interval(0.5,1.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.5,1.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.5,1.5), interval(0.0,1.0)) === Interval(0.5,1.5)

    @test ^(interval(0.5,1.5), interval(-0.0,1.0)) === Interval(0.5,1.5)

    @test ^(interval(0.5,1.5), interval(0.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(-0.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,1.5), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,1.5), interval(0.1,0.1)) === Interval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(0.5,1.5), interval(0.1,1.0)) === Interval(0.5,1.5)

    @test ^(interval(0.5,1.5), interval(0.1,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,1.5), interval(1.0,1.0)) === Interval(0.5,1.5)

    @test ^(interval(0.5,1.5), interval(1.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,1.5), interval(2.5,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,1.5), interval(-0.1,0.1)) === Interval(0x1.DDB680117AB12P-1,0x1.125FBEE250665P+0)

    @test ^(interval(0.5,1.5), interval(-0.1,1.0)) === Interval(0x1P-1,0x1.8P+0)

    @test ^(interval(0.5,1.5), interval(-0.1,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(-0.1,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-1.0,0.1)) === Interval(0x1.5555555555555P-1,0x1P+1)

    @test ^(interval(0.5,1.5), interval(-1.0,1.0)) === Interval(0x1P-1,0x1P+1)

    @test ^(interval(0.5,1.5), interval(-1.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.5,1.5), interval(-1.0,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-2.5,0.1)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-2.5,1.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-2.5,2.5)) === Interval(0x1.6A09E667F3BCCP-3,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-2.5,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-Inf,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-Inf,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-Inf,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), entireinterval()) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-1.0,0.0)) === Interval(0x1.5555555555555P-1,0x1P+1)

    @test ^(interval(0.5,1.5), interval(-1.0,-0.0)) === Interval(0x1.5555555555555P-1,0x1P+1)

    @test ^(interval(0.5,1.5), interval(-2.5,0.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-2.5,-0.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-Inf,0.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-Inf,-0.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-0.1,-0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.125FBEE250665P+0)

    @test ^(interval(0.5,1.5), interval(-1.0,-0.1)) === Interval(0x1.5555555555555P-1,0x1P+1)

    @test ^(interval(0.5,1.5), interval(-2.5,-0.1)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-Inf,-0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-1.0,-1.0)) === Interval(0x1.5555555555555P-1,0x1P+1)

    @test ^(interval(0.5,1.5), interval(-2.5,-1.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-Inf,-1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,1.5), interval(-2.5,-2.5)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,1.5), interval(-Inf,-2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(0.5,Inf), emptyinterval()) === emptyinterval()

    @test ^(interval(0.5,Inf), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.5,Inf), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.5,Inf), interval(0.0,1.0)) === Interval(0.5,Inf)

    @test ^(interval(0.5,Inf), interval(-0.0,1.0)) === Interval(0.5,Inf)

    @test ^(interval(0.5,Inf), interval(0.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,Inf)

    @test ^(interval(0.5,Inf), interval(-0.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,Inf)

    @test ^(interval(0.5,Inf), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(0.1,0.1)) === Interval(0x1.DDB680117AB12P-1,Inf)

    @test ^(interval(0.5,Inf), interval(0.1,1.0)) === Interval(0.5,Inf)

    @test ^(interval(0.5,Inf), interval(0.1,2.5)) === Interval(0x1.6A09E667F3BCCP-3,Inf)

    @test ^(interval(0.5,Inf), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(1.0,1.0)) === Interval(0.5,Inf)

    @test ^(interval(0.5,Inf), interval(1.0,2.5)) === Interval(0x1.6A09E667F3BCCP-3,Inf)

    @test ^(interval(0.5,Inf), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(2.5,2.5)) === Interval(0x1.6A09E667F3BCCP-3,Inf)

    @test ^(interval(0.5,Inf), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-1.0,0.0)) === Interval(0.0,0x1P+1)

    @test ^(interval(0.5,Inf), interval(-1.0,-0.0)) === Interval(0.0,0x1P+1)

    @test ^(interval(0.5,Inf), interval(-2.5,0.0)) === Interval(0.0,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,Inf), interval(-2.5,-0.0)) === Interval(0.0,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,Inf), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-0.1,-0.1)) === Interval(0.0,0x1.125FBEE250665P+0)

    @test ^(interval(0.5,Inf), interval(-1.0,-0.1)) === Interval(0.0,0x1P+1)

    @test ^(interval(0.5,Inf), interval(-2.5,-0.1)) === Interval(0.0,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,Inf), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-1.0,-1.0)) === Interval(0.0,0x1P+1)

    @test ^(interval(0.5,Inf), interval(-2.5,-1.0)) === Interval(0.0,0x1.6A09E667F3BCDP+2)

    @test ^(interval(0.5,Inf), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.5,Inf), interval(-2.5,-2.5)) === Interval(0.0,0x1.6A09E667F3BCDP+2)

    @test ^(interval(1.0,1.5), emptyinterval()) === emptyinterval()

    @test ^(interval(1.0,1.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.0,1.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.0,1.5), interval(0.0,1.0)) === Interval(1.0,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(-0.0,1.0)) === Interval(1.0,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(0.0,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(-0.0,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,1.5), interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,1.5), interval(0.1,0.1)) === Interval(1.0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.0,1.5), interval(0.1,1.0)) === Interval(1.0,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(0.1,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(0.1,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,1.5), interval(1.0,1.0)) === Interval(1.0,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(1.0,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(1.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,1.5), interval(2.5,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(2.5,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,1.5), interval(-0.1,0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.0,1.5), interval(-0.1,1.0)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(-0.1,2.5)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(-0.1,Inf)) === Interval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test ^(interval(1.0,1.5), interval(-1.0,0.1)) === Interval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.0,1.5), interval(-1.0,1.0)) === Interval(0x1.5555555555555P-1,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(-1.0,2.5)) === Interval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(-1.0,Inf)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(1.0,1.5), interval(-2.5,0.1)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.0,1.5), interval(-2.5,1.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(-2.5,2.5)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), interval(-2.5,Inf)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(1.0,1.5), interval(-Inf,0.1)) === Interval(0x0P+0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.0,1.5), interval(-Inf,1.0)) === Interval(0x0P+0,0x1.8P+0)

    @test ^(interval(1.0,1.5), interval(-Inf,2.5)) === Interval(0x0P+0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.0,1.5), entireinterval()) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,1.5), interval(-1.0,0.0)) === Interval(0x1.5555555555555P-1,1.0)

    @test ^(interval(1.0,1.5), interval(-1.0,-0.0)) === Interval(0x1.5555555555555P-1,1.0)

    @test ^(interval(1.0,1.5), interval(-2.5,0.0)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.0,1.5), interval(-2.5,-0.0)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.0,1.5), interval(-Inf,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,1.5), interval(-Inf,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,1.5), interval(-0.1,-0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,1.0)

    @test ^(interval(1.0,1.5), interval(-1.0,-0.1)) === Interval(0x1.5555555555555P-1,1.0)

    @test ^(interval(1.0,1.5), interval(-2.5,-0.1)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.0,1.5), interval(-Inf,-0.1)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,1.5), interval(-1.0,-1.0)) === Interval(0x1.5555555555555P-1,1.0)

    @test ^(interval(1.0,1.5), interval(-2.5,-1.0)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.0,1.5), interval(-Inf,-1.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,1.5), interval(-2.5,-2.5)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.0,1.5), interval(-Inf,-2.5)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), emptyinterval()) === emptyinterval()

    @test ^(interval(1.0,Inf), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.0,Inf), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.0,Inf), interval(0.0,1.0)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.0,1.0)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(0.0,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.0,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(0.1,0.1)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(0.1,1.0)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(0.1,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(0.1,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(1.0,1.0)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(1.0,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(1.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(2.5,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(2.5,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.1,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.1,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.1,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-0.1,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-1.0,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-1.0,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-1.0,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-1.0,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-2.5,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-2.5,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-2.5,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-2.5,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-Inf,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-Inf,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-Inf,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), entireinterval()) === Interval(0x0P+0,Inf)

    @test ^(interval(1.0,Inf), interval(-1.0,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-1.0,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-2.5,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-2.5,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-Inf,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-Inf,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-0.1,-0.1)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-1.0,-0.1)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-2.5,-0.1)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-Inf,-0.1)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-1.0,-1.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-2.5,-1.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-Inf,-1.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-2.5,-2.5)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.0,Inf), interval(-Inf,-2.5)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,1.5), emptyinterval()) === emptyinterval()

    @test ^(interval(1.1,1.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.1,1.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.1,1.5), interval(0.0,1.0)) === Interval(1.0,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(-0.0,1.0)) === Interval(1.0,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(0.0,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(-0.0,2.5)) === Interval(1.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.1,1.5), interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.1,1.5), interval(0.1,0.1)) === Interval(0x1.02739C65D58BFP+0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.1,1.5), interval(0.1,1.0)) === Interval(0x1.02739C65D58BFP+0,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(0.1,2.5)) === Interval(0x1.02739C65D58BFP+0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(0.1,Inf)) === Interval(0x1.02739C65D58BFP+0,Inf)

    @test ^(interval(1.1,1.5), interval(1.0,1.0)) === Interval(0x1.199999999999AP+0,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(1.0,2.5)) === Interval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(1.0,Inf)) === Interval(0x1.199999999999AP+0,Inf)

    @test ^(interval(1.1,1.5), interval(2.5,2.5)) === Interval(0x1.44E1080833B25P+0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(2.5,Inf)) === Interval(0x1.44E1080833B25P+0,Inf)

    @test ^(interval(1.1,1.5), interval(-0.1,0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.1,1.5), interval(-0.1,1.0)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(-0.1,2.5)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(-0.1,Inf)) === Interval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test ^(interval(1.1,1.5), interval(-1.0,0.1)) === Interval(0x1.5555555555555P-1,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.1,1.5), interval(-1.0,1.0)) === Interval(0x1.5555555555555P-1,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(-1.0,2.5)) === Interval(0x1.5555555555555P-1,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(-1.0,Inf)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(1.1,1.5), interval(-2.5,0.1)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.1,1.5), interval(-2.5,1.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(-2.5,2.5)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), interval(-2.5,Inf)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(1.1,1.5), interval(-Inf,0.1)) === Interval(0x0P+0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(1.1,1.5), interval(-Inf,1.0)) === Interval(0x0P+0,0x1.8P+0)

    @test ^(interval(1.1,1.5), interval(-Inf,2.5)) === Interval(0x0P+0,0x1.60B9FD68A4555P+1)

    @test ^(interval(1.1,1.5), entireinterval()) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,1.5), interval(-1.0,0.0)) === Interval(0x1.5555555555555P-1,1.0)

    @test ^(interval(1.1,1.5), interval(-1.0,-0.0)) === Interval(0x1.5555555555555P-1,1.0)

    @test ^(interval(1.1,1.5), interval(-2.5,0.0)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.1,1.5), interval(-2.5,-0.0)) === Interval(0x1.7398BF1D1EE6FP-2,1.0)

    @test ^(interval(1.1,1.5), interval(-Inf,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,1.5), interval(-Inf,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,1.5), interval(-0.1,-0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,1.5), interval(-1.0,-0.1)) === Interval(0x1.5555555555555P-1,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,1.5), interval(-2.5,-0.1)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,1.5), interval(-Inf,-0.1)) === Interval(0x0P+0,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,1.5), interval(-1.0,-1.0)) === Interval(0x1.5555555555555P-1,0x1.D1745D1745D17P-1)

    @test ^(interval(1.1,1.5), interval(-2.5,-1.0)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.D1745D1745D17P-1)

    @test ^(interval(1.1,1.5), interval(-Inf,-1.0)) === Interval(0x0P+0,0x1.D1745D1745D17P-1)

    @test ^(interval(1.1,1.5), interval(-2.5,-2.5)) === Interval(0x1.7398BF1D1EE6FP-2,0x1.9372D999784C8P-1)

    @test ^(interval(1.1,1.5), interval(-Inf,-2.5)) === Interval(0x0P+0,0x1.9372D999784C8P-1)

    @test ^(interval(1.1,Inf), emptyinterval()) === emptyinterval()

    @test ^(interval(1.1,Inf), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.1,Inf), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(1.1,Inf), interval(0.0,1.0)) === Interval(1.0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.0,1.0)) === Interval(1.0,Inf)

    @test ^(interval(1.1,Inf), interval(0.0,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.0,2.5)) === Interval(1.0,Inf)

    @test ^(interval(1.1,Inf), interval(0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test ^(interval(1.1,Inf), interval(0.1,0.1)) === Interval(0x1.02739C65D58BFP+0,Inf)

    @test ^(interval(1.1,Inf), interval(0.1,1.0)) === Interval(0x1.02739C65D58BFP+0,Inf)

    @test ^(interval(1.1,Inf), interval(0.1,2.5)) === Interval(0x1.02739C65D58BFP+0,Inf)

    @test ^(interval(1.1,Inf), interval(0.1,Inf)) === Interval(0x1.02739C65D58BFP+0,Inf)

    @test ^(interval(1.1,Inf), interval(1.0,1.0)) === Interval(0x1.199999999999AP+0,Inf)

    @test ^(interval(1.1,Inf), interval(1.0,2.5)) === Interval(0x1.199999999999AP+0,Inf)

    @test ^(interval(1.1,Inf), interval(1.0,Inf)) === Interval(0x1.199999999999AP+0,Inf)

    @test ^(interval(1.1,Inf), interval(2.5,2.5)) === Interval(0x1.44E1080833B25P+0,Inf)

    @test ^(interval(1.1,Inf), interval(2.5,Inf)) === Interval(0x1.44E1080833B25P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.1,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.1,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.1,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-0.1,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-1.0,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-1.0,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-1.0,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-1.0,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-2.5,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-2.5,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-2.5,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-2.5,Inf)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-Inf,0.1)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-Inf,1.0)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-Inf,2.5)) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), entireinterval()) === Interval(0x0P+0,Inf)

    @test ^(interval(1.1,Inf), interval(-1.0,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,Inf), interval(-1.0,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,Inf), interval(-2.5,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,Inf), interval(-2.5,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,Inf), interval(-Inf,0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,Inf), interval(-Inf,-0.0)) === Interval(0x0P+0,1.0)

    @test ^(interval(1.1,Inf), interval(-0.1,-0.1)) === Interval(0x0P+0,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,Inf), interval(-1.0,-0.1)) === Interval(0x0P+0,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,Inf), interval(-2.5,-0.1)) === Interval(0x0P+0,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,Inf), interval(-Inf,-0.1)) === Interval(0x0P+0,0x1.FB24AF5281928P-1)

    @test ^(interval(1.1,Inf), interval(-1.0,-1.0)) === Interval(0x0P+0,0x1.D1745D1745D17P-1)

    @test ^(interval(1.1,Inf), interval(-2.5,-1.0)) === Interval(0x0P+0,0x1.D1745D1745D17P-1)

    @test ^(interval(1.1,Inf), interval(-Inf,-1.0)) === Interval(0x0P+0,0x1.D1745D1745D17P-1)

    @test ^(interval(1.1,Inf), interval(-2.5,-2.5)) === Interval(0x0P+0,0x1.9372D999784C8P-1)

    @test ^(interval(1.1,Inf), interval(-Inf,-2.5)) === Interval(0x0P+0,0x1.9372D999784C8P-1)

    @test ^(interval(0.0,0.5), emptyinterval()) === emptyinterval()

    @test ^(interval(0.0,0.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,0.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,0.5), interval(0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(0.0,0.5), interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(0.0,0.5), interval(0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,0.5), interval(-0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,0.5), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,0.5), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,0.5), interval(0.1,0.1)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(0.0,0.5), interval(0.1,1.0)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(0.0,0.5), interval(0.1,2.5)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(0.0,0.5), interval(0.1,Inf)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(0.0,0.5), interval(1.0,1.0)) === Interval(0.0,0.5)

    @test ^(interval(0.0,0.5), interval(1.0,2.5)) === Interval(0.0,0.5)

    @test ^(interval(0.0,0.5), interval(1.0,Inf)) === Interval(0.0,0.5)

    @test ^(interval(0.0,0.5), interval(2.5,2.5)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(0.0,0.5), interval(2.5,Inf)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(0.0,0.5), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,0.5), interval(-0.1,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(0.0,0.5), interval(-1.0,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(0.0,0.5), interval(-2.5,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(0.0,0.5), interval(-Inf,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(0.0,1.0), emptyinterval()) === emptyinterval()

    @test ^(interval(0.0,1.0), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,1.0), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(-0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.1,0.1)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.1,1.0)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.1,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(0.1,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(1.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(1.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(1.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(2.5,2.5)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(2.5,Inf)) === Interval(0.0,1.0)

    @test ^(interval(0.0,1.0), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.0), interval(-0.1,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-0.1,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-0.1,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-1.0,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-2.5,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.0), interval(-Inf,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(0.0,1.5), emptyinterval()) === emptyinterval()

    @test ^(interval(0.0,1.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,1.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,1.5), interval(0.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(0.0,1.5), interval(-0.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(0.0,1.5), interval(0.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.0,1.5), interval(-0.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.0,1.5), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(0.1,0.1)) === Interval(0.0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(0.0,1.5), interval(0.1,1.0)) === Interval(0.0,1.5)

    @test ^(interval(0.0,1.5), interval(0.1,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.0,1.5), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(1.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(0.0,1.5), interval(1.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.0,1.5), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(2.5,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(0.0,1.5), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,0.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,-0.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,0.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,-0.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-0.1,-0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,-0.1)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,-0.1)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-1.0,-1.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,-1.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,1.5), interval(-2.5,-2.5)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(0.0,1.5), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), emptyinterval()) === emptyinterval()

    @test ^(interval(0.0,Inf), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,Inf), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(0.0,Inf), interval(0.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(0.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-0.1,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-1.0,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,Inf), interval(-2.5,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.0,0.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,0.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,0.5), interval(0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,0.5), interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,0.5), interval(0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,0.5), interval(-0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,0.5), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,0.5), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,0.5), interval(0.1,0.1)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.0,0.5), interval(0.1,1.0)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.0,0.5), interval(0.1,2.5)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.0,0.5), interval(0.1,Inf)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.0,0.5), interval(1.0,1.0)) === Interval(0.0,0.5)

    @test ^(interval(-0.0,0.5), interval(1.0,2.5)) === Interval(0.0,0.5)

    @test ^(interval(-0.0,0.5), interval(1.0,Inf)) === Interval(0.0,0.5)

    @test ^(interval(-0.0,0.5), interval(2.5,2.5)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(-0.0,0.5), interval(2.5,Inf)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(-0.0,0.5), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,0.5), interval(-0.1,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.0,0.5), interval(-1.0,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(-0.0,0.5), interval(-2.5,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(-0.0,0.5), interval(-Inf,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(-0.0,1.0), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.0,1.0), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,1.0), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(-0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.1,0.1)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.1,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.1,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(0.1,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(1.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(1.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(1.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(2.5,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(2.5,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.0,1.0), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-0.1,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-0.1,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-0.1,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-1.0,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-2.5,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.0), interval(-Inf,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(-0.0,1.5), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.0,1.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,1.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,1.5), interval(0.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.0,1.5), interval(-0.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.0,1.5), interval(0.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.0,1.5), interval(-0.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.0,1.5), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(0.1,0.1)) === Interval(0.0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(-0.0,1.5), interval(0.1,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.0,1.5), interval(0.1,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.0,1.5), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(1.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.0,1.5), interval(1.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.0,1.5), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(2.5,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.0,1.5), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,0.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,-0.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,0.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,-0.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-0.1,-0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,-0.1)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,-0.1)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-1.0,-1.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,-1.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,1.5), interval(-2.5,-2.5)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.0,1.5), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.0,Inf), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,Inf), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.0,Inf), interval(0.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(0.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-0.1,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-1.0,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.0,Inf), interval(-2.5,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.1,0.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,0.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,0.5), interval(0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,0.5), interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,0.5), interval(0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,0.5), interval(-0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,0.5), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,0.5), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,0.5), interval(0.1,0.1)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.1,0.5), interval(0.1,1.0)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.1,0.5), interval(0.1,2.5)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.1,0.5), interval(0.1,Inf)) === Interval(0.0,0x1.DDB680117AB13P-1)

    @test ^(interval(-0.1,0.5), interval(1.0,1.0)) === Interval(0.0,0.5)

    @test ^(interval(-0.1,0.5), interval(1.0,2.5)) === Interval(0.0,0.5)

    @test ^(interval(-0.1,0.5), interval(1.0,Inf)) === Interval(0.0,0.5)

    @test ^(interval(-0.1,0.5), interval(2.5,2.5)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(-0.1,0.5), interval(2.5,Inf)) === Interval(0.0,0x1.6A09E667F3BCDP-3)

    @test ^(interval(-0.1,0.5), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,0.5), interval(-0.1,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,-0.1)) === Interval(0x1.125FBEE250664P+0,Inf)

    @test ^(interval(-0.1,0.5), interval(-1.0,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,-1.0)) === Interval(0x1P+1,Inf)

    @test ^(interval(-0.1,0.5), interval(-2.5,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(-0.1,0.5), interval(-Inf,-2.5)) === Interval(0x1.6A09E667F3BCCP+2,Inf)

    @test ^(interval(-0.1,1.0), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.1,1.0), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,1.0), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(-0.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(-0.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.1,0.1)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.1,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.1,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(0.1,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(1.0,1.0)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(1.0,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(1.0,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(2.5,2.5)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(2.5,Inf)) === Interval(0.0,1.0)

    @test ^(interval(-0.1,1.0), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-0.1,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-0.1,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-0.1,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,-0.1)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-1.0,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,-1.0)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-2.5,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.0), interval(-Inf,-2.5)) === Interval(1.0,Inf)

    @test ^(interval(-0.1,1.5), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.1,1.5), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,1.5), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,1.5), interval(0.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.1,1.5), interval(-0.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.1,1.5), interval(0.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.1,1.5), interval(-0.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.1,1.5), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(0.1,0.1)) === Interval(0.0,0x1.0A97DCE72A0CBP+0)

    @test ^(interval(-0.1,1.5), interval(0.1,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.1,1.5), interval(0.1,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.1,1.5), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(1.0,1.0)) === Interval(0.0,1.5)

    @test ^(interval(-0.1,1.5), interval(1.0,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.1,1.5), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(2.5,2.5)) === Interval(0.0,0x1.60B9FD68A4555P+1)

    @test ^(interval(-0.1,1.5), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,0.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,-0.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,0.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,-0.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-0.1,-0.1)) === Interval(0x1.EBA7C9E4D31E9P-1,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,-0.1)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,-0.1)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-1.0,-1.0)) === Interval(0x1.5555555555555P-1,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,-1.0)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,1.5), interval(-2.5,-2.5)) === Interval(0x1.7398BF1D1EE6FP-2,Inf)

    @test ^(interval(-0.1,1.5), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.1,Inf), interval(0.0,0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,Inf), interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test ^(interval(-0.1,Inf), interval(0.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(0.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.1,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.1,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.1,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.1,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,Inf)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), entireinterval()) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,-0.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-0.1,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,-0.1)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-1.0,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,-1.0)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-Inf,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(-0.1,Inf), interval(-2.5,-2.5)) === Interval(0.0,Inf)

    @test ^(interval(0.0,0.0), emptyinterval()) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-1.0,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-2.5,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-2.5,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-Inf,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-Inf,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), entireinterval()) === Interval(0.0,0.0)

    @test ^(interval(0.0,0.0), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(0.0,0.0), interval(-2.5,-2.5)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-1.0,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-2.5,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-2.5,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-Inf,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-Inf,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), entireinterval()) === Interval(0.0,0.0)

    @test ^(interval(-0.0,-0.0), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(-0.0,-0.0), interval(-2.5,-2.5)) === emptyinterval()

    @test ^(interval(-0.0,0.0), emptyinterval()) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-1.0,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-2.5,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-2.5,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-Inf,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-Inf,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), entireinterval()) === Interval(0.0,0.0)

    @test ^(interval(-0.0,0.0), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(-0.0,0.0), interval(-2.5,-2.5)) === emptyinterval()

    @test ^(interval(0.0,-0.0), emptyinterval()) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-1.0,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-2.5,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-2.5,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-Inf,0.1)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-Inf,2.5)) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), entireinterval()) === Interval(0.0,0.0)

    @test ^(interval(0.0,-0.0), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(0.0,-0.0), interval(-2.5,-2.5)) === emptyinterval()

    @test ^(interval(-1.0,0.0), emptyinterval()) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-1.0,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-2.5,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-2.5,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-Inf,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-Inf,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), entireinterval()) === Interval(0.0,0.0)

    @test ^(interval(-1.0,0.0), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(-1.0,0.0), interval(-2.5,-2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), emptyinterval()) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.1,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.1,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.1,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-0.1,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-1.0,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-1.0,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-1.0,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-1.0,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-2.5,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-2.5,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-2.5,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-2.5,Inf)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-Inf,0.1)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-Inf,2.5)) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), entireinterval()) === Interval(0.0,0.0)

    @test ^(interval(-1.0,-0.0), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.0), interval(-2.5,-2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), emptyinterval()) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.0,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.0,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.0,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.0,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.0,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.0,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.0,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.0,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.1,0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.1,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.1,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(0.1,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(1.0,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(1.0,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(1.0,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(2.5,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(2.5,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.1,0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.1,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.1,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.1,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,Inf)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), entireinterval()) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,-0.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-0.1,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,-0.1)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-1.0,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,-1.0)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-Inf,-2.5)) === emptyinterval()

    @test ^(interval(-1.0,-0.1), interval(-2.5,-2.5)) === emptyinterval()

end

@testset "minimal_pow_dec_test" begin

    @test ^(DecoratedInterval(interval(0.1,0.5), com), DecoratedInterval(interval(0.0,1.0), com)) === DecoratedInterval(Interval(0x1.999999999999AP-4,1.0), com)

    @test ^(DecoratedInterval(interval(0.1,0.5), com), DecoratedInterval(interval(0.1,0.1), def)) === DecoratedInterval(Interval(0x1.96B230BCDC434P-1,0x1.DDB680117AB13P-1), def)

    @test ^(DecoratedInterval(interval(0.1,0.5), trv), DecoratedInterval(interval(-2.5,2.5), dac)) === DecoratedInterval(Interval(0x1.9E7C6E43390B7P-9,0x1.3C3A4EDFA9758P+8), trv)

    @test ^(DecoratedInterval(interval(0.1,0.5), com), DecoratedInterval(interval(-2.5,Inf), dac)) === DecoratedInterval(Interval(0.0,0x1.3C3A4EDFA9758P+8), dac)

    @test ^(DecoratedInterval(interval(0.1,0.5), trv), DecoratedInterval(interval(-Inf,0.1), dac)) === DecoratedInterval(Interval(0x1.96B230BCDC434P-1,Inf), trv)

    @test ^(DecoratedInterval(interval(0.1,1.0), com), DecoratedInterval(interval(0.0,2.5), com)) === DecoratedInterval(Interval(0x1.9E7C6E43390B7P-9,1.0), com)

    @test ^(DecoratedInterval(interval(0.1,1.0), def), DecoratedInterval(interval(1.0,1.0), dac)) === DecoratedInterval(Interval(0x1.999999999999AP-4,1.0), def)

    @test ^(DecoratedInterval(interval(0.1,1.0), trv), DecoratedInterval(interval(-2.5,1.0), def)) === DecoratedInterval(Interval(0x1.999999999999AP-4,0x1.3C3A4EDFA9758P+8), trv)

    @test ^(DecoratedInterval(interval(0.5,1.5), dac), DecoratedInterval(interval(0.1,0.1), com)) === DecoratedInterval(Interval(0x1.DDB680117AB12P-1,0x1.0A97DCE72A0CBP+0), dac)

    @test ^(DecoratedInterval(interval(0.5,1.5), def), DecoratedInterval(interval(-2.5,0.1), trv)) === DecoratedInterval(Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), trv)

    @test ^(DecoratedInterval(interval(0.5,1.5), com), DecoratedInterval(interval(-2.5,-2.5), com)) === DecoratedInterval(Interval(0x1.7398BF1D1EE6FP-2,0x1.6A09E667F3BCDP+2), com)

    @test ^(DecoratedInterval(interval(0.5,Inf), dac), DecoratedInterval(interval(0.1,0.1), com)) === DecoratedInterval(Interval(0x1.DDB680117AB12P-1,Inf), dac)

    @test ^(DecoratedInterval(interval(0.5,Inf), def), DecoratedInterval(interval(-2.5,-0.0), com)) === DecoratedInterval(Interval(0.0,0x1.6A09E667F3BCDP+2), def)

    @test ^(DecoratedInterval(interval(1.0,1.5), com), DecoratedInterval(interval(-0.1,0.1), def)) === DecoratedInterval(Interval(0x1.EBA7C9E4D31E9P-1,0x1.0A97DCE72A0CBP+0), def)

    @test ^(DecoratedInterval(interval(1.0,1.5), trv), DecoratedInterval(interval(-0.1,-0.1), com)) === DecoratedInterval(Interval(0x1.EBA7C9E4D31E9P-1,1.0), trv)

    @test ^(DecoratedInterval(interval(1.0,Inf), dac), DecoratedInterval(interval(1.0,1.0), dac)) === DecoratedInterval(Interval(1.0,Inf), dac)

    @test ^(DecoratedInterval(interval(1.0,Inf), def), DecoratedInterval(interval(-1.0,-0.0), dac)) === DecoratedInterval(Interval(0x0P+0,1.0), def)

    @test ^(DecoratedInterval(interval(1.1,1.5), def), DecoratedInterval(interval(1.0,2.5), com)) === DecoratedInterval(Interval(0x1.199999999999AP+0,0x1.60B9FD68A4555P+1), def)

    @test ^(DecoratedInterval(interval(1.1,1.5), com), DecoratedInterval(interval(-0.1,-0.1), com)) === DecoratedInterval(Interval(0x1.EBA7C9E4D31E9P-1,0x1.FB24AF5281928P-1), com)

    @test ^(DecoratedInterval(interval(1.1,Inf), dac), DecoratedInterval(interval(0.1,Inf), dac)) === DecoratedInterval(Interval(0x1.02739C65D58BFP+0,Inf), dac)

    @test ^(DecoratedInterval(interval(1.1,Inf), def), DecoratedInterval(interval(-2.5,Inf), dac)) === DecoratedInterval(Interval(0x0P+0,Inf), def)

    @test ^(DecoratedInterval(interval(1.1,Inf), trv), DecoratedInterval(interval(-Inf,-1.0), def)) === DecoratedInterval(Interval(0x0P+0,0x1.D1745D1745D17P-1), trv)

    @test ^(DecoratedInterval(interval(0.0,0.5), com), DecoratedInterval(interval(0.1,0.1), com)) === DecoratedInterval(Interval(0.0,0x1.DDB680117AB13P-1), com)

    @test ^(DecoratedInterval(interval(0.0,0.5), com), DecoratedInterval(interval(2.5,Inf), dac)) === DecoratedInterval(Interval(0.0,0x1.6A09E667F3BCDP-3), dac)

    @test ^(DecoratedInterval(interval(0.0,0.5), com), DecoratedInterval(interval(-Inf,-2.5), dac)) === DecoratedInterval(Interval(0x1.6A09E667F3BCCP+2,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), com), DecoratedInterval(interval(0.0,0.0), com)) === DecoratedInterval(Interval(1.0,1.0), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(interval(0.0,2.5), dac)) === DecoratedInterval(Interval(0.0,1.0), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), dac), DecoratedInterval(interval(1.0,2.5), com)) === DecoratedInterval(Interval(0.0,1.0), dac)

    @test ^(DecoratedInterval(interval(0.0,1.0), com), DecoratedInterval(interval(-2.5,0.1), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(entireinterval(), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), dac), DecoratedInterval(interval(-0.1,0.0), com)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), com), DecoratedInterval(interval(-Inf,0.0), dac)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.0), def), DecoratedInterval(interval(-Inf,-2.5), dac)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.5), com), DecoratedInterval(interval(0.0,2.5), com)) === DecoratedInterval(Interval(0.0,0x1.60B9FD68A4555P+1), trv)

    @test ^(DecoratedInterval(interval(0.0,1.5), def), DecoratedInterval(interval(2.5,2.5), dac)) === DecoratedInterval(Interval(0.0,0x1.60B9FD68A4555P+1), def)

    @test ^(DecoratedInterval(interval(0.0,1.5), dac), DecoratedInterval(interval(-1.0,0.0), com)) === DecoratedInterval(Interval(0x1.5555555555555P-1,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,1.5), com), DecoratedInterval(interval(-2.5,-2.5), def)) === DecoratedInterval(Interval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,Inf), dac), DecoratedInterval(interval(0.1,0.1), com)) === DecoratedInterval(Interval(0.0,Inf), dac)

    @test ^(DecoratedInterval(interval(0.0,Inf), def), DecoratedInterval(interval(-1.0,1.0), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,Inf), trv), DecoratedInterval(interval(-Inf,-1.0), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,Inf), dac), DecoratedInterval(interval(-2.5,-2.5), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,0.5), com), DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,1.0), trv)

    @test ^(DecoratedInterval(interval(-0.0,0.5), def), DecoratedInterval(interval(0.1,Inf), def)) === DecoratedInterval(Interval(0.0,0x1.DDB680117AB13P-1), def)

    @test ^(DecoratedInterval(interval(-0.0,0.5), dac), DecoratedInterval(interval(2.5,2.5), com)) === DecoratedInterval(Interval(0.0,0x1.6A09E667F3BCDP-3), dac)

    @test ^(DecoratedInterval(interval(-0.0,0.5), trv), DecoratedInterval(interval(-2.5,-0.0), dac)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,0.5), com), DecoratedInterval(interval(-Inf,-0.1), def)) === DecoratedInterval(Interval(0x1.125FBEE250664P+0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,0.5), def), DecoratedInterval(interval(-Inf,-2.5), dac)) === DecoratedInterval(Interval(0x1.6A09E667F3BCCP+2,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.0), com), DecoratedInterval(interval(2.5,2.5), dac)) === DecoratedInterval(Interval(0.0,1.0), dac)

    @test ^(DecoratedInterval(interval(-0.0,1.0), dac), DecoratedInterval(interval(-1.0,Inf), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.0), com), DecoratedInterval(entireinterval(), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.0), def), DecoratedInterval(interval(-2.5,-2.5), com)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.0), dac), DecoratedInterval(interval(-Inf,-2.5), def)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.5), com), DecoratedInterval(interval(0.1,2.5), dac)) === DecoratedInterval(Interval(0.0,0x1.60B9FD68A4555P+1), dac)

    @test ^(DecoratedInterval(interval(-0.0,1.5), def), DecoratedInterval(interval(-1.0,0.0), trv)) === DecoratedInterval(Interval(0x1.5555555555555P-1,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.5), dac), DecoratedInterval(interval(-2.5,-0.1), def)) === DecoratedInterval(Interval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.5), com), DecoratedInterval(interval(-2.5,-2.5), com)) === DecoratedInterval(Interval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,1.5), def), DecoratedInterval(interval(-Inf,-2.5), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,Inf), dac), DecoratedInterval(interval(-0.1,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,Inf), def), DecoratedInterval(interval(-2.5,-0.0), com)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,Inf), trv), DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,Inf), dac), DecoratedInterval(interval(-Inf,-0.0), trv)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.0,Inf), def), DecoratedInterval(interval(-Inf,-1.0), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,0.5), def), DecoratedInterval(interval(0.1,Inf), dac)) === DecoratedInterval(Interval(0.0,0x1.DDB680117AB13P-1), trv)

    @test ^(DecoratedInterval(interval(-0.1,0.5), com), DecoratedInterval(interval(-0.1,-0.1), com)) === DecoratedInterval(Interval(0x1.125FBEE250664P+0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,0.5), dac), DecoratedInterval(interval(-Inf,-2.5), def)) === DecoratedInterval(Interval(0x1.6A09E667F3BCCP+2,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.0), com), DecoratedInterval(interval(0.0,0.0), com)) === DecoratedInterval(Interval(1.0,1.0), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.0), dac), DecoratedInterval(interval(-Inf,2.5), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.0), def), DecoratedInterval(interval(-Inf,-1.0), def)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.0), com), DecoratedInterval(interval(-2.5,-2.5), com)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(interval(-Inf,-2.5), trv)) === DecoratedInterval(Interval(1.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.5), trv), DecoratedInterval(interval(0.0,2.5), com)) === DecoratedInterval(Interval(0.0,0x1.60B9FD68A4555P+1), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.5), com), DecoratedInterval(interval(2.5,2.5), dac)) === DecoratedInterval(Interval(0.0,0x1.60B9FD68A4555P+1), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.5), dac), DecoratedInterval(interval(-1.0,0.0), trv)) === DecoratedInterval(Interval(0x1.5555555555555P-1,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.5), com), DecoratedInterval(interval(-0.1,-0.1), com)) === DecoratedInterval(Interval(0x1.EBA7C9E4D31E9P-1,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,1.5), def), DecoratedInterval(interval(-2.5,-2.5), def)) === DecoratedInterval(Interval(0x1.7398BF1D1EE6FP-2,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,Inf), dac), DecoratedInterval(interval(-0.1,2.5), com)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,Inf), def), DecoratedInterval(interval(-2.5,0.0), def)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(-0.1,Inf), dac), DecoratedInterval(interval(-2.5,-2.5), trv)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test ^(DecoratedInterval(interval(0.0,0.0), com), DecoratedInterval(interval(1.0,Inf), dac)) === DecoratedInterval(Interval(0.0,0.0), dac)

    @test ^(DecoratedInterval(interval(0.0,0.0), com), DecoratedInterval(interval(-2.5,0.1), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test ^(DecoratedInterval(interval(0.0,0.0), dac), DecoratedInterval(interval(-1.0,0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test ^(DecoratedInterval(interval(-1.0,-0.1), com), DecoratedInterval(interval(-0.1,1.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test ^(DecoratedInterval(interval(-1.0,-0.1), dac), DecoratedInterval(interval(-0.1,2.5), com)) === DecoratedInterval(emptyinterval(), trv)

    @test ^(DecoratedInterval(interval(-1.0,-0.1), def), DecoratedInterval(interval(-0.1,Inf), trv)) === DecoratedInterval(emptyinterval(), trv)

end

@testset "minimal_exp_test" begin

    @test exp(emptyinterval()) === emptyinterval()

    @test exp(interval(-Inf,0.0)) === Interval(0.0,1.0)

    @test exp(interval(-Inf,-0.0)) === Interval(0.0,1.0)

    @test exp(interval(0.0,Inf)) === Interval(1.0,Inf)

    @test exp(interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test exp(entireinterval()) === Interval(0.0,Inf)

    @test exp(interval(-Inf,0x1.62E42FEFA39FP+9)) === Interval(0.0,Inf)

    @test exp(interval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9)) === Interval( 0x1.FFFFFFFFFFFFFP+1023,Inf)

    @test exp(interval(0.0,0x1.62E42FEFA39EP+9)) === Interval(1.0,0x1.FFFFFFFFFC32BP+1023)

    @test exp(interval(-0.0,0x1.62E42FEFA39EP+9)) === Interval(1.0,0x1.FFFFFFFFFC32BP+1023)

    @test exp(interval(-0x1.6232BDD7ABCD3P+9,0x1.62E42FEFA39EP+9)) === Interval(0x0.FFFFFFFFFFE7BP-1022,0x1.FFFFFFFFFC32BP+1023)

    @test exp(interval(-0x1.6232BDD7ABCD3P+8,0x1.62E42FEFA39EP+9)) === Interval(0x1.FFFFFFFFFFE7BP-512,0x1.FFFFFFFFFC32BP+1023)

    @test exp(interval(-0x1.6232BDD7ABCD3P+8,0.0)) === Interval(0x1.FFFFFFFFFFE7BP-512,1.0)

    @test exp(interval(-0x1.6232BDD7ABCD3P+8,-0.0)) === Interval(0x1.FFFFFFFFFFE7BP-512,1.0)

    @test exp(interval(-0x1.6232BDD7ABCD3P+8,1.0)) === Interval(0x1.FFFFFFFFFFE7BP-512,0x1.5BF0A8B14576AP+1)

    @test exp(interval(1.0,5.0)) === Interval(0x1.5BF0A8B145769P+1,0x1.28D389970339P+7)

    @test exp(interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)) === Interval(0x1.2797F0A337A5FP-5,0x1.86091CC9095C5P+2)

    @test exp(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)) === Interval(0x1.1337E9E45812AP+1, 0x1.805A5C88021B6P+142)

    @test exp(interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)) === Interval(0x1.EF461A783114CP+16,0x1.691D36C6B008CP+37)

end

@testset "minimal_exp_dec_test" begin

    @test exp(DecoratedInterval(interval(0x1.62E42FEFA39FP+9,0x1.62E42FEFA39FP+9), com)) === DecoratedInterval(Interval( 0x1.FFFFFFFFFFFFFP+1023,Inf), dac)

    @test exp(DecoratedInterval(interval(0.0,0x1.62E42FEFA39EP+9), def)) === DecoratedInterval(Interval(1.0,0x1.FFFFFFFFFC32BP+1023), def)

end

@testset "minimal_exp2_test" begin

    @test exp2(emptyinterval()) === emptyinterval()

    @test exp2(interval(-Inf,0.0)) === Interval(0.0,1.0)

    @test exp2(interval(-Inf,-0.0)) === Interval(0.0,1.0)

    @test exp2(interval(0.0,Inf)) === Interval(1.0,Inf)

    @test exp2(interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test exp2(entireinterval()) === Interval(0.0,Inf)

    @test exp2(interval(-Inf,1024.0)) === Interval(0.0,Inf)

    @test exp2(interval(1024.0,1024.0)) === Interval(0x1.FFFFFFFFFFFFFP+1023,Inf)

    @test exp2(interval(0.0,1023.0)) === Interval(1.0,0x1P+1023)

    @test exp2(interval(-0.0,1023.0)) === Interval(1.0,0x1P+1023)

    @test exp2(interval(-1022.0,1023.0)) === Interval(0x1P-1022,0x1P+1023)

    @test exp2(interval(-1022.0,0.0)) === Interval(0x1P-1022,1.0)

    @test exp2(interval(-1022.0,-0.0)) === Interval(0x1P-1022,1.0)

    @test exp2(interval(-1022.0,1.0)) === Interval(0x1P-1022,2.0)

    @test exp2(interval(1.0,5.0)) === Interval(2.0,32.0)

    @test exp2(interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)) === Interval(0x1.9999999999998P-4,0x1.C000000000001P+1)

    @test exp2(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)) === Interval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98)

    @test exp2(interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)) === Interval(0x1.AEA0000721857P+11,0x1.FCA0555555559P+25)

end

@testset "minimal_exp2_dec_test" begin

    @test exp2(DecoratedInterval(interval(1024.0,1024.0), com)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFP+1023,Inf), dac)

    @test exp2(DecoratedInterval(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), def)) === DecoratedInterval(Interval(0x1.B333333333332P+0,0x1.C81FD88228B4FP+98), def)

end

@testset "minimal_exp10_test" begin

    @test exp10(emptyinterval()) === emptyinterval()

    @test exp10(interval(-Inf,0.0)) === Interval(0.0,1.0)

    @test exp10(interval(-Inf,-0.0)) === Interval(0.0,1.0)

    @test exp10(interval(0.0,Inf)) === Interval(1.0,Inf)

    @test exp10(interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test exp10(entireinterval()) === Interval(0.0,Inf)

    @test exp10(interval(-Inf,0x1.34413509F79FFP+8)) === Interval(0.0,Inf)

    @test exp10(interval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8)) === Interval(0x1.FFFFFFFFFFFFFP+1023,Inf)

    @test exp10(interval(0.0,0x1.34413509F79FEP+8)) === Interval(1.0,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(interval(-0.0,0x1.34413509F79FEP+8)) === Interval(1.0,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(interval(-0x1.33A7146F72A42P+8,0x1.34413509F79FEP+8)) === Interval(0x0.FFFFFFFFFFFE3P-1022,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(interval(-0x1.22P+7,0x1.34413509F79FEP+8)) === Interval(0x1.3FAAC3E3FA1F3P-482,0x1.FFFFFFFFFFBA1P+1023)

    @test exp10(interval(-0x1.22P+7,0.0)) === Interval(0x1.3FAAC3E3FA1F3P-482,1.0)

    @test exp10(interval(-0x1.22P+7,-0.0)) === Interval(0x1.3FAAC3E3FA1F3P-482,1.0)

    @test exp10(interval(-0x1.22P+7,1.0)) === Interval(0x1.3FAAC3E3FA1F3P-482,10.0)

    @test exp10(interval(1.0,5.0)) === Interval(10.0,100000.0)

    @test exp10(interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)) === Interval(0x1.F3A8254311F9AP-12,0x1.00B18AD5B7D56P+6)

    @test exp10(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)) === Interval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328)

    @test exp10(interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)) === Interval(0x1.0608D2279A811P+39,0x1.43AF5D4271CB8P+86)

end

@testset "minimal_exp10_dec_test" begin

    @test exp10(DecoratedInterval(interval(0x1.34413509F79FFP+8,0x1.34413509F79FFP+8), com)) === DecoratedInterval(Interval( 0x1.FFFFFFFFFFFFFP+1023,Inf), dac)

    @test exp10(DecoratedInterval(interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6), def)) === DecoratedInterval(Interval(0x1.75014B7296807P+2,0x1.3EEC1D47DFB2BP+328), def)

end

@testset "minimal_log_test" begin

    @test log(emptyinterval()) === emptyinterval()

    @test log(interval(-Inf,0.0)) === emptyinterval()

    @test log(interval(-Inf,-0.0)) === emptyinterval()

    @test log(interval(0.0,1.0)) === Interval(-Inf,0.0)

    @test log(interval(-0.0,1.0)) === Interval(-Inf,0.0)

    @test log(interval(1.0,Inf)) === Interval(0.0,Inf)

    @test log(interval(0.0,Inf)) === entireinterval()

    @test log(interval(-0.0,Inf)) === entireinterval()

    @test log(entireinterval()) === entireinterval()

    @test log(interval(0.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,0x1.62E42FEFA39FP+9)

    @test log(interval(-0.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,0x1.62E42FEFA39FP+9)

    @test log(interval(1.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(0.0,0x1.62E42FEFA39FP+9)

    @test log(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)) === Interval(-0x1.74385446D71C4p9, +0x1.62E42FEFA39Fp9)

    @test log(interval(0x0.0000000000001p-1022,1.0)) === Interval(-0x1.74385446D71C4p9,0.0)

    @test log(interval(0x1.5BF0A8B145769P+1,0x1.5BF0A8B145769P+1)) === Interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test log(interval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1)) === Interval(0x1P+0,0x1.0000000000001P+0)

    @test log(interval(0x0.0000000000001p-1022,0x1.5BF0A8B14576AP+1)) === Interval(-0x1.74385446D71C4p9,0x1.0000000000001P+0)

    @test log(interval(0x1.5BF0A8B145769P+1,32.0)) === Interval(0x1.FFFFFFFFFFFFFP-1,0x1.BB9D3BEB8C86CP+1)

    @test log(interval(0x1.999999999999AP-4,0x1.CP+1)) === Interval(-0x1.26BB1BBB55516P+1,0x1.40B512EB53D6P+0)

    @test log(interval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)) === Interval(0x1.0FAE81914A99P-1,0x1.120627F6AE7F1P+6)

    @test log(interval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)) === Interval(0x1.04A1363DB1E63P+3,0x1.203E52C0256B5P+4)

end

@testset "minimal_log_dec_test" begin

    @test log(DecoratedInterval(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-0x1.74385446D71C4p9,0x1.62E42FEFA39FP+9), com)

    @test log(DecoratedInterval(interval(0.0,1.0), com)) === DecoratedInterval(Interval(-Inf,0.0), trv)

    @test log(DecoratedInterval(interval(0x1.5BF0A8B14576AP+1,0x1.5BF0A8B14576AP+1), def)) === DecoratedInterval(Interval(0x1P+0,0x1.0000000000001P+0), def)

end

@testset "minimal_log2_test" begin

    @test log2(emptyinterval()) === emptyinterval()

    @test log2(interval(-Inf,0.0)) === emptyinterval()

    @test log2(interval(-Inf,-0.0)) === emptyinterval()

    @test log2(interval(0.0,1.0)) === Interval(-Inf,0.0)

    @test log2(interval(-0.0,1.0)) === Interval(-Inf,0.0)

    @test log2(interval(1.0,Inf)) === Interval(0.0,Inf)

    @test log2(interval(0.0,Inf)) === entireinterval()

    @test log2(interval(-0.0,Inf)) === entireinterval()

    @test log2(entireinterval()) === entireinterval()

    @test log2(interval(0.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,1024.0)

    @test log2(interval(-0.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,1024.0)

    @test log2(interval(1.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(0.0,1024.0)

    @test log2(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)) === Interval(-1074.0,1024.0)

    @test log2(interval(0x0.0000000000001p-1022,1.0)) === Interval(-1074.0,0.0)

    @test log2(interval(0x0.0000000000001p-1022,2.0)) === Interval(-1074.0,1.0)

    @test log2(interval(2.0,32.0)) === Interval(1.0,5.0)

    @test log2(interval(0x1.999999999999AP-4,0x1.CP+1)) === Interval(-0x1.A934F0979A372P+1,0x1.CEAECFEA8085AP+0)

    @test log2(interval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)) === Interval(0x1.87F42B972949CP-1,0x1.8B55484710029P+6)

    @test log2(interval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)) === Interval(0x1.78025C8B3FD39P+3,0x1.9FD8EEF3FA79BP+4)

end

@testset "minimal_log2_dec_test" begin

    @test log2(DecoratedInterval(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-1074.0,1024.0), com)

    @test log2(DecoratedInterval(interval(0x0.0000000000001p-1022,Inf), dac)) === DecoratedInterval(Interval(-1074.0,Inf), dac)

    @test log2(DecoratedInterval(interval(2.0,32.0), def)) === DecoratedInterval(Interval(1.0,5.0), def)

    @test log2(DecoratedInterval(interval(0.0,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-Inf,1024.0), trv)

end

@testset "minimal_log10_test" begin

    @test log10(emptyinterval()) === emptyinterval()

    @test log10(interval(-Inf,0.0)) === emptyinterval()

    @test log10(interval(-Inf,-0.0)) === emptyinterval()

    @test log10(interval(0.0,1.0)) === Interval(-Inf,0.0)

    @test log10(interval(-0.0,1.0)) === Interval(-Inf,0.0)

    @test log10(interval(1.0,Inf)) === Interval(0.0,Inf)

    @test log10(interval(0.0,Inf)) === entireinterval()

    @test log10(interval(-0.0,Inf)) === entireinterval()

    @test log10(entireinterval()) === entireinterval()

    @test log10(interval(0.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,0x1.34413509F79FFP+8)

    @test log10(interval(-0.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,0x1.34413509F79FFP+8)

    @test log10(interval(1.0,0x1.FFFFFFFFFFFFFp1023)) === Interval(0.0,0x1.34413509F79FFP+8)

    @test log10(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023)) === Interval(-0x1.434E6420F4374p+8, +0x1.34413509F79FFp+8)

    @test log10(interval(0x0.0000000000001p-1022,1.0)) === Interval(-0x1.434E6420F4374p+8 ,0.0)

    @test log10(interval(0x0.0000000000001p-1022,10.0)) === Interval(-0x1.434E6420F4374p+8 ,1.0)

    @test log10(interval(10.0,100000.0)) === Interval(1.0,5.0)

    @test log10(interval(0x1.999999999999AP-4,0x1.CP+1)) === Interval(-0x1P+0,0x1.1690163290F4P-1)

    @test log10(interval(0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test log10(interval(0x1.B333333333333P+0,0x1.C81FD88228B2FP+98)) === Interval(0x1.D7F59AA5BECB9P-3,0x1.DC074D84E5AABP+4)

    @test log10(interval(0x1.AEA0000721861P+11,0x1.FCA055555554CP+25)) === Interval(0x1.C4C29DD829191P+1,0x1.F4BAEBBA4FA4P+2)

end

@testset "minimal_log10_dec_test" begin

    @test log10(DecoratedInterval(interval(0x0.0000000000001p-1022,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-0x1.434E6420F4374p+8,0x1.34413509F79FFP+8), com)

    @test log10(DecoratedInterval(interval(0.0,0x1.FFFFFFFFFFFFFp1023), dac)) === DecoratedInterval(Interval(-Inf,0x1.34413509F79FFP+8), trv)

end

@testset "minimal_sin_test" begin

    @test sin(emptyinterval()) === emptyinterval()

    @test sin(interval(0.0,Inf)) === Interval(-1.0,1.0)

    @test sin(interval(-0.0,Inf)) === Interval(-1.0,1.0)

    @test sin(interval(-Inf,0.0)) === Interval(-1.0,1.0)

    @test sin(interval(-Inf,-0.0)) === Interval(-1.0,1.0)

    @test sin(entireinterval()) === Interval(-1.0,1.0)

    @test sin(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test sin(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === Interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test sin(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === Interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === Interval(0x1.FFFFFFFFFFFFFP-1,0x1P+0)

    @test sin(interval(0.0,0x1.921FB54442D18P+0)) === Interval(0.0,0x1P+0)

    @test sin(interval(-0.0,0x1.921FB54442D18P+0)) === Interval(0.0,0x1P+0)

    @test sin(interval(0.0,0x1.921FB54442D19P+0)) === Interval(0.0,0x1P+0)

    @test sin(interval(-0.0,0x1.921FB54442D19P+0)) === Interval(0.0,0x1P+0)

    @test sin(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)) === Interval(0x1.1A62633145C06P-53,0x1.1A62633145C07P-53)

    @test sin(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)) === Interval(-0x1.72CECE675D1FDP-52,-0x1.72CECE675D1FCP-52)

    @test sin(interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)) === Interval(-0x1.72CECE675D1FDP-52,0x1.1A62633145C07P-53)

    @test sin(interval(0.0,0x1.921FB54442D18P+1)) === Interval(0.0,1.0)

    @test sin(interval(-0.0,0x1.921FB54442D18P+1)) === Interval(0.0,1.0)

    @test sin(interval(0.0,0x1.921FB54442D19P+1)) === Interval(-0x1.72CECE675D1FDP-52,1.0)

    @test sin(interval(-0.0,0x1.921FB54442D19P+1)) === Interval(-0x1.72CECE675D1FDP-52,1.0)

    @test sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)) === Interval(0x1.1A62633145C06P-53,0x1P+0)

    @test sin(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)) === Interval(-0x1.72CECE675D1FDP-52,0x1P+0)

    @test sin(interval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)) === Interval(0x1.1A62633145C06P-53,0x1P+0)

    @test sin(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)) === Interval(-0x1.72CECE675D1FDP-52,0x1P+0)

    @test sin(interval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test sin(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test sin(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test sin(interval(-0x1.921FB54442D18P+0,0.0)) === Interval(-0x1P+0,0.0)

    @test sin(interval(-0x1.921FB54442D18P+0,-0.0)) === Interval(-0x1P+0,0.0)

    @test sin(interval(-0x1.921FB54442D19P+0,0.0)) === Interval(-0x1P+0,0.0)

    @test sin(interval(-0x1.921FB54442D19P+0,-0.0)) === Interval(-0x1P+0,0.0)

    @test sin(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)) === Interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53)

    @test sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)) === Interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52)

    @test sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)) === Interval(-0x1.1A62633145C07P-53,0x1.72CECE675D1FDP-52)

    @test sin(interval(-0x1.921FB54442D18P+1,0.0)) === Interval(-1.0,0.0)

    @test sin(interval(-0x1.921FB54442D18P+1,-0.0)) === Interval(-1.0,0.0)

    @test sin(interval(-0x1.921FB54442D19P+1,0.0)) === Interval(-1.0,0x1.72CECE675D1FDP-52)

    @test sin(interval(-0x1.921FB54442D19P+1,-0.0)) === Interval(-1.0,0x1.72CECE675D1FDP-52)

    @test sin(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)) === Interval(-0x1P+0,-0x1.1A62633145C06P-53)

    @test sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)) === Interval(-0x1P+0,0x1.72CECE675D1FDP-52)

    @test sin(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)) === Interval(-0x1P+0,-0x1.1A62633145C06P-53)

    @test sin(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)) === Interval(-0x1P+0,0x1.72CECE675D1FDP-52)

    @test sin(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === Interval(-0x1P+0,0x1P+0)

    @test sin(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === Interval(-0x1P+0,0x1P+0)

    @test sin(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)) === Interval(-0x1P+0,0x1P+0)

    @test sin(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === Interval(-0x1P+0,0x1P+0)

    @test sin(interval(-0.7,0.1)) === Interval(-0x1.49D6E694619B9P-1,0x1.98EAECB8BCB2DP-4)

    @test sin(interval(1.0,2.0)) === Interval(0x1.AED548F090CEEP-1,1.0)

    @test sin(interval(-3.2,-2.9)) === Interval(-0x1.E9FB8D64830E3P-3,0x1.DE33739E82D33P-5)

    @test sin(interval(2.0,3.0)) === Interval(0x1.210386DB6D55BP-3,0x1.D18F6EAD1B446P-1)

end

@testset "minimal_sin_dec_test" begin

    @test sin(DecoratedInterval(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0), def)) === DecoratedInterval(Interval(-0x1P+0,-0x1.1A62633145C06P-53), def)

    @test sin(DecoratedInterval(interval(-Inf,-0.0), trv)) === DecoratedInterval(Interval(-1.0,1.0), trv)

    @test sin(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-1.0,1.0), dac)

end

@testset "minimal_cos_test" begin

    @test cos(emptyinterval()) === emptyinterval()

    @test cos(interval(0.0,Inf)) === Interval(-1.0,1.0)

    @test cos(interval(-0.0,Inf)) === Interval(-1.0,1.0)

    @test cos(interval(-Inf,0.0)) === Interval(-1.0,1.0)

    @test cos(interval(-Inf,-0.0)) === Interval(-1.0,1.0)

    @test cos(entireinterval()) === Interval(-1.0,1.0)

    @test cos(interval(0.0,0.0)) === Interval(1.0,1.0)

    @test cos(interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === Interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54)

    @test cos(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53)

    @test cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54)

    @test cos(interval(0.0,0x1.921FB54442D18P+0)) === Interval(0x1.1A62633145C06P-54,1.0)

    @test cos(interval(-0.0,0x1.921FB54442D18P+0)) === Interval(0x1.1A62633145C06P-54,1.0)

    @test cos(interval(0.0,0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(-0.0,0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(interval(0.0,0x1.921FB54442D18P+1)) === Interval(-1.0,1.0)

    @test cos(interval(-0.0,0x1.921FB54442D18P+1)) === Interval(-1.0,1.0)

    @test cos(interval(0.0,0x1.921FB54442D19P+1)) === Interval(-1.0,1.0)

    @test cos(interval(-0.0,0x1.921FB54442D19P+1)) === Interval(-1.0,1.0)

    @test cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+1)) === Interval(-1.0,0x1.1A62633145C07P-54)

    @test cos(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)) === Interval(-1.0,0x1.1A62633145C07P-54)

    @test cos(interval(0x1.921FB54442D19P+0,0x1.921FB54442D18P+1)) === Interval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+1)) === Interval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(interval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0)) === Interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54)

    @test cos(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,-0x1.72CECE675D1FCP-53)

    @test cos(interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)) === Interval(-0x1.72CECE675D1FDP-53,0x1.1A62633145C07P-54)

    @test cos(interval(-0x1.921FB54442D18P+0,0.0)) === Interval(0x1.1A62633145C06P-54,1.0)

    @test cos(interval(-0x1.921FB54442D18P+0,-0.0)) === Interval(0x1.1A62633145C06P-54,1.0)

    @test cos(interval(-0x1.921FB54442D19P+0,0.0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(-0x1.921FB54442D19P+0,-0.0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+1)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+1)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+1)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test cos(interval(-0x1.921FB54442D18P+1,0.0)) === Interval(-1.0,1.0)

    @test cos(interval(-0x1.921FB54442D18P+1,-0.0)) === Interval(-1.0,1.0)

    @test cos(interval(-0x1.921FB54442D19P+1,0.0)) === Interval(-1.0,1.0)

    @test cos(interval(-0x1.921FB54442D19P+1,-0.0)) === Interval(-1.0,1.0)

    @test cos(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D18P+0)) === Interval(-1.0,0x1.1A62633145C07P-54)

    @test cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D18P+0)) === Interval(-1.0,0x1.1A62633145C07P-54)

    @test cos(interval(-0x1.921FB54442D18P+1,-0x1.921FB54442D19P+0)) === Interval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(interval(-0x1.921FB54442D19P+1,-0x1.921FB54442D19P+0)) === Interval(-1.0,-0x1.72CECE675D1FCP-53)

    @test cos(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === Interval(0x1.1A62633145C06P-54,1.0)

    @test cos(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === Interval(-0x1.72CECE675D1FDP-53,1.0)

    @test cos(interval(-0.7,0.1)) === Interval(0x1.87996529F9D92P-1,1.0)

    @test cos(interval(1.0,2.0)) === Interval(-0x1.AA22657537205P-2,0x1.14A280FB5068CP-1)

    @test cos(interval(-3.2,-2.9)) === Interval(-1.0,-0x1.F1216DBA340C8P-1)

    @test cos(interval(2.0,3.0)) === Interval(-0x1.FAE04BE85E5D3P-1,-0x1.AA22657537204P-2)

end

@testset "minimal_cos_dec_test" begin

    @test cos(DecoratedInterval(interval(-0x1.921FB54442D18P+0,-0x1.921FB54442D18P+0), trv)) === DecoratedInterval(Interval(0x1.1A62633145C06P-54,0x1.1A62633145C07P-54), trv)

    @test cos(DecoratedInterval(interval(-Inf,-0.0), def)) === DecoratedInterval(Interval(-1.0,1.0), def)

    @test cos(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-1.0,1.0), dac)

end

@testset "minimal_tan_test" begin

    @test tan(emptyinterval()) === emptyinterval()

    @test tan(interval(0.0,Inf)) === entireinterval()

    @test tan(interval(-0.0,Inf)) === entireinterval()

    @test tan(interval(-Inf,0.0)) === entireinterval()

    @test tan(interval(-Inf,-0.0)) === entireinterval()

    @test tan(entireinterval()) === entireinterval()

    @test tan(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test tan(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test tan(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === Interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53)

    @test tan(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === Interval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52)

    @test tan(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === entireinterval()

    @test tan(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1)) === Interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53)

    @test tan(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1)) === Interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52)

    @test tan(interval(0.0,0x1.921FB54442D18P+0)) === Interval(0.0,0x1.D02967C31CDB5P+53)

    @test tan(interval(-0.0,0x1.921FB54442D18P+0)) === Interval(0.0,0x1.D02967C31CDB5P+53)

    @test tan(interval(0.0,0x1.921FB54442D19P+0)) === entireinterval()

    @test tan(interval(-0.0,0x1.921FB54442D19P+0)) === entireinterval()

    @test tan(interval(0.0,0x1.921FB54442D18P+1)) === entireinterval()

    @test tan(interval(-0.0,0x1.921FB54442D18P+1)) === entireinterval()

    @test tan(interval(0.0,0x1.921FB54442D19P+1)) === entireinterval()

    @test tan(interval(-0.0,0x1.921FB54442D19P+1)) === entireinterval()

    @test tan(interval(0x1P-51,0x1.921FB54442D18P+1)) === entireinterval()

    @test tan(interval(0x1P-51,0x1.921FB54442D19P+1)) === entireinterval()

    @test tan(interval(0x1P-52,0x1.921FB54442D18P+1)) === entireinterval()

    @test tan(interval(0x1P-52,0x1.921FB54442D19P+1)) === entireinterval()

    @test tan(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0)) === Interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53)

    @test tan(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)) === entireinterval()

    @test tan(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0)) === entireinterval()

    @test tan(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)) === entireinterval()

    @test tan(interval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4)) === Interval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4)

    @test tan(interval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12)) === Interval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0)

    @test tan(interval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12)) === entireinterval()

    @test tan(interval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0)) === Interval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0)

end

@testset "minimal_tan_dec_test" begin

    @test tan(DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test tan(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0.0,Inf), def)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-Inf,0.0), trv)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-Inf,-0.0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0.0,0.0), com)) === DecoratedInterval(Interval(0.0,0.0), com)

    @test tan(DecoratedInterval(interval(-0.0,-0.0), def)) === DecoratedInterval(Interval(0.0,0.0), def)

    @test tan(DecoratedInterval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), com)) === DecoratedInterval(Interval(0x1.D02967C31CDB4P+53,0x1.D02967C31CDB5P+53), com)

    @test tan(DecoratedInterval(interval(0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), def)) === DecoratedInterval(Interval(-0x1.617A15494767BP+52,-0x1.617A15494767AP+52), def)

    @test tan(DecoratedInterval(interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0x1.921FB54442D18P+1,0x1.921FB54442D18P+1), trv)) === DecoratedInterval(Interval(-0x1.1A62633145C07P-53,-0x1.1A62633145C06P-53), trv)

    @test tan(DecoratedInterval(interval(0x1.921FB54442D19P+1,0x1.921FB54442D19P+1), com)) === DecoratedInterval(Interval(0x1.72CECE675D1FCP-52,0x1.72CECE675D1FDP-52), com)

    @test tan(DecoratedInterval(interval(0.0,0x1.921FB54442D18P+0), dac)) === DecoratedInterval(Interval(0.0,0x1.D02967C31CDB5P+53), dac)

    @test tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D18P+0), com)) === DecoratedInterval(Interval(0.0,0x1.D02967C31CDB5P+53), com)

    @test tan(DecoratedInterval(interval(0.0,0x1.921FB54442D19P+0), trv)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D19P+0), def)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0.0,0x1.921FB54442D18P+1), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D18P+1), com)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0.0,0x1.921FB54442D19P+1), trv)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0.0,0x1.921FB54442D19P+1), def)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0x1P-51,0x1.921FB54442D18P+1), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0x1P-51,0x1.921FB54442D19P+1), com)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0x1P-52,0x1.921FB54442D18P+1), trv)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0x1P-52,0x1.921FB54442D19P+1), def)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D18P+0), com)) === DecoratedInterval(Interval(-0x1.D02967C31CDB5P+53,0x1.D02967C31CDB5P+53), com)

    @test tan(DecoratedInterval(interval(-0x1.921FB54442D18P+0,0x1.921FB54442D19P+0), trv)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D18P+0), def)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), dac)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(-0x1.555475A31A4BEP-2,0x1.999999999999AP-4), com)) === DecoratedInterval(Interval(-0x1.628F4FD931FEFP-2,0x1.9AF8877430B81P-4), com)

    @test tan(DecoratedInterval(interval(0x1.4E18E147AE148P+12,0x1.4E2028F5C28F6P+12), dac)) === DecoratedInterval(Interval(-0x1.D6D67B035B6B4P+2,-0x1.7E42B0760E3F3P+0), dac)

    @test tan(DecoratedInterval(interval(0x1.4E18E147AE148P+12,0x1.546028F5C28F6P+12), def)) === DecoratedInterval(entireinterval(), trv)

    @test tan(DecoratedInterval(interval(0x1.FAE147AE147AEP-1,0x1.028F5C28F5C29P+0), trv)) === DecoratedInterval(Interval(0x1.860FADCC59064P+0,0x1.979AD0628469DP+0), trv)

end

@testset "minimal_asin_test" begin

    @test asin(emptyinterval()) === emptyinterval()

    @test asin(interval(0.0,Inf)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test asin(interval(-0.0,Inf)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test asin(interval(-Inf,0.0)) === Interval(-0x1.921FB54442D19P+0,0.0)

    @test asin(interval(-Inf,-0.0)) === Interval(-0x1.921FB54442D19P+0,0.0)

    @test asin(entireinterval()) === Interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)

    @test asin(interval(-1.0,1.0)) === Interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)

    @test asin(interval(-Inf,-1.0)) === Interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)

    @test asin(interval(1.0,Inf)) === Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test asin(interval(-1.0,-1.0)) === Interval(-0x1.921FB54442D19P+0,-0x1.921FB54442D18P+0)

    @test asin(interval(1.0,1.0)) === Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test asin(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test asin(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test asin(interval(-Inf,-0x1.0000000000001P+0)) === emptyinterval()

    @test asin(interval(0x1.0000000000001P+0,Inf)) === emptyinterval()

    @test asin(interval(-0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(-0x1.9A49276037885P-4,0x1.9A49276037885P-4)

    @test asin(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)) === Interval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0)

    @test asin(interval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)) === Interval(-0x1.921FB50442D19P+0,0x1.921FB50442D19P+0)

end

@testset "minimal_asin_dec_test" begin

    @test asin(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), trv)

    @test asin(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0,0.0), trv)

    @test asin(DecoratedInterval(interval(-1.0,1.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), com)

    @test asin(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), trv)

    @test asin(DecoratedInterval(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), def)) === DecoratedInterval(Interval(-0x1.585FF6E341C3FP-2,0x1.921FB50442D19P+0), def)

end

@testset "minimal_acos_test" begin

    @test acos(emptyinterval()) === emptyinterval()

    @test acos(interval(0.0,Inf)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test acos(interval(-0.0,Inf)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test acos(interval(-Inf,0.0)) === Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)

    @test acos(interval(-Inf,-0.0)) === Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1)

    @test acos(entireinterval()) === Interval(0.0,0x1.921FB54442D19P+1)

    @test acos(interval(-1.0,1.0)) === Interval(0.0,0x1.921FB54442D19P+1)

    @test acos(interval(-Inf,-1.0)) === Interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)

    @test acos(interval(1.0,Inf)) === Interval(0.0,0.0)

    @test acos(interval(-1.0,-1.0)) === Interval(0x1.921FB54442D18P+1,0x1.921FB54442D19P+1)

    @test acos(interval(1.0,1.0)) === Interval(0.0,0.0)

    @test acos(interval(0.0,0.0)) === Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test acos(interval(-0.0,-0.0)) === Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+0)

    @test acos(interval(-Inf,-0x1.0000000000001P+0)) === emptyinterval()

    @test acos(interval(0x1.0000000000001P+0,Inf)) === emptyinterval()

    @test acos(interval(-0x1.999999999999AP-4,0x1.999999999999AP-4)) === Interval(0x1.787B22CE3F59P+0,0x1.ABC447BA464A1P+0)

    @test acos(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1)) === Interval(0x1P-26,0x1.E837B2FD13428P+0)

    @test acos(interval(-0x1.FFFFFFFFFFFFFP-1,0x1.FFFFFFFFFFFFFP-1)) === Interval(0x1P-26,0x1.921FB52442D19P+1)

end

@testset "minimal_acos_dec_test" begin

    @test acos(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), trv)

    @test acos(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0,0x1.921FB54442D19P+1), trv)

    @test acos(DecoratedInterval(interval(-1.0,1.0), com)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), com)

    @test acos(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test acos(DecoratedInterval(interval(-0x1.51EB851EB851FP-2,0x1.FFFFFFFFFFFFFP-1), def)) === DecoratedInterval(Interval(0x1P-26,0x1.E837B2FD13428P+0), def)

end

@testset "minimal_atan_test" begin

    @test atan(emptyinterval()) === emptyinterval()

    @test atan(interval(0.0,Inf)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test atan(interval(-0.0,Inf)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test atan(interval(-Inf,0.0)) === Interval(-0x1.921FB54442D19P+0,0.0)

    @test atan(interval(-Inf,-0.0)) === Interval(-0x1.921FB54442D19P+0,0.0)

    @test atan(entireinterval()) === Interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0)

    @test atan(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test atan(interval(1.0,0x1.4C2463567C5ACP+25)) === Interval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0)

    @test atan(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === Interval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0)

end

@testset "minimal_atan_dec_test" begin

    @test atan(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), dac)

    @test atan(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0,0.0), def)

    @test atan(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0,0x1.921FB54442D19P+0), dac)

    @test atan(DecoratedInterval(interval(1.0,0x1.4C2463567C5ACP+25), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P-1,0x1.921FB4E19ABD7P+0), trv)

    @test atan(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)) === DecoratedInterval(Interval(-0x1.921FB54440CEBP+0,-0x1.91ABE5C1E4C6DP+0), com)

end

@testset "minimal_atan2_test" begin

    @test atan(emptyinterval(), emptyinterval()) === emptyinterval()

    @test atan(emptyinterval(), entireinterval()) === emptyinterval()

    @test atan(emptyinterval(), interval(0.0, 0.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(-0.0, 0.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(0.0, -0.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(-0.0, -0.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(-2.0, -0.1)) === emptyinterval()

    @test atan(emptyinterval(), interval(-2.0, 0.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(-2.0, -0.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(-2.0, 1.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(0.0, 1.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(-0.0, 1.0)) === emptyinterval()

    @test atan(emptyinterval(), interval(0.1, 1.0)) === emptyinterval()

    @test atan(entireinterval(), emptyinterval()) === emptyinterval()

    @test atan(entireinterval(), entireinterval()) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(), interval(0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(), interval(0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(), interval(-0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(), interval(-0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(), interval(-2.0, -0.1)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(), interval(-2.0, 0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(), interval(-2.0, -0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(), interval(-2.0, 1.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(entireinterval(), interval(0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(), interval(-0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(entireinterval(), interval(0.1, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 0.0), emptyinterval()) === emptyinterval()

    @test atan(interval(0.0, 0.0), entireinterval()) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 0.0), interval(0.0, 0.0)) === emptyinterval()

    @test atan(interval(0.0, 0.0), interval(-0.0, 0.0)) === emptyinterval()

    @test atan(interval(0.0, 0.0), interval(0.0, -0.0)) === emptyinterval()

    @test atan(interval(0.0, 0.0), interval(-0.0, -0.0)) === emptyinterval()

    @test atan(interval(0.0, 0.0), interval(-2.0, -0.1)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 0.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 0.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 0.0), interval(-2.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 0.0), interval(0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(0.0, 0.0), interval(-0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(0.0, 0.0), interval(0.1, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0, 0.0), emptyinterval()) === emptyinterval()

    @test atan(interval(-0.0, 0.0), entireinterval()) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 0.0), interval(0.0, 0.0)) === emptyinterval()

    @test atan(interval(-0.0, 0.0), interval(-0.0, 0.0)) === emptyinterval()

    @test atan(interval(-0.0, 0.0), interval(0.0, -0.0)) === emptyinterval()

    @test atan(interval(-0.0, 0.0), interval(-0.0, -0.0)) === emptyinterval()

    @test atan(interval(-0.0, 0.0), interval(-2.0, -0.1)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 0.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 0.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 0.0), interval(-2.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 0.0), interval(0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0, 0.0), interval(-0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0, 0.0), interval(0.1, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(0.0, -0.0), emptyinterval()) === emptyinterval()

    @test atan(interval(0.0, -0.0), entireinterval()) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(0.0, -0.0), interval(0.0, 0.0)) === emptyinterval()

    @test atan(interval(0.0, -0.0), interval(-0.0, 0.0)) === emptyinterval()

    @test atan(interval(0.0, -0.0), interval(0.0, -0.0)) === emptyinterval()

    @test atan(interval(0.0, -0.0), interval(-0.0, -0.0)) === emptyinterval()

    @test atan(interval(0.0, -0.0), interval(-2.0, -0.1)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, -0.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, -0.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, -0.0), interval(-2.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(0.0, -0.0), interval(0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(0.0, -0.0), interval(-0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(0.0, -0.0), interval(0.1, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0, -0.0), emptyinterval()) === emptyinterval()

    @test atan(interval(-0.0, -0.0), entireinterval()) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, -0.0), interval(0.0, 0.0)) === emptyinterval()

    @test atan(interval(-0.0, -0.0), interval(-0.0, 0.0)) === emptyinterval()

    @test atan(interval(-0.0, -0.0), interval(0.0, -0.0)) === emptyinterval()

    @test atan(interval(-0.0, -0.0), interval(-0.0, -0.0)) === emptyinterval()

    @test atan(interval(-0.0, -0.0), interval(-2.0, -0.1)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, -0.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, -0.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, -0.0), interval(-2.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, -0.0), interval(0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0, -0.0), interval(-0.0, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-0.0, -0.0), interval(0.1, 1.0)) === Interval(0.0,0.0)

    @test atan(interval(-2.0, -0.1), emptyinterval()) === emptyinterval()

    @test atan(interval(-2.0, -0.1), entireinterval()) === Interval(-0x1.921FB54442D19P+1,0.0)

    @test atan(interval(-2.0, -0.1), interval(0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.1), interval(0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.1), interval(-0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.1), interval(0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.1), interval(-2.0, -0.1)) === Interval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0)

    @test atan(interval(-2.0, -0.1), interval(-2.0, 0.0)) === Interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.1), interval(-2.0, -0.0)) === Interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.1), interval(-2.0, 1.0)) === Interval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4)

    @test atan(interval(-2.0, -0.1), interval(0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4)

    @test atan(interval(-2.0, -0.1), interval(-0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4)

    @test atan(interval(-2.0, -0.1), interval(0.1, 1.0)) === Interval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4)

    @test atan(interval(-2.0, 0.0), emptyinterval()) === emptyinterval()

    @test atan(interval(-2.0, 0.0), entireinterval()) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 0.0), interval(0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, 0.0), interval(-0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, 0.0), interval(0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, 0.0), interval(-0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, 0.0), interval(-2.0, -0.1)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 0.0), interval(-2.0, 0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 0.0), interval(-2.0, -0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 0.0), interval(-2.0, 1.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 0.0), interval(0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(interval(-2.0, 0.0), interval(-0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(interval(-2.0, 0.0), interval(0.1, 1.0)) === Interval(-0x1.8555A2787982P+0, 0.0)

    @test atan(interval(-2.0, -0.0), emptyinterval()) === emptyinterval()

    @test atan(interval(-2.0, -0.0), entireinterval()) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, -0.0), interval(0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.0), interval(-0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.0), interval(0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.0), interval(-0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0)

    @test atan(interval(-2.0, -0.0), interval(-2.0, -0.1)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, -0.0), interval(-2.0, 0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, -0.0), interval(-2.0, -0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, -0.0), interval(-2.0, 1.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, -0.0), interval(0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(interval(-2.0, -0.0), interval(-0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0.0)

    @test atan(interval(-2.0, -0.0), interval(0.1, 1.0)) === Interval(-0x1.8555A2787982P+0, 0.0)

    @test atan(interval(-2.0, 1.0), emptyinterval()) === emptyinterval()

    @test atan(interval(-2.0, 1.0), entireinterval()) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 1.0), interval(0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-2.0, 1.0), interval(-0.0, 0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-2.0, 1.0), interval(0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-2.0, 1.0), interval(-0.0, -0.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-2.0, 1.0), interval(-2.0, -0.1)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 1.0), interval(-2.0, 0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 1.0), interval(-2.0, -0.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 1.0), interval(-2.0, 1.0)) === Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1)

    @test atan(interval(-2.0, 1.0), interval(0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-2.0, 1.0), interval(-0.0, 1.0)) === Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-2.0, 1.0), interval(0.1, 1.0)) === Interval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0)

    @test atan(interval(-0.0, 1.0), emptyinterval()) === emptyinterval()

    @test atan(interval(-0.0, 1.0), entireinterval()) === Interval(0.0, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 1.0), interval(0.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-0.0, 1.0), interval(-0.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-0.0, 1.0), interval(0.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-0.0, 1.0), interval(-0.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(-0.0, 1.0), interval(-2.0, -0.1)) === Interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 1.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 1.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 1.0), interval(-2.0, 1.0)) === Interval(0.0, 0x1.921FB54442D19P+1)

    @test atan(interval(-0.0, 1.0), interval(0.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test atan(interval(-0.0, 1.0), interval(-0.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test atan(interval(-0.0, 1.0), interval(0.1, 1.0)) === Interval(0.0, 0x1.789BD2C160054P+0)

    @test atan(interval(0.0, 1.0), emptyinterval()) === emptyinterval()

    @test atan(interval(0.0, 1.0), entireinterval()) === Interval(0.0, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 1.0), interval(0.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 1.0), interval(-0.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 1.0), interval(0.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 1.0), interval(-0.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 1.0), interval(-2.0, -0.1)) === Interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 1.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 1.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 1.0), interval(-2.0, 1.0)) === Interval(0.0, 0x1.921FB54442D19P+1)

    @test atan(interval(0.0, 1.0), interval(0.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 1.0), interval(-0.0, 1.0)) === Interval(0.0,0x1.921FB54442D19P+0)

    @test atan(interval(0.0, 1.0), interval(0.1, 1.0)) === Interval(0.0,0x1.789BD2C160054P+0)

    @test atan(interval(0.1, 1.0), emptyinterval()) === emptyinterval()

    @test atan(interval(0.1, 1.0), entireinterval()) === Interval(0.0, 0x1.921FB54442D19P+1)

    @test atan(interval(0.1, 1.0), interval(0.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.1, 1.0), interval(-0.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.1, 1.0), interval(0.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.1, 1.0), interval(-0.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0)

    @test atan(interval(0.1, 1.0), interval(-2.0, -0.1)) === Interval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1)

    @test atan(interval(0.1, 1.0), interval(-2.0, 0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1)

    @test atan(interval(0.1, 1.0), interval(-2.0, -0.0)) === Interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1)

    @test atan(interval(0.1, 1.0), interval(-2.0, 1.0)) === Interval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1)

    @test atan(interval(0.1, 1.0), interval(0.0, 1.0)) === Interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0)

    @test atan(interval(0.1, 1.0), interval(-0.0, 1.0)) === Interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0)

    @test atan(interval(0.1, 1.0), interval(0.1, 1.0)) === Interval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0)

end

@testset "minimal_atan2_dec_test" begin

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0, 0.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0, -0.0), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, -0.1), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, 0.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, -0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-2.0, 1.0), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0, 1.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0, 1.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.1, 1.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.0, 0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.0, -0.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, -0.1), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, 0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, -0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.0, 1.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 1.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.0, 1.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), dac)

    @test atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(0.0, 0.0), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), trv), DecoratedInterval(interval(-0.0, 0.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-0.0, -0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac)

    @test atan(DecoratedInterval(interval(0.0, 0.0), trv), DecoratedInterval(interval(-2.0, 0.0), com)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.0), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.0, 1.0), def)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(0.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), trv), DecoratedInterval(interval(-0.0, 1.0), dac)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), com)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), def), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), trv), DecoratedInterval(interval(-0.0, 0.0), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(interval(-0.0, -0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), trv), DecoratedInterval(interval(-2.0, 0.0), com)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.0), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), dac), DecoratedInterval(interval(-2.0, 1.0), def)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(0.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), def), DecoratedInterval(interval(-0.0, 1.0), dac)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 0.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), com)

    @test atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), def), DecoratedInterval(interval(0.0, 0.0), dac)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), trv), DecoratedInterval(interval(-0.0, 0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), dac), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(-0.0, -0.0), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), dac)

    @test atan(DecoratedInterval(interval(0.0, -0.0), def), DecoratedInterval(interval(-2.0, 0.0), com)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(-2.0, -0.0), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), dac), DecoratedInterval(interval(-2.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(0.0, 1.0), trv)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), def), DecoratedInterval(interval(-0.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(0.0, -0.0), com), DecoratedInterval(interval(0.1, 1.0), def)) === DecoratedInterval(Interval(0.0,0.0), def)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), def), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), dac), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), trv), DecoratedInterval(interval(-0.0, 0.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(interval(0.0, -0.0), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), dac), DecoratedInterval(interval(-0.0, -0.0), com)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), def), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), def)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), trv), DecoratedInterval(interval(-2.0, 0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), dac), DecoratedInterval(interval(-2.0, -0.0), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), def), DecoratedInterval(interval(-2.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(interval(0.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), trv), DecoratedInterval(interval(-0.0, 1.0), dac)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test atan(DecoratedInterval(interval(-0.0, -0.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(0.0,0.0), com)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1,0.0), def)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), trv), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, -0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), dac)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.0, 0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), def)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, -0.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.0, -0.1), com)) === DecoratedInterval(Interval(-0x1.8BBAABDE5E29CP+1, -0x1.9EE9C8100C211P+0), def)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.0, 0.0), def)) === DecoratedInterval(Interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), def)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), trv), DecoratedInterval(interval(-2.0, -0.0), dac)) === DecoratedInterval(Interval(-0x1.8BBAABDE5E29CP+1, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.0, 1.0), trv)) === DecoratedInterval(Interval(-0x1.8BBAABDE5E29CP+1, -0x1.983E282E2CC4CP-4), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 1.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), def)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.0, 1.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.983E282E2CC4CP-4), dac)

    @test atan(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(-0x1.8555A2787982P+0, -0x1.983E282E2CC4CP-4), com)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.0, 0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), trv), DecoratedInterval(interval(-0.0, 0.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, -0.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(-0.0, -0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.0, 0.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(-2.0, -0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), trv), DecoratedInterval(interval(-2.0, 1.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(0.0, 1.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(-0.0, 1.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(-0x1.8555A2787982P+0, 0.0), com)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), trv), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), dac), DecoratedInterval(entireinterval(), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), def), DecoratedInterval(interval(-0.0, 0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), dac), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(-0.0, -0.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, -0x1.921FB54442D18P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), def), DecoratedInterval(interval(-2.0, -0.1), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(-2.0, 0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), dac), DecoratedInterval(interval(-2.0, -0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), def), DecoratedInterval(interval(-2.0, 1.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), trv), DecoratedInterval(interval(0.0, 1.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(-0.0, 1.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0.0), trv)

    @test atan(DecoratedInterval(interval(-2.0, -0.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(-0x1.8555A2787982P+0, 0.0), com)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), def), DecoratedInterval(interval(0.0, 0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(-0.0, 0.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), trv), DecoratedInterval(interval(0.0, -0.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(-0.0, -0.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), dac), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), def)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), def), DecoratedInterval(interval(-2.0, 0.0), def)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), trv), DecoratedInterval(interval(-2.0, -0.0), trv)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), dac), DecoratedInterval(interval(-2.0, 1.0), com)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+1, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(0.0, 1.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), trv), DecoratedInterval(interval(-0.0, 1.0), dac)) === DecoratedInterval(Interval(-0x1.921FB54442D19P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-2.0, 1.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(-0x1.8555A2787982P+0, 0x1.789BD2C160054P+0), com)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), com), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(entireinterval(), def)) === DecoratedInterval(Interval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), def), DecoratedInterval(interval(0.0, 0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), trv), DecoratedInterval(interval(-0.0, 0.0), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(interval(0.0, -0.0), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), com), DecoratedInterval(interval(-0.0, -0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), com), DecoratedInterval(interval(-2.0, -0.1), com)) === DecoratedInterval(Interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), dac)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), def), DecoratedInterval(interval(-2.0, 0.0), com)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), def), DecoratedInterval(interval(-2.0, -0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(interval(-2.0, 1.0), dac)) === DecoratedInterval(Interval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), dac), DecoratedInterval(interval(0.0, 1.0), dac)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), trv), DecoratedInterval(interval(-0.0, 1.0), com)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(-0.0, 1.0), trv), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(0.0, 0x1.789BD2C160054P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), def), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(0.0, 0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), trv), DecoratedInterval(interval(-0.0, 0.0), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), trv), DecoratedInterval(interval(0.0, -0.0), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), def), DecoratedInterval(interval(-0.0, -0.0), com)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-2.0, -0.1), dac)) === DecoratedInterval(Interval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), dac)

    @test atan(DecoratedInterval(interval(0.0, 1.0), def), DecoratedInterval(interval(-2.0, 0.0), trv)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-2.0, -0.0), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-2.0, 1.0), def)) === DecoratedInterval(Interval(0.0, 0x1.921FB54442D19P+1), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(0.0, 1.0), trv)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), dac), DecoratedInterval(interval(-0.0, 1.0), def)) === DecoratedInterval(Interval(0.0,0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.0, 1.0), com), DecoratedInterval(interval(0.1, 1.0), com)) === DecoratedInterval(Interval(0.0,0x1.789BD2C160054P+0), com)

    @test atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(emptyinterval(), trv)) === DecoratedInterval(emptyinterval(), trv)

    @test atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0, 0x1.921FB54442D19P+1), dac)

    @test atan(DecoratedInterval(interval(0.1, 1.0), def), DecoratedInterval(interval(0.0, 0.0), com)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), def)

    @test atan(DecoratedInterval(interval(0.1, 1.0), trv), DecoratedInterval(interval(-0.0, 0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.1, 1.0), trv), DecoratedInterval(interval(0.0, -0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), trv)

    @test atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(interval(-0.0, -0.0), def)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.921FB54442D19P+0), def)

    @test atan(DecoratedInterval(interval(0.1, 1.0), com), DecoratedInterval(interval(-2.0, -0.1), trv)) === DecoratedInterval(Interval(0x1.ABA397C7259DDP+0, 0x1.8BBAABDE5E29CP+1), trv)

    @test atan(DecoratedInterval(interval(0.1, 1.0), com), DecoratedInterval(interval(-2.0, 0.0), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), dac)

    @test atan(DecoratedInterval(interval(0.1, 1.0), com), DecoratedInterval(interval(-2.0, -0.0), dac)) === DecoratedInterval(Interval(0x1.921FB54442D18P+0, 0x1.8BBAABDE5E29CP+1), dac)

    @test atan(DecoratedInterval(interval(0.1, 1.0), def), DecoratedInterval(interval(-2.0, 1.0), dac)) === DecoratedInterval(Interval(0x1.983E282E2CC4CP-4, 0x1.8BBAABDE5E29CP+1), def)

    @test atan(DecoratedInterval(interval(0.1, 1.0), def), DecoratedInterval(interval(0.0, 1.0), def)) === DecoratedInterval(Interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), def)

    @test atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(interval(-0.0, 1.0), def)) === DecoratedInterval(Interval(0x1.983E282E2CC4CP-4, 0x1.921FB54442D19P+0), def)

    @test atan(DecoratedInterval(interval(0.1, 1.0), dac), DecoratedInterval(interval(0.1, 1.0), def)) === DecoratedInterval(Interval(0x1.983E282E2CC4CP-4, 0x1.789BD2C160054P+0), def)

end

@testset "minimal_sinh_test" begin

    @test sinh(emptyinterval()) === emptyinterval()

    @test sinh(interval(0.0,Inf)) === Interval(0.0,Inf)

    @test sinh(interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test sinh(interval(-Inf,0.0)) === Interval(-Inf,0.0)

    @test sinh(interval(-Inf,-0.0)) === Interval(-Inf,0.0)

    @test sinh(entireinterval()) === entireinterval()

    @test sinh(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test sinh(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test sinh(interval(1.0,0x1.2C903022DD7AAP+8)) === Interval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432)

    @test sinh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === Interval(-Inf,-0x1.53045B4F849DEP+815)

    @test sinh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === Interval(-0x1.55ECFE1B2B215P+0,0x1.3BF72EA61AF1BP+2)

end

@testset "minimal_sinh_dec_test" begin

    @test sinh(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), dac)

    @test sinh(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), dac)

    @test sinh(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(-Inf,0.0), def)

    @test sinh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), com)) === DecoratedInterval(Interval(0x1.2CD9FC44EB982P+0,0x1.89BCA168970C6P+432), com)

    @test sinh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)) === DecoratedInterval(Interval(-Inf,-0x1.53045B4F849DEP+815), dac)

end

@testset "minimal_cosh_test" begin

    @test cosh(emptyinterval()) === emptyinterval()

    @test cosh(interval(0.0,Inf)) === Interval(1.0,Inf)

    @test cosh(interval(-0.0,Inf)) === Interval(1.0,Inf)

    @test cosh(interval(-Inf,0.0)) === Interval(1.0,Inf)

    @test cosh(interval(-Inf,-0.0)) === Interval(1.0,Inf)

    @test cosh(entireinterval()) === Interval(1.0,Inf)

    @test cosh(interval(0.0,0.0)) === Interval(1.0,1.0)

    @test cosh(interval(-0.0,-0.0)) === Interval(1.0,1.0)

    @test cosh(interval(1.0,0x1.2C903022DD7AAP+8)) === Interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432)

    @test cosh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === Interval(0x1.53045B4F849DEP+815,Inf)

    @test cosh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === Interval(1.0,0x1.4261D2B7D6181P+2)

end

@testset "minimal_cosh_dec_test" begin

    @test cosh(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(1.0,Inf), dac)

    @test cosh(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(1.0,Inf), def)

    @test cosh(DecoratedInterval(entireinterval(), def)) === DecoratedInterval(Interval(1.0,Inf), def)

    @test cosh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), def)) === DecoratedInterval(Interval(0x1.8B07551D9F55P+0,0x1.89BCA168970C6P+432), def)

    @test cosh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), com)) === DecoratedInterval(Interval(0x1.53045B4F849DEP+815,Inf), dac)

end

@testset "minimal_tanh_test" begin

    @test tanh(emptyinterval()) === emptyinterval()

    @test tanh(interval(0.0,Inf)) === Interval(0.0,1.0)

    @test tanh(interval(-0.0,Inf)) === Interval(0.0,1.0)

    @test tanh(interval(-Inf,0.0)) === Interval(-1.0,0.0)

    @test tanh(interval(-Inf,-0.0)) === Interval(-1.0,0.0)

    @test tanh(entireinterval()) === Interval(-1.0,1.0)

    @test tanh(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test tanh(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test tanh(interval(1.0,0x1.2C903022DD7AAP+8)) === Interval(0x1.85EFAB514F394P-1,0x1P+0)

    @test tanh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1)

    @test tanh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === Interval(-0x1.99DB01FDE2406P-1,0x1.F5CF31E1C8103P-1)

end

@testset "minimal_tanh_dec_test" begin

    @test tanh(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,1.0), dac)

    @test tanh(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(-1.0,0.0), def)

    @test tanh(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(-1.0,1.0), dac)

    @test tanh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), com)) === DecoratedInterval(Interval(0x1.85EFAB514F394P-1,0x1P+0), com)

    @test tanh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), trv)) === DecoratedInterval(Interval(-0x1P+0,-0x1.FFFFFFFFFFFFFP-1), trv)

end

@testset "minimal_asinh_test" begin

    @test asinh(emptyinterval()) === emptyinterval()

    @test asinh(interval(0.0,Inf)) === Interval(0.0,Inf)

    @test asinh(interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test asinh(interval(-Inf,0.0)) === Interval(-Inf,0.0)

    @test asinh(interval(-Inf,-0.0)) === Interval(-Inf,0.0)

    @test asinh(entireinterval()) === entireinterval()

    @test asinh(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test asinh(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test asinh(interval(1.0,0x1.2C903022DD7AAP+8)) === Interval(0x1.C34366179D426P-1,0x1.9986127438A87P+2)

    @test asinh(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9)) === Interval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2)

    @test asinh(interval(-0x1.199999999999AP+0,0x1.2666666666666P+1)) === Interval(-0x1.E693DF6EDF1E7P-1,0x1.91FDC64DE0E51P+0)

end

@testset "minimal_asinh_dec_test" begin

    @test asinh(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), dac)

    @test asinh(DecoratedInterval(interval(-Inf,0.0), trv)) === DecoratedInterval(Interval(-Inf,0.0), trv)

    @test asinh(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(entireinterval(), dac)

    @test asinh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), com)) === DecoratedInterval(Interval(0x1.C34366179D426P-1,0x1.9986127438A87P+2), com)

    @test asinh(DecoratedInterval(interval(-0x1.FD219490EAAC1P+38,-0x1.1AF1C9D74F06DP+9), def)) === DecoratedInterval(Interval(-0x1.BB86380A6CC45P+4,-0x1.C204D8EB20827P+2), def)

end

@testset "minimal_acosh_test" begin

    @test acosh(emptyinterval()) === emptyinterval()

    @test acosh(interval(0.0,Inf)) === Interval(0.0,Inf)

    @test acosh(interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test acosh(interval(1.0,Inf)) === Interval(0.0,Inf)

    @test acosh(interval(-Inf,1.0)) === Interval(0.0,0.0)

    @test acosh(interval(-Inf,0x1.FFFFFFFFFFFFFP-1)) === emptyinterval()

    @test acosh(entireinterval()) === Interval(0.0,Inf)

    @test acosh(interval(1.0,1.0)) === Interval(0.0,0.0)

    @test acosh(interval(1.0,0x1.2C903022DD7AAP+8)) === Interval(0.0,0x1.9985FB3D532AFP+2)

    @test acosh(interval(0x1.199999999999AP+0,0x1.2666666666666P+1)) === Interval(0x1.C636C1A882F2CP-2,0x1.799C88E79140DP+0)

    @test acosh(interval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29)) === Interval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4)

end

@testset "minimal_acosh_dec_test" begin

    @test acosh(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test acosh(DecoratedInterval(interval(1.0,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), dac)

    @test acosh(DecoratedInterval(entireinterval(), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test acosh(DecoratedInterval(interval(1.0,1.0), com)) === DecoratedInterval(Interval(0.0,0.0), com)

    @test acosh(DecoratedInterval(interval(0.9,1.0), com)) === DecoratedInterval(Interval(0.0,0.0), trv)

    @test acosh(DecoratedInterval(interval(1.0,0x1.2C903022DD7AAP+8), dac)) === DecoratedInterval(Interval(0.0,0x1.9985FB3D532AFP+2), dac)

    @test acosh(DecoratedInterval(interval(0.9,0x1.2C903022DD7AAP+8), com)) === DecoratedInterval(Interval(0.0,0x1.9985FB3D532AFP+2), trv)

    @test acosh(DecoratedInterval(interval(0x1.14D4E82B2B26FP+15,0x1.72DBE91C837B5P+29), def)) === DecoratedInterval(Interval(0x1.656510B4BAEC3P+3,0x1.52A415EE8455AP+4), def)

end

@testset "minimal_atanh_test" begin

    @test atanh(emptyinterval()) === emptyinterval()

    @test_skip atanh(interval(0.0,Inf)) === Interval(0.0,Inf)

    @test_skip atanh(interval(-0.0,Inf)) === Interval(0.0,Inf)

    @test atanh(interval(1.0,Inf)) === emptyinterval()

    @test_skip atanh(interval(-Inf,0.0)) === Interval(-Inf,0.0)

    @test_skip atanh(interval(-Inf,-0.0)) === Interval(-Inf,0.0)

    @test atanh(interval(-Inf,-1.0)) === emptyinterval()

    @test_skip atanh(interval(-1.0,1.0)) === entireinterval()

    @test_skip atanh(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test_skip atanh(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test atanh(interval(-1.0,-1.0)) === emptyinterval()

    @test atanh(interval(1.0,1.0)) === emptyinterval()

    @test_skip atanh(entireinterval()) === entireinterval()

    @test_skip atanh(interval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1)) === Interval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4)

    @test_skip atanh(interval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4)) === Interval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4)

end

@testset "minimal_atanh_dec_test" begin

    @test_skip atanh(DecoratedInterval(interval(0.0,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), trv)

    @test_skip atanh(DecoratedInterval(interval(-Inf,0.0), def)) === DecoratedInterval(Interval(-Inf,0.0), trv)

    @test_skip atanh(DecoratedInterval(interval(-1.0,1.0), com)) === DecoratedInterval(entireinterval(), trv)

    @test_skip atanh(DecoratedInterval(interval(0.0,0.0), com)) === DecoratedInterval(Interval(0.0,0.0), com)

    @test atanh(DecoratedInterval(interval(1.0,1.0), def)) === DecoratedInterval(emptyinterval(), trv)

    @test_skip atanh(DecoratedInterval(interval(0x1.4C0420F6F08CCP-2,0x1.FFFFFFFFFFFFFP-1), com)) === DecoratedInterval(Interval(0x1.5871DD2DF9102P-2,0x1.2B708872320E2P+4), com)

    @test_skip atanh(DecoratedInterval(interval(-1.0,0x1.FFFFFFFFFFFFFP-1), com)) === DecoratedInterval(Interval(-Inf,0x1.2B708872320E2P+4), trv)

    @test_skip atanh(DecoratedInterval(interval(-0x1.FFB88E9EB6307P-1,0x1.999999999999AP-4), def)) === DecoratedInterval(Interval(-0x1.06A3A97D7979CP+2,0x1.9AF93CD234413P-4), def)

    @test_skip atanh(DecoratedInterval(interval(-0x1.FFB88E9EB6307P-1,1.0), com)) === DecoratedInterval(Interval(-0x1.06A3A97D7979CP+2,Inf), trv)

end

@testset "minimal_sign_test" begin

    @test sign(emptyinterval()) === emptyinterval()

    @test sign(interval(1.0,2.0)) === Interval(1.0,1.0)

    @test sign(interval(-1.0,2.0)) === Interval(-1.0,1.0)

    @test sign(interval(-1.0,0.0)) === Interval(-1.0,0.0)

    @test sign(interval(0.0,2.0)) === Interval(0.0,1.0)

    @test sign(interval(-0.0,2.0)) === Interval(0.0,1.0)

    @test sign(interval(-5.0,-2.0)) === Interval(-1.0,-1.0)

    @test sign(interval(0.0,0.0)) === Interval(0.0,0.0)

    @test sign(interval(-0.0,-0.0)) === Interval(0.0,0.0)

    @test sign(interval(-0.0,0.0)) === Interval(0.0,0.0)

    @test sign(entireinterval()) === Interval(-1.0,1.0)

end

@testset "minimal_sign_dec_test" begin

    @test sign(DecoratedInterval(interval(1.0,2.0), com)) === DecoratedInterval(Interval(1.0,1.0), com)

    @test sign(DecoratedInterval(interval(-1.0,2.0), com)) === DecoratedInterval(Interval(-1.0,1.0), def)

    @test sign(DecoratedInterval(interval(-1.0,0.0), com)) === DecoratedInterval(Interval(-1.0,0.0), def)

    @test sign(DecoratedInterval(interval(0.0,2.0), com)) === DecoratedInterval(Interval(0.0,1.0), def)

    @test sign(DecoratedInterval(interval(-0.0,2.0), def)) === DecoratedInterval(Interval(0.0,1.0), def)

    @test sign(DecoratedInterval(interval(-5.0,-2.0), trv)) === DecoratedInterval(Interval(-1.0,-1.0), trv)

    @test sign(DecoratedInterval(interval(0.0,0.0), dac)) === DecoratedInterval(Interval(0.0,0.0), dac)

end

@testset "minimal_ceil_test" begin

    @test ceil(emptyinterval()) === emptyinterval()

    @test ceil(entireinterval()) === entireinterval()

    @test ceil(interval(1.1,2.0)) === Interval(2.0,2.0)

    @test ceil(interval(-1.1,2.0)) === Interval(-1.0,2.0)

    @test ceil(interval(-1.1,0.0)) === Interval(-1.0,0.0)

    @test ceil(interval(-1.1,-0.0)) === Interval(-1.0,0.0)

    @test ceil(interval(-1.1,-0.4)) === Interval(-1.0,0.0)

    @test ceil(interval(-1.9,2.2)) === Interval(-1.0,3.0)

    @test ceil(interval(-1.0,2.2)) === Interval(-1.0,3.0)

    @test ceil(interval(0.0,2.2)) === Interval(0.0,3.0)

    @test ceil(interval(-0.0,2.2)) === Interval(0.0,3.0)

    @test ceil(interval(-1.5,Inf)) === Interval(-1.0,Inf)

    @test ceil(interval(0x1.FFFFFFFFFFFFFp1023,Inf)) === Interval(0x1.FFFFFFFFFFFFFp1023,Inf)

    @test ceil(interval(-Inf,2.2)) === Interval(-Inf,3.0)

    @test ceil(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)) === Interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)

end

@testset "minimal_ceil_dec_test" begin

    @test ceil(DecoratedInterval(interval(1.1,2.0), com)) === DecoratedInterval(Interval(2.0,2.0), dac)

    @test ceil(DecoratedInterval(interval(-1.1,2.0), com)) === DecoratedInterval(Interval(-1.0,2.0), def)

    @test ceil(DecoratedInterval(interval(-1.1,0.0), dac)) === DecoratedInterval(Interval(-1.0,0.0), def)

    @test ceil(DecoratedInterval(interval(-1.1,-0.0), trv)) === DecoratedInterval(Interval(-1.0,0.0), trv)

    @test ceil(DecoratedInterval(interval(-1.1,-0.4), dac)) === DecoratedInterval(Interval(-1.0,0.0), def)

    @test ceil(DecoratedInterval(interval(-1.9,2.2), com)) === DecoratedInterval(Interval(-1.0,3.0), def)

    @test ceil(DecoratedInterval(interval(-1.0,2.2), dac)) === DecoratedInterval(Interval(-1.0,3.0), def)

    @test ceil(DecoratedInterval(interval(0.0,2.2), trv)) === DecoratedInterval(Interval(0.0,3.0), trv)

    @test ceil(DecoratedInterval(interval(-0.0,2.2), def)) === DecoratedInterval(Interval(0.0,3.0), def)

    @test ceil(DecoratedInterval(interval(-1.5,Inf), trv)) === DecoratedInterval(Interval(-1.0,Inf), trv)

    @test ceil(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,Inf), dac)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFp1023,Inf), def)

    @test ceil(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac)

    @test ceil(DecoratedInterval(interval(-Inf,2.2), trv)) === DecoratedInterval(Interval(-Inf,3.0), trv)

    @test ceil(DecoratedInterval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), dac)) === DecoratedInterval(Interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), def)

end

@testset "minimal_floor_test" begin

    @test floor(emptyinterval()) === emptyinterval()

    @test floor(entireinterval()) === entireinterval()

    @test floor(interval(1.1,2.0)) === Interval(1.0,2.0)

    @test floor(interval(-1.1,2.0)) === Interval(-2.0,2.0)

    @test floor(interval(-1.1,0.0)) === Interval(-2.0,0.0)

    @test floor(interval(-1.1,-0.0)) === Interval(-2.0,0.0)

    @test floor(interval(-1.1,-0.4)) === Interval(-2.0,-1.0)

    @test floor(interval(-1.9,2.2)) === Interval(-2.0,2.0)

    @test floor(interval(-1.0,2.2)) === Interval(-1.0,2.0)

    @test floor(interval(0.0,2.2)) === Interval(0.0,2.0)

    @test floor(interval(-0.0,2.2)) === Interval(0.0,2.0)

    @test floor(interval(-1.5,Inf)) === Interval(-2.0,Inf)

    @test floor(interval(-Inf,2.2)) === Interval(-Inf,2.0)

end

@testset "minimal_floor_dec_test" begin

    @test floor(DecoratedInterval(interval(1.1,2.0), com)) === DecoratedInterval(Interval(1.0,2.0), def)

    @test floor(DecoratedInterval(interval(-1.1,2.0), def)) === DecoratedInterval(Interval(-2.0,2.0), def)

    @test floor(DecoratedInterval(interval(-1.1,0.0), dac)) === DecoratedInterval(Interval(-2.0,0.0), def)

    @test floor(DecoratedInterval(interval(-1.2,-1.1), com)) === DecoratedInterval(Interval(-2.0,-2.0), com)

    @test floor(DecoratedInterval(interval(-1.1,-0.4), def)) === DecoratedInterval(Interval(-2.0,-1.0), def)

    @test floor(DecoratedInterval(interval(-1.9,2.2), com)) === DecoratedInterval(Interval(-2.0,2.0), def)

    @test floor(DecoratedInterval(interval(-1.0,2.2), trv)) === DecoratedInterval(Interval(-1.0,2.0), trv)

    @test floor(DecoratedInterval(interval(0.0,2.2), trv)) === DecoratedInterval(Interval(0.0,2.0), trv)

    @test floor(DecoratedInterval(interval(-0.0,2.2), com)) === DecoratedInterval(Interval(0.0,2.0), def)

    @test floor(DecoratedInterval(interval(-1.5,Inf), dac)) === DecoratedInterval(Interval(-2.0,Inf), def)

    @test floor(DecoratedInterval(interval(-Inf,2.2), trv)) === DecoratedInterval(Interval(-Inf,2.0), trv)

    @test floor(DecoratedInterval(interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(-0x1.FFFFFFFFFFFFFp1023,-0x1.FFFFFFFFFFFFFp1023), dac)

end

@testset "minimal_trunc_test" begin

    @test trunc(emptyinterval()) === emptyinterval()

    @test trunc(entireinterval()) === entireinterval()

    @test trunc(interval(1.1,2.1)) === Interval(1.0,2.0)

    @test trunc(interval(-1.1,2.0)) === Interval(-1.0,2.0)

    @test trunc(interval(-1.1,0.0)) === Interval(-1.0,0.0)

    @test trunc(interval(-1.1,-0.0)) === Interval(-1.0,0.0)

    @test trunc(interval(-1.1,-0.4)) === Interval(-1.0,0.0)

    @test trunc(interval(-1.9,2.2)) === Interval(-1.0,2.0)

    @test trunc(interval(-1.0,2.2)) === Interval(-1.0,2.0)

    @test trunc(interval(0.0,2.2)) === Interval(0.0,2.0)

    @test trunc(interval(-0.0,2.2)) === Interval(0.0,2.0)

    @test trunc(interval(-1.5,Inf)) === Interval(-1.0,Inf)

    @test trunc(interval(-Inf,2.2)) === Interval(-Inf,2.0)

end

@testset "minimal_trunc_dec_test" begin

    @test trunc(DecoratedInterval(interval(1.1,2.1), com)) === DecoratedInterval(Interval(1.0,2.0), def)

    @test trunc(DecoratedInterval(interval(1.1,1.9), com)) === DecoratedInterval(Interval(1.0,1.0), com)

    @test trunc(DecoratedInterval(interval(-1.1,2.0), dac)) === DecoratedInterval(Interval(-1.0,2.0), def)

    @test trunc(DecoratedInterval(interval(-1.1,0.0), trv)) === DecoratedInterval(Interval(-1.0,0.0), trv)

    @test trunc(DecoratedInterval(interval(-1.1,-0.0), def)) === DecoratedInterval(Interval(-1.0,0.0), def)

    @test trunc(DecoratedInterval(interval(-1.1,-0.4), com)) === DecoratedInterval(Interval(-1.0,0.0), def)

    @test trunc(DecoratedInterval(interval(-1.9,2.2), def)) === DecoratedInterval(Interval(-1.0,2.0), def)

    @test trunc(DecoratedInterval(interval(-1.0,2.2), dac)) === DecoratedInterval(Interval(-1.0,2.0), def)

    @test trunc(DecoratedInterval(interval(-1.5,Inf), dac)) === DecoratedInterval(Interval(-1.0,Inf), def)

    @test trunc(DecoratedInterval(interval(-Inf,2.2), trv)) === DecoratedInterval(Interval(-Inf,2.0), trv)

    @test trunc(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), com)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFp1023,0x1.FFFFFFFFFFFFFp1023), dac)

    @test trunc(DecoratedInterval(interval(0x1.FFFFFFFFFFFFFp1023,Inf), dac)) === DecoratedInterval(Interval(0x1.FFFFFFFFFFFFFp1023,Inf), def)

end

@testset "minimal_round_ties_to_even_test" begin

    @test round(emptyinterval()) === emptyinterval()

    @test round(entireinterval()) === entireinterval()

    @test round(interval(1.1,2.1)) === Interval(1.0,2.0)

    @test round(interval(-1.1,2.0)) === Interval(-1.0,2.0)

    @test round(interval(-1.1,-0.4)) === Interval(-1.0,0.0)

    @test round(interval(-1.1,0.0)) === Interval(-1.0,0.0)

    @test round(interval(-1.1,-0.0)) === Interval(-1.0,0.0)

    @test round(interval(-1.9,2.2)) === Interval(-2.0,2.0)

    @test round(interval(-1.0,2.2)) === Interval(-1.0,2.0)

    @test round(interval(1.5,2.1)) === Interval(2.0,2.0)

    @test round(interval(-1.5,2.0)) === Interval(-2.0,2.0)

    @test round(interval(-1.1,-0.5)) === Interval(-1.0,0.0)

    @test round(interval(-1.9,2.5)) === Interval(-2.0,2.0)

    @test round(interval(0.0,2.5)) === Interval(0.0,2.0)

    @test round(interval(-0.0,2.5)) === Interval(0.0,2.0)

    @test round(interval(-1.5,2.5)) === Interval(-2.0,2.0)

    @test round(interval(-1.5,Inf)) === Interval(-2.0,Inf)

    @test round(interval(-Inf,2.2)) === Interval(-Inf,2.0)

end

@testset "minimal_round_ties_to_even_dec_test" begin

    @test round(DecoratedInterval(interval(1.1,2.1), com)) === DecoratedInterval(Interval(1.0,2.0), def)

    @test round(DecoratedInterval(interval(-1.1,2.0), trv)) === DecoratedInterval(Interval(-1.0,2.0), trv)

    @test round(DecoratedInterval(interval(-1.6,-1.5), com)) === DecoratedInterval(Interval(-2.0,-2.0), dac)

    @test round(DecoratedInterval(interval(-1.6,-1.4), com)) === DecoratedInterval(Interval(-2.0,-1.0), def)

    @test round(DecoratedInterval(interval(-1.5,Inf), dac)) === DecoratedInterval(Interval(-2.0,Inf), def)

    @test round(DecoratedInterval(interval(-Inf,2.2), trv)) === DecoratedInterval(Interval(-Inf,2.0), trv)

end

@testset "minimal_round_ties_to_away_test" begin

    @test round(emptyinterval(), RoundNearestTiesAway) === emptyinterval()

    @test round(entireinterval(), RoundNearestTiesAway) === entireinterval()

    @test round(interval(1.1,2.1), RoundNearestTiesAway) === Interval(1.0,2.0)

    @test round(interval(-1.1,2.0), RoundNearestTiesAway) === Interval(-1.0,2.0)

    @test round(interval(-1.1,0.0), RoundNearestTiesAway) === Interval(-1.0,0.0)

    @test round(interval(-1.1,-0.0), RoundNearestTiesAway) === Interval(-1.0,-0.0)

    @test round(interval(-1.1,-0.4), RoundNearestTiesAway) === Interval(-1.0,0.0)

    @test round(interval(-1.9,2.2), RoundNearestTiesAway) === Interval(-2.0,2.0)

    @test round(interval(-1.0,2.2), RoundNearestTiesAway) === Interval(-1.0,2.0)

    @test round(interval(0.5,2.1), RoundNearestTiesAway) === Interval(1.0,2.0)

    @test round(interval(-2.5,2.0), RoundNearestTiesAway) === Interval(-3.0,2.0)

    @test round(interval(-1.1,-0.5), RoundNearestTiesAway) === Interval(-1.0,-1.0)

    @test round(interval(-1.9,2.5), RoundNearestTiesAway) === Interval(-2.0,3.0)

    @test round(interval(-1.5,2.5), RoundNearestTiesAway) === Interval(-2.0,3.0)

    @test round(interval(0.0,2.5), RoundNearestTiesAway) === Interval(0.0,3.0)

    @test round(interval(-0.0,2.5), RoundNearestTiesAway) === Interval(0.0,3.0)

    @test round(interval(-1.5,Inf), RoundNearestTiesAway) === Interval(-2.0,Inf)

    @test round(interval(-Inf,2.2), RoundNearestTiesAway) === Interval(-Inf,2.0)

end

@testset "minimal_round_ties_to_away_dec_test" begin

    @test round(DecoratedInterval(interval(1.1,2.1), com), RoundNearestTiesAway) === DecoratedInterval(Interval(1.0,2.0), def)

    @test round(DecoratedInterval(interval(-1.9,2.2), com), RoundNearestTiesAway) === DecoratedInterval(Interval(-2.0,2.0), def)

    @test round(DecoratedInterval(interval(1.9,2.2), com), RoundNearestTiesAway) === DecoratedInterval(Interval(2.0,2.0), com)

    @test round(DecoratedInterval(interval(-1.0,2.2), trv), RoundNearestTiesAway) === DecoratedInterval(Interval(-1.0,2.0), trv)

    @test round(DecoratedInterval(interval(2.5,2.6), com), RoundNearestTiesAway) === DecoratedInterval(Interval(3.0,3.0), dac)

    @test round(DecoratedInterval(interval(-1.5,Inf), dac), RoundNearestTiesAway) === DecoratedInterval(Interval(-2.0,Inf), def)

    @test round(DecoratedInterval(interval(-Inf,2.2), def), RoundNearestTiesAway) === DecoratedInterval(Interval(-Inf,2.0), def)

end

@testset "minimal_abs_test" begin

    @test abs(emptyinterval()) === emptyinterval()

    @test abs(entireinterval()) === Interval(0.0,Inf)

    @test abs(interval(1.1,2.1)) === Interval(1.1,2.1)

    @test abs(interval(-1.1,2.0)) === Interval(0.0,2.0)

    @test abs(interval(-1.1,0.0)) === Interval(0.0,1.1)

    @test abs(interval(-1.1,-0.0)) === Interval(0.0,1.1)

    @test abs(interval(-1.1,-0.4)) === Interval(0.4,1.1)

    @test abs(interval(-1.9,0.2)) === Interval(0.0,1.9)

    @test abs(interval(0.0,0.2)) === Interval(0.0,0.2)

    @test abs(interval(-0.0,0.2)) === Interval(0.0,0.2)

    @test abs(interval(-1.5,Inf)) === Interval(0.0,Inf)

    @test abs(interval(-Inf,-2.2)) === Interval(2.2,Inf)

end

@testset "minimal_abs_dec_test" begin

    @test abs(DecoratedInterval(interval(-1.1,2.0), com)) === DecoratedInterval(Interval(0.0,2.0), com)

    @test abs(DecoratedInterval(interval(-1.1,0.0), dac)) === DecoratedInterval(Interval(0.0,1.1), dac)

    @test abs(DecoratedInterval(interval(-1.1,-0.0), def)) === DecoratedInterval(Interval(0.0,1.1), def)

    @test abs(DecoratedInterval(interval(-1.1,-0.4), trv)) === DecoratedInterval(Interval(0.4,1.1), trv)

    @test abs(DecoratedInterval(interval(-1.9,0.2), dac)) === DecoratedInterval(Interval(0.0,1.9), dac)

    @test abs(DecoratedInterval(interval(0.0,0.2), def)) === DecoratedInterval(Interval(0.0,0.2), def)

    @test abs(DecoratedInterval(interval(-0.0,0.2), com)) === DecoratedInterval(Interval(0.0,0.2), com)

    @test abs(DecoratedInterval(interval(-1.5,Inf), dac)) === DecoratedInterval(Interval(0.0,Inf), dac)

end

@testset "minimal_min_test" begin

    @test min(emptyinterval(), interval(1.0,2.0)) === emptyinterval()

    @test min(interval(1.0,2.0), emptyinterval()) === emptyinterval()

    @test min(emptyinterval(), emptyinterval()) === emptyinterval()

    @test min(entireinterval(), interval(1.0,2.0)) === Interval(-Inf,2.0)

    @test min(interval(1.0,2.0), entireinterval()) === Interval(-Inf,2.0)

    @test min(entireinterval(), entireinterval()) === entireinterval()

    @test min(emptyinterval(), entireinterval()) === emptyinterval()

    @test min(interval(1.0,5.0), interval(2.0,4.0)) === Interval(1.0,4.0)

    @test min(interval(0.0,5.0), interval(2.0,4.0)) === Interval(0.0,4.0)

    @test min(interval(-0.0,5.0), interval(2.0,4.0)) === Interval(0.0,4.0)

    @test min(interval(1.0,5.0), interval(2.0,8.0)) === Interval(1.0,5.0)

    @test min(interval(1.0,5.0), entireinterval()) === Interval(-Inf,5.0)

    @test min(interval(-7.0,-5.0), interval(2.0,4.0)) === Interval(-7.0,-5.0)

    @test min(interval(-7.0,0.0), interval(2.0,4.0)) === Interval(-7.0,0.0)

    @test min(interval(-7.0,-0.0), interval(2.0,4.0)) === Interval(-7.0,0.0)

end

@testset "minimal_min_dec_test" begin

    @test min(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(1.0,2.0), com)) === DecoratedInterval(Interval(-Inf,2.0), dac)

    @test min(DecoratedInterval(interval(-7.0,-5.0), trv), DecoratedInterval(interval(2.0,4.0), def)) === DecoratedInterval(Interval(-7.0,-5.0), trv)

    @test min(DecoratedInterval(interval(-7.0,0.0), dac), DecoratedInterval(interval(2.0,4.0), def)) === DecoratedInterval(Interval(-7.0,0.0), def)

    @test min(DecoratedInterval(interval(-7.0,-0.0), com), DecoratedInterval(interval(2.0,4.0), com)) === DecoratedInterval(Interval(-7.0,0.0), com)

end

@testset "minimal_max_test" begin

    @test max(emptyinterval(), interval(1.0,2.0)) === emptyinterval()

    @test max(interval(1.0,2.0), emptyinterval()) === emptyinterval()

    @test max(emptyinterval(), emptyinterval()) === emptyinterval()

    @test max(entireinterval(), interval(1.0,2.0)) === Interval(1.0,Inf)

    @test max(interval(1.0,2.0), entireinterval()) === Interval(1.0,Inf)

    @test max(entireinterval(), entireinterval()) === entireinterval()

    @test max(emptyinterval(), entireinterval()) === emptyinterval()

    @test max(interval(1.0,5.0), interval(2.0,4.0)) === Interval(2.0,5.0)

    @test max(interval(1.0,5.0), interval(2.0,8.0)) === Interval(2.0,8.0)

    @test max(interval(-1.0,5.0), entireinterval()) === Interval(-1.0,Inf)

    @test max(interval(-7.0,-5.0), interval(2.0,4.0)) === Interval(2.0,4.0)

    @test max(interval(-7.0,-5.0), interval(0.0,4.0)) === Interval(0.0,4.0)

    @test max(interval(-7.0,-5.0), interval(-0.0,4.0)) === Interval(0.0,4.0)

    @test max(interval(-7.0,-5.0), interval(-2.0,0.0)) === Interval(-2.0,0.0)

    @test max(interval(-7.0,-5.0), interval(-2.0,-0.0)) === Interval(-2.0,0.0)

end

@testset "minimal_max_dec_test" begin

    @test max(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(1.0,2.0), com)) === DecoratedInterval(Interval(1.0,Inf), dac)

    @test max(DecoratedInterval(interval(-7.0,-5.0), trv), DecoratedInterval(interval(2.0,4.0), def)) === DecoratedInterval(Interval(2.0,4.0), trv)

    @test max(DecoratedInterval(interval(-7.0,5.0), dac), DecoratedInterval(interval(2.0,4.0), def)) === DecoratedInterval(Interval(2.0,5.0), def)

    @test max(DecoratedInterval(interval(3.0,3.5), com), DecoratedInterval(interval(2.0,4.0), com)) === DecoratedInterval(Interval(3.0,4.0), com)

end

