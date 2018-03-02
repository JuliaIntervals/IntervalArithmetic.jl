using IntervalArithmetic
using Base.Test

setprecision(Interval, Float64)

@testset "setformat tests" begin

    @testset "Interval" begin

        a = 1..2
        b = -1.1..1.3
        c = Interval(pi)
        d = @interval(π)

        @testset "6 sig figs" begin
            setformat(:standard, sigfigs=6)

            @test string(a) == "[1, 2]"
            @test string(b) == "[-1.10001, 1.30001]"
            @test string(c) == "[3.14159, 3.1416]"
            @test string(d) == "[3.14159, 3.1416]"
        end

        @testset "10 sig figs" begin
            setformat(sigfigs=10)

            @test string(a) == "[1, 2]"
            @test string(b) == "[-1.100000001, 1.300000001]"
            @test string(c) == "[3.141592653, 3.141592654]"
            @test string(d) == "[3.141592653, 3.141592654]"
        end

        @testset "20 sig figs" begin
            setformat(sigfigs=20)

            @test string(a) == "[1, 2]"
            @test string(b) == "[-1.1000000000000000889, 1.3000000000000000445]"
            @test string(c) == "[3.1415926535897931159, 3.141592653589793116]"
            @test string(d) == "[3.1415926535897931159, 3.1415926535897935601]"
        end

        @testset "Full" begin
            setformat(:full)

            @test string(a) == "Interval(1.0, 2.0)"
            @test string(b) == "Interval(-1.1, 1.3)"
            @test string(c) == "Interval(3.141592653589793, 3.141592653589793)"
            @test string(d) == "Interval(3.141592653589793, 3.1415926535897936)"
        end

        @testset "Midpoint" begin
            setformat(:midpoint, sigfigs=6)

            @test string(a) == "1.5 ± 0.5"
            @test string(b) == "0.1 ± 1.20001"
            @test string(c) == "3.14159 ± 0"
            @test string(d) == "3.14159 ± 4.4409e-16"

            # issue 175:
            @test string(@biginterval(1, 2)) == "1.5 ± 0.5"
        end
    end

    @testset "Interval{Rational{T}}" begin
        a = Interval(1//3, 5//4)
        @test typeof(a)== Interval{Rational{Int}}
        setformat(:standard)
        @test string(a) == "[1//3, 5//4]"

        setformat(:full)
        @test string(a) == "Interval(1//3, 5//4)"

        setformat(:midpoint)
        @test string(a) == "19//24 ± 11//24"
    end


    setprecision(Interval, 256)

    @testset "DecoratedInterval" begin
        a = @decorated(1, 2)
        @test typeof(a)== DecoratedInterval{Float64}

        setformat(:standard, decorations=false)
        @test string(a) == "[1, 2]"

        setformat(:standard, decorations=true)
        @test string(a) == "[1, 2]_com"

        # issue 131:
        a = DecoratedInterval(big(2), big(3), com)

        setformat(:standard, decorations=false)
        @test string(a) == "[2, 3]₂₅₆"

        setformat(decorations=true)
        @test string(a) == "[2, 3]₂₅₆_com"

        setformat(:full)
        @test string(a) == "DecoratedInterval(Interval(2.000000000000000000000000000000000000000000000000000000000000000000000000000000, 3.000000000000000000000000000000000000000000000000000000000000000000000000000000), com)"

        setformat(:midpoint)
        @test string(a) == "2.5 ± 0.5_com"

        setformat(decorations=false)
        @test string(a) == "2.5 ± 0.5"

    end


    setprecision(Interval, 128)

    @testset "BigFloat intervals" begin
        setformat(:standard, decorations=false)

        a = @interval big(1)
        @test typeof(a)== Interval{BigFloat}
        @test string(a) == "[1, 1]₁₂₈"

        setformat(:full)
        @test string(a) == "Interval(1.000000000000000000000000000000000000000, 1.000000000000000000000000000000000000000)"


        a = DecoratedInterval(big(2), big(3), com)
        @test typeof(a)== DecoratedInterval{BigFloat}

        setformat(:standard, decorations=false)
        @test string(a) == "[2, 3]₁₂₈"

        setformat(:standard, decorations=true)
        @test string(a) == "[2, 3]₁₂₈_com"

        setformat(:full)
        @test string(a) == "DecoratedInterval(Interval(2.000000000000000000000000000000000000000, 3.000000000000000000000000000000000000000), com)"
    end


    setprecision(Interval, Float64)

    @testset "IntervalBox" begin

        setformat(:standard, sigfigs=6)

        X = IntervalBox(1..2, 3..4)
        @test typeof(X) == IntervalBox{2,Float64}
        @test string(X) == "[1, 2] × [3, 4]"

        s = sprint(show, MIME("text/plain"), X)
        @test s == "[1, 2] × [3, 4]"

        X = IntervalBox(1.1..1.2, 2.1..2.2)
        @test string(X) == "[1.09999, 1.20001] × [2.09999, 2.20001]"

        X = IntervalBox(-Inf..Inf, -Inf..Inf)
        @test string(X) == "[-∞, ∞] × [-∞, ∞]"

        setformat(:full)
        @test string(X) == "IntervalBox(Interval(-Inf, Inf), Interval(-Inf, Inf))"

    end
end

@testset "showall" begin
    setformat(:standard, decorations=false, sigfigs=6)
    setprecision(128)

    x = 0..1
    @test string(x) == "[0, 1]"
    @test sprint(showall, x) == "Interval(0.0, 1.0)"

    x = @biginterval(0, 1)
    @test string(x) == "[0, 1]₁₂₈"
    @test sprint(showall, x) == "Interval(0.000000000000000000000000000000000000000, 1.000000000000000000000000000000000000000)"

    x = DecoratedInterval(0, 1, dac)
    @test string(x) == "[0, 1]"
    @test sprint(showall, x) == "DecoratedInterval(Interval(0.0, 1.0), dac)"

    x = DecoratedInterval(big(0), big(1), def)
    @test string(x) == "[0, 1]₁₂₈"
    @test sprint(showall, x) == "DecoratedInterval(Interval(0.000000000000000000000000000000000000000, 1.000000000000000000000000000000000000000), def)"

    setformat(decorations=true)
    @test string(x) == "[0, 1]₁₂₈_def"

end

@testset "@format tests" begin
    x = 0.1..0.3

    @format full
    @test string(x) == "Interval(0.09999999999999999, 0.30000000000000004)"

    @format standard 3
    @test string(x) == "[0.0999, 0.301]"

    @format 10
    @test string(x) == "[0.09999999999, 0.3000000001]"
end
