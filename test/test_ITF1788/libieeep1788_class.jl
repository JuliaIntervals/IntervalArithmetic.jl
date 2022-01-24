@testset "minimal_nums_to_interval_test" begin

    @test interval(-1.0,1.0) === Interval(-1.0,1.0)

    @test interval(-Inf,1.0) === Interval(-Inf,1.0)

    @test interval(-1.0,Inf) === Interval(-1.0,Inf)

    @test interval(-Inf,Inf) === Interval(-Inf,Inf)

    @test_logs (:warn, ) @test interval(NaN,NaN) === emptyinterval()

    @test_logs (:warn, ) @test interval(1.0,-1.0) === emptyinterval()

    @test_logs (:warn, ) @test interval(-Inf,-Inf) === emptyinterval()

    @test_logs (:warn, ) @test interval(Inf,Inf) === emptyinterval()

end

@testset "minimal_nums_to_decorated_interval_test" begin

    @test DecoratedInterval(-1.0,1.0) === DecoratedInterval(Interval(-1.0,1.0), com)

    @test DecoratedInterval(-Inf,1.0) === DecoratedInterval(Interval(-Inf,1.0), dac)

    @test DecoratedInterval(-1.0,Inf) === DecoratedInterval(Interval(-1.0,Inf), dac)

    @test DecoratedInterval(-Inf,Inf) === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test_logs (:warn, ) @test isnai(DecoratedInterval(NaN,NaN))

    @test_logs (:warn, ) @test isnai(DecoratedInterval(1.0,-1.0))

    @test_logs (:warn, ) @test isnai(DecoratedInterval(-Inf,-Inf))

    @test_logs (:warn, ) @test isnai(DecoratedInterval(Inf,Inf))

end

@testset "minimal_text_to_interval_test" begin

    @test_skip @interval("[ Empty  ]") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[ Empty  ]_trv") === emptyinterval()

    @test_skip @interval("[  ]") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[  ]_trv") === emptyinterval()

    @test_skip @interval("[,]") === Interval(-Inf,Inf)

    @test_logs (:warn, ) @test_skip @interval("[,]_trv") === emptyinterval()

    @test_skip @interval("[ entire  ]") === Interval(-Inf,Inf)

    @test_logs (:warn, ) @test_skip @interval("[ ENTIRE ]_dac") === emptyinterval()

    @test_skip @interval("[ ENTIRE ]") === Interval(-Inf,Inf)

    @test @interval("[ -inf , INF  ]") === Interval(-Inf,Inf)

    @test_logs (:warn, ) @test_skip @interval("[ -inf, INF ]_def") === emptyinterval()

    @test @interval("[-1.0,1.0]") === Interval(-1.0,1.0)

    @test @interval("[  -1.0  ,  1.0  ]") === Interval(-1.0,1.0)

    @test @interval("[  -1.0  , 1.0]") === Interval(-1.0,1.0)

    @test_skip @interval("[-1,]") === Interval(-1.0,Inf)

    @test @interval("[-1.0, +inf]") === Interval(-1.0,Inf)

    @test @interval("[-1.0, +infinity]") === Interval(-1.0,Inf)

    @test @interval("[-Inf, 1.000 ]") === Interval(-Inf,1.0)

    @test @interval("[-Infinity, 1.000 ]") === Interval(-Inf,1.0)

    @test @interval("[1.0E+400 ]") === Interval(0x1.fffffffffffffp+1023,Inf)

    @test @interval("[ -4/2, 10/5 ]") === Interval(-2.0,2.0)

    @test @interval("[ -1/10, 1/10 ]") === Interval(-0.1,0.1)

    @test @interval("0.0?") === Interval(-0.05,0.05)

    @test @interval("0.0?u") === Interval(0.0,0.05)

    @test @interval("0.0?d") === Interval(-0.05,0.0)

    @test @interval("2.5?") === Interval(0x1.3999999999999p+1,0x1.4666666666667p+1)

    @test @interval("2.5?u") === Interval(2.5,0x1.4666666666667p+1)

    @test @interval("2.5?d") === Interval(0x1.3999999999999p+1,2.5)

    @test @interval("0.000?5") === Interval(-0.005,0.005)

    @test @interval("0.000?5u") === Interval(0.0,0.005)

    @test @interval("0.000?5d") === Interval(-0.005,0.0)

    @test @interval("2.500?5") === Interval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1)

    @test @interval("2.500?5u") === Interval(2.5,0x1.40a3d70a3d70bp+1)

    @test @interval("2.500?5d") === Interval(0x1.3f5c28f5c28f5p+1,2.5)

    @test_skip @interval("0.0??") === Interval(-Inf,Inf)

    @test_skip @interval("0.0??u") === Interval(0.0,Inf)

    @test_skip @interval("0.0??d") === Interval(-Inf,0.0)

    @test_skip @interval("2.5??") === Interval(-Inf,Inf)

    @test_skip @interval("2.5??u") === Interval(2.5,Inf)

    @test_skip @interval("2.5??d") === Interval(-Inf,2.5)

    @test_skip @interval("2.500?5e+27") === Interval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91)

    @test @interval("2.500?5ue4") === Interval(0x1.86ap+14,0x1.8768p+14)

    @test @interval("2.500?5de-5") === Interval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16)

    @test @interval("10?3") === Interval(7.0,13.0)

    @test_skip @interval("10?3e380") === Interval(0x1.fffffffffffffp+1023,Inf)

    @test @interval("1.0000000000000001?1") === Interval(1.0,0x1.0000000000001p+0)

    @test_skip @interval("10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") === Interval(-Inf,Inf)

    @test_logs (:warn, ) @test_skip @interval("[ Nai  ]") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[ Nai  ]_ill") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[ Nai  ]_trv") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[ Empty  ]_ill") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[  ]_com") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[,]_com") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[   Entire ]_com") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[ -inf ,  INF ]_com") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[  -1.0  , 1.0]_ill") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[  -1.0  , 1.0]_fooo") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[  -1.0  , 1.0]_da") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[-1.0,]_com") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[-Inf, 1.000 ]_ill") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[-I  nf, 1.000 ]") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[-Inf, 1.0  00 ]") === emptyinterval()

    @test_logs (:warn, ) @test @interval("[-Inf ]") === emptyinterval()

    @test_logs (:warn, ) @test @interval("[Inf , INF]") === emptyinterval()

    @test_logs (:warn, ) @test_skip @interval("[ foo ]") === emptyinterval()

    @test_logs (:warn, ) @test @interval("[1.0000000000000002,1.0000000000000001]") === Interval(1.0,0x1.0000000000001p+0)

    @test_logs (:warn, ) @test @interval("[10000000000000001/10000000000000000,10000000000000002/10000000000000001]") === Interval(1.0,0x1.0000000000001p+0)

    @test_logs (:warn, ) @test @interval("[0x1.00000000000002p0,0x1.00000000000001p0]") === Interval(1.0,0x1.0000000000001p+0)

end

@testset "minimal_text_to_decorated_interval_test" begin

    @test_skip @decorated("[ Empty  ]") === DecoratedInterval(emptyinterval(), trv)

    @test_skip @decorated("[ Empty  ]_trv") === DecoratedInterval(emptyinterval(), trv)

    @test_skip @decorated("[  ]") === DecoratedInterval(emptyinterval(), trv)

    @test_skip @decorated("[  ]_trv") === DecoratedInterval(emptyinterval(), trv)

    @test_skip @decorated("[,]") === DecoratedInterval(entireinterval(), dac)

    @test_skip @decorated("[,]_trv") === DecoratedInterval(entireinterval(), trv)

    @test_skip @decorated("[ entire  ]") === DecoratedInterval(entireinterval(), dac)

    @test_skip @decorated("[ ENTIRE ]_dac") === DecoratedInterval(entireinterval(), dac)

    @test @decorated("[ -inf , INF  ]") === DecoratedInterval(entireinterval(), dac)

    @test @decorated("[ -inf, INF ]_def") === DecoratedInterval(entireinterval(), def)

    @test @decorated("[-1.0,1.0]") === DecoratedInterval(Interval(-1.0,1.0), com)

    @test @decorated("[  -1.0  ,  1.0  ]_com") === DecoratedInterval(Interval(-1.0,1.0), com)

    @test @decorated("[  -1.0  , 1.0]_trv") === DecoratedInterval(Interval(-1.0,1.0), trv)

    @test_skip @decorated("[-1,]") === DecoratedInterval(Interval(-1.0,Inf), dac)

    @test @decorated("[-1.0, +inf]_def") === DecoratedInterval(Interval(-1.0,Inf), def)

    @test @decorated("[-1.0, +infinity]_def") === DecoratedInterval(Interval(-1.0,Inf), def)

    @test @decorated("[-Inf, 1.000 ]") === DecoratedInterval(Interval(-Inf,1.0), dac)

    @test @decorated("[-Infinity, 1.000 ]_trv") === DecoratedInterval(Interval(-Inf,1.0), trv)

    @test_skip @decorated("[1.0E+400 ]_com") === DecoratedInterval(Interval(0x1.fffffffffffffp+1023,Inf), dac)

    @test @decorated("[ -4/2, 10/5 ]_com") === DecoratedInterval(Interval(-2.0,2.0), com)

    @test @decorated("[ -1/10, 1/10 ]_com") === DecoratedInterval(Interval(-0.1,0.1), com)

    @test @decorated("0.0?") === DecoratedInterval(Interval(-0.05,0.05), com)

    @test @decorated("0.0?u_trv") === DecoratedInterval(Interval(0.0,0.05), trv)

    @test @decorated("0.0?d_dac") === DecoratedInterval(Interval(-0.05,0.0), dac)

    @test @decorated("2.5?") === DecoratedInterval(Interval(0x1.3999999999999p+1,0x1.4666666666667p+1), com)

    @test @decorated("2.5?u") === DecoratedInterval(Interval(2.5,0x1.4666666666667p+1), com)

    @test @decorated("2.5?d_trv") === DecoratedInterval(Interval(0x1.3999999999999p+1,2.5), trv)

    @test @decorated("0.000?5") === DecoratedInterval(Interval(-0.005,0.005), com)

    @test @decorated("0.000?5u_def") === DecoratedInterval(Interval(0.0,0.005), def)

    @test @decorated("0.000?5d") === DecoratedInterval(Interval(-0.005,0.0), com)

    @test @decorated("2.500?5") === DecoratedInterval(Interval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1), com)

    @test @decorated("2.500?5u") === DecoratedInterval(Interval(2.5,0x1.40a3d70a3d70bp+1), com)

    @test @decorated("2.500?5d") === DecoratedInterval(Interval(0x1.3f5c28f5c28f5p+1,2.5), com)

    @test_skip @decorated("0.0??_dac") === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test_skip @decorated("0.0??u_trv") === DecoratedInterval(Interval(0.0,Inf), trv)

    @test_skip @decorated("0.0??d") === DecoratedInterval(Interval(-Inf,0.0), dac)

    @test_skip @decorated("2.5??") === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test_skip @decorated("2.5??u_def") === DecoratedInterval(Interval(2.5,Inf), def)

    @test_skip @decorated("2.5??d_dac") === DecoratedInterval(Interval(-Inf,2.5), dac)

    @test_skip @decorated("2.500?5e+27") === DecoratedInterval(Interval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91), com)

    @test @decorated("2.500?5ue4_def") === DecoratedInterval(Interval(0x1.86ap+14,0x1.8768p+14), def)

    @test @decorated("2.500?5de-5") === DecoratedInterval(Interval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16), com)

    @test_skip isnai(@decorated("[ Nai  ]"))

    @test_skip @decorated("10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_com") === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test @decorated("10?3_com") === DecoratedInterval(Interval(7.0,13.0), com)

    @test_skip @decorated("10?3e380_com") === DecoratedInterval(Interval(0x1.fffffffffffffp+1023,Inf), dac)

    @test_logs (:warn, ) @test_skip isnai(@decorated("[ Nai  ]_ill"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[ Nai  ]_trv"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[ Empty  ]_ill"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[  ]_com"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[,]_com"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[   Entire ]_com"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[ -inf ,  INF ]_com"))

    @test_logs (:warn, ) @test isnai(@decorated("[  -1.0  , 1.0]_ill"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[  -1.0  , 1.0]_fooo"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[  -1.0  , 1.0]_da"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[-1.0,]_com"))

    @test_logs (:warn, ) @test isnai(@decorated("[-Inf, 1.000 ]_ill"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[-I  nf, 1.000 ]"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[-Inf, 1.0  00 ]"))

    @test_logs (:warn, ) @test isnai(@decorated("[-Inf ]"))

    @test_logs (:warn, ) @test isnai(@decorated("[Inf , INF]"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[ foo ]"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("0.0??_com"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("0.0??u_ill"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("0.0??d_com"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("0.0??_com"))

    @test_logs (:warn, ) @test_skip isnai(@decorated("[1.0,2.0"))

    @test_logs (:warn, ) @test @decorated("[1.0000000000000002,1.0000000000000001]") === DecoratedInterval(Interval(1.0,0x1.0000000000001p+0), com)

    @test_logs (:warn, ) @test @decorated("[10000000000000001/10000000000000000,10000000000000002/10000000000000001]") === DecoratedInterval(Interval(1.0,0x1.0000000000001p+0), com)

    @test_logs (:warn, ) @test @decorated("[0x1.00000000000002p0,0x1.00000000000001p0]") === DecoratedInterval(Interval(1.0,0x1.0000000000001p+0), com)

end

@testset "minimal_interval_part_test" begin

    @test_skip interval_part(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)) === Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)

    @test_skip interval_part(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) === Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)

    @test_skip interval_part(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)) === Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)

    @test_skip interval_part(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)) === Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)

    @test_skip interval_part(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)) === Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)

    @test_skip interval_part(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)) === Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)

    @test_skip interval_part(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)) === Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)

    @test_skip interval_part(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), trv)) === Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)

    @test_skip interval_part(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) === Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)

    @test_skip interval_part(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)) === Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)

    @test_skip interval_part(DecoratedInterval(interval(-Inf,Inf), trv)) === Interval(-Inf,Inf)

    @test_skip interval_part(DecoratedInterval(emptyinterval(), trv)) === emptyinterval()

    @test_skip interval_part(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)) === Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)

    @test_logs (:warn, ) @test_skip interval_part(nai()) === emptyinterval()

end

@testset "minimal_new_dec_test" begin

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)) === DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), com)

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)) === DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)) === DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), com)

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)) === DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), com)

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)) === DecoratedInterval(Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), com)

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)) === DecoratedInterval(Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), com)

    @test DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)) === DecoratedInterval(Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com)

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)) === DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com)

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)) === DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com)

    @test DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)) === DecoratedInterval(Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com)

    @test DecoratedInterval(interval(-Inf,Inf)) === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test DecoratedInterval(emptyinterval()) === DecoratedInterval(emptyinterval(), trv)

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)) === DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

end

@testset "minimal_set_dec_test" begin

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv) === DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) === DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

    @test DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac) === DecoratedInterval(Interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def) === DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv) === DecoratedInterval(Interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)

    @test DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def) === DecoratedInterval(Interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def)

    @test DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac) === DecoratedInterval(Interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac)

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com) === DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com)

    @test DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def) === DecoratedInterval(Interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def)

    @test DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv) === DecoratedInterval(Interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)

    @test DecoratedInterval(interval(-Inf,Inf), dac) === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test DecoratedInterval(emptyinterval(), trv) === DecoratedInterval(emptyinterval(), trv)

    @test DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com) === DecoratedInterval(Interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)

    @test_skip DecoratedInterval(emptyinterval(), def) === DecoratedInterval(emptyinterval(), trv)

    @test_skip DecoratedInterval(emptyinterval(), dac) === DecoratedInterval(emptyinterval(), trv)

    @test_skip DecoratedInterval(emptyinterval(), com) === DecoratedInterval(emptyinterval(), trv)

    @test_skip DecoratedInterval(interval(1.0,Inf), com) === DecoratedInterval(Interval(1.0,Inf), dac)

    @test_skip DecoratedInterval(interval(-Inf,3.0), com) === DecoratedInterval(Interval(-Inf,3.0), dac)

    @test_skip DecoratedInterval(interval(-Inf,Inf), com) === DecoratedInterval(Interval(-Inf,Inf), dac)

    @test_logs (:warn, ) @test isnai(DecoratedInterval(emptyinterval(), ill))

    @test_logs (:warn, ) @test isnai(DecoratedInterval(interval(-Inf,3.0), ill))

    @test_logs (:warn, ) @test isnai(DecoratedInterval(interval(-1.0,3.0), ill))

end

@testset "minimal_decoration_part_test" begin

    @test decoration(nai()) === ill

    @test decoration(DecoratedInterval(emptyinterval(), trv)) === trv

    @test decoration(DecoratedInterval(interval(-1.0,3.0), trv)) === trv

    @test decoration(DecoratedInterval(interval(-1.0,3.0), def)) === def

    @test decoration(DecoratedInterval(interval(-1.0,3.0), dac)) === dac

    @test decoration(DecoratedInterval(interval(-1.0,3.0), com)) === com

end

