# This file is part of the ValidatedNumerics.jl package; MIT licensed

using ValidatedNumerics
using FactCheck

facts("Constructing intervals") do
    setprecision(Interval, 53)
    @fact ValidatedNumerics.parameters.precision --> 53

    setprecision(Interval, Float64)
    @fact ValidatedNumerics.parameters.precision --> 53

    # There is an inexplicable error on 0.5 with the following:
    @pending precision(BigFloat) --> 53
    @pending precision(Interval) --> (Float64, 53)

    # Checks for parameters
    @fact ValidatedNumerics.parameters.precision_type --> Float64
    @fact ValidatedNumerics.parameters.precision --> 53
    @fact ValidatedNumerics.parameters.rounding --> :narrow
    @fact ValidatedNumerics.parameters.pi --> @biginterval(pi)

    # Naive constructors, with no conversion involved
    @fact Interval(1) --> Interval(1.0, 1.0)
    @fact Interval(big(1)) --> Interval(1.0, 1.0)
    @fact Interval(eu) --> Interval(1.0*eu)
    @fact Interval(1//10) --> Interval{Rational{Int}}(1//10, 1//10)
    @fact Interval(BigInt(1)//10) --> Interval{Rational{BigInt}}(1//10, 1//10)
    @fact Interval( (1.0, 2.0) ) --> Interval(1.0, 2.0)

    @fact Interval{Rational{Int}}(1) --> Interval(1//1)
    #@fact Interval{Rational{Int}}(pi) --> Interval(rationalize(1.0*pi))

    @fact Interval{BigFloat}(1) --> Interval{BigFloat}(big(1.0),big(1.0))
    @fact Interval{BigFloat}(pi) -->
        Interval{BigFloat}(big(3.1415926535897931), big(3.1415926535897936))

    # Disallowed conversions with a > b

    @fact_throws ArgumentError Interval(2, 1)
    @fact_throws ArgumentError Interval(big(2), big(1))
    @fact_throws ArgumentError Interval(BigInt(1), 1//10)
    @fact_throws ArgumentError Interval(1, 0.1)
    @fact_throws ArgumentError Interval(big(1), big(0.1))

    @fact_throws ArgumentError @interval(2, 1)
    @fact_throws ArgumentError @interval(big(2), big(1))
    @fact_throws ArgumentError @interval(big(1), 1//10)
    @fact_throws ArgumentError @interval(1, 0.1)
    @fact_throws ArgumentError @interval(big(1), big(0.1))

    # Conversions; may involve rounding
    # @fact convert(Interval, 1) --> Interval(1.0)
    # @fact convert(Interval, pi) --> @interval(pi)
    # @fact convert(Interval, eu) --> @interval(eu)
    # @fact convert(Interval, BigInt(1)) --> Interval(BigInt(1))
    # @fact convert(Interval, 1//10) --> @interval(1//10)
    # @fact convert(Interval, 0.1) --> Interval(0.09999999999999999, 0.1)
    # @fact convert(Interval, BigFloat(0.1)) --> Interval(big(0.1))


    @fact convert(Interval{Rational{Int}}, 0.1) --> Interval(1//10)
    # @fact convert(Interval{Rational{BigInt}}, pi) --> Interval{Rational{BigInt}}(pi)

    ## promotion
    @fact promote(Interval(2//1,3//1), Interval(1, 2)) -->
        (Interval(2.0,3.0), Interval(1.0,2.0))
    @fact promote(Interval(1.5), parse(BigFloat, "2.1")) -->
        (Interval(BigFloat(1.5)), Interval(BigFloat(2.1)))
    @fact promote(Interval(1.0), pi) --> (Interval(1.0), @interval(pi))

    # Constructors from the macros @interval, @floatinterval @biginterval
    setprecision(Interval, 53)

    a = @interval(0.1)
    b = @interval(pi)

    @fact nextfloat(a.lo) --> a.hi
    @fact typeof(a) --> Interval{BigFloat}
    @fact a --> @biginterval("0.1")
    @fact convert(Interval{Float64}, a) --> @floatinterval(0.1)
    @fact nextfloat(b.lo) --> b.hi

    @fact b --> @biginterval(pi)
    x = 10238971209348170283710298347019823749182374098172309487120398471029837409182374098127304987123049817032984712039487
    @fact @interval(x) --> @biginterval(x)
    @fact isthin(@interval(x)) --> false

    x = 0.1
    a = @interval(x)
    @fact nextfloat(a.lo) --> a.hi


    setprecision(Interval, Float64)
    a = @interval(0.1)
    b = @interval(pi)

    @fact a --> @floatinterval("0.1")
    @fact typeof(a) --> Interval{Float64}
    @fact nextfloat(a.lo) --> a.hi
    @fact b --> @floatinterval(pi)
    @fact nextfloat(b.lo) --> b.hi
    @fact convert(Interval{Float64}, @biginterval(0.1)) --> a
    x = typemax(Int)
    @fact @interval(x) --> @floatinterval(x)
    @fact isthin(@interval(x)) --> false
    x = rand()
    c = @interval(x)
    @fact nextfloat(c.lo) --> c.hi


    a = @interval("[0.1, 0.2]")
    b = @interval(0.1, 0.2)

    @fact a ⊆ b --> true

    @fact_throws ArgumentError @interval("[0.1]")
    @fact_throws ArgumentError @interval("[0.1, 0.2")


    for precision in (64, Float64)
        setprecision(Interval, precision)
        d = big(3)
        f = @interval(d, 2d)
        @fact @interval(3, 6) ⊆ f --> true
    end


    for rounding in (:wide, :narrow)
        a = @interval(0.1, 0.2)
        @fact a ⊆ Interval(0.09999999999999999, 0.20000000000000004) --> true

        b = @interval(0.1)
        @fact b ⊆ Interval(0.09999999999999999, 0.10000000000000002) --> true

        b = setprecision(Interval, 128) do
            @interval(0.1, 0.2)
        end
        @fact b ⊆ Interval(0.09999999999999999, 0.20000000000000004) --> true

        @fact float(b) ⊆ a --> true

        c = @interval("0.1", "0.2")
        @fact c ⊆ a --> true  # c is narrower than a
        @fact Interval(1//2) == Interval(0.5) --> true
        @fact Interval(1//10).lo == rationalize(0.1) --> true
    end

    @fact string(emptyinterval()) == "∅" --> true

    params = ValidatedNumerics.IntervalParameters()
    @fact params.precision_type == BigFloat --> true
    @fact params.precision == 256 --> true
    @fact params.rounding == :narrow --> true

    setprecision(Interval, 53)
    a = big(1)//3
    @fact @interval(a) --> Interval(big(3.3333333333333331e-01), big(3.3333333333333337e-01))

end

facts("Big intervals") do
    a = @floatinterval(3)
    @fact typeof(big(a)) --> Interval{BigFloat}

    @fact @floatinterval(123412341234123412341241234) --> Interval(1.234123412341234e26, 1.2341234123412342e26)
    @fact @interval(big"3") --> @floatinterval(3)
    @fact @floatinterval(big"1e10000") --> Interval(1.7976931348623157e308, ∞)

    a = big(10)^10000
    @fact @floatinterval(a) --> Interval(1.7976931348623157e308, ∞)
    setprecision(Interval, 53)
    @fact @biginterval(a) --> Interval(big"9.9999999999999994e+9999", big"1.0000000000000001e+10000")

end

facts("Complex intervals") do
    a = @floatinterval(3 + 4im)
    @fact a --> Interval(3) + im*Interval(4)

    b = exp(a)
    @fact real(b) --> Interval(-13.12878308146216, -13.128783081462153)
    @fact imag(b) --> Interval(-15.200784463067956, -15.20078446306795)
end

facts("± tests") do
    setprecision(Interval, Float64)

    @fact 3 ± 0.5 --> Interval(2.5, 3.5)
    @fact 3 ± 0.1 --> Interval(2.9, 3.1)
    @fact 0.5 ± 1 --> Interval(-0.5, 1.5)
end
