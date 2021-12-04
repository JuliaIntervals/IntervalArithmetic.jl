# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

const eeuler = Base.MathConstants.e


@testset "Constructing intervals" begin
    setprecision(Interval, 53)
    @test IntervalArithmetic.parameters.precision == 53

    setprecision(Interval, Float64)
    @test IntervalArithmetic.parameters.precision == 53

    @test precision(BigFloat) == 53
    @test precision(Interval) == (Float64, 53)

    # Checks for parameters
    @test IntervalArithmetic.parameters.precision_type == Float64
    @test IntervalArithmetic.parameters.precision == 53
    @test IntervalArithmetic.parameters.rounding == :narrow
    @test IntervalArithmetic.parameters.pi == @biginterval(pi)

    # Naive constructors, with no conversion involved
    @test Interval(1) == Interval(1.0, 1.0)
    @test size(Interval(1)) == (1,)
    @test Interval(big(1)) == Interval(1.0, 1.0)
    @test Interval(1//10) == Interval{Rational{Int}}(1//10, 1//10)
    @test Interval(BigInt(1)//10) == Interval{Rational{BigInt}}(1//10, 1//10)
    @test Interval( (1.0, 2.0) ) == Interval(1.0, 2.0)

    @test Interval{Rational{Int}}(1) == Interval(1//1)
    #@test Interval{Rational{Int}}(pi) == Interval(rationalize(1.0*pi))

    @test Interval{BigFloat}(1) == Interval{BigFloat}(big(1.0), big(1.0))

    # Irrational
    for irr in (π, eeuler)
        @test @interval(-irr, irr).hi == (-irr..irr).hi
        @test 0..irr == hull(interval(0), Interval{Float64}(irr))
        @test 1.2..irr == @interval(1.2, irr)
        @test irr..irr == Interval{Float64}(irr)
        @test Interval(irr) == @interval(irr)
        @test Interval(irr, irr) == Interval(irr)
        @test Interval{Float32}(irr, irr) == Interval{Float32}(irr)
    end

    # The following error on windows due to a missing method in MPFR
    @test_broken eeuler..big(4) == hull(Interval{BigFloat}(π), interval(4))
    @test π..big(4) == hull(Interval{BigFloat}(π), interval(4))

    @test eeuler..pi == hull(@interval(eeuler), Interval{Float64}(π))
    @test big(eeuler) in Interval(eeuler, π)
    @test big(π) in Interval(eeuler, π)
    @test big(eeuler) in Interval(0, eeuler)
    @test big(π) in Interval(π, 4)

    @test big(eeuler) in Interval{Float32}(eeuler, π)
    @test big(π) in Interval{Float32}(eeuler, π)
    @test big(eeuler) in Interval{Float32}(0, eeuler)
    @test big(π) in Interval{Float32}(π, 4)

    # a < Inf and b > -Inf
    @test @interval(1e300) == Interval(9.999999999999999e299, 1.0e300)
    @test @interval(-1e307) == Interval(-1.0000000000000001e307, -1.0e307)
    @test @interval(Inf) == IntervalArithmetic.wideinterval(Inf)
    @test IntervalArithmetic.wideinterval(-big(Inf)) == Interval(-Inf, nextfloat(big(-Inf)))

    # Disallowed conversions with a > b

    @test_logs (:warn,) @test isempty(interval(2, 1))
    @test_logs (:warn,) @test isempty(interval(big(2), big(1)))
    @test_logs (:warn,) @test isempty(interval(BigInt(1), 1//10))
    @test_logs (:warn,) @test isempty(interval(1, 0.1))
    @test_logs (:warn,) @test isempty(interval(big(1), big(0.1)))

    @test_logs (:warn,) @test isempty(@interval(2, 1))
    @test_logs (:warn,) @test isempty(@interval(big(2), big(1)))
    @test_logs (:warn,) @test isempty(@interval(big(1), 1//10))
    @test_logs (:warn,) @test isempty(@interval(1, 0.1))
    @test_logs (:warn,) @test isempty(@interval(big(1), big(0.1)))
    @test_logs (:warn,) @test isempty(interval(Inf))
    @test_logs (:warn,) @test isempty(interval(-Inf, -Inf))
    @test_logs (:warn,) @test isempty(interval(Inf, Inf))

    # Conversion to Interval without type
    @test convert(Interval, 1) == Interval(1.0)
    @test convert(Interval, pi) == @interval(pi)
    @test convert(Interval, eeuler) == @interval(eeuler)
    @test convert(Interval, BigInt(1)) == Interval(BigInt(1))
    @test convert(Interval, 1//10) == @interval(1//10)
    @test convert(Interval, Interval(0.1, 0.2)) === Interval(0.1, 0.2)

    @test convert(Interval{Rational{Int}}, 0.1) == Interval(1//10)
    # @test convert(Interval{Rational{BigInt}}, pi) == Interval{Rational{BigInt}}(pi)

    ## promotion
    @test promote(Interval(2//1,3//1), Interval(1, 2)) ==
        (Interval(2.0,3.0), Interval(1.0,2.0))
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
    x = typemax(Int64)
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

    params = IntervalArithmetic.IntervalParameters()
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


    @test_skip @floatinterval(big"1e10000") == Interval(1.7976931348623157e308, ∞)

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

@testset "Typed intervals" begin
    setprecision(Interval, Float64)

    @test typeof(@interval Float64 1 2) == Interval{Float64}
    @test typeof(@interval         1 2) == Interval{Float64}
    @test typeof(@interval Float32 1 2) == Interval{Float32}
    @test typeof(@interval Float16 1 2) == Interval{Float16}

    # PR 496
    @test eltype(Interval(1, 2)) == Interval{Float64}
    @test IntervalArithmetic.numtype(Interval(1, 2)) == Float64
    @test [1 2; 3 4] * Interval(-1, 1) == [-1..1 -2..2;-3..3 -4..4]

    @test eltype(IntervalBox(1..2, 2..3)) == Interval{Float64}
    @test IntervalArithmetic.numtype(IntervalBox(1..2, 2..3)) == Float64
end

@testset ".. tests" begin

    a = 0.1..0.3
    @test a == Interval(0.09999999999999999, 0.30000000000000004)
    @test big"0.1" ∈ a
    @test big"0.3" ∈ a

    # part of issue #172:

    a = big(0.1)..2
    @test typeof(a) == Interval{BigFloat}

    @test_logs (:warn, ) @test isempty(2..1)
    @test_logs (:warn, ) @test isempty(π..1)
    @test_logs (:warn, ) @test isempty(π..eeuler)
    @test_logs (:warn, ) @test isempty(4..π)
    @test_logs (:warn, ) @test isempty(NaN..3)
    @test_logs (:warn, ) @test isempty(3..NaN)
    @test 1..π == Interval(1, π)
end

@testset "± tests" begin
    setprecision(Interval, Float64)

    @test 3 ± 1 == Interval(2.0, 4.0)
    @test 3 ± 0.5 == 2.5..3.5
    @test 3 ± 0.1 == 2.9..3.1
    @test 0.5 ± 1 == -0.5..1.5

    # issue 172:
    @test (1..1) ± 1 == 0..2

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
@testset "Disallow NaN in an interval" begin
    @test_logs (:warn, ) @test isempty(interval(NaN, 2))
    @test_logs (:warn, ) @test isempty(interval(Inf, NaN))
    @test_logs (:warn, ) @test isempty(interval(NaN, NaN))
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

@testset "@interval with fields" begin
    a = 3..4
    x = @interval(a.lo, 2*a.hi)
    @test x == Interval(3, 8)
end

@testset "@interval with user-defined function" begin
    f(x) = x==Inf ? one(x) : x/(1+x)  # monotonic

    x = 3..4
    @test @interval(f(x.lo), f(x.hi)) == Interval(0.75, 0.8)
end

@testset "a..b with a > b" begin
    @test_logs (:warn,) @test isempty(3..2)
end

@testset "Hashing of Intervals" begin
    x = Interval{Float64}(1, 2)
    y = Interval{BigFloat}(1, 2)
    @test isequal(x, y)
    @test isequal(hash(x), hash(y))

    x = @interval(0.1)
    y = IntervalArithmetic.bigequiv(x)
    @test isequal(x, y)
    @test isequal(hash(x), hash(y))

    x = 0.1
    y = IntervalArithmetic.bigequiv(x)
    @test isequal(x, y)
    @test isequal(hash(x), hash(y))

    x = interval(1, 2)
    y = interval(1, 3)
    @test !isequal(x, y)
    @test !isequal(hash(x), hash(y))

end

import IntervalArithmetic: force_interval
@testset "force_interval" begin
    @test force_interval(4, 3) == Interval(3, 4)
    @test force_interval(4, Inf) == Interval(4, Inf)
    @test force_interval(Inf, 4) == Interval(4, Inf)
    @test force_interval(Inf, -Inf) == Interval(-Inf, Inf)
    @test_logs (:warn,) @test isempty(force_interval(NaN, 3))
end

@testset "Zero interval" begin
    @test zero(Interval{Float64}) === Interval{Float64}(0, 0)
    @test zero(0 .. 1) === Interval{Float64}(0, 0)
end
