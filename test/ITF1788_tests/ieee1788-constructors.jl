@testset "IEEE1788.a" begin

    @test bareinterval(-Inf,Inf) === entireinterval(BareInterval{Float64})

end

@testset "IEEE1788.b" begin

    @test parse(BareInterval{Float64}, "[1.2345]") === bareinterval(0x1.3C083126E978DP+0, 0x1.3C083126E978EP+0)

    @test parse(BareInterval{Float64}, "[1,+infinity]") === bareinterval(1.0, Inf)

    @test parse(Interval{Float64}, "[1,1e3]_com") === interval(bareinterval(1.0, 1000.0), com)

    @test parse(Interval{Float64}, "[1,1E3]_COM") === interval(bareinterval(1.0, 1000.0), com)

end

@testset "IEEE1788.c" begin

    @test parse(BareInterval{Float64}, "[1.e-3, 1.1e-3]") === bareinterval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12)

    @test parse(BareInterval{Float64}, "[-0x1.3p-1, 2/3]") === bareinterval(-0x9.8000000000000P-4, +0xA.AAAAAAAAAAAB0P-4)

    @test parse(BareInterval{Float64}, "[3.56]") === bareinterval(0x3.8F5C28F5C28F4P+0, 0x3.8F5C28F5C28F6P+0)

    @test parse(BareInterval{Float64}, "3.56?1") === bareinterval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0)

    @test parse(BareInterval{Float64}, "3.56?1e2") === bareinterval(355.0, 357.0)

    @test parse(BareInterval{Float64}, "3.560?2") === bareinterval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0)

    @test parse(BareInterval{Float64}, "3.56?") === bareinterval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0)

    @test parse(BareInterval{Float64}, "3.560?2u") === bareinterval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0)

    @test parse(BareInterval{Float64}, "-10?") === bareinterval(-10.5, -9.5)

    @test parse(BareInterval{Float64}, "-10?u") === bareinterval(-10.0, -9.5)

    @test parse(BareInterval{Float64}, "-10?12") === bareinterval(-22.0, 2.0)

end

@testset "IEEE1788.d" begin

    @test parse(BareInterval{Float64}, "[1.234e5,Inf]") === bareinterval(123400.0, Inf)

    @test parse(BareInterval{Float64}, "3.1416?1") === bareinterval(0x3.24395810624DCP+0, 0x3.24467381D7DC0P+0)

    @test parse(BareInterval{Float64}, "[Empty]") === emptyinterval(BareInterval{Float64})

end

@testset "IEEE1788.e" begin

    @test_logs (:warn,) @test interval(2,1) === nai(Interval{Float64})

end

@testset "IEEE1788.e" begin

    @test parse(Interval{Float64}, "[ ]") === interval(emptyinterval(BareInterval{Float64}), trv)

    @test parse(Interval{Float64}, "[entire]") === interval(bareinterval(-Inf, +Inf), dac)

    @test parse(Interval{Float64}, "[1.e-3, 1.1e-3]") === interval(bareinterval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12), com)

    @test parse(Interval{Float64}, "[-Inf, 2/3]") === interval(bareinterval(-Inf, +0xA.AAAAAAAAAAAB0P-4), dac)

    @test parse(Interval{Float64}, "[0x1.3p-1,]") === interval(bareinterval(0x1.3p-1, Inf), dac)

    @test parse(Interval{Float64}, "[,]") === interval(entireinterval(BareInterval{Float64}), dac)

    @test parse(Interval{Float64}, "3.56?1") === interval(bareinterval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), com)

    @test parse(Interval{Float64}, "3.56?1e2") === interval(bareinterval(355.0, 357.0), com)

    @test parse(Interval{Float64}, "3.560?2") === interval(bareinterval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0), com)

    @test parse(Interval{Float64}, "3.56?") === interval(bareinterval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0), com)

    @test parse(Interval{Float64}, "3.560?2u") === interval(bareinterval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0), com)

    @test parse(Interval{Float64}, "-10?") === interval(bareinterval(-10.5, -9.5), com)

    @test parse(Interval{Float64}, "-10?u") === interval(bareinterval(-10.0, -9.5), com)

    @test parse(Interval{Float64}, "-10?12") === interval(bareinterval(-22.0, 2.0), com)

    @test parse(Interval{Float64}, "-10??u") === interval(bareinterval(-10.0, Inf), dac)

    @test parse(Interval{Float64}, "-10??") === interval(bareinterval(-Inf, Inf), dac)

    @test parse(Interval{Float64}, "[nai]") === nai(Interval{Float64})

    @test parse(Interval{Float64}, "3.56?1_def") === interval(bareinterval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), def)

end

@testset "IEEE1788.f" begin

    @test parse(BareInterval{Float64}, "[]") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[empty]") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[ empty ]") === emptyinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[,]") === entireinterval(BareInterval{Float64})

    @test parse(BareInterval{Float64}, "[ entire ]") === entireinterval(BareInterval{Float64})

end
