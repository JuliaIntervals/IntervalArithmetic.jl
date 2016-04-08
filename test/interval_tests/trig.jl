# This file is part of the ValidatedNumerics.jl package; MIT licensed

using ValidatedNumerics
using FactCheck

setprecision(Interval, 128)
setprecision(Interval, Float64)

facts("Trig tests") do
    @fact sin(@interval(0.5)) --> Interval(0.47942553860420295, 0.47942553860420301)
    @fact sin(@interval(0.5, 1.67)) --> Interval(4.7942553860420295e-01, 1.0)
    @fact sin(@interval(1.67, 3.2)) --> Interval(-5.8374143427580093e-02, 9.9508334981018021e-01)
    @fact sin(@interval(2.1, 5.6)) --> Interval(-1.0, 0.863209366648874)
    @fact sin(@interval(0.5, 8.5)) --> Interval(-1.0, 1.0)
    @fact sin(@floatinterval(-4.5, 0.1)) --> Interval(-1.0, 0.9775301176650971)
    @fact sin(@floatinterval(1.3, 6.3)) --> Interval(-1.0, 1.0)

    @fact sin(@biginterval(0.5)) ⊆ sin(@interval(0.5)) --> true
    @fact sin(@biginterval(0.5, 1.67)) ⊆ sin(@interval(0.5, 1.67)) --> true
    @fact sin(@biginterval(1.67, 3.2)) ⊆ sin(@interval(1.67, 3.2)) --> true
    @fact sin(@biginterval(2.1, 5.6)) ⊆ sin(@interval(2.1, 5.6)) --> true
    @fact sin(@biginterval(0.5, 8.5)) ⊆ sin(@interval(0.5, 8.5)) --> true
    @fact sin(@biginterval(-4.5, 0.1)) ⊆ sin(@interval(-4.5, 0.1)) --> true
    @fact sin(@biginterval(1.3, 6.3)) ⊆ sin(@interval(1.3, 6.3)) --> true

    @fact cos(@interval(0.5)) --> Interval(0.87758256189037265, 0.87758256189037276)
    @fact cos(@interval(0.5, 1.67)) --> Interval(-0.09904103659872825, 0.8775825618903728)
    @fact cos(@interval(2.1, 5.6)) --> Interval(-1.0, 0.77556587851025016)
    @fact cos(@interval(0.5, 8.5)) --> Interval(-1.0, 1.0)
    @fact cos(@interval(1.67, 3.2)) --> Interval(-1.0, -0.09904103659872801)

    @fact cos(@biginterval(0.5)) ⊆ cos(@interval(0.5)) --> true
    @fact cos(@biginterval(0.5, 1.67)) ⊆ cos(@interval(0.5, 1.67)) --> true
    @fact cos(@biginterval(1.67, 3.2)) ⊆ cos(@interval(1.67, 3.2)) --> true
    @fact cos(@biginterval(2.1, 5.6)) ⊆ cos(@interval(2.1, 5.6)) --> true
    @fact cos(@biginterval(0.5, 8.5)) ⊆ cos(@interval(0.5, 8.5)) --> true
    @fact cos(@biginterval(-4.5, 0.1)) ⊆ cos(@interval(-4.5, 0.1)) --> true
    @fact cos(@biginterval(1.3, 6.3)) ⊆ cos(@interval(1.3, 6.3)) --> true

    @fact tan(@interval(0.5)) --> Interval(0.54630248984379048, 0.5463024898437906)
    @fact tan(@interval(0.5, 1.67)) --> entireinterval()
    @fact tan(@interval(1.67, 3.2)) --> Interval(-10.047182299210307, 0.05847385445957865)

    @fact tan(@biginterval(0.5)) ⊆ tan(@interval(0.5)) --> true
    @fact tan(@biginterval(0.5, 1.67)) --> entireinterval(BigFloat)
    @fact tan(@biginterval(0.5, 1.67)) ⊆ tan(@interval(0.5, 1.67)) --> true
    @fact tan(@biginterval(1.67, 3.2)) ⊆ tan(@interval(1.67, 3.2)) --> true
    @fact tan(@biginterval(2.1, 5.6)) ⊆ tan(@interval(2.1, 5.6)) --> true
    @fact tan(@biginterval(0.5, 8.5)) ⊆ tan(@interval(0.5, 8.5)) --> true
    @fact tan(@biginterval(-4.5, 0.1)) ⊆ tan(@interval(-4.5, 0.1)) --> true
    @fact tan(@biginterval(1.3, 6.3)) ⊆ tan(@interval(1.3, 6.3)) --> true


    @fact asin(@interval(1)) --> @interval(pi/2)#pi_interval(Float64)/2
    @fact asin(@interval(0.9, 2)) --> asin(@interval(0.9, 1))
    @fact asin(@interval(3, 4)) --> ∅

    @fact asin(@biginterval(1)) ⊆ asin(@interval(1)) --> true
    @fact asin(@biginterval(0.9, 2)) ⊆ asin(@interval(0.9, 2)) --> true
    @fact asin(@biginterval(3, 4)) ⊆ asin(@interval(3, 4)) --> true

    @fact acos(@interval(1)) --> Interval(0., 0.)
    @fact acos(@interval(-2, -0.9)) --> acos(@interval(-1, -0.9))
    @fact acos(@interval(3, 4)) --> ∅

    @fact acos(@biginterval(1)) ⊆ acos(@interval(1)) --> true
    @fact acos(@biginterval(-2, -0.9)) ⊆ acos(@interval(-2, -0.9)) --> true
    @fact acos(@biginterval(3, 4)) ⊆ acos(@interval(3, 4)) --> true

    @fact atan(@interval(-1,1)) -->
        Interval(-pi_interval(Float64).hi/4, pi_interval(Float64).hi/4)
    @fact atan(@interval(0)) --> Interval(0.0, 0.0)
    @fact atan(@biginterval(-1, 1)) ⊆ atan(@interval(-1, 1)) --> true

    @fact atan2(∅, entireinterval()) --> ∅
    @fact atan2(entireinterval(), ∅) --> ∅
    @fact atan2(@interval(0.0, 1.0), @biginterval(0.0)) --> @interval(pi/2)
    @fact atan2(@interval(0.0, 1.0), @interval(0.0)) --> @interval(pi/2)
    @fact atan2(@interval(-1.0, -0.1), @interval(0.0)) --> @interval(-pi/2)
    @fact atan2(@interval(-1.0, 1.0), @interval(0.0)) --> @interval(-pi/2, pi/2)
    @fact atan2(@interval(0.0), @interval(0.1, 1.0)) --> @interval(0.0)
    @fact atan2(@biginterval(0.0, 0.1), @biginterval(0.1, 1.0)) ⊆
        atan2(@interval(0.0, 0.1), @interval(0.1, 1.0)) --> true
    @fact atan2(@interval(0.0, 0.1), @interval(0.1, 1.0)) -->
        Interval(0.0, 0.7853981633974484)
    @fact atan2(@biginterval(-0.1, 0.0), @biginterval(0.1, 1.0)) ⊆
        atan2(@interval(-0.1, 0.0), @interval(0.1, 1.0)) --> true
    @fact atan2(@interval(-0.1, 0.0), @interval(0.1, 1.0)) -->
        Interval(-0.7853981633974484, 0.0)
    @fact atan2(@biginterval(-0.1, -0.1), @biginterval(0.1, Inf)) ⊆
        atan2(@interval(-0.1, -0.1), @interval(0.1, Inf)) --> true
    @fact atan2(@interval(-0.1, 0.0), @interval(0.1, Inf)) -->
        Interval(-0.7853981633974484, 0.0)
    @fact atan2(@biginterval(0.0, 0.1), @biginterval(-2.0, -0.1)) ⊆
        atan2(@interval(0.0, 0.1), @interval(-2.0, -0.1)) --> true
    @fact atan2(@interval(0.0, 0.1), @interval(-2.0, -0.1)) -->
        Interval(2.356194490192345, 3.1415926535897936)
    @fact atan2(@biginterval(-0.1, 0.0), @biginterval(-2.0, -0.1)) ⊆
        atan2(@interval(-0.1, 0.0), @interval(-2.0, -0.1)) --> true
    @fact atan2(@interval(-0.1, 0.0), @interval(-2.0, -0.1)) -->
        @interval(-pi, pi)
    @fact atan2(@biginterval(-0.1, 0.1), @biginterval(-Inf, -0.1)) ⊆
        atan2(@interval(-0.1, 0.1), @interval(-Inf, -0.1)) --> true
    @fact atan2(@interval(-0.1, 0.1), @interval(-Inf, -0.1)) -->
        @interval(-pi, pi)

    @fact atan2(@biginterval(0.0, 0.0), @biginterval(-2.0, 0.0)) ⊆
        atan2(@interval(0.0, 0.0), @interval(-2.0, 0.0)) --> true
    @fact atan2(@interval(-0.0, 0.0), @interval(-2.0, 0.0)) -->
        Interval(3.141592653589793, 3.1415926535897936)
    @fact atan2(@biginterval(0.0, 0.1), @biginterval(-0.1, 0.0)) ⊆
        atan2(@interval(0.0, 0.1), @interval(-0.1, 0.0)) --> true
    @fact atan2(@interval(-0.0, 0.1), @interval(-0.1, 0.0)) -->
        Interval(1.5707963267948966, 3.1415926535897936)
    @fact atan2(@biginterval(-0.1, -0.1), @biginterval(-0.1, 0.0)) ⊆
        atan2(@interval(-0.1, -0.1), @interval(-0.1, 0.0)) --> true
    @fact atan2(@interval(-0.1, -0.1), @interval(-0.1, 0.0)) -->
        Interval(-2.3561944901923453, -1.5707963267948966)
    @fact atan2(@biginterval(-0.1, 0.1), @biginterval(-2.0, 0.0)) ⊆
        atan2(@interval(-0.1, 0.1), @interval(-2.0, 0.0)) --> true
    @fact atan2(@interval(-0.1, 0.1), @interval(-2.0, 0.0)) -->
        @interval(-pi, pi)

    @fact atan2(@biginterval(0.0, 0.0), @biginterval(-2.0, 0.0)) ⊆
        atan2(@interval(0.0, 0.0), @interval(-2.0, 0.0)) --> true
    @fact atan2(@interval(-0.0, 0.0), @interval(-2.0, 0.0)) -->
        Interval(3.141592653589793, 3.1415926535897936)
    @fact atan2(@biginterval(0.0, 0.1), @biginterval(-0.1, 0.0)) ⊆
        atan2(@interval(0.0, 0.1), @interval(-0.1, 0.0)) --> true
    @fact atan2(@interval(-0.0, 0.1), @interval(-0.1, 0.0)) -->
        Interval(1.5707963267948966, 3.1415926535897936)
    @fact atan2(@biginterval(-0.1, -0.1), @biginterval(-0.1, 0.0)) ⊆
        atan2(@interval(-0.1, -0.1), @interval(-0.1, 0.0)) --> true
    @fact atan2(@interval(-0.1, -0.1), @interval(-0.1, 0.0)) -->
        Interval(-2.3561944901923453, -1.5707963267948966)
    @fact atan2(@biginterval(-0.1, 0.1), @biginterval(-2.0, 0.0)) ⊆
        atan2(@interval(-0.1, 0.1), @interval(-2.0, 0.0)) --> true
    @fact atan2(@interval(-0.1, 0.1), @interval(-2.0, 0.0)) -->
        @interval(-pi, pi)
    @fact atan2(@biginterval(0.0, 0.1), @biginterval(-2.0, 0.1)) ⊆
        atan2(@interval(0.0, 0.1), @interval(-2.0, 0.1)) --> true
    @fact atan2(@interval(-0.0, 0.1), @interval(-2.0, 0.1)) -->
        Interval(0.0, 3.1415926535897936)
    @fact atan2(@biginterval(-0.1, -0.1), @biginterval(-0.1, 0.1)) ⊆
        atan2(@interval(-0.1, -0.1), @interval(-0.1, 0.1)) --> true
    @fact atan2(@interval(-0.1, -0.1), @interval(-0.1, 0.1)) -->
        Interval(-2.3561944901923453, -0.7853981633974482)
    @fact atan2(@biginterval(-0.1, 0.1), @biginterval(-2.0, 0.1)) ⊆
        atan2(@interval(-0.1, 0.1), @interval(-2.0, 0.1)) --> true
    @fact atan2(@interval(-0.1, 0.1), @interval(-2.0, 0.1)) -->
        @interval(-pi, pi)

    @fact atan2(@interval(-0.1, 0.1), @interval(0.1, 0.1)) -->
        Interval(-0.7853981633974484, 0.7853981633974484)
    @fact atan2(@biginterval(-0.1, 0.1), @biginterval(0.1, 0.1)) ⊆
        atan2(@interval(-0.1, 0.1), @interval(0.1, 0.1)) --> true
    @fact atan2(@interval(0.0), @interval(-0.0, 0.1)) --> @interval(0.0)
    @fact atan2(@interval(0.0, 0.1), @interval(-0.0, 0.1)) -->
        Interval(0.0, 1.5707963267948968)
    @fact atan2(@interval(-0.1, 0.0), @interval(0.0, 0.1)) -->
        Interval(-1.5707963267948968, 0.0)
    @fact atan2(@interval(-0.1, 0.1), @interval(-0.0, 0.1)) -->
        Interval(-1.5707963267948968, 1.5707963267948968)
    @fact atan2(@biginterval(-0.1, 0.1), @biginterval(-0.0, 0.1)) ⊆
        atan2(@interval(-0.1, 0.1), @interval(0.0, 0.1)) --> true

    for a in ( @interval(17, 19), @interval(0.5, 1.2) )
        @fact tan(a) ⊆ sin(a)/cos(a) --> true
    end

end
