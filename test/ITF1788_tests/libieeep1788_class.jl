@testset "minimal_nums_to_interval_test" begin

    @test interval(-1.0,1.0) == Interval(-1.0,1.0)

    @test interval(-Inf,1.0) == Interval(-Inf,1.0)

    @test interval(-1.0,Inf) == Interval(-1.0,Inf)

    @test interval(-Inf,Inf) == Interval(-Inf,Inf)

    @test_logs (:warn, ) @test interval(NaN,NaN) == emptyinterval()

    @test_logs (:warn, ) @test interval(1.0,-1.0) == emptyinterval()

    @test_logs (:warn, ) @test interval(-Inf,-Inf) == emptyinterval()

    @test_logs (:warn, ) @test interval(Inf,Inf) == emptyinterval()

end

@testset "minimal_nums_to_decorated_interval_test" begin

    @test DecoratedInterval(-1.0,1.0) == DecoratedInterval(Interval(-1.0,1.0), com) && decoration(DecoratedInterval(-1.0,1.0)) == decoration(DecoratedInterval(Interval(-1.0,1.0), com))

    @test DecoratedInterval(-Inf,1.0) == DecoratedInterval(Interval(-Inf,1.0), dac) && decoration(DecoratedInterval(-Inf,1.0)) == decoration(DecoratedInterval(Interval(-Inf,1.0), dac))

    @test DecoratedInterval(-1.0,Inf) == DecoratedInterval(Interval(-1.0,Inf), dac) && decoration(DecoratedInterval(-1.0,Inf)) == decoration(DecoratedInterval(Interval(-1.0,Inf), dac))

    @test DecoratedInterval(-Inf,Inf) == DecoratedInterval(Interval(-Inf,Inf), dac) && decoration(DecoratedInterval(-Inf,Inf)) == decoration(DecoratedInterval(Interval(-Inf,Inf), dac))

    @test isnai(DecoratedInterval(NaN,NaN))
    
    @test isnai(DecoratedInterval(1.0,-1.0))

    @test isnai(DecoratedInterval(-Inf,-Inf))

    @test isnai(DecoratedInterval(Inf,Inf))

end


@testset "minimal_interval_part_test" begin

    @test interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)) == Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)

    @test interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) == Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)

    @test interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)) == Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)

    @test interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)) == Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)

    @test interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)) == Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)

    @test interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)) == Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)

    @test interval(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)) == Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)

    @test interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), trv)) == Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)

    @test interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) == Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)

    @test interval(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) == Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)

    @test interval(DecoratedInterval(interval(-Inf,Inf), trv)) == Interval(-Inf,Inf)

    @test interval(DecoratedInterval(emptyinterval(), trv)) == emptyinterval()

    @test interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) == Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)

    @test_logs (:warn, ) @test interval(nai()) == emptyinterval()

end

@testset "minimal_new_dec_test" begin

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)) == DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), com) && decoration(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4))) == decoration(DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), com))

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)) == DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) && decoration(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4))) == decoration(DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)) == DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), com) && decoration(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4))) == decoration(DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), com))

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)) == DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), com) && decoration(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4))) == decoration(DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), com))

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)) == DecoratedInterval(Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), com) && decoration(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022))) == decoration(DecoratedInterval(Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), com))

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)) == DecoratedInterval(Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), com) && decoration(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022))) == decoration(DecoratedInterval(Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), com))

    @test DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)) == DecoratedInterval(Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com) && decoration(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022))) == decoration(DecoratedInterval(Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com))

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com) && decoration(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023))) == decoration(DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com))

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com) && decoration(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023))) == decoration(DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com))

    @test DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)) == DecoratedInterval(Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com) && decoration(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023))) == decoration(DecoratedInterval(Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com))

    @test DecoratedInterval(interval(-Inf,Inf)) == DecoratedInterval(Interval(-Inf,Inf), dac) && decoration(DecoratedInterval(interval(-Inf,Inf))) == decoration(DecoratedInterval(Interval(-Inf,Inf), dac))

    @test DecoratedInterval(emptyinterval()) == DecoratedInterval(emptyinterval(), trv) && decoration(DecoratedInterval(emptyinterval())) == decoration(DecoratedInterval(emptyinterval(), trv))

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)) == DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) && decoration(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4))) == decoration(DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

end

@testset "minimal_set_dec_test" begin

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv) == DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv) && decoration(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)) == decoration(DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv))

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) == DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) && decoration(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) == decoration(DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac) == DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac) && decoration(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)) == decoration(DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac))

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def) == DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def) && decoration(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)) == decoration(DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def))

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv) == DecoratedInterval(Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv) && decoration(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)) == decoration(DecoratedInterval(Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv))

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def) == DecoratedInterval(Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def) && decoration(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def)) == decoration(DecoratedInterval(Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def))

    @test DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac) == DecoratedInterval(Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac) && decoration(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac)) == decoration(DecoratedInterval(Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac))

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com) && decoration(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com)) == decoration(DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com))

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def) == DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def) && decoration(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def)) == decoration(DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def))

    @test DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv) == DecoratedInterval(Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv) && decoration(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) == decoration(DecoratedInterval(Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv))

    @test DecoratedInterval(interval(-Inf,Inf), dac) == DecoratedInterval(Interval(-Inf,Inf), dac) && decoration(DecoratedInterval(interval(-Inf,Inf), dac)) == decoration(DecoratedInterval(Interval(-Inf,Inf), dac))

    @test DecoratedInterval(emptyinterval(), trv) == DecoratedInterval(emptyinterval(), trv) && decoration(DecoratedInterval(emptyinterval(), trv)) == decoration(DecoratedInterval(emptyinterval(), trv))

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) == DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) && decoration(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) == decoration(DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

    @test DecoratedInterval(emptyinterval(), def) == DecoratedInterval(emptyinterval(), trv) && decoration(DecoratedInterval(emptyinterval(), def)) == decoration(DecoratedInterval(emptyinterval(), trv))

    @test DecoratedInterval(emptyinterval(), dac) == DecoratedInterval(emptyinterval(), trv) && decoration(DecoratedInterval(emptyinterval(), dac)) == decoration(DecoratedInterval(emptyinterval(), trv))

    @test DecoratedInterval(emptyinterval(), com) == DecoratedInterval(emptyinterval(), trv) && decoration(DecoratedInterval(emptyinterval(), com)) == decoration(DecoratedInterval(emptyinterval(), trv))

    @test DecoratedInterval(interval(1.0,Inf), com) == DecoratedInterval(Interval(1.0,Inf), dac) && decoration(DecoratedInterval(interval(1.0,Inf), com)) == decoration(DecoratedInterval(Interval(1.0,Inf), dac))

    @test DecoratedInterval(interval(-Inf,3.0), com) == DecoratedInterval(Interval(-Inf,3.0), dac) && decoration(DecoratedInterval(interval(-Inf,3.0), com)) == decoration(DecoratedInterval(Interval(-Inf,3.0), dac))

    @test DecoratedInterval(interval(-Inf,Inf), com) == DecoratedInterval(Interval(-Inf,Inf), dac) && decoration(DecoratedInterval(interval(-Inf,Inf), com)) == decoration(DecoratedInterval(Interval(-Inf,Inf), dac))

    @test isnai(DecoratedInterval(emptyinterval(), ill))

    @test isnai(DecoratedInterval(interval(-Inf,3.0), ill))

    @test isnai(DecoratedInterval(interval(-1.0,3.0), ill))

end

@testset "minimal_decoration_part_test" begin

    @test decoration(nai()) == ill

    @test decoration(DecoratedInterval(emptyinterval(), trv)) == trv

    @test decoration(DecoratedInterval(interval(-1.0,3.0), trv)) == trv

    @test decoration(DecoratedInterval(interval(-1.0,3.0), def)) == def

    @test decoration(DecoratedInterval(interval(-1.0,3.0), dac)) == dac

    @test decoration(DecoratedInterval(interval(-1.0,3.0), com)) == com

end

