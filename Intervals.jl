## Intervals.jl
##
## Last modification: 2014.04.10
## Luis Benet and David P. Sanders, UNAM
##
## Julia module for handling Interval arithmetics
##

module Intervals

import 
    Base: in, zero, one, show, 
        sqrt, exp, log, sin, cos, tan, 
        union, intersect, isempty

export 
    @roundingDown, @roundingUp, @roundingDirect, @rounded_interval,
    Interval, isinside, diam, mid, mag, mig, hull

## Changing the default precision
set_bigfloat_precision(53)

## Some macros for rounding
macro roundingDown(expr)
    quote
        set_rounding(BigFloat, RoundDown)
        c = $expr
        set_rounding(BigFloat, RoundNearest)
        c
    end
end

macro roundingUp(expr)
    quote
        set_rounding(BigFloat, RoundUp)
        c = $expr
        set_rounding(BigFloat, RoundNearest)
        c
    end
end

## Interval constructor
immutable Interval <: Real
    lo :: Real
    hi :: Real

    ## Inner constructor
    function Interval(a, b)
        if a > b
            a, b = b, a
        end

        # Directed rounding: We avoid rounding a BigFloat, since BigFloats 
        # are already rounded
        T = typeof(a)
        if T == BigFloat
            lo = a
        elseif T == Rational{Int64} || T == Rational{BigInt} || T == Rational{Int32}
            lo = @roundingDown( BigFloat(a) )
        else
            #lo = BigFloat(string(a), RoundDown)
            lo = @roundingDown( BigFloat(string(a)) )
        end

        T = typeof(b)
        if T == BigFloat
            hi = b
        elseif T == Rational{Int64} || T == Rational{BigInt} || T == Rational{Int32}
            hi = @roundingUp( BigFloat(b) )
        else
            #hi = BigFloat(string(b), RoundUp)
            hi = @roundingUp( BigFloat(string(b)) )
        end

        new(lo, hi)
    end
end
Interval(a::Interval) = a
Interval(a::Tuple) = Interval(a[1], a[2])
#?Interval(a::BigFloat) = Interval( @roundingDown("$a"), @roundingUp("$a") )
Interval(b::Bool) = Interval(int(b))   ## Included because a warning: Bool <: Real --> true
Interval(a::Real) = Interval(a, a)

## Equalities and neg-equalities
==(a::Interval, b::Interval) = a.lo == b.lo && a.hi == b.hi
==(a::Interval, x::Real) = ==(a, Interval(x))
==(x::Real, a::Interval) = ==(a, Interval(x))
!=(a::Interval, b::Interval) = a.lo != b.lo || a.hi != b.hi
!=(a::Interval, x::Real) = !=(a, Interval(x))
!=(x::Real, a::Interval) = !=(a, Interval(x))

## Inclusion/containment functions
in(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
in(x::Rational, a::Interval) = a.lo <= BigFloat(x) <= a.hi
in(x::BigFloat, a::Interval) = a.lo <= x <= a.hi
in(x::Real, a::Interval) = a.lo <= BigFloat(string(x)) <= a.hi
isinside(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
isinside(x::Rational, a::Interval) = a.lo < BigFloat(x) < a.hi
isinside(x::BigFloat, a::Interval) = a.lo < x < a.hi
isinside(x::Real, a::Interval) = a.lo < BigFloat(string(x)) < a.hi

## zero and one functions
zero(a::Interval) = Interval(BigFloat("0"))
one(a::Interval) = Interval(BigFloat("1"))

## Addition
function +(a::Interval, b::Interval)
    set_rounding(BigFloat, RoundDown)
    lo = a.lo+b.lo
    set_rounding(BigFloat, RoundDown)
    hi = a.hi+b.hi
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end
#?+(a::Interval, b::Interval) = @rounded_interval( a.lo+b.lo, a.hi+b.hi )
+(a::Interval) = a

## Substraction
function -(a::Interval, b::Interval)
    set_rounding(BigFloat, RoundDown)
    lo = a.lo-b.hi
    set_rounding(BigFloat, RoundDown)
    hi = a.hi-b.lo
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end
#?-(a::Interval, b::Interval) = @rounded_interval( a.lo-b.hi, a.hi-b.lo )
-(a::Interval) = Interval(-a.hi,-a.lo)

## Multiplication
function *(a::Interval, b::Interval)
    set_rounding(BigFloat, RoundDown)    
    lo = min( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi )
    set_rounding(BigFloat, RoundUp)
    hi = max( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi )
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end
# The following is needed because to avoid a silly warning
*(a::Interval, b::Bool) = b ? a : zero(a)
*(b::Bool, a::Interval) = b ? a : zero(a)

## Operations mixing Interval and Real
for op in (:+, :-, :*)
    @eval $(op)(a::Interval, x::Real) = $(op)(a, Interval(x))
    @eval $(op)(x::Real, a::Interval) = $(op)(Interval(x), a)
end

## Division
function reciprocal(a::Interval)
    uno = one(BigFloat)
    z = zero(BigFloat)
    if isinside(z,a)
        warn("\nInterval in denominator contains 0.")
        return Interval(-Inf,Inf)
    end
    set_rounding(BigFloat, RoundDown)    
    lo = uno/a.hi
    set_rounding(BigFloat, RoundUp)
    hi = uno/a.lo
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end
/(a::Interval, b::Interval) = a*reciprocal(b)
/(a::Interval, x::Real) = a*reciprocal( Interval(x) )
/(x::Real, a::Interval) = Interval(x)*reciprocal(a)

## Some scalar functions on intervals
diam(a::Interval) = a.hi - a.lo
mid(a::Interval) = BigFloat(0.5) * (a.hi + a.lo)
mag(a::Interval) = max( abs(a.lo), abs(a.hi) )
mig(a::Interval) = in(BigFloat(0.0),a) ? BigFloat(0.0) : min( abs(a.lo), abs(a.hi) )

## Intersection
isempty(a::Interval, b::Interval) = a.hi < b.lo || b.hi < a.lo
#?isempty(a::Interval, x::Real) = isempty(a, Interval(x))
function intersect(a::Interval, b::Interval)
    if isempty(a,b)
        warn("Intersection is empty")
        return nothing
    end
    z = zero(BigFloat)
    set_rounding(BigFloat, RoundDown)    
    lo = max(a.lo, b.lo)
    set_rounding(BigFloat, RoundUp)
    hi = min(a.hi, b.hi)
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end

## hull
function hull(a::Interval, b::Interval)
    z = zero(BigFloat)
    set_rounding(BigFloat, RoundDown)    
    lo = min(a.lo, b.lo)
    set_rounding(BigFloat, RoundUp)
    hi = max(a.hi, b.hi)
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end
hull(a::Interval, x::Real) = hull(a, Interval(x))
hull(x::Real, a::Interval) = hull(a, Interval(x))

## union
function union(a::Interval, b::Interval)
    isempty(a,b) && warn("Empty intersection; union is computed as hull")
    hull(a,b)
end
union(a::Interval, x::Real) = union(a, Interval(x))
union(x::Real, a::Interval) = union(Interval(x), a)

#----- From here on, NEEDS TESTING ------
## Int power
function ^(a::Interval, n::Integer)
    n < zero(n) && return reciprocal( a^(-n) )
    n == zero(n) && return one(a)
    n == one(n) && return a
    #
    ## NOTE: square(x) is deprecated in favor of x*x
    if n == 2*one(n)
        xmi = mig(a)
        xma = mag(a)
        set_rounding(BigFloat, RoundDown)
        lo = xmi * xmi
        set_rounding(BigFloat, RoundUp)
        hi = xma * xma
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    end
    #    
    ## even power
    if n%2 == 0
        set_rounding(BigFloat, RoundDown)
        lo = ( mig(a) )^n
        set_rounding(BigFloat, RoundUp)
        hi = ( mag(a) )^n
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    end
    ## odd power
    set_rounding(BigFloat, RoundDown)
    lo = a.lo^n
    set_rounding(BigFloat, RoundUp)
    hi = a.hi^n
    set_rounding(BigFloat, RoundNearest)
    return Interval( lo, hi )
end
^(a::Interval, r::Rational) = a^( Interval(r) )
function ^(a::Interval, x::Real)
    x == int(x) && return a^(int(x))
    x < zero(x) && return reciprocal( a^(-x) )
    x == 0.5*one(x) && return sqrt(a)
    #
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation; Interval is strictly negative and power is not an integer")
    #
    xInterv = Interval( x )
    diam( xInterv ) >= eps(x) && return a^xInterv
    # xInterv is a thin interval
    domainPow = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainPow)
    set_rounding(BigFloat, RoundDown)
    lo = aRestricted.lo^x
    set_rounding(BigFloat, RoundUp)
    hi = aRestricted.hi^x
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end
function ^(a::Interval, x::Interval)
    # Is x a thin interval?
    diam( x ) < eps( mid(x) ) && return a^(x.lo)
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation; Interval is strictly negative and power is not an integer")
    #
    domainPow = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainPow)
    set_rounding(BigFloat, RoundDown)
    lolo = aRestricted.lo^x.lo
    lohi = aRestricted.lo^x.hi
    set_rounding(BigFloat, RoundUp)
    hilo = aRestricted.hi^x.lo
    hihi = aRestricted.hi^x.hi
    set_rounding(BigFloat, RoundNearest)
    lo = min( lolo, lohi)
    hi = min( hilo, hihi)
    Interval( lo, hi )
end

## sqrt
function sqrt(a::Interval)
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation; Interval is strictly negative and power is not an integer")
    #
    domainSqrt = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainSqrt)
    set_rounding(BigFloat, RoundDown)
    lo = sqrt( aRestricted.lo )
    set_rounding(BigFloat, RoundUp)
    hi = sqrt( aRestricted.hi )
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end

## exp
function exp(a::Interval)
    set_rounding(BigFloat, RoundDown)    
    lo = exp( a.lo )
    set_rounding(BigFloat, RoundUp)
    hi = exp( a.hi )
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end

## log
function log(a::Interval)
    z = zero(BigFloat)
    domainLog = Interval(z, inf(BigFloat))
    z > a.hi && error("Undefined log; Interval is strictly negative")
    aRestricted = intersect(a, domainLog)
    #
    set_rounding(BigFloat, RoundDown)
    lo = log( aRestricted.lo )
    set_rounding(BigFloat, RoundUp)
    hi = log( aRestricted.hi )
    set_rounding(BigFloat, RoundNearest)
    Interval( lo, hi )
end

## sin
function sin(a::Interval)
    piHalf = pi*BigFloat("0.5")
    twoPi = pi*BigFloat("2.0")
    domainSin = Interval( BigFloat(-1.0), BigFloat(1.0) )

    # Checking the specific case
    diam(a) >= twoPi && return domainSin

    # Limits within 1 full period of sin(x)
    # Abbreviations
    loMod2pi = mod(a.lo, twoPi)
    hiMod2pi = mod(a.hi, twoPi)
    loQuartile = floor( loMod2pi / piHalf )
    hiQuartile = floor( hiMod2pi / piHalf )
    
    # 20 different cases
    if loQuartile == hiQuartile # Interval limits in the same quartile 
        loMod2pi > hiMod2pi && return domainSin
        set_rounding(BigFloat, RoundDown)
        lo = sin( a.lo )
        set_rounding(BigFloat, RoundUp)
        hi = sin( a.hi )
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    elseif loQuartile == 3 && hiQuartile==0
        set_rounding(BigFloat, RoundDown)
        lo = sin( a.lo )
        set_rounding(BigFloat, RoundUp)
        hi = sin( a.hi )
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    elseif loQuartile == 1 && hiQuartile==2
        set_rounding(BigFloat, RoundDown)
        lo = sin( a.hi )
        set_rounding(BigFloat, RoundUp)
        hi = sin( a.lo )
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    elseif ( loQuartile == 0 || loQuartile==3 ) && ( hiQuartile==1 || hiQuartile==2 )
        set_rounding(BigFloat, RoundDown)
        slo = sin( a.lo )
        shi = sin( a.hi )
        set_rounding(BigFloat, RoundNearest)
        lo = min( slo, shi )
        return Interval( lo, BigFloat(1.0) )
    elseif ( loQuartile == 1 || loQuartile==2 ) && ( hiQuartile==3 || hiQuartile==0 )
        set_rounding(BigFloat, RoundUp)
        slo = sin( a.lo )
        shi = sin( a.hi )
        set_rounding(BigFloat, RoundNearest)
        hi = max( slo, shi )
        return Interval( BigFloat(-1.0), hi )
    elseif ( loQuartile == 0 && hiQuartile==3 ) || ( loQuartile == 2 && hiQuartile==1 )
        return domainSin
    else
        # This should be never reached!
        error(string("SOMETHING WENT WRONG in sin.\nThis should have never been reached") )
    end
end

## cos
function cos(a::Interval)
    piHalf = pi*BigFloat("0.5")
    twoPi = pi*BigFloat("2.0")
    domainCos = Interval( BigFloat(-1.0), BigFloat(1.0) )

    # Checking the specific case
    diam(a) >= twoPi && return domainCos

    # Limits within 1 full period of sin(x)
    # Abbreviations
    loMod2pi = mod(a.lo, twoPi)
    hiMod2pi = mod(a.hi, twoPi)
    loQuartile = floor( loMod2pi / piHalf )
    hiQuartile = floor( hiMod2pi / piHalf )
    
    # 20 different cases
    if loQuartile == hiQuartile # Interval limits in the same quartile 
        loMod2pi > hiMod2pi && return domainCos
        set_rounding(BigFloat, RoundDown)
        lo = cos( a.hi )
        set_rounding(BigFloat, RoundUp)
        hi = cos( a.lo )
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    elseif loQuartile == 2 && hiQuartile==3
        set_rounding(BigFloat, RoundDown)
        lo = cos( a.lo )
        set_rounding(BigFloat, RoundUp)
        hi = cos( a.hi )
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    elseif loQuartile == 0 && hiQuartile==1
        set_rounding(BigFloat, RoundDown)
        lo = cos( a.hi )
        set_rounding(BigFloat, RoundUp)
        hi = cos( a.lo )
        set_rounding(BigFloat, RoundNearest)
        return Interval( lo, hi )
    elseif ( loQuartile == 2 || loQuartile==3 ) && ( hiQuartile==0 || hiQuartile==1 )
        set_rounding(BigFloat, RoundDown)
        clo = cos( a.lo )
        chi = cos( a.hi )
        set_rounding(BigFloat, RoundNearest)
        lo = min( clo, chi )
        return Interval( lo, BigFloat(1.0) )
    elseif ( loQuartile == 0 || loQuartile==1 ) && ( hiQuartile==2 || hiQuartile==3 )
        set_rounding(BigFloat, RoundUp)
        clo = cos( a.lo )
        chi = cos( a.hi )
        set_rounding(BigFloat, RoundNearest)
        hi = max( clo, chi )
        return Interval( BigFloat(-1.0), hi )
    elseif ( loQuartile == 3 && hiQuartile==2 ) || ( loQuartile == 1 && hiQuartile==0 )
        return domainCos
    else
        # This should be never reached!
        error(string("SOMETHING WENT WRONG in cos.\nThis should have never been reached") )
    end
end

## tan
function tan(a::Interval)
    bigPi = pi*BigFloat("1.0")
    piHalf = pi*BigFloat("0.5")
    domainTan = Interval( BigFloat(-Inf), BigFloat(Inf) )

    # Checking the specific case
    diam(a) >= bigPi && return domainTan

    # within 1 full period of tan(x) --> 4 cases
    # some abreviations
    loModpi = mod(a.lo, bigPi)
    hiModpi = mod(a.hi, bigPi)
    loHalf = floor( loModpi / piHalf )
    hiHalf = floor( hiModpi / piHalf )
    set_rounding(BigFloat, RoundDown)
    lo = tan( a.lo )
    set_rounding(BigFloat, RoundUp)
    hi = tan( a.hi )
    set_rounding(BigFloat, RoundNearest)
    
    if (loHalf > hiHalf) || ( loHalf == hiHalf && lo_modpi < hi_modpi) 
        return Interval( lo, hi )
    end

    disjoint2 = Interval( tan_xlo, BigFloat(Inf) )
    disjoint1 = Interval( BigFloat(-Inf), tan_xhi )
    info(string("\n The resulting interval is disjoint:\n", disjoint1, disjoint2,
        "\n The hull of the disjoint subintervals is considered:\n", domainTan))
    return domainTan
end


## Output
function show(io::IO, a::Interval)
    lo = a.lo
    hi = a.hi
    prec = a.lo.prec
    print(io, string(" [", lo, ", ", hi, "] with ", prec, " bits of precision"))
end


end