@testset "minimal_nums_to_interval_test" begin

    @test isequal_interval(interval(-1.0,1.0), interval(-1.0,1.0))

    @test isequal_interval(interval(-Inf,1.0), interval(-Inf,1.0))

    @test isequal_interval(interval(-1.0,Inf), interval(-1.0,Inf))

    @test isequal_interval(interval(-Inf,Inf), interval(-Inf,Inf))

    @test isequal_interval(interval(NaN,NaN), emptyinterval())

    @test isequal_interval(interval(1.0,-1.0), emptyinterval())

    @test isequal_interval(interval(-Inf,-Inf), emptyinterval())

    @test isequal_interval(interval(Inf,Inf), emptyinterval())

end

@testset "minimal_nums_to_decorated_interval_test" begin

    @test isequal_interval(DecoratedInterval(-1.0,1.0), DecoratedInterval(interval(-1.0,1.0), com))

    @test isequal_interval(DecoratedInterval(-Inf,1.0), DecoratedInterval(interval(-Inf,1.0), dac))

    @test isequal_interval(DecoratedInterval(-1.0,Inf), DecoratedInterval(interval(-1.0,Inf), dac))

    @test isequal_interval(DecoratedInterval(-Inf,Inf), DecoratedInterval(interval(-Inf,Inf), dac))

    @test isnai(DecoratedInterval(NaN,NaN))

    @test isnai(DecoratedInterval(1.0,-1.0))

    @test isnai(DecoratedInterval(-Inf,-Inf))

    @test isnai(DecoratedInterval(Inf,Inf))

end

@testset "minimal_text_to_interval_test" begin

    @test isequal_interval(parse(Interval{Float64}, "[ Empty  ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ Empty  ]_trv"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[  ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[  ]_trv"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[,]"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[,]_trv"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ entire  ]"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[ ENTIRE ]_dac"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ ENTIRE ]"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[ -inf , INF  ]"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[ -inf, INF ]_def"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[-1.0,1.0]"), interval(-1.0,1.0))

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  ,  1.0  ]"), interval(-1.0,1.0))

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  , 1.0]"), interval(-1.0,1.0))

    @test isequal_interval(parse(Interval{Float64}, "[-1,]"), interval(-1.0,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[-1.0, +inf]"), interval(-1.0,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[-1.0, +infinity]"), interval(-1.0,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[-Inf, 1.000 ]"), interval(-Inf,1.0))

    @test isequal_interval(parse(Interval{Float64}, "[-Infinity, 1.000 ]"), interval(-Inf,1.0))

    @test isequal_interval(parse(Interval{Float64}, "[1.0E+400 ]"), interval(0x1.fffffffffffffp+1023,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[ -4/2, 10/5 ]"), interval(-2.0,2.0))

    @test isequal_interval(parse(Interval{Float64}, "[ -1/10, 1/10 ]"), interval(-0.1,0.1))

    @test isequal_interval(parse(Interval{Float64}, "0.0?"), interval(-0.05,0.05))

    @test isequal_interval(parse(Interval{Float64}, "0.0?u"), interval(0.0,0.05))

    @test isequal_interval(parse(Interval{Float64}, "0.0?d"), interval(-0.05,0.0))

    @test isequal_interval(parse(Interval{Float64}, "2.5?"), interval(0x1.3999999999999p+1,0x1.4666666666667p+1))

    @test isequal_interval(parse(Interval{Float64}, "2.5?u"), interval(2.5,0x1.4666666666667p+1))

    @test isequal_interval(parse(Interval{Float64}, "2.5?d"), interval(0x1.3999999999999p+1,2.5))

    @test isequal_interval(parse(Interval{Float64}, "0.000?5"), interval(-0.005,0.005))

    @test isequal_interval(parse(Interval{Float64}, "0.000?5u"), interval(0.0,0.005))

    @test isequal_interval(parse(Interval{Float64}, "0.000?5d"), interval(-0.005,0.0))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5"), interval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5u"), interval(2.5,0x1.40a3d70a3d70bp+1))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5d"), interval(0x1.3f5c28f5c28f5p+1,2.5))

    @test isequal_interval(parse(Interval{Float64}, "0.0??"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "0.0??u"), interval(0.0,Inf))

    @test isequal_interval(parse(Interval{Float64}, "0.0??d"), interval(-Inf,0.0))

    @test isequal_interval(parse(Interval{Float64}, "2.5??"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "2.5??u"), interval(2.5,Inf))

    @test isequal_interval(parse(Interval{Float64}, "2.5??d"), interval(-Inf,2.5))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5e+27"), interval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5ue4"), interval(0x1.86ap+14,0x1.8768p+14))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5de-5"), interval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16))

    @test isequal_interval(parse(Interval{Float64}, "10?3"), interval(7.0,13.0))

    @test isequal_interval(parse(Interval{Float64}, "10?3e380"), interval(0x1.fffffffffffffp+1023,Inf))

    @test isequal_interval(parse(Interval{Float64}, "1.0000000000000001?1"), interval(1.0,0x1.0000000000001p+0))

    @test isequal_interval(parse(Interval{Float64}, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"), interval(-Inf,Inf))

    @test isequal_interval(parse(Interval{Float64}, "[ Nai  ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ Nai  ]_ill"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ Nai  ]_trv"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ Empty  ]_ill"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[  ]_com"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[,]_com"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[   Entire ]_com"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ -inf ,  INF ]_com"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  , 1.0]_ill"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  , 1.0]_fooo"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  , 1.0]_da"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[-1.0,]_com"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[-Inf, 1.000 ]_ill"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[-I  nf, 1.000 ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[-Inf, 1.0  00 ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[-Inf ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[Inf , INF]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[ foo ]"), emptyinterval())

    @test isequal_interval(parse(Interval{Float64}, "[1.0000000000000002,1.0000000000000001]"), interval(1.0,0x1.0000000000001p+0))

    @test isequal_interval(parse(Interval{Float64}, "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]"), interval(1.0,0x1.0000000000001p+0))

    @test isequal_interval(parse(Interval{Float64}, "[0x1.00000000000002p0,0x1.00000000000001p0]"), interval(1.0,0x1.0000000000001p+0))

end

@testset "minimal_text_to_decorated_interval_test" begin

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ Empty  ]"), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ Empty  ]_trv"), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[  ]"), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[  ]_trv"), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[,]"), DecoratedInterval(entireinterval(), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[,]_trv"), DecoratedInterval(entireinterval(), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ entire  ]"), DecoratedInterval(entireinterval(), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ ENTIRE ]_dac"), DecoratedInterval(entireinterval(), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ -inf , INF  ]"), DecoratedInterval(entireinterval(), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ -inf, INF ]_def"), DecoratedInterval(entireinterval(), def))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[-1.0,1.0]"), DecoratedInterval(interval(-1.0,1.0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[  -1.0  ,  1.0  ]_com"), DecoratedInterval(interval(-1.0,1.0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[  -1.0  , 1.0]_trv"), DecoratedInterval(interval(-1.0,1.0), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[-1,]"), DecoratedInterval(interval(-1.0,Inf), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[-1.0, +inf]_def"), DecoratedInterval(interval(-1.0,Inf), def))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[-1.0, +infinity]_def"), DecoratedInterval(interval(-1.0,Inf), def))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[-Inf, 1.000 ]"), DecoratedInterval(interval(-Inf,1.0), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[-Infinity, 1.000 ]_trv"), DecoratedInterval(interval(-Inf,1.0), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[1.0E+400 ]_com"), DecoratedInterval(interval(0x1.fffffffffffffp+1023,Inf), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ -4/2, 10/5 ]_com"), DecoratedInterval(interval(-2.0,2.0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[ -1/10, 1/10 ]_com"), DecoratedInterval(interval(-0.1,0.1), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.0?"), DecoratedInterval(interval(-0.05,0.05), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.0?u_trv"), DecoratedInterval(interval(0.0,0.05), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.0?d_dac"), DecoratedInterval(interval(-0.05,0.0), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.5?"), DecoratedInterval(interval(0x1.3999999999999p+1,0x1.4666666666667p+1), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.5?u"), DecoratedInterval(interval(2.5,0x1.4666666666667p+1), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.5?d_trv"), DecoratedInterval(interval(0x1.3999999999999p+1,2.5), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.000?5"), DecoratedInterval(interval(-0.005,0.005), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.000?5u_def"), DecoratedInterval(interval(0.0,0.005), def))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.000?5d"), DecoratedInterval(interval(-0.005,0.0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.500?5"), DecoratedInterval(interval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.500?5u"), DecoratedInterval(interval(2.5,0x1.40a3d70a3d70bp+1), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.500?5d"), DecoratedInterval(interval(0x1.3f5c28f5c28f5p+1,2.5), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.0??_dac"), DecoratedInterval(interval(-Inf,Inf), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.0??u_trv"), DecoratedInterval(interval(0.0,Inf), trv))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "0.0??d"), DecoratedInterval(interval(-Inf,0.0), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.5??"), DecoratedInterval(interval(-Inf,Inf), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.5??u_def"), DecoratedInterval(interval(2.5,Inf), def))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.5??d_dac"), DecoratedInterval(interval(-Inf,2.5), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.500?5e+27"), DecoratedInterval(interval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.500?5ue4_def"), DecoratedInterval(interval(0x1.86ap+14,0x1.8768p+14), def))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "2.500?5de-5"), DecoratedInterval(interval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16), com))

    @test isnai(parse(DecoratedInterval{Float64}, "[ Nai  ]"))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_com"), DecoratedInterval(interval(-Inf,Inf), dac))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "10?3_com"), DecoratedInterval(interval(7.0,13.0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "10?3e380_com"), DecoratedInterval(interval(0x1.fffffffffffffp+1023,Inf), dac))

    @test isnai(parse(DecoratedInterval{Float64}, "[ Nai  ]_ill"))

    @test isnai(parse(DecoratedInterval{Float64}, "[ Nai  ]_trv"))

    @test isnai(parse(DecoratedInterval{Float64}, "[ Empty  ]_ill"))

    @test isnai(parse(DecoratedInterval{Float64}, "[  ]_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "[,]_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "[   Entire ]_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "[ -inf ,  INF ]_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "[  -1.0  , 1.0]_ill"))

    @test isnai(parse(DecoratedInterval{Float64}, "[  -1.0  , 1.0]_fooo"))

    @test isnai(parse(DecoratedInterval{Float64}, "[  -1.0  , 1.0]_da"))

    @test isnai(parse(DecoratedInterval{Float64}, "[-1.0,]_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "[-Inf, 1.000 ]_ill"))

    @test isnai(parse(DecoratedInterval{Float64}, "[-I  nf, 1.000 ]"))

    @test isnai(parse(DecoratedInterval{Float64}, "[-Inf, 1.0  00 ]"))

    @test isnai(parse(DecoratedInterval{Float64}, "[-Inf ]"))

    @test isnai(parse(DecoratedInterval{Float64}, "[Inf , INF]"))

    @test isnai(parse(DecoratedInterval{Float64}, "[ foo ]"))

    @test isnai(parse(DecoratedInterval{Float64}, "0.0??_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "0.0??u_ill"))

    @test isnai(parse(DecoratedInterval{Float64}, "0.0??d_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "0.0??_com"))

    @test isnai(parse(DecoratedInterval{Float64}, "[1.0,2.0"))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[1.0000000000000002,1.0000000000000001]"), DecoratedInterval(interval(1.0,0x1.0000000000001p+0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]"), DecoratedInterval(interval(1.0,0x1.0000000000001p+0), com))

    @test isequal_interval(parse(DecoratedInterval{Float64}, "[0x1.00000000000002p0,0x1.00000000000001p0]"), DecoratedInterval(interval(1.0,0x1.0000000000001p+0), com))

end

@testset "minimal_interval_part_test" begin

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv)), interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)), interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac)), interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def)), interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv)), interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)), interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022))

    @test isequal_interval(interval(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), trv)), interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), trv)), interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023))

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)), interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023))

    @test isequal_interval(interval(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv)), interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023))

    @test isequal_interval(interval(DecoratedInterval(interval(-Inf,Inf), trv)), interval(-Inf,Inf))

    @test isequal_interval(interval(DecoratedInterval(emptyinterval(), trv)), emptyinterval())

    @test isequal_interval(interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com)), interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4))

    @test_broken isequal_interval(interval(nai()), emptyinterval())

end

@testset "minimal_new_dec_test" begin

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)), DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)), DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)), DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)), DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), com))

    @test isequal_interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)), DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), com))

    @test isequal_interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)), DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), com))

    @test isequal_interval(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)), DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)), DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)), DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com))

    @test isequal_interval(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)), DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), com))

    @test isequal_interval(DecoratedInterval(interval(-Inf,Inf)), DecoratedInterval(interval(-Inf,Inf), dac))

    @test isequal_interval(DecoratedInterval(emptyinterval()), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)), DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

end

@testset "minimal_set_dec_test" begin

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv), DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), trv))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com), DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac), DecoratedInterval(interval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), dac))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def), DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), def))

    @test isequal_interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv), DecoratedInterval(interval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), trv))

    @test isequal_interval(DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def), DecoratedInterval(interval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), def))

    @test isequal_interval(DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac), DecoratedInterval(interval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), dac))

    @test isequal_interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com), DecoratedInterval(interval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), com))

    @test isequal_interval(DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def), DecoratedInterval(interval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), def))

    @test isequal_interval(DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv), DecoratedInterval(interval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), trv))

    @test isequal_interval(DecoratedInterval(interval(-Inf,Inf), dac), DecoratedInterval(interval(-Inf,Inf), dac))

    @test isequal_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com), DecoratedInterval(interval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), com))

    @test isequal_interval(DecoratedInterval(emptyinterval(), def), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(DecoratedInterval(emptyinterval(), dac), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(DecoratedInterval(emptyinterval(), com), DecoratedInterval(emptyinterval(), trv))

    @test isequal_interval(DecoratedInterval(interval(1.0,Inf), com), DecoratedInterval(interval(1.0,Inf), dac))

    @test isequal_interval(DecoratedInterval(interval(-Inf,3.0), com), DecoratedInterval(interval(-Inf,3.0), dac))

    @test isequal_interval(DecoratedInterval(interval(-Inf,Inf), com), DecoratedInterval(interval(-Inf,Inf), dac))

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
