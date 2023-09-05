using Test
using IntervalArithmetic

let x, b

@testset "setformat tests" begin
    @testset "Interval" begin
        a = interval(1, 2)
        b = interval(-1.1, 1.3)
        c = interval(π)
        # large_expo = IntervalArithmetic.atomic(Interval{BigFloat}, -Inf)
        # Use smaller exponent, cf. JuliaLang/julia#48678
        large_expo = interval(0, big"1e123456789")

        @testset "6 significant digits" begin
            setformat(:standard; sigdigits = 6)

            @test sprint(show, MIME("text/plain"), a) == "[1.0, 2.0]"
            @test sprint(show, MIME("text/plain"), b) == "[-1.10001, 1.30001]"
            @test sprint(show, MIME("text/plain"), c) == "[3.14159, 3.1416]"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "[0.0, 1.00001e+123456789]₂₅₆"
        end

        @testset "10 significant digits" begin
            setformat(; sigdigits = 10)

            @test sprint(show, MIME("text/plain"), a) == "[1.0, 2.0]"
            @test sprint(show, MIME("text/plain"), b) == "[-1.100000001, 1.300000001]"
            @test sprint(show, MIME("text/plain"), c) == "[3.141592653, 3.141592654]"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "[0.0, 1.000000001e+123456789]₂₅₆"
        end

        @testset "20 significant digits" begin
            setformat(; sigdigits = 20)

            @test sprint(show, MIME("text/plain"), a) == "[1.0, 2.0]"
            @test sprint(show, MIME("text/plain"), b) == "[-1.1000000000000000889, 1.3000000000000000445]"
            @test sprint(show, MIME("text/plain"), c) == "[3.1415926535897931159, 3.1415926535897935601]"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "[0.0, 1.0000000000000000001e+123456789]₂₅₆"
        end

        @testset "Full" begin
            setformat(:full)

            @test sprint(show, MIME("text/plain"), a) == "Interval{Float64}(1.0, 2.0)"
            @test sprint(show, MIME("text/plain"), b) == "Interval{Float64}(-1.1, 1.3)"
            @test sprint(show, MIME("text/plain"), c) == "Interval{Float64}(3.141592653589793, 3.1415926535897936)"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "Interval{BigFloat}(0.0, 1.000000000000000000000000000000000000000000000000000000000000000000000000000004e+123456789)"
        end

        @testset "Midpoint" begin
            setformat(:midpoint; sigdigits = 6)

            @test sprint(show, MIME("text/plain"), a) == "1.5 ± 0.5"
            @test sprint(show, MIME("text/plain"), b) == "0.1 ± 1.20001"
            @test sprint(show, MIME("text/plain"), c) == "3.14159 ± 4.4409e-16"
            @test sprint(show, MIME("text/plain"), large_expo) == "(5.0e+123456788 ± 5.00001e+123456788)₂₅₆"

            # issue 175:
            @test sprint(show, MIME("text/plain"), interval(BigFloat, 1, 2)) == "(1.5 ± 0.5)₂₅₆"
        end
    end

    @testset "Interval{Rational{T}}" begin
        a = interval(Rational{Int}, 1//3, 5//4)
        @test typeof(a) == Interval{Rational{Int}}

        setformat(:standard)
        @test sprint(show, MIME("text/plain"), a) == "[1//3, 5//4]"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == string(typeof(a), "(1//3, 5//4)")

        setformat(:midpoint)
        @test sprint(show, MIME("text/plain"), a) == "19//24 ± 11//24"
    end

    @testset "Interval{Float32}" begin
        a = interval(Float32, 1, 2)
        b = interval(Float32, -1, Inf)

        setformat(:standard)
        @test sprint(show, MIME("text/plain"), a) == "[1.0f0, 2.0f0]"
        @test sprint(show, MIME("text/plain"), b) == "[-1.0f0, ∞]"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "Interval{Float32}(1.0f0, 2.0f0)"
        @test sprint(show, MIME("text/plain"), b) == "Interval{Float32}(-1.0f0, Inf32)"

        setformat(:midpoint)
        @test sprint(show, MIME("text/plain"), a) == "1.5f0 ± 0.5f0"
    end

    @testset "Complex{Interval}" begin
        a = Complex(interval(0, 2), interval(1))
        @test typeof(a) == Complex{Interval{Float64}}

        setformat(:standard)
        @test sprint(show, MIME("text/plain"), a) == "[0.0, 2.0] + [1.0, 1.0]im"

        setformat(:midpoint)
        @test sprint(show, MIME("text/plain"), a) == "(1.0 ± 1.0) + (1.0 ± 0.0)im"
    end

    setprecision(BigFloat, 256)

    @testset "DecoratedInterval" begin
        a = DecoratedInterval(1, 2)
        @test typeof(a) == DecoratedInterval{Float64}

        setformat(:standard; decorations = false)
        @test sprint(show, MIME("text/plain"), a) == "[1.0, 2.0]"

        setformat(; decorations = true)
        @test sprint(show, MIME("text/plain"), a) == "[1.0, 2.0]_com"

        setformat(:midpoint; decorations = true)
        @test sprint(show, MIME("text/plain"), a) == "(1.5 ± 0.5)_com"

        # issue 131:
        a = DecoratedInterval(big(2), big(3), com)

        setformat(:standard; decorations = false)
        @test sprint(show, MIME("text/plain"), a) == "[2.0, 3.0]₂₅₆"

        setformat(; decorations = true)
        @test sprint(show, MIME("text/plain"), a) == "[2.0, 3.0]₂₅₆_com"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "DecoratedInterval(Interval{BigFloat}(2.0, 3.0), com)"

        setformat(:midpoint)
        @test sprint(show, MIME("text/plain"), a) == "(2.5 ± 0.5)₂₅₆_com"

        setformat(; decorations = false)
        @test sprint(show, MIME("text/plain"), a) == "(2.5 ± 0.5)₂₅₆"
    end

    setprecision(BigFloat, 128)

    @testset "BigFloat intervals" begin
        a = interval(big(1))
        @test typeof(a) == Interval{BigFloat}

        setformat(:standard; decorations = false)
        @test sprint(show, MIME("text/plain"), a) == "[1.0, 1.0]₁₂₈"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "Interval{BigFloat}(1.0, 1.0)"

        a = DecoratedInterval(big(2), big(3), com)
        @test typeof(a) == DecoratedInterval{BigFloat}

        setformat(:standard; decorations = false)
        @test sprint(show, MIME("text/plain"), a) == "[2.0, 3.0]₁₂₈"

        setformat(:standard; decorations = true)
        @test sprint(show, MIME("text/plain"), a) == "[2.0, 3.0]₁₂₈_com"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "DecoratedInterval(Interval{BigFloat}(2.0, 3.0), com)"
    end
end

@testset "show" begin
    setformat(:standard; decorations = false, sigdigits = 6)
    setprecision(BigFloat, 128)

    x = interval(0, 1)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]"
    @test sprint(show, x) == "Interval{Float64}(0.0, 1.0)"

    x = interval(BigFloat, 0, 1)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]₁₂₈"
    @test sprint(show, x) == "Interval{BigFloat}(0.0, 1.0)"

    x = DecoratedInterval(0, 1, dac)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]"
    @test sprint(show, x) == "DecoratedInterval(Interval{Float64}(0.0, 1.0), dac)"

    x = DecoratedInterval(big(0), big(1), def)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]₁₂₈"
    @test sprint(show, x) == "DecoratedInterval(Interval{BigFloat}(0.0, 1.0), def)"

    setformat(; decorations = true)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]₁₂₈_def"
end

setprecision(BigFloat, 256)

end
