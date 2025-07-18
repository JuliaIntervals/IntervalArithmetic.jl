@testset "Difference between checked and unchecked bare intervals" begin
    @test IntervalArithmetic._unsafe_bareinterval(Float64, 1, 2) === bareinterval(1, 2)

    @test inf(IntervalArithmetic._unsafe_bareinterval(Float64, 3, 2)) == 3
    @test isempty_interval(bareinterval(3, 2))
    @test isnai(interval(3, 2))

    # `:set_based` flavor
    @test sup(IntervalArithmetic._unsafe_bareinterval(Float64, Inf, Inf)) == Inf
    @test isempty_interval(bareinterval(Inf, Inf))
    @test isnai(interval(Inf, Inf))
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

    @test inf(interval(1, 2)) == 1 && sup(interval(1, 2)) == 2

    @test isequal_interval(
        interval(Float64, 1, 1), interval(Float64, 1), interval(1),
        interval(Float64, interval(1)), interval(interval(1)),
        interval(BigFloat, 1, 1), interval(BigFloat, 1), interval(big(1)),
        interval(Float64, 1, 1), interval(1, 1), interval(Float64, 1), interval(1))

    @test isequal_interval(
        interval(Rational{Int}, 1//10, 1//10), interval(1//10, 1//10), interval(Rational{Int}, 1//10), interval(1//10),
        interval(Rational{Int}, interval(1//10)), interval(interval(1//10)),
        interval(Rational{BigInt}, 1//10, 1//10), interval(Rational{BigInt}, 1//10), interval(big(1//10)),
        interval(Rational{Int}, 1//10, 1//10), interval(1//10, 1//10), interval(Rational{Int}, 1//10), interval(1//10))

    @test_throws MethodError BareInterval(1)
    @test_throws MethodError BareInterval{Float64}(1)
    @test_throws MethodError BareInterval(1, 2)
    @test_throws MethodError BareInterval{Float64}(1, 2)

    @test !isguaranteed(Interval(1))
    @test !isguaranteed(Interval{Float64}(1))
    @test_throws MethodError Interval(1, 2)
    @test_throws MethodError Interval{Float64}(1, 2)

    @test isequal_interval(
        BareInterval{Float64}(bareinterval(3, 4)), BareInterval{BigFloat}(bareinterval(3, 4)),
        BareInterval{Rational{Int}}(bareinterval(3, 4)), BareInterval{Rational{BigInt}}(bareinterval(3, 4)),
        bareinterval(3, 4))

    @test isequal_interval(
        Interval{Float64}(interval(3, 4)), Interval{BigFloat}(interval(3, 4)),
        Interval{Rational{Int}}(interval(3, 4)), Interval{Rational{BigInt}}(interval(3, 4)),
        interval(3, 4))

    @test isempty_interval(bareinterval(2, 1))
    @test isempty_interval(bareinterval(Inf))
    @test isempty_interval(bareinterval(-Inf))
    @test isempty_interval(bareinterval(1, NaN))
    @test isempty_interval(bareinterval(NaN))

    @test isnai(interval(2, 1))
    @test isnai(interval(Inf))
    @test isnai(interval(-Inf))
    @test isnai(interval(1, NaN))
    @test isnai(interval(NaN))

    # check no issue with `Integer` modular arithmetic
    @test bounds(interval(typemin(Int64), typemax(Int64))) == (float(typemin(Int64)), float(typemax(Int64)))

    # 1//10 < 0.1, 2//10 < 0.2
    @test !in_interval(1//10, interval(0.1, 0.2)) && in_interval(2//10, interval(0.1, 0.2))

    @test isequal_interval(interval(1//2), interval(0.5))
    @test inf(interval(1//10)) == 1//10 && sup(interval(1//10)) == 1//10

    x = interval(1 + 2im)
    @test typeof(x) == Complex{Interval{Float64}}
    @test isequal_interval(x, complex(interval(1), interval(2)))

    @test IntervalArithmetic.Symbols.:..(1, 2) === interval(1, 2; format = :infsup)
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
end

@testset "Decorations" begin
    a = interval(1, 2)
    b = interval(1, 2, IntervalArithmetic.com)
    c = interval(1, 2, IntervalArithmetic.dac)
    d = interval(a, IntervalArithmetic.dac)

    @test decoration(a) == IntervalArithmetic.com
    @test decoration(b) == IntervalArithmetic.com
    @test decoration(c) == IntervalArithmetic.dac
    @test decoration(d) == IntervalArithmetic.dac

    @test decoration(interval(2, 0.1)) == decoration(interval(2, 0.1, IntervalArithmetic.com)) == IntervalArithmetic.ill
end

@testset "Conversions and promotions" begin
    bx = bareinterval(Float64, π)
    by = bareinterval(BigFloat, π)
    big_bx, big_by = promote(bx, by)
    @test promote_type(typeof(bx), typeof(by)) == typeof(big_bx) == BareInterval{BigFloat}
    @test isequal_interval(big_bx, BareInterval{BigFloat}(bx))
    @test isequal_interval(big_by, by)
    # cannot convert a `Real` to a `BareInterval`
    @test_throws MethodError convert(BareInterval, 1)
    @test_throws MethodError convert(BareInterval{Float64}, 1)

    x = interval(Float64, π)
    y = interval(BigFloat, π)
    big_x, big_y = promote(x, y)
    @test promote_type(typeof(x), typeof(y)) == typeof(big_x) == Interval{BigFloat}
    @test isequal_interval(big_x, Interval{BigFloat}(x))
    @test isequal_interval(big_y, y)
    # can convert a `Real` to an `Interval`
    @test isequal_interval(convert(Interval{Float64}, 1), interval(1)) & (isguaranteed(convert(Interval{Float64}, 1)) == !isguaranteed(interval(1)))
    @test isequal_interval(convert(Complex{Interval{Float64}}, 1), interval(1+0im)) & (isguaranteed(convert(Complex{Interval{Float64}}, 1)) == !isguaranteed(interval(1+0im)))
    @test isequal_interval(convert(Complex{Interval{Float64}}, im), interval(im)) & (isguaranteed(convert(Complex{Interval{Float64}}, im)) == !isguaranteed(interval(im)))
    @test isequal_interval(convert(Interval{Float64}, 1+0im), convert(Interval{Float64}, interval(1+0im)), interval(1))
    @test_throws DomainError convert(Interval{Float64}, 1+im)
    @test_throws DomainError convert(Interval{Float64}, interval(1+im))
end

@testset "Interval types conversion" begin
    i = interval(IS.Interval(1, 2))
    @test isequal_interval(i, interval(1., 2.)) && !isguaranteed(i)
    i = interval(IS.Interval(0.1, 2))
    @test isequal_interval(i, interval(0.1, 2.)) && !isguaranteed(i)
    @test interval(Float64, IS.Interval(0.1, 2)) === i

    i = interval(IS.iv"[0.1, Inf)")
    @test isequal_interval(i, interval(0.1, Inf)) && !isguaranteed(i)
    @test interval(IS.iv"[0.1, Inf]") === nai(Float64)
    @test interval(IS.iv"(0.1, Inf]") === nai(Float64)
    @test interval(IS.iv"(0.1, Inf)") === nai(Float64)
    @test interval(IS.iv"(0.1, 1)") === nai(Float64)
    @test interval(IS.iv"(0.1, 1]") === nai(Float64)

    @test IS.Interval(interval(1, 2)) === IS.Interval(1., 2.)
    @test IS.Interval(interval(0.1, 2)) === IS.Interval(0.1, 2.)
    @test IS.Interval(interval(0.1, Inf)) === IS.iv"[0.1, Inf)"
    @test IS.Interval(interval(-Inf, Inf)) === IS.iv"(-Inf, Inf)"
end

@testset "Propagation of `isguaranteed`" begin
    @test !isguaranteed(interval(convert(Interval{Float64}, 0), interval(convert(Interval{Float64}, 1))))
    @test !isguaranteed(interval(0, convert(Interval{Float64}, 1)))
    @test !isguaranteed(interval(convert(Interval{Float64}, 0), 1))
end
