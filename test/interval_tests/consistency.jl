# This file is part of the IntervalArithmetic.jl package; MIT licensed

using IntervalArithmetic
if VERSION < v"0.7.0-DEV.2004"
    using Base.Test
else
    using Test
end


setprecision(Interval, Float64)

@testset "Consistency tests" begin

    a = @interval(0.1, 1.1)
    b = @interval(0.9, 2.0)
    c = @interval(0.25, 4.0)

    @testset "Interval types and constructors" begin

        @test isa( @interval(1,2), Interval )
        @test isa( @interval(0.1), Interval )
        @test isa( zero(b), Interval )

        @test zero(b) == 0.0
        @test zero(b) == zero(typeof(b))
        @test one(a) == 1.0
        @test one(a) == one(typeof(a))
        @test one(a) == big(1.0)
        @test !(a == b)
        @test a != b
        @test eps(typeof(a)) === eps(one(typeof(a)))
        @test typemin(typeof(a)) === Interval(-Inf, nextfloat(-Inf))
        @test typemax(typeof(a)) === Interval(prevfloat(Inf), Inf)
        @test typemin(a) === typemin(typeof(a))
        @test typemax(a) === typemax(typeof(a))
        @test typemin(Interval{Int64}) === Interval(typemin(Int64))
        @test typemax(Interval{Int64}) === Interval(typemax(Int64))

        @test a == Interval(a.lo, a.hi)
        @test @interval(1, Inf) == Interval(1.0, Inf)
        @test @interval(-Inf, 1) == Interval(-Inf, 1.0)
        @test @biginterval(1, Inf) == Interval{BigFloat}(1.0, Inf)
        @test @biginterval(-Inf, 1) == Interval{BigFloat}(-Inf, 1.0)
        @test @interval(-Inf, Inf) == entireinterval(Float64)
        @test emptyinterval(Rational{Int}) == ∅

        @test 1 == zero(a)+one(b)
        @test Interval(0,1) + emptyinterval(a) == emptyinterval(a)
        @test @interval(0.25) - one(c)/4 == zero(c)
        @test emptyinterval(a) - Interval(0,1) == emptyinterval(a)
        @test Interval(0,1) - emptyinterval(a) == emptyinterval(a)
        @test a*b == Interval(a.lo*b.lo, a.hi*b.hi)
        @test Interval(0,1) * emptyinterval(a) == emptyinterval(a)
        @test a * Interval(0) == zero(a)
    end

    @testset "inv" begin

        @test inv( zero(a) ) == emptyinterval()
        @test inv( @interval(0, 1) ) == Interval(1, Inf)
        @test inv( @interval(1, Inf) ) == Interval(0, 1)
        @test inv(c) == c
        @test one(b)/b == inv(b)
        @test a/emptyinterval(a) == emptyinterval(a)
        @test emptyinterval(a)/a == emptyinterval(a)
        @test inv(@interval(-4.0,0.0)) == @interval(-Inf, -0.25)
        @test inv(@interval(0.0,4.0)) == @interval(0.25, Inf)
        @test inv(@interval(-4.0,4.0)) == entireinterval(Float64)
        @test @interval(0)/@interval(0) == emptyinterval()
        @test typeof(emptyinterval()) == Interval{Float64}
    end

    @testset "fma consistency" begin
        @test fma(emptyinterval(), a, b) == emptyinterval()
        @test fma(entireinterval(), zero(a), b) == b
        @test fma(entireinterval(), one(a), b) == entireinterval()
        @test fma(zero(a), entireinterval(), b) == b
        @test fma(one(a), entireinterval(), b) == entireinterval()
        @test fma(a, zero(a), c) == c
        @test fma(Interval(1//2), Interval(1//3), Interval(1//12)) == Interval(3//12)
    end

    @testset "∈ tests" begin
        @test !(Inf ∈ entireinterval())
        @test 0.1 ∈ @interval(0.1)
        @test 0.1 in @interval(0.1)
        @test !(-Inf ∈ entireinterval())
        @test !(Inf ∈ entireinterval())
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
        @test ∅ <= ∅
        @test !(Interval(1.0,2.0) <= ∅)
        @test Interval(-Inf,Inf) <= Interval(-Inf,Inf)
        @test !(Interval(-0.0,2.0) ≤ Interval(-Inf,Inf))
        @test precedes(∅,∅)
        @test precedes(Interval(3.0,4.0),∅)
        @test !(precedes(Interval(0.0,2.0),Interval(-Inf,Inf)))
        @test precedes(Interval(1.0,3.0),Interval(3.0,4.0))
        @test strictprecedes(Interval(3.0,4.0),∅)
        @test !(strictprecedes(Interval(-3.0,-1.0),Interval(-1.0,0.0)))
        @test !(iscommon(emptyinterval()))
        @test !(iscommon(entireinterval()))
        @test iscommon(a)
        @test !(isunbounded(emptyinterval()))
        @test isunbounded(entireinterval())
        @test isunbounded(Interval(-Inf, 0.0))
        @test isunbounded(Interval(0.0, Inf))
        @test !(isunbounded(a))
    end

    @testset "Intersection tests" begin
        @test emptyinterval() == Interval(Inf, -Inf)
        @test (a ∩ @interval(-1)) == emptyinterval(a)
        @test isempty(a ∩ @interval(-1) )
        @test !(isempty(a))
        @test !(emptyinterval(a) == a)
        @test emptyinterval() == emptyinterval()

        @test intersect(a, hull(a,b)) == a
        @test union(a,b) == Interval(a.lo, b.hi)
    end

    @testset "Hull and union tests" begin
        @test hull(1..2, 3..4) == Interval(1, 4)
        @test hull(Interval(1//3, 3//4), Interval(3, 4)) == @interval(1/3, 4)

        @test union(1..2, 3..4) == Interval(1, 4)
        @test union(Interval(1//3, 3//4), Interval(3, 4)) == @interval(1/3, 4)
    end

    @testset "Special interval tests" begin

        @test entireinterval(Float64) == Interval(-Inf, Inf)
        @test isentire(entireinterval(a))
        @test isentire(Interval(-Inf, Inf))
        @test !(isentire(a))
        @test Interval(-Inf, Inf) ⪽ Interval(-Inf, Inf)

        @test !(nai(a) == nai(a))
        @test nai(a) === nai(a)
        @test nai(Float64) === Interval(NaN)
        @test isnan(nai(BigFloat).lo)
        @test isnai(nai())
        @test !(isnai(a))

        @test inf(a) == a.lo
        @test sup(a) == a.hi
        @test inf(emptyinterval(a)) == Inf
        @test sup(emptyinterval(a)) == -Inf
        @test inf(entireinterval(a)) == -Inf
        @test sup(entireinterval(a)) == Inf
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

    @testset "mid with parameter" begin
        @test mid(0..1, 0.75) == 0.75
        @test mid(1..∞, 0.75) > 0
        @test mid(-∞..∞, 0.75) > 0
        @test mid(-∞..∞, 0.25) < 0
    end

    @testset "mid with large floats" begin
        @test mid(0.8e308..1.2e308) == 1e308
        @test mid(-1e308..1e308) == 0
        @test isfinite(mid(0.8e308..1.2e308, 0.75))
        @test isfinite(mid(-1e308..1e308, 0.75))
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
        @test cancelminus(x, y) == entireinterval(Float64)
        @test cancelplus(x, y) == entireinterval(Float64)
        x = Interval(-big(1.0), eps(big(1.0))/4)
        y = Interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) == entireinterval(BigFloat)
        @test cancelplus(x, y) == entireinterval(BigFloat)
        x = Interval(-big(1.0), eps(big(1.0))/2)
        y = Interval(-eps(big(1.0))/2, big(1.0))
        @test cancelminus(x, y) ⊆ Interval(-one(BigFloat), one(BigFloat))
        @test cancelplus(x, y) == Interval(zero(BigFloat), zero(BigFloat))
        @test cancelminus(emptyinterval(), emptyinterval()) == emptyinterval()
        @test cancelplus(emptyinterval(), emptyinterval()) == emptyinterval()
        @test cancelminus(emptyinterval(), Interval(0.0, 5.0)) == emptyinterval()
        @test cancelplus(emptyinterval(), Interval(0.0, 5.0)) == emptyinterval()
        @test cancelminus(entireinterval(), Interval(0.0, 5.0)) == entireinterval()
        @test cancelplus(entireinterval(), Interval(0.0, 5.0)) == entireinterval()
        @test cancelminus(Interval(5.0), Interval(-Inf, 0.0)) == entireinterval()
        @test cancelplus(Interval(5.0), Interval(-Inf, 0.0)) == entireinterval()
        @test cancelminus(Interval(0.0, 5.0), emptyinterval()) == entireinterval()
        @test cancelplus(Interval(0.0, 5.0), emptyinterval()) == entireinterval()
        @test cancelminus(Interval(0.0), Interval(0.0, 1.0)) == entireinterval()
        @test cancelplus(Interval(0.0), Interval(0.0, 1.0)) == entireinterval()
        @test cancelminus(Interval(0.0), Interval(1.0)) == Interval(-1.0)
        @test cancelplus(Interval(0.0), Interval(1.0)) == Interval(1.0)
        @test cancelminus(Interval(-5.0, 0.0), Interval(0.0, 5.0)) == Interval(-5.0)
        @test cancelplus(Interval(-5.0, 0.0), Interval(0.0, 5.0)) == Interval(0.0)
    end

    @testset "mid and radius" begin
        @test radius(Interval(-1//10,1//10)) == diam(Interval(-1//10,1//10))/2
        @test isnan(IntervalArithmetic.radius(emptyinterval()))
        @test mid(c) == 2.125
        @test isnan(mid(emptyinterval()))
        @test mid(entireinterval()) == 0.0
        @test isnan(mid(nai()))
        if VERSION < v"0.7.0-DEV"
            @test_throws ArgumentError nai(Interval(1//2))
        else
            @test_throws InexactError nai(Interval(1//2))
        end
    end

    @testset "abs, min, max, sign" begin

        @test abs(entireinterval()) == Interval(0.0, Inf)
        @test abs(emptyinterval()) == emptyinterval()
        @test abs(Interval(-3.0,1.0)) == Interval(0.0, 3.0)
        @test abs(Interval(-3.0,-1.0)) == Interval(1.0, 3.0)
        @test abs2(Interval(-3.0,1.0)) == Interval(0.0, 9.0)
        @test abs2(Interval(-3.0,-1.0)) == Interval(1.0, 9.0)
        @test min(entireinterval(), Interval(3.0,4.0)) == Interval(-Inf, 4.0)
        @test min(emptyinterval(), Interval(3.0,4.0)) == emptyinterval()
        @test min(Interval(-3.0,1.0), Interval(3.0,4.0)) == Interval(-3.0, 1.0)
        @test min(Interval(-3.0,-1.0), Interval(3.0,4.0)) == Interval(-3.0, -1.0)
        @test max(entireinterval(), Interval(3.0,4.0)) == Interval(3.0, Inf)
        @test max(emptyinterval(), Interval(3.0,4.0)) == emptyinterval()
        @test max(Interval(-3.0,1.0), Interval(3.0,4.0)) == Interval(3.0, 4.0)
        @test max(Interval(-3.0,-1.0), Interval(3.0,4.0)) == Interval(3.0, 4.0)
        @test sign(entireinterval()) == Interval(-1.0, 1.0)
        @test sign(emptyinterval()) == emptyinterval()
        @test sign(Interval(-3.0,1.0)) == Interval(-1.0, 1.0)
        @test sign(Interval(-3.0,-1.0)) == Interval(-1.0, -1.0)

        # Test putting functions in @interval:
        @test log(@interval(-2,5)) == @interval(-Inf,log(5.0))
        @test @interval(sin(0.1) + cos(0.2)) == sin(@interval(0.1)) + cos(@interval(0.2))

        f(x) = 2x
        @test @interval(f(0.1)) == f(@interval(0.1))

        # midpoint-radius representation
        a = @interval(0.1)
        midpoint, radius = midpoint_radius(a)

        @test interval_from_midpoint_radius(midpoint, radius) ==
            Interval(0.09999999999999999, 0.10000000000000002)
    end

    @testset "Precision tests" begin
        setprecision(Interval, 100)
        @test precision(Interval) == (BigFloat, 100)

        setprecision(Interval, Float64)
        @test precision(Interval) == (Float64, 100)

        a = @interval(0.1, 0.3)

        b = setprecision(Interval, 64) do
            @interval(0.1, 0.3)
        end

        @test b ⊆ a

        @test precision(Interval) == (Float64, 100)
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

        setprecision(Interval, Float64)

        a = @interval(1, 2)
        b = @interval(3, 4)

        @test a^b == @interval(1, 16)
        @test a^@interval(0.5, 1) == a
        @test a^@interval(0.3, 0.5) == @interval(1, sqrt(2))

        @test b^@interval(0.3) == Interval(1.3903891703159093, 1.5157165665103982)
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

    @testset "Difference between Interval and interval" begin
        @test interval(1, 2) == Interval(1, 2)

        @test inf(Interval(3, 2)) == 3
        @test_throws ArgumentError interval(3, 2)

        @test sup(Interval(Inf, Inf)) == Inf
        @test_throws ArgumentError interval(Inf, Inf)

    end

end
