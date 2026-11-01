using Test
using IntervalArithmetic
using IntervalArithmetic: NumTypes, promote_numtype, _unsafe_bareinterval, _round, __round,
    __float, _unsafe_interval, setdecoration, atomic, _atomic
using InteractiveUtils

struct UnsupportedTestIrrational <: AbstractIrrational end

@testset "NumTypes and promote_numtype" begin
    @test NumTypes === Union{Rational,AbstractFloat}

    @test promote_numtype(Float64, Float32) == Float64
    @test promote_numtype(BigFloat, Float64) == BigFloat
    @test promote_numtype(Rational{Int}, Float64) == Float64
    @test promote_numtype(Float16, Int8) == Float16
    @test promote_numtype(Int, Int) == Float64
    @test promote_numtype(Bool, Bool) == Float64
    @test promote_numtype(Rational{Int32}, Irrational{:π}) == Rational{Int64}
    @test promote_numtype(Irrational{:π}, Rational{Int32}) == Rational{Int64}
    @test promote_numtype(Rational{Int64}, Irrational{:π}) == Rational{Int64}
    @test promote_numtype(Irrational{:π}, Irrational{:ℯ}) == Float64
end

IntervalArithmetic.configure(numtype = Float32)
try
    @testset "configured default numtype" begin
        @test promote_numtype(Int, Int) == Float32
        @test IntervalArithmetic.default_numtype() == Float32
    end
finally
    IntervalArithmetic.configure(numtype = Float64)
end

@testset "default numtype restored" begin
    @test promote_numtype(Int, Int) == Float64
    @test IntervalArithmetic.default_numtype() == Float64
end

@testset "Representation invariants of the bounds" begin
    @test !(BareInterval{Float64} <: Real)
    @test_throws TypeError BareInterval{Int}
    @test fieldnames(BareInterval) == (:lo, :hi)
    @test fieldtypes(BareInterval{Float64}) == (Float64, Float64)

    for T ∈ (Float16, Float32, Float64, BigFloat, Rational{Int}, Rational{BigInt})
        e = emptyinterval(BareInterval{T})
        @test (e.lo == typemax(T)) & (e.hi == typemin(T))
        @test isempty_interval(e)
        @test (inf(e) == typemax(T)) & (sup(e) == typemin(T))

        f = @test_logs (:warn,) bareinterval(T, 2, 1)
        @test (f.lo == typemax(T)) & (f.hi == typemin(T))

        g = nai(Interval{T})
        @test (g.bareinterval.lo == typemax(T)) & (g.bareinterval.hi == typemin(T))
    end
    @test bounds(emptyinterval(BareInterval{Float64})) === (Inf, -Inf)
    @test bounds(emptyinterval(BareInterval{Rational{Int64}})) == (1//0, -1//0)

    x = bareinterval(0.0, 1.0)
    @test (x.lo === 0.0) & (inf(x) === -0.0) & (sup(x) === 1.0)
    y = bareinterval(-1.0, -0.0)
    @test (y.hi === 0.0) & (sup(y) === 0.0)
    z = bareinterval(-0.0, 0.0)
    @test (z.lo === 0.0) & (z.hi === 0.0)
    @test (inf(z) === -0.0) & (sup(z) === 0.0)

    @test bounds(x) === (0.0, 1.0)
    @test bounds(bareinterval(-0.0, 1.0)) == (0.0, 1.0)

    b = bareinterval(BigFloat, -0.0, 0.0)
    @test !signbit(b.lo)
    @test bounds(b) == (0.0, 0.0)
end

@testset "Difference between checked and unchecked bare intervals" begin
    @test IntervalArithmetic._unsafe_bareinterval(Float64, 1, 2) === bareinterval(1, 2)

    @test inf(_unsafe_bareinterval(Float64, 3, 2)) == 3
    @test isempty_interval(@test_logs (:warn,) bareinterval(3, 2))
    @test isnai(@test_logs (:warn,) interval(3, 2))

    x = _unsafe_bareinterval(Float64, 0.1, 0.2)
    @test (x.lo === 0.1) & (x.hi === 0.2)
    y = _unsafe_bareinterval(Float64, 1//10, 1//5)
    @test (inf(y) === 0.09999999999999999) & (sup(y) === 0.2)

    r8 = _unsafe_bareinterval(Rational{Int8}, 1//2, 3//4)
    @test (inf(r8) == 1//2) & (sup(r8) == 3//4)
    r16 = _unsafe_bareinterval(Rational{Int16}, 1//2, 3//4)
    @test (inf(r16) == 1//2) & (sup(r16) == 3//4)
end

@testset "Directed rounding of the bounds" begin
    @test _round(Float64, π, RoundDown) == 3.141592653589793
    @test _round(Float64, π, RoundUp) == 3.1415926535897936 == nextfloat(3.141592653589793)
    @test _round(Float64, ℯ, RoundDown) == 2.718281828459045
    @test _round(Float64, ℯ, RoundUp) == 2.7182818284590455
    @test _round(Float64, MathConstants.φ, RoundDown) == 1.6180339887498947
    @test _round(Float64, MathConstants.φ, RoundUp) == 1.618033988749895
    @test _round(Float64, MathConstants.γ, RoundDown) == 0.5772156649015328
    @test _round(Float64, MathConstants.catalan, RoundDown) == 0.915965594177219

    @test_throws ArgumentError _round(Float64, UnsupportedTestIrrational(), RoundDown)
    @test_throws ArgumentError _round(Rational{Int}, UnsupportedTestIrrational(), RoundUp)

    @test _round(Rational{Int64}, π, RoundDown) == 80143857//25510582
    @test _round(Rational{Int64}, π, RoundUp) == 85563208//27235615

    @test __round(Rational{Int}, 1//3, RoundDown) == __round(Rational{Int}, 1//3, RoundUp) == 1//3

    @test __float(Int8) == Float16
    @test __float(UInt8) == Float16
    @test __float(Int16) == Float32
    @test __float(UInt16) == Float32
    @test __float(Int32) == Float64
    @test __float(Int64) == Float64
end

@testset "bareinterval constructors" begin
    x = bareinterval(Rational{Int64}, 0.1)
    @test (inf(x) == 1//10) & (sup(x) == 300239975158034//3002399751580339)
    @test in_interval(0.1, x)

    # src/intervals/construction.jl: the `rationalize`-based `__round` loses the enclosure for small integer types
    y = bareinterval(Rational{Int32}, 0.1)
    @test (inf(y) == 1//10) & (sup(y) == 1//10)
    @test !in_interval(0.1, y)
    z = bareinterval(Rational{Int8}, 0.1)
    @test (inf(z) == 1//10) & (sup(z) == 1//10)

    p16 = bareinterval(Rational{Int16}, π)
    @test (inf(p16) == 31218//9937) & (sup(p16) == 355//113)

    a = bareinterval(1//1, π)
    @test typeof(a) == BareInterval{Rational{Int64}}
    @test (inf(a) == 1//1) & (sup(a) == 85563208//27235615)
    b = bareinterval(Rational{Int32}, 1//1, π)
    @test typeof(b) == BareInterval{Rational{Int32}}
    @test (inf(b) == 1//1) & (sup(b) == 85563208//27235615)
    c = bareinterval(1, π)
    @test typeof(c) == BareInterval{Float64}
    @test bounds(c) == (1.0, 3.1415926535897936)

    @test precision(sup(bareinterval(BigFloat, 1, π))) == precision(BigFloat) == 256
    @test precision(inf(bareinterval(BigFloat, 0.1))) == 256
    setprecision(BigFloat, 53) do
        @test bounds(bareinterval(BigFloat, 1, π)) == (1.0, 3.1415926535897936)
    end
    setprecision(BigFloat, 20) do
        for c ∈ (π, ℯ, MathConstants.φ)
            @test nextfloat(IntervalArithmetic._round(Float64, c, RoundDown)) == IntervalArithmetic._round(Float64, c, RoundUp)
        end
    end

    @test bareinterval(1) === bareinterval(1.0, 1.0)
    @test typeof(bareinterval(1)) == BareInterval{Float64}
    @test typeof(bareinterval(1//2)) == BareInterval{Rational{Int}}
    @test typeof(bareinterval(Float32, 1)) == BareInterval{Float32}
    @test bounds(bareinterval(Float32, 0.1)) === (0.099999994f0, 0.1f0)
    @test bounds(bareinterval(Float16, 1, π)) === (Float16(1.0), Float16(3.143))

    @test bareinterval((1, 2)) === bareinterval(1, 2)
    @test bareinterval((1,)) === bareinterval(1)
    @test typeof(bareinterval(Float32, (1, 2))) == BareInterval{Float32}
    @test_throws MethodError bareinterval((1, 2, 3))

    @test bounds(bareinterval(Float32, bareinterval(0.1))) === (0.099999994f0, 0.1f0)
    @test bareinterval(bareinterval(1, 2)) === bareinterval(1, 2)

    @test isempty_interval(@test_logs (:warn, r"ill-formed bare interval") bareinterval(1, -1))
    @test isempty_interval(@test_logs (:warn,) bareinterval(NaN))
    @test isempty_interval(@test_logs (:warn,) bareinterval(1, NaN))
    @test isempty_interval(@test_logs (:warn,) bareinterval(Inf, Inf))
    @test isempty_interval(@test_logs (:warn,) bareinterval(-Inf, -Inf))

    @test promote_type(BareInterval{Float64}, BareInterval{Float32}) == BareInterval{Float64}
    @test convert(BareInterval{Float32}, bareinterval(0.1)) === bareinterval(Float32, 0.1)
    @test BareInterval{Float32}(bareinterval(0.1)) === bareinterval(Float32, 0.1)

    @test_throws MethodError bareinterval(Int, 1, 2)
    @test_throws MethodError bareinterval(Complex{Float64}, 1, 2)
    @test_throws MethodError interval(Int, 1, 2)
end

@testset "Decoration enum" begin
    @test Decoration isa Type
    @test (Int(ill), Int(trv), Int(def), Int(dac), Int(com)) == (0, 1, 2, 3, 4)
    @test instances(Decoration) == (ill, trv, def, dac, com)
    @test trv < def
    @test min(com, trv) == trv
    @test max(def, dac) == dac
    @test Decoration(2) === def

    @test decoration(emptyinterval(BareInterval{Float64})) == trv
    @test decoration(bareinterval(1, Inf)) == dac
    @test decoration(entireinterval(BareInterval{Float64})) == dac
    @test decoration(bareinterval(1, 2)) == com

    @test decoration(nai(Interval{Float64})) == ill
    @test decoration(interval(1, 2)) == com
    @test decoration(complex(interval(1, 2), interval(1, Inf))) == dac
end

@testset "Interval type and setdecoration" begin
    @test Interval{Float64} <: Real
    @test fieldnames(Interval) == (:bareinterval, :decoration, :isguaranteed)

    x = _unsafe_interval(bareinterval(1, 2), def, false)
    @test decoration(x) == def
    @test !isguaranteed(x)
    @test bareinterval(x) === bareinterval(1, 2)

    @test isempty_interval(@test_logs (:warn, r"interval part of NaI") bareinterval(nai(Interval{Float64})))
    @test isempty_interval(@test_logs (:warn,) bareinterval(Float32, nai(Interval{Float64})))
    @test typeof(bareinterval(Float32, interval(1, 2))) == BareInterval{Float32}

    @test decoration(setdecoration(interval(1, 2), def)) == def
    @test isnai(setdecoration(interval(1, 2), ill))
    @test decoration(setdecoration(interval(1, 2), ill)) == ill
    @test decoration(setdecoration(emptyinterval(Interval{Float64}), com)) == trv
    @test decoration(setdecoration(interval(1, Inf), com)) == dac
    @test !isguaranteed(setdecoration(convert(Interval{Float64}, 1), def))
    @test isguaranteed(setdecoration(interval(1), def))

    y = @test_logs (:warn,) interval(NaN)
    z = @test_logs (:warn,) setdecoration(y, com)
    @test !isnai(z)
    @test decoration(z) == trv
end

@testset "isguaranteed" begin
    @test isguaranteed(bareinterval(1))
    @test isguaranteed(interval(1))
    @test !isguaranteed(convert(Interval{Float64}, 1))
    @test !isguaranteed(interval(1) + 0)
    @test !isguaranteed(1)
    @test !isguaranteed(1.0)
    @test !isguaranteed(π)
    @test !isguaranteed(complex(interval(1), convert(Interval{Float64}, 2)))
    @test isguaranteed(complex(interval(1), interval(2)))
end

@testset "Basics" begin
    @test typeof(interval(1, 2)) == Interval{Float64}
    @test typeof(big(interval(1, 2))) == Interval{BigFloat}
    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test typeof(interval(T, 1, 2)) == Interval{T}
    end
    for T ∈ [InteractiveUtils.subtypes(Signed) ; InteractiveUtils.subtypes(Unsigned)]
        @test typeof(interval(Rational{T}, 1, 2)) == Interval{Rational{T}}
    end
    @test eltype(interval(1, 2)) == Interval{Float64}
    @test IntervalArithmetic.numtype(interval(1, 2)) == Float64
    @test typeof(interval(BigInt(1), 11//10)) == Interval{Rational{BigInt}}

    @test isequal_interval(interval(big"3"), interval(3))
    @test isequal_interval(interval(Float64, big"1e10000"), interval(Float64, big(10)^10000), interval(prevfloat(Inf), Inf))

    @test inf(interval(1, 2)) == 1 && sup(interval(1, 2)) == 2

    a = interval(0.1, 1.1)
    @test isequal_interval(a, interval(inf(a), sup(a)))
    @test isequal_interval(emptyinterval(Rational{Int}), emptyinterval())

    @test isequal_interval(
        interval(Float64, 1, 1), interval(Float64, 1), interval(1),
        interval(Float64, interval(1)), interval(interval(1)),
        interval(BigFloat, 1, 1), interval(BigFloat, 1), interval(big(1)),
        interval(1, 1))

    @test isequal_interval(
        interval(Rational{Int}, 1//10, 1//10), interval(1//10, 1//10), interval(Rational{Int}, 1//10), interval(1//10),
        interval(Rational{Int}, interval(1//10)), interval(interval(1//10)),
        interval(Rational{BigInt}, 1//10, 1//10), interval(Rational{BigInt}, 1//10), interval(big(1//10)))

    @test_throws MethodError BareInterval(1)
    @test_throws MethodError BareInterval{Float64}(1)
    @test_throws MethodError BareInterval(1, 2)
    @test_throws MethodError BareInterval{Float64}(1, 2)

    @test !isguaranteed(Interval(1))
    @test !isguaranteed(Interval{Float64}(1))
    @test typeof(Interval(1//2)) == Interval{Rational{Int}}
    @test_throws MethodError Interval(1, 2)
    @test_throws MethodError Interval{Float64}(1, 2)
    @test_throws MethodError interval(Float64, com)

    @test isequal_interval(
        BareInterval{Float64}(bareinterval(3, 4)), BareInterval{BigFloat}(bareinterval(3, 4)),
        BareInterval{Rational{Int}}(bareinterval(3, 4)), BareInterval{Rational{BigInt}}(bareinterval(3, 4)),
        bareinterval(3, 4))

    @test isequal_interval(
        Interval{Float64}(interval(3, 4)), Interval{BigFloat}(interval(3, 4)),
        Interval{Rational{Int}}(interval(3, 4)), Interval{Rational{BigInt}}(interval(3, 4)),
        interval(3, 4))

    @test isempty_interval(@test_logs (:warn,) bareinterval(2, 1))
    @test isempty_interval(@test_logs (:warn,) bareinterval(Inf))
    @test isempty_interval(@test_logs (:warn,) bareinterval(-Inf))
    @test isempty_interval(@test_logs (:warn,) bareinterval(1, NaN))
    @test isempty_interval(@test_logs (:warn,) bareinterval(NaN))

    @test isnai(@test_logs (:warn, r"ill-formed interval") interval(2, 1))
    @test isnai(@test_logs (:warn,) interval(Inf))
    @test isnai(@test_logs (:warn,) interval(-Inf))
    @test isnai(@test_logs (:warn,) interval(1, NaN))
    @test isnai(@test_logs (:warn,) interval(NaN, 3))
    @test isnai(@test_logs (:warn,) interval(NaN))
    @test isnai(@test_logs (:warn,) interval(NaN, NaN))
    @test isnai(@test_logs (:warn,) interval(Inf, Inf))
    @test isnai(@test_logs (:warn,) interval(-Inf, -Inf))

    @test isnai(@test_logs (:warn,) interval(1//0))
    @test isnai(@test_logs (:warn,) interval(-1//0))

    @test isnai(@test_logs (:warn,) interval(1, 2, ill))

    @test bounds(interval(typemin(Int64), typemax(Int64))) == (float(typemin(Int64)), float(typemax(Int64)))

    @test !in_interval(1//10, interval(0.1, 0.2)) && in_interval(2//10, interval(0.1, 0.2))

    @test isequal_interval(interval(1//2), interval(0.5))
    @test inf(interval(1//10)) == 1//10 && sup(interval(1//10)) == 1//10
end

@testset "Rational bounds" begin
    f = 1 // 3
    g = 1 // 3
    @test isequal_interval(interval(f*g), interval(1//9))
    @test isequal_interval(interval(1//9), interval(1//9, 1//9))
    @test isequal_interval(interval(f, g) - interval(1//1), interval(-2//3, -2//3))
    @test issubset_interval(interval(f*g), interval(1)/interval(9))
end

@testset "Irrationals" begin
    for irr ∈ (MathConstants.:π, MathConstants.:γ, MathConstants.:catalan, MathConstants.:φ, MathConstants.:ℯ)
        for T ∈ (Float16, Float32, Float64, BigFloat)
            @test in_interval(irr, interval(T, irr))
            if T !== BigFloat
                @test nextfloat(inf(interval(T, irr))) == sup(interval(T, irr))
            end
        end
        for T ∈ [InteractiveUtils.subtypes(Signed) ; InteractiveUtils.subtypes(Unsigned)]
            @test in_interval(irr, interval(Rational{T}, irr))
        end
    end
end

@testset "Midpoint" begin
    @test isequal_interval(IntervalArithmetic.Symbols.:±(0.5, 1),
        interval(0.5, 1; format = :midpoint),
        interval(0.5, 1+0im; format = :midpoint),
        interval(0.5, interval(1+0im); format = :midpoint),
        interval(-0.5, 1.5))

    @test isequal_interval(IntervalArithmetic.Symbols.:±(interval(0.5, 1), interval(1, 2)),
        interval(interval(0.5, 1), interval(1, 2); format = :midpoint),
        interval(-1.5, 3))

    @test isequal_interval(IntervalArithmetic.Symbols.:±(0.5+im, 1),
        interval(0.5+im, 1; format = :midpoint),
        interval(0.5+im, 1+0im; format = :midpoint),
        interval(interval(0.5+im), interval(1+0im); format = :midpoint),
        complex(interval(-0.5, 1.5), interval(0, 2)))

    @test_throws DomainError interval(0.5+im, 1+im; format = :midpoint)
    @test_throws DomainError interval(0, -1; format = :midpoint)
    @test isequal_interval(interval(1, 0; format = :midpoint), interval(1, 1))
    @test isequal_interval(interval(1, 2; format = :midpoint), interval(-1, 3))
    @test isequal_interval(interval(1; format = :midpoint), interval(1, 1))
    @test_throws ArgumentError interval(1, 2; format = :bad)
    @test_throws ArgumentError interval(1; format = :bad)

    cm = interval(complex(1, 2), 1; format = :midpoint)
    @test isequal_interval(real(cm), interval(0, 2)) & isequal_interval(imag(cm), interval(1, 3))
    @test isequal_interval(interval(1, complex(1, 0); format = :midpoint), interval(0, 2))
end

@testset "Decorations" begin
    a = interval(1, 2)
    b = interval(1, 2, com)
    c = interval(1, 2, dac)
    d = interval(a, dac)

    @test decoration(a) == com
    @test decoration(b) == com
    @test decoration(c) == dac
    @test decoration(d) == dac
    @test decoration(interval(1, Inf)) == dac
    @test decoration(interval(1, 2, def)) == def

    x = @test_logs (:warn,) interval(2, 0.1)
    y = @test_logs (:warn,) interval(2, 0.1, com)
    @test decoration(x) == decoration(y) == ill

    z = interval(1//1, π)
    @test typeof(z) == Interval{Rational{Int64}}
    @test (inf(z) == 1//1) & (sup(z) == 85563208//27235615)
    @test (decoration(z) == com) & isguaranteed(z)
    w = interval(1, π)
    @test typeof(w) == Interval{Float64}
    @test bounds(w) == (1.0, 3.1415926535897936)
    @test (decoration(w) == com) & isguaranteed(w)
end

@testset "Constructor branches for intervals and mixed arguments" begin
    x = interval(interval(1, 2), interval(3, 4))
    @test isequal_interval(x, interval(1, 4))
    @test (decoration(x) == com) & isguaranteed(x)
    @test decoration(interval(interval(1, 2, def), interval(3, 4))) == def

    y = interval(entireinterval(), interval(3, 4))
    @test bounds(y) == (-Inf, 4.0)
    @test (decoration(y) == dac) & isguaranteed(y)

    e = @test_logs interval(emptyinterval(Interval{Float64}), emptyinterval(Interval{Float64}))
    @test isempty_interval(e) & (decoration(e) == trv) & isguaranteed(e)
    e_ng = _unsafe_interval(emptyinterval(BareInterval{Float64}), trv, false)
    @test !isguaranteed(interval(e_ng, emptyinterval(Interval{Float64})))

    z = @test_logs (:warn, r"invalid interval") interval(emptyinterval(Interval{Float64}), convert(Interval{Float64}, 1))
    @test isnai(z) & !isguaranteed(z)

    w = @test_logs (:warn, r"invalid interval") interval(interval(3, 4), interval(1, 2))
    @test isnai(w) & isguaranteed(w)
    w_ng = @test_logs (:warn,) interval(interval(3, 4, def), convert(Interval{Float64}, 1))
    @test isnai(w_ng) & !isguaranteed(w_ng)

    v = @test_logs (:warn,) interval(interval(1, 2), interval(3, 4), ill)
    @test isnai(v) & isguaranteed(v)
    v_ng = @test_logs (:warn,) interval(convert(Interval{Float64}, 1), interval(3, 4), ill)
    @test isnai(v_ng) & !isguaranteed(v_ng)

    m = interval(convert(Interval{Float64}, 1), 4.0)
    @test isequal_interval(m, interval(1, 4)) & !isguaranteed(m) & (decoration(m) == com)
    m2 = interval(1.0, convert(Interval{Float64}, 1))
    @test !isguaranteed(m2)
    m3 = @test_logs (:warn, r"invalid interval") interval(convert(Interval{Float64}, 2), 1.0)
    @test isnai(m3) & isguaranteed(m3)

    @test !isguaranteed(interval(convert(Interval{Float64}, 0), interval(convert(Interval{Float64}, 1))))
    @test !isguaranteed(interval(0, convert(Interval{Float64}, 1)))
    @test !isguaranteed(interval(convert(Interval{Float64}, 0), 1))

    c = interval(complex(1, 2), complex(3, 4))
    @test typeof(c) == Complex{Interval{Float64}}
    @test isequal_interval(real(c), interval(1, 3)) & isequal_interval(imag(c), interval(2, 4))
    c2 = interval(complex(1, 2))
    @test isequal_interval(real(c2), interval(1)) & isequal_interval(imag(c2), interval(2))
    c3 = interval(1, complex(3, 4))
    @test isequal_interval(real(c3), interval(1, 3)) & isequal_interval(imag(c3), interval(0, 4))

    A = interval([1, 2], [3, 4])
    @test A isa Vector{Interval{Float64}}
    @test isequal_interval(A[1], interval(1, 3)) & isequal_interval(A[2], interval(2, 4))
    @test interval(Float32[1], Float32[2]) isa Vector{Interval{Float32}}
end

@testset "Complex" begin
    x = interval(1 + 2im)
    @test typeof(x) == Complex{Interval{Float64}}
    @test isequal_interval(x, complex(interval(1), interval(2)))

    a = interval(1im)
    @test typeof(a) == Complex{Interval{Float64}}
    @test isequal_interval(a, interval(0) + interval(1)*interval(im))

    @test isequal_interval(interval(-1 - im, 0), interval(-1 - im, 0 + 0im))
    @test isequal_interval(interval(0, 1 + im), interval(0 + 0im, 1 + im))
end

@testset "Conversions and promotions" begin
    bx = bareinterval(Float64, π)
    by = bareinterval(BigFloat, π)
    big_bx, big_by = promote(bx, by)
    @test promote_type(typeof(bx), typeof(by)) == typeof(big_bx) == BareInterval{BigFloat}
    @test isequal_interval(big_bx, BareInterval{BigFloat}(bx))
    @test isequal_interval(big_by, by)
    @test_throws MethodError convert(BareInterval, 1)
    @test_throws MethodError convert(BareInterval{Float64}, 1)

    x = interval(Float64, π)
    y = interval(BigFloat, π)
    big_x, big_y = promote(x, y)
    @test promote_type(typeof(x), typeof(y)) == typeof(big_x) == Interval{BigFloat}
    @test isequal_interval(big_x, Interval{BigFloat}(x))
    @test isequal_interval(big_y, y)

    @test promote_type(Interval{Float64}, Interval{Float32}) == Interval{Float64}
    @test promote_type(Interval{Float64}, Int) == Interval{Float64}
    @test promote_type(Int, Interval{Float32}) == Interval{Float32}
    @test promote_type(Bool, Interval{Float32}) == Interval{Float32}
    @test promote_type(Interval{Float32}, Bool) == Interval{Float32}
    @test promote_type(Interval{Float64}, BigFloat) == Interval{BigFloat}
    @test promote_type(BigFloat, Interval{Float64}) == Interval{BigFloat}
    @test promote_type(Interval{Float64}, Irrational{:π}) == Interval{Float64}
    @test promote_type(Irrational{:π}, Interval{Float64}) == Interval{Float64}

    p = promote(interval(1), 1)
    @test (p isa Tuple{Interval{Float64},Interval{Float64}}) & isguaranteed(p[1]) & !isguaranteed(p[2])

    @test isequal_interval(convert(Interval{Float64}, 1), interval(1))
    @test !isguaranteed(convert(Interval{Float64}, 1)) && isguaranteed(interval(1))
    @test isequal_interval(convert(Complex{Interval{Float64}}, 1), interval(1+0im))
    @test !isguaranteed(convert(Complex{Interval{Float64}}, 1)) && isguaranteed(interval(1+0im))
    @test isequal_interval(convert(Complex{Interval{Float64}}, im), interval(im))
    @test !isguaranteed(convert(Complex{Interval{Float64}}, im)) && isguaranteed(interval(im))
    @test isequal_interval(convert(Interval{Float64}, 1+0im), convert(Interval{Float64}, interval(1+0im)), interval(1))
    @test !isguaranteed(convert(Interval{Float64}, 1+0im))
    @test_throws DomainError convert(Interval{Float64}, 1+im)
    @test_throws DomainError convert(Interval{Float64}, interval(1+im))

    @test isguaranteed(convert(Interval{Float64}, π))
    @test bounds(convert(Interval{Float64}, π)) == (3.141592653589793, 3.1415926535897936)
    @test isguaranteed(convert(Interval{Float64}, interval(Float32, 1)))
    @test isguaranteed(Interval{Float64}(interval(Float32, 1)))
    @test isguaranteed(convert(Complex{Interval{Float64}}, interval(1)))
    @test isguaranteed(convert(Complex{Interval{Float64}}, π))
    @test isguaranteed(convert(Interval{Float64}, complex(interval(1), interval(0))))
    @test_throws DomainError convert(Interval{Float64}, complex(interval(1), interval(2)))
end

@testset "atomic" begin
    x = atomic(Float64, 0.1)
    @test bounds(x) == (0.09999999999999999, 0.1)
    @test (decoration(x) == com) & isguaranteed(x)
    @test in_interval(1//10, x)

    y = atomic(Float64, 0.3)
    @test bounds(y) == (0.3, 0.30000000000000004)
    @test in_interval(3//10, y)

    @test isequal_interval(atomic(Float64, 1), interval(1))
    @test isequal_interval(atomic(Float64, π), interval(Float64, π))
    @test isequal_interval(atomic(Float64, interval(1, 2)), interval(1, 2))
    @test isequal_interval(atomic(Float64, "0.1"), atomic(Float64, 0.1))
    @test bounds(atomic(Float32, 0.1)) === (0.099999994f0, 0.1f0)
    @test bounds(atomic(Rational{Int64}, 0.1)) == (1//10, 1//10)
    @test bounds(atomic(Float64, big"0.1")) == (0.09999999999999999, 0.1)
    @test isequal_interval(atomic(0.1), atomic(Float64, 0.1))
end

@testset "`@interval` macro" begin
    x = 1
    T = Float32
    @test isequal_interval(@interval(sin(1)), sin(interval(1)))
    @test bounds(@interval sin(1)) == (0.8414709848078965, 0.8414709848078966)
    @test isguaranteed(@interval sin(1))
    @test isequal_interval(@interval(Float32, sin(1)), sin(interval(Float32, 1)))
    @test bounds(@interval Float32 sin(1)) === (0.84147096f0, 0.841471f0)
    @test isequal_interval(@interval(Float64, x), interval(1))
    @test isequal_interval(@interval(T, sin(x)), sin(interval(Float32, 1)))
    @test isequal_interval(@interval(Float64, sin(1), exp(1)), interval(inf(sin(interval(1))), sup(exp(interval(1)))))
    @test bounds(@interval sin(1) exp(1)) == (0.8414709848078965, 2.7182818284590455)
    @test bounds(@interval Float64 sin(1) exp(1)) == (0.8414709848078965, 2.7182818284590455)
    @test isequal_interval(@interval(1, 2), interval(1, 2))
    @test isequal_interval(@interval(x, 2), interval(1, 2))
    @test isequal_interval(@interval(exp(1), exp(1)), exp(interval(1)))
    @test isequal_interval(@interval(sin(1), exp(1)), interval(inf(sin(interval(1))), sup(exp(interval(1)))))
    @test isequal_interval(@interval(3, sin(5) + 10), interval(3, sup(sin(interval(5)) + interval(10))))
    @test typeof(@interval Float32 1 2) == Interval{Float32}

    @test isequal_interval(@interval(0.1), atomic(Float64, 0.1))
    let x = 3
        @test isequal_interval(@interval(x), interval(3))
    end
    @test isequal_interval(@interval(big"0.1"), atomic(Float64, big"0.1"))
    A = [1.0, 2.0]
    @test isequal_interval(@interval(A[1]), interval(1))
    @test isequal_interval(@interval(Base.MathConstants.pi), atomic(Float64, π))
    @test isequal_interval(@interval(2^3), interval(8))
    @test bounds(@interval sqrt(2)) == (1.414213562373095, 1.4142135623730951)

    @test isnai(@test_logs (:warn,) @interval(2, 1))
    @test isnai(@test_logs (:warn,) @interval(x, sin(x)))
    @test isnai(@test_logs (:warn,) @interval(Float64, 2, 1))

    @test _atomic(Float64, Float32) === Float32
    @test isequal_interval(_atomic(Float64, 0.1), atomic(Float64, 0.1))
end

@testset "Loop variables" begin
    i = 1

    @test inf(interval(i, i)) == 1
    @test inf(interval(i)) == 1

    for i ∈ 1:10
        a = interval(i)
        @test inf(a) == i
    end
end

@testset "ExactReal interoperability" begin
    x = interval(exact(0.1))
    @test bounds(x) == (0.1, 0.1)
    @test isguaranteed(x)
    y = interval(exact(1), 2)
    @test isequal_interval(y, interval(1, 2)) & isguaranteed(y)
end
