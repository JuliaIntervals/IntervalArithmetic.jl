using ValidatedNumerics

setdisplay(:standard, decorations=true, sigfigs=6)

@testset "Parsing of string to interval" begin
    @test parse(Interval{Float64}, "1") == Interval(1, 1)
    @test parse(Interval{Float64}, "[1, 2]") == Interval(1, 2)
    @test parse(Interval{Float64}, "[-0x1.3p-1, 2/3]") == @interval(-0x1.3p-1, 2/3)

    @test parse(Interval{BigFloat}, "1") == @biginterval(1)
    parse(Interval{BigFloat}, "[-0x1.3p-1, 2/3]") == @biginterval(-0x1.3p-1, 2/3)
end
