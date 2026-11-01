using Test
using IntervalArithmetic

@testset "ExactReal construction" begin
    @test ExactReal{Float64} <: Real
    @test fieldnames(ExactReal) == (:value,)

    @test exact(0.5) isa ExactReal{Float64}
    @test exact(3).value == 3
    @test IntervalArithmetic._value(exact(3)) == 3
    @test exact(exact(0.5)) === exact(0.5)

    @test_throws MethodError ExactReal{Float64}(1//3)
    @test_throws MethodError ExactReal{Float64}(1.0)
    @test_throws MethodError ExactReal(1.0)
    @test_throws MethodError convert(ExactReal{Float64}, 2)
    @test ExactReal{Float64}(exact(0.5)) === exact(0.5)

    c = exact(complex(1, 2))
    @test c isa Complex{ExactReal{Int}}
    @test (real(c) === exact(1)) & (imag(c) === exact(2))
    @test exact([1, 2]) isa Vector{ExactReal{Int}}
    @test exact([1, 2]) == [exact(1), exact(2)]

    @test isguaranteed(exact(1))
    @test !isguaranteed(1)
end

@testset "Display" begin
    @test repr(exact(0.1)) == "ExactReal{Float64}(0.1000000000000000055511151231257827021181583404541015625)"
    @test repr("text/plain", exact(0.1)) == repr(exact(0.1))
    @test repr(exact(1//2)) == "ExactReal{Rational{$Int}}(1//2)"
    @test repr(exact(1)) == "ExactReal{$Int}(1)"

    @test has_exact_display(0.5)
    @test !has_exact_display(0.1)
    @test has_exact_display(1)
    @test has_exact_display(1//3)
end

@testset "Utilities" begin
    @test [10, 20, 30][exact(2)] == 20

    @test zero(ExactReal{Float64}) === exact(0.0)
    @test one(ExactReal{Int}) === exact(1)
    @test zero(exact(1.0)) === exact(0.0)
    @test one(exact(2)) === exact(1)
    @test zero(Complex{ExactReal{Float64}}) === complex(exact(0.0), exact(0.0))
    @test one(Complex{ExactReal{Int}}) === complex(exact(1), exact(0))
    @test zero(complex(exact(1.0), exact(2.0))) === complex(exact(0.0), exact(0.0))
    @test one(complex(exact(1), exact(2))) === complex(exact(1), exact(0))

    @test hash(exact(1)) == hash(1)

    @test !isfinite(exact(Inf))
    @test isinf(exact(Inf))
    @test isinteger(exact(2.0))
    @test isnan(exact(NaN))
end

@testset "Conversion and promotion" begin
    @test convert(ExactReal{Float64}, exact(0.5)) === exact(0.5)
    @test convert(ExactReal{Int}, exact(Int8(1))) === exact(1)
    @test convert(ExactReal{Rational{Int}}, exact(2)) === exact(2//1)

    @test_throws ArgumentError promote_type(ExactReal{Float64}, ExactReal{Float32})
    @test promote_type(ExactReal{Int8}, ExactReal{Int16}) == ExactReal{Int16}
    @test promote_type(ExactReal{Int}, ExactReal{Rational{Int}}) == ExactReal{Rational{Int}}

    @test bounds(convert(BareInterval{Float64}, exact(0.1))) == (0.1, 0.1)
    x = convert(Interval{Float64}, exact(0.1))
    @test (bounds(x) == (0.1, 0.1)) & (decoration(x) == com) & isguaranteed(x)

    @test BareInterval(exact(1)) === bareinterval(1)
    @test BareInterval{Float32}(exact(1)) === bareinterval(Float32, 1)
    @test Interval(exact(1)) isa Interval{Float64}
    @test isguaranteed(Interval(exact(1)))
    @test Interval{Float32}(exact(1)) isa Interval{Float32}

    @test isequal_interval(promote(bareinterval(1, 2), exact(3))[2], bareinterval(3))
    @test isequal_interval(promote(interval(1, 2), exact(3))[2], interval(3))

    @test promote_type(BareInterval{Float64}, ExactReal{Int}) == BareInterval{Float64}
    @test promote_type(ExactReal{Int}, BareInterval{Float64}) == BareInterval{Float64}
    @test promote_type(Interval{Float64}, ExactReal{Int}) == Interval{Float64}
    @test promote_type(ExactReal{Int}, Interval{Float32}) == Interval{Float32}

    @test promote_type(ExactReal{Float64}, Float32) == Float64
    @test promote_type(Float32, ExactReal{Float64}) == Float64
    @test promote_type(ExactReal{Int}, Bool) == Int
    @test promote_type(Bool, ExactReal{Int}) == Int
    @test promote_type(ExactReal{Int}, BigFloat) == BigFloat
    @test promote_type(BigFloat, ExactReal{Int}) == BigFloat
    @test promote_type(ExactReal{Int}, Irrational{:π}) == Float64
    @test promote_type(Irrational{:π}, ExactReal{Int}) == Float64

    @test Float64(exact(1)) === 1.0
    @test Int(exact(2)) === 2
    @test Bool(exact(1)) === true

    c = Complex{Interval{Float64}}(exact(1))
    @test isguaranteed(c)
    @test isthinzero(imag(c))
end

@testset "Exact arithmetic" begin
    @test exact(1)//exact(2) === exact(1//2)
    @test exact(1)//2 === 1//2
    @test 1//exact(2) === 1//2

    @test -exact(0.5) === exact(-0.5)
    @test -exact(1//2) === exact(-1//2)
    @test -exact(1) === exact(-1)
    @test (-exact(big"0.5")) isa ExactReal{BigFloat}
    @test (-exact(big"0.5")).value == -0.5
    @test_throws OverflowError -exact(typemin(Int))
    @test -exact(π) === -Float64(π)

    @test exact(1) + exact(2) === exact(3)
    @test exact(1) - exact(3) === exact(-2)
    @test exact(2) * exact(3) === exact(6)
    @test exact(2) + exact(1//2) === exact(5//2)
    @test exact(2) * exact(1//2) === exact(1//1)
    @test exact(1//2) + exact(1//4) === exact(3//4)
    @test exact(1//2) - exact(1//4) === exact(1//4)
    @test exact(1//2) * exact(1//2) === exact(1//4)

    @test_throws OverflowError exact(typemax(Int)) + exact(1)
    @test_throws OverflowError exact(typemin(Int)) - exact(1)
    @test_throws OverflowError exact(typemax(Int)) * exact(2)
    @test_throws OverflowError exact(2) ^ exact(1000)

    @test exact(2) ^ exact(3) === exact(8)
    @test exact(1//2) ^ exact(3) === exact(1//8)
    @test exact(2) ^ 3 === exact(8)
    let p = 3
        @test exact(2) ^ p === 8
    end
    @test exact(2.0) ^ 2 === 4.0
    @test exact(2.0) ^ exact(3) === 8.0
    if VERSION ≥ v"1.11"
        @test_throws DomainError exact(2) ^ (-2)
    else
        @test_throws InexactError exact(2) ^ (-2)
    end

    let x = exact(1.5)
        @test x * exact(true) === exact(1.5)
        @test x * exact(false) === exact(0.0)
        @test x / exact(true) === exact(1.5)
        @test exact(true) * x === exact(1.5)
        @test exact(true) * exact(true) === exact(true)
        @test exact(true) * exact(2) === exact(2)
        @test exact(true) / exact(true) === exact(1.0)
        @test exact(2) / exact(true) === exact(2.0)
        @test exact(1//2) / exact(true) === exact(1//2)
        @test exact(true) / exact(1//2) === exact(2//1)
        @test exact(true) / exact(2) === exact(0.5)
    end

    @test exact(4) / exact(2) === exact(2.0)
    @test exact(1) / exact(2) === exact(0.5)
    @test exact(1) / exact(4) === exact(0.25)
    @test exact(1) / exact(3) === 1/3
    @test exact(1) / exact(Int64(2)^Int64(60) + Int64(1)) === 1/Int64(2)^Int64(60)
    @test exact(-Int64(1)) / exact(typemin(Int32)) === exact(-Int64(1)/typemin(Int32))
    @test exact(-1) / exact(typemin(Int)) === -1/typemin(Int)
    @test exact(typemin(Int)) / exact(-1) === typemin(Int)/-1

    @test exact(1//2) / exact(2) === exact(1//4)
    @test exact(1//2) / exact(1//4) === exact(2//1)
    @test exact(1) / exact(1//4) === exact(4//1)

    @test exact(1.5) + exact(2.0) === 3.5
    @test exact(1.5) * exact(2.0) === 3.0
    @test exact(1.5) - exact(2.0) === -0.5
    @test exact(2.0) ^ exact(3.0) === 8.0
    @test exact(0.5) + exact(0.25) === 0.75
    @test exact(0.5) * exact(0.5) === 0.25

    t = setprecision(() -> big(1) / 3, BigFloat, 512)
    @test precision((-exact(t)).value) == 512
    @test (-exact(t)).value == setprecision(() -> -t, BigFloat, 512)

    @test !(exact(true) / exact(3.0) isa ExactReal)
    @test !(exact(true) / exact(3) isa ExactReal)
    @test !(exact(2^60 + 1) / exact(true) isa ExactReal)
    @test exact(6) / exact(true) === exact(6.0)
    @test exact(true) / exact(4) === exact(0.25)
    @test exact(2.5) / exact(true) === exact(2.5)
    @test exact(1//3) / exact(true) === exact(1//3)
    @test (exact(t) / exact(true)).value === t
end

@testset "Interaction with intervals" begin
    x = @exact 0.5

    @test (2 * x) isa Float64
    @test isone(2 * x)

    @test (bareinterval(2) * x) isa BareInterval
    @test isthinone(bareinterval(2) * x)

    @test (interval(2) * x) isa Interval
    @test isthinone(interval(2) * x)
    @test isguaranteed(interval(2) * x)

    y = interval(1.0, 2.0) + exact(0.5)
    z = interval(1.0, 2.0) + 0.5
    @test isguaranteed(y) & !isguaranteed(z)
    @test isequal_interval(y, z)
end

@testset "Exact literals with bare intervals" begin
    specialized(f, S, R) = which(f, Tuple{S,R}).sig isa UnionAll
    @test all(f -> specialized(f, BareInterval{Float64}, ExactReal{Float64}), (+, -, *, /))
    @test all(f -> specialized(f, ExactReal{Float64}, BareInterval{Float64}), (+, -, *, \))
    @test !specialized(*, BareInterval{Float64}, ExactReal{Int})

    viapromotion(f, x, y) = f(promote(x, y)...)
    samebits(x::BareInterval, y::BareInterval) = (inf(x) === inf(y)) & (sup(x) === sup(y))

    for T ∈ (Float64, Float32, Rational{Int})
        vals = T <: Rational ?
            (zero(T), one(T), -one(T), T(1//2), T(-5//3)) :
            (zero(T), -zero(T), one(T), -one(T), T(0.5), T(-2.5), T(0.1), T(-0.1),
             floatmax(T), floatmin(T))
        ivs = (bareinterval(T, 1, 2), bareinterval(T, -2, -1), bareinterval(T, -1, 2),
               bareinterval(T, 0, 1), bareinterval(T, -1, 0), bareinterval(T, 0, 0),
               bareinterval(T(1//10), T(1//10)), bareinterval(T, -Inf, 2),
               bareinterval(T, 3, Inf), entireinterval(BareInterval{T}),
               emptyinterval(BareInterval{T}))
        for v ∈ vals, x ∈ ivs
            k = exact(v)
            @test samebits(x + k, viapromotion(+, x, k))
            @test samebits(k + x, viapromotion(+, k, x))
            @test samebits(x - k, viapromotion(-, x, k))
            @test samebits(k - x, viapromotion(-, k, x))
            @test samebits(x * k, viapromotion(*, x, k))
            @test samebits(k * x, viapromotion(*, k, x))
            @test samebits(x / k, viapromotion(/, x, k))
            @test samebits(k \ x, viapromotion(\, k, x))
        end
    end

    b = bareinterval(1.0, 2.0)
    e = exact(0.5)
    @test bounds(b + e) == (1.5, 2.5)
    @test bounds(b - e) == (0.5, 1.5)
    @test bounds(e - b) == (-1.5, -0.5)
    @test bounds(b * e) == (0.5, 1.0)
    @test bounds(b / e) == (2.0, 4.0)
    @test bounds(e \ b) == (2.0, 4.0)
    @test samebits(b ^ e, viapromotion(^, b, e))
    @test bounds(bareinterval(1.0, 2.0) * exact(-2.0)) == (-4.0, -2.0)
    @test bounds(bareinterval(1.0, 2.0) / exact(-2.0)) == (-1.0, -0.5)
    @test bounds(bareinterval(0.1, 0.2) * exact(3.0)) == (0.3, 0.6000000000000001)

    let e = emptyinterval(BareInterval{Float64})
        @test isempty_interval(e + exact(1.0))
        @test isempty_interval(e - exact(1.0))
        @test isempty_interval(e * exact(1.0))
        @test isempty_interval(e / exact(1.0))
    end

    let x = bareinterval(1.0, 2.0)
        for v ∈ (Inf, -Inf, NaN)
            @test isempty_interval(@test_logs (:warn, r"ill-formed bare interval") x + exact(v))
            @test isempty_interval(@test_logs (:warn,) x - exact(v))
            @test isempty_interval(@test_logs (:warn,) exact(v) - x)
            @test isempty_interval(@test_logs (:warn,) x * exact(v))
            @test isempty_interval(@test_logs (:warn,) x / exact(v))
        end
    end

    @test bounds(bareinterval(-Inf, 1.0) * exact(0.0)) == (0.0, 0.0)
    @test isempty_interval(bareinterval(1.0, 2.0) / exact(0.0))

    @test bareinterval(1, 2) + exact(1) === bareinterval(2.0, 3.0)
    @test (bareinterval(Float32, 1, 2) + exact(1.0f0)) isa BareInterval{Float32}
    @test bareinterval(1//2, 3//4) + exact(1//4) === bareinterval(3//4, 1//1)

    @test isequal_interval(bareinterval(1.0, 2.0) * exact(2), bareinterval(2.0, 4.0))
    @test isequal_interval(bareinterval(1.0, 2.0) + exact(1//3),
                           bareinterval(1.0, 2.0) + bareinterval(Float64, 1//3))
end

@testset "@exact macro" begin
    @test (@exact 1.5) === exact(1.5)
    @test (@exact 1 + 2) === exact(3)
    @test (@exact 1//2) === exact(1//2)
    @test (@exact [1.0, 2.0]) isa Vector{ExactReal{Float64}}

    @test (@exact 2im) isa Complex{<:ExactReal}
    @test (@exact 1.2 + 3.4im) isa Complex{<:ExactReal}
    @test_throws ArgumentError (@exact 1.2 + 3im)

    @test (@exact im) === complex(exact(false), exact(true))
    @test (@exact 1 + im) === complex(exact(1), exact(1))
    @test (@exact im + 1) === complex(exact(1), exact(1))
    @test (@exact 1 - im) === complex(exact(1), exact(-1))
    @test (@exact 2im) === complex(exact(0), exact(2))
    @test (@exact 2 * im) === complex(exact(0), exact(2))
    @test (@exact im * 2) === complex(exact(0), exact(2))
    @test (@exact 2.5 * im) === complex(exact(0.0), exact(2.5))
    @test (@exact 1 + 2im) === complex(exact(1), exact(2))
    @test (@exact 1 - 2im) === complex(exact(1), exact(-2))
    @test (@exact 1 + im * 2) === complex(exact(1), exact(2))
    @test (@exact 2im + 1) === complex(exact(1), exact(2))
    @test (@exact im * 2 + 1) === complex(exact(1), exact(2))

    @exact function f(x)
        return x^2 - 2x + 1
    end

    @test f(1.0) isa Real
    @test iszero(f(1.0))

    @test f(bareinterval(1)) isa BareInterval
    @test isthinzero(f(bareinterval(1)))

    @test f(interval(1)) isa Interval
    @test isthinzero(f(interval(1)))
    @test isguaranteed(f(interval(1)))

    g_plain(x) = 1.2 * x + 0.1
    @exact g_exact(x) = 1.2 * x + 0.1
    @test !isguaranteed(g_plain(interval(1, 2)))
    @test isguaranteed(g_exact(interval(1, 2)))
    @test isequal_interval(g_exact(interval(1, 2)), g_plain(interval(1, 2)))
    @test g_exact(1.4) === 1.78

    h = @exact (x -> 2x + 1)
    @test isguaranteed(h(interval(1)))
    @test isequal_interval(h(interval(1)), interval(3))
end
