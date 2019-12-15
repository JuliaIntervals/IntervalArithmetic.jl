using IntervalArithmetic
using Test

setformat(:standard, decorations=true, sigfigs=6)

@testset "Parse string to Interval" begin
    @test parse(Interval{Float64}, "1") == Interval(1, 1)
    @test parse(Interval{Float64}, "[1, 2]") == Interval(1, 2)
    @test parse(Interval{Float64}, "[-0x1.3p-1, 2/3]") == @interval(-0x1.3p-1, 2/3)
    @test parse(Interval{Float64}, "[1,+infinity]") == Interval(1.0, Inf)
    @test parse(Interval{Float64}, "[1.234e5,Inf]") == Interval(123400.0, Inf)
    @test parse(Interval{Float64}, "[]") == ∅
    @test parse(Interval{Float64}, "[,]") == entireinterval(Float64)
    @test parse(Interval{Float64}, "[ entire ]") == entireinterval(Float64)
    @test parse(Interval{Float64}, "3.56?1") == Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0)
    @test parse(Interval{Float64}, "3.56?1e2") == Interval(355.0, 357.0)
    @test parse(Interval{Float64}, "3.560?2") == Interval(0x3.8ed916872b020p+0, 0x3.8fdf3b645a1ccp+0)
    @test parse(Interval{Float64}, "3.56?") == Interval(0x3.8e147ae147ae0p+0, 0x3.90a3d70a3d70cp+0)
    @test parse(Interval{Float64}, "3.560?2u") == Interval(0x3.8f5c28f5c28f4p+0, 0x3.8fdf3b645a1ccp+0)
    @test parse(Interval{Float64}, "-10?") == Interval(-10.5, -9.5)
    @test parse(Interval{Float64}, "-10?u") == Interval(-10.0, -9.5)
    @test parse(Interval{Float64}, "-10?12") == Interval(-22.0, 2.0)
    @test parse(Interval{Float64}, "0.0?d") == Interval(-0.05, 0.0)
    @test parse(Interval{Float64}, "2.5?d") == Interval(0x1.3999999999999p+1, 2.5)
    @test parse(Interval{Float64}, "0.000?5d") == Interval(-0.005, 0.0)
    @test parse(Interval{Float64}, "2.500?5d") == Interval(0x1.3f5c28f5c28f5p+1, 2.5)
    @test parse(Interval{Float64}, "2.5??d") == Interval(-Inf, 2.5)
    @test parse(Interval{Float64}, "2.500?5ue4") == Interval(0x1.86ap+14, 0x1.8768p+14)
    @test parse(Interval{Float64}, "2.500?5de-5") == Interval(0x1.a2976f1cee4d5p-16, 0x1.a36e2eb1c432dp-16)
    @test parse(Interval{Float64}, "3.1416?1") == Interval(0x3.24395810624dcp+0, 0x3.24467381d7dc0p+0)

    @test parse(Interval{BigFloat}, "1") == @biginterval(1)
    @test parse(Interval{BigFloat}, "[-0x1.3p-1, 2/3]") == @biginterval(-0x1.3p-1, 2/3)

    @test parse(Interval{Float64}, "[Empty]") == emptyinterval(Float64)
    @test parse(Interval{BigFloat}, "[Empty]") == emptyinterval(BigFloat)

    @test parse(Interval{Float64}, "3 ±  4") == (-1)..7
    @test parse(Interval{Float64}, "0.2 ± 0.1") == 0.1..0.3
    @test parse(Interval{BigFloat}, "0.2 ± 0.1") == big"0.2" ± big"0.1"
end

@testset "Parse string to DecoratedInterval" begin
    @test parse(DecoratedInterval{Float64}, "[3]") == DecoratedInterval(3)

    @test parse(DecoratedInterval{Float64}, "[3, 4]") == DecoratedInterval(3, 4)

    @test parse(DecoratedInterval{Float64}, "[3, 4]_dac") == DecoratedInterval(3, 4, dac)

    @test parse(DecoratedInterval{Float64}, "[ ]") == DecoratedInterval(∅, trv)

    @test parse(DecoratedInterval{Float64}, "[entire]") == DecoratedInterval(Interval(-Inf, Inf), dac)

    @test parse(DecoratedInterval{Float64}, "[,]") == DecoratedInterval(entireinterval(Float64), dac)
    @test parse(DecoratedInterval{Float64}, "3.56?1") == DecoratedInterval(Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0), com)
    @test parse(DecoratedInterval{Float64}, "3.56?1e2") == DecoratedInterval(Interval(355.0, 357.0), com)
    @test parse(DecoratedInterval{Float64}, "3.560?2") == DecoratedInterval(Interval(0x3.8ed916872b020p+0, 0x3.8fdf3b645a1ccp+0), com)
    @test parse(DecoratedInterval{Float64}, "3.56?") == DecoratedInterval(Interval(0x3.8e147ae147ae0p+0, 0x3.90a3d70a3d70cp+0), com)
    @test parse(DecoratedInterval{Float64}, "3.56?e2") == DecoratedInterval(Interval(3.555e2, 3.565e2), com)
    @test parse(DecoratedInterval{Float64}, "3.560?2u") == DecoratedInterval(Interval(0x3.8f5c28f5c28f4p+0, 0x3.8fdf3b645a1ccp+0), com)
    @test parse(DecoratedInterval{Float64}, "-10?") == DecoratedInterval(Interval(-10.5, -9.5), com)
    @test parse(DecoratedInterval{Float64}, "-10?e2") == DecoratedInterval(Interval(-10.5e2, -9.5e2), com)
    @test parse(DecoratedInterval{Float64}, "-10?u") == DecoratedInterval(Interval(-10.0, -9.5), com)
    @test parse(DecoratedInterval{Float64}, "-10?12") == DecoratedInterval(Interval(-22.0, 2.0), com)
    @test parse(DecoratedInterval{Float64}, "-10??u") == DecoratedInterval(Interval(-10.0, Inf), dac)
    @test parse(DecoratedInterval{Float64}, "-10??") == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test isnai(parse(DecoratedInterval{Float64}, "[nai]"))
    @test parse(DecoratedInterval{Float64}, "3.56?1_def") == DecoratedInterval(Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0), def)
end
