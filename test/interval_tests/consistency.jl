# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
using Test

@testset "Consistency tests" begin

    a = Interval(0.1, 1.1)
    b = Interval(0.9, 2.0)
    c = Interval(0.25, 4.0)

    @testset "Interval types and constructors" begin
        @test isa( @interval(1,2), Interval )
        @test isa( @interval(0.1), Interval )
        @test isa( zero(b), Interval )

        @test zero(b) ≛ 0.0
        @test zero(b) ≛ zero(typeof(b))
        @test one(a) ≛ 1.0
        @test one(a) ≛ one(typeof(a))
        @test one(a) ≛ big(1.0)
        @test !(a ≛ b)
        @test eps(typeof(a)) === eps(one(typeof(a)))
        @test typemin(typeof(a)) === Interval(-Inf, nextfloat(-Inf))
        @test typemax(typeof(a)) === Interval(prevfloat(Inf), Inf)
        @test typemin(a) === typemin(typeof(a))
        @test typemax(a) === typemax(typeof(a))

        @test a ≛ Interval(a.lo, a.hi)
        @test @interval(1, Inf) ≛ Interval(1.0, Inf)
        @test @interval(-Inf, 1) ≛ Interval(-Inf, 1.0)
        @test @biginterval(1, Inf) ≛ Interval{BigFloat}(1.0, Inf)
        @test @biginterval(-Inf, 1) ≛ Interval{BigFloat}(-Inf, 1.0)
        @test @interval(-Inf, Inf) ≛ RR(Float64)
        @test emptyinterval(Rational{Int}) ≛ ∅

        @test (zero(a) + one(b)).lo == 1
        @test (zero(a) + one(b)).hi == 1
        @test Interval(0,1) + emptyinterval(a) ≛ emptyinterval(a)
        @test Interval(0.25) - one(c)/4 ≛ zero(c)
        @test emptyinterval(a) - Interval(0,1) ≛ emptyinterval(a)
        @test Interval(0,1) - emptyinterval(a) ≛ emptyinterval(a)
        @test a*b ≛ Interval(*(a.lo, b.lo, RoundDown), *(a.hi, b.hi, RoundUp))
        @test Interval(0,1) * emptyinterval(a) ≛ emptyinterval(a)
        @test a * Interval(0) ≛ zero(a)
    end

    @testset "inv" begin
        @test inv( zero(a) ) ≛ emptyinterval()  # Only for set based flavor
        @test inv( Interval(0, 1) ) ≛ Interval(1, Inf)
        @test inv( Interval(1, Inf) ) ≛ Interval(0, 1)
        @test inv(c) ≛ c
        @test one(b)/b ≛ inv(b)
        @test a/emptyinterval(a) ≛ emptyinterval(a)
        @test emptyinterval(a)/a ≛ emptyinterval(a)
        @test inv(Interval(-4.0, 0.0)) ≛ Interval(-Inf, -0.25)
        @test inv(Interval(0.0, 4.0)) ≛ Interval(0.25, Inf)
        @test inv(Interval(-4.0, 4.0)) ≛ RR(Float64)
        @test Interval(0)/Interval(0) ≛ emptyinterval()  # TODO Is this really correct ?
        @test typeof(emptyinterval()) == Interval{Float64}
    end

    @testset "fma consistency" begin
        @test fma(emptyinterval(), a, b) ≛ emptyinterval()
        @test fma(RR(), zero(a), b) ≛ b
        @test fma(RR(), one(a), b) ≛ RR()
        @test fma(zero(a), RR(), b) ≛ b
        @test fma(one(a), RR(), b) ≛ RR()
        @test fma(a, zero(a), c) ≛ c
        @test_broken fma(Interval(1//2), Interval(1//3), Interval(1//12)) ≛ Interval(3//12)
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
        @test IntervalArithmetic.isweaklylessprime(a.lo, b.lo) == (a.lo < b.lo)
        @test IntervalArithmetic.isweaklylessprime(Inf, Inf)
        @test isweaklyless(∅, ∅)
        @test !isweaklyless(Interval(1.0,2.0), ∅)
        @test isweaklyless(Interval(-Inf,Inf), Interval(-Inf,Inf))
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
        @test emptyinterval() ≛ Interval(Inf, -Inf)
        @test (a ∩ @interval(-1)) ≛ emptyinterval(a)
        @test isempty(a ∩ @interval(-1) )
        @test !(isempty(a))
        @test !(emptyinterval(a) ≛ a)
        @test emptyinterval() ≛ emptyinterval()

        @test intersect(a, hull(a,b)) ≛ a
        @test union(a,b) ≛ Interval(a.lo, b.hi)

        # n-ary intersection
        @test intersect(Interval(1.0, 2.0),
                        Interval(-1.0, 5.0),
                        Interval(1.8, 3.0)) ≛ Interval(1.8, 2.0)
        @test intersect(a, emptyinterval(), b) ≛ emptyinterval()
        @test intersect(0..1, 3..4, 0..1, 0..1) ≛ emptyinterval()
    end

    @testset "Hull and union tests" begin
        @test hull(1..2, 3..4) ≛ Interval(1, 4)
        @test hull(Interval(1//3, 3//4), Interval(3, 4)) ≛ @interval(1/3, 4)

        @test union(1..2, 3..4) ≛ Interval(1, 4)
        @test union(Interval(1//3, 3//4), Interval(3, 4)) ≛ @interval(1/3, 4)
    end

    @testset "Special interval tests" begin
        @test RR(Float64) ≛ Interval(-Inf, Inf)
        @test isentire(RR(a))
        @test isentire(Interval(-Inf, Inf))
        @test !(isentire(a))
        @test Interval(-Inf, Inf) ⪽ Interval(-Inf, Inf)

        @test !(nai(a) ≛ nai(a))
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
        @test diam( @interval(0.1) ) == 2eps(0.1)
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
        @test cancelminus(x, y) ≛ RR(Float64)
        @test cancelplus(x, y) ≛ RR(Float64)
        x = Interval(-big(1.0), eps(big(1.0))/4)
        y = Interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) ≛ RR(BigFloat)
        @test cancelplus(x, y) ≛ RR(BigFloat)
        x = Interval(-big(1.0), eps(big(1.0))/2)
        y = Interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) ⊆ Interval(-one(BigFloat), one(BigFloat))
        @test cancelplus(x, y) ≛ Interval(zero(BigFloat), zero(BigFloat))
        @test cancelminus(emptyinterval(), emptyinterval()) ≛ emptyinterval()
        @test cancelplus(emptyinterval(), emptyinterval()) ≛ emptyinterval()
        @test cancelminus(emptyinterval(), Interval(0.0, 5.0)) ≛ emptyinterval()
        @test cancelplus(emptyinterval(), Interval(0.0, 5.0)) ≛ emptyinterval()
        @test cancelminus(RR(), Interval(0.0, 5.0)) ≛ RR()
        @test cancelplus(RR(), Interval(0.0, 5.0)) ≛ RR()
        @test cancelminus(Interval(5.0), Interval(-Inf, 0.0)) ≛ RR()
        @test cancelplus(Interval(5.0), Interval(-Inf, 0.0)) ≛ RR()
        @test cancelminus(Interval(0.0, 5.0), emptyinterval()) ≛ RR()
        @test cancelplus(Interval(0.0, 5.0), emptyinterval()) ≛ RR()
        @test cancelminus(Interval(0.0), Interval(0.0, 1.0)) ≛ RR()
        @test cancelplus(Interval(0.0), Interval(0.0, 1.0)) ≛ RR()
        @test cancelminus(Interval(0.0), Interval(1.0)) ≛ Interval(-1.0)
        @test cancelplus(Interval(0.0), Interval(1.0)) ≛ Interval(1.0)
        @test cancelminus(Interval(-5.0, 0.0), Interval(0.0, 5.0)) ≛ Interval(-5.0)
        @test cancelplus(Interval(-5.0, 0.0), Interval(0.0, 5.0)) ≛ Interval(0.0)
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
        @test abs(RR()) ≛ Interval(0.0, Inf)
        @test abs(emptyinterval()) ≛ emptyinterval()
        @test abs(Interval(-3.0,1.0)) ≛ Interval(0.0, 3.0)
        @test abs(Interval(-3.0,-1.0)) ≛ Interval(1.0, 3.0)
        @test abs2(Interval(-3.0,1.0)) ≛ Interval(0.0, 9.0)
        @test abs2(Interval(-3.0,-1.0)) ≛ Interval(1.0, 9.0)
        @test min(RR(), Interval(3.0,4.0)) ≛ Interval(-Inf, 4.0)
        @test min(emptyinterval(), Interval(3.0,4.0)) ≛ emptyinterval()
        @test min(Interval(-3.0,1.0), Interval(3.0,4.0)) ≛ Interval(-3.0, 1.0)
        @test min(Interval(-3.0,-1.0), Interval(3.0,4.0)) ≛ Interval(-3.0, -1.0)
        @test max(RR(), Interval(3.0,4.0)) ≛ Interval(3.0, Inf)
        @test max(emptyinterval(), Interval(3.0,4.0)) ≛ emptyinterval()
        @test max(Interval(-3.0,1.0), Interval(3.0,4.0)) ≛ Interval(3.0, 4.0)
        @test max(Interval(-3.0,-1.0), Interval(3.0,4.0)) ≛ Interval(3.0, 4.0)
        @test sign(RR()) ≛ Interval(-1.0, 1.0)
        @test sign(emptyinterval()) ≛ emptyinterval()
        @test sign(Interval(-3.0,1.0)) ≛ Interval(-1.0, 1.0)
        @test sign(Interval(-3.0,-1.0)) ≛ Interval(-1.0, -1.0)

        # Test putting functions in @interval:
        @test log(@interval(-2, 5)) ⊆ @interval(-Inf, log(5.0))
        @test @interval(sin(0.1) + cos(0.2)) ≛ sin(@interval(0.1)) + cos(@interval(0.2))

        f(x) = 2x
        @test @interval(f(0.1)) ≛ f(@interval(0.1))
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
        a = Interval(1, 2)
        b = Interval(3, 4)

        @test a^b ≛ Interval(1, 16)
        @test a^Interval(0.5, 1) ≛ a
        @test a^Interval(0.3, 0.5) ≛ Interval(1, sqrt(2))
    end

    @testset "isatomic" begin
        @test isatomic(Interval(1))
        @test isatomic(Interval(2.3, 2.3))
        @test isatomic(emptyinterval())
        @test isatomic(@interval(∞))  # Interval(floatmax(), Inf)

        @test !isatomic(1..2)
        @test !isatomic(Interval(1, nextfloat(1.0, 2)))

    end

    @testset "isthinzero" begin
        @test isthinzero(Interval(0))
        @test isthinzero(Interval(0//1))
        @test isthinzero(Interval(big(0)))
        @test isthinzero(Interval(-0.0))
        @test isthinzero(Interval(-0.0, 0.0))

        @test !isthinzero(1..2)
        @test !isthinzero(Interval(0.0, nextfloat(0.0)))
    end

    @testset "Difference between checked and unchecked Intervals" begin
        @test checked_interval(1, 2) ≛ Interval(1, 2)

        @test inf(Interval(3, 2)) == 3
        @test_logs (:warn,) @test isempty(checked_interval(3, 2))

        @test sup(Interval(Inf, Inf)) == Inf
        @test_logs (:warn,) @test isempty(checked_interval(Inf, Inf))
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
