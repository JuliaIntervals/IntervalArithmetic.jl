using Test
using IntervalArithmetic
using Random

@testset "inf and sup" begin
    @test inf(bareinterval(0, 1)) === -0.0
    @test signbit(inf(bareinterval(0, 1)))
    @test inf(bareinterval(1, 2)) == 1.0
    @test inf(bareinterval(-1, 0)) == -1.0
    x = inf(bareinterval(BigFloat, 0, 1))
    @test (x isa BigFloat) & iszero(x) & signbit(x)
    @test inf(bareinterval(0//1, 1//1)) == 0//1
    @test !signbit(inf(bareinterval(0//1, 1//1)))
    @test inf(emptyinterval(BareInterval{Float64})) == Inf
    @test isnan(inf(nai()))
    @test_throws ArgumentError inf(nai(Interval{Rational{Int}}))
    @test inf(0) === -0.0
    @test inf(1.5) == 1.5
    @test inf(2.5) == 2.5

    a = interval(0.1, 1.1)
    @test inf(a) == inf(bareinterval(a))
    @test sup(a) == sup(bareinterval(a))
    @test inf(emptyinterval(a)) == Inf
    @test sup(emptyinterval(a)) == -Inf
    @test inf(entireinterval(a)) == -Inf
    @test sup(entireinterval(a)) == Inf
    @test isnan(sup(nai(BigFloat)))

    @test sup(bareinterval(1, 2)) == 2.0
    @test sup(bareinterval(-1, 0)) === 0.0
    @test !signbit(sup(bareinterval(-1, 0)))
    @test sup(emptyinterval(BareInterval{Float64})) == -Inf
    @test isnan(sup(nai()))
    @test_throws ArgumentError sup(nai(Interval{Rational{Int}}))
    @test sup(2) == 2.0
end

@testset "bounds" begin
    @test bounds(bareinterval(0, 1)) === (0.0, 1.0)
    @test bounds(bareinterval(0.0, 1.0)) === (0.0, 1.0)
    @test bounds(emptyinterval(BareInterval{Float64})) === (Inf, -Inf)
    @test all(isnan, bounds(nai()))
    @test_throws ArgumentError bounds(nai(Interval{Rational{Int}}))
    @test bounds(1.5) === (1.5, 1.5)
    @test bounds(interval(0, 1)) === (0.0, 1.0)
end

@testset "mid" begin
    @test mid(bareinterval(1, 2)) == 1.5
    @test mid(bareinterval(1, 2), 0.25) == 1.25
    @test mid(bareinterval(1, 2)) == mid(bareinterval(1, 2), 0.5)
    @test mid(interval(1, 2)) == 1.5
    @test mid(interval(0.1, 0.3)) == 0.2
    @test mid(interval(-10, 5)) == -2.5
    @test mid(interval(2), 0.4969816845401611) == 2
    @test mid(interval(0, 1), 0.75) == 0.75
    @test mid(interval(0, 1000), 0.125) == 125

    @test_throws DomainError mid(bareinterval(1, 2), 1.2)
    @test_throws DomainError mid(bareinterval(1//1, 2//1), 3//2)
    @test_throws DomainError mid(interval(1, 2), 1.2)
    @test_throws DomainError mid(interval(1, 2), -0.7)
    @test_throws DomainError mid(interval(Rational{Int}, 1, 2), -1//2)

    @test isnan(mid(emptyinterval(BareInterval{Float64})))
    @test isnan(mid(emptyinterval()))
    @test_throws ArgumentError mid(emptyinterval(BareInterval{Rational{Int}}))
    @test isnan(mid(nai()))
    @test_throws ArgumentError mid(nai(Interval{Rational{Int}}))

    @test mid(entireinterval(BareInterval{Float64})) == 0.0
    @test mid(entireinterval()) == 0.0
    @test mid(entireinterval(BareInterval{Float64}), 0.75) == prevfloat(typemax(Float64)) == floatmax(Float64)
    @test mid(entireinterval(BareInterval{Float64}), 0.25) == nextfloat(typemin(Float64)) == -floatmax(Float64)
    @test mid(interval(-Inf, Inf), 0.75) > 0
    @test mid(interval(-Inf, Inf), 0.25) < 0
    @test mid(entireinterval(BareInterval{Rational{Int64}})) == 0//1
    @test mid(entireinterval(BareInterval{Rational{Int64}}), 3//4) == Rational{Int64}(typemax(Int64))
    @test mid(entireinterval(BareInterval{Rational{Int64}}), 1//4) == Rational{Int64}(typemin(Int64))

    # `α` acts as a threshold: the finite bound is reachable when `α` selects its side
    @test mid(bareinterval(-Inf, 1)) == -floatmax(Float64)
    @test mid(bareinterval(1, Inf)) == floatmax(Float64)
    for α ∈ (0.25, 0.5, 0.75)
        @test mid(bareinterval(-Inf, 1), α) == -floatmax(Float64)
        @test mid(bareinterval(1, Inf), α) == floatmax(Float64)

        @test_throws DomainError mid(x, 0.0)
        @test_throws DomainError mid(x, 1.0)
    end
    # `typemin`/`typemax` do not exist for `BigInt`, so the clamp throws an informative error
    @test mid(entireinterval(BareInterval{Rational{BigInt}})) == 0//1
    @test midradius(entireinterval(BareInterval{Rational{BigInt}})) == (0//1, 1//0)
    @test_throws ArgumentError mid(bareinterval(Rational{BigInt}(-1, 0), Rational{BigInt}(1)))
    @test_throws "no smallest finite" mid(bareinterval(Rational{BigInt}(-1, 0), Rational{BigInt}(1)))
    @test_throws "no largest finite" mid(entireinterval(BareInterval{Rational{BigInt}}), 0.75)

    @test mid(interval(-Inf, 1)) == nextfloat(-Inf)
    @test mid(interval(1, Inf)) == prevfloat(Inf)
    @test mid(interval(1, Inf), 0.75) > 0

    @test mid(bareinterval(1, 1)) == 1.0
    @test mid(bareinterval(-1, 1)) === 0.0
    @test mid(interval(Rational{Int}, 1//2)) == 1//2

    for x ∈ (bareinterval(0, 1), bareinterval(-1e308, 1e308), bareinterval(0.1, 0.3), bareinterval(-Inf, 1), bareinterval(1, Inf), entireinterval(BareInterval{Float64}))
        for α ∈ (0.25, 0.5, 0.75)
            @test inf(x) ≤ mid(x, α) ≤ sup(x)
        end

        @test_throws DomainError mid(x, 0.0)
        @test_throws DomainError mid(x, 1.0)
    end

    @test mid(bareinterval(-1e308, 1e308), 0.25) == -5.0e307
    @test isfinite(mid(bareinterval(-1e308, 1e308), 0.25))
    @test mid(bareinterval(-1e308, 1e308)) == 0.0
    @test mid(interval(0.8e308, 1.2e308)) == 1e308
    @test mid(interval(-1e308, 1e308)) == 0
    @test isfinite(mid(interval(0.8e308, 1.2e308)))
    @test isfinite(mid(interval(-1e308, 1e308)))

    @test mid(bareinterval(1//3, 2//3)) == 1//2
    @test mid(bareinterval(Float32, 1, 2)) isa Float32
    @test mid(bareinterval(BigFloat, 1, 2)) isa BigFloat

    @test mid(interval(0.25, 4.0)) == 2.125
    @test mid(2.125) == 2.125
    @test mid(2.0, 0.25) == 2.0
    @test mid(complex(interval(0, 3), interval(0, 4))) == 1.5 + 2im
    @test mid([interval(0, 1), interval(1, 3)]) == [0.5, 2.0]
end

@testset "diam" begin
    @test diam(bareinterval(1, 2)) == 1.0
    @test diam(bareinterval(1, 1)) == 0.0
    @test diam(bareinterval(0.1, 1.1)) == 1.0000000000000002 == nextfloat(1.0)
    @test diam(interval(0.1, 1.1)) == 1.0000000000000002

    for x ∈ (bareinterval(0.1, 1.1), bareinterval(-0.3, 0.7), bareinterval(1, 2), bareinterval(1e-300, 1e300), bareinterval(0.1, nextfloat(0.1)))
        @test diam(x) ≥ sup(x) - inf(x)
    end

    @test diam(entireinterval(BareInterval{Float64})) == Inf
    @test diam(bareinterval(-1e308, 1e308)) == Inf
    @test isbounded(bareinterval(-1e308, 1e308))

    @test isnan(diam(emptyinterval(BareInterval{Float64})))
    @test isnan(diam(emptyinterval()))
    @test_throws ArgumentError diam(emptyinterval(BareInterval{Rational{Int}}))
    @test isnan(diam(nai()))
    @test_throws ArgumentError diam(nai(Interval{Rational{Int}}))

    @test diam(bareinterval(1//3, 1//2)) == 1//6
    @test diam(interval(Rational{Int}, 1//2)) == 0//1
    @test diam(interval(1//10)) == 0
    @test diam(I"0.1") == eps(0.1)

    @test diam(0.1) == 0
    @test diam(complex(interval(0, 1), interval(0, 3))) == 3.0
end

@testset "radius and midradius" begin
    @test midradius(bareinterval(1, 2)) == (1.5, 0.5)
    @test radius(bareinterval(1, 2)) == 0.5

    for x ∈ (bareinterval(0.0, nextfloat(0.0, 3)), bareinterval(-1, 1e10), bareinterval(0.1, 1.1))
        m, r = midradius(x)
        @test radius(x) == r
        @test (m - r ≤ inf(x)) & (sup(x) ≤ m + r)
    end

    # the radius is rounded upward (Section 12.12.8), so `mid(x) ± radius(x)` encloses `x`;
    # with round-to-nearest this fails for about half of the wide intervals
    enclosed(x) = issubset_interval(interval(inf(x), sup(x)), interval(midradius(x)...; format = :midpoint))
    @test enclosed(bareinterval(-3.514641998989496e-149, 2.2210542297708545e247))
    @test enclosed(bareinterval(-floatmin(Float64), 1.3))
    rng = MersenneTwister(20260910)
    @test all(1:10^4) do _
        lo, hi = minmax(reinterpret(Float64, rand(rng, UInt64)), reinterpret(Float64, rand(rng, UInt64)))
        (isfinite(lo) & isfinite(hi)) || return true
        return enclosed(bareinterval(lo, hi))
    end

    @test radius(entireinterval(BareInterval{Float64})) == Inf
    @test mid(entireinterval(BareInterval{Float64})) == 0.0

    @test midradius(entireinterval(BareInterval{Rational{Int64}})) == (0//1, 1//0)

    @test_throws "cannot compute the midpoint" radius(emptyinterval(BareInterval{Rational{Int}}))
    @test_throws "cannot compute the midpoint" midradius(emptyinterval(BareInterval{Rational{Int}}))

    @test isnan(radius(emptyinterval()))
    @test isnan(radius(nai()))
    @test all(isnan, midradius(nai()))
    @test_throws "cannot compute the radius of an NaI" radius(nai(Interval{Rational{Int}}))
    @test_throws "cannot compute the midpoint and radius of an NaI" midradius(nai(Interval{Rational{Int}}))

    @test radius(interval(Rational{Int}, -1//10, 1//10)) == diam(interval(Rational{Int}, -1//10, 1//10)) / 2
    @test radius(2.125) == 0
    @test radius(complex(interval(0, 1), interval(0, 3))) == 1.5
    @test midradius(complex(interval(0, 1), interval(0, 3))) == (0.5 + 1.5im, 1.5)
end

@testset "mag and mig" begin
    @test mag(bareinterval(-3, 2)) == 3.0
    @test mag(bareinterval(1, 2)) == 2.0
    @test mag(entireinterval(BareInterval{Float64})) == Inf
    @test mag(-interval(0.9, 2.0)) == sup(interval(0.9, 2.0))
    @test mag(interval(Rational{Int}, 1//2)) == 1//2
    @test isnan(mag(emptyinterval(BareInterval{Float64})))
    @test isnan(mag(emptyinterval()))
    @test_throws ArgumentError mag(emptyinterval(BareInterval{Rational{Int}}))
    @test isnan(mag(nai()))
    @test_throws ArgumentError mag(nai(Interval{Rational{Int}}))
    @test mag(-3) == 3.0
    @test mag(complex(interval(0, 3), interval(0, 4))) == 5
    @test mag(complex(interval(1, 2), interval(3, 4))) == 4.47213595499958

    @test mig(bareinterval(-3, 2)) == 0.0
    @test mig(bareinterval(2, 3)) == 2.0
    @test mig(bareinterval(-3, -2)) == 2.0
    @test mig(entireinterval(BareInterval{Float64})) == 0.0
    @test mig(interval(-2, 2)) == BigFloat(0.0)
    @test mig(interval(Rational{Int}, 1//2)) == 1//2
    @test mig(bareinterval(-1//2, 1//2)) == 0//1
    @test mig(bareinterval(1//2, 3//2)) isa Rational{Int}
    @test isnan(mig(emptyinterval(BareInterval{Float64})))
    @test isnan(mig(emptyinterval()))
    @test_throws ArgumentError mig(emptyinterval(BareInterval{Rational{Int}}))
    @test isnan(mig(nai()))
    @test_throws ArgumentError mig(nai(Interval{Rational{Int}}))
    @test mig(-3) == 3.0
    @test mig(complex(interval(0, 3), interval(0, 4))) == 0
    @test mig(complex(interval(1, 2), interval(3, 4))) == 3.162277660168379

    # an empty component makes the whole complex interval empty: NaN, not a negative magnitude
    @test isnan(mag(complex(emptyinterval(), interval(1, 2))))
    @test isnan(mag(complex(interval(1, 2), emptyinterval())))
    @test isnan(mig(complex(emptyinterval(), interval(1, 2))))
    @test isnan(mig(complex(interval(1, 2), emptyinterval())))
    @test_throws ArgumentError mag(complex(emptyinterval(Interval{Rational{Int}}), interval(Rational{Int}, 1, 2)))
    @test_throws ArgumentError mig(complex(emptyinterval(Interval{Rational{Int}}), interval(Rational{Int}, 1, 2)))
end

@testset "dist" begin
    @test dist(bareinterval(1, 2), bareinterval(1.5, 3)) == 1.0
    @test dist(bareinterval(1, 2), bareinterval(1, 2)) == 0.0
    @test dist(interval(1, 2), interval(3, 4)) == 2.0
    @test dist(interval(0.1), interval(0.1, 0.1)) <= inf(eps(interval(0.1)))

    @test isnan(dist(emptyinterval(BareInterval{Float64}), bareinterval(1, 2)))
    @test isnan(dist(bareinterval(1, 2), emptyinterval(BareInterval{Float64})))
    @test_throws ArgumentError dist(emptyinterval(BareInterval{Rational{Int}}), bareinterval(1//1, 2//1))

    @test dist(bareinterval(Float32, 1, 2), bareinterval(1.5, 3)) === 1.0
    @test dist(interval(Float32, 1, 2), interval(1.5, 3)) === 1.0

    @test isnan(dist(nai(), interval(1, 2)))
    @test_throws ArgumentError dist(nai(Interval{Rational{Int}}), interval(Rational{Int}, 1, 2))

    # equal infinite bounds contribute 0 rather than `Inf - Inf`
    @test dist(entireinterval(), entireinterval()) == 0.0
    @test dist(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) == 0.0
    @test dist(interval(-Inf, 0), interval(-Inf, 1)) == 1.0
    @test dist(interval(0, Inf), interval(1, Inf)) == 1.0
    @test dist(interval(-Inf, 0), interval(0, Inf)) == Inf
    # `(-1//0) - (-1//0)` throws a `DivideError`, so the rational path needs the same guard
    @test dist(interval(Rational{Int}, -1//0, 0//1), interval(Rational{Int}, -1//0, 1//1)) == 1//1
    @test dist(entireinterval(BareInterval{Rational{Int}}), entireinterval(BareInterval{Rational{Int}})) == 0//1

    @test_throws MethodError dist(1, 2)
end

@testset "bound type preservation" begin
    for T ∈ (Float16, Float32, Float64, BigFloat)
        x = bareinterval(T, 1, 2)
        @test inf(x) isa T
        @test sup(x) isa T
        @test bounds(x) isa Tuple{T,T}
        @test mid(x) isa T
        @test diam(x) isa T
        @test radius(x) isa T
        @test midradius(x) isa Tuple{T,T}
        @test mag(x) isa T
        @test mig(x) isa T
        @test dist(x, x) isa T
    end
    for T ∈ (Rational{Int32}, Rational{Int64})
        x = bareinterval(T(1), T(2))
        @test inf(x) isa T
        @test sup(x) isa T
        @test mid(x) isa Rational
        @test diam(x) isa T
        @test radius(x) isa Rational
        @test mag(x) isa T
        @test mig(x) isa T
        @test dist(x, x) isa T
    end
    x = bareinterval(1//1, 2//1)
    @test mid(x) isa Rational{Int}
    @test radius(x) isa Rational{Int}
end
