@testset "IEEE1788.a" begin

    @test interval(-Inf, Inf) ≛ entireinterval()

end

@testset "IEEE1788.b" begin

    @test parse(Interval{Float64}, "[1.2345]") ≛ interval(0x1.3C083126E978DP+0, 0x1.3C083126E978EP+0)

    @test parse(Interval{Float64}, "[1,+infinity]") ≛ interval(1.0, Inf)

    @test parse(DecoratedInterval{Float64}, "[1,1e3]_com") ≛ DecoratedInterval(interval(1.0, 1000.0), com)

    @test parse(DecoratedInterval{Float64}, "[1,1E3]_COM") ≛ DecoratedInterval(interval(1.0, 1000.0), com)

end

@testset "IEEE1788.c" begin

    @test parse(Interval{Float64}, "[1.e-3, 1.1e-3]") ≛ interval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12)

    @test parse(Interval{Float64}, "[-0x1.3p-1, 2/3]") ≛ interval(-0x9.8000000000000P-4, +0xA.AAAAAAAAAAAB0P-4)

    @test parse(Interval{Float64}, "[3.56]") ≛ interval(0x3.8F5C28F5C28F4P+0, 0x3.8F5C28F5C28F6P+0)

    @test parse(Interval{Float64}, "3.56?1") ≛ interval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0)

    @test parse(Interval{Float64}, "3.56?1e2") ≛ interval(355.0, 357.0)

    @test parse(Interval{Float64}, "3.560?2") ≛ interval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0)

    @test parse(Interval{Float64}, "3.56?") ≛ interval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0)

    @test parse(Interval{Float64}, "3.560?2u") ≛ interval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0)

    @test parse(Interval{Float64}, "-10?") ≛ interval(-10.5, -9.5)

    @test parse(Interval{Float64}, "-10?u") ≛ interval(-10.0, -9.5)

    @test parse(Interval{Float64}, "-10?12") ≛ interval(-22.0, 2.0)

end

@testset "IEEE1788.d" begin

    @test parse(Interval{Float64}, "[1.234e5,Inf]") ≛ interval(123400.0, Inf)

    @test parse(Interval{Float64}, "3.1416?1") ≛ interval(0x3.24395810624DCP+0, 0x3.24467381D7DC0P+0)

    @test parse(Interval{Float64}, "[Empty]") ≛ emptyinterval()

end

@testset "IEEE1788.e" begin

    @test isnai(DecoratedInterval(2,1))

end

@testset "IEEE1788.e" begin

    @test parse(DecoratedInterval{Float64}, "[ ]") ≛ DecoratedInterval(emptyinterval(), trv)

    @test parse(DecoratedInterval{Float64}, "[entire]") ≛ DecoratedInterval(interval(-Inf, +Inf), dac)

    @test parse(DecoratedInterval{Float64}, "[1.e-3, 1.1e-3]") ≛ DecoratedInterval(interval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12), com)

    @test parse(DecoratedInterval{Float64}, "[-Inf, 2/3]") ≛ DecoratedInterval(interval(-Inf, +0xA.AAAAAAAAAAAB0P-4), dac)

    @test parse(DecoratedInterval{Float64}, "[0x1.3p-1,]") ≛ DecoratedInterval(interval(0x1.3p-1, Inf), dac)

    @test parse(DecoratedInterval{Float64}, "[,]") ≛ DecoratedInterval(entireinterval(), dac)

    @test parse(DecoratedInterval{Float64}, "3.56?1") ≛ DecoratedInterval(interval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), com)

    @test parse(DecoratedInterval{Float64}, "3.56?1e2") ≛ DecoratedInterval(interval(355.0, 357.0), com)

    @test parse(DecoratedInterval{Float64}, "3.560?2") ≛ DecoratedInterval(interval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0), com)

    @test parse(DecoratedInterval{Float64}, "3.56?") ≛ DecoratedInterval(interval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0), com)

    @test parse(DecoratedInterval{Float64}, "3.560?2u") ≛ DecoratedInterval(interval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0), com)

    @test parse(DecoratedInterval{Float64}, "-10?") ≛ DecoratedInterval(interval(-10.5, -9.5), com)

    @test parse(DecoratedInterval{Float64}, "-10?u") ≛ DecoratedInterval(interval(-10.0, -9.5), com)

    @test parse(DecoratedInterval{Float64}, "-10?12") ≛ DecoratedInterval(interval(-22.0, 2.0), com)

    @test parse(DecoratedInterval{Float64}, "-10??u") ≛ DecoratedInterval(interval(-10.0, Inf), dac)

    @test parse(DecoratedInterval{Float64}, "-10??") ≛ DecoratedInterval(interval(-Inf, Inf), dac)

    @test isnai(parse(DecoratedInterval{Float64}, "[nai]"))

    @test parse(DecoratedInterval{Float64}, "3.56?1_def") ≛ DecoratedInterval(interval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), def)

end

@testset "IEEE1788.f" begin

    @test parse(Interval{Float64}, "[]") ≛ emptyinterval()

    @test parse(Interval{Float64}, "[empty]") ≛ emptyinterval()

    @test parse(Interval{Float64}, "[ empty ]") ≛ emptyinterval()

    @test parse(Interval{Float64}, "[,]") ≛ entireinterval()

    @test parse(Interval{Float64}, "[ entire ]") ≛ entireinterval()

end
