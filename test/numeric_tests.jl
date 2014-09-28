
using ValidatedNumerics
using Base.Test

set_bigfloat_precision(53)

a = @interval(1.1, 0.1)
b = @interval(0.9, 2.0)
c = @interval(0.25, 4.0)

@test @interval(0.1) == Interval(9.9999999999999992e-02, 1.0000000000000001e-01)
@test a+b == Interval(9.9999999999999989e-01, 3.1000000000000001e+00)
@test -a == Interval(-1.1000000000000001e+00, -9.9999999999999992e-02)
@test a-b == Interval(-1.9000000000000001e+00, 2.0000000000000018e-01)

@test 10a == Interval(9.9999999999999989e-01, 1.1000000000000002e+01)
@test b/a == Interval(8.181818181818179e-01, 2.0000000000000004e+01)
@test a/c == Interval(2.4999999999999998e-02, 4.4000000000000004e+00)
@test c/4.0 == Interval(6.25e-02, 1e+00)

@test @interval(-3,2)^2 == @interval(0,9)
@test @interval(-3,2)^3 == @interval(-27,8)
@test @interval(-3,4)^0.5 == @interval(0,2) == @interval(-3,4)^(1//2)
@test @interval(1,27)^@interval(1/3) == Interval(1, 3.0000000000000004e+00)  # @interval(1, 3)
@test @interval(-3,2)^@interval(2) == Interval(0, 9)
@test @interval(-3,4)^@interval(0.5) == Interval(0, 2)
@test @interval(0.1, 0.7)^(1/3) == Interval(4.6415888336127786e-01, 8.8790400174260076e-01)


@test exp( @interval(1//2) ) == Interval(1.648721270700128e+00, 1.6487212707001282e+00)
@test exp(@interval(0.1)) == Interval(1.1051709180756475e+00, 1.1051709180756477e+00)
@test diam(exp(@interval(0.1))) == eps(exp(0.1))
@test log(@interval(1//2)) == Interval(-6.931471805599454e-01, -6.9314718055994529e-01)
@test log(@interval(0.1)) == Interval(-2.3025850929940459e+00, -2.3025850929940455e+00)
@test diam(log(@interval(0.1))) == eps(log(0.1))
