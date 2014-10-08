## Automatic differentiation
## Jetapted from original version by Nikolay Kryukov

## Represents the jet of a function u at the point a by (u(a), u'(a))

type Jet
    value
    deriv
end

# Constants:
Jet(c) = Jet(c, 0)

# Arithmetic between two Jet
+(x::Jet, y::Jet) = Jet(x.value + y.value, x.deriv + y.deriv)
-(x::Jet, y::Jet) = Jet(x.value - y.value, x.deriv - y.deriv)
*(x::Jet, y::Jet) = Jet(x.value*y.value, x.value*y.deriv + y.value*x.deriv)

function /(x::Jet, y::Jet)
    quotient = x.value / y.value
    deriv = (x.deriv - quotient*y.deriv) / y.value

    Jet(quotient, deriv)
end


# Arithmetic operations between Jet and intervals/numbers
# This may be able to be replaced by suitable promotion and convert statements

for op in (:+, :-, :*, :/)
    @eval begin
        $op(u::Jet, c::Real) = $op(u, Jet(c))
        $op(c::Real, u::Jet) = $op(Jet(c), u)
    end
end

+(x::Jet) = x
-(x::Jet) = Jet(-x.value, -x.deriv)


# Elementary functions

sin(x::Jet) = Jet(sin(x.value), x.deriv*cos(x.value))
cos(x::Jet) = Jet(cos(x.value), -x.deriv*sin(x.value))

exp(x::Jet) = Jet(exp(x.value), x.deriv * exp(x.value))
log(x::Jet) = Jet(log(x.value), x.deriv / x.value)

^(x::Jet, n::Integer) = n==0 ? Jet(0, 0) : Jet( (x.value)^n, n * (x.value)^(n-1) * x.deriv )
^(x::Jet, y::Real) = Jet( (x.value)^y, y * (x.value)^(y-1) * x.deriv )

differentiate(f, a) = f(Jet(a, 1.)).deriv
const D = differentiate

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
