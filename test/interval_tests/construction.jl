# This file is part of the ValidatedNumerics.jl package; MIT licensed

if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end
using ValidatedNumerics

@testset "Constructing intervals" begin
    setprecision(Interval, 53)
    @test ValidatedNumerics.parameters.precision == 53

    setprecision(Interval, Float64)
    @test ValidatedNumerics.parameters.precision == 53

    @test precision(BigFloat) == 53
    @test precision(Interval) == (Float64, 53)

    # Checks for parameters
    @test ValidatedNumerics.parameters.precision_type == Float64
    @test ValidatedNumerics.parameters.precision == 53
    @test ValidatedNumerics.parameters.rounding == :narrow
    @test ValidatedNumerics.parameters.pi == @biginterval(pi)

    # Naive constructors, with no conversion involved
    @test Interval(1) == Interval(1.0, 1.0)
    @test Interval(big(1)) == Interval(1.0, 1.0)
    @test Interval(eu) == Interval(1.0*eu)
    @test Interval(1//10) == Interval{Rational{Int}}(1//10, 1//10)
    @test Interval(BigInt(1)//10) == Interval{Rational{BigInt}}(1//10, 1//10)
    @test Interval( (1.0, 2.0) ) == Interval(1.0, 2.0)

    @test Interval{Rational{Int}}(1) == Interval(1//1)
    #@test Interval{Rational{Int}}(pi) == Interval(rationalize(1.0*pi))

    @test Interval{Float64}(pi) == Interval(float(pi))
    @test Interval{BigFloat}(1) == Interval{BigFloat}(big(1.0), big(1.0))
    @test Interval{BigFloat}(pi) == Interval{BigFloat}(big(pi), big(pi))

    # Disallowed conversions with a > b

    @test_throws ArgumentError Interval(2, 1)
    @test_throws ArgumentError Interval(big(2), big(1))
    @test_throws ArgumentError Interval(BigInt(1), 1//10)
    @test_throws ArgumentError Interval(1, 0.1)
    @test_throws ArgumentError Interval(big(1), big(0.1))

    @test_throws ArgumentError @interval(2, 1)
    @test_throws ArgumentError @interval(big(2), big(1))
    @test_throws ArgumentError @interval(big(1), 1//10)
    @test_throws ArgumentError @interval(1, 0.1)
    @test_throws ArgumentError @interval(big(1), big(0.1))


    # Conversion to Interval without type
    @test convert(Interval, 1) == Interval(1.0)
    @test convert(Interval, pi) == @interval(pi)
    @test convert(Interval, eu) == @interval(eu)
    @test convert(Interval, BigInt(1)) == Interval(BigInt(1))
    @test convert(Interval, 1//10) == @interval(1//10)
    @test convert(Interval, 0.1) == Interval(0.09999999999999999, 0.1)
    @test convert(Interval, BigFloat(0.1)) == Interval(big(0.1))


    @test convert(Interval{Rational{Int}}, 0.1) == Interval(1//10)
    # @test convert(Interval{Rational{BigInt}}, pi) == Interval{Rational{BigInt}}(pi)

    ## promotion
    @test promote(Interval(2//1,3//1), Interval(1, 2)) ==
        (Interval(2.0,3.0), Interval(1.0,2.0))
    @test promote(Interval(1.5), parse(BigFloat, "2.1")) ==
        (Interval(BigFloat(1.5)), Interval(BigFloat(2.1)))
    @test promote(Interval(1.0), pi) == (Interval(1.0), @interval(pi))

    # Constructors from the macros @interval, @floatinterval @biginterval
    setprecision(Interval, 53)

    a = @interval(0.1)
    b = @interval(pi)

    @test nextfloat(a.lo) == a.hi
    @test typeof(a) == Interval{BigFloat}
    @test a == @biginterval("0.1")
    @test convert(Interval{Float64}, a) == @floatinterval(0.1)
    @test nextfloat(b.lo) == b.hi

    @test b == @biginterval(pi)
    x = 10238971209348170283710298347019823749182374098172309487120398471029837409182374098127304987123049817032984712039487
    @test @interval(x) == @biginterval(x)
    @test isthin(@interval(x)) == false

    x = 0.1
    a = @interval(x)
    @test nextfloat(a.lo) == a.hi


    setprecision(Interval, Float64)
    a = @interval(0.1)
    b = @interval(pi)

    @test a == @floatinterval("0.1")
    @test typeof(a) == Interval{Float64}
    @test nextfloat(a.lo) == a.hi
    @test b == @floatinterval(pi)
    @test nextfloat(b.lo) == b.hi
    @test convert(Interval{Float64}, @biginterval(0.1)) == a
    x = typemax(Int)
    @test @interval(x) == @floatinterval(x)
    @test isthin(@interval(x)) == false
    x = rand()
    c = @interval(x)
    @test nextfloat(c.lo) == c.hi


    a = @interval("[0.1, 0.2]")
    b = @interval(0.1, 0.2)

    @test a == b

    @test_throws ArgumentError @interval("[0.1, 0.2")


    for precision in (64, Float64)
        setprecision(Interval, precision)
        d = big(3)
        f = @interval(d, 2d)
        @test @interval(3, 6) ⊆ f
    end


    for rounding in (:wide, :narrow)
        a = @interval(0.1, 0.2)
        @test a ⊆ Interval(0.09999999999999999, 0.20000000000000004)

        b = @interval(0.1)
        @test b ⊆ Interval(0.09999999999999999, 0.10000000000000002)

        b = setprecision(Interval, 128) do
            @interval(0.1, 0.2)
        end
        @test b ⊆ Interval(0.09999999999999999, 0.20000000000000004)

        @test float(b) ⊆ a

        c = @interval("0.1", "0.2")
        @test c ⊆ a   # c is narrower than a
        @test Interval(1//2) == Interval(0.5)
        @test Interval(1//10).lo == rationalize(0.1)
    end

    @test string(emptyinterval()) == "∅"

    params = ValidatedNumerics.IntervalParameters()
    @test params.precision_type == BigFloat
    @test params.precision == 256
    @test params.rounding == :narrow

    setprecision(Interval, 53)
    a = big(1)//3
    @test @interval(a) == Interval(big(3.3333333333333331e-01), big(3.3333333333333337e-01))
end

@testset "Big intervals" begin
    a = @floatinterval(3)
    @test typeof(a)== Interval{Float64}
    @test typeof(big(a)) == Interval{BigFloat}

    @test @floatinterval(123412341234123412341241234) == Interval(1.234123412341234e26, 1.2341234123412342e26)
    @test @interval(big"3") == @floatinterval(3)
    @test @floatinterval(big"1e10000") == Interval(1.7976931348623157e308, ∞)

    a = big(10)^10000
    @test @floatinterval(a) == Interval(1.7976931348623157e308, ∞)
    setprecision(Interval, 53)
    @test @biginterval(a) == Interval(big"9.9999999999999994e+9999", big"1.0000000000000001e+10000")
end

@testset "Complex intervals" begin
    a = @floatinterval(3 + 4im)
    @test typeof(a)== Complex{Interval{Float64}}
    @test a == Interval(3) + im*Interval(4)

    # TODO; Uncomment these tests
    # b = exp(a)
    # @test real(b) == Interval(-13.12878308146216, -13.128783081462153)
    # @test imag(b) == Interval(-15.200784463067956, -15.20078446306795)
end

@testset ".. tests" begin


    a = 0.1..0.3
    @test big"0.1" ∈ a
    @test big"0.3" ∈ a

    # part of issue #172:

    a = big(0.1)..2
    @test typeof(a) == Interval{BigFloat}
end

@testset "± tests" begin
    setprecision(Interval, Float64)

    @test 3 ± 0.5 == Interval(2.5, 3.5)
    @test 3 ± 0.1 == Interval(2.9, 3.1)
    @test 0.5 ± 1 == Interval(-0.5, 1.5)

    # issue 172:
    a = @interval(1) ± 1
    @test a == Interval(-0.0, 2.0)
    @test typeof(a) == Interval{Float64}

    a =  @biginterval(1) ± 1
    @test a == Interval(big(-0.0), big(2.0))
    @test typeof(a) == Interval{BigFloat}

end

@testset "Conversion to interval of same type" begin
    x = 3..4
    @test convert(Interval{Float64}, x) === x

    x = big(3)..big(4)
    @test convert(Interval{BigFloat}, x) === x
end

@testset "Conversions between different types of interval" begin
    a = convert(Interval{BigFloat}, 3..4)
    @test typeof(a) == Interval{BigFloat}

    a = convert(Interval{Float64}, @biginterval(3, 4))
    @test typeof(a) == Interval{Float64}
end

@testset "Conversion to Interval" begin
    a = convert(Interval, 3)
    @test a == Interval(3.0)
    @test typeof(a) == Interval{Float64}

    a = convert(Interval, big(3))
    @test typeof(a) == Interval{BigFloat}

end

@testset "Interval{T} constructor" begin
    @test Interval{Float64}(1) == 1..1
    @test Interval{Float64}(1.1) == Interval(1.1, 1.1)  # no rounding

    @test Interval{BigFloat}(1) == @biginterval(1, 1)
    @test Interval{BigFloat}(big"1.1") == Interval(big"1.1", big"1.1")
end

# issue 192:
@testset "Disallow a single NaN in an interval" begin
    a = Interval(NaN, 2)
    @test isnan(a.lo) && isnan(a.hi)

    a = Interval(Inf, NaN)
    @test isnan(a.lo) && isnan(a.hi)

end

# issue 206:

setprecision(Interval, Float64)

@testset "Interval strings" begin
    @test I"[1, 2]" == @interval("[1, 2]")
    @test I"[2/3, 1.1]" == @interval("[2/3, 1.1]") == Interval(0.6666666666666666, 1.1)
    @test I"[1]" == @interval("[1]") == Interval(1.0, 1.0)
    @test I"[-0x1.3p-1, 2/3]" == @interval("[-0x1.3p-1, 2/3]") == Interval(-0.59375, 0.6666666666666667)
end

@testset "setdiff tests" begin
    x = 1..3
    y = 2..4
    @test setdiff(x, y) == [1..2]
    @test setdiff(y, x) == [3..4]

    @test setdiff(x, x) == Interval{Float64}[]

    @test setdiff(x, emptyinterval(x)) == [x]

    z = 0..5
    @test setdiff(x, z) == Interval{Float64}[]
    @test setdiff(z, x) == [0..1, 3..5]
end

@testset "Interval{T}(x::Interval)" begin
    @test Interval{Float64}(3..4) == Interval(3.0, 4.0)
    @test Interval{BigFloat}(3..4) == Interval{BigFloat}(3, 4)
end
