
using ValidatedNumerics
using FactCheck

setprecision(Interval, Float64)

facts("displaymode tests") do

    context("Interval") do

        a = 1..2
        b = -1.1..1.3
        c = Interval(pi)
        d = @interval(π)

        context("6 sig figs") do
            displaymode(format=:standard, sigfigs=6)

            @fact string(a) --> "[1, 2]"
            @fact string(b) --> "[-1.10001, 1.30001]"
            @fact string(c) --> "[3.14159, 3.1416]"
            @fact string(d) --> "[3.14159, 3.1416]"
        end

        context("10 sig figs") do
            displaymode(sigfigs=10)

            @fact string(a) --> "[1, 2]"
            @fact string(b) --> "[-1.100000001, 1.300000001]"
            @fact string(c) --> "[3.141592653, 3.141592654]"
            @fact string(d) --> "[3.141592653, 3.141592654]"
        end

        context("20 sig figs") do
            displaymode(sigfigs=20)

            @fact string(a) --> "[1, 2]"
            @fact string(b) --> "[-1.1000000000000000889, 1.3000000000000000445]"
            @fact string(c) --> "[3.1415926535897931159, 3.141592653589793116]"
            @fact string(d) --> "[3.1415926535897931159, 3.1415926535897935601]"
        end

        context("Full") do
            displaymode(format=:full)

            @fact string(a) --> "Interval(1.0, 2.0)"
            @fact string(b) --> "Interval(-1.1, 1.3)"
            @fact string(c) --> "Interval(3.141592653589793, 3.141592653589793)"
            @fact string(d) --> "Interval(3.141592653589793, 3.1415926535897936)"
        end

        context("Midpoint") do
            displaymode(format=:midpoint, sigfigs=6)

            @fact string(a) --> "1.5 ± 0.5"
            @fact string(b) --> "0.1 ± 1.20001"
            @fact string(c) --> "3.14159 ± 0"
            @fact string(d) --> "3.14159 ± 4.4409e-16"
        end


    end

    context("DecoratedInterval") do
        a = @decorated(1, 2)

        displaymode(format=:standard, decorations=false)

        @fact string(a) --> "[1, 2]"

        displaymode(format=:standard, decorations=true)

        @fact string(a) --> "[1, 2]_com"

    end

    context("IntervalBox") do
        displaymode(sigfigs=6)

        X = IntervalBox(1..2, 3..4)
        @fact string(X) --> "[1, 2] × [3, 4]"

        X = IntervalBox(1.1..1.2, 2.1..2.2)
        @fact string(X) --> "[1.09999, 1.20001] × [2.09999, 2.20001]"

    end
end
