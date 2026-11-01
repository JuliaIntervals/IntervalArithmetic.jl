using Test
using IntervalArithmetic

@testset "sign" begin
    @test isequal_interval(sign(bareinterval(-2.0, 3.0)), bareinterval(-1.0, 1.0))
    @test isequal_interval(sign(bareinterval(0.0, 3.0)), bareinterval(0.0, 1.0))
    @test isthin(sign(bareinterval(-3.0, -1.0)), -1.0)
    @test isthinzero(sign(bareinterval(0.0)))
    @test isempty_interval(sign(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(sign(entireinterval(BareInterval{Float64})), bareinterval(-1.0, 1.0))

    @test isequal_interval(sign(bareinterval(-1//2, 3//2)), bareinterval(-1//1, 1//1))
    @test numtype(sign(bareinterval(-1//2, 3//2))) === Rational{Int}

    @test decoration(sign(interval(1.0, 3.0))) == com
    @test decoration(sign(interval(-2.0, 3.0))) == def
    @test decoration(sign(interval(0.0, 3.0))) == def
    @test decoration(sign(interval(1.0, 3.0, def))) == def
    @test decoration(sign(emptyinterval(Interval{Float64}))) == trv
    @test isguaranteed(sign(interval(1.0)))
    @test !isguaranteed(sign(convert(Interval{Float64}, 1)))
    r = @test_logs (:warn,) sign(nai(Float64))
    @test isnai(r)

    @test isequal_interval(sign(entireinterval()), interval(-1.0, 1.0))
    @test isequal_interval(sign(emptyinterval()), emptyinterval())
    @test isequal_interval(sign(interval(-3.0, 1.0)), interval(-1.0, 1.0))
    @test isequal_interval(sign(interval(-3.0, -1.0)), interval(-1.0, -1.0))
    @test isequal_interval(sign(interval(0.1, 1.1)), interval(1.0))
end

@testset "ceil, floor and trunc" begin
    @test isequal_interval(ceil(bareinterval(-1.5, 2.5)), bareinterval(-1.0, 3.0))
    @test isequal_interval(floor(bareinterval(-1.5, 2.5)), bareinterval(-2.0, 2.0))
    @test isequal_interval(trunc(bareinterval(-1.5, 2.5)), bareinterval(-1.0, 2.0))
    @test isequal_interval(ceil(bareinterval(2.0, 3.0)), bareinterval(2.0, 3.0))

    for f ∈ (ceil, floor, trunc)
        @test isempty_interval(f(emptyinterval(BareInterval{Float64})))
        @test isentire_interval(f(entireinterval(BareInterval{Float64})))
    end

    @test isequal_interval(ceil(bareinterval(-1//2, 3//2)), bareinterval(0//1, 2//1))
    @test numtype(ceil(bareinterval(-1//2, 3//2))) === Rational{Int}
    @test isequal_interval(floor(bareinterval(-1//2, 3//2)), bareinterval(-1//1, 1//1))
    @test isequal_interval(trunc(bareinterval(-1//2, 3//2)), bareinterval(0//1, 1//1))

    @test decoration(ceil(interval(1.5, 2.0))) == dac
    @test decoration(ceil(interval(2.0, 2.0))) == dac
    @test decoration(ceil(interval(-1.5, 2.5))) == def
    @test decoration(ceil(interval(1.2, 1.8))) == com

    @test decoration(floor(interval(1.2, 1.8))) == com
    @test decoration(floor(interval(1.5, 2.0))) == def
    @test decoration(floor(interval(-1.5, 2.5))) == def

    @test decoration(trunc(interval(-2.0, -1.5))) == def
    @test decoration(trunc(interval(0.5, 0.9))) == com
    @test decoration(trunc(interval(-1.5, 2.5))) == def

    for f ∈ (ceil, floor, trunc)
        @test decoration(f(emptyinterval(Interval{Float64}))) == trv
        @test decoration(f(entireinterval())) == def
        @test isguaranteed(f(interval(1.2, 1.8)))
        @test !isguaranteed(f(convert(Interval{Float64}, 1)))
        r = @test_logs (:warn,) f(nai(Float64))
        @test isnai(r)
    end

    @test isequal_interval(floor(interval(0.1, 1.1)), interval(0, 1))
    @test isequal_interval(ceil(interval(0.1, 1.1)), interval(1, 2))
    @test isequal_interval(trunc(interval(0.1, 1.1)), interval(0.0, 1.0))

    w, n = setprecision(BigFloat, 512) do
        return big(2.0)^300 + 1 + big(2.0)^-100, big(2.0)^300 + 1
    end
    x = setprecision(() -> bareinterval(BigFloat, w), BigFloat, 512)
    @test inf(floor(x)) == sup(floor(x)) == n
    @test inf(ceil(x)) == sup(ceil(x)) == setprecision(() -> n + 1, BigFloat, 512)
    @test inf(trunc(x)) == sup(trunc(x)) == n
    @test inf(floor(-x)) == setprecision(() -> -n - 1, BigFloat, 512)
    @test inf(trunc(-x)) == setprecision(() -> -n, BigFloat, 512)
end

@testset "round" begin
    for x ∈ (bareinterval(-1.5, 2.5), bareinterval(0.1, 1.1), interval(-1.5, 2.5), interval(0.1, 1.1))
        @test isequal_interval(round(x), round(x, RoundNearest))
    end
    for x ∈ (bareinterval(-1.5, 2.5), interval(-1.5, 2.5), interval(0.5, 0.9, def))
        @test round(x, RoundToZero) === trunc(x)
        @test round(x, RoundUp) === ceil(x)
        @test round(x, RoundDown) === floor(x)
    end

    @test isequal_interval(round(bareinterval(-1.5, 2.5), RoundNearest), bareinterval(-2.0, 2.0))
    @test isequal_interval(round(bareinterval(-1.5, 2.5), RoundNearestTiesAway), bareinterval(-2.0, 3.0))
    @test isequal_interval(round(bareinterval(1.2, 1.8), RoundNearest), bareinterval(1.0, 2.0))
    for mode ∈ (RoundNearest, RoundNearestTiesAway, RoundToZero, RoundUp, RoundDown)
        @test isempty_interval(round(emptyinterval(BareInterval{Float64}), mode))
    end

    @test isequal_interval(round(bareinterval(-1//2, 3//2)), bareinterval(0//1, 2//1))
    @test numtype(round(bareinterval(-1//2, 3//2))) === Rational{Int}

    @test decoration(round(interval(0.5, 0.7))) == def
    @test decoration(round(interval(-1.5, 2.5))) == def
    @test decoration(round(interval(1.2, 1.8))) == def
    @test decoration(round(interval(1.2, 1.4))) == com
    @test decoration(round(interval(1.2, 1.4), RoundNearestTiesAway)) == com
    @test isguaranteed(round(interval(1.2, 1.8)))
    @test !isguaranteed(round(convert(Interval{Float64}, 1)))
    r = @test_logs (:warn,) round(nai(Float64))
    @test isnai(r)
    r = @test_logs (:warn,) round(nai(Float64), RoundNearestTiesAway)
    @test isnai(r)

    @test isequal_interval(round(interval(0.1, 1.1), RoundDown), interval(0, 1))
    @test isequal_interval(round(interval(0.1, 1.1), RoundUp), interval(1, 2))
    @test isequal_interval(round(interval(0.1, 1.1), RoundToZero), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.1)), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.5)), interval(0.0, 2.0))
    @test isequal_interval(round(interval(-1.5, 0.1)), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(-2.5, 0.1)), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(0.1, 1.1), RoundNearest), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.5), RoundNearest), interval(0.0, 2.0))
    @test isequal_interval(round(interval(-1.5, 0.1), RoundNearest), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(-2.5, 0.1), RoundNearest), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(0.1, 1.1), RoundNearestTiesAway), interval(0.0, 1.0))
    @test isequal_interval(round(interval(0.1, 1.5), RoundNearestTiesAway), interval(0.0, 2.0))
    @test isequal_interval(round(interval(-1.5, 0.1), RoundNearestTiesAway), interval(-2.0, 0.0))
    @test isequal_interval(round(interval(-2.5, 0.1), RoundNearestTiesAway), interval(-3.0, 0.0))

    w, n = setprecision(BigFloat, 512) do
        return big(2.0)^300 + 1 + big(2.0)^-100, big(2.0)^300 + 1
    end
    x = setprecision(() -> bareinterval(BigFloat, w), BigFloat, 512)
    @test inf(round(x)) == sup(round(x)) == n
    @test inf(round(x, RoundNearestTiesAway)) == n
    x = setprecision(() -> interval(BigFloat, big(0.5) + big(2.0)^-300), BigFloat, 512)
    @test decoration(round(x)) == com
end

@testset "numtype stability" begin
    for T ∈ (Float16, Float32, BigFloat)
        x = bareinterval(T, 3//2, 5//2)
        for f ∈ (sign, ceil, floor, trunc, round)
            @test numtype(f(x)) === T
        end
        @test numtype(round(x, RoundNearestTiesAway)) === T
    end
end

@testset "point enclosure" begin
    for x ∈ (bareinterval(-2.6, 3.2), bareinterval(0.1, 1.1))
        for t ∈ range(inf(x), sup(x); length = 9)
            @test in_interval(sign(t), sign(x))
            @test in_interval(ceil(t), ceil(x))
            @test in_interval(floor(t), floor(x))
            @test in_interval(trunc(t), trunc(x))
            @test in_interval(round(t), round(x))
            @test in_interval(round(t, RoundNearestTiesAway), round(x, RoundNearestTiesAway))
        end
    end
end
