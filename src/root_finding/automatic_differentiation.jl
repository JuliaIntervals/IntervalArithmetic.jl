#module AutomaticDifferentiation


## Automatic differentiation


#using ValidatedNumerics


# module AutomaticDifferentiation
#export Ad, differentiate, jacobian


type Ad
    u
    up
end

#Ad(c) = Ad(c, Interval(0))
Ad(c) = Ad(c, 0)

# Arithmetic between two Ad
+(x::Ad, y::Ad) = Ad(x.u + y.u, x.up + y.up)
-(x::Ad, y::Ad) = Ad(x.u - y.u, x.up - y.up)
*(x::Ad, y::Ad) = Ad(x.u*y.u, x.u*y.up + y.u*x.up)
function /(x::Ad, y::Ad)
    ff = x.u/y.u
    dd = (x.up - ff*y.up)/y.u
    Ad(ff, dd)
end

# Power; two functions for power because it is less costly
#= Commented out because it gave errors
^(x::Ad, a::Integer)= Ad(x.u^a, a*x.u^(a-1)*x.up)

function ^(x::Ad, a::Real)
    ff = x.u^(a-1)
    Ad(ff*x.u, a*ff*x.up)
end
=#

# Arithmetic operations between Ad and intervals/numbers

for op in (:+, :-, :*, :/)
    @eval begin
        $op(u::Ad, c::Number) = $op(u, Ad(c))
        $op(c::Number, u::Ad) = $op(Ad(c), u)
#        $op(u::Ad, c::Number) = $op(u, Ad(c))
#        $op(c::Real, u::Ad) = $op(Ad(c), u)
    end
end

+(x::Ad) = x
-(x::Ad) = Ad(-x.u, -x.up)

# Elementary functions

import Base.sin
sin(x::Ad) = Ad(sin(x.u), x.up*cos(x.u))

import Base.cos
cos(x::Ad) = Ad(cos(x.u), -x.up*sin(x.u))

e^(x::Ad) = Ad(e^x.u, x.up*e^x.u)

import Base.exp
exp(x::Ad) = Ad(exp(x.u), x.up*exp(x.u))

import Base.log
log(x::Ad) = Ad(log(x.u), x.up/x.u)

#(x::Ad)^y::Interval = Ad(x.u^y, x.up*y*x.u^(y-1))

differentiate(f, a) = f(Ad(a, 1.)).up

# End of module
#end

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
