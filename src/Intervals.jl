## Intervals.jl
##
## Last modification: 2014.06.09
## Luis Benet and David P. Sanders, UNAM
##
## Julia module for handling Interval arithmetics
##

#module Intervals

import Base: in, zero, one, show,
sqrt, exp, log, sin, cos, tan, inv,
union, intersect, isempty,
convert, promote_rule

export
# @round_down, @round_up, @directed_rounding,
Interval, isinside, diam, mid, mag, mig, hull

## Changing the default precision
set_bigfloat_precision(53)

## Macros for directed rounding:
macro round_down(expr)
    quote
        set_rounding(BigFloat, RoundDown)
        $expr
        # set_rounding(BigFloat, RoundNearest)
    end
end

macro round_up(expr)
    quote
        set_rounding(BigFloat, RoundUp)
        $expr
        # set_rounding(BigFloat, RoundNearest)
    end
end


macro interval(expr1, expr2)
    quote
        Interval(@round_down($expr1), @round_up($expr2))
    end
end



## Interval constructor
immutable Interval <: Number
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
            lo = @round_down( BigFloat(a) )
        else
            lo = @round_down( BigFloat(string(a)) )
        end

        T = typeof(b)
        if T == BigFloat
            hi = b
        elseif T == Rational{Int64} || T == Rational{BigInt} || T == Rational{Int32}
            hi = @round_up( BigFloat(b) )
        else
            hi = @round_up( BigFloat(string(b)) )
        end

        new(lo, hi)
    end
end
Interval(a::Interval) = a
Interval(a::Tuple) = Interval(a...)
Interval(a::Real) = Interval(a, a)

# Convertion and promotion
convert(::Type{Interval},x::Real) = Interval(x)
promote_rule{A<:Real}(::Type{Interval}, ::Type{A}) = Interval

## Equalities and neg-equalities
==(a::Interval, b::Interval) = a.lo == b.lo && a.hi == b.hi
!=(a::Interval, b::Interval) = a.lo != b.lo || a.hi != b.hi

## Inclusion/containment functions
in(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
in(x::Real, a::Interval) = in(promote(x,a)...)

isinside(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
isinside(x::Real, a::Interval) = isinside(promote(x,a)...)

## zero and one functions
zero(a::Interval) = Interval(zero(BigFloat))
one(a::Interval) = Interval(one(BigFloat))

## Addition

+(a::Interval, b::Interval) = @interval(a.lo + b.lo, a.hi + b.hi)
+(a::Interval) = a

## Subtraction

-(a::Interval) = Interval(-a.hi, -a.lo)
-(a::Interval, b::Interval) = a + (-b) # @interval(a.lo - b.hi, a.hi - b.lo)

## Multiplication

*(a::Interval, b::Interval) = @interval(min( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi ),
                                        max( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi )
                                        )

## Division
function reciprocal(a::Interval)
    uno = one(BigFloat)
    z = zero(BigFloat)
    if isinside(z,a)
        warn("\nInterval in denominator contains 0.")
        return Interval(-inf(z),inf(z))  # inf(z) returns inf of type of z
    end

    @interval(uno/a.hi, uno/a.lo)
end

inv(a::Interval) = reciprocal(a)
/(a::Interval, b::Interval) = a*reciprocal(b)

## Some scalar functions on intervals; no direct rounding used
diam(a::Interval) = a.hi - a.lo
mid(a::Interval) = one(a.lo) / 2 * (a.hi + a.lo)
mag(a::Interval) = max( abs(a.lo), abs(a.hi) )
mig(a::Interval) = in(zero(BigFloat),a) ? zero(BigFloat) : min( abs(a.lo), abs(a.hi) )


isempty(a::Interval, b::Interval) = a.hi < b.lo || b.hi < a.lo

function intersect(a::Interval, b::Interval)
    if isempty(a,b)
        # warn("Intersection is empty")
        return nothing
    end

    @interval(max(a.lo, b.lo), min(a.hi, b.hi))

end

hull(a::Interval, b::Interval) = @interval(min(a.lo, b.lo), max(a.hi, b.hi))
union(a::Interval, b::Interval) = hull(a, b)


# Extending operators that mix Interval and Real
for fn in (:intersect, :hull, :union)
    @eval $(fn)(a::Interval, x::Real) = $(fn)(promote(a,x)...)
    @eval $(fn)(x::Real, a::Interval) = $(fn)(promote(x,a)...)
end

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

        return @interval(xmi * xmi, xma * xma)
    end
    #
    ## even power
    if n%2 == 0
        return @interval(mig(a)^n, mag(a)^n)
    end
    ## odd power

    @interval(a.lo^n, a.hi^n)
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
    @interval(aRestricted.lo^x, aRestricted.hi^x)

end
function ^(a::Interval, x::Interval)
    # Is x a thin interval?
    diam( x ) < eps( mid(x) ) && return a^(x.lo)
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation;\n",
                      "Interval is strictly negative and power is not an integer")
    #
    domainPow = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainPow)

    @interval(begin
                  lolo = aRestricted.lo^(x.lo)
                  lohi = aRestricted.lo^(x.hi)
                  min( lolo, lohi )
              end,
              begin
                  hilo = aRestricted.hi^(x.lo)
                  hihi = aRestricted.hi^(x.hi)
              end
              )
end

## sqrt
function sqrt(a::Interval)
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation;\n",
                      "Interval is strictly negative and power is not an integer")
    #
    domainSqrt = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainSqrt)

    @interval(sqrt(aRestricted.lo), sqrt(aRestricted.hi))

end

## exp
exp(a::Interval) = @interval(exp(a.lo), exp(a.hi))

## log
function log(a::Interval)
    z = zero(BigFloat)
    domainLog = Interval(z, inf(BigFloat))
    z > a.hi && error("Undefined log; Interval is strictly negative")
    aRestricted = intersect(a, domainLog)

    @interval(log(aRestricted.lo), log(aRestricted.hi))
end

#----- From here on, NEEDS TESTING ------
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

    if (loHalf > hiHalf) || ( loHalf == hiHalf && loModpi <= hiModpi)
        return Interval( lo, hi )
    end

    disjoint2 = Interval( lo, BigFloat(Inf) )
    disjoint1 = Interval( BigFloat(-Inf), hi )
    info(string("The resulting interval is disjoint:\n", disjoint1, "\n", disjoint2,
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


#end
