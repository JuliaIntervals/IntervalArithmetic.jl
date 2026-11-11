using Test
using IntervalArithmetic
using IntervalArithmetic: IntervalRounding, default_rounding, _fround, _round_expr,
    _unsafe_bareinterval, @round, rootn, CRlibm, CoreMath, RoundingEmulator

@testset "rounding configuration" begin
    @test Base.issingletontype(IntervalRounding{:correct})
    @test default_rounding() === IntervalRounding{:correct}()
    @test_throws ArgumentError IntervalArithmetic.configure(rounding = :bad)
    @test IntervalArithmetic.configuration_options.rounding == :correct
end

@testset "dispatch helpers" begin
    @test _fround(+, 0.1, 0.2, RoundDown) === _fround(+, default_rounding(), 0.1, 0.2, RoundDown)
    @test _fround(sqrt, 2.0, RoundUp) === _fround(sqrt, default_rounding(), 2.0, RoundUp)
end

@testset "exact operations" begin
    _fexact = IntervalArithmetic._fexact
    @test _fexact(-, 1.5) === -1.5
    @test _fexact(floor, -1.5) === -2.0
    @test _fexact(round, 2.5, RoundNearest) === 2.0
    @test _fexact(ldexp, 3.0, 1) === 6.0
    @test _fexact(ldexp, 3//4, 1) === 3//2
    @test_throws MethodError _fexact(sqrt, big(2.0))
    @test_throws MethodError _fexact(round, big(2.5), RoundUp)
    v = setprecision(() -> 1 + big(2.0)^-400, BigFloat, 512)
    for (f, args, t) ∈ ((-, (), setprecision(() -> -v, BigFloat, 512)), (abs, (), v), (floor, (), 1), (ceil, (), 2), (trunc, (), 1), (round, (RoundNearest,), 1),
                        (round, (RoundNearestTiesAway,), 1), (ldexp, (1,), setprecision(() -> 2v, BigFloat, 512)))
        z = _fexact(f, f === abs ? setprecision(() -> -v, BigFloat, 512) : v, args...)
        @test precision(z) == 512
        @test z == t
    end
end

@testset "directed Float64 arithmetic" begin
    @test _fround(+, 0.1, 0.2, RoundDown) == 0.3
    @test _fround(+, 0.1, 0.2, RoundUp) == 0.30000000000000004 == 0.1 + 0.2
    @test _fround(+, 0.1, 0.2, RoundDown) < _fround(+, 0.1, 0.2, RoundUp)
    @test _fround(/, 1.0, 3.0, RoundDown) == 0.3333333333333333
    @test _fround(/, 1.0, 3.0, RoundUp) == 0.33333333333333337 == nextfloat(0.3333333333333333)
    @test _fround(sqrt, 2.0, RoundDown) == 1.414213562373095
    @test _fround(sqrt, 2.0, RoundUp) == 1.4142135623730951 == sqrt(2.0)
    @test _fround(inv, 3.0, RoundDown) == 0.3333333333333333
    @test _fround(inv, 3.0, RoundUp) == 0.33333333333333337
end

@testset "exact rational arithmetic" begin
    for ir ∈ (IntervalRounding{:correct}(), IntervalRounding{:ulp}(), IntervalRounding{:none}()),
            r ∈ (RoundDown, RoundUp)
        @test _fround(+, ir, 1//3, 1//6, r) === 1//2
        @test _fround(-, ir, 1//2, 1//3, r) === 1//6
        @test _fround(*, ir, 2//3, 3//4, r) === 1//2
        @test _fround(/, ir, 1//2, 1//4, r) === 2//1
        @test _fround(inv, ir, 3//7, r) === 7//3
        @test _fround(^, ir, 1//2, 3, r) === 1//8
    end
end

@testset "narrow float arithmetic" begin
    @test _fround(+, 0.1f0, 0.2f0, RoundDown) === 0.29999998f0
    @test _fround(+, 0.1f0, 0.2f0, RoundUp) === 0.3f0
    @test _fround(+, Float16(0.1), Float16(0.2), RoundDown) === Float16(0.2998)
    @test _fround(+, Float16(0.1), Float16(0.2), RoundUp) === Float16(0.3)
end

@testset "BigFloat via MPFR" begin
    lo = _fround(+, big"0.1", big"0.2", RoundDown)
    hi = _fround(+, big"0.1", big"0.2", RoundUp)
    @test lo isa BigFloat
    @test lo < hi
    @test precision(lo) == precision(BigFloat)
    x = BigFloat("0.1"; precision = 64)
    y = BigFloat("0.2"; precision = 128)
    @test precision(_fround(+, promote(x, y)..., RoundDown)) == 128
    @test _fround(sqrt, big"2.0", RoundDown) isa BigFloat
    @test _fround(sqrt, big"2.0", RoundDown) < _fround(sqrt, big"2.0", RoundUp)
    @test _fround(sqrt, big"2.0", RoundDown) ≤ sqrt(big"2.0") ≤ _fround(sqrt, big"2.0", RoundUp)
end

@testset "correct mode uses RoundingEmulator" begin
    for T ∈ (Float32, Float64)
        x, y = T(0.1), T(0.3)
        for (f, down, up) ∈ ((+, RoundingEmulator.add_down, RoundingEmulator.add_up),
                             (-, RoundingEmulator.sub_down, RoundingEmulator.sub_up),
                             (*, RoundingEmulator.mul_down, RoundingEmulator.mul_up),
                             (/, RoundingEmulator.div_down, RoundingEmulator.div_up))
            @test _fround(f, IntervalRounding{:correct}(), x, y, RoundDown) === down(x, y)
            @test _fround(f, IntervalRounding{:correct}(), x, y, RoundUp) === up(x, y)
        end
        @test _fround(sqrt, IntervalRounding{:correct}(), T(2), RoundDown) === RoundingEmulator.sqrt_down(T(2))
        @test _fround(sqrt, IntervalRounding{:correct}(), T(2), RoundUp) === RoundingEmulator.sqrt_up(T(2))
    end
end

@testset "ulp mode arithmetic" begin
    @test _fround(+, IntervalRounding{:ulp}(), 0.1, 0.2, RoundDown) === prevfloat(0.1 + 0.2)
    @test _fround(+, IntervalRounding{:ulp}(), 0.1, 0.2, RoundUp) === nextfloat(0.1 + 0.2) === 0.3000000000000001
    @test _fround(+, IntervalRounding{:ulp}(), 0.1, 0.2, RoundUp) > _fround(+, IntervalRounding{:correct}(), 0.1, 0.2, RoundUp)
    for T ∈ (Float16, Float32)
        @test _fround(*, IntervalRounding{:ulp}(), T(0.1), T(0.2), RoundDown) ===
            T(prevfloat(Float64(T(0.1)) * Float64(T(0.2))), RoundDown)
        @test _fround(sqrt, IntervalRounding{:ulp}(), T(2), RoundUp) ===
            T(nextfloat(sqrt(Float64(T(2)))), RoundUp)
    end
    @test _fround(sqrt, IntervalRounding{:ulp}(), 2.0, RoundDown) === prevfloat(sqrt(2.0))
end

@testset "none mode" begin
    @test _fround(+, IntervalRounding{:none}(), 0.1, 0.2, RoundDown) ===
        _fround(+, IntervalRounding{:none}(), 0.1, 0.2, RoundUp) === 0.30000000000000004
    @test _fround(sqrt, IntervalRounding{:none}(), 2.0, RoundDown) === sqrt(2.0)
    @test _fround(inv, IntervalRounding{:none}(), 3.0, RoundUp) === inv(3.0)
    @test _fround(sin, IntervalRounding{:none}(), 1.0, RoundDown) === sin(1.0)
    @test _fround(^, IntervalRounding{:none}(), 2.0, 0.5, RoundDown) === 2.0^0.5
    @test _fround(atan, IntervalRounding{:none}(), 1.0, 2.0, RoundUp) === atan(1.0, 2.0)
    @test _fround(rootn, IntervalRounding{:none}(), 8.0, 3, RoundDown) === 8.0^(1//3)
end

@testset "inv drops the explicit rounding type" begin
    # src/intervals/rounding.jl: `_fround(inv, ...)` re-dispatches through `default_rounding()`
    @test _fround(inv, IntervalRounding{:ulp}(), 3.0, RoundDown) == 0.3333333333333333
    @test _fround(/, IntervalRounding{:ulp}(), 1.0, 3.0, RoundDown) == 0.33333333333333326
end

@testset "one-argument functions, correct mode" begin
    crlibm = (exp, expm1, log, log2, log10, log1p, sin, sinpi, cos, cospi, tan, asin, acos,
              atan, sinh, cosh)
    for f ∈ crlibm, T ∈ (Float32, Float64)
        x = T(0.7)
        down = _fround(f, x, RoundDown)
        up = _fround(f, x, RoundUp)
        @test typeof(down) == typeof(up) == T
        @test down < up
        @test down ≤ f(big(x)) ≤ up
    end
    @test _fround(sin, 1.0, RoundDown) == 0.8414709848078965
    @test _fround(sin, 1.0, RoundUp) == 0.8414709848078966
    @test typeof(_fround(sin, IntervalRounding{:correct}(), Float16(1), RoundDown)) == Float16

    mpfr = ((cbrt, 0.5), (exp2, 0.5), (exp10, 0.5), (cot, 0.5), (sec, 0.5), (csc, 0.5),
            (acot, 1.0), (tanh, 0.5), (asinh, 0.5), (coth, 0.5), (sech, 0.5), (csch, 0.5),
            (acosh, 2.0), (atanh, 0.5), (acoth, 2.0))
    for (f, x) ∈ mpfr
        down = _fround(f, x, RoundDown)
        up = _fround(f, x, RoundUp)
        @test typeof(down) == typeof(up) == BigFloat
        @test down < up
        @test down ≤ f(big(x)) ≤ up
    end
    @test _fround(acot, 1.0, RoundDown) < acot(big(1.0)) < _fround(acot, 1.0, RoundUp)
    @test _fround(acoth, 2.0, RoundDown) < acoth(big(2.0)) < _fround(acoth, 2.0, RoundUp)
end

@testset "one-argument functions, ulp mode" begin
    # CoreMath ships no library for 32-bit systems
    if isdefined(CoreMath, :libcoremath)
        working = ((cbrt, 0.5), (exp, 0.5), (exp2, 0.5), (exp10, 0.5), (expm1, 0.5), (log, 0.5),
                   (log2, 0.5), (log10, 0.5), (log1p, 0.5), (sin, 0.5), (sinpi, 0.5), (cos, 0.5),
                   (cospi, 0.5), (tan, 0.5), (asin, 0.5), (acos, 0.5), (atan, 0.5), (sinh, 0.5),
                   (tanh, 0.5), (asinh, 0.5), (cosh, 0.5), (acosh, 2.0), (atanh, 0.5))
        for (f, x) ∈ working, T ∈ (Float32, Float64)
            down = _fround(f, IntervalRounding{:ulp}(), T(x), RoundDown)
            up = _fround(f, IntervalRounding{:ulp}(), T(x), RoundUp)
            @test typeof(down) == typeof(up) == T
            @test down < up
            @test down ≤ f(big(T(x))) ≤ up
        end
    end
    # no CoreMath routine: `:ulp` falls back to `:correct`, cf. src/intervals/rounding.jl
    for (f, x) ∈ ((cot, 0.5), (sec, 0.5), (csc, 0.5), (acot, 1.0), (coth, 0.5), (sech, 0.5),
                  (csch, 0.5), (acoth, 2.0)),
            T ∈ (Float32, Float64)
        down = _fround(f, IntervalRounding{:ulp}(), T(x), RoundDown)
        up = _fround(f, IntervalRounding{:ulp}(), T(x), RoundUp)
        @test down == _fround(f, IntervalRounding{:correct}(), T(x), RoundDown)
        @test up == _fround(f, IntervalRounding{:correct}(), T(x), RoundUp)
        @test down < up
        @test down ≤ f(big(T(x))) ≤ up
    end
end

@testset "two-argument functions" begin
    @test _fround(^, 2.0, 0.5, RoundDown) == prevfloat(sqrt(2.0))
    @test _fround(^, 2.0, 0.5, RoundUp) == 1.4142135623730951
    @test _fround(^, 2.0, 0.5, RoundDown) isa BigFloat
    @test _fround(^, 2.0, 3.0, RoundDown) == 8.0
    @test _fround(^, 2.0, 3, RoundDown) == _fround(^, 2.0, 3.0, RoundDown)
    @test _fround(atan, 1.0, 2.0, RoundDown) < atan(big(1.0), big(2.0)) < _fround(atan, 1.0, 2.0, RoundUp)
    @test _fround(atan, 1.0, 2.0, RoundDown) isa BigFloat
    # CoreMath ships no library for 32-bit systems
    if isdefined(CoreMath, :libcoremath)
        for T ∈ (Float32, Float64)
            @test _fround(^, IntervalRounding{:ulp}(), T(2), T(0.5), RoundDown) === prevfloat(CoreMath.cr_pow(T(2), T(0.5)))
            @test _fround(^, IntervalRounding{:ulp}(), T(2), T(0.5), RoundUp) === nextfloat(CoreMath.cr_pow(T(2), T(0.5)))
            @test _fround(atan, IntervalRounding{:ulp}(), T(1), T(2), RoundDown) === prevfloat(CoreMath.cr_atan2(T(1), T(2)))
            @test _fround(atan, IntervalRounding{:ulp}(), T(1), T(2), RoundUp) === nextfloat(CoreMath.cr_atan2(T(1), T(2)))
        end
    end
end

@testset "rootn" begin
    @test _fround(rootn, 8.0, 3, RoundDown) ≤ 2 ≤ _fround(rootn, 8.0, 3, RoundUp)
    @test _fround(rootn, 8.0, 3, RoundUp) - _fround(rootn, 8.0, 3, RoundDown) ≤ 2eps(2.0)
    @test _fround(rootn, 2.0, 3, RoundUp) isa BigFloat
    @test _fround(rootn, 2.0, 3, RoundDown) ≤ cbrt(big"2.0") ≤ _fround(rootn, 2.0, 3, RoundUp)
end

@testset "@round" begin
    a = bareinterval(0.1)
    b = bareinterval(0.2)
    @test isequal_interval(@round(Float64, inf(a) + inf(b), sup(a) + sup(b)),
                           _unsafe_bareinterval(Float64, 0.3, 0.30000000000000004))
    @test isequal_interval(@round(Float64, min(inf(a) + inf(b), inf(a) - inf(b)),
                                  max(sup(a) + sup(b), sup(a) - sup(b))),
                           _unsafe_bareinterval(Float64, -0.1, 0.30000000000000004))
    @test isequal_interval(@round(Float64, -inf(a), -inf(a)), _unsafe_bareinterval(Float64, -0.1, -0.1))
    @test isequal_interval(@round(Float64, typemin(Float64), typemax(Float64)), bareinterval(-Inf, Inf))
    @test isequal_interval(@round(Float64, sqrt(2.0), sqrt(2.0)),
                           _unsafe_bareinterval(Float64, 1.414213562373095, 1.4142135623730951))
    @test isequal_interval(@round(Rational{Int64}, 1//3 + 1//6, 1//3 + 1//6), bareinterval(1//2))
end

@testset "_round_expr" begin
    ex = _round_expr(:(a + b), RoundDown)
    @test (ex.head === :call) & (ex.args[1] === :_fround) & (ex.args[2] === :+)
    @test (ex.args[3] == Expr(:escape, :a)) & (ex.args[4] == Expr(:escape, :b)) & (ex.args[5] === RoundDown)
    ex = _round_expr(:(sin(a)), RoundUp)
    @test (ex.args[1] === :_fround) & (ex.args[2] === :sin) & (ex.args[3] == Expr(:escape, :a)) & (ex.args[4] === RoundUp)
    ex = _round_expr(:(min(a + b, c + d)), RoundDown)
    @test (ex.args[1] === :min) & all(arg -> arg.args[1] === :_fround, ex.args[2:3])
    @test _round_expr(:(typemin(T)), RoundDown) == Expr(:escape, :(typemin(T)))
    @test _round_expr(:(-a), RoundUp) == Expr(:escape, :(-a))
    ex = _round_expr(:(_unbounded_mul(a, b)), RoundDown)
    @test (ex.args[1] === :_unbounded_mul) & (ex.args[4] === RoundDown)
    @test _round_expr(1.0, RoundDown) === 1.0
    @test _round_expr(:x, RoundUp) === :x
end

IntervalArithmetic.configure(rounding = :correct)

@testset "end-to-end correct rounding" begin
    @test default_rounding() === IntervalRounding{:correct}()
    @test isequal_interval(sin(interval(0.5)), interval(0.47942553860420295, 0.479425538604203))
    tiny = interval(0, floatmin())
    huge = interval(floatmax(), Inf)
    @test isequal_interval(tiny * tiny, interval(0, nextfloat(0.0)))
    @test isequal_interval(huge * huge, interval(floatmax(), Inf))
    @test isequal_interval(huge / tiny, interval(floatmax(), Inf))
    @test isequal_interval(tiny / huge, interval(0, nextfloat(0.0)))
    @test bounds(bareinterval(0.1) + bareinterval(0.2)) == (0.3, 0.30000000000000004)
end

# `Base.invokelatest` advances the world age past `configure`
try
    IntervalArithmetic.configure(rounding = :ulp)
    Base.invokelatest() do
        @testset "end-to-end ulp rounding" begin
            @test default_rounding() === IntervalRounding{:ulp}()
            @test bounds(bareinterval(0.1) + bareinterval(0.2)) == (0.3, 0.3000000000000001)
        end
    end

    IntervalArithmetic.configure(rounding = :none)
    Base.invokelatest() do
        @testset "end-to-end no rounding" begin
            @test default_rounding() === IntervalRounding{:none}()
            x = bareinterval(0.1) + bareinterval(0.2)
            @test inf(x) == sup(x) == 0.30000000000000004
            @test isequal_interval(sin(interval(0.5)), interval(0.479425538604203, 0.479425538604203))
        end
    end
finally
    IntervalArithmetic.configure(rounding = :correct)
end
