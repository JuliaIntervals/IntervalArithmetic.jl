using ValidatedNumerics
using Base.Test

set_bigfloat_precision(53)

a = @interval(1.1, 0.1)
b = @interval(0.9, 2.0)
c = @interval(0.25, 4.0)


@test isa( @interval(1,2), Interval )
@test isa( @interval(0.1), Interval )
@test isa( zero(b), Interval )

@test zero(b) == 0.0
@test one(a) == 1.0
@test one(a) == big(1.0)
@test !(a == b)
@test a != b
@test 1 == zero(a)+one(b)

@test @interval(0.25) - one(c)/4 == zero(c)
#@test isempty(a, @interval(-1))
@test a == Interval(a.lo, a.hi)
@test a == @interval(a.lo, a.hi)

# The following is no longer true!
#@test a*b == Interval(a.lo*b.lo, a.hi*b.hi)
@test a*b == @interval(a.lo*b.lo, a.hi*b.hi)


@test inv( zero(a) ) == @interval(Inf,Inf)
@test inv( @interval(0, 1) ) == @interval(1, Inf)
@test inv( @interval(1, Inf) ) == @interval(0, 1)
@test inv(c) == c
@test one(a)/b == inv(b)



@test inv(zero(a)) == @interval(Inf,Inf)
@test inv(@interval(0,1)) == @interval(1,Inf)
@test inv(@interval(1,Inf)) == @interval(0,1)
@test inv(c) == c
@test one(a)/b == inv(b)

@test in(0.1,@interval(0.1))
@test !isinside(0.1,@interval(0.1))
@test 0.1 in @interval(0.1)
@test intersect(a,@interval(-1)) == nothing
@test intersect(a,hull(a,b)) == a
@test union(a,b) == @interval(a.lo,b.hi)

@test diam( @interval(1//2) ) == zero(BigFloat)
@test diam( @interval(0.1) ) == eps(0.1)
@test mig(@interval(-2,2)) == BigFloat(0.0)
@test mag(-b) == b.hi
@test diam(a) == a.hi - a.lo

@test log(@interval(-2,5)) == @interval(-Inf,log(5.0))

println
