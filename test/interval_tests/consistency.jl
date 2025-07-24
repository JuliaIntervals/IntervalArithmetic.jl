@test size(interval(1)) == () # match the `size` behaviour of `Real`

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

        @test isequal_interval(a, interval(inf(a), sup(a)))
        @test isequal_interval(emptyinterval(Rational{Int}), emptyinterval())

        @test inf(zero(a) + one(b)) == 1
        @test sup(zero(a) + one(b)) == 1
        @test isequal_interval(interval(0,1) + emptyinterval(a), emptyinterval(a))
        @test isequal_interval(interval(0.25) - one(c)/interval(4), zero(c))
        @test isequal_interval(emptyinterval(a) - interval(0, 1), emptyinterval(a))
        @test isequal_interval(interval(0, 1) - emptyinterval(a), emptyinterval(a))
        @test isequal_interval(interval(0, 1) * emptyinterval(a), emptyinterval(a))
        @test isequal_interval(a * interval(0), zero(a))

        @test decoration(IntervalArithmetic.setdecoration(interval(1, 2), ill)) == ill
        @test decoration(IntervalArithmetic.setdecoration(emptyinterval(), com)) == trv
        @test decoration(IntervalArithmetic.setdecoration(interval(1, Inf), com)) == dac

        @test !isnai(IntervalArithmetic.setdecoration(interval(NaN), com))
        @test decoration(IntervalArithmetic.setdecoration(interval(NaN), com)) == trv
    end

    @testset "real interface" begin
        @test isthinzero(zero(Interval{Float64}))
        @test isthinzero(zero(Complex{Interval{Float64}}))

        @test isthinone(one(Interval{Float64}))
        @test isthinone(one(Complex{Interval{Float64}}))
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

        @test isinterior(b, c)
        @test !isinterior(b, b)
        @test isinterior(emptyinterval(c), c)
        @test !isinterior(c, emptyinterval(c))
        @test isinterior(emptyinterval(c), emptyinterval(c))

        @test isdisjoint_interval(a, I"2.1")
        @test !(isdisjoint_interval(a, b))
        @test isdisjoint_interval(emptyinterval(a), a)
        @test isdisjoint_interval(emptyinterval(), emptyinterval())
        @test !isdisjoint_interval(interval(1, 2), interval(3, 4), interval(5, 6), interval(1, 2))
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
        @test isequal_interval(emptyinterval(BareInterval{Float64}), bareinterval(Inf, -Inf))
        @test isequal_interval(intersect_interval(a, interval(-1)), emptyinterval(a))
        @test isempty_interval(intersect_interval(a, interval(-1)))
        @test !isempty_interval(a)
        @test !isequal_interval(emptyinterval(a), a)
        @test isequal_interval(emptyinterval(), emptyinterval())

        @test isequal_interval(intersect_interval(a, hull(a, b)), a)
        @test isequal_interval(hull(a, b), interval(inf(a), sup(b)))

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
        @test isinterior(interval(-Inf, Inf), interval(-Inf, Inf))

        @test !isequal_interval(nai(a), nai(a))
        @test isnai(interval(NaN)) & isnai(convert(Interval{Float64}, NaN))
        @test isnan(inf(nai(BigFloat)))
        @test isnai(nai())
        @test !isnai(a)

        @test inf(a) == bareinterval(a).lo
        @test sup(a) == bareinterval(a).hi
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
        @test mid(interval(2), 0.4969816845401611) == 2
        @test mid(interval(1, 2)) == 1.5
        @test mid(interval(0.1, 0.3)) == 0.2
        @test mid(interval(-10, 5)) == -2.5
        @test mid(interval(-Inf, 1)) == nextfloat(-Inf)
        @test mid(interval(1, Inf)) == prevfloat(Inf)
        @test isnan(mid(emptyinterval()))
    end

    @testset "mid with α" begin
        @test_throws DomainError mid(interval(1, 2), 1.2)
        @test_throws DomainError mid(interval(1, 2), -0.7)
        @test mid(interval(0, 1), 0.75) == 0.75
        @test mid(interval(0, 1000), 0.125) == 125
        @test mid(interval(1, Inf), 0.75) > 0
        @test mid(interval(-Inf, Inf), 0.75) > 0
        @test mid(interval(-Inf, Inf), 0.25) < 0
    end

    @testset "mid with large floats" begin
        @test mid(interval(0.8e308, 1.2e308)) == 1e308
        @test mid(interval(-1e308, 1e308)) == 0
        @test isfinite(mid(interval(0.8e308, 1.2e308)))
        @test isfinite(mid(interval(-1e308, 1e308)))
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
        @test mag(-b) == sup(b)
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

        #

        x = interval(0, 3) + interval(0, 4)*interval(im)
        @test isequal_interval(abs2(x), interval(0, 25))
        @test isequal_interval(abs(x), interval(0, 5))

        y = interval(-1, 1) + interval(-2, 2)*interval(im)
        @test inf(abs(y)) == 0
        @test inf(abs2(y)) == 0

        @test mag(x) == 5
        @test mig(x) == 0
        @test mid(x) == 1.5 + 2im
    end

    @testset "Interval power of an interval" begin
        a = interval(1, 2)
        b = interval(3, 4)

        @test isequal_interval(pow(a, b), interval(1, 16))
        @test isequal_interval(pow(a, interval(0.5, 1)), a)
        @test isequal_interval(pow(a, interval(0.3, 0.5)), interval(1, sqrt(2)))
    end

    @testset "isatomic" begin
        @test isatomic(interval(1))
        @test isatomic(interval(2.3, 2.3))
        @test isatomic(emptyinterval())
        @test isnai(interval(Inf))

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

    @testset "Type stability" begin
        for T ∈ (Float32, Float64, BigFloat)

            xs = [interval(3, 4), interval(0, 4), interval(0), interval(-4, 0), interval(-4, 4), interval(-Inf, 4), interval(4, Inf), interval(-Inf, Inf)]

            for x ∈ xs
                for y ∈ xs
                    xx = Interval{T}(x)
                    yy = Interval{T}(y)

                    for op ∈ (+, -, *, /, atan)
                        @inferred op(x, y)
                    end
                end

                for op ∈ (sin, cos, exp, log, tan, abs, mid, diam)
                    @inferred op(x)
                end
            end
        end
    end

    @testset "`Real` functionalities" begin
        x, y = interval(1), interval(2)

        @test !isnan(x)

        @test isone(x)
        @test !iszero(x)
        @test_throws ArgumentError iszero(interval(0, 1))
        @test x != y
        @test x == 1
        @test_throws ArgumentError interval(1, 2) != 2
        @test_throws ArgumentError interval(1, 2) != y
        @test_throws ArgumentError y != interval(1, 2)
        @test_throws ArgumentError interval(1, 2) == interval(1, 2)

        @test x < y
        @test x < 2
        @test !(x > y)
        @test !(x < x)
        @test !(x < 1)
        @test_throws ArgumentError x < interval(1, 2)

        @test isfinite(x)
        @test_throws ArgumentError isfinite(interval(1, Inf))

        @test isinteger(x)
        @test !isinteger(interval(1.2, 1.9))
        @test_throws ArgumentError isinteger(interval(1.5, 2.5))

        #

        @test_throws ArgumentError intersect(x, x)
        @test_throws ArgumentError isapprox(x, x)
        @test_throws ArgumentError isdisjoint(x, x)
        @test_throws ArgumentError issubset(x, x)
        @test_throws ArgumentError issetequal(x, x)
        @test_throws ArgumentError x ∈ x
        @test_throws ArgumentError isempty(x)
        @test_throws ArgumentError union(x, x)
        @test_throws ArgumentError setdiff(x, x)
    end

end

@testset "Zero interval" begin
    @test isequal_interval(zero(Interval{Float64}), interval(0))
    @test isequal_interval(zero(interval(0, 1)), interval(0))
end

@testset "Decorations" begin
    a = interval(1, 2)
    b = interval(3, 4)

    @test dist(a, b) == 2.0

    @test isnai(interval(3, 1))
    @test isnai(interval(Inf, Inf))
    @test isnai(interval(-Inf, -Inf))
    @test isnai(interval(NaN, NaN))
    @test isnai(interval(NaN, 3))
    @test isnai(interval(3, NaN))
end

@testset "Hashing of Intervals" begin
    x = interval(Float64, 1, 2)
    y = interval(BigFloat, 1, 2)
    @test isequal_interval(x, y)
    @test hash(x) == hash(y)

    x = I"0.1"
    y = interval(BigFloat, x)
    @test isequal_interval(x, y)
    @test hash(x) == hash(y)

    x = interval(1, 2)
    y = interval(1, 3)
    @test !isequal_interval(x, y)
    @test hash(x) != hash(y)
end

@testset "Complex" begin
    a = interval(1im)
    b = interval(4im + 3)
    c = interval(-1, 4) + interval(0, 2)*interval(im)

    @test isinterior(a, c)
    @test issubset_interval(a, c)
    @test isinterior(a, c)
    @test !isinterior(b, c)
    @test !issubset_interval(b, c)

    @test typeof(a) == Complex{Interval{Float64}}
    @test isequal_interval(a, interval(0) + interval(1)*interval(im))
    @test isequal_interval(a * a, interval(-1))
    @test isequal_interval(a + a, interval(2)*interval(im))
    @test isthinzero(a - a)
    @test isthinone(a / a)

    @test in_interval(3+2im, c)
    @test isequal_interval(hull(a, b), interval(0, 3) + interval(1, 4)*interval(im))
    @test isequal_interval(intersect_interval(c, hull(a, b)), interval(0, 3) + interval(1, 2)*interval(im))
    @test isequal_interval(intersect_interval(a, b), emptyinterval() + emptyinterval()*interval(im))
    @test isdisjoint_interval(a, b)
end
