using Test
using IntervalArithmetic

@testset "unary plus and minus" begin
    for x ∈ (bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))
        @test +x === x
    end
    for x ∈ (interval(1.0, 2.0), emptyinterval(), entireinterval())
        @test +x === x
    end

    @test isequal_interval(-bareinterval(0.0, 1.0), bareinterval(-1.0, 0.0))
    @test isempty_interval(-emptyinterval(BareInterval{Float64}))
    @test isentire_interval(-entireinterval(BareInterval{Float64}))

    r = -interval(1.0, 2.0, def)
    @test isequal_interval(r, interval(-2.0, -1.0))
    @test decoration(r) == def
    @test isguaranteed(-interval(1.0))
    @test !isguaranteed(-convert(Interval{Float64}, 1))

    a = interval(0.1, 1.1)
    @test isequal_interval(+a, a)
    @test isequal_interval(-a, interval(-sup(a), -inf(a)))

    v = setprecision(() -> 1 + big(2.0)^-400, BigFloat, 512)
    r = -setprecision(() -> bareinterval(BigFloat, v), BigFloat, 512)
    @test precision(inf(r)) == precision(sup(r)) == 512
    @test inf(r) == sup(r) == setprecision(() -> -v, BigFloat, 512)
end

@testset "addition" begin
    @test bounds(bareinterval(0.1) + bareinterval(0.2)) == (0.3, 0.30000000000000004)
    @test sup(bareinterval(0.1) + bareinterval(0.2)) == 0.1 + 0.2
    @test isempty_interval(emptyinterval(BareInterval{Float64}) + bareinterval(1.0))
    @test isempty_interval(bareinterval(1.0) + emptyinterval(BareInterval{Float64}))
    @test isentire_interval(entireinterval(BareInterval{Float64}) + bareinterval(1.0))
    @test isequal_interval(bareinterval(1.0, Inf) + bareinterval(1.0, 2.0), bareinterval(2.0, Inf))
    @test typeof(bareinterval(1.0f0) + bareinterval(1.0)) === BareInterval{Float64}
    @test isequal_interval(bareinterval(1//2) + bareinterval(1//3), bareinterval(5//6))
    @test numtype(bareinterval(1//2) + bareinterval(1//3)) === Rational{Int}

    setprecision(BigFloat, 128) do
        x = bareinterval(BigFloat, 1) / bareinterval(BigFloat, 3)
        y = x + x
        @test precision(inf(y)) == 128
        @test inf(y) < 2//3 < sup(y)
        @test sup(y) == nextfloat(inf(y))
    end

    @test decoration(interval(1.0, Inf) + interval(1.0)) == dac
    @test decoration(interval(1.0, 2.0, def) + interval(1.0, 2.0)) == def
    @test isguaranteed(interval(1.0) + interval(2.0))
    @test !isguaranteed(interval(1.0) + 1)

    r = @test_logs (:warn,) interval(1.0) + nai(Float64)
    @test isnai(r)
    r = interval(1.0) + emptyinterval()
    @test isempty_interval(r)
    @test decoration(r) == trv

    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)
    @test inf(zero(a) + one(b)) == 1
    @test sup(zero(a) + one(b)) == 1
    @test isequal_interval(interval(0, 1) + emptyinterval(a), emptyinterval(a))
    @test isequal_interval(interval(Rational{Int}, 1//4, 1//2) + interval(Rational{Int}, 2//3), interval(Rational{Int}, 11//12, 7//6))
end

@testset "subtraction" begin
    @test isequal_interval(bareinterval(1.0, 2.0) - bareinterval(1.0, 2.0), bareinterval(-1.0, 1.0))
    @test isempty_interval(bareinterval(1.0) - emptyinterval(BareInterval{Float64}))
    @test isempty_interval(emptyinterval(BareInterval{Float64}) - bareinterval(1.0))
    @test typeof(bareinterval(1.0f0) - bareinterval(1.0)) === BareInterval{Float64}
    @test isequal_interval(bareinterval(1//2) - bareinterval(1//3), bareinterval(1//6))

    @test decoration(interval(1.0, 2.0, def) - interval(1.0)) == def
    @test decoration(interval(1.0, Inf) - interval(1.0)) == dac
    @test !isguaranteed(interval(1.0) - convert(Interval{Float64}, 1))

    a = interval(0.1, 1.1)
    c = interval(0.25, 4.0)
    @test isequal_interval(interval(0.25) - one(c) / interval(4), zero(c))
    @test isequal_interval(emptyinterval(a) - interval(0, 1), emptyinterval(a))
    @test isequal_interval(interval(0, 1) - emptyinterval(a), emptyinterval(a))
    @test isequal_interval(interval(Rational{Int}, 1//4, 1//2) - interval(Rational{Int}, 2//3), interval(Rational{Int}, -5//12, -1//6))
    @test isequal_interval(interval(1//3, 1//3) - interval(1//1), interval(-2//3, -2//3))
end

@testset "multiplication" begin
    p = bareinterval(1.0, 2.0)
    n = bareinterval(-2.0, -1.0)
    m = bareinterval(-1.0, 2.0)
    @test isequal_interval(p * p, bareinterval(1.0, 4.0))
    @test isequal_interval(p * n, bareinterval(-4.0, -1.0))
    @test isequal_interval(p * m, bareinterval(-2.0, 4.0))
    @test isequal_interval(n * p, bareinterval(-4.0, -1.0))
    @test isequal_interval(n * n, bareinterval(1.0, 4.0))
    @test isequal_interval(n * m, bareinterval(-4.0, 2.0))
    @test isequal_interval(m * p, bareinterval(-2.0, 4.0))
    @test isequal_interval(m * n, bareinterval(-4.0, 2.0))
    @test isequal_interval(m * m, bareinterval(-2.0, 4.0))

    @test isequal_interval(bareinterval(0.1) * bareinterval(0.1), bareinterval(0.01, 0.010000000000000002))

    @test isthinzero(bareinterval(0.0) * entireinterval(BareInterval{Float64}))
    @test isthinzero(entireinterval(BareInterval{Float64}) * bareinterval(0.0))

    @test isequal_interval(bareinterval(0.0, 1.0) * bareinterval(1.0, Inf), bareinterval(0.0, Inf))
    @test isequal_interval(bareinterval(-Inf, 0.0) * bareinterval(0.0, Inf), bareinterval(-Inf, 0.0))
    @test isequal_interval(bareinterval(-Inf, -1.0) * bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0))
    @test isentire_interval(entireinterval(BareInterval{Float64}) * entireinterval(BareInterval{Float64}))
    @test isequal_interval(bareinterval(0.0, Inf) * bareinterval(0.0, Inf), bareinterval(0.0, Inf))

    @test isempty_interval(emptyinterval(BareInterval{Float64}) * bareinterval(0.0))
    @test isempty_interval(bareinterval(0.0) * emptyinterval(BareInterval{Float64}))

    @test IntervalArithmetic._unbounded_mul(0.0, Inf, RoundDown) == 0.0
    @test IntervalArithmetic._unbounded_mul(Inf, 0.0, RoundUp) == 0.0
    @test IntervalArithmetic._unbounded_mul(0.0, -Inf, RoundUp) === -0.0
    @test IntervalArithmetic._unbounded_mul(-2.0, Inf, RoundDown) == -Inf

    for x ∈ (p, n, m), y ∈ (p, n, m)
        @test isequal_interval(IntervalArithmetic._mult(*, x, y), IntervalArithmetic._mult(IntervalArithmetic._unbounded_mul, x, y))
    end

    @test typeof(bareinterval(1.0f0) * bareinterval(1.0)) === BareInterval{Float64}
    @test isequal_interval(bareinterval(1//2) * bareinterval(1//3), bareinterval(1//6))

    @test decoration(interval(1.0, 2.0) * interval(1.0, Inf)) == dac
    @test decoration(interval(1.0, 2.0, def) * interval(1.0)) == def
    @test !isguaranteed(interval(1.0) * convert(Interval{Float64}, 1))

    a = interval(0.1, 1.1)
    @test isequal_interval(interval(0, 1) * emptyinterval(a), emptyinterval(a))
    @test isequal_interval(a * interval(0), zero(a))
    @test isequal_interval(interval(0, Inf) * interval(-1, Inf), entireinterval())

    fa = interval(Float32, 1e38)
    fb = interval(Float32, 1e2)
    @test isequal_interval(fa * fb, interval(Float32, floatmax(Float32), Inf))
end

@testset "mixed numtype promotion" begin
    for f ∈ (+, -, *, /)
        @test isequal_interval(f(interval(Float64, π), interval(Float32, π)), f(interval(Float64, π), Interval{Float64}(interval(Float32, π))))
    end
end

@testset "arithmetic with thin intervals" begin
    x = interval(1, 2)
    @test isequal_interval(interval(0.1) + x, interval(1.0999999999999999, 2.1))
    @test isequal_interval(interval(3.0) - x, x)
    @test isequal_interval(interval(3.1) - x, interval(1.1, 2.1))
    @test isequal_interval(interval(0.1) * interval(1), interval(0.1, 0.1))
    @test isequal_interval(interval(0.0) * interval(1), interval(0.0, 0.0))
    @test isequal_interval(interval(1) / interval(10.0), interval(0.09999999999999999, 0.1))

    @test isequal_interval(interval(1) * interval(π), interval(π))
    @test isequal_interval(interval(π) * interval(1), interval(π))
    @test isequal_interval(interval(π) + interval(0), interval(π))
    @test isequal_interval(interval(0) + interval(π), interval(π))
    @test isequal_interval(interval(π) - interval(0), interval(π))
    @test isequal_interval(interval(0) - interval(π), -interval(π))
end

@testset "inv" begin
    @test isequal_interval(inv(bareinterval(3.0)), bareinterval(0.3333333333333333, 0.33333333333333337))
    @test isequal_interval(inv(bareinterval(-1.0, 0.0)), bareinterval(-Inf, -1.0))
    @test isequal_interval(inv(bareinterval(0.0, 1.0)), bareinterval(1.0, Inf))
    @test isentire_interval(inv(bareinterval(-1.0, 1.0)))
    @test isempty_interval(inv(bareinterval(0.0)))
    @test isempty_interval(inv(emptyinterval(BareInterval{Float64})))
    @test isentire_interval(inv(entireinterval(BareInterval{Float64})))
    @test isequal_interval(inv(bareinterval(1.0, Inf)), bareinterval(0.0, 1.0))

    @test isequal_interval(inv(bareinterval(1//2)), bareinterval(2//1))
    @test isentire_interval(inv(bareinterval(-1//2, 1//2)))
    @test numtype(inv(bareinterval(-1//2, 1//2))) === Rational{Int}

    @test decoration(inv(interval(0.0, 1.0))) == trv
    @test decoration(inv(interval(-1.0, 1.0))) == trv
    @test decoration(inv(interval(1.0, Inf))) == dac
    @test decoration(inv(interval(1.0, 2.0))) == com
    @test isguaranteed(inv(interval(1.0, 2.0)))
    @test !isguaranteed(inv(convert(Interval{Float64}, 2)))

    @test isequal_interval(inv(complex(interval(1.0), interval(0.0))), complex(interval(1.0), interval(0.0)))
    @test isequal_interval(inv(complex(interval(0.0), interval(1.0))), complex(interval(0.0), interval(-1.0)))

    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)
    c = interval(0.25, 4.0)
    @test isequal_interval(inv(zero(a)), emptyinterval())
    @test isequal_interval(inv(interval(0, 1)), interval(1, Inf))
    @test isequal_interval(inv(interval(1, Inf)), interval(0, 1))
    @test isequal_interval(inv(c), c)
    @test isequal_interval(one(b) / b, inv(b))
    @test isequal_interval(inv(interval(-4.0, 0.0)), interval(-Inf, -0.25))
    @test isequal_interval(inv(interval(0.0, 4.0)), interval(0.25, Inf))
    @test isequal_interval(inv(interval(-4.0, 4.0)), entireinterval(Float64))

    @test isequal_interval(inv(interval(2, 3)), interval(0.3333333333333333, 0.5))
    @test isequal_interval(inv(big(interval(2, 3))), interval(big"3.333333333333333333333333333333333333333333333333333333333333333333333333333305e-01", big"5.0e-01"))
end

@testset "division" begin
    @test isequal_interval(bareinterval(1.0, 2.0) / bareinterval(1.0, 2.0), bareinterval(0.5, 2.0))
    @test isequal_interval(bareinterval(-2.0, -1.0) / bareinterval(1.0, 2.0), bareinterval(-2.0, -0.5))
    @test isequal_interval(bareinterval(-1.0, 2.0) / bareinterval(1.0, 2.0), bareinterval(-1.0, 2.0))
    @test isequal_interval(bareinterval(1.0, 2.0) / bareinterval(-2.0, -1.0), bareinterval(-2.0, -0.5))
    @test isequal_interval(bareinterval(-2.0, -1.0) / bareinterval(-2.0, -1.0), bareinterval(0.5, 2.0))
    @test isequal_interval(bareinterval(-1.0, 2.0) / bareinterval(-2.0, -1.0), bareinterval(-2.0, 1.0))

    @test isempty_interval(bareinterval(1.0, 2.0) / bareinterval(0.0))
    @test isempty_interval(bareinterval(0.0) / bareinterval(0.0))
    @test isthinzero(bareinterval(0.0) / bareinterval(-1.0, 1.0))

    @test isequal_interval(bareinterval(1.0, 2.0) / bareinterval(0.0, 1.0), bareinterval(1.0, Inf))
    @test isequal_interval(bareinterval(-2.0, -1.0) / bareinterval(0.0, 1.0), bareinterval(-Inf, -1.0))
    @test isentire_interval(bareinterval(-1.0, 1.0) / bareinterval(0.0, 1.0))
    @test isequal_interval(bareinterval(1.0, 2.0) / bareinterval(-1.0, 0.0), bareinterval(-Inf, -1.0))
    @test isequal_interval(bareinterval(-2.0, -1.0) / bareinterval(-1.0, 0.0), bareinterval(1.0, Inf))
    @test isentire_interval(bareinterval(-1.0, 1.0) / bareinterval(-1.0, 0.0))
    @test isentire_interval(bareinterval(1.0, 2.0) / bareinterval(-1.0, 1.0))

    @test isempty_interval(emptyinterval(BareInterval{Float64}) / bareinterval(1.0))
    @test isempty_interval(bareinterval(1.0) / emptyinterval(BareInterval{Float64}))
    @test typeof(bareinterval(1.0f0) / bareinterval(1.0)) === BareInterval{Float64}
    @test isequal_interval(bareinterval(1//2) / bareinterval(1//3), bareinterval(3//2))
    @test isempty_interval(bareinterval(1//1) / bareinterval(0//1))

    @test decoration(interval(1.0, 2.0) / interval(1.0, 2.0)) == com
    @test decoration(interval(1.0, 2.0) / interval(0.0, 1.0)) == trv
    @test decoration(interval(1.0, 2.0) / interval(-1.0, 1.0)) == trv
    @test decoration(interval(1.0, 2.0, def) / interval(1.0)) == def
    @test !isguaranteed(interval(1.0) / convert(Interval{Float64}, 2))

    a = interval(0.1, 1.1)
    c = interval(0.25, 4.0)
    @test isequal_interval(a / emptyinterval(a), emptyinterval(a))
    @test isequal_interval(emptyinterval(a) / a, emptyinterval(a))
    @test isequal_interval(interval(0) / interval(0), emptyinterval())
    @test isequal_interval(interval(-30.0, -15.0) / interval(-5.0, -3.0), interval(3.0, 10.0))
    @test isequal_interval(interval(-30, -15) / interval(-5, -3), interval(3.0, 10.0))
    @test isequal_interval(a / c, interval(0.025, 4.4))
    @test isequal_interval(c / interval(4.0), interval(6.25e-02, 1e+00))
    @test isequal_interval(c / zero(c), emptyinterval(c))
    @test isequal_interval(interval(0.0, 1.0) / interval(0.0, 1.0), interval(0.0, Inf))
    @test isequal_interval(interval(-1.0, 1.0) / interval(0.0, 1.0), entireinterval(c))
    @test isequal_interval(interval(-1.0, 1.0) / interval(-1.0, 1.0), entireinterval(c))
    @test issubset_interval(interval(1//9), interval(1) / interval(9))

    @test isequal_interval(bareinterval(2.0) \ bareinterval(1.0), bareinterval(0.5))
    @test isequal_interval(interval(2.0) \ interval(1.0), interval(0.5))
end

@testset "muladd and fma" begin
    @test isequal_interval(muladd(bareinterval(2.0), bareinterval(3.0), bareinterval(1.0)), bareinterval(7.0))
    @test isequal_interval(fma(bareinterval(0.1), bareinterval(0.1), bareinterval(0.1)), bareinterval(0.11, 0.11000000000000001))
    for x ∈ (bareinterval(0.1), bareinterval(-2.0, 3.0)), y ∈ (bareinterval(0.1), bareinterval(-1.0, 1.0)), z ∈ (bareinterval(0.1),)
        @test isequal_interval(fma(x, y, z), muladd(x, y, z))
        @test isequal_interval(fma(x, y, z), x * y + z)
    end
    @test typeof(muladd(bareinterval(1.0f0), bareinterval(2.0), bareinterval(3.0))) === BareInterval{Float64}
    @test typeof(fma(bareinterval(1.0f0), bareinterval(2.0), bareinterval(3.0))) === BareInterval{Float64}

    @test decoration(muladd(interval(1.0, 2.0), interval(1.0, Inf), interval(0.0))) == dac
    @test decoration(fma(interval(1.0, 2.0, def), interval(1.0), interval(0.0))) == def
    @test !isguaranteed(muladd(interval(1.0), interval(2.0), convert(Interval{Float64}, 3)))
    @test isempty_interval(muladd(emptyinterval(), interval(1.0), interval(2.0)))

    r = @test_logs (:warn,) fma(nai(Float64), interval(1.0), interval(2.0))
    @test isnai(r)

    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)
    c = interval(0.25, 4.0)
    @test isequal_interval(fma(emptyinterval(), a, b), emptyinterval())
    @test isequal_interval(fma(entireinterval(), zero(a), b), b)
    @test isequal_interval(fma(entireinterval(), one(a), b), entireinterval())
    @test isequal_interval(fma(zero(a), entireinterval(), b), b)
    @test isequal_interval(fma(one(a), entireinterval(), b), entireinterval())
    @test isequal_interval(fma(a, zero(a), c), c)
    @test isequal_interval(fma(interval(Rational{Int}, 1//2, 1//2), interval(Rational{Int}, 1//3, 1//3), interval(Rational{Int}, 1//12, 1//12)), interval(Rational{Int}, 3//12, 3//12))

    result = interval(1.1) * interval(2) + interval(3)
    @test isequal_interval(muladd(interval(1.1), interval(2), interval(3)), result)
    @test isequal_interval(muladd(interval(1.1), interval(Float32, 2), interval(3)), result)
end

@testset "sqrt" begin
    @test isequal_interval(sqrt(bareinterval(2.0)), bareinterval(1.414213562373095, 1.4142135623730951))
    @test isthin(sqrt(bareinterval(4.0)), 2.0)
    @test isequal_interval(sqrt(bareinterval(-1.0, 4.0)), bareinterval(0.0, 2.0))
    @test isempty_interval(sqrt(bareinterval(-4.0, -1.0)))
    @test isempty_interval(sqrt(emptyinterval(BareInterval{Float64})))
    @test isequal_interval(sqrt(bareinterval(0.0, Inf)), bareinterval(0.0, Inf))

    @test IntervalArithmetic._cut_negative_domain(bareinterval(-1.0, 4.0)) == 0.0
    @test IntervalArithmetic._cut_negative_domain(bareinterval(1.0, 4.0)) == 1.0
    @test IntervalArithmetic._cut_negative_domain(bareinterval(BigFloat, -1, 4)) == 0
    @test IntervalArithmetic._cut_negative_domain(bareinterval(BigFloat, 1, 4)) == 1

    @test isequal_interval(sqrt(bareinterval(1//4)), bareinterval(0.5))
    @test numtype(sqrt(bareinterval(1//4))) === Float64

    @test decoration(sqrt(interval(0.0, 4.0))) == com
    @test decoration(sqrt(interval(-1.0, 4.0))) == trv
    @test decoration(sqrt(interval(0.0, Inf))) == dac
    r = sqrt(interval(-4.0, -1.0))
    @test isempty_interval(r)
    @test decoration(r) == trv
    @test isguaranteed(sqrt(interval(2.0)))
    @test !isguaranteed(sqrt(convert(Interval{Float64}, 2)))
    r = @test_logs (:warn,) sqrt(nai(Float64))
    @test isnai(r)

    @test isequal_interval(sqrt(bareinterval(Float32, 2)), bareinterval(1.4142135f0, 1.4142137f0))
    @test numtype(sqrt(bareinterval(Float16, 2))) === Float16
    @test in_interval(sqrt(big(2)), sqrt(bareinterval(Float16, 2)))
    @test isequal_interval(sqrt(interval(2, 3)), interval(1.414213562373095, 1.7320508075688774))
    @test isequal_interval(sqrt(big(interval(2, 3))), interval(big"1.414213562373095048801688724209698078569671875376948073176679737990732478462102", big"1.732050807568877293527446341505872366942805253810380628055806979451933016908815"))

    r = sqrt(complex(interval(4.0), interval(0.0)))
    @test in_interval(2, real(r))
    @test in_interval(0, imag(r))
    r = sqrt(complex(interval(-1.0), interval(0.0)))
    @test in_interval(0, real(r))
    @test in_interval(1, imag(r))

    ra = interval(Rational{Int64}, 1//2, 3//4)
    rb = interval(Rational{Int64}, 3//7, 9//12)
    @test issubset_interval(sqrt(ra + rb), interval(Int64(137482504)//142672337, Int64(46099201)//37639840))
    @test issubset_interval(sqrt(interval(1//3)), interval(Int64(29354524)//50843527, Int64(50843527)//88063572))

    r = sqrt(interval(1, 2, com))
    @test isequal_interval(r, sqrt(interval(1, 2)))
    @test decoration(r) == com
    r = sqrt(interval(-1, 1, com))
    @test isequal_interval(r, sqrt(interval(0, 1)))
    @test decoration(r) == trv
end

@testset "no mixing of BareInterval and Number" begin
    @test_throws MethodError bareinterval(1.0) + 1
    @test_throws MethodError 1 + bareinterval(1.0)
    @test_throws MethodError bareinterval(1.0) + interval(1.0)
    @test_throws MethodError bareinterval(1.0) * 2
    @test_throws MethodError bareinterval(1.0) / 2
end

@testset "complex arithmetic" begin
    a = interval(1im)
    @test typeof(a) == Complex{Interval{Float64}}
    @test isequal_interval(a, complex(interval(0), interval(1)))
    @test isequal_interval(a, interval(0) + interval(1) * interval(im))
    @test isequal_interval(a * a, interval(-1))
    @test isequal_interval(a + a, interval(2) * interval(im))
    @test isthinzero(a - a)
    @test isthinone(a / a)
end

@testset "enclosure of point operations" begin
    xs = (bareinterval(0.1, 1.1), bareinterval(-2.7, -0.3), bareinterval(-1.5, 2.5))
    ys = (bareinterval(0.4, 2.3), bareinterval(-3.1, -1.2))
    for x ∈ xs, y ∈ ys
        for s ∈ range(inf(x), sup(x); length = 5), t ∈ range(inf(y), sup(y); length = 5)
            @test in_interval(s + t, x + y)
            @test in_interval(s - t, x - y)
            @test in_interval(s * t, x * y)
            @test in_interval(s / t, x / y)
        end
    end
end

function calc_pi1(N)
    S = interval(0)
    for i ∈ 1:N
        S += inv(interval(i)^2)
    end
    S += interval(inv(interval(N+1)), inv(interval(N)))
    return sqrt(interval(6) * S)
end

function calc_pi2(N)
    S = interval(0)
    for i ∈ 1:N
        S += interval(1 / i^2)
    end
    S += interval(inv(interval(N+1)), inv(interval(N)))
    return sqrt(interval(6) * S)
end

function calc_pi3(N)
    S = interval(0)
    for i ∈ 1:N
        S += interval(1 / i^2)
    end
    S += parse(Interval{Float64}, "[1/$(N+1), 1/$N]")
    return sqrt(interval(6) * S)
end

function calc_pi4(N)
    S = interval(0)
    II = interval(1)
    for i ∈ N:-1:1
        S += II / interval(i^2)
    end
    S += II / interval(N, N+1)
    return sqrt(interval(6) * S)
end

function calc_pi5(N)
    S = interval(0)
    for i ∈ N:-1:1
        S += interval(1 // i^2)
    end
    S += inv(interval(N, N+1))
    return sqrt(interval(6) * S)
end

@testset "pi computations" begin
    big_pi = setprecision(256) do
        big(π)
    end

    N = 10000
    pi1 = calc_pi1(N)
    pi2 = calc_pi2(N)
    pi3 = calc_pi3(N)
    pi4 = calc_pi4(N)
    pi5 = calc_pi5(N)

    @test in_interval(big_pi, pi1)
    @test in_interval(big_pi, pi2)
    @test in_interval(big_pi, pi3)
    @test in_interval(big_pi, pi4)
    @test in_interval(big_pi, pi5)

    @test isequal_interval(pi1, pi2)
    @test isequal_interval(pi2, pi3)
end
