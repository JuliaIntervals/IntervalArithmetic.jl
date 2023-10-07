using Test
using IntervalArithmetic
import IntervalArithmetic: unsafe_interval

@testset "Consistency tests" begin

    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)
    c = interval(0.25, 4.0)

    @testset "Interval types and constructors" begin
        @test isa( interval(1, 2), Interval )
        @test isa( interval(0.1), Interval )
        @test isa( zero(b), Interval )

        @test isthin(zero(b), 0.0)
        @test isequal_interval(zero(b), zero(typeof(b)))
        @test isthin(one(a), 1.0)
        @test isequal_interval(one(a), one(typeof(a)))
        @test isthin(one(a), big(1.0))
        @test !isequal_interval(a, b)
        @test isequal_interval(eps(typeof(a)), eps(one(typeof(a))))
        @test isequal_interval(typemin(typeof(a)), interval(-Inf, nextfloat(-Inf)))
        @test isequal_interval(typemax(typeof(a)), interval(prevfloat(Inf), Inf))
        @test isequal_interval(typemin(a), typemin(typeof(a)))
        @test isequal_interval(typemax(a), typemax(typeof(a)))

        @test isequal_interval(a, interval(a.lo, a.hi))
        @test isequal_interval(emptyinterval(Rational{Int}), emptyinterval())

        @test (zero(a) + one(b)).lo == 1
        @test (zero(a) + one(b)).hi == 1
        @test isequal_interval(interval(0,1) + emptyinterval(a), emptyinterval(a))
        @test isequal_interval(interval(0.25) - one(c)/4, zero(c))
        @test isequal_interval(emptyinterval(a) - interval(0, 1), emptyinterval(a))
        @test isequal_interval(interval(0, 1) - emptyinterval(a), emptyinterval(a))
        @test isequal_interval(a*b, interval(*(a.lo, b.lo, RoundDown), *(a.hi, b.hi, RoundUp)))
        @test isequal_interval(interval(0, 1) * emptyinterval(a), emptyinterval(a))
        @test isequal_interval(a * interval(0), zero(a))
    end

    @testset "inv" begin
        @test isequal_interval(inv( zero(a) ), emptyinterval())  # Only for set based flavor
        @test isequal_interval(inv( interval(0, 1) ), interval(1, Inf))
        @test isequal_interval(inv( interval(1, Inf) ), interval(0, 1))
        @test isequal_interval(inv(c), c)
        @test isequal_interval(one(b)/b, inv(b))
        @test isequal_interval(a/emptyinterval(a), emptyinterval(a))
        @test isequal_interval(emptyinterval(a)/a, emptyinterval(a))
        @test isequal_interval(inv(interval(-4.0, 0.0)), interval(-Inf, -0.25))
        @test isequal_interval(inv(interval(0.0, 4.0)), interval(0.25, Inf))
        @test isequal_interval(inv(interval(-4.0, 4.0)), entireinterval(Float64))
        @test isequal_interval(interval(0)/interval(0), emptyinterval())  # According to the standard for :set_based flavor
        @test typeof(emptyinterval()) == Interval{Float64}
    end

    @testset "fma consistency" begin
        @test isequal_interval(fma(emptyinterval(), a, b), emptyinterval())
        @test isequal_interval(fma(entireinterval(), zero(a), b), b)
        @test isequal_interval(fma(entireinterval(), one(a), b), entireinterval())
        @test isequal_interval(fma(zero(a), entireinterval(), b), b)
        @test isequal_interval(fma(one(a), entireinterval(), b), entireinterval())
        @test isequal_interval(fma(a, zero(a), c), c)
        @test isequal_interval(fma(interval(Rational{Int}, 1//2, 1//2),
            interval(Rational{Int}, 1//3, 1//3),
            interval(Rational{Int}, 1//12, 1//12)), interval(Rational{Int}, 3//12, 3//12))
    end

    @testset "in_interval tests" begin
        @test !in_interval(Inf, entireinterval())
        @test in_interval(0.1, I"0.1")
        @test in_interval(0.1, I"0.1")
        @test !in_interval(-Inf, entireinterval())
        @test !in_interval(Inf, entireinterval())

        @test_throws ArgumentError in_interval(interval(3, 4), interval(3, 4))
    end

    @testset "Inclusion tests" begin
        @test issubset_interval(b, c)
        @test issubset_interval(b, b)
        @test issubset_interval(emptyinterval(c), c)
        @test !issubset_interval(c, emptyinterval(c))

        @test isstrictsubset_interval(b, c)
        @test !isstrictsubset_interval(b, b)
        @test isstrictsubset_interval(emptyinterval(c), c)
        @test !isstrictsubset_interval(c, emptyinterval(c))
        @test isstrictsubset_interval(emptyinterval(c), emptyinterval(c))

        @test isdisjoint_interval(a, I"2.1")
        @test !(isdisjoint_interval(a, b))
        @test isdisjoint_interval(emptyinterval(a), a)
        @test isdisjoint_interval(emptyinterval(), emptyinterval())
    end

    @testset "Comparison tests" begin
        @test isweakless(emptyinterval(), emptyinterval())
        @test !isweakless(interval(1, 2), emptyinterval())
        @test isweakless(interval(-Inf,Inf), interval(-Inf,Inf))
        @test precedes(emptyinterval(), emptyinterval())
        @test precedes(interval(3, 4), emptyinterval())
        @test !(precedes(interval(0, 2),interval(-Inf,Inf)))
        @test precedes(interval(1, 3),interval(3, 4))
        @test strictprecedes(interval(3, 4), emptyinterval())
        @test !(strictprecedes(interval(-3, -1),interval(-1, 0)))
        @test !(iscommon(emptyinterval()))
        @test !(iscommon(entireinterval()))
        @test iscommon(a)
        @test !(isunbounded(emptyinterval()))
        @test isunbounded(entireinterval())
        @test isunbounded(interval(-Inf, 0))
        @test isunbounded(interval(0, Inf))
        @test !(isunbounded(a))
    end

    @testset "Intersection tests" begin
        @test isequal_interval(emptyinterval(), interval(Inf, -Inf))
        @test isequal_interval(intersect_interval(a, interval(-1)), emptyinterval(a))
        @test isempty_interval(intersect_interval(a, interval(-1)))
        @test !isempty_interval(a)
        @test !isequal_interval(emptyinterval(a), a)
        @test isequal_interval(emptyinterval(), emptyinterval())

        @test isequal_interval(intersect_interval(a, hull(a,b)), a)
        @test isequal_interval(hull(a,b), interval(a.lo, b.hi))

        # n-ary intersect_interval
        @test isequal_interval(intersect_interval(interval(1.0, 2.0),
                        interval(-1.0, 5.0),
                        interval(1.8, 3.0)), interval(1.8, 2.0))
        @test isequal_interval(intersect_interval(a, emptyinterval(), b), emptyinterval())
        @test isequal_interval(intersect_interval(interval(0, 1), interval(3, 4), interval(0, 1), interval(0, 1)), emptyinterval())
    end

    @testset "hull and hull tests" begin
        @test isequal_interval(hull(interval(1, 2), interval(3, 4)), interval(1, 4))
        @test isequal_interval(hull(interval(1//3, 3//4), interval(3, 4)), interval(1/3, 4))

        @test isequal_interval(hull(interval(1, 2), interval(3, 4)), interval(1, 4))
        @test isequal_interval(hull(interval(1//3, 3//4), interval(3, 4)), interval(1/3, 4))
    end

    @testset "Special interval tests" begin
        @test isequal_interval(entireinterval(Float64), interval(-Inf, Inf))
        @test isentire_interval(entireinterval(a))
        @test isentire_interval(interval(-Inf, Inf))
        @test !isentire_interval(a)
        @test isstrictsubset_interval(interval(-Inf, Inf), interval(-Inf, Inf))

        @test !isequal_interval(nai(a), nai(a))
        @test isnai(DecoratedInterval(NaN))
        @test isnan(interval(nai(BigFloat)).lo)
        @test isnai(nai())
        @test !isnai(a)

        @test inf(a) == a.lo
        @test sup(a) == a.hi
        @test inf(emptyinterval(a)) == Inf
        @test sup(emptyinterval(a)) == -Inf
        @test inf(entireinterval(a)) == -Inf
        @test sup(entireinterval(a)) == Inf
        @test isnan(sup(nai(BigFloat)))

        @test inf(2.5) == 2.5
        @test sup(2.5) == 2.5
    end

    @testset "mid" begin
        @test mid(interval(Rational{Int}, 1//2)) == 1//2
        @test mid(interval(1, 2)) == 1.5
        @test mid(interval(0.1, 0.3)) == 0.2
        @test mid(interval(-10, 5)) == -2.5
        @test mid(interval(-Inf, 1)) == nextfloat(-Inf)
        @test mid(interval(1, Inf)) == prevfloat(Inf)
        @test isnan(mid(emptyinterval()))
    end

    @testset "scaled mid" begin
        @test scaled_mid(interval(0, 1), 0.75) == 0.75
        @test scaled_mid(interval(1, Inf), 0.75) > 0
        @test scaled_mid(interval(-Inf, Inf), 0.75) > 0
        @test scaled_mid(interval(-Inf, Inf), 0.25) < 0
    end

    @testset "mid with large floats" begin
        @test mid(interval(0.8e308, 1.2e308)) == 1e308
        @test mid(interval(-1e308, 1e308)) == 0
        @test isfinite(scaled_mid(interval(0.8e308, 1.2e308), 0.75))
        @test isfinite(scaled_mid(interval(-1e308, 1e308), 0.75))
    end

    @testset "diam" begin
        @test diam( interval(Rational{Int}, 1//2) ) == 0//1
        @test diam( interval(1//10) ) == 0
        @test diam( I"0.1" ) == eps(0.1)
        @test isnan(diam(emptyinterval()))
        @test diam(a) == 1.0000000000000002

        @test diam(0.1) == 0
    end

    @testset "mig and mag" begin
        @test mig(interval(-2, 2)) == BigFloat(0.0)
        @test mig( interval(Rational{Int}, 1//2) ) == 1//2
        @test isnan(mig(emptyinterval()))
        @test mag(-b) == b.hi
        @test mag( interval(Rational{Int}, 1//2) ) == 1//2
        @test isnan(mag(emptyinterval()))
    end

    @testset "cancelplus tests" begin
        x = interval(-2.0, 4.440892098500622e-16)
        y = interval(-4.440892098500624e-16, 2.0)
        @test isequal_interval(cancelminus(x, y), entireinterval(Float64))
        @test isequal_interval(cancelplus(x, y), entireinterval(Float64))
        x = interval(-big(1.0), eps(big(1.0))/4)
        y = interval(-eps(big(1.0))/2, big(1.0))
        @test isequal_interval(cancelminus(x, y), entireinterval(BigFloat))
        @test isequal_interval(cancelplus(x, y), entireinterval(BigFloat))
        x = interval(-big(1.0), eps(big(1.0))/2)
        y = interval(-eps(big(1.0))/2, big(1.0))
        @test issubset_interval(cancelminus(x, y), interval(-one(BigFloat), one(BigFloat)))
        @test isequal_interval(cancelplus(x, y), interval(zero(BigFloat), zero(BigFloat)))
        @test isequal_interval(cancelminus(emptyinterval(), emptyinterval()), emptyinterval())
        @test isequal_interval(cancelplus(emptyinterval(), emptyinterval()), emptyinterval())
        @test isequal_interval(cancelminus(emptyinterval(), interval(0.0, 5.0)), emptyinterval())
        @test isequal_interval(cancelplus(emptyinterval(), interval(0.0, 5.0)), emptyinterval())
        @test isequal_interval(cancelminus(entireinterval(), interval(0.0, 5.0)), entireinterval())
        @test isequal_interval(cancelplus(entireinterval(), interval(0.0, 5.0)), entireinterval())
        @test isequal_interval(cancelminus(interval(5.0), interval(-Inf, 0.0)), entireinterval())
        @test isequal_interval(cancelplus(interval(5.0), interval(-Inf, 0.0)), entireinterval())
        @test isequal_interval(cancelminus(interval(0.0, 5.0), emptyinterval()), entireinterval())
        @test isequal_interval(cancelplus(interval(0.0, 5.0), emptyinterval()), entireinterval())
        @test isequal_interval(cancelminus(interval(0.0), interval(0.0, 1.0)), entireinterval())
        @test isequal_interval(cancelplus(interval(0.0), interval(0.0, 1.0)), entireinterval())
        @test isequal_interval(cancelminus(interval(0.0), interval(1.0)), interval(-1.0))
        @test isequal_interval(cancelplus(interval(0.0), interval(1.0)), interval(1.0))
        @test isequal_interval(cancelminus(interval(-5.0, 0.0), interval(0.0, 5.0)), interval(-5.0))
        @test isequal_interval(cancelplus(interval(-5.0, 0.0), interval(0.0, 5.0)), interval(0.0))
        @test isequal_interval(cancelminus(interval(1e308), -interval(1e308)), IntervalArithmetic.atomic(Float64, Inf))
        @test isequal_interval(cancelplus(interval(1e308), interval(1e308)), IntervalArithmetic.atomic(Float64, Inf))
        @test isequal_interval(cancelminus(interval(nextfloat(1e308)), -interval(nextfloat(1e308))), IntervalArithmetic.atomic(Float64, Inf))
        @test isequal_interval(cancelplus(interval(nextfloat(1e308)), interval(nextfloat(1e308))), IntervalArithmetic.atomic(Float64, Inf))
        @test isequal_interval(cancelminus(interval(prevfloat(big(Inf))), -interval(prevfloat(big(Inf)))), IntervalArithmetic.atomic(BigFloat, Inf))
        @test isequal_interval(cancelplus(interval(prevfloat(big(Inf))), interval(prevfloat(big(Inf)))), IntervalArithmetic.atomic(BigFloat, Inf))
    end

    @testset "mid and radius" begin
        @test radius(interval(Rational{Int}, -1//10,1//10)) == diam(interval(Rational{Int}, -1//10,1//10))/2
        @test isnan(radius(emptyinterval()))
        @test mid(c) == 2.125
        @test isnan(mid(emptyinterval()))
        @test mid(entireinterval()) == 0.0
        @test isnan(mid(nai()))
        # @test_throws InexactError nai(interval(1//2)) TODO move this test

        @test mid(2.125) == 2.125
        @test radius(2.125) == 0
    end

    @testset "abs, min, max, sign" begin
        @test isequal_interval(abs(entireinterval()), interval(0.0, Inf))
        @test isequal_interval(abs(emptyinterval()), emptyinterval())
        @test isequal_interval(abs(interval(-3.0,1.0)), interval(0.0, 3.0))
        @test isequal_interval(abs(interval(-3.0,-1.0)), interval(1.0, 3.0))
        @test isequal_interval(abs2(interval(-3.0,1.0)), interval(0.0, 9.0))
        @test isequal_interval(abs2(interval(-3.0,-1.0)), interval(1.0, 9.0))
        @test isequal_interval(min(entireinterval(), interval(3.0,4.0)), interval(-Inf, 4.0))
        @test isequal_interval(min(emptyinterval(), interval(3.0,4.0)), emptyinterval())
        @test isequal_interval(min(interval(-3.0,1.0), interval(3.0,4.0)), interval(-3.0, 1.0))
        @test isequal_interval(min(interval(-3.0,-1.0), interval(3.0,4.0)), interval(-3.0, -1.0))
        @test isequal_interval(max(entireinterval(), interval(3.0,4.0)), interval(3.0, Inf))
        @test isequal_interval(max(emptyinterval(), interval(3.0,4.0)), emptyinterval())
        @test isequal_interval(max(interval(-3.0,1.0), interval(3.0,4.0)), interval(3.0, 4.0))
        @test isequal_interval(max(interval(-3.0,-1.0), interval(3.0,4.0)), interval(3.0, 4.0))
        @test isequal_interval(sign(entireinterval()), interval(-1.0, 1.0))
        @test isequal_interval(sign(emptyinterval()), emptyinterval())
        @test isequal_interval(sign(interval(-3.0,1.0)), interval(-1.0, 1.0))
        @test isequal_interval(sign(interval(-3.0,-1.0)), interval(-1.0, -1.0))

        # Test putting functions in interval:
        @test issubset_interval(log(interval(-2, 5)), interval(-Inf, log(interval(5))))
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
        a = interval(1, 2)
        b = interval(3, 4)

        @test isequal_interval(a^b, interval(1, 16))
        @test isequal_interval(a^interval(0.5, 1), a)
        @test isequal_interval(a^interval(0.3, 0.5), interval(1, sqrt(2)))
    end

    @testset "isatomic" begin
        @test isatomic(interval(1))
        @test isatomic(interval(2.3, 2.3))
        @test isatomic(emptyinterval())
        @test isatomic(interval(Inf))  # interval(floatmax(), Inf)

        @test !isatomic(interval(1, 2))
        @test !isatomic(interval(1, nextfloat(1.0, 2)))

    end

    @testset "isthinzero" begin
        @test isthinzero(interval(0))
        @test isthinzero(interval(Rational{Int}, 0//1))
        @test isthinzero(interval(big(0)))
        @test isthinzero(interval(-0.0))
        @test isthinzero(interval(-0.0, 0.0))

        @test !isthinzero(interval(1, 2))
        @test !isthinzero(interval(0.0, nextfloat(0.0)))
    end

    @testset "Difference between checked and unchecked Intervals" begin
        @test isequal_interval(unsafe_interval(Float64, 1, 2), interval(Float64, 1, 2))

        @test inf(unsafe_interval(Float64, 3, 2)) == 3
        @test_logs (:warn,) @test isempty_interval(interval(3, 2))

        @test sup(unsafe_interval(Float64, Inf, Inf)) == Inf
        @test_logs (:warn,) @test isempty_interval(interval(Inf, Inf))
    end

    @testset "Type stability" begin
        for T in (Float32, Float64, BigFloat)

            xs = [interval(3, 4), interval(0, 4), interval(0), interval(-4, 0), interval(-4, 4), interval(-Inf, 4), interval(4, Inf), interval(-Inf, Inf)]

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

    @testset "Disallowed `Real` functionalities" begin
        x, y = interval(1), interval(2)
        @test_throws ArgumentError x == y
        @test_throws ArgumentError x < y
        @test_throws ArgumentError isdisjoint(x, y)
        @test_throws ArgumentError issubset(x, y)
        @test_throws ArgumentError issetequal(x, y)
        @test_throws ArgumentError x in y
        @test_throws ArgumentError isempty(x)
        @test_throws ArgumentError isfinite(x)
        @test_throws ArgumentError isnan(x)
        @test_throws ArgumentError isinteger(x)
    end

end
