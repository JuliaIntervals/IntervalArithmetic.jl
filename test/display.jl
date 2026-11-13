using Test
using IntervalArithmetic
using Random

@testset "Display options" begin
    d = IntervalArithmetic.display_options
    @test d isa IntervalArithmetic.DisplayOptions
    @test d.format === :infsup && d.decorations && d.ng_flag && d.sigdigits == 6
    @test setdisplay() === d
    @test d.format === :infsup && d.decorations && d.ng_flag && d.sigdigits == 6
    try
        setdisplay(:midpoint)
        @test d.format === :midpoint && d.decorations && d.ng_flag && d.sigdigits == 6
        setdisplay(:infsup; sigdigits = 3)
        @test d.format === :infsup && d.decorations && d.ng_flag && d.sigdigits == 3
        setdisplay(; decorations = false)
        @test d.format === :infsup && !d.decorations && d.ng_flag && d.sigdigits == 3

        @test_throws ArgumentError("`format` must be `:infsup`, `:midpoint` or `:full`") setdisplay(:foo)
        @test d.format === :infsup && !d.decorations && d.ng_flag && d.sigdigits == 3
        @test_throws ArgumentError("`sigdigits` must be `≥ 1`") setdisplay(:infsup; sigdigits = 0)
        @test_throws ArgumentError("`sigdigits` must be `≥ 1`") setdisplay(:infsup; sigdigits = -1)
        @test d.sigdigits == 3

        setdisplay(:infsup; sigdigits = 1)
        @test d.sigdigits == 1

        setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        @test sprint(show, MIME("text/plain"), d) == string(
            "Display options:\n",
            "  - format: infsup\n",
            "  - decorations: true\n",
            "  - NG flag: true\n",
            "  - significant digits: 6")
        setdisplay(:full)
        @test sprint(show, MIME("text/plain"), d) == string(
            "Display options:\n",
            "  - format: full\n",
            "  - decorations: true (ignored)\n",
            "  - NG flag: true (ignored)\n",
            "  - significant digits: 6 (ignored)")
    finally
        setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
    end
end

@testset "Printing entry points agree" begin
    setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
    for x ∈ (bareinterval(1, 2), interval(0.1, 0.3), interval(1, 2)/1, nai(),
            complex(interval(1, 2), interval(2, 3)))
        str = sprint(show, x)
        @test sprint(show, MIME("text/plain"), x) == str
        @test repr(x) == str
        @test string(x) == str
        @test sprint(print, x) == str
    end
    @test repr([interval(1, 2)]) == "Interval{Float64}[[1.0, 2.0]_com]"
end

@testset "NaI" begin
    illformed = @test_logs (:warn,) interval(1, -1)
    try
        for format ∈ (:infsup, :midpoint, :full)
            setdisplay(format)
            @test sprint(show, MIME("text/plain"), illformed) == "NaI"
            for T ∈ (Float64, Float32, Float16, BigFloat, Rational{Int64})
                @test (@test_logs repr(nai(T))) == "NaI"
            end
        end
    finally
        setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
    end
end

setprecision(BigFloat, 256) do
    @testset "BareInterval" begin
        a = bareinterval(-floatmin(Float64), 1.3)
        large_expo = bareinterval(0, BigFloat("1e123456789"))
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(emptyinterval(BareInterval{Float64})) == "∅"
            @test repr(bareinterval(1, 2)) == "[1.0, 2.0]"
            @test repr(entireinterval(BareInterval{Float64})) == "(-∞, ∞)"
            @test repr(a) == "[-2.22508e-308, 1.3]"
            @test repr(large_expo) == "[0.0, 1.0e+123456789]₂₅₆"

            setdisplay(; sigdigits = 20)
            @test repr(a) == "[-2.2250738585072014e-308, 1.3]"
            @test repr(large_expo) == "[0.0, 1.0000000000000000001e+123456789]₂₅₆"

            setdisplay(:full; sigdigits = 100)
            @test repr(emptyinterval(BareInterval{Float64})) == "∅"
            @test repr(bareinterval(0.1, 0.3)) == "BareInterval{Float64}(0.1, 0.3)"
            @test repr(entireinterval(BareInterval{Float64})) == "BareInterval{Float64}(-Inf, Inf)"
            @test repr(a) == "BareInterval{Float64}(-2.2250738585072014e-308, 1.3)"
            @test repr(large_expo) == "BareInterval{BigFloat}(0.0, $(sup(large_expo)))"

            setdisplay(:midpoint; sigdigits = 6, decorations = false, ng_flag = false)
            @test repr(emptyinterval(BareInterval{Float64})) == "∅"
            @test repr(bareinterval(1, 2)) == "1.5 ± 0.5"
            @test repr(a) == "0.65 ± 0.650001"
            @test repr(large_expo) == "(5.0e+123456788 ± 5.0e+123456788)₂₅₆"

            setdisplay(; decorations = true, ng_flag = true)
            @test repr(bareinterval(1, 2)) == "1.5 ± 0.5"
            @test repr(a) == "0.65 ± 0.650001"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "Interval" begin
        a = interval(1, 2)
        a_NG = a/1
        b = interval(-floatmin(Float64), 1.3)
        b32 = interval(-floatmin(Float32), parse(Float32, "1.3"))
        b16 = interval(-floatmin(Float16), parse(Float16, "1.3"))
        br = interval(Rational{Int64}, -11//10, 13//10)
        c = interval(-1, Inf)
        cr = interval(Rational{Int64}, -1//1, 1//0)
        large_expo = interval(0, BigFloat("1e123456789"))
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(emptyinterval()) == "∅_trv"
            @test repr(emptyinterval()/1) == "∅_trv_NG"
            @test repr(a) == "[1.0, 2.0]_com"
            @test repr(a_NG) == "[1.0, 2.0]_com_NG"
            @test repr(b) == "[-2.22508e-308, 1.3]_com"
            @test repr(b32) == "[-1.1755f-38, 1.3f0]_com"
            @test repr(b16) == "[Float16(-6.104e-5), Float16(1.3)]_com"
            @test repr(br) == "[-11//10, 13//10]_com"
            @test repr(c) == "[-1.0, ∞)_dac"
            @test repr(cr) == "[-1//1, ∞)_dac"
            @test repr(large_expo) == "[0.0, 1.0e+123456789]₂₅₆_com"
            @test repr(interval(0, 0)) == "[0.0, 0.0]_com"
            @test repr(interval(-0.0, 0.0)) == "[0.0, 0.0]_com"
            @test repr(entireinterval()) == "(-∞, ∞)_dac"
            @test repr(interval(1, Inf)) == "[1.0, ∞)_dac"
            @test repr(interval(-Inf, 1)) == "(-∞, 1.0]_dac"
            @test repr(interval(-floatmax(Float64), prevfloat(floatmax(Float64)))) == "[-1.7976931348623157e+308, 1.7976931348623155e+308]_com"

            setdisplay(; decorations = false)
            @test repr(emptyinterval()) == "∅"
            @test repr(emptyinterval()/1) == "∅_NG"
            @test repr(a) == "[1.0, 2.0]"
            @test repr(a_NG) == "[1.0, 2.0]_NG"
            @test repr(b) == "[-2.22508e-308, 1.3]"
            @test repr(b32) == "[-1.1755f-38, 1.3f0]"
            @test repr(b16) == "[Float16(-6.104e-5), Float16(1.3)]"
            @test repr(br) == "[-11//10, 13//10]"
            @test repr(c) == "[-1.0, ∞)"
            @test repr(cr) == "[-1//1, ∞)"
            @test repr(large_expo) == "[0.0, 1.0e+123456789]₂₅₆"

            setdisplay(; decorations = true, ng_flag = false)
            @test repr(a_NG) == "[1.0, 2.0]_com"
            @test repr(emptyinterval()/1) == "∅_trv"

            setdisplay(; sigdigits = 20, decorations = true, ng_flag = true)
            @test repr(a) == "[1.0, 2.0]_com"
            @test repr(a_NG) == "[1.0, 2.0]_com_NG"
            @test repr(b) == "[-2.2250738585072014e-308, 1.3]_com"
            @test repr(b32) == "[-1.1754944f-38, 1.3f0]_com"
            @test repr(b16) == "[Float16(-6.104e-5), Float16(1.3)]_com"
            @test repr(br) == "[-11//10, 13//10]_com"
            @test repr(c) == "[-1.0, ∞)_dac"
            @test repr(cr) == "[-1//1, ∞)_dac"
            @test repr(large_expo) == "[0.0, 1.0000000000000000001e+123456789]₂₅₆_com"

            setdisplay(:full; sigdigits = 100, decorations = false)
            @test repr(emptyinterval()) == "∅"
            @test repr(emptyinterval()/1) == "∅_NG"
            @test repr(a) == "Interval{Float64}(1.0, 2.0, com, true)"
            @test repr(a_NG) == "Interval{Float64}(1.0, 2.0, com, false)"
            @test repr(b) == "Interval{Float64}(-2.2250738585072014e-308, 1.3, com, true)"
            @test repr(b32) == "Interval{Float32}(-1.1754944f-38, 1.3f0, com, true)"
            @test repr(b16) == "Interval{Float16}(Float16(-6.104e-5), Float16(1.3), com, true)"
            @test repr(br) == "Interval{Rational{Int64}}(-11//10, 13//10, com, true)"
            @test repr(c) == "Interval{Float64}(-1.0, Inf, dac, true)"
            @test repr(cr) == "Interval{Rational{Int64}}(-1//1, 1//0, dac, true)"
            @test repr(large_expo) == "Interval{BigFloat}(0.0, $(sup(large_expo)), com, true)"
            @test repr(interval(0.1, 0.3)) == "Interval{Float64}(0.1, 0.3, com, true)"
            @test repr(entireinterval()) == "Interval{Float64}(-Inf, Inf, dac, true)"

            setdisplay(:midpoint; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(emptyinterval()) == "∅_trv"
            @test repr(emptyinterval()/1) == "∅_trv_NG"
            @test repr(a) == "(1.5 ± 0.5)_com"
            @test repr(a_NG) == "(1.5 ± 0.5)_com_NG"
            @test repr(b) == "(0.65 ± 0.650001)_com"
            @test repr(b32) == "(0.65f0 ± 0.650001f0)_com"
            @test repr(b16) == "(Float16(0.65) ± Float16(0.6504))_com"
            @test repr(br) == "(1//10 ± 6//5)_com"
            @test repr(c) == "(1.79769e+308 ± ∞)_dac"
            @test repr(cr) == "(9223372036854775807//1 ± ∞)_dac"
            @test repr(large_expo) == "(5.0e+123456788 ± 5.0e+123456788)₂₅₆_com"
            @test repr(entireinterval()) == "(0.0 ± ∞)_dac"

            setdisplay(; decorations = false)
            @test repr(emptyinterval()) == "∅"
            @test repr(emptyinterval()/1) == "∅_NG"
            @test repr(a) == "1.5 ± 0.5"
            @test repr(a_NG) == "(1.5 ± 0.5)_NG"
            @test repr(b) == "0.65 ± 0.650001"
            @test repr(b32) == "0.65f0 ± 0.650001f0"
            @test repr(b16) == "Float16(0.65) ± Float16(0.6504)"
            @test repr(br) == "1//10 ± 6//5"
            @test repr(c) == "1.79769e+308 ± ∞"
            @test repr(cr) == "9223372036854775807//1 ± ∞"
            @test repr(large_expo) == "(5.0e+123456788 ± 5.0e+123456788)₂₅₆"

            setdisplay(; ng_flag = false)
            @test repr(a) == "1.5 ± 0.5"
            @test repr(a_NG) == "1.5 ± 0.5"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "Digit rounding" begin
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(interval(π)) == "[3.14159, 3.1416]_com"
            setdisplay(; sigdigits = 1)
            @test repr(interval(π)) == "[3.0, 4.0]_com"
            setdisplay(; sigdigits = 17)
            @test repr(interval(0.1, 0.3)) == "[0.1, 0.3]_com"
            setdisplay(; sigdigits = 6)
            @test repr(interval(1e100)) == "[1.0e+100, 1.0e+100]_com"
            @test repr(interval(1e-100)) == "[1.0e-100, 1.0e-100]_com"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "Float32" begin
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(interval(Float32, 0.1, 0.3)) == "[0.099999f0, 0.3f0]_com"
            @test repr(interval(Float32, 1e30, 2e30)) == "[1.0f+30, 2.0f+30]_com"
            @test repr(entireinterval(Interval{Float32})) == "(-∞, ∞)_dac"
            @test repr(emptyinterval(Interval{Float32})) == "∅_trv"
            setdisplay(:full)
            @test repr(interval(Float32, 1f30, 2f30)) == "Interval{Float32}(1.0f30, 2.0f30, com, true)"
            @test repr(entireinterval(Interval{Float32})) == "Interval{Float32}(-Inf32, Inf32, dac, true)"
            @test repr(emptyinterval(Interval{Float32})) == "∅_trv"
            setdisplay(:midpoint)
            # the ∞ substitution is absent from the Float32 midpoint branch, cf. src/display.jl
            @test repr(entireinterval(Interval{Float32})) == "(0.0f0 ± Inf32)_dac"
            @test repr(emptyinterval(Interval{Float32})) == "∅_trv"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "Float16" begin
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(interval(Float16, 0.1, 0.3)) == "[Float16(0.1), Float16(0.3)]_com"
            @test repr(entireinterval(Interval{Float16})) == "(-∞, ∞)_dac"
            setdisplay(:full)
            @test repr(interval(Float16, 0.1, 0.3)) == "Interval{Float16}(Float16(0.1), Float16(0.3), com, true)"
            @test repr(entireinterval(Interval{Float16})) == "Interval{Float16}(-Inf16, Inf16, dac, true)"
            setdisplay(:midpoint)
            @test repr(entireinterval(Interval{Float16})) == "(Float16(0.0) ± ∞)_dac"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "Rational" begin
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(interval(1//2, 3//4)) == "[1//2, 3//4]_com"
            @test repr(entireinterval(Interval{Rational{Int64}})) == "(-∞, ∞)_dac"
            setdisplay(:midpoint)
            @test repr(interval(1//2, 3//4)) == "(5//8 ± 1//8)_com"
            @test repr(entireinterval(Interval{Rational{Int64}})) == "(0//1 ± ∞)_dac"
            setdisplay(:full)
            @test repr(interval(1//2, 3//4)) == "Interval{Rational{$Int}}(1//2, 3//4, com, true)"
            @test repr(entireinterval(Interval{Rational{Int64}})) == "Interval{Rational{Int64}}(-1//0, 1//0, dac, true)"
            setdisplay(:infsup; sigdigits = 1)
            @test repr(interval(1//2, 3//4)) == "[1//2, 3//4]_com"
            setdisplay(; sigdigits = 20)
            @test repr(interval(1//2, 3//4)) == "[1//2, 3//4]_com"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "BigFloat" begin
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(interval(BigFloat, 0.1, 0.3)) == "[0.1, 0.3]₂₅₆_com"
            setdisplay(:midpoint)
            @test repr(interval(BigFloat, 0.1, 0.3)) == "(0.2 ± 0.1)₂₅₆_com"
            setdisplay(:full)
            @test repr(interval(BigFloat, 1, 2)) == "Interval{BigFloat}(1.0, 2.0, com, true)"
            @test repr(bareinterval(BigFloat, 1, 2)) == "BareInterval{BigFloat}(1.0, 2.0)"
            @test repr(emptyinterval(Interval{BigFloat})) == "∅₂₅₆_trv"
            @test repr(emptyinterval(BareInterval{BigFloat})) == "∅₂₅₆"

            setdisplay(:infsup)
            x = IntervalArithmetic._unsafe_interval(
                IntervalArithmetic._unsafe_bareinterval(BigFloat,
                    BigFloat(1; precision = 256), BigFloat(2; precision = 80)), com, true)
            @test repr(x) == "[1.0, 2.0]₂₅₆_₈₀_com"

            setprecision(BigFloat, 53) do
                @test repr(interval(BigFloat, 1, 2)) == "[1.0, 2.0]₅₃_com"
            end

            setdisplay(:midpoint; decorations = false, ng_flag = false)
            @test repr(interval(BigFloat, 1, 2)) == "(1.5 ± 0.5)₂₅₆"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end

    @testset "Complex" begin
        a = complex(interval(0, 2), interval(1))
        b = complex(interval(0, 2), interval(-1))
        c = complex(interval(0, 1e-70), interval(-1e-70))
        try
            setdisplay(:infsup; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(a) == "[0.0, 2.0]_com + im*[1.0, 1.0]_com"
            @test repr(b) == "[0.0, 2.0]_com - im*[1.0, 1.0]_com"
            @test repr(c) == "[0.0, 1.0e-70]_com - im*[1.0e-70, 1.0e-70]_com"
            @test repr(complex(interval(1, 2), interval(2, 3))) == "[1.0, 2.0]_com + im*[2.0, 3.0]_com"
            @test repr(complex(interval(1, 2), interval(-3, -2))) == "[1.0, 2.0]_com - im*[2.0, 3.0]_com"
            @test repr(complex(interval(1, 2), interval(-2, 0))) == "[1.0, 2.0]_com - im*[0.0, 2.0]_com"
            @test repr(complex(interval(1, 2), interval(0, 0))) == "[1.0, 2.0]_com + im*[0.0, 0.0]_com"
            @test repr(complex(interval(1, 2), emptyinterval())) == "[1.0, 2.0]_com + im*∅_trv"
            @test repr(complex(interval(1, 2), interval(-Inf, -1))) == "[1.0, 2.0]_com - im*[1.0, ∞)_dac"

            setdisplay(; decorations = false)
            @test repr(a) == "[0.0, 2.0] + im*[1.0, 1.0]"
            @test repr(b) == "[0.0, 2.0] - im*[1.0, 1.0]"
            @test repr(c) == "[0.0, 1.0e-70] - im*[1.0e-70, 1.0e-70]"

            setdisplay(:full; sigdigits = 100, decorations = false)
            @test repr(a) == "Interval{Float64}(0.0, 2.0, com, true) + im*Interval{Float64}(1.0, 1.0, com, true)"
            @test repr(b) == "Interval{Float64}(0.0, 2.0, com, true) - im*Interval{Float64}(1.0, 1.0, com, true)"
            @test repr(c) == "Interval{Float64}(0.0, 1.0e-70, com, true) - im*Interval{Float64}(1.0e-70, 1.0e-70, com, true)"
            @test repr(complex(interval(1, 2), interval(-3, -2))) ==
                "Interval{Float64}(1.0, 2.0, com, true) - im*Interval{Float64}(2.0, 3.0, com, true)"
            @test repr(complex(interval(1, 2), interval(2, 3))) ==
                "Interval{Float64}(1.0, 2.0, com, true) + im*Interval{Float64}(2.0, 3.0, com, true)"

            setdisplay(:midpoint; sigdigits = 6, decorations = true, ng_flag = true)
            @test repr(a) == "(1.0 ± 1.0)_com + im*(1.0 ± 0.0)_com"
            @test repr(b) == "(1.0 ± 1.0)_com - im*(1.0 ± 0.0)_com"
            @test repr(c) == "(5.0e-71 ± 5.0e-71)_com - im*(1.0e-70 ± 0.0)_com"
            @test repr(complex(interval(1, 2), interval(-3, -2))) == "(1.5 ± 0.5)_com - im*(2.5 ± 0.5)_com"

            setdisplay(; decorations = false)
            @test repr(a) == "(1.0 ± 1.0) + im*(1.0 ± 0.0)"
            @test repr(b) == "(1.0 ± 1.0) - im*(1.0 ± 0.0)"
            @test repr(c) == "(5.0e-71 ± 5.0e-71) - im*(1.0e-70 ± 0.0)"
        finally
            setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)
        end
    end
end

@testset "String helpers" begin
    @test IntervalArithmetic._round_string(0.1, 6) == "0.1"
    @test IntervalArithmetic._round_string(1/3, 6) == "0.333333"
    @test IntervalArithmetic._round_string(1.0, 6) == "1.0"
    @test IntervalArithmetic._round_string(0.0, 6) == "0.0"
    @test IntervalArithmetic._round_string(123456789.0, 6) == "1.23457e+8"
    @test IntervalArithmetic._round_string(1e100, 6) == "1.0e+100"
    @test IntervalArithmetic._round_string(1/3, 6, RoundDown) == "0.333333"
    @test IntervalArithmetic._round_string(1/3, 6, RoundUp) == "0.333334"
    @test IntervalArithmetic._round_string(Inf, 6) == "Inf"
    @test IntervalArithmetic._round_string(-Inf, 6) == "-Inf"
    @test IntervalArithmetic._round_string(NaN, 6) == "NaN"

    @test IntervalArithmetic._count_sigdigits("0.1") == 1
    @test IntervalArithmetic._count_sigdigits("1.0e5") == 2
    @test IntervalArithmetic._count_sigdigits("1234.5") == 5
    @test IntervalArithmetic._count_sigdigits("-0.001200") == 7

    @test IntervalArithmetic._display_midpoint_radius(bareinterval(0.1, 0.3), 6) == (0.2, 0.1)
    @test IntervalArithmetic._display_midpoint_radius(bareinterval(-Inf, Inf), 6) == (0.0, Inf)
    @test IntervalArithmetic._display_midpoint_radius(bareinterval(1.0, Inf), 6) ==
        (round(floatmax(Float64), RoundNearest; sigdigits = 6), Inf)
    @test IntervalArithmetic._display_midpoint_radius(bareinterval(0.1, 0.30000001), 3) == (0.2, 0.101)

    @test IntervalArithmetic._flipl(']') == '['
    @test IntervalArithmetic._flipl(')') == '('
    @test IntervalArithmetic._flipr('[') == ']'
    @test IntervalArithmetic._flipr('(') == ')'

    @test IntervalArithmetic._subscriptify(0) === '₀'
    @test IntervalArithmetic._subscriptify(9) === '₉'
    @test IntervalArithmetic._subscriptify(53) == "₅₃"
    @test IntervalArithmetic._subscriptify(256) == "₂₅₆"
    for (i, c) ∈ enumerate(('₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'))
        @test IntervalArithmetic._subscript_digit(i - 1) === c
    end
    @test IntervalArithmetic._subscript_digit(10) === '₉'
    @test IntervalArithmetic._subscript_digit(-1) === '₉'
end

@testset "Enclosure properties" begin
    rng = MersenneTwister(20260821)
    for _ ∈ 1:100
        lo = 1000 * randn(rng)
        hi = lo + 100 * rand(rng)
        prev_lo, prev_hi = -Inf, Inf
        for sigdigits ∈ 1:10
            plo = parse(Float64, IntervalArithmetic._round_string(lo, sigdigits, RoundDown))
            phi = parse(Float64, IntervalArithmetic._round_string(hi, sigdigits, RoundUp))
            @test plo ≤ lo && hi ≤ phi
            @test prev_lo ≤ plo && phi ≤ prev_hi
            prev_lo, prev_hi = plo, phi
        end
        for sigdigits ∈ 1:6
            m_d, r_d = IntervalArithmetic._display_midpoint_radius(bareinterval(lo, hi), sigdigits)
            @test issubset_interval(interval(lo, hi), interval(m_d, r_d; format = :midpoint))
        end
    end
end
