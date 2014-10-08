## Automatic differentiation
## Adapted from original version by Nikolay Kryukov

## Represents the jet of a function u at the point a by (u(a), u'(a))

immutable Jet <: Number  # is this really a Number?  Then promotion rules work
    val   # value u(a)
    der   # derative u'(a)
end

import Base.convert, Base.promote_rule

convert(::Type{Jet}, c::Real) = Jet(c)
promote_rule{T <: Real}(::Type{Jet}, ::Type{T}) = Jet

# Constants:
Jet(c::Real) = Jet(c, 0)

# Arithmetic between two Jet
+(x::Jet, y::Jet) = Jet(x.val + y.val, x.der + y.der)
-(x::Jet, y::Jet) = Jet(x.val - y.val, x.der - y.der)
*(x::Jet, y::Jet) = Jet(x.val*y.val, x.val*y.der + y.val*x.der)

function /(x::Jet, y::Jet)
    quotient = x.val / y.val
    der = (x.der - quotient*y.der) / y.val

    Jet(quotient, der)
end


# Arithmetic operations between Jet and intervals/numbers
# This may be able to be replaced by suitable promotion and convert statements

# for op in (:+, :-, :*, :/)
#     @eval begin
#         $op(u::Jet, c::Real) = $op(u, Jet(c))
#         $op(c::Real, u::Jet) = $op(Jet(c), u)
#     end
# end


#promote_rule(::Type{BigFloat}, ::Type{Interval}) = Interval

+(x::Jet) = x
-(x::Jet) = Jet(-x.val, -x.der)


# Elementary functions

sin(x::Jet) = Jet(sin(x.val), x.der*cos(x.val))
cos(x::Jet) = Jet(cos(x.val), -x.der*sin(x.val))

exp(x::Jet) = Jet(exp(x.val), x.der * exp(x.val))
log(x::Jet) = Jet(log(x.val), x.der / x.val)

^(x::Jet, n::Integer) = n==0 ? Jet(0, 0) : Jet( (x.val)^n, n * (x.val)^(n-1) * x.der )
^(x::Jet, r::Rational) = x^(r.num)^(1/r.den)
^(x::Jet, y::Real) = Jet( (x.val)^y, y * (x.val)^(y-1) * x.der )

differentiate(f, a) = f( Jet(a, 1) ).der
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
