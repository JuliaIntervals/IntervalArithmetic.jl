# Simple tests for Intervals
#using Intervals
using Validated
using Base.Test

set_bigfloat_precision(53)

a = Interval(1.1,0.1)
b = Interval(0.9,2.0)
c = Interval(0.25,4.0)

@test isa(Interval(1,2),Interval)
@test isa(Interval(big(0.1)),Interval)
@test zero(b) == 0.0
@test one(a) == big(1.0)
@test !(a == b)
@test a != b
@test 1 == zero(a)+one(b)
@test Interval(0.25)-one(c)/4 == zero(c)
@test isempty(a,Interval(-1))

@test Interval(0.1) == Interval(0.0999999999999999999,0.1)
@test a == Interval(a.lo,a.hi)
@test a+b == Interval(0.9999999999999999,3.1)
@test -a == Interval(-1.1,-0.0999999999999999999)
#@test a-b == Interval(big(-1.9000000000000001e+00), big(2.0000000000000018e-01))
@test a-b == Interval(big(-1.9000000000000001e+00), big(2.0000000000000018e-01))

# @test a*b == Interval(a.lo*b.lo, a.hi*b.hi)  # Why should this be true?
@test 10a == Interval(big(9.9999999999999989e-01), big(1.1000000000000002e+01))
@test b/a == Interval(big(8.181818181818179e-01), big(2.0000000000000004e+01))
@test a/c == Interval(big(0.024999999999999998), big(4.4))
@test c/4.0 == Interval(0.0625,1.0)

@test inv(zero(a)) == Interval(Inf,Inf)
@test inv(Interval(0,1)) == Interval(1,Inf)
@test inv(Interval(1,Inf)) == Interval(0,1)
@test inv(c) == c
@test one(a)/b == inv(b)

@test Interval(-3,2)^2 == Interval(0,9)
@test Interval(-3,2)^3 == Interval(-27,8)
@test Interval(-3,4)^0.5 == Interval(0,2) == Interval(-3,4)^(1//2)
@test Interval(1,27)^Interval(1//3) == Interval(1, big(3.0000000000000004e+00))  #Interval(1,3)
@test Interval(-3,2)^Interval(2) == Interval(0,9)
@test Interval(-3,4)^Interval(0.5) == Interval(0,2)
@test Interval(0.1,0.7)^(1/3) ==
    Interval(big(4.6415888336127786e-01), big(8.8790400174260087e-01))

@test inv(zero(a)) == Interval(Inf,Inf)
@test inv(Interval(0,1)) == Interval(1,Inf)
@test inv(Interval(1,Inf)) == Interval(0,1)
@test inv(c) == c
@test one(a)/b == inv(b)

@test in(0.1,Interval(0.1))
@test !isinside(0.1,Interval(0.1))
@test intersect(a,Interval(-1)) == nothing
@test intersect(a,hull(a,b)) == a
@test union(a,b) == Interval(a.lo,b.hi)

@test diam( Interval(1//2) ) == zero(BigFloat)
@test diam( Interval(0.1) ) == eps(0.1)
@test mig(Interval(-2,2)) == BigFloat(0.0)
@test mag(-b) == b.hi
@test diam(a) == a.hi - a.lo

@test exp(Interval(1//2)) ==
    Interval(big(1.648721270700128e+00), big(1.6487212707001282e+00))
@test exp(Interval(0.1)) ==
    Interval(big(1.1051709180756475e+00), big(1.1051709180756477e+00))
@test diam(exp(Interval(0.1))) == eps(exp(0.1))
@test log(Interval(1//2)) ==
    Interval(big(-6.931471805599454e-01), big(-6.9314718055994529e-01))
@test log(Interval(0.1)) ==
    Interval(big(-2.3025850929940459e+00), big(-2.3025850929940455e+00))
@test diam(log(Interval(0.1))) == eps(log(0.1))
@test log(Interval(-2,5)) == Interval(-Inf,log(5.0))

@test sin(Interval(0.5)) ==
    Interval(big(0.47942553860420295), big(0.47942553860420301))
@test sin(Interval(0.5, 1.67)) ==
    Interval(big(4.7942553860420295e-01), big(1.0))
@test sin(Interval(1.67,3.2)) ==
    Interval(big(-5.8374143427580093e-02), big(9.9508334981018021e-01))
@test sin(Interval(2.1, 5.6)) ==
    Interval(big(-1.0), big(8.6320936664887404e-01))
@test sin(Interval(0.5,8.5)) == Interval(-1.0, 1.0)
@test cos(Interval(0.5)) ==
    Interval(big(0.87758256189037265), big(0.87758256189037276))
@test cos(Interval(0.5,1.67)) ==
    Interval(big(-0.099041036598728246), big(0.87758256189037276))
@test cos(Interval(2.1, 5.6)) ==
    Interval(big(-1.0), big(0.77556587851025016))
@test cos(Interval(0.5,8.5)) == Interval(big(-1.0), big(1.0))
@test cos(Interval(1.67,3.2)) == Interval(big(-1.0), big(-0.099041036598728011))
@test tan(Interval(0.5)) ==
    Interval(big(0.54630248984379048), big(0.5463024898437906))
@test tan(Interval(0.5,1.67)) == Interval(big(-Inf), big(Inf))
@test tan(Interval(1.67, 3.2)) ==
    Interval(big(-10.047182299210307), big(0.058473854459578652))

println("    \033[32;1mSUCCESS\033[0m")
