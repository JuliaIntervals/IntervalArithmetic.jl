using Test
using IntervalArithmetic
using Random

@testset "Type aliases" begin
    @test RealOrComplexI{Float64} === Union{Interval{Float64},Complex{Interval{Float64}}}
    @test Interval{Float64} <: RealOrComplexI{Float64}
    @test Complex{Interval{Float64}} <: RealOrComplexI{Float64}
    @test !(BareInterval{Float64} <: RealOrComplexI{Float64})

    @test ComplexI{Float64} === Complex{Interval{Float64}}
    @test !(Interval{Float64} <: ComplexI{Float64})

    @test RealIntervalType{Float64} === Union{BareInterval{Float64},Interval{Float64}}
    @test BareInterval{Float64} <: RealIntervalType{Float64}
    @test Interval{Float64} <: RealIntervalType{Float64}
    @test !(Complex{Interval{Float64}} <: RealIntervalType{Float64})
end

@testset "Exports" begin
    expected = [Symbol("@I_str"), Symbol("@exact"), Symbol("@interval"), :BareInterval,
        :ComplexI, :Decoration, :Domain, :ExactReal, :Interval,
        :IntervalArithmetic, :Overlap, :Piecewise, :RealIntervalType, :RealOrComplexI,
        :bareinterval, :bisect, :bounds, :cancelminus, :cancelplus, :com, :dac,
        :decoration, :def, :diam, :discontinuities, :dist, :domains, :emptyinterval,
        :entireinterval, :exact, :extended_div, :fastpow, :fastpown, :has_exact_display,
        :hull, :ill, :in_interval, :inf, :interiordiff, :intersect_interval, :interval,
        :isatomic, :isbounded, :iscommon, :isdisjoint_interval, :isempty_interval,
        :isentire_interval, :isequal_interval, :isguaranteed, :isinterior, :isnai,
        :issetequal_interval, :isstrictless, :isstrictsubset, :issubset_interval,
        :isthin, :isthininteger, :isthinone, :isthinzero, :isunbounded, :isweakless,
        :mag, :mid, :midradius, :mig, :mince, :mince!, :nai, :numtype, :overlap,
        :pieces, :pow, :pown, :precedes, :radius, :rootn, :sample, :setdisplay,
        :strictprecedes, :sup, :trv, :union_interval]
    @test sort(names(IntervalArithmetic)) == sort(expected)

    @test haskey(Base.Docs.meta(IntervalArithmetic),
        Base.Docs.Binding(IntervalArithmetic, :IntervalArithmetic))
end

@testset "Type stability" begin
    xs = [interval(3, 4), interval(0, 4), interval(0), interval(-4, 0), interval(-4, 4),
        interval(-Inf, 4), interval(4, Inf), interval(-Inf, Inf)]
    for T ∈ (Float32, Float64, BigFloat)
        for x ∈ xs
            xx = Interval{T}(x)
            for y ∈ xs
                yy = Interval{T}(y)
                for op ∈ (+, -, *, /, atan)
                    @test @inferred(op(xx, yy)) isa Interval{T}
                end
            end
            for op ∈ (sin, cos, exp, log, tan, abs)
                @test @inferred(op(xx)) isa Interval{T}
            end
            for op ∈ (mid, diam)
                @test @inferred(op(xx)) isa T
            end
        end
    end
end

@testset "Configuration defaults" begin
    opts = IntervalArithmetic.configuration_options
    @test opts isa IntervalArithmetic.ConfigurationOptions
    @test opts.numtype === Float64
    @test opts.flavor === :set_based
    @test opts.rounding === :correct
    @test opts.power === :fast
    @test opts.matmul === :fast
    @test opts.nthreads > 0

    @test sprint(show, MIME("text/plain"), opts) == string(
        "Configuration options:\n",
        "  - bound type: Float64\n",
        "  - flavor: set_based\n",
        "  - interval rounding: correct\n",
        "  - power mode: fast\n",
        "  - matrix multiplication mode: fast\n",
        "  - number of threads for `:fast` matrix multiplication mode: ", opts.nthreads)

    @test IntervalArithmetic.default_numtype() === Float64
    @test IntervalArithmetic.default_flavor() === IntervalArithmetic.Flavor{:set_based}()
    @test IntervalArithmetic.default_rounding() === IntervalArithmetic.IntervalRounding{:correct}()
    @test IntervalArithmetic.default_power() === IntervalArithmetic.PowerMode{:fast}()
    @test IntervalArithmetic.default_matmul() === IntervalArithmetic.MatMulMode{:fast}()

    @test IntervalArithmetic.MatMulMode isa UnionAll
    @test sizeof(IntervalArithmetic.MatMulMode{:fast}()) == 0
    @test sizeof(IntervalArithmetic.MatMulMode{:slow}()) == 0
end

@testset "configure_ helpers" begin
    try
        @test IntervalArithmetic.configure_numtype(Float32) === Float32
        @test Base.invokelatest(IntervalArithmetic.default_numtype) === Float32
    finally
        IntervalArithmetic.configure_numtype(Float64)
    end
    @test Base.invokelatest(IntervalArithmetic.default_numtype) === Float64

    @test IntervalArithmetic.configure_flavor(:set_based) === :set_based
    @test_throws ArgumentError("only the interval flavor `:set_based` is supported and implemented") IntervalArithmetic.configure_flavor(:foo)

    try
        for s ∈ (:ulp, :none, :correct)
            @test IntervalArithmetic.configure_rounding(s) === s
        end
    finally
        IntervalArithmetic.configure_rounding(:correct)
    end
    @test_throws ArgumentError("only the rounding mode `:correct`, `:ulp` and `:none` are available") IntervalArithmetic.configure_rounding(:foo)

    try
        for s ∈ (:slow, :fast)
            @test IntervalArithmetic.configure_power(s) === s
        end
    finally
        IntervalArithmetic.configure_power(:fast)
    end
    @test_throws ArgumentError("only the power mode `:slow` and `:fast` are available") IntervalArithmetic.configure_power(:foo)

    try
        for s ∈ (:slow, :fast)
            @test IntervalArithmetic.configure_matmul(s) === s
        end
    finally
        IntervalArithmetic.configure_matmul(:fast)
    end
    @test_throws ArgumentError("only the matrix multiplication mode `:slow` and `:fast` are available") IntervalArithmetic.configure_matmul(:foo)
end

@testset "Threads" begin
    dt = IntervalArithmetic.default_threads()
    @test dt ≥ 1
    if Sys.isapple() && Sys.ARCH === :aarch64
        @test dt == max(1, Sys.CPU_THREADS)
    else
        @test dt == max(1, Sys.CPU_THREADS ÷ 2)
    end

    @test IntervalArithmetic._get_num_threads() isa Int

    @test_throws ArgumentError("the number of threads must be positive") IntervalArithmetic.configure_threads(0)
    @test_throws ArgumentError("the number of threads must be positive") IntervalArithmetic.configure_threads(-1)

    if Int === Int64
        try
            # the BLAS library may cap the effective number of threads
            @test IntervalArithmetic.configure_threads(2) == IntervalArithmetic._get_num_threads() ≥ 1
            @test IntervalArithmetic._set_num_threads(3) == IntervalArithmetic._get_num_threads() ≥ 1
        finally
            IntervalArithmetic.configure(nthreads = dt)
        end
        @test IntervalArithmetic.configuration_options.nthreads == IntervalArithmetic._get_num_threads() ≥ 1
    else
        @test IntervalArithmetic._get_num_threads() == 1
        @test IntervalArithmetic._set_num_threads(5) == 1
    end
end

@testset "configure" begin
    opts = IntervalArithmetic.configuration_options
    try
        @test IntervalArithmetic.configure() === opts
        @test opts.numtype === Float64 && opts.flavor === :set_based &&
            opts.rounding === :correct && opts.power === :fast && opts.matmul === :fast

        IntervalArithmetic.configure(numtype = Float32)
        @test Base.invokelatest(interval, 1, 2) isa Interval{Float32}
        IntervalArithmetic.configure(numtype = Float64)
        @test Base.invokelatest(interval, 1, 2) isa Interval{Float64}

        IntervalArithmetic.configure(rounding = :none)
        x = Base.invokelatest(() -> interval(0.1) + interval(0.2))
        @test inf(x) == sup(x) == 0.1 + 0.2

        IntervalArithmetic.configure(rounding = :ulp)
        x = Base.invokelatest(() -> interval(0.1) + interval(0.2))
        @test inf(x) == prevfloat(0.1 + 0.2) && sup(x) == nextfloat(0.1 + 0.2)
        IntervalArithmetic.configure(rounding = :correct)

        @test IntervalArithmetic.configure(power = :slow).power === :slow
        @test Base.invokelatest(IntervalArithmetic.default_power) === IntervalArithmetic.PowerMode{:slow}()
        @test IntervalArithmetic.configure(power = :fast).power === :fast
        @test Base.invokelatest(IntervalArithmetic.default_power) === IntervalArithmetic.PowerMode{:fast}()

        @test IntervalArithmetic.configure(matmul = :slow).matmul === :slow
        @test Base.invokelatest(IntervalArithmetic.default_matmul) === IntervalArithmetic.MatMulMode{:slow}()
        @test IntervalArithmetic.configure(matmul = :fast).matmul === :fast
        @test Base.invokelatest(IntervalArithmetic.default_matmul) === IntervalArithmetic.MatMulMode{:fast}()

        if Int === Int64
            @test IntervalArithmetic.configure(nthreads = 2).nthreads == IntervalArithmetic._get_num_threads() ≥ 1
        end

        @test_throws TypeError IntervalArithmetic.configure(numtype = Int)
        @test opts.numtype === Float64

        # options are applied one at a time, so a later invalid one leaves earlier ones in place
        @test_throws ArgumentError IntervalArithmetic.configure(numtype = Float32, rounding = :foo)
        @test opts.numtype === Float32
        @test Base.invokelatest(IntervalArithmetic.default_numtype) === Float32
    finally
        IntervalArithmetic.configure(numtype = Float64, flavor = :set_based,
            rounding = :correct, power = :fast, matmul = :fast,
            nthreads = IntervalArithmetic.default_threads())
    end
    @test opts.numtype === Float64 && opts.flavor === :set_based &&
        opts.rounding === :correct && opts.power === :fast && opts.matmul === :fast
    @test opts.nthreads == IntervalArithmetic._get_num_threads() ≥ 1
    @test Base.invokelatest(IntervalArithmetic.default_numtype) === Float64
end

@testset "rand" begin
    x = rand(Interval{Float64})
    @test x isa Interval{Float64}
    @test isthin(x)
    @test decoration(x) === com && isguaranteed(x)
    @test 0.0 ≤ inf(x) && sup(x) < 1.0

    @test isequal_interval(rand(MersenneTwister(42), Interval{Float64}),
        interval(rand(MersenneTwister(42), Float64)))

    v = rand(Interval{Float32}, 3)
    @test v isa Vector{Interval{Float32}}
    @test length(v) == 3 && all(isthin, v)

    y = rand(Interval{BigFloat})
    @test y isa Interval{BigFloat} && isthin(y)

    @test_throws MethodError rand(Interval{Rational{Int}})
end

@testset "sample" begin
    x = interval(1, 2)
    @test all(1:10^4) do _
        s = sample(x)
        s isa Float64 && in_interval(s, x)
    end

    @test sample(MersenneTwister(1), x) == sample(MersenneTwister(1), x)
    @test sample(x) isa Float64

    @test sample(interval(1, 1)) === 1.0

    @test all(_ -> isfinite(sample(entireinterval())), 1:10^4)

    s = sample(interval(1.0, Inf))
    @test isfinite(s) && in_interval(s, interval(1.0, Inf))
    s = sample(interval(-Inf, 1.0))
    @test isfinite(s) && in_interval(s, interval(-Inf, 1.0))

    @test isnan(sample(emptyinterval()))
    @test isnan(sample(nai()))

    s = sample(interval(BigFloat, 1, 2))
    @test s isa BigFloat && 1 ≤ s ≤ 2

    y = interval(prevfloat(1.0), 1.0)
    @test all(1:10^3) do _
        s = sample(y)
        s == prevfloat(1.0) || s == 1.0
    end

    s = sample(interval(1, 2) + 1)
    @test s isa Float64 && 2 ≤ s ≤ 3

    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test IntervalArithmetic._value_min(T) == floatmin(T)
        @test IntervalArithmetic._value_max(T) == floatmax(T)
    end
    @test_throws MethodError sample(interval(1//2, 3//4))
end

@testset "Irrational bareinterval" begin
    x = bareinterval(Float64, π)
    @test x isa BareInterval{Float64}
    @test inf(x) == 3.141592653589793
    @test sup(x) == 3.1415926535897936 == nextfloat(inf(x))
    @test @inferred(bareinterval(Float64, π)) isa BareInterval{Float64}

    for T ∈ (Float16, Float32, Float64)
        y = bareinterval(T, π)
        @test in_interval(π, y)
        @test nextfloat(inf(y)) == sup(y)
    end
    @test in_interval(π, bareinterval(Rational{Int}, π))

    for irr ∈ (MathConstants.ℯ, MathConstants.golden, MathConstants.γ, MathConstants.catalan)
        for T ∈ (Float32, Float64, BigFloat)
            y = bareinterval(T, irr)
            @test in_interval(irr, y)
            if T !== BigFloat
                @test nextfloat(inf(y)) == sup(y)
            end
        end
    end

    z = bareinterval(BigFloat, π)
    @test precision(inf(z)) == precision(sup(z)) == precision(BigFloat)
    @test in_interval(π, z)
    @test nextfloat(inf(z)) == sup(z)

    setprecision(BigFloat, 128) do
        z128 = bareinterval(BigFloat, π)
        @test precision(inf(z128)) == precision(sup(z128)) == 128
        @test in_interval(π, z128)
        @test nextfloat(inf(z128)) == sup(z128)
    end

    # irrational enclosures are rigorous whatever the configured rounding mode
    try
        IntervalArithmetic.configure(rounding = :none)
        for irr ∈ (MathConstants.ℯ, MathConstants.golden), T ∈ (Float64, BigFloat)
            y = Base.invokelatest(bareinterval, T, irr)
            @test in_interval(irr, y)
            @test inf(y) < sup(y)
        end
    finally
        IntervalArithmetic.configure(rounding = :correct)
    end

    @test_throws ArgumentError("only irrationals from MathConstants or IrrationalConstants.jl are supported") bareinterval(Float64, Base.Irrational{:foo}())
end
