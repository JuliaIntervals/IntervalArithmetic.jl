using IntervalArithmetic
using Test

let x, b

@testset "setformat tests" begin
    @testset "Interval" begin
        a = 1..2
        b = -1.1..1.3
        c = interval(pi)
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

            @test sprint(show, MIME("text/plain"), a) == "Interval(1.0, 2.0)"
            @test sprint(show, MIME("text/plain"), b) == "Interval(-1.1, 1.3)"
            @test sprint(show, MIME("text/plain"), c) == "Interval(3.141592653589793, 3.1415926535897936)"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "Interval(0.0, 1.000000000000000000000000000000000000000000000000000000000000000000000000000004e+123456789)"
        end

        @testset "Midpoint" begin
            setformat(:midpoint; sigdigits = 6)

            @test sprint(show, MIME("text/plain"), a) == "1.5 ± 0.5"
            @test sprint(show, MIME("text/plain"), b) == "0.1 ± 1.20001"
            @test sprint(show, MIME("text/plain"), c) == "3.14159 ± 4.4409e-16"
            @test sprint(show, MIME("text/plain"), large_expo) == "(5.0e+123456788 ± 5.00001e+123456788)₂₅₆"

            # issue 175:
            @test sprint(show, MIME("text/plain"), @biginterval(1, 2)) == "(1.5 ± 0.5)₂₅₆"
        end
    end

    @testset "Interval{Rational{T}}" begin
        a = interval(1//3, 5//4)
        @test_broken typeof(a) == Interval{Rational{Int}}

        setformat(:standard)
        @test_broken sprint(show, MIME("text/plain"), a) == "[1//3, 5//4]"

        setformat(:full)
        @test_broken sprint(show, MIME("text/plain"), a) == "Interval(1//3, 5//4)"

        setformat(:midpoint)
        @test_broken sprint(show, MIME("text/plain"), a) == "19//24 ± 11//24"
    end

    @testset "Interval{Float32}" begin
        a = Interval{Float32}(1, 2)
        b = Interval{Float32}(-1, Inf)

        setformat(:standard)
        @test sprint(show, MIME("text/plain"), a) == "[1.0f0, 2.0f0]"
        @test sprint(show, MIME("text/plain"), b) == "[-1.0f0, ∞]"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "Interval(1.0f0, 2.0f0)"
        @test sprint(show, MIME("text/plain"), b) == "Interval(-1.0f0, ∞)"

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
        a = @decorated(1, 2)
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
        @test sprint(show, MIME("text/plain"), a) == "DecoratedInterval(Interval(2.0, 3.0), com)"

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
        @test sprint(show, MIME("text/plain"), a) == "Interval(1.0, 1.0)"

        a = DecoratedInterval(big(2), big(3), com)
        @test typeof(a) == DecoratedInterval{BigFloat}

        setformat(:standard; decorations = false)
        @test sprint(show, MIME("text/plain"), a) == "[2.0, 3.0]₁₂₈"

        setformat(:standard; decorations = true)
        @test sprint(show, MIME("text/plain"), a) == "[2.0, 3.0]₁₂₈_com"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "DecoratedInterval(Interval(2.0, 3.0), com)"
    end

    @testset "IntervalBox" begin
        X = IntervalBox(1..2, 3..4)
        @test typeof(X) == IntervalBox{2,Float64}

        setformat(:standard; sigdigits = 6)
        @test sprint(show, MIME("text/plain"), X) == "[1.0, 2.0] × [3.0, 4.0]"
        X = IntervalBox(1.1..1.2, 2.1..2.2)
        @test sprint(show, MIME("text/plain"), X) == "[1.09999, 1.20001] × [2.09999, 2.20001]"
        X = IntervalBox(-Inf..Inf, -Inf..Inf)
        @test sprint(show, MIME("text/plain"), X) == "[-∞, ∞]²"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), X) == "IntervalBox(Interval(-Inf, Inf), 2)"

        setformat(:standard)
        a = IntervalBox(1..2, 2..3)
        @test sprint(show, MIME("text/plain"), a) == "[1.0, 2.0] × [2.0, 3.0]"
        b = IntervalBox(emptyinterval(), 2)
        @test sprint(show, MIME("text/plain"), b) == "∅²"
        c = IntervalBox(1..2, 1)
        @test sprint(show, MIME("text/plain"), c) == "[1.0, 2.0]¹"

        setformat(:full)
        @test sprint(show, MIME("text/plain"), a) == "IntervalBox(Interval(1.0, 2.0), Interval(2.0, 3.0))"
        @test sprint(show, MIME("text/plain"), b) == "IntervalBox(∅, 2)"
        @test sprint(show, MIME("text/plain"), c) == "IntervalBox(Interval(1.0, 2.0), 1)"

        setformat(:midpoint)
        @test sprint(show, MIME("text/plain"), a) == "(1.5 ± 0.5) × (2.5 ± 0.5)"
        @test sprint(show, MIME("text/plain"), b) == "∅²"
        @test sprint(show, MIME("text/plain"), c) == "(1.5 ± 0.5)¹"
    end
end

@testset "show" begin
    setformat(:standard; decorations = false, sigdigits = 6)
    setprecision(BigFloat, 128)

    x = 0..1
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]"
    @test sprint(show, x) == "Interval(0.0, 1.0)"

    x = @biginterval(0, 1)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]₁₂₈"
    @test sprint(show, x) == "Interval(0.0, 1.0)"

    x = DecoratedInterval(0, 1, dac)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]"
    @test sprint(show, x) == "DecoratedInterval(Interval(0.0, 1.0), dac)"

    x = DecoratedInterval(big(0), big(1), def)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]₁₂₈"
    @test sprint(show, x) == "DecoratedInterval(Interval(0.0, 1.0), def)"

    setformat(; decorations = true)
    @test sprint(show, MIME("text/plain"), x) == "[0.0, 1.0]₁₂₈_def"

    a = IntervalBox(1..2, 2..3)
    b = IntervalBox(emptyinterval(), 2)
    c = IntervalBox(1..2, 1)

    @test sprint(show, a) == "IntervalBox(Interval(1.0, 2.0), Interval(2.0, 3.0))"
    @test sprint(show, b) == "IntervalBox(∅, 2)"
    @test sprint(show, c) == "IntervalBox(Interval(1.0, 2.0), 1)"

end

@testset "@format tests" begin
    x = prevfloat(0.1)..nextfloat(0.3)

    @format full
    @test sprint(show, MIME("text/plain"), x) == "Interval(0.09999999999999999, 0.30000000000000004)"

    @format standard 3
    @test sprint(show, MIME("text/plain"), x) == "[0.0999, 0.301]"

    @format standard 10
    @test sprint(show, MIME("text/plain"), x) == "[0.09999999999, 0.3000000001]"
end

setprecision(BigFloat, 256)

end
