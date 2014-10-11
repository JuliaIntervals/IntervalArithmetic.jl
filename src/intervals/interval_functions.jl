
## Powers
# Integer power of an interval:
function ^{T}(a::Interval{T}, n::Integer)
    n < zero(n) && return reciprocal( a^(-n) )
    n == zero(n) && return one(a)
    n == one(n) && return a
    #
    ## NOTE: square(x) is deprecated in favor of x*x
    if n == 2*one(n)   # this is unnecessary as stands, but  mig(a)*mig(a) is supposed to be more efficient
        return @round(T, mig(a)^2, mag(a)^2)
    end
    #
    ## even power
    if n%2 == 0
        return @round(T, mig(a)^n, mag(a)^n)
    end
    ## odd power

    @round(T, a.lo^n, a.hi^n)
end

^{T}(a::Interval{T}, r::Rational) = (a^(r.num)) ^ (1/r.den)

# Real power of an interval:
function ^{T}(a::Interval{T}, x::Real)
    x == int(x) && return a^(int(x))
    x < zero(x) && return inv( a^(-x) )
    x == 0.5*one(x) && return sqrt(a)
    #
    z = zero(a.hi)
    z > a.hi && error("Undefined operation; Interval is strictly negative and power is not an integer")
    #
    xInterv = convert(Interval{T}, Interval(x))
    diam( xInterv ) >= eps(x) && return a^xInterv
    # xInterv is a thin interval
    domainPow = Interval(z, inf(a.hi))
    aRestricted = intersect(a, domainPow)
    @round(T, aRestricted.lo^x, aRestricted.hi^x)

end

# Interval power of an interval:
function ^{T}(a::Interval{T}, x::Interval)
    # Is x a thin interval?
    diam(x) < eps( mid(x) ) && return a^(x.lo)
    z = zero(T)
    z > a.hi && error("Undefined operation;\n",
                      "Interval is strictly negative and power is not an integer")
    #
    domainPow = Interval(z, inf(a.hi))
    aRestricted = intersect(a, domainPow)

    @round(T,
           begin
               lolo = aRestricted.lo^(x.lo)
               lohi = aRestricted.lo^(x.hi)
               min( lolo, lohi )
           end,
           begin
               hilo = aRestricted.hi^(x.lo)
               hihi = aRestricted.hi^(x.hi)
               max( hilo, hihi)
           end
           )
end

## sqrt

inf(x::Rational) = 1//0  # to allow sqrt()

function sqrt{T}(a::Interval{T})
    z = zero(T)
    z > a.hi && error("Undefined operation;\n",
                      "Interval is strictly negative and power is not an integer")
    #
    domainSqrt = Interval(z, inf(a.hi))
    aRestricted = intersect(a, domainSqrt)

    @round(T, sqrt(aRestricted.lo), sqrt(aRestricted.hi))

end

## exp
exp{T}(a::Interval{T}) = @round(T, exp(a.lo), exp(a.hi))

## log
function log{T}(a::Interval{T})
    z = zero(T)
    domainLog = Interval(z, inf(a.hi))
    z > a.hi && error("Undefined log; Interval is strictly negative")
    aRestricted = intersect(a, domainLog)

    @round(T, log(aRestricted.lo), log(aRestricted.hi))
end
