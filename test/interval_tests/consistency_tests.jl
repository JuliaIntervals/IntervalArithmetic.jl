using ValidatedNumerics
using FactCheck

set_bigfloat_precision(53)

facts("Consistency tests") do

    a = @interval(1.1, 0.1)
    b = @interval(0.9, 2.0)
    c = @interval(0.25, 4.0)

    @fact isa( @interval(1,2), Interval ) --> true
    @fact isa( @interval(0.1), Interval ) --> true
    @fact isa( zero(b), Interval ) --> true

    @fact zero(b) --> 0.0
    @fact zero(b) == zero(typeof(b)) --> true
    @fact one(a) --> 1.0
    @fact one(a) == one(typeof(a)) --> true
    @fact one(a) --> big(1.0)
    @fact a == b --> false
    @fact a != b --> true

    @fact a --> Interval(a.lo, a.hi)
    @fact a --> @interval(a.lo, a.hi)
    @fact @interval(1, Inf) --> Interval(1.0, Inf)
    # @fact @interval(Inf, -Inf) --> emptyinterval()
    # @fact @interval(-Inf, Inf) --> emptyinterval()

    @fact 1 == zero(a)+one(b) --> true
    @fact Interval(0,1) + emptyinterval(a) --> emptyinterval(a)
    @fact @interval(0.25) - one(c)/4 --> zero(c)
    @fact emptyinterval(a) - Interval(0,1) --> emptyinterval(a)
    @fact Interval(0,1) - emptyinterval(a) --> emptyinterval(a)
    @fact a*b --> @interval(a.lo*b.lo, a.hi*b.hi)
    @fact Interval(0,1) * emptyinterval(a) --> emptyinterval(a)
    @fact a * Interval(0) --> zero(a)

    @fact inv( zero(a) ) --> emptyinterval()
    @fact inv( @interval(0, 1) ) --> Interval(1, Inf)
    @fact inv( @interval(1, Inf) ) --> Interval(0, 1)
    @fact inv(c) --> c
    @fact one(a)/b --> inv(b)
    @fact a/emptyinterval(a) --> emptyinterval(a)
    @fact emptyinterval(a)/a --> emptyinterval(a)
    @fact inv(@interval(-4.0,0.0)) --> @interval(-Inf, -0.25)
    @fact inv(@interval(0.0,4.0)) --> @interval(0.25, Inf)
    @fact inv(@interval(-4.0,4.0)) --> entireinterval(Float64)
    @fact @interval(0)/@interval(0) --> emptyinterval()
    @fact typeof(emptyinterval()) --> Interval{Float64}

    @fact 0.1 ∈ @interval(0.1) --> true
    @fact 0.1 in @interval(0.1) --> true

    @fact b ⊆ c --> true
    @fact emptyinterval(c) ⊆ c --> true
    @fact c ⊆ emptyinterval(c) --> false
    @fact interior(b,c) --> true
    @fact b ⪽ emptyinterval(b) --> false
    @fact emptyinterval(c) ⊊ c --> true
    @fact emptyinterval(c) ⪽ emptyinterval(c) --> true
    @fact isdisjoint(a, @interval(2.1)) --> true
    @fact isdisjoint(a, b) --> false
    @fact isdisjoint(emptyinterval(a), a) --> true
    @fact isdisjoint(emptyinterval(), emptyinterval()) --> true

    @fact emptyinterval() --> Interval(Inf, -Inf)
    @fact a ∩ @interval(-1) --> emptyinterval(a)
    @fact isempty(a ∩ @interval(-1) ) --> true
    @fact isempty(a) --> false
    @fact emptyinterval(a) == a --> false
    @fact emptyinterval() == emptyinterval() --> true

    @fact intersect(a, hull(a,b)) --> a
    @fact union(a,b) --> @interval(a.lo, b.hi)

    @fact entireinterval(Float64) --> Interval(-Inf, Inf)
    @fact isentire(entireinterval(a)) --> true
    @fact isentire(a) --> false

    @fact nai(a) == nai(a) --> false
    @fact nai(a) === nai(a) --> true
    @fact nai(Float64) === Interval(NaN) --> true
    @fact isnan(nai(BigFloat).lo) --> true
    @fact isnai(nai()) --> true
    @fact isnai(a) --> false

    @fact infimum(a) == a.lo --> true
    @fact supremum(a) == a.hi --> true
    @fact infimum(emptyinterval(a)) --> Inf
    @fact supremum(emptyinterval(a)) --> -Inf
    @fact infimum(entireinterval(a)) --> -Inf
    @fact supremum(entireinterval(a)) --> Inf
    @fact isnan(supremum(nai(BigFloat))) --> true

    @fact diam( @interval(1//2) ) --> zero(BigFloat)
    @fact diam( @interval(0.1) ) --> eps(0.1)
    @fact mig(@interval(-2,2)) --> BigFloat(0.0)
    @fact mag(-b) --> b.hi
    @fact diam(a) == a.hi - a.lo --> true
    @fact mid(c) == 2.125 --> true
    @fact isnan(mid(emptyinterval())) --> true
    @fact mid(entireinterval()) == 0.0 --> true
    @fact isnan(mid(nai())) --> true

    @fact log(@interval(-2,5)) --> @interval(-Inf,log(5.0))

    # Test putting functions in @interval:
    @fact @interval(sin(0.1) + cos(0.2)) --> sin(@interval(0.1)) + cos(@interval(0.2))

    f(x) = 2x
    @fact @interval(f(0.1)) --> f(@interval(0.1))

    # midpoint-radius representation
    a = @interval(0.1)
    midpoint, radius = midpoint_radius(a)

    @fact interval_from_midpoint_radius(midpoint, radius) -->
        Interval(0.09999999999999999, 0.10000000000000002)

end

facts("Precision tests") do
    set_interval_precision(64)
    a = @interval(0.1, 0.3)

    @fact get_interval_precision() == (BigFloat, 64) --> true

    set_interval_precision(Float64)

    @fact get_interval_precision() == (Float64, -1) --> true

    b = with_interval_precision(64) do
        @interval(0.1, 0.3)
    end

    @fact a == b --> true
end

facts("Interval rounding tests") do
    set_interval_rounding(:wide)
    @fact get_interval_rounding() == :wide --> true

    @fact_throws ArgumentError set_interval_rounding(:hello)
end

facts("Constructing intervals") do
    set_interval_precision(Float64)
    a = @interval("[0.1, 0.2]")
    b = @interval(0.1, 0.2)

    @fact a ⊆ b --> true

    @fact_throws ArgumentError @interval("[0.1, 0.2")

    @fact Interval( (0.1, 0.2) ) == Interval(0.1, 0.2) --> true


    set_interval_rounding(:wide)
    set_interval_precision(Float64)
    a = @interval(0.1, 0.2)

    @fact a == Interval(0.09999999999999998, 0.20000000000000007) --> true

    b = @interval(0.1)
    @fact b == Interval(0.09999999999999998, 0.10000000000000003) --> true

    c = @interval("0.1", "0.2")
    @fact c ⊆ a --> true  # c is narrower than a

    for precision in (64, Float64)
        set_interval_precision(precision)
        d = big(3)
        f = @interval(d, 2d)
        @fact @interval(3, 6) ⊆ f --> true
    end


    for rounding in (:wide, :narrow)

        set_interval_precision(Float64)

        a = @interval(0.1, 0.2)
        b = with_interval_precision(128) do
            @interval(0.1, 0.2)
        end

        @fact float(b) ⊆ a --> true
    end
end

set_interval_rounding(:narrow)
set_interval_precision(Float64)

facts("Interval power of an interval") do
    a = @interval(1, 2)
    b = @interval(3, 4)

    @fact a^b == @interval(1, 16) --> true
    @fact a^@interval(0.5, 1) == a --> true
    @fact a^@interval(0.3, 0.5) == @interval(1, sqrt(2)) --> true

    @fact b^@interval(0.3) == Interval(1.3903891703159093, 1.5157165665103982) --> true

end

facts("Rational infinity") do
    @fact inf(3//4) == 1//0 --> true
end
