@testset "IntervalArithmeticThickNumbersExt" begin
    # ThickNumbers.jl is not yet registered in the General registry, so it cannot be
    # listed as an ordinary test dependency in test/Project.toml without breaking
    # `Pkg.instantiate` for everyone else. Run this testset only when ThickNumbers is
    # already present in the active environment (e.g. added there with `Pkg.develop`).
    if Base.find_package("ThickNumbers") === nothing
        @info "ThickNumbers.jl is not available in this environment; skipping IntervalArithmeticThickNumbersExt tests. Pkg.develop it locally to run them (it is not yet registered in General)."
    else
        import ThickNumbers as TN
        import ThickNumbers: ≺, ≻, ⪯, ⪰, ⫃, ⪽, ⫄, ⪾, ≐, ⩪

        @testset "isthick trait" begin
            @test TN.isthick(Interval)
            @test TN.isthick(Interval{Float64})
            @test TN.isthick(interval(1, 2))
        end

        @testset "lohi / loval / hival round trip" begin
            x = TN.lohi(Interval{Float64}, 1 / 3, nextfloat(2 / 3))
            @test x isa Interval{Float64}
            @test TN.loval(x) == inf(x)
            @test TN.hival(x) == sup(x)
            @test in_interval(1 / 3, x)
            @test in_interval(nextfloat(2 / 3), x)
            @test TN.loval(x) ≈ 1 / 3
            @test TN.hival(x) ≈ nextfloat(2 / 3)

            y = TN.lohi(Interval, 1, 2)
            @test y isa Interval{Float64}
            @test TN.loval(y) == 1.0
            @test TN.hival(y) == 2.0

            # invalid bounds: IA's validating constructor warns and returns NaI, it
            # does not throw.
            local bad
            @test_logs (:warn,) begin
                bad = TN.lohi(Interval{Float64}, 2.0, 1.0)
            end
            @test isnai(bad)
        end

        @testset "midrad / mid / rad round trip" begin
            x = TN.midrad(Interval{Float64}, 1 / 2, 1 / 6)
            @test x isa Interval{Float64}
            @test in_interval(1 / 2, x)
            @test 1 / 6 <= TN.rad(x)
            @test TN.rad(x) ≈ 1 / 6
            @test TN.mid(x) ≈ 1 / 2

            y = TN.midrad(Interval, 1.0, 2.0)
            @test y isa Interval{Float64}
            @test TN.valuetype(y) === Float64

            # IA's midpoint-format `interval` constructor throws `DomainError` for a
            # negative radius, rather than silently producing an empty interval (the
            # behavior of ThickNumbers' generic `midrad` fallback).
            @test_throws DomainError TN.midrad(Interval{Float64}, 1.0, -1.0)
        end

        @testset "basetype / valuetype" begin
            @test TN.basetype(Interval) === Interval
            @test TN.basetype(Interval{Float64}) === Interval
            @test TN.basetype(interval(1, 2)) === Interval
            @test TN.valuetype(Interval{Float64}) === Float64
            @test TN.valuetype(interval(1, 2)) === Float64
            @test TN.valuetype(interval(BigFloat, 1, 2)) === BigFloat
        end

        @testset "emptyset / isempty_tn" begin
            e1 = TN.emptyset(Interval{Float64})
            e2 = TN.emptyset(Interval)
            e3 = TN.emptyset(interval(1.0, 2.0))
            @test isequal_interval(e1, emptyinterval(Float64))
            @test isequal_interval(e2, emptyinterval(Float64))
            @test isequal_interval(e3, emptyinterval(Float64))
            @test TN.isempty_tn(e1)
            @test !TN.isempty_tn(interval(1.0, 2.0))
            # NaI is not the empty set: `isempty_interval` (and hence `isempty_tn`)
            # returns `false` for it, `isnan_tn` returns `true`.
            @test !TN.isempty_tn(nai(Float64))
        end

        @testset "isnan_tn / isfinite_tn / isinf_tn" begin
            @test TN.isnan_tn(nai(Float64))
            @test !TN.isnan_tn(interval(1.0, 2.0))
            @test TN.isfinite_tn(interval(1.0, 2.0))
            @test !TN.isfinite_tn(interval(1.0, Inf))
            @test TN.isinf_tn(entireinterval())
            @test TN.isinf_tn(interval(1.0, Inf))
            @test !TN.isinf_tn(interval(1.0, 2.0))
            # NaI is neither finite nor infinite in this trait's sense.
            @test !TN.isfinite_tn(nai(Float64))
            @test !TN.isinf_tn(nai(Float64))
        end

        @testset "mid / wid / rad / mag / mig" begin
            x = interval(1.0, 3.0)
            @test TN.mid(x) == 2.0
            @test TN.wid(x) == 2.0
            @test TN.rad(x) == 1.0
            @test TN.mag(x) == 3.0
            @test TN.mig(x) == 1.0

            y = interval(-2.0, 0.5) # straddles zero
            @test TN.mig(y) == 0.0
            @test TN.mag(y) == 2.0
        end

        @testset "hull" begin
            x = interval(1.0, 3.0)
            y = interval(-2.0, 0.5)
            z = interval(10.0)
            e = emptyinterval(Float64)

            @test isequal_interval(TN.hull(x, y), interval(-2.0, 3.0))
            @test isequal_interval(TN.hull(x, y, z), interval(-2.0, 10.0))

            # `hull(emptyset, x) == x`, relying on `inf(emptyset) == +Inf` and
            # `sup(emptyset) == -Inf`: downstream branch-and-bound code depends on
            # this identity.
            @test inf(e) == Inf
            @test sup(e) == -Inf
            @test isequal_interval(TN.hull(e, x), x)
            @test isequal_interval(TN.hull(x, e), x)
        end

        @testset "subset / superset operators" begin
            a = interval(1.0, 2.0)
            b = interval(0.0, 3.0)
            c = interval(1.0, 2.0) # == a
            e = emptyinterval(Float64)

            @test TN.issubset_tn(a, b)
            @test !TN.issubset_tn(b, a)
            @test TN.issubset_tn(e, a) # the empty set is a subset of everything
            @test TN.issubset_tn(a, c) # subset includes equality

            @test TN.is_strict_subset_tn(a, b)
            @test !TN.is_strict_subset_tn(a, c) # equal, not strict

            @test TN.issupset_tn(b, a)
            @test !TN.issupset_tn(a, b)

            @test TN.is_strict_supset_tn(b, a)
            @test !TN.is_strict_supset_tn(c, a)

            # unicode aliases are the same functions
            @test (a ⫃ b) === TN.issubset_tn(a, b)
            @test (a ⪽ b) === TN.is_strict_subset_tn(a, b)
            @test (b ⫄ a) === TN.issupset_tn(b, a)
            @test (b ⪾ a) === TN.is_strict_supset_tn(b, a)

            # `is_strict_subset_tn` is loval/hival-based (matches IA's `isstrictsubset`),
            # not a topological interior test: unlike `isinterior`, it does not
            # require strict inequality at the shared endpoint.
            p, q = interval(1.0, 2.0), interval(1.0, 3.0)
            @test TN.is_strict_subset_tn(p, q)
            @test !isinterior(p, q)
        end

        @testset "Base.in(::Real, ::Interval)" begin
            # `ThickNumber` subtypes get this from ThickNumbers' generic
            # `Base.in(x::Real, a::ThickNumber)`; `Interval` opts into the ThickNumbers
            # interface via `isthick` rather than subtyping, so the extension defines it
            # directly (`Base.in(::Interval, ::Interval)` remains purposely unsupported).
            a = interval(1.0, 2.0)
            @test 1.0 ∈ a && 1.5 ∈ a && 2.0 ∈ a
            @test 0.99 ∉ a && 2.01 ∉ a
            @test !(Inf ∈ a) && !(-Inf ∈ a)
            @test_throws ArgumentError a ∈ a
        end

        @testset "Base.iszero(::Interval)" begin
            # `iszero` asks whether the interval is the additive identity `[0, 0]`
            # (`isthinzero`), which is decidable; it does not fall back to `==`,
            # which throws for non-thin intervals.
            @test iszero(interval(0.0, 0.0))
            @test !iszero(interval(-1.0, 1.0)) # contains zero but is not [0, 0]
            @test !iszero(interval(1.0, 2.0))
            @test !iszero(emptyinterval(Float64))
            @test !iszero(nai(Float64))
        end

        @testset "isless_tn, ≺, ≻, ⪯, ⪰" begin
            a = interval(1.0, 2.0)
            d = interval(5.0, 6.0)

            @test TN.isless_tn(a, d)
            @test !TN.isless_tn(d, a)
            @test (a ≺ d) === true
            @test (d ≺ a) === false
            @test (d ≻ a) === true
            @test (a ≻ d) === false
            @test (a ⪯ d) === true
            @test (d ⪰ a) === true

            # touching endpoints: strict relations are false, non-strict are true
            t = interval(2.0, 3.0)
            @test !TN.isless_tn(a, t) # sup(a) == inf(t): not strictly less
            @test (a ⪯ t) === true
            @test !(a ≺ t)
            @test (t ⪰ a) === true
            @test !(t ≻ a)

            # overlapping operands distinguish `x ≻ y` from `!(x ⪯ y)`: every
            # relation must quantify over all member pairs, so neither order holds
            o1, o2 = interval(2.0, 4.0), interval(1.0, 3.0)
            @test !(o1 ≻ o2)
            @test !(o2 ≺ o1)
            @test !(o1 ⪰ o2)
            @test !(o2 ⪯ o1)
        end

        @testset "isequal_tn, iseq_tn (≐), isapprox_tn (⩪)" begin
            a = interval(1.0, 2.0)
            c = interval(1.0, 2.0)
            b = interval(1.0, 2.0 + eps(2.0))

            @test TN.isequal_tn(a, c)
            @test !TN.isequal_tn(a, b)
            @test (a ≐ c) === true
            @test (a ≐ b) === false

            @test (a ⩪ interval(1.0 + 1e-10, 2.0 + 1e-10)) === true
            @test !(a ⩪ interval(1.1, 2.1))
            @test TN.isapprox_tn(a, a; atol = 0.0) === true

            e1, e2 = emptyinterval(Float64), emptyinterval(Float64)
            @test TN.isequal_tn(e1, e2)
            @test (e1 ≐ e2) === true
            @test (e1 ⩪ e2) === true
        end
    end
end
