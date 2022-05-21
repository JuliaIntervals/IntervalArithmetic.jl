@testset "IEEE1788.a" begin

    @test interval(-Inf,Inf) === entireinterval()

end

@testset "IEEE1788.b" begin

    @test @interval("[1.2345]") === Interval(0x1.3C083126E978DP+0, 0x1.3C083126E978EP+0)

    @test @interval("[1,+infinity]") === Interval(1.0, Inf)

    @test @decorated("[1,1e3]_com") === DecoratedInterval(Interval(1.0, 1000.0), com)

    @test @decorated("[1,1E3]_COM") === DecoratedInterval(Interval(1.0, 1000.0), com)

end

@testset "IEEE1788.c" begin

    @test @interval("[1.e-3, 1.1e-3]") === Interval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12)

    @test @interval("[-0x1.3p-1, 2/3]") === Interval(-0x9.8000000000000P-4, +0xA.AAAAAAAAAAAB0P-4)

    @test @interval("[3.56]") === Interval(0x3.8F5C28F5C28F4P+0, 0x3.8F5C28F5C28F6P+0)

    @test @interval("3.56?1") === Interval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0)

    @test @interval("3.56?1e2") === Interval(355.0, 357.0)

    @test @interval("3.560?2") === Interval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0)

    @test @interval("3.56?") === Interval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0)

    @test @interval("3.560?2u") === Interval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0)

    @test @interval("-10?") === Interval(-10.5, -9.5)

    @test @interval("-10?u") === Interval(-10.0, -9.5)

    @test @interval("-10?12") === Interval(-22.0, 2.0)

end

@testset "IEEE1788.d" begin

    @test @interval("[1.234e5,Inf]") === Interval(123400.0, Inf)

    @test @interval("3.1416?1") === Interval(0x3.24395810624DCP+0, 0x3.24467381D7DC0P+0)

    @test @interval("[Empty]") === emptyinterval()

end

@testset "IEEE1788.e" begin

    @test isnai(DecoratedInterval(2,1))

end

@testset "IEEE1788.e" begin

    @test @decorated("[ ]") === DecoratedInterval(emptyinterval(), trv)

    @test @decorated("[entire]") === DecoratedInterval(Interval(-Inf, +Inf), dac)

    @test @decorated("[1.e-3, 1.1e-3]") === DecoratedInterval(Interval(0x4.189374BC6A7ECP-12, 0x4.816F0068DB8BCP-12), com)

    @test @decorated("[-Inf, 2/3]") === DecoratedInterval(Interval(-Inf, +0xA.AAAAAAAAAAAB0P-4), dac)

    @test @decorated("[0x1.3p-1,]") === DecoratedInterval(Interval(0x1.3p-1, Inf), dac)

    @test @decorated("[,]") === DecoratedInterval(entireinterval(), dac)

    @test @decorated("3.56?1") === DecoratedInterval(Interval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), com)

    @test @decorated("3.56?1e2") === DecoratedInterval(Interval(355.0, 357.0), com)

    @test @decorated("3.560?2") === DecoratedInterval(Interval(0x3.8ED916872B020P+0, 0x3.8FDF3B645A1CCP+0), com)

    @test @decorated("3.56?") === DecoratedInterval(Interval(0x3.8E147AE147AE0P+0, 0x3.90A3D70A3D70CP+0), com)

    @test @decorated("3.560?2u") === DecoratedInterval(Interval(0x3.8F5C28F5C28F4P+0, 0x3.8FDF3B645A1CCP+0), com)

    @test @decorated("-10?") === DecoratedInterval(Interval(-10.5, -9.5), com)

    @test @decorated("-10?u") === DecoratedInterval(Interval(-10.0, -9.5), com)

    @test @decorated("-10?12") === DecoratedInterval(Interval(-22.0, 2.0), com)

    @test @decorated("-10??u") === DecoratedInterval(Interval(-10.0, Inf), dac)

    @test @decorated("-10??") === DecoratedInterval(Interval(-Inf, Inf), dac)

    @test isnai(@decorated("[nai]"))

    @test @decorated("3.56?1_def") === DecoratedInterval(Interval(0x3.8CCCCCCCCCCCCP+0, 0x3.91EB851EB8520P+0), def)

end

@testset "IEEE1788.f" begin

    @test @interval("[]") === emptyinterval()

    @test @interval("[empty]") === emptyinterval()

    @test @interval("[ empty ]") === emptyinterval()

    @test @interval("[,]") === entireinterval()

    @test @interval("[ entire ]") === entireinterval()

end
