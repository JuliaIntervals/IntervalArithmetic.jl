@testset "minimal_nums_to_interval_test" begin

    @test bareinterval(-1.0,1.0) === bareinterval(-1.0,1.0)

    @test bareinterval(-Inf,1.0) === bareinterval(-Inf,1.0)

    @test bareinterval(-1.0,Inf) === bareinterval(-1.0,Inf)

    @test bareinterval(-Inf,Inf) === bareinterval(-Inf,Inf)

    @test_logs (:warn,) @test bareinterval(NaN,NaN) === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test bareinterval(1.0,-1.0) === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test bareinterval(-Inf,-Inf) === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test bareinterval(Inf,Inf) === emptyinterval(BareInterval{Float64})

end

@testset "minimal_nums_to_decorated_interval_test" begin

    @test interval(-1.0,1.0) === interval(bareinterval(-1.0,1.0), com)

    @test interval(-Inf,1.0) === interval(bareinterval(-Inf,1.0), dac)

    @test interval(-1.0,Inf) === interval(bareinterval(-1.0,Inf), dac)

    @test interval(-Inf,Inf) === interval(bareinterval(-Inf,Inf), dac)

    @test_logs (:warn,) @test interval(NaN,NaN) === nai(Interval{Float64})

    @test_logs (:warn,) @test interval(1.0,-1.0) === nai(Interval{Float64})

    @test_logs (:warn,) @test interval(-Inf,-Inf) === nai(Interval{Float64})

    @test_logs (:warn,) @test interval(Inf,Inf) === nai(Interval{Float64})

end

@testset "minimal_text_to_interval_test" begin

    @test parse(BareInterval{Float64}, "[ Empty  ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ Empty  ]_trv") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[  ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[  ]_trv") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[,]") === bareinterval(-Inf,Inf)

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[,]_trv") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[ entire  ]") === bareinterval(-Inf,Inf)

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ ENTIRE ]_dac") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[ ENTIRE ]") === bareinterval(-Inf,Inf)

    @test parse(BareInterval{Float64}, "[ -inf , INF  ]") === bareinterval(-Inf,Inf)

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ -inf, INF ]_def") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[-1.0,1.0]") === bareinterval(-1.0,1.0)

    @test parse(BareInterval{Float64}, "[  -1.0  ,  1.0  ]") === bareinterval(-1.0,1.0)

    @test parse(BareInterval{Float64}, "[  -1.0  , 1.0]") === bareinterval(-1.0,1.0)

    @test parse(BareInterval{Float64}, "[-1,]") === bareinterval(-1.0,Inf)

    @test parse(BareInterval{Float64}, "[-1.0, +inf]") === bareinterval(-1.0,Inf)

    @test parse(BareInterval{Float64}, "[-1.0, +infinity]") === bareinterval(-1.0,Inf)

    @test parse(BareInterval{Float64}, "[-Inf, 1.000 ]") === bareinterval(-Inf,1.0)

    @test parse(BareInterval{Float64}, "[-Infinity, 1.000 ]") === bareinterval(-Inf,1.0)

    @test parse(BareInterval{Float64}, "[1.0E+400 ]") === bareinterval(0x1.fffffffffffffp+1023,Inf)

    @test parse(BareInterval{Float64}, "[ -4/2, 10/5 ]") === bareinterval(-2.0,2.0)

    @test parse(BareInterval{Float64}, "[ -1/10, 1/10 ]") === bareinterval(-0.1,0.1)

    @test parse(BareInterval{Float64}, "0.0?") === bareinterval(-0.05,0.05)

    @test parse(BareInterval{Float64}, "0.0?u") === bareinterval(0.0,0.05)

    @test parse(BareInterval{Float64}, "0.0?d") === bareinterval(-0.05,0.0)

    @test parse(BareInterval{Float64}, "2.5?") === bareinterval(0x1.3999999999999p+1,0x1.4666666666667p+1)

    @test parse(BareInterval{Float64}, "2.5?u") === bareinterval(2.5,0x1.4666666666667p+1)

    @test parse(BareInterval{Float64}, "2.5?d") === bareinterval(0x1.3999999999999p+1,2.5)

    @test parse(BareInterval{Float64}, "0.000?5") === bareinterval(-0.005,0.005)

    @test parse(BareInterval{Float64}, "0.000?5u") === bareinterval(0.0,0.005)

    @test parse(BareInterval{Float64}, "0.000?5d") === bareinterval(-0.005,0.0)

    @test parse(BareInterval{Float64}, "2.500?5") === bareinterval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1)

    @test parse(BareInterval{Float64}, "2.500?5u") === bareinterval(2.5,0x1.40a3d70a3d70bp+1)

    @test parse(BareInterval{Float64}, "2.500?5d") === bareinterval(0x1.3f5c28f5c28f5p+1,2.5)

    @test parse(BareInterval{Float64}, "0.0??") === bareinterval(-Inf,Inf)

    @test parse(BareInterval{Float64}, "0.0??u") === bareinterval(0.0,Inf)

    @test parse(BareInterval{Float64}, "0.0??d") === bareinterval(-Inf,0.0)

    @test parse(BareInterval{Float64}, "2.5??") === bareinterval(-Inf,Inf)

    @test parse(BareInterval{Float64}, "2.5??u") === bareinterval(2.5,Inf)

    @test parse(BareInterval{Float64}, "2.5??d") === bareinterval(-Inf,2.5)

    @test parse(BareInterval{Float64}, "2.500?5e+27") === bareinterval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91)

    @test parse(BareInterval{Float64}, "2.500?5ue4") === bareinterval(0x1.86ap+14,0x1.8768p+14)

    @test parse(BareInterval{Float64}, "2.500?5de-5") === bareinterval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16)

    @test parse(BareInterval{Float64}, "10?3") === bareinterval(7.0,13.0)

    @test parse(BareInterval{Float64}, "10?3e380") === bareinterval(0x1.fffffffffffffp+1023,Inf)

    @test parse(BareInterval{Float64}, "1.0000000000000001?1") === bareinterval(1.0,0x1.0000000000001p+0)

    @test parse(BareInterval{Float64}, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") === bareinterval(-Inf,Inf)

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ Nai  ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ Nai  ]_ill") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ Nai  ]_trv") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ Empty  ]_ill") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[  ]_com") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[,]_com") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[   Entire ]_com") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ -inf ,  INF ]_com") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[  -1.0  , 1.0]_ill") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[  -1.0  , 1.0]_fooo") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[  -1.0  , 1.0]_da") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[-1.0,]_com") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[-Inf, 1.000 ]_ill") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[-I  nf, 1.000 ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[-Inf, 1.0  00 ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[-Inf ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[Inf , INF]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[ foo ]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[1.0000000000000002,1.0000000000000001]") === bareinterval(1.0,0x1.0000000000001p+0)

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]") === bareinterval(1.0,0x1.0000000000001p+0)

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[0x1.00000000000002p0,0x1.00000000000001p0]") === bareinterval(1.0,0x1.0000000000001p+0)

end

@testset "minimal_text_to_decorated_interval_test" begin

    @test parse(Interval{Float64}, "[ Empty  ]") === interval(emptyinterval(BareInterval{Float64}), trv)

    @test parse(Interval{Float64}, "[ Empty  ]_trv") === interval(emptyinterval(BareInterval{Float64}), trv)

    @test parse(Interval{Float64}, "[  ]") === interval(emptyinterval(BareInterval{Float64}), trv)

    @test parse(Interval{Float64}, "[  ]_trv") === interval(emptyinterval(BareInterval{Float64}), trv)

    @test parse(Interval{Float64}, "[,]") === interval(entireinterval(BareInterval{Float64}), dac)

    @test parse(Interval{Float64}, "[,]_trv") === interval(entireinterval(BareInterval{Float64}), trv)

    @test parse(Interval{Float64}, "[ entire  ]") === interval(entireinterval(BareInterval{Float64}), dac)

    @test parse(Interval{Float64}, "[ ENTIRE ]_dac") === interval(entireinterval(BareInterval{Float64}), dac)

    @test parse(Interval{Float64}, "[ -inf , INF  ]") === interval(entireinterval(BareInterval{Float64}), dac)

    @test parse(Interval{Float64}, "[ -inf, INF ]_def") === interval(entireinterval(BareInterval{Float64}), def)

    @test parse(Interval{Float64}, "[-1.0,1.0]") === interval(bareinterval(-1.0,1.0), com)

    @test parse(Interval{Float64}, "[  -1.0  ,  1.0  ]_com") === interval(bareinterval(-1.0,1.0), com)

    @test parse(Interval{Float64}, "[  -1.0  , 1.0]_trv") === interval(bareinterval(-1.0,1.0), trv)

    @test parse(Interval{Float64}, "[-1,]") === interval(bareinterval(-1.0,Inf), dac)

    @test parse(Interval{Float64}, "[-1.0, +inf]_def") === interval(bareinterval(-1.0,Inf), def)

    @test parse(Interval{Float64}, "[-1.0, +infinity]_def") === interval(bareinterval(-1.0,Inf), def)

    @test parse(Interval{Float64}, "[-Inf, 1.000 ]") === interval(bareinterval(-Inf,1.0), dac)

    @test parse(Interval{Float64}, "[-Infinity, 1.000 ]_trv") === interval(bareinterval(-Inf,1.0), trv)

    @test parse(Interval{Float64}, "[1.0E+400 ]_com") === interval(bareinterval(0x1.fffffffffffffp+1023,Inf), dac)

    @test parse(Interval{Float64}, "[ -4/2, 10/5 ]_com") === interval(bareinterval(-2.0,2.0), com)

    @test parse(Interval{Float64}, "[ -1/10, 1/10 ]_com") === interval(bareinterval(-0.1,0.1), com)

    @test parse(Interval{Float64}, "0.0?") === interval(bareinterval(-0.05,0.05), com)

    @test parse(Interval{Float64}, "0.0?u_trv") === interval(bareinterval(0.0,0.05), trv)

    @test parse(Interval{Float64}, "0.0?d_dac") === interval(bareinterval(-0.05,0.0), dac)

    @test parse(Interval{Float64}, "2.5?") === interval(bareinterval(0x1.3999999999999p+1,0x1.4666666666667p+1), com)

    @test parse(Interval{Float64}, "2.5?u") === interval(bareinterval(2.5,0x1.4666666666667p+1), com)

    @test parse(Interval{Float64}, "2.5?d_trv") === interval(bareinterval(0x1.3999999999999p+1,2.5), trv)

    @test parse(Interval{Float64}, "0.000?5") === interval(bareinterval(-0.005,0.005), com)

    @test parse(Interval{Float64}, "0.000?5u_def") === interval(bareinterval(0.0,0.005), def)

    @test parse(Interval{Float64}, "0.000?5d") === interval(bareinterval(-0.005,0.0), com)

    @test parse(Interval{Float64}, "2.500?5") === interval(bareinterval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1), com)

    @test parse(Interval{Float64}, "2.500?5u") === interval(bareinterval(2.5,0x1.40a3d70a3d70bp+1), com)

    @test parse(Interval{Float64}, "2.500?5d") === interval(bareinterval(0x1.3f5c28f5c28f5p+1,2.5), com)

    @test parse(Interval{Float64}, "0.0??_dac") === interval(bareinterval(-Inf,Inf), dac)

    @test parse(Interval{Float64}, "0.0??u_trv") === interval(bareinterval(0.0,Inf), trv)

    @test parse(Interval{Float64}, "0.0??d") === interval(bareinterval(-Inf,0.0), dac)

    @test parse(Interval{Float64}, "2.5??") === interval(bareinterval(-Inf,Inf), dac)

    @test parse(Interval{Float64}, "2.5??u_def") === interval(bareinterval(2.5,Inf), def)

    @test parse(Interval{Float64}, "2.5??d_dac") === interval(bareinterval(-Inf,2.5), dac)

    @test parse(Interval{Float64}, "2.500?5e+27") === interval(bareinterval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91), com)

    @test parse(Interval{Float64}, "2.500?5ue4_def") === interval(bareinterval(0x1.86ap+14,0x1.8768p+14), def)

    @test parse(Interval{Float64}, "2.500?5de-5") === interval(bareinterval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16), com)

    @test parse(Interval{Float64}, "[ Nai  ]") === nai(Interval{Float64})

    @test parse(Interval{Float64}, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_com") === interval(bareinterval(-Inf,Inf), dac)

    @test parse(Interval{Float64}, "10?3_com") === interval(bareinterval(7.0,13.0), com)

    @test parse(Interval{Float64}, "10?3e380_com") === interval(bareinterval(0x1.fffffffffffffp+1023,Inf), dac)

    @test_logs (:warn,) @test parse(Interval{Float64}, "[ Nai  ]_ill") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[ Nai  ]_trv") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[ Empty  ]_ill") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[  ]_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[,]_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[   Entire ]_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[ -inf ,  INF ]_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[  -1.0  , 1.0]_ill") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[  -1.0  , 1.0]_fooo") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[  -1.0  , 1.0]_da") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[-1.0,]_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[-Inf, 1.000 ]_ill") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[-I  nf, 1.000 ]") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[-Inf, 1.0  00 ]") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[-Inf ]") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[Inf , INF]") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[ foo ]") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "0.0??_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "0.0??u_ill") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "0.0??d_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "0.0??_com") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[1.0,2.0") === nai(Interval{Float64})

    @test_logs (:warn,) @test parse(Interval{Float64}, "[1.0000000000000002,1.0000000000000001]") === interval(bareinterval(1.0,0x1.0000000000001p+0), com)

    @test_logs (:warn,) @test parse(Interval{Float64}, "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]") === interval(bareinterval(1.0,0x1.0000000000001p+0), com)

    @test_logs (:warn,) @test parse(Interval{Float64}, "[0x1.00000000000002p0,0x1.00000000000001p0]") === interval(bareinterval(1.0,0x1.0000000000001p+0), com)

end

@testset "minimal_interval_part_test" begin

    @test bareinterval(interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)) === bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)

    @test bareinterval(interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) === bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)

    @test bareinterval(interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)) === bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)

    @test bareinterval(interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)) === bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)

    @test bareinterval(interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)) === bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)

    @test bareinterval(interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)) === bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)

    @test bareinterval(interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)) === bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)

    @test bareinterval(interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), trv)) === bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)

    @test bareinterval(interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) === bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)

    @test bareinterval(interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) === bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)

    @test bareinterval(interval(bareinterval(-Inf,Inf), trv)) === bareinterval(-Inf,Inf)

    @test bareinterval(interval(emptyinterval(BareInterval{Float64}), trv)) === emptyinterval(BareInterval{Float64})

    @test bareinterval(interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) === bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)

    @test_logs (:warn,) @test bareinterval(nai(Interval{Float64})) === emptyinterval(BareInterval{Float64})

end

@testset "minimal_new_dec_test" begin

    @test interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)) === interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), com)

    @test interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)) === interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

    @test interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)) === interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), com)

    @test interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)) === interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), com)

    @test interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)) === interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), com)

    @test interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)) === interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), com)

    @test interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)) === interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com)

    @test interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)) === interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com)

    @test interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)) === interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com)

    @test interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)) === interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com)

    @test interval(bareinterval(-Inf,Inf)) === interval(bareinterval(-Inf,Inf), dac)

    @test interval(emptyinterval(BareInterval{Float64})) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)) === interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

end

@testset "minimal_set_dec_test" begin

    @test interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv) === interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)

    @test interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) === interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

    @test interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac) === interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)

    @test interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def) === interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)

    @test interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv) === interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)

    @test interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def) === interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def)

    @test interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac) === interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac)

    @test interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com) === interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com)

    @test interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def) === interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def)

    @test interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv) === interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)

    @test interval(bareinterval(-Inf,Inf), dac) === interval(bareinterval(-Inf,Inf), dac)

    @test interval(emptyinterval(BareInterval{Float64}), trv) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) === interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

    @test interval(emptyinterval(BareInterval{Float64}), def) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test interval(emptyinterval(BareInterval{Float64}), dac) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test interval(emptyinterval(BareInterval{Float64}), com) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test interval(bareinterval(1.0,Inf), com) === interval(bareinterval(1.0,Inf), dac)

    @test interval(bareinterval(-Inf,3.0), com) === interval(bareinterval(-Inf,3.0), dac)

    @test interval(bareinterval(-Inf,Inf), com) === interval(bareinterval(-Inf,Inf), dac)

    @test_logs (:warn,) @test interval(emptyinterval(BareInterval{Float64}), ill) === nai(Interval{Float64})

    @test_logs (:warn,) @test interval(bareinterval(-Inf,3.0), ill) === nai(Interval{Float64})

    @test_logs (:warn,) @test interval(bareinterval(-1.0,3.0), ill) === nai(Interval{Float64})

end

@testset "minimal_decoration_part_test" begin

    @test decoration(nai(Interval{Float64})) === ill

    @test decoration(interval(emptyinterval(BareInterval{Float64}), trv)) === trv

    @test decoration(interval(bareinterval(-1.0,3.0), trv)) === trv

    @test decoration(interval(bareinterval(-1.0,3.0), def)) === def

    @test decoration(interval(bareinterval(-1.0,3.0), dac)) === dac

    @test decoration(interval(bareinterval(-1.0,3.0), com)) === com

end
