
@test @interval(0.1) == @interval(0.0999999999999999999,0.1)
@test a+b == @interval(0.9999999999999999,3.1)
@test -a == @interval(-1.1,-0.0999999999999999999)
@test a-b == @interval(big(-1.9000000000000001e+00), big(2.0000000000000018e-01))

@test 10a == @interval(big(9.9999999999999989e-01), big(1.1000000000000002e+01))
@test b/a == @interval(big(8.181818181818179e-01), big(2.0000000000000004e+01))
@test a/c == @interval(big(0.024999999999999998), big(4.4))
@test c/4.0 == @interval(0.0625,1.0)

@test @interval(-3,2)^2 == @interval(0,9)
@test @interval(-3,2)^3 == @interval(-27,8)
@test @interval(-3,4)^0.5 == @interval(0,2) == @interval(-3,4)^(1//2)
@test @interval(1,27)^@interval(1//3) == @interval(1, big(3.0000000000000004e+00))  #@interval(1,3)
@test @interval(-3,2)^@interval(2) == @interval(0,9)
@test @interval(-3,4)^@interval(0.5) == @interval(0,2)
@test @interval(0.1,0.7)^(1/3) == @interval(big(4.6415888336127786e-01), big(8.8790400174260087e-01


@test exp(@interval(1//2)) == @interval(big(1.648721270700128e+00), big(1.6487212707001282e+00))
@test exp(@interval(0.1)) == @interval(big(1.1051709180756475e+00), big(1.1051709180756477e+00))
@test diam(exp(@interval(0.1))) == eps(exp(0.1))
@test log(@interval(1//2)) == @interval(big(-6.931471805599454e-01), big(-6.9314718055994529e-01))
@test log(@interval(0.1)) == @interval(big(-2.3025850929940459e+00), big(-2.3025850929940455e+00))
@test diam(log(@interval(0.1))) == eps(log(0.1))
