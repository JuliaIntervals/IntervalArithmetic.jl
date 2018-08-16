using IntervalArithmetic
using Test

setformat(:standard, decorations=true, sigfigs=6)

setprecision(128)

@testset "Parse string to Interval" begin
    @test parse(Interval{Float64}, "1") == Interval(1, 1)
    @test parse(Interval{Float64}, "[1, 2]") == Interval(1, 2)
    @test parse(Interval{Float64}, "[-0x1.3p-1, 2/3]") == @interval(-0x1.3p-1, 2/3)

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
end
