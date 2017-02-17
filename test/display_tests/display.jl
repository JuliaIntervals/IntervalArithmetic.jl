if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end
using ValidatedNumerics

setprecision(Interval, Float64)

@testset "displaymode tests" begin

    @testset "Interval" begin

        a = 1..2
        b = -1.1..1.3
        c = Interval(pi)
        d = @interval(π)

        @testset "6 sig figs" begin
            displaymode(format=:standard, sigfigs=6)

            @test string(a) == "[1, 2]"
            @test string(b) == "[-1.10001, 1.30001]"
            @test string(c) == "[3.14159, 3.1416]"
            @test string(d) == "[3.14159, 3.1416]"
        end

        @testset "10 sig figs" begin
            displaymode(sigfigs=10)

            @test string(a) == "[1, 2]"
            @test string(b) == "[-1.100000001, 1.300000001]"
            @test string(c) == "[3.141592653, 3.141592654]"
            @test string(d) == "[3.141592653, 3.141592654]"
        end

        @testset "20 sig figs" begin
            displaymode(sigfigs=20)

            @test string(a) == "[1, 2]"
            @test string(b) == "[-1.1000000000000000889, 1.3000000000000000445]"
            @test string(c) == "[3.1415926535897931159, 3.141592653589793116]"
            @test string(d) == "[3.1415926535897931159, 3.1415926535897935601]"
        end

        @testset "Full" begin
            displaymode(format=:full)

            @test string(a) == "Interval(1.0, 2.0)"
            @test string(b) == "Interval(-1.1, 1.3)"
            @test string(c) == "Interval(3.141592653589793, 3.141592653589793)"
            @test string(d) == "Interval(3.141592653589793, 3.1415926535897936)"
        end

        @testset "Midpoint" begin
            displaymode(format=:midpoint, sigfigs=6)

            @test string(a) == "1.5 ± 0.5"
            @test string(b) == "0.1 ± 1.20001"
            @test string(c) == "3.14159 ± 0"
            @test string(d) == "3.14159 ± 4.4409e-16"
        end
    end

    @testset "Interval{Rational{T}}" begin
        a = Interval(1//3, 5//4)
        @test typeof(a)== Interval{Rational{Int}}
        displaymode(format=:standard)
        @test string(a) == "[1//3, 5//4]"

        displaymode(format=:full)
        @test string(a) == "Interval(1//3, 5//4)"

        displaymode(format=:midpoint)
        @test string(a) == "19//24 ± 11//24"
    end

    @testset "DecoratedInterval" begin
        a = @decorated(1, 2)
        @test typeof(a)== DecoratedInterval{Float64}

        displaymode(format=:standard, decorations=false)

        @test string(a) == "[1, 2]"

        displaymode(format=:standard, decorations=true)

        @test string(a) == "[1, 2]_com"
    end


    setprecision(Interval, 128)

    @testset "BigFloat intervals" begin
        displaymode(format=:standard, decorations=false)

        a = @interval big(1)
        @test typeof(a)== Interval{BigFloat}
        @test string(a) == "[1, 1]₁₂₈"

        displaymode(format=:full)
        @test string(a) == "Interval(1.000000000000000000000000000000000000000, 1.000000000000000000000000000000000000000)"


        a = DecoratedInterval(big(2), big(3), com)
        @test typeof(a)== DecoratedInterval{BigFloat}

        displaymode(format=:standard, decorations=false)
        @test string(a) == "[2, 3]₁₂₈"

        displaymode(format=:standard, decorations=true)
        @test string(a) == "[2, 3]₁₂₈_com"

        displaymode(format=:full)
        @test string(a) == "DecoratedInterval(Interval(2.000000000000000000000000000000000000000, 3.000000000000000000000000000000000000000), com)"
    end


    setprecision(Interval, Float64)

    @testset "IntervalBox" begin

        displaymode(format=:standard, sigfigs=6)

        X = IntervalBox(1..2, 3..4)
        @test typeof(X) == IntervalBox{2,Float64}
        @test string(X) == "[1, 2] × [3, 4]"

        X = IntervalBox(1.1..1.2, 2.1..2.2)
        @test string(X) == "[1.09999, 1.20001] × [2.09999, 2.20001]"

        X = IntervalBox(-Inf..Inf, -Inf..Inf)
        @test string(X) == "[-∞, ∞] × [-∞, ∞]"

        displaymode(format=:full)
        @test string(X) == "IntervalBox(Interval(-Inf, Inf), Interval(-Inf, Inf))"

    end
end
