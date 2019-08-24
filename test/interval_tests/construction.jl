# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

const eeuler = Base.MathConstants.e

@testset "Construction" begin

    @testset "Constructing intervals" begin
        # Naive constructors, with no conversion involved
        @test isidentical(Interval(1), Interval(1.0, 1.0))
        @test size(Interval(1)) == (1,)
        @test isidentical(Interval(big(1)), Interval(1.0, 1.0))
        @test isidentical(Interval(eeuler), Interval(1.0*eeuler))
        @test isidentical(Interval(1//10), Interval{Rational{Int}}(1//10, 1//10))
        @test isidentical(Interval(BigInt(1)//10), Interval{Rational{BigInt}}(1//10, 1//10))
        @test isidentical(Interval( (1.0, 2.0) ), Interval(1.0, 2.0))
        @test isidentical(Interval{Rational{Int}}(1), Interval(1//1))
        @test isidentical(Interval{BigFloat}(1), Interval{BigFloat}(big(1.0), big(1.0)))

        @test isidentical(-pi..pi, @interval(-pi,pi))
        @test isidentical(0..pi, hull(Interval(0), Interval{Float64}(π)))
        @test isidentical(1.2..pi, @interval(1.2, pi))
        @test isidentical(pi..big(4), hull(Interval{BigFloat}(π), Interval(4)))
        @test isidentical(pi..pi, Interval{Float64}(π))
        @test isidentical(eeuler..pi, hull(@interval(eeuler), Interval{Float64}(π)))

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
    @test isidentical(@interval(1e300), Interval(9.999999999999999e299, 1.0e300))
    @test isidentical(@interval(-1e307), Interval(-1.0000000000000001e307, -1.0e307))
    @test isidentical(@interval(Inf), IntervalArithmetic.wideinterval(Inf))
    @test isidentical(IntervalArithmetic.wideinterval(-big(Inf)), Interval(-Inf, nextfloat(big(-Inf))))
        # a < Inf and b > -Inf
        @test isidentical(@interval(1e300), Interval(9.999999999999999e299, 1.0e300))
        @test isidentical(@interval(-1e307), Interval(-1.0000000000000001e307, -1.0e307))
        @test isidentical(@interval(Inf), IntervalArithmetic.wideinterval(Inf))
        @test isidentical(IntervalArithmetic.wideinterval(-big(Inf)), Interval(-Inf, nextfloat(big(-Inf))))

        # Disallowed conversions with a > b

        @test_throws ArgumentError Interval(2, 1, check=true)
        @test_throws ArgumentError Interval(big(2), big(1), check=true)
        @test_throws ArgumentError Interval(BigInt(1), 1//10, check=true)
        @test_throws ArgumentError Interval(1, 0.1, check=true)
        @test_throws ArgumentError Interval(big(1), big(0.1), check=true)

        @test_throws ArgumentError @interval(2, 1)
        @test_throws ArgumentError @interval(big(2), big(1))
        @test_throws ArgumentError @interval(big(1), 1//10)
        @test_throws ArgumentError @interval(1, 0.1)
        @test_throws ArgumentError @interval(big(1), big(0.1))
        @test_throws ArgumentError Interval(Inf, check=true)
        @test_throws ArgumentError Interval(-Inf, -Inf, check=true)
        @test_throws ArgumentError Interval(Inf, Inf, check=true)

        # Conversion to Interval without type
        @test isidentical(convert(Interval, 1), Interval(1.0))
        @test isidentical(convert(Interval, pi), @interval(pi))
        @test isidentical(convert(Interval, eeuler), @interval(eeuler))
        @test isidentical(convert(Interval, BigInt(1)), Interval(BigInt(1)))
        @test isidentical(convert(Interval, 1//10), @interval(1//10))
        @test convert(Interval, Interval(0.1, 0.2)) === Interval(0.1, 0.2)

        @test isidentical(convert(Interval{Rational{Int}}, 0.1), Interval(1//10))

        ## promotion
        @test all(isidentical.(promote(Interval(2//1,3//1), Interval(1, 2)),
                            (Interval(2.0,3.0), Interval(1.0,2.0))))
        @test all(isidentical.(promote(Interval(1.0), pi), (Interval(1.0), @interval(pi))))

        a = @interval(0.1)
        b = @interval(pi)

        @test isidentical(a, @floatinterval("0.1"))
        @test typeof(a) == Interval{Float64}
        @test nextfloat(a.lo) == a.hi
        @test b == @floatinterval(pi)
        @test nextfloat(b.lo) == b.hi
        @test isidentical(convert(Interval{Float64}, @biginterval(0.1)), a)
        x = typemax(Int64)
        @test isidentical(@interval(x), @floatinterval(x))
        @test !isthin(@interval(x))
        x = rand()
        c = @interval(x)
        @test nextfloat(c.lo) == c.hi

        a = @interval("[0.1, 0.2]")
        b = @interval(0.1, 0.2)

        @test isidentical(a, b)

        @test_throws ArgumentError @interval("[0.1, 0.2")

        for rounding in (:wide, :narrow)
            a = @interval(0.1, 0.2)
            @test a ⊆ Interval(0.09999999999999999, 0.20000000000000004)

            b = @interval(0.1)
            @test b ⊆ Interval(0.09999999999999999, 0.10000000000000002)
            @test b ⊆ Interval(0.09999999999999999, 0.20000000000000004)
            @test float(b) ⊆ a

            c = @interval("0.1", "0.2")
            @test c ⊆ a   # c is narrower than a
            @test isidentical(Interval(1//2), Interval(0.5))
            @test Interval(1//10).lo == rationalize(0.1)
        end

        @test string(emptyinterval()) == "∅"
    end

    @testset "Big intervals" begin
        a = @floatinterval(3)
        @test typeof(a)== Interval{Float64}
        @test typeof(big(a)) == Interval{BigFloat}

        @test isidentical(@floatinterval(123412341234123412341241234), Interval(1.234123412341234e26, 1.2341234123412342e26))
        @test isidentical(@interval(big"3"), @floatinterval(3))


        @test_skip @floatinterval(big"1e10000") == Interval(1.7976931348623157e308, ∞)

        a = big(10)^10000
        @test isidentical(@floatinterval(a), Interval(1.7976931348623157e308, ∞))
    end

    #=
    @testset "Complex intervals" begin
        a = @floatinterval(3 + 4im)
        @test typeof(a) == Complex{Interval{Float64}}
        @test isidentical(a, Interval(3) + im*Interval(4))

        # TODO; Uncomment these tests
        # b = exp(a)
        # @test real(b) == Interval(-13.12878308146216, -13.128783081462153)
        # @test imag(b) == Interval(-15.200784463067956, -15.20078446306795)
    end
    =#

    @testset ".. tests" begin
        a = 1..2
        @test typeof(a) == Interval{DefaultBound}

        a = 0.1..0.3
        @test isidentical(a, Interval(0.09999999999999999, 0.30000000000000004))
        @test big"0.1" ∈ a
        @test big"0.3" ∈ a

        # part of issue #172:
        a = big(0.1)..2
        @test typeof(a) == Interval{BigFloat}
    end

    @testset "± tests" begin
        @test isidentical(3 ± 1, Interval(2.0, 4.0))
        @test isidentical(3 ± 0.5, 2.5..3.5)
        @test isidentical(3 ± 0.1, 2.9..3.1)
        @test isidentical(0.5 ± 1, -0.5..1.5)

        # issue 172:
        @test isidentical((1..1) ± 1, 0..2)

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
        @test isidentical(a, Interval(3.0))
        @test typeof(a) == Interval{Float64}

        a = convert(Interval, big(3))
        @test typeof(a) == Interval{BigFloat}

    end

    @testset "Interval{T} constructor" begin
        @test isidentical(Interval{Float64}(1), 1..1)
        # no rounding
        @test isidentical(Interval{Float64}(1.1), Interval(1.1, 1.1))

        @test isidentical(Interval{BigFloat}(1), @biginterval(1, 1))
        @test isidentical(Interval{BigFloat}(big"1.1"), Interval(big"1.1", big"1.1"))
    end

    @testset "Disallow a single NaN in an interval" begin
        @test_throws ArgumentError Interval(NaN, 2, check=true)
        @test_throws ArgumentError Interval(Inf, NaN, check=true)
    end

    # issue 206:
    @testset "Interval strings" begin
        @test isidentical(I"[1, 2]", @interval("[1, 2]"))

        a = I"[2/3, 1.1]"
        b = @interval("[2/3, 1.1]")
        c = Interval(0.6666666666666666, 1.1)
        @test isidentical(a, b)
        @test isidentical(b, c)

        a = I"[1]"
        b = @interval("[1]")
        c = Interval(1.0, 1.0)
        @test isidentical(a, b)
        @test isidentical(b, c)

        a = I"[-0x1.3p-1, 2/3]"
        b = @interval("[-0x1.3p-1, 2/3]")
        c = Interval(-0.59375, 0.6666666666666667)
        @test isidentical(a, b)
        @test isidentical(b, c)
    end

    @testset "setdiff tests" begin
        x = 1..3
        y = 2..4
        @test all(isidentical.(setdiff(x, y), [1..2]))
        @test all(isidentical.(setdiff(y, x), [3..4]))

        @test setdiff(x, x) == Interval{DefaultBound}[]

        @test all(isidentical.(setdiff(x, emptyinterval(x)), [x]))

        z = 0..5
        @test setdiff(x, z) == Interval{DefaultBound}[]
        @test all(isidentical.(setdiff(z, x), [0..1, 3..5]))
    end

    @testset "Interval{T}(x::Interval)" begin
        @test isidentical(Interval{Float64}(3..4), Interval(3.0, 4.0))
        @test isidentical(Interval{BigFloat}(3..4), Interval{BigFloat}(3, 4))
    end

    @testset "@interval with fields" begin
        a = 3..4
        x = @interval(a.lo, 2*a.hi)
        @test isidentical(x, Interval(3, 8))
    end

    @testset "@interval with user-defined function" begin
        f(x) = x==Inf ? one(x) : x/(1+x)  # monotonic

        x = 3..4
        @test isidentical(@interval(f(x.lo), f(x.hi)), Interval(0.75, 0.8))
    end

    @testset "a..b with a > b" begin
        @test_throws ArgumentError 3..2
    end

    @testset "Hashing of Intervals" begin
        x = Interval{Float64}(1, 2)
        y = Interval{BigFloat}(1, 2)
        @test isidentical(x, y)
        @test hash(x) == hash(y)

        x = @interval(0.1)
        y = IntervalArithmetic.big53(x)
        @test isidentical(x, y)
        @test hash(x) == hash(y)

        x = 1..2
        y = 1..3
        @test !isidentical(x, y)
        @test hash(x) != hash(y)
    end

    import IntervalArithmetic: force_interval
    @testset "force_interval" begin
        @test isidentical(force_interval(4, 3), Interval(3, 4))
        @test isidentical(force_interval(4, Inf), Interval(4, Inf))
        @test isidentical(force_interval(Inf, 4), Interval(4, Inf))
        @test isidentical(force_interval(Inf, -Inf), Interval(-Inf, Inf))
        @test_throws ArgumentError force_interval(NaN, 3)
    end

end