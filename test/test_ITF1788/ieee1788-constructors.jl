@testset "IEEE1788.a" begin

    @test isequal_interval(bareinterval(-Inf, Inf), entireinterval(BareInterval{Float64}))

end

@testset "IEEE1788.b" begin

    @test isequal_interval(parse(BareInterval{Float64}, "[1.2345]"), bareinterval(0x1.3C083126E978DP+0, 0x1.3C083126E978EP+0))

    @test isequal_interval(parse(BareInterval{Float64}, "[1,+infinity]"), bareinterval(1.0, Inf))

    @test isequal_interval(parse(Interval{Float64}, "[1,1e3]_com"), Interval(bareinterval(1.0, 1000.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[1,1E3]_COM"), Interval(bareinterval(1.0, 1000.0), IntervalArithmetic.com))

end

@testset "IEEE1788.c" begin

    @test isequal_interval(parse(BareInterval{Float64}, "[1.e-3, 1.1e-3]"), bareinterval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12))

    @test isequal_interval(parse(BareInterval{Float64}, "[-0x1.3p-1, 2/3]"), bareinterval(-0x9.8000000000000P-4, +0xA.AAAAAAAAAAAB0P-4))

    @test isequal_interval(parse(BareInterval{Float64}, "[3.56]"), bareinterval(0x3.8F5C28F5C28F4P+0, 0x3.8F5C28F5C28F6P+0))

    @test isequal_interval(parse(BareInterval{Float64}, "3.56?1"), bareinterval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0))

    @test isequal_interval(parse(BareInterval{Float64}, "3.56?1e2"), bareinterval(355.0, 357.0))

    @test isequal_interval(parse(BareInterval{Float64}, "3.560?2"), bareinterval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0))

    @test isequal_interval(parse(BareInterval{Float64}, "3.56?"), bareinterval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0))

    @test isequal_interval(parse(BareInterval{Float64}, "3.560?2u"), bareinterval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0))

    @test isequal_interval(parse(BareInterval{Float64}, "-10?"), bareinterval(-10.5, -9.5))

    @test isequal_interval(parse(BareInterval{Float64}, "-10?u"), bareinterval(-10.0, -9.5))

    @test isequal_interval(parse(BareInterval{Float64}, "-10?12"), bareinterval(-22.0, 2.0))

end

@testset "IEEE1788.d" begin

    @test isequal_interval(parse(BareInterval{Float64}, "[1.234e5,Inf]"), bareinterval(123400.0, Inf))

    @test isequal_interval(parse(BareInterval{Float64}, "3.1416?1"), bareinterval(0x3.24395810624DCP+0, 0x3.24467381D7DC0P+0))

    @test isequal_interval(parse(BareInterval{Float64}, "[Empty]"), emptyinterval(BareInterval{Float64}))

end

@testset "IEEE1788.e" begin

    @test isnai(interval(2,1))

end

@testset "IEEE1788.e" begin

    @test isequal_interval(parse(Interval{Float64}, "[ ]"), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(parse(Interval{Float64}, "[entire]"), Interval(bareinterval(-Inf, +Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[1.e-3, 1.1e-3]"), Interval(bareinterval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "[-Inf, 2/3]"), Interval(bareinterval(-Inf, +0xA.AAAAAAAAAAAB0P-4), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[0x1.3p-1,]"), Interval(bareinterval(0x1.3p-1, Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "[,]"), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "3.56?1"), Interval(bareinterval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "3.56?1e2"), Interval(bareinterval(355.0, 357.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "3.560?2"), Interval(bareinterval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "3.56?"), Interval(bareinterval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "3.560?2u"), Interval(bareinterval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "-10?"), Interval(bareinterval(-10.5, -9.5), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "-10?u"), Interval(bareinterval(-10.0, -9.5), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "-10?12"), Interval(bareinterval(-22.0, 2.0), IntervalArithmetic.com))

    @test isequal_interval(parse(Interval{Float64}, "-10??u"), Interval(bareinterval(-10.0, Inf), IntervalArithmetic.dac))

    @test isequal_interval(parse(Interval{Float64}, "-10??"), Interval(bareinterval(-Inf, Inf), IntervalArithmetic.dac))

    @test isnai(parse(Interval{Float64}, "[nai]"))

    @test isequal_interval(parse(Interval{Float64}, "3.56?1_def"), Interval(bareinterval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), IntervalArithmetic.def))

end

@testset "IEEE1788.f" begin

    @test isequal_interval(parse(BareInterval{Float64}, "[]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[empty]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ empty ]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[,]"), entireinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[ entire ]"), entireinterval(BareInterval{Float64}))

end
