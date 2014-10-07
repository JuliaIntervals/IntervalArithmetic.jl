## Automatic differentiation
## Adapted from original version by Nikolay Kryukov

## Represents the jet of a function u at the point a by (u(a), u'(a))

type Ad
    u
    up
end

# Constants:
Ad(c) = Ad(c, 0)

# Arithmetic between two Ad
+(x::Ad, y::Ad) = Ad(x.u + y.u, x.up + y.up)
-(x::Ad, y::Ad) = Ad(x.u - y.u, x.up - y.up)
*(x::Ad, y::Ad) = Ad(x.u*y.u, x.u*y.up + y.u*x.up)

function /(x::Ad, y::Ad)
    quotient = x.u / y.u
    deriv = (x.up - quotient*y.up) / y.u

    Ad(quotient, deriv)
end


# Arithmetic operations between Ad and intervals/numbers
# This may be able to be replaced by suitable promotion and convert statements

for op in (:+, :-, :*, :/)
    @eval begin
        $op(u::Ad, c::Real) = $op(u, Ad(c))
        $op(c::Real, u::Ad) = $op(Ad(c), u)
    end
end

+(x::Ad) = x
-(x::Ad) = Ad(-x.u, -x.up)


# Elementary functions

sin(x::Ad) = Ad(sin(x.u), x.up*cos(x.u))
cos(x::Ad) = Ad(cos(x.u), -x.up*sin(x.u))

exp(x::Ad) = Ad(exp(x.u), x.up * exp(x.u))
log(x::Ad) = Ad(log(x.u), x.up / x.u)

^(x::Ad, n::Integer) = n==0 ? Ad(0, 0) : Ad( (x.u)^n, y * (x.u)^(n-1) * x.up )
^(x::Ad, y::Real) = Ad( (x.u)^y, y * (x.u)^(y-1) * x.up )

differentiate(f, a) = f(Ad(a, 1.)).up

function jacobian(f, a)

	f1(x) = f(x)[1]
	f2(x) = f(x)[2]

	f11(x1) = f1([x1, a[2]])
	J11 = differentiate(f11, a[1])

	f12(x2) = f1([a[1], x2])
	J12 = differentiate(f12, a[2])

	f21(x1) = f2([x1, a[2]])
	J21 = differentiate(f21, a[1])

	f22(x2) = f2([a[1], x2])
	J22 = differentiate(f22, a[2])

	[J11 J12; J21 J22]

end
