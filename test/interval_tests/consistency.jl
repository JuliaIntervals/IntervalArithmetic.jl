# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

@testset "Consistency tests" begin

    a = @interval(0.1, 1.1)
    b = @interval(0.9, 2.0)
    c = @interval(0.25, 4.0)

    @testset "Interval types and constructors" begin

        @test isa( @interval(1,2), Interval )
        @test isa( @interval(0.1), Interval )
        @test isa( zero(b), Interval )

        @test isidentical(zero(b), 0.0)
        @test isidentical(zero(b), zero(typeof(b)))
        @test isidentical(one(a), 1.0)
        @test isidentical(one(a), one(typeof(a)))
        @test isidentical(one(a), big(1.0))
        @test !isidentical(a, b)
        @test isdistinct(a, b)
        @test eps(typeof(a)) === eps(one(typeof(a)))
        @test typemin(typeof(a)) === Interval(-Inf, nextfloat(-Inf))
        @test typemax(typeof(a)) === Interval(prevfloat(Inf), Inf)
        @test typemin(a) === typemin(typeof(a))
        @test typemax(a) === typemax(typeof(a))
        @test typemin(Interval{Int64}) === Interval(typemin(Int64))
        @test typemax(Interval{Int64}) === Interval(typemax(Int64))

        @test isidentical(a, Interval(a.lo, a.hi))
        @test isidentical(@interval(1, Inf), Interval(1.0, Inf))
        @test isidentical(@interval(-Inf, 1), Interval(-Inf, 1.0))
        @test isidentical(@biginterval(1, Inf), Interval{BigFloat}(1.0, Inf))
        @test isidentical(@biginterval(-Inf, 1), Interval{BigFloat}(-Inf, 1.0))
        @test isidentical(@interval(-Inf, Inf), RR(Float64))
        @test isidentical(emptyinterval(Rational{Int}), ∅)

        @test (zero(a) + one(b)).lo == 1
        @test (zero(a) + one(b)).hi == 1
        @test isidentical(Interval(0,1) + emptyinterval(a), emptyinterval(a))
        @test isidentical(@interval(0.25) - one(c)/4, zero(c))
        @test isidentical(emptyinterval(a) - Interval(0,1), emptyinterval(a))
        @test isidentical(Interval(0,1) - emptyinterval(a), emptyinterval(a))
        @test isidentical(a*b, Interval(a.lo*b.lo, a.hi*b.hi))
        @test isidentical(Interval(0,1) * emptyinterval(a), emptyinterval(a))
        @test isidentical(a * Interval(0), zero(a))
    end

    @testset "inv" begin

        @test isidentical(inv( zero(a) ), emptyinterval())  # Only for set based flavor
        @test isidentical(inv( @interval(0, 1) ), Interval(1, Inf))
        @test isidentical(inv( @interval(1, Inf) ), Interval(0, 1))
        @test isidentical(inv(c), c)
        @test isidentical(one(b)/b, inv(b))
        @test isidentical(a/emptyinterval(a), emptyinterval(a))
        @test isidentical(emptyinterval(a)/a, emptyinterval(a))
        @test isidentical(inv(@interval(-4.0,0.0)), @interval(-Inf, -0.25))
        @test isidentical(inv(@interval(0.0,4.0)), @interval(0.25, Inf))
        @test isidentical(inv(@interval(-4.0,4.0)), RR(Float64))
        @test isidentical(@interval(0)/@interval(0), emptyinterval())
        @test typeof(emptyinterval()) == Interval{Float64}
    end

    @testset "fma consistency" begin
        @test isidentical(fma(emptyinterval(), a, b), emptyinterval())
        @test isidentical(fma(RR(), zero(a), b), b)
        @test isidentical(fma(RR(), one(a), b), RR())
        @test isidentical(fma(zero(a), RR(), b), b)
        @test isidentical(fma(one(a), RR(), b), RR())
        @test isidentical(fma(a, zero(a), c), c)
        @test isidentical(fma(Interval(1//2), Interval(1//3), Interval(1//12)), Interval(3//12))
    end

    @testset "∈ tests" begin
        @test !(Inf ∈ RR())
        @test 0.1 ∈ @interval(0.1)
        @test 0.1 in @interval(0.1)
        @test !(-Inf ∈ RR())
        @test !(Inf ∈ RR())

        @test_throws ArgumentError (3..4) ∈ (3..4)
    end

    @testset "Inclusion tests" begin
        @test b ⊆ c
        @test emptyinterval(c) ⊆ c
        @test !(c ⊆ emptyinterval(c))
        @test isinterior(b,c)
        @test !(b ⪽ emptyinterval(b))
        @test emptyinterval(c) ⪽ c
        @test emptyinterval(c) ⪽ emptyinterval(c)
        @test b ⊂ c
        @test !(b ⊂ b)
        @test emptyinterval(c) ⊂ c
        @test !(c ⊂ emptyinterval(c))
        @test c ⊃ b
        @test !(b ⊃ b)
        @test !(emptyinterval(c) ⊃ c)
        @test c ⊃ emptyinterval(c)
        @test c ⊇ b
        @test b ⊇ b
        @test !(emptyinterval(c) ⊇ c)
        @test c ⊇ emptyinterval(c)
        @test isdisjoint(a, @interval(2.1))
        @test !(isdisjoint(a, b))
        @test isdisjoint(emptyinterval(a), a)
        @test isdisjoint(emptyinterval(), emptyinterval())
    end

    @testset "Comparison tests" begin
        @test IntervalArithmetic.islessprime(a.lo, b.lo) == (a.lo < b.lo)
        @test IntervalArithmetic.islessprime(Inf, Inf)
        @test isless(∅, ∅)
        @test !isless(Interval(1.0,2.0), ∅)
        @test isless(Interval(-Inf,Inf), Interval(-Inf,Inf))
        @test precedes(∅,∅)
        @test precedes(Interval(3.0,4.0),∅)
        @test !(precedes(Interval(0.0,2.0),Interval(-Inf,Inf)))
        @test precedes(Interval(1.0,3.0),Interval(3.0,4.0))
        @test strictprecedes(Interval(3.0,4.0),∅)
        @test !(strictprecedes(Interval(-3.0,-1.0),Interval(-1.0,0.0)))
        @test !(iscommon(emptyinterval()))
        @test !(iscommon(RR()))
        @test iscommon(a)
        @test !(isunbounded(emptyinterval()))
        @test isunbounded(RR())
        @test isunbounded(Interval(-Inf, 0.0))
        @test isunbounded(Interval(0.0, Inf))
        @test !(isunbounded(a))
    end

    @testset "Intersection tests" begin
        @test isidentical(emptyinterval(), Interval(Inf, -Inf))
        @test isidentical((a ∩ @interval(-1)), emptyinterval(a))
        @test isempty(a ∩ @interval(-1) )
        @test !(isempty(a))
        @test !isidentical(emptyinterval(a), a)
        @test isidentical(emptyinterval(), emptyinterval())

        @test isidentical(intersect(a, hull(a,b)), a)
        @test isidentical(union(a,b), Interval(a.lo, b.hi))

        # n-ary intersection
        @test intersect(Interval(1.0, 2.0),
                        Interval(-1.0, 5.0),
                        Interval(1.8, 3.0)) == Interval(1.8, 2.0)
        @test isidentical(intersect(a, emptyinterval(), b), emptyinterval())
        @test isidentical(intersect(0..1, 3..4, 0..1, 0..1), emptyinterval())
    end

    @testset "Hull and union tests" begin
        @test isidentical(hull(1..2, 3..4), Interval(1, 4))
        @test isidentical(hull(Interval(1//3, 3//4), Interval(3, 4)), @interval(1/3, 4))

        @test isidentical(union(1..2, 3..4), Interval(1, 4))
        @test isidentical(union(Interval(1//3, 3//4), Interval(3, 4)), @interval(1/3, 4))
    end

    @testset "Special interval tests" begin
        @test isidentical(RR(Float64), Interval(-Inf, Inf))
        @test isentire(RR(a))
        @test isentire(Interval(-Inf, Inf))
        @test !(isentire(a))
        @test Interval(-Inf, Inf) ⪽ Interval(-Inf, Inf)

        @test !(isidentical(nai(a), nai(a)))
        @test nai(a) === nai(a)
        @test nai(Float64) === DecoratedInterval(NaN)
        @test isnan(interval(nai(BigFloat)).lo)
        @test isnai(nai())
        @test !(isnai(a))

        @test inf(a) == a.lo
        @test sup(a) == a.hi
        @test inf(emptyinterval(a)) == Inf
        @test sup(emptyinterval(a)) == -Inf
        @test inf(RR(a)) == -Inf
        @test sup(RR(a)) == Inf
        @test isnan(sup(nai(BigFloat)))
    end

    @testset "mid" begin

        @test mid(Interval(1//2)) == 1//2
        @test mid(1..2) == 1.5
        @test mid(0.1..0.3) == 0.2
        @test mid(-10..5) == -2.5
        @test mid(-∞..1) == nextfloat(-∞)
        @test mid(1..∞) == prevfloat(∞)
        @test isnan(mid(emptyinterval()))
    end

    @testset "scaled mid" begin
        @test scaled_mid(0..1, 0.75) == 0.75
        @test scaled_mid(1..∞, 0.75) > 0
        @test scaled_mid(-∞..∞, 0.75) > 0
        @test scaled_mid(-∞..∞, 0.25) < 0
    end

    @testset "mid with large floats" begin
        @test mid(0.8e308..1.2e308) == 1e308
        @test mid(-1e308..1e308) == 0
        @test isfinite(scaled_mid(0.8e308..1.2e308, 0.75))
        @test isfinite(scaled_mid(-1e308..1e308, 0.75))
    end

    @testset "diam" begin

        @test diam( Interval(1//2) ) == 0//1
        @test diam( @interval(1//10) ) == eps(0.1)
        @test diam( @interval(0.1) ) == eps(0.1)
        @test isnan(diam(emptyinterval()))
        @test diam(a) == 1.0000000000000002
    end

    @testset "mig and mag" begin

        @test mig(@interval(-2,2)) == BigFloat(0.0)
        @test mig( Interval(1//2) ) == 1//2
        @test isnan(mig(emptyinterval()))
        @test mag(-b) == b.hi
        @test mag( Interval(1//2) ) == 1//2
        @test isnan(mag(emptyinterval()))
    end

    @testset "cancelplus tests" begin

        x = Interval(-2.0, 4.440892098500622e-16)
        y = Interval(-4.440892098500624e-16, 2.0)
        @test isidentical(cancelminus(x, y), RR(Float64))
        @test isidentical(cancelplus(x, y), RR(Float64))
        x = Interval(-big(1.0), eps(big(1.0))/4)
        y = Interval(-eps(big(1.0))/2, big(1.0))
        @test isidentical(cancelminus(x, y), RR(BigFloat))
        @test isidentical(cancelplus(x, y), RR(BigFloat))
        x = Interval(-big(1.0), eps(big(1.0))/2)
        y = Interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) ⊆ Interval(-one(BigFloat), one(BigFloat))
        @test isidentical(cancelplus(x, y), Interval(zero(BigFloat), zero(BigFloat)))
        @test isidentical(cancelminus(emptyinterval(), emptyinterval()), emptyinterval())
        @test isidentical(cancelplus(emptyinterval(), emptyinterval()), emptyinterval())
        @test isidentical(cancelminus(emptyinterval(), Interval(0.0, 5.0)), emptyinterval())
        @test isidentical(cancelplus(emptyinterval(), Interval(0.0, 5.0)), emptyinterval())
        @test isidentical(cancelminus(RR(), Interval(0.0, 5.0)), RR())
        @test isidentical(cancelplus(RR(), Interval(0.0, 5.0)), RR())
        @test isidentical(cancelminus(Interval(5.0), Interval(-Inf, 0.0)), RR())
        @test isidentical(cancelplus(Interval(5.0), Interval(-Inf, 0.0)), RR())
        @test isidentical(cancelminus(Interval(0.0, 5.0), emptyinterval()), RR())
        @test isidentical(cancelplus(Interval(0.0, 5.0), emptyinterval()), RR())
        @test isidentical(cancelminus(Interval(0.0), Interval(0.0, 1.0)), RR())
        @test isidentical(cancelplus(Interval(0.0), Interval(0.0, 1.0)), RR())
        @test isidentical(cancelminus(Interval(0.0), Interval(1.0)), Interval(-1.0))
        @test isidentical(cancelplus(Interval(0.0), Interval(1.0)), Interval(1.0))
        @test isidentical(cancelminus(Interval(-5.0, 0.0), Interval(0.0, 5.0)), Interval(-5.0))
        @test isidentical(cancelplus(Interval(-5.0, 0.0), Interval(0.0, 5.0)), Interval(0.0))
    end

    @testset "mid and radius" begin
        @test radius(Interval(-1//10,1//10)) == diam(Interval(-1//10,1//10))/2
        @test isnan(IntervalArithmetic.radius(emptyinterval()))
        @test mid(c) == 2.125
        @test isnan(mid(emptyinterval()))
        @test mid(RR()) == 0.0
        @test isnan(mid(nai()))
        # @test_throws InexactError nai(Interval(1//2)) TODO move this test
    end

    @testset "abs, min, max, sign" begin

        @test isidentical(abs(RR()), Interval(0.0, Inf))
        @test isidentical(abs(emptyinterval()), emptyinterval())
        @test isidentical(abs(Interval(-3.0,1.0)), Interval(0.0, 3.0))
        @test isidentical(abs(Interval(-3.0,-1.0)), Interval(1.0, 3.0))
        @test isidentical(abs2(Interval(-3.0,1.0)), Interval(0.0, 9.0))
        @test isidentical(abs2(Interval(-3.0,-1.0)), Interval(1.0, 9.0))
        @test isidentical(min(RR(), Interval(3.0,4.0)), Interval(-Inf, 4.0))
        @test isidentical(min(emptyinterval(), Interval(3.0,4.0)), emptyinterval())
        @test isidentical(min(Interval(-3.0,1.0), Interval(3.0,4.0)), Interval(-3.0, 1.0))
        @test isidentical(min(Interval(-3.0,-1.0), Interval(3.0,4.0)), Interval(-3.0, -1.0))
        @test isidentical(max(RR(), Interval(3.0,4.0)), Interval(3.0, Inf))
        @test isidentical(max(emptyinterval(), Interval(3.0,4.0)), emptyinterval())
        @test isidentical(max(Interval(-3.0,1.0), Interval(3.0,4.0)), Interval(3.0, 4.0))
        @test isidentical(max(Interval(-3.0,-1.0), Interval(3.0,4.0)), Interval(3.0, 4.0))
        @test isidentical(sign(RR()), Interval(-1.0, 1.0))
        @test isidentical(sign(emptyinterval()), emptyinterval())
        @test isidentical(sign(Interval(-3.0,1.0)), Interval(-1.0, 1.0))
        @test isidentical(sign(Interval(-3.0,-1.0)), Interval(-1.0, -1.0))

        # Test putting functions in @interval:
        @test isidentical(log(@interval(-2,5)), @interval(-Inf,log(5.0)))
        @test isidentical(@interval(sin(0.1) + cos(0.2)), sin(@interval(0.1)) + cos(@interval(0.2)))

        f(x) = 2x
        @test isidentical(@interval(f(0.1)), f(@interval(0.1)))

        # midpoint-radius representation
        a = @interval(0.1)
        midpoint, radius = midpoint_radius(a)

        @test interval_from_midpoint_radius(midpoint, radius) ==
            Interval(0.09999999999999999, 0.10000000000000002)
    end

    # @testset "Interval rounding tests" begin
    #     # setrounding(Interval, :wide)
    #     @test rounding(Interval) == :wide
    #
    #     @test_throws ArgumentError # setrounding(Interval, :hello)
    #
    #     # setrounding(Interval, :narrow)
    #     @test rounding(Interval) == :narrow
    # end

    @testset "Interval power of an interval" begin
        a = @interval(1, 2)
        b = @interval(3, 4)

        @test isidentical(a^b, @interval(1, 16))
        @test isidentical(a^@interval(0.5, 1), a)
        @test isidentical(a^@interval(0.3, 0.5), @interval(1, sqrt(2)))

        @test isidentical(b^@interval(0.3), Interval(1.3903891703159093, 1.5157165665103982))
    end

    @testset "isatomic" begin
        @test isatomic(Interval(1))
        @test isatomic(Interval(2.3, 2.3))
        @test isatomic(emptyinterval())
        @test isatomic(@interval(∞))  # Interval(floatmax(), Inf)

        @test !isatomic(1..2)
        @test !isatomic(Interval(1, nextfloat(1.0, 2)))

    end

    @testset "iszero" begin
        @test iszero(Interval(0))
        @test iszero(Interval(0//1))
        @test iszero(Interval(big(0)))
        @test iszero(Interval(-0.0))
        @test iszero(Interval(-0.0, 0.0))

        @test !iszero(1..2)
        @test !iszero(Interval(0.0, nextfloat(0.0)))
    end

    @testset "Difference between checked and unchecked Intervals" begin
        @test isidentical(Interval(1, 2, check=true), Interval(1, 2))

        @test inf(Interval(3, 2)) == 3
        @test_throws ArgumentError Interval(3, 2, check=true)

        @test sup(Interval(Inf, Inf)) == Inf
        @test_throws ArgumentError Interval(Inf, Inf, check=true)

    end

    @testset "Type stability" begin
        for T in (Float32, Float64, BigFloat)

            xs = [3..4, 0..4, 0..0, -4..0, -4..4, -Inf..4, 4..Inf, -Inf..Inf]

            for x in xs
                for y in xs
                    xx = Interval{T}(x)
                    yy = Interval{T}(y)

                    for op in (+, -, *, /, atan)
                        # @inferred op(x, y)  TODO solve the problem for *
                    end
                end

                for op in (sin, cos, exp, log, tan, abs, mid, diam)
                    @inferred op(x)
                end
            end
        end
    end

end
