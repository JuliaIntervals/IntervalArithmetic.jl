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

        @test zero(b) ≛ 0.0
        @test zero(b) ≛ zero(typeof(b))
        @test one(a) ≛ 1.0
        @test one(a) ≛ one(typeof(a))
        @test one(a) ≛ big(1.0)
        @test !(a ≛ b)
        @test eps(typeof(a)) ≛ eps(one(typeof(a)))
        @test typemin(typeof(a)) ≛ interval(-Inf, nextfloat(-Inf))
        @test typemax(typeof(a)) ≛ interval(prevfloat(Inf), Inf)
        @test typemin(a) ≛ typemin(typeof(a))
        @test typemax(a) ≛ typemax(typeof(a))

        @test a ≛ interval(a.lo, a.hi)
        @test emptyinterval(Rational{Int}) ≛ emptyinterval()

        @test (zero(a) + one(b)).lo == 1
        @test (zero(a) + one(b)).hi == 1
        @test interval(0,1) + emptyinterval(a) ≛ emptyinterval(a)
        @test interval(0.25) - one(c)/4 ≛ zero(c)
        @test emptyinterval(a) - interval(0, 1) ≛ emptyinterval(a)
        @test interval(0, 1) - emptyinterval(a) ≛ emptyinterval(a)
        @test a*b ≛ interval(*(a.lo, b.lo, RoundDown), *(a.hi, b.hi, RoundUp))
        @test interval(0, 1) * emptyinterval(a) ≛ emptyinterval(a)
        @test a * interval(0) ≛ zero(a)
    end

    @testset "inv" begin
        @test inv( zero(a) ) ≛ emptyinterval()  # Only for set based flavor
        @test inv( interval(0, 1) ) ≛ interval(1, Inf)
        @test inv( interval(1, Inf) ) ≛ interval(0, 1)
        @test inv(c) ≛ c
        @test one(b)/b ≛ inv(b)
        @test a/emptyinterval(a) ≛ emptyinterval(a)
        @test emptyinterval(a)/a ≛ emptyinterval(a)
        @test inv(interval(-4.0, 0.0)) ≛ interval(-Inf, -0.25)
        @test inv(interval(0.0, 4.0)) ≛ interval(0.25, Inf)
        @test inv(interval(-4.0, 4.0)) ≛ entireinterval(Float64)
        @test interval(0)/interval(0) ≛ emptyinterval()  # According to the standard for :set_based flavor
        @test typeof(emptyinterval()) == Interval{Float64}
    end

    @testset "fma consistency" begin
        @test fma(emptyinterval(), a, b) ≛ emptyinterval()
        @test fma(entireinterval(), zero(a), b) ≛ b
        @test fma(entireinterval(), one(a), b) ≛ entireinterval()
        @test fma(zero(a), entireinterval(), b) ≛ b
        @test fma(one(a), entireinterval(), b) ≛ entireinterval()
        @test fma(a, zero(a), c) ≛ c
        @test fma(interval(Rational{Int}, 1//2, 1//2),
            interval(Rational{Int}, 1//3, 1//3),
            interval(Rational{Int}, 1//12, 1//12)) ≛ interval(Rational{Int}, 3//12, 3//12)
    end

    @testset "∈ tests" begin
        @test !(Inf ∈ entireinterval())
        @test 0.1 ∈ I"0.1"
        @test 0.1 ∈ I"0.1"
        @test !(-Inf ∈ entireinterval())
        @test !(Inf ∈ entireinterval())

        @test_throws ArgumentError interval(3, 4) ∈ interval(3, 4)
    end

    @testset "Inclusion tests" begin
        @test b ⊆ c
        @test emptyinterval(c) ⊆ c
        @test !(c ⊆ emptyinterval(c))
        @test isinterior(b,c)
        @test !isinterior(b, emptyinterval(b))
        @test isinterior(emptyinterval(c), c)
        @test isinterior(emptyinterval(c), emptyinterval(c))
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
        @test isdisjoint(a, I"2.1")
        @test !(isdisjoint(a, b))
        @test isdisjoint(emptyinterval(a), a)
        @test isdisjoint(emptyinterval(), emptyinterval())
    end

    @testset "Comparison tests" begin
        @test IntervalArithmetic.isweaklylessprime(a.lo, b.lo) == (a.lo < b.lo)
        @test IntervalArithmetic.isweaklylessprime(Inf, Inf)
        @test isweaklyless(emptyinterval(), emptyinterval())
        @test !isweaklyless(interval(1, 2), emptyinterval())
        @test isweaklyless(interval(-Inf,Inf), interval(-Inf,Inf))
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
        @test emptyinterval() ≛ interval(Inf, -Inf)
        @test (a ∩ interval(-1)) ≛ emptyinterval(a)
        @test isempty(a ∩ interval(-1))
        @test !(isempty(a))
        @test !(emptyinterval(a) ≛ a)
        @test emptyinterval() ≛ emptyinterval()

        @test intersect(a, hull(a,b)) ≛ a
        @test union(a,b) ≛ interval(a.lo, b.hi)

        # n-ary intersection
        @test intersect(interval(1.0, 2.0),
                        interval(-1.0, 5.0),
                        interval(1.8, 3.0)) ≛ interval(1.8, 2.0)
        @test intersect(a, emptyinterval(), b) ≛ emptyinterval()
        @test intersect(interval(0, 1), interval(3, 4), interval(0, 1), interval(0, 1)) ≛ emptyinterval()
    end

    @testset "Hull and union tests" begin
        @test hull(interval(1, 2), interval(3, 4)) ≛ interval(1, 4)
        @test hull(interval(1//3, 3//4), interval(3, 4)) ≛ interval(1/3, 4)

        @test union(interval(1, 2), interval(3, 4)) ≛ interval(1, 4)
        @test union(interval(1//3, 3//4), interval(3, 4)) ≛ interval(1/3, 4)
    end

    @testset "Special interval tests" begin
        @test entireinterval(Float64) ≛ interval(-Inf, Inf)
        @test isentire(entireinterval(a))
        @test isentire(interval(-Inf, Inf))
        @test !(isentire(a))
        @test isinterior(interval(-Inf, Inf), interval(-Inf, Inf))

        @test !(nai(a) ≛ nai(a))
        @test nai(Float64) ≛ DecoratedInterval(NaN)
        @test isnan(interval(nai(BigFloat)).lo)
        @test isnai(nai())
        @test !(isnai(a))

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
        @test cancelminus(x, y) ≛ entireinterval(Float64)
        @test cancelplus(x, y) ≛ entireinterval(Float64)
        x = interval(-big(1.0), eps(big(1.0))/4)
        y = interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) ≛ entireinterval(BigFloat)
        @test cancelplus(x, y) ≛ entireinterval(BigFloat)
        x = interval(-big(1.0), eps(big(1.0))/2)
        y = interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) ⊆ interval(-one(BigFloat), one(BigFloat))
        @test cancelplus(x, y) ≛ interval(zero(BigFloat), zero(BigFloat))
        @test cancelminus(emptyinterval(), emptyinterval()) ≛ emptyinterval()
        @test cancelplus(emptyinterval(), emptyinterval()) ≛ emptyinterval()
        @test cancelminus(emptyinterval(), interval(0.0, 5.0)) ≛ emptyinterval()
        @test cancelplus(emptyinterval(), interval(0.0, 5.0)) ≛ emptyinterval()
        @test cancelminus(entireinterval(), interval(0.0, 5.0)) ≛ entireinterval()
        @test cancelplus(entireinterval(), interval(0.0, 5.0)) ≛ entireinterval()
        @test cancelminus(interval(5.0), interval(-Inf, 0.0)) ≛ entireinterval()
        @test cancelplus(interval(5.0), interval(-Inf, 0.0)) ≛ entireinterval()
        @test cancelminus(interval(0.0, 5.0), emptyinterval()) ≛ entireinterval()
        @test cancelplus(interval(0.0, 5.0), emptyinterval()) ≛ entireinterval()
        @test cancelminus(interval(0.0), interval(0.0, 1.0)) ≛ entireinterval()
        @test cancelplus(interval(0.0), interval(0.0, 1.0)) ≛ entireinterval()
        @test cancelminus(interval(0.0), interval(1.0)) ≛ interval(-1.0)
        @test cancelplus(interval(0.0), interval(1.0)) ≛ interval(1.0)
        @test cancelminus(interval(-5.0, 0.0), interval(0.0, 5.0)) ≛ interval(-5.0)
        @test cancelplus(interval(-5.0, 0.0), interval(0.0, 5.0)) ≛ interval(0.0)
        @test cancelminus(interval(1e308), -interval(1e308)) ≛ IntervalArithmetic.atomic(Float64, Inf)
        @test cancelplus(interval(1e308), interval(1e308)) ≛ IntervalArithmetic.atomic(Float64, Inf)
        @test cancelminus(interval(nextfloat(1e308)), -interval(nextfloat(1e308))) ≛ IntervalArithmetic.atomic(Float64, Inf)
        @test cancelplus(interval(nextfloat(1e308)), interval(nextfloat(1e308))) ≛ IntervalArithmetic.atomic(Float64, Inf)
        @test cancelminus(interval(prevfloat(big(Inf))), -interval(prevfloat(big(Inf)))) ≛ IntervalArithmetic.atomic(BigFloat, Inf)
        @test cancelplus(interval(prevfloat(big(Inf))), interval(prevfloat(big(Inf)))) ≛ IntervalArithmetic.atomic(BigFloat, Inf)
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
        @test abs(entireinterval()) ≛ interval(0.0, Inf)
        @test abs(emptyinterval()) ≛ emptyinterval()
        @test abs(interval(-3.0,1.0)) ≛ interval(0.0, 3.0)
        @test abs(interval(-3.0,-1.0)) ≛ interval(1.0, 3.0)
        @test abs2(interval(-3.0,1.0)) ≛ interval(0.0, 9.0)
        @test abs2(interval(-3.0,-1.0)) ≛ interval(1.0, 9.0)
        @test min(entireinterval(), interval(3.0,4.0)) ≛ interval(-Inf, 4.0)
        @test min(emptyinterval(), interval(3.0,4.0)) ≛ emptyinterval()
        @test min(interval(-3.0,1.0), interval(3.0,4.0)) ≛ interval(-3.0, 1.0)
        @test min(interval(-3.0,-1.0), interval(3.0,4.0)) ≛ interval(-3.0, -1.0)
        @test max(entireinterval(), interval(3.0,4.0)) ≛ interval(3.0, Inf)
        @test max(emptyinterval(), interval(3.0,4.0)) ≛ emptyinterval()
        @test max(interval(-3.0,1.0), interval(3.0,4.0)) ≛ interval(3.0, 4.0)
        @test max(interval(-3.0,-1.0), interval(3.0,4.0)) ≛ interval(3.0, 4.0)
        @test sign(entireinterval()) ≛ interval(-1.0, 1.0)
        @test sign(emptyinterval()) ≛ emptyinterval()
        @test sign(interval(-3.0,1.0)) ≛ interval(-1.0, 1.0)
        @test sign(interval(-3.0,-1.0)) ≛ interval(-1.0, -1.0)

        # Test putting functions in interval:
        @test log(interval(-2, 5)) ⊆ interval(-Inf, log(interval(5)))
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

        @test a^b ≛ interval(1, 16)
        @test a^interval(0.5, 1) ≛ a
        @test a^interval(0.3, 0.5) ≛ interval(1, sqrt(2))
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
        @test unsafe_interval(Float64, 1, 2) ≛ interval(Float64, 1, 2)

        @test inf(unsafe_interval(Float64, 3, 2)) == 3
        @test_logs (:warn,) @test isempty(interval(3, 2))

        @test sup(unsafe_interval(Float64, Inf, Inf)) == Inf
        @test_logs (:warn,) @test isempty(interval(Inf, Inf))
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

end
