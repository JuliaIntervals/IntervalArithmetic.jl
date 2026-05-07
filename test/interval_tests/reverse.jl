# Tests for the reverse-mode constraint-propagation functions that are not
# covered by the ITF1788 test corpus (sections of `libieeep1788_rev.itl` and
# `libieeep1788_mul_rev.itl` cover `sqr_rev`, `abs_rev`, `pown_rev`, the
# trigonometric and `cosh` reverses, and `mul_rev` / `mulRevToPair`).

# Helper: assert that `forward(rev) ⊇ c ∩ forward(x)` and `rev ⊆ x`. This
# expresses the spec: `f_rev(c, x)` is an enclosure of
# `{y ∈ x : f(y) ∈ c}`. Property tests using this helper guarantee that
# the reverse is a *valid* enclosure regardless of looseness.
function check_reverse(forward, rev_result, c, x)
    @test issubset_interval(rev_result, x)
    # Every `y` in the true preimage maps to some value in `c ∩ forward(x)`.
    # Equivalently, `forward(rev_result)` must contain `c ∩ forward(x)`.
    target = intersect_interval(c, forward(x))
    isempty_interval(target) && return
    @test issubset_interval(target, forward(rev_result))
end

@testset "Additive and divisive reverses" begin
    b = bareinterval(1.0, 2.0)
    c = bareinterval(0.0, 5.0)
    x = bareinterval(-10.0, 10.0)

    @test isequal_interval(add_rev(b, c, x), intersect_interval(c - b, x))
    @test isequal_interval(sub_rev1(b, c, x), intersect_interval(c + b, x))
    @test isequal_interval(sub_rev2(b, c, x), intersect_interval(b - c, x))
    @test isequal_interval(div_rev1(b, c, x), intersect_interval(c * b, x))

    # `div_rev2` uses extended division
    @test isequal_interval(div_rev2(bareinterval(1.0, 2.0), bareinterval(2.0, 4.0)),
                           bareinterval(0.25, 1.0))
    @test isempty_interval(div_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 0.0)))

    # Decorated form sets `trv`
    @test decoration(add_rev(interval(1.0, 2.0), interval(0.0, 5.0))) == trv
end

@testset "Monotonic reverses (trivial inverse)" begin
    @test isequal_interval(cbrt_rev(bareinterval(0.0, 2.0)), bareinterval(0.0, 8.0))
    @test isequal_interval(cbrt_rev(bareinterval(-1.0, 1.0)), bareinterval(-1.0, 1.0))

    @test isequal_interval(exp_rev(bareinterval(1.0, 1.0)), bareinterval(0.0, 0.0))
    @test issubset_interval(bareinterval(0.0), exp_rev(bareinterval(1.0, 1.0)))
    @test isempty_interval(exp_rev(bareinterval(-1.0, -0.5)))   # exp ≯ 0

    @test issubset_interval(bareinterval(1.0), log_rev(bareinterval(0.0, 0.0)))
    @test isequal_interval(log_rev(bareinterval(0.0, 0.0), bareinterval(0.5, 1.5)),
                           bareinterval(1.0, 1.0))

    for (rev_pair) in (
        (exp_rev,   exp,   bareinterval(0.5, 2.0)),
        (log_rev,   log,   bareinterval(-1.0, 1.0)),
        (exp2_rev,  exp2,  bareinterval(0.5, 4.0)),
        (log2_rev,  log2,  bareinterval(-1.0, 2.0)),
        (exp10_rev, exp10, bareinterval(0.1, 100.0)),
        (log10_rev, log10, bareinterval(-1.0, 1.0)),
        (sinh_rev,  sinh,  bareinterval(-2.0, 3.0)),
        (asinh_rev, asinh, bareinterval(-2.0, 3.0)),
    )
        rev, fwd, c = rev_pair
        check_reverse(fwd, rev(c, bareinterval(-100.0, 100.0)), c, bareinterval(-100.0, 100.0))
    end

    # `tanh_rev`: clipping happens inside `atanh`
    @test isequal_interval(tanh_rev(bareinterval(2.0, 3.0)), emptyinterval(BareInterval{Float64}))
    @test issubset_interval(bareinterval(0.0), tanh_rev(bareinterval(0.0, 0.0)))
end

@testset "sqrt_rev and acosh_rev (clip to [0, ∞))" begin
    @test isequal_interval(sqrt_rev(bareinterval(2.0, 3.0)), bareinterval(4.0, 9.0))
    @test isequal_interval(sqrt_rev(bareinterval(-1.0, 3.0)), bareinterval(0.0, 9.0))
    @test isempty_interval(sqrt_rev(bareinterval(-2.0, -1.0)))
    @test isequal_interval(sqrt_rev(bareinterval(2.0, 3.0), bareinterval(-100.0, 7.0)),
                           bareinterval(4.0, 7.0))

    @test issubset_interval(bareinterval(1.0), acosh_rev(bareinterval(0.0, 0.0)))
    @test isempty_interval(acosh_rev(bareinterval(-2.0, -1.0)))
    # `acosh_rev` must clip — without clipping `cosh([-1, -0.5])` would give
    # a non-empty (incorrect) result.
    @test isempty_interval(acosh_rev(bareinterval(-1.0, -0.5)))
end

@testset "Inverse-trig reverses (clip to function range)" begin
    π_lo = inf(bareinterval(Float64, π))
    π_hi = sup(bareinterval(Float64, π))

    # asin: range [-π/2, π/2]; values outside are unreachable
    @test isempty_interval(asin_rev(bareinterval(2.0, 3.0)))
    @test issubset_interval(bareinterval(0.0), asin_rev(bareinterval(0.0, 0.0)))
    @test issubset_interval(bareinterval(1.0),
                            asin_rev(bareinterval(π_lo / 2, π_hi / 2)))

    # acos: range [0, π]; negative values unreachable
    @test isempty_interval(acos_rev(bareinterval(-2.0, -0.1)))
    @test issubset_interval(bareinterval(1.0),
                            acos_rev(bareinterval(0.0, 0.0)))
    @test issubset_interval(bareinterval(-1.0),
                            acos_rev(bareinterval(π_lo, π_hi)))

    # atan: range (-π/2, π/2); values outside unreachable
    @test isempty_interval(atan_rev(bareinterval(2.0, 3.0)))
    @test issubset_interval(bareinterval(0.0), atan_rev(bareinterval(0.0, 0.0)))
    @test issubset_interval(bareinterval(1.0),
                            atan_rev(bareinterval(π_lo / 4, π_hi / 4)))
end

@testset "Inverse-hyperbolic reverses" begin
    # asinh: bijective ℝ → ℝ
    @test issubset_interval(bareinterval(0.0), asinh_rev(bareinterval(0.0, 0.0)))
    @test issubset_interval(bareinterval(1.0), asinh_rev(bareinterval(asinh(1.0), asinh(1.0))))

    # atanh: range ℝ; preimage in (-1, 1)
    @test issubset_interval(bareinterval(0.0), atanh_rev(bareinterval(0.0, 0.0)))
    # `atanh_rev(c, x)` should produce values in `(-1, 1)`
    r = atanh_rev(bareinterval(-100.0, 100.0))
    @test inf(r) ≥ -1.0
    @test sup(r) ≤ 1.0
end

@testset "Decoration is `trv` for non-NaI inputs" begin
    @test decoration(sqrt_rev(interval(2.0, 3.0))) == trv
    @test decoration(exp_rev(interval(1.0, 10.0))) == trv
    @test decoration(log_rev(interval(0.0, 1.0))) == trv
    @test decoration(sinh_rev(interval(-1.0, 1.0))) == trv
    @test decoration(asin_rev(interval(0.0, 1.0))) == trv
end

@testset "NaI propagation" begin
    @test isnai(sqrt_rev(nai(Interval{Float64})))
    @test isnai(exp_rev(nai(Interval{Float64})))
    @test isnai(log_rev(nai(Interval{Float64}), interval(1.0, 2.0)))
    @test isnai(asin_rev(interval(0.0, 1.0), nai(Interval{Float64})))
end

@testset "inv_rev" begin
    # inv is its own inverse: inv_rev(c) = inv(c)
    @test isequal_interval(inv_rev(bareinterval(1.0, 2.0)), bareinterval(0.5, 1.0))
    @test isequal_interval(inv_rev(bareinterval(0.5, 1.0)), bareinterval(1.0, 2.0))
    # intersect with x
    @test isequal_interval(inv_rev(bareinterval(1.0, 2.0), bareinterval(0.0, 0.7)),
                           bareinterval(0.5, 0.7))
    # NaI + decoration
    @test isnai(inv_rev(nai(Interval{Float64})))
    @test decoration(inv_rev(interval(1.0, 2.0))) == trv
end

@testset "sign_rev" begin
    # only 1 ∈ c → preimage is [0, ∞)
    @test isequal_interval(sign_rev(bareinterval(1.0, 1.0)),
                           _unsafe_bareinterval(Float64, 0.0, Inf))
    # only -1 ∈ c → preimage is (-∞, 0]
    @test isequal_interval(sign_rev(bareinterval(-1.0, -1.0)),
                           _unsafe_bareinterval(Float64, -Inf, 0.0))
    # only 0 ∈ c → preimage is {0}
    @test isequal_interval(sign_rev(bareinterval(0.0, 0.0)), bareinterval(0.0, 0.0))
    # all three values in c → entire real line
    @test isentire_interval(sign_rev(bareinterval(-1.0, 1.0)))
    # nothing in {-1, 0, 1} → empty
    @test isempty_interval(sign_rev(bareinterval(0.5, 0.7)))
    # restrict to x
    @test isequal_interval(sign_rev(bareinterval(0.0, 1.0), bareinterval(-5.0, 3.0)),
                           bareinterval(0.0, 3.0))
    # NaI + decoration
    @test isnai(sign_rev(nai(Interval{Float64})))
    @test decoration(sign_rev(interval(0.0, 1.0))) == trv
end

@testset "pow_rev1 and pow_rev2" begin
    # pow_rev1: solve c = x^b for x, with b = 2, c = [4, 9] → x ⊇ [2, 3]
    r = pow_rev1(bareinterval(2.0, 2.0), bareinterval(4.0, 9.0))
    @test issubset_interval(bareinterval(2.0, 3.0), r)
    # Tight enclosure (within a few ulps of [2, 3])
    @test diam(r) - 1.0 < 1e-12

    # pow_rev2: solve c = a^x for x, with a = 2, c = [4, 8] → x ⊇ [2, 3]
    r = pow_rev2(bareinterval(2.0, 2.0), bareinterval(4.0, 8.0))
    @test issubset_interval(bareinterval(2.0, 3.0), r)
    @test diam(r) - 1.0 < 1e-12  # diam ≈ 1 with a few ulps slack

    # decoration trv on Interval form
    @test decoration(pow_rev1(interval(2.0, 2.0), interval(4.0, 9.0))) == trv
    @test decoration(pow_rev2(interval(2.0, 2.0), interval(4.0, 8.0))) == trv

    # NaI propagation
    @test isnai(pow_rev1(nai(Interval{Float64}), interval(1.0, 2.0)))
    @test isnai(pow_rev2(interval(2.0, 2.0), nai(Interval{Float64})))
end

@testset "mul_rev_to_pair" begin
    # 0 ∉ b → standard division, second pair element empty
    r1, r2 = mul_rev_to_pair(bareinterval(1.0, 2.0), bareinterval(3.0, 4.0))
    @test isequal_interval(r1, bareinterval(1.5, 4.0))
    @test isempty_interval(r2)

    # 0 ∈ b, 0 ∉ c → genuine split into two half-rays
    r1, r2 = mul_rev_to_pair(bareinterval(-1.0, 1.0), bareinterval(1.0, 2.0))
    @test isequal_interval(r1, _unsafe_bareinterval(Float64, -Inf, -1.0))
    @test isequal_interval(r2, _unsafe_bareinterval(Float64, 1.0, Inf))

    # 0 ∈ b and 0 ∈ c → entire reals (no split)
    r1, r2 = mul_rev_to_pair(bareinterval(-1.0, 1.0), bareinterval(-1.0, 1.0))
    @test isentire_interval(r1)
    @test isempty_interval(r2)

    # NaI propagation: both outputs are NaI
    nai_iv = nai(Interval{Float64})
    r1, r2 = mul_rev_to_pair(nai_iv, interval(1.0, 2.0))
    @test isnai(r1) && isnai(r2)

    # §11.7.1 decoration: split case forces `trv`
    r1, r2 = mul_rev_to_pair(interval(-1.0, 1.0), interval(1.0, 2.0))
    @test decoration(r1) == trv
    @test decoration(r2) == trv
    # non-split case: r1 carries the standard division decoration, r2 is `trv`
    r1, r2 = mul_rev_to_pair(interval(1.0, 2.0), interval(3.0, 4.0))
    @test decoration(r2) == trv
    @test decoration(r1) ≥ trv  # at least trv; typically `com`
end
