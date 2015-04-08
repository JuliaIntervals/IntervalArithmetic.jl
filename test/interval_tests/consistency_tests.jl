
using ValidatedNumerics
using FactCheck

set_bigfloat_precision(53)

a = @interval(1.1, 0.1)
b = @interval(0.9, 2.0)
c = @interval(0.25, 4.0)

facts("Consistency tests") do


    @fact isa( @interval(1,2), Interval ) => true
    @fact isa( @interval(0.1), Interval ) => true
    @fact isa( zero(b), Interval ) => true

    @fact zero(b) => 0.0
    @fact one(a) => 1.0
    @fact one(a) => big(1.0)
    @fact a == b => false
    @fact a != b => true
    @fact 1 == zero(a)+one(b) => true

    @fact @interval(0.25) - one(c)/4 => zero(c)
    @fact a => Interval(a.lo, a.hi)
    @fact a => @interval(a.lo, a.hi)

    @fact a*b => @interval(a.lo*b.lo, a.hi*b.hi)

    @fact inv( zero(a) ) => Interval(Inf, Inf)
    @fact inv( @interval(0, 1) ) => Interval(1, Inf)
    @fact inv( @interval(1, Inf) ) => Interval(0, 1)
    @fact inv(c) => c
    @fact one(a)/b => inv(b)

    @fact 0.1 ∈ @interval(0.1) => true
    @fact 0.1 in @interval(0.1) => true

    @fact a ∩ @interval(-1) => emptyinterval(a)
    @fact isempty(a ∩ @interval(-1) ) => true
    @fact intersect(a, hull(a,b)) => a
    @fact union(a,b) => @interval(a.lo, b.hi)

    @fact diam( @interval(1//2) ) => zero(BigFloat)
    @fact diam( @interval(0.1) ) => eps(0.1)
    @fact mig(@interval(-2,2)) => BigFloat(0.0)
    @fact mag(-b) => b.hi
    @fact diam(a) == a.hi - a.lo => true

    @fact log(@interval(-2,5)) => @interval(-Inf,log(5.0))

end
