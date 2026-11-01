using Test
using IntervalArithmetic

@testset "abs on BareInterval" begin
    x = bareinterval(1.0, 2.0)
    @test abs(x) === x
    @test isequal_interval(abs(bareinterval(-3.0, -1.0)), bareinterval(1.0, 3.0))
    @test isequal_interval(abs(bareinterval(-2.0, 1.0)), bareinterval(0.0, 2.0))
    @test isequal_interval(abs(bareinterval(-1.0, 2.0)), bareinterval(0.0, 2.0))

    z = abs(bareinterval(0.0))
    @test isthinzero(z)
    @test signbit(inf(z))
    @test bounds(z)[1] === 0.0

    e = emptyinterval(BareInterval{Float64})
    @test abs(e) === e
    @test isequal_interval(abs(entireinterval(BareInterval{Float64})), bareinterval(0.0, Inf))
    @test isequal_interval(abs(bareinterval(-Inf, -1.0)), bareinterval(1.0, Inf))
    @test isequal_interval(abs(bareinterval(1.0, Inf)), bareinterval(1.0, Inf))

    @test isthin(abs(bareinterval(0.1)), 0.1)
    @test diam(abs(bareinterval(-3.7, -1.2))) == diam(bareinterval(-3.7, -1.2))

    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test numtype(abs(bareinterval(T, -2, 1))) === T
    end
    @test numtype(abs(bareinterval(-1//2, 3//2))) === Rational{Int}
    @test isequal_interval(abs(bareinterval(Rational{Int32}(-1//2), Rational{Int32}(3//2))), bareinterval(Rational{Int32}(0//1), Rational{Int32}(3//2)))

    v = setprecision(() -> 1 + big(2.0)^-400, BigFloat, 512)
    x = setprecision(() -> bareinterval(BigFloat, -v, 0.5), BigFloat, 512)
    @test sup(abs(x)) == v
    @test sup(abs(-x)) == v
    x = setprecision(() -> bareinterval(BigFloat, -v, -0.5), BigFloat, 512)
    @test bounds(abs(x)) == (0.5, v)
    @test precision(sup(abs(x))) == 512
end

@testset "abs on Interval" begin
    r = abs(interval(-2.0, 1.0))
    @test isequal_interval(r, interval(0.0, 2.0))
    @test decoration(r) == com

    @test decoration(abs(interval(-Inf, 1.0))) == dac
    @test decoration(abs(emptyinterval(Interval{Float64}))) == trv
    @test decoration(abs(interval(1.0, 2.0, def))) == def

    @test isguaranteed(abs(interval(1.0)))
    @test !isguaranteed(abs(convert(Interval{Float64}, 1)))

    r = @test_logs (:warn,) abs(nai(Float64))
    @test isnai(r)
    @test decoration(r) == ill

    @test isequal_interval(abs(entireinterval()), interval(0.0, Inf))
    @test isequal_interval(abs(emptyinterval()), emptyinterval())
    @test isequal_interval(abs(interval(-3.0, 1.0)), interval(0.0, 3.0))
    @test isequal_interval(abs(interval(-3.0, -1.0)), interval(1.0, 3.0))
    @test isequal_interval(abs(interval(0.1, 0.2)), interval(0.1, 0.2))
    @test isequal_interval(abs(interval(-1, 2)), interval(0, 2))
end

@testset "abs on Complex" begin
    @test isequal_interval(abs(complex(interval(3.0), interval(4.0))), interval(5.0))
    @test isequal_interval(abs(complex(interval(3.0), interval(4.0))), hypot(interval(3.0), interval(4.0)))
    @test isthinzero(abs(complex(interval(0.0), interval(0.0))))
    @test isempty_interval(abs(complex(emptyinterval(), interval(1.0))))

    x = complex(interval(0, 3), interval(0, 4))
    @test isequal_interval(abs(x), interval(0, 5))
    y = complex(interval(-1, 1), interval(-2, 2))
    @test inf(abs(y)) == 0
end

@testset "abs2" begin
    @test isequal_interval(abs2(bareinterval(-2.0, 1.0)), bareinterval(0.0, 4.0))
    @test isequal_interval(abs2(bareinterval(2.0, 3.0)), bareinterval(4.0, 9.0))
    @test isempty_interval(abs2(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(abs2(entireinterval(BareInterval{Float64})), bareinterval(0.0, Inf))

    x = bareinterval(-2.0, 3.0)
    @test isequal_interval(abs2(x), IntervalArithmetic._select_pown(x, 2))
    @test isequal_interval(IntervalArithmetic._select_pown(IntervalArithmetic.PowerMode{:slow}(), x, 2), pown(x, 2))
    @test isequal_interval(IntervalArithmetic._select_pown(IntervalArithmetic.PowerMode{:fast}(), x, 2), fastpown(x, 2))

    @test decoration(abs2(interval(-Inf, 1.0))) == dac
    @test decoration(abs2(interval(-2.0, 1.0))) == com
    @test decoration(abs2(interval(1.0, 2.0, def))) == def
    @test isguaranteed(abs2(interval(-2.0, 1.0)))
    @test !isguaranteed(abs2(convert(Interval{Float64}, 2)))

    r = @test_logs (:warn,) abs2(nai(Float64))
    @test isnai(r)

    @test isequal_interval(abs2(interval(-3.0, 1.0)), interval(0.0, 9.0))
    @test isequal_interval(abs2(interval(-3.0, -1.0)), interval(1.0, 9.0))

    @test isequal_interval(abs2(complex(interval(1, 2), interval(3, 4))), interval(10, 20))
    x = complex(interval(0, 3), interval(0, 4))
    @test isequal_interval(abs2(x), interval(0, 25))
    y = complex(interval(-1, 1), interval(-2, 2))
    @test inf(abs2(y)) == 0
end

@testset "min and max on BareInterval" begin
    x = bareinterval(1.0, 3.0)
    y = bareinterval(2.0, 4.0)
    @test isequal_interval(min(x, y), bareinterval(1.0, 3.0))
    @test isequal_interval(max(x, y), bareinterval(2.0, 4.0))
    @test isequal_interval(min(x, y), min(y, x))
    @test isequal_interval(max(x, y), max(y, x))
    @test isequal_interval(min(x, x), x)
    @test isequal_interval(max(x, x), x)

    @test isequal_interval(min(bareinterval(1//2, 3//2), bareinterval(1//3, 2//1)), bareinterval(1//3, 3//2))
    @test numtype(min(bareinterval(1//2, 3//2), bareinterval(1//3, 2//1))) === Rational{Int}

    e = emptyinterval(BareInterval{Float64})
    @test min(x, e) === e
    @test max(e, x) === e
    @test typeof(min(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float32}))) === BareInterval{Float64}
    @test isempty_interval(min(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float32})))

    @test typeof(min(bareinterval(1.0f0, 3.0f0), bareinterval(2.0, 4.0))) === BareInterval{Float64}
    @test typeof(max(bareinterval(1.0f0, 3.0f0), bareinterval(2.0, 4.0))) === BareInterval{Float64}

    entire = entireinterval(BareInterval{Float64})
    @test isequal_interval(min(entire, bareinterval(1.0, 2.0)), bareinterval(-Inf, 2.0))
    @test isequal_interval(max(entire, bareinterval(1.0, 2.0)), bareinterval(1.0, Inf))

    @test_throws MethodError min(bareinterval(1.0), 1.0)
    @test_throws MethodError max(bareinterval(1.0), 1.0)
end

@testset "min and max on Interval" begin
    @test decoration(min(interval(1.0, 3.0, dac), interval(2.0, 4.0))) == dac
    @test decoration(max(interval(1.0, 3.0, dac), interval(2.0, 4.0))) == dac
    @test !isguaranteed(min(interval(1.0), convert(Interval{Float64}, 2)))
    @test isguaranteed(min(interval(1.0), interval(2.0)))

    r = @test_logs (:warn,) min(interval(1.0), nai(Float64))
    @test isnai(r)
    r = @test_logs (:warn,) max(nai(Float64), interval(1.0))
    @test isnai(r)

    @test isequal_interval(min(interval(1.0), 2.0), interval(1.0))
    @test !isguaranteed(min(interval(1.0), 2.0))
    @test isequal_interval(max(interval(1.0), 2.0), interval(2.0))
    @test !isguaranteed(max(interval(1.0), 2.0))

    @test typeof(min(interval(Float32, 1), interval(1.0, 2.0))) === Interval{Float64}

    @test isequal_interval(min(entireinterval(), interval(3.0, 4.0)), interval(-Inf, 4.0))
    @test isequal_interval(min(emptyinterval(), interval(3.0, 4.0)), emptyinterval())
    @test isequal_interval(min(interval(-3.0, 1.0), interval(3.0, 4.0)), interval(-3.0, 1.0))
    @test isequal_interval(min(interval(-3.0, -1.0), interval(3.0, 4.0)), interval(-3.0, -1.0))
    @test isequal_interval(max(entireinterval(), interval(3.0, 4.0)), interval(3.0, Inf))
    @test isequal_interval(max(emptyinterval(), interval(3.0, 4.0)), emptyinterval())
    @test isequal_interval(max(interval(-3.0, 1.0), interval(3.0, 4.0)), interval(3.0, 4.0))
    @test isequal_interval(max(interval(-3.0, -1.0), interval(3.0, 4.0)), interval(3.0, 4.0))
end

@testset "docstrings" begin
    meta = Base.Docs.meta(IntervalArithmetic)
    for name ∈ (:abs, :abs2, :min, :max)
        b = Base.Docs.Binding(Base, name)
        @test haskey(meta, b)
        @test any(!isempty(string(ds.text...)) for (_, ds) ∈ meta[b].docs)
    end
end
