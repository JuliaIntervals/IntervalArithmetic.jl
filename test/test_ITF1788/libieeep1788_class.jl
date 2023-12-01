@testset "minimal_nums_to_interval_test" begin

    @test isequal_interval(bareinterval(-1.0,1.0), bareinterval(-1.0,1.0))

    @test isequal_interval(bareinterval(-Inf,1.0), bareinterval(-Inf,1.0))

    @test isequal_interval(bareinterval(-1.0,Inf), bareinterval(-1.0,Inf))

    @test isequal_interval(bareinterval(-Inf,Inf), bareinterval(-Inf,Inf))

    @test isequal_interval(bareinterval(NaN,NaN), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(bareinterval(1.0,-1.0), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(bareinterval(-Inf,-Inf), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(bareinterval(Inf,Inf), emptyinterval(BareInterval{Float64}))

end

@testset "minimal_nums_to_decorated_interval_test" begin

    @test isequal_interval(interval(-1.0,1.0), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.com))

    @test isequal_interval(interval(-Inf,1.0), Interval(bareinterval(-Inf,1.0), IntervalArithmetic.dac))

    @test isequal_interval(interval(-1.0,Inf), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(interval(-Inf,Inf), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isnai(interval(NaN,NaN))

    @test isnai(interval(1.0,-1.0))

    @test isnai(interval(-Inf,-Inf))

    @test isnai(interval(Inf,Inf))

end

@testset "minimal_text_to_interval_test" begin

    @test isequal_interval(parse(BareInterval{Float64}, "[ Empty  ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ Empty  ]_trv"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[  ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[  ]_trv"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[,]"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[,]_trv"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ entire  ]"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[ ENTIRE ]_dac"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ ENTIRE ]"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[ -inf , INF  ]"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[ -inf, INF ]_def"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[-1.0,1.0]"), bareinterval(-1.0,1.0))

    @test isequal_interval(parse(BareInterval{Float64}, "[  -1.0  ,  1.0  ]"), bareinterval(-1.0,1.0))

    @test isequal_interval(parse(BareInterval{Float64}, "[  -1.0  , 1.0]"), bareinterval(-1.0,1.0))

    @test isequal_interval(parse(BareInterval{Float64}, "[-1,]"), bareinterval(-1.0,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[-1.0, +inf]"), bareinterval(-1.0,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[-1.0, +infinity]"), bareinterval(-1.0,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[-Inf, 1.000 ]"), bareinterval(-Inf,1.0))

    @test isequal_interval(parse(BareInterval{Float64}, "[-Infinity, 1.000 ]"), bareinterval(-Inf,1.0))

    @test isequal_interval(parse(BareInterval{Float64}, "[1.0E+400 ]"), bareinterval(0x1.fffffffffffffp+1023,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[ -4/2, 10/5 ]"), bareinterval(-2.0,2.0))

    @test isequal_interval(parse(BareInterval{Float64}, "[ -1/10, 1/10 ]"), bareinterval(-0.1,0.1))

    @test isequal_interval(parse(BareInterval{Float64}, "0.0?"), bareinterval(-0.05,0.05))

    @test isequal_interval(parse(BareInterval{Float64}, "0.0?u"), bareinterval(0.0,0.05))

    @test isequal_interval(parse(BareInterval{Float64}, "0.0?d"), bareinterval(-0.05,0.0))

    @test isequal_interval(parse(BareInterval{Float64}, "2.5?"), bareinterval(0x1.3999999999999p+1,0x1.4666666666667p+1))

    @test isequal_interval(parse(BareInterval{Float64}, "2.5?u"), bareinterval(2.5,0x1.4666666666667p+1))

    @test isequal_interval(parse(BareInterval{Float64}, "2.5?d"), bareinterval(0x1.3999999999999p+1,2.5))

    @test isequal_interval(parse(BareInterval{Float64}, "0.000?5"), bareinterval(-0.005,0.005))

    @test isequal_interval(parse(BareInterval{Float64}, "0.000?5u"), bareinterval(0.0,0.005))

    @test isequal_interval(parse(BareInterval{Float64}, "0.000?5d"), bareinterval(-0.005,0.0))

    @test isequal_interval(parse(BareInterval{Float64}, "2.500?5"), bareinterval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1))

    @test isequal_interval(parse(BareInterval{Float64}, "2.500?5u"), bareinterval(2.5,0x1.40a3d70a3d70bp+1))

    @test isequal_interval(parse(BareInterval{Float64}, "2.500?5d"), bareinterval(0x1.3f5c28f5c28f5p+1,2.5))

    @test isequal_interval(parse(BareInterval{Float64}, "0.0??"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "0.0??u"), bareinterval(0.0,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "0.0??d"), bareinterval(-Inf,0.0))

    @test isequal_interval(parse(BareInterval{Float64}, "2.5??"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "2.5??u"), bareinterval(2.5,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "2.5??d"), bareinterval(-Inf,2.5))

    @test isequal_interval(parse(BareInterval{Float64}, "2.500?5e+27"), bareinterval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91))

    @test isequal_interval(parse(BareInterval{Float64}, "2.500?5ue4"), bareinterval(0x1.86ap+14,0x1.8768p+14))

    @test isequal_interval(parse(BareInterval{Float64}, "2.500?5de-5"), bareinterval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16))

    @test isequal_interval(parse(BareInterval{Float64}, "10?3"), bareinterval(7.0,13.0))

    @test isequal_interval(parse(BareInterval{Float64}, "10?3e380"), bareinterval(0x1.fffffffffffffp+1023,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "1.0000000000000001?1"), bareinterval(1.0,0x1.0000000000001p+0))

    @test isequal_interval(parse(BareInterval{Float64}, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"), bareinterval(-Inf,Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "[ Nai  ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ Nai  ]_ill"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ Nai  ]_trv"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ Empty  ]_ill"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[  ]_com"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[,]_com"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[   Entire ]_com"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ -inf ,  INF ]_com"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[  -1.0  , 1.0]_ill"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[  -1.0  , 1.0]_fooo"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[  -1.0  , 1.0]_da"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[-1.0,]_com"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[-Inf, 1.000 ]_ill"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[-I  nf, 1.000 ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[-Inf, 1.0  00 ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[-Inf ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[Inf , INF]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ foo ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[1.0000000000000002,1.0000000000000001]"), bareinterval(1.0,0x1.0000000000001p+0))

    @test isequal_interval(parse(BareInterval{Float64}, "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]"), bareinterval(1.0,0x1.0000000000001p+0))

    @test isequal_interval(parse(BareInterval{Float64}, "[0x1.00000000000002p0,0x1.00000000000001p0]"), bareinterval(1.0,0x1.0000000000001p+0))

end

@testset "minimal_text_to_decorated_interval_test" begin

    @test isequal_interval(parse(Interval{Float64}, "[ Empty  ]"), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[ Empty  ]_trv"), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[  ]"), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[  ]_trv"), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[,]"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[,]_trv"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[ entire  ]"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[ ENTIRE ]_dac"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[ -inf , INF  ]"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[ -inf, INF ]_def"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def))

    @test isequal_interval(parse(Interval{Float64}, "[-1.0,1.0]"), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  ,  1.0  ]_com"), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[  -1.0  , 1.0]_trv"), Interval(bareinterval(-1.0,1.0), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[-1,]"), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[-1.0, +inf]_def"), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(parse(Interval{Float64}, "[-1.0, +infinity]_def"), Interval(bareinterval(-1.0,Inf), IntervalArithmetic.def))

    @test isequal_interval(parse(Interval{Float64}, "[-Inf, 1.000 ]"), Interval(bareinterval(-Inf,1.0), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[-Infinity, 1.000 ]_trv"), Interval(bareinterval(-Inf,1.0), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[1.0E+400 ]_com"), Interval(bareinterval(0x1.fffffffffffffp+1023,Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[ -4/2, 10/5 ]_com"), Interval(bareinterval(-2.0,2.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[ -1/10, 1/10 ]_com"), Interval(bareinterval(-0.1,0.1), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "0.0?"), Interval(bareinterval(-0.05,0.05), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "0.0?u_trv"), Interval(bareinterval(0.0,0.05), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "0.0?d_dac"), Interval(bareinterval(-0.05,0.0), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "2.5?"), Interval(bareinterval(0x1.3999999999999p+1,0x1.4666666666667p+1), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "2.5?u"), Interval(bareinterval(2.5,0x1.4666666666667p+1), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "2.5?d_trv"), Interval(bareinterval(0x1.3999999999999p+1,2.5), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "0.000?5"), Interval(bareinterval(-0.005,0.005), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "0.000?5u_def"), Interval(bareinterval(0.0,0.005), IntervalArithmetic.def))

    @test isequal_interval(parse(Interval{Float64}, "0.000?5d"), Interval(bareinterval(-0.005,0.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5"), Interval(bareinterval(0x1.3f5c28f5c28f5p+1,0x1.40a3d70a3d70bp+1), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5u"), Interval(bareinterval(2.5,0x1.40a3d70a3d70bp+1), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5d"), Interval(bareinterval(0x1.3f5c28f5c28f5p+1,2.5), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "0.0??_dac"), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "0.0??u_trv"), Interval(bareinterval(0.0,Inf), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "0.0??d"), Interval(bareinterval(-Inf,0.0), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "2.5??"), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "2.5??u_def"), Interval(bareinterval(2.5,Inf), IntervalArithmetic.def))

    @test isequal_interval(parse(Interval{Float64}, "2.5??d_dac"), Interval(bareinterval(-Inf,2.5), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5e+27"), Interval(bareinterval(0x1.01fa19a08fe7fp+91,0x1.0302cc4352683p+91), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5ue4_def"), Interval(bareinterval(0x1.86ap+14,0x1.8768p+14), IntervalArithmetic.def))

    @test isequal_interval(parse(Interval{Float64}, "2.500?5de-5"), Interval(bareinterval(0x1.a2976f1cee4d5p-16,0x1.a36e2eb1c432dp-16), IntervalArithmetic.com))

    @test isnai(parse(Interval{Float64}, "[ Nai  ]"))

    @test isequal_interval(parse(Interval{Float64}, "10?1800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_com"), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "10?3_com"), Interval(bareinterval(7.0,13.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "10?3e380_com"), Interval(bareinterval(0x1.fffffffffffffp+1023,Inf), IntervalArithmetic.dac))

    @test isnai(parse(Interval{Float64}, "[ Nai  ]_ill"))

    @test isnai(parse(Interval{Float64}, "[ Nai  ]_trv"))

    @test isnai(parse(Interval{Float64}, "[ Empty  ]_ill"))

    @test isnai(parse(Interval{Float64}, "[  ]_com"))

    @test isnai(parse(Interval{Float64}, "[,]_com"))

    @test isnai(parse(Interval{Float64}, "[   Entire ]_com"))

    @test isnai(parse(Interval{Float64}, "[ -inf ,  INF ]_com"))

    @test isnai(parse(Interval{Float64}, "[  -1.0  , 1.0]_ill"))

    @test isnai(parse(Interval{Float64}, "[  -1.0  , 1.0]_fooo"))

    @test isnai(parse(Interval{Float64}, "[  -1.0  , 1.0]_da"))

    @test isnai(parse(Interval{Float64}, "[-1.0,]_com"))

    @test isnai(parse(Interval{Float64}, "[-Inf, 1.000 ]_ill"))

    @test isnai(parse(Interval{Float64}, "[-I  nf, 1.000 ]"))

    @test isnai(parse(Interval{Float64}, "[-Inf, 1.0  00 ]"))

    @test isnai(parse(Interval{Float64}, "[-Inf ]"))

    @test isnai(parse(Interval{Float64}, "[Inf , INF]"))

    @test isnai(parse(Interval{Float64}, "[ foo ]"))

    @test isnai(parse(Interval{Float64}, "0.0??_com"))

    @test isnai(parse(Interval{Float64}, "0.0??u_ill"))

    @test isnai(parse(Interval{Float64}, "0.0??d_com"))

    @test isnai(parse(Interval{Float64}, "0.0??_com"))

    @test isnai(parse(Interval{Float64}, "[1.0,2.0"))

    @test isequal_interval(parse(Interval{Float64}, "[1.0000000000000002,1.0000000000000001]"), Interval(bareinterval(1.0,0x1.0000000000001p+0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]"), Interval(bareinterval(1.0,0x1.0000000000001p+0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[0x1.00000000000002p0,0x1.00000000000001p0]"), Interval(bareinterval(1.0,0x1.0000000000001p+0), IntervalArithmetic.com))

end

@testset "minimal_interval_part_test" begin

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), IntervalArithmetic.trv)), bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com)), bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), IntervalArithmetic.dac)), bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), IntervalArithmetic.def)), bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), IntervalArithmetic.trv)), bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.trv)), bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022))

    @test isequal_interval(bareinterval(Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.trv)), bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), IntervalArithmetic.trv)), bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.trv)), bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023))

    @test isequal_interval(bareinterval(Interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.trv)), bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023))

    @test isequal_interval(bareinterval(Interval(bareinterval(-Inf,Inf), IntervalArithmetic.trv)), bareinterval(-Inf,Inf))

    @test isequal_interval(bareinterval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(bareinterval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com)), bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4))

    @test isequal_interval(bareinterval(nai()), emptyinterval(BareInterval{Float64}))

end

@testset "minimal_new_dec_test" begin

    @test isequal_interval(Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4)), Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)), Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4)), Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4)), Interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022)), Interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022)), Interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022)), Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023)), Interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)), Interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023)), Interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-Inf,Inf)), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64})), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4)), Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com))

end

@testset "minimal_set_dec_test" begin

    @test isequal_interval(Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), IntervalArithmetic.trv), Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.9999999999999P-4), IntervalArithmetic.trv))

    @test isequal_interval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com), Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), IntervalArithmetic.dac), Interval(bareinterval(-0x1.99999A842549Ap+4,0x1.99999A0000000p-4), IntervalArithmetic.dac))

    @test isequal_interval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), IntervalArithmetic.def), Interval(bareinterval(-0x1.99999C0000000p+4,0x1.99999A0000000p-4), IntervalArithmetic.def))

    @test isequal_interval(Interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), IntervalArithmetic.trv), Interval(bareinterval(-0x0.0000000000001p-1022,-0x0.0000000000001p-1022), IntervalArithmetic.trv))

    @test isequal_interval(Interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.def), Interval(bareinterval(-0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.def))

    @test isequal_interval(Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.dac), Interval(bareinterval(0x0.0000000000001p-1022,0x0.0000000000001p-1022), IntervalArithmetic.dac))

    @test isequal_interval(Interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), IntervalArithmetic.com), Interval(bareinterval(-0x1.fffffffffffffp+1023,-0x1.fffffffffffffp+1023), IntervalArithmetic.com))

    @test isequal_interval(Interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.def), Interval(bareinterval(-0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.def))

    @test isequal_interval(Interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.trv), Interval(bareinterval(0x1.fffffffffffffp+1023,0x1.fffffffffffffp+1023), IntervalArithmetic.trv))

    @test isequal_interval(Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com), Interval(bareinterval(-0x1.99999C0000000p+4,0x1.9999999999999P-4), IntervalArithmetic.com))

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(Interval(bareinterval(1.0,Inf), IntervalArithmetic.com), Interval(bareinterval(1.0,Inf), IntervalArithmetic.dac))

    @test isequal_interval(Interval(bareinterval(-Inf,3.0), IntervalArithmetic.com), Interval(bareinterval(-Inf,3.0), IntervalArithmetic.dac))

    @test isequal_interval(Interval(bareinterval(-Inf,Inf), IntervalArithmetic.com), Interval(bareinterval(-Inf,Inf), IntervalArithmetic.dac))

    @test isnai(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.ill))

    @test isnai(Interval(bareinterval(-Inf,3.0), IntervalArithmetic.ill))

    @test isnai(Interval(bareinterval(-1.0,3.0), IntervalArithmetic.ill))

end

@testset "minimal_decoration_part_test" begin

    @test decoration(nai()) == IntervalArithmetic.ill

    @test decoration(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == IntervalArithmetic.trv

    @test decoration(Interval(bareinterval(-1.0,3.0), IntervalArithmetic.trv)) == IntervalArithmetic.trv

    @test decoration(Interval(bareinterval(-1.0,3.0), IntervalArithmetic.def)) == IntervalArithmetic.def

    @test decoration(Interval(bareinterval(-1.0,3.0), IntervalArithmetic.dac)) == IntervalArithmetic.dac

    @test decoration(Interval(bareinterval(-1.0,3.0), IntervalArithmetic.com)) == IntervalArithmetic.com

end
