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
convert, promote_rule,
BigFloat, string

export
@round_down, @round_up, @round, @interval, @thin_interval, transform,
Interval, diam, mid, mag, mig, hull, isinside

## Change the default precision:
set_bigfloat_precision(53)


## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = float(a) < float(b)


## Macros for directed rounding:

# (Could use "with rounding" to ensure previous rounding mode is correctly reset)

macro round_down(expr)
    quote
        set_rounding(BigFloat, RoundDown)
        $expr
    end
end

macro round_up(expr)
    quote
        set_rounding(BigFloat, RoundUp)
        $expr
    end
end


## Wrap user input for correct rounding:


macro thin_interval(expr)
    quote
        Interval(@round_down($expr), @round_up($expr))
    end
end


transform(a::BigFloat) = ( @thin_interval(a))
transform(a::Number) = :( @thin_interval(BigFloat(string($a))) )

function transform(a::Symbol)

    b = eval(Main, a)   # use module_parent

    if isa(b, MathConst)
        :(@thin_interval(big($a)))
    elseif isa(b, Number)
        :(@thin_interval(BigFloat(string($b))))
    else
        a  # symbols like :+
    end
end

function transform(expr::Expr)
    ex = copy(expr)
    for (i, arg) in enumerate(expr.args)
        # println(i, " ", arg)
        ex.args[i] = transform(arg)
    end
    return ex
end


macro interval(expr1, expr2...)

    expr1 = transform(expr1)

    if isempty(expr2)
        expr2 = expr1
    else
        expr2 = transform(expr2[1])
    end

    return :(hull($expr1, $expr2))
end


macro round(expr1, expr2)
    quote
        Interval(@round_down($expr1), @round_up($expr2))
    end
end


## Interval constructor
immutable Interval <: Number
    lo :: Real
    hi :: Real

    function Interval(a::Real, b::Real)

        if a > b
            a, b = b, a
        end

        #a = @round_down(interpret(a))
        #b = @round_up(interpret(b))

#         try
#             a = @round_down(BigFloat(string(a)))
#         catch
#             a = @round_down(big(a))

#             if !isa(a, BigFloat)   # to catch rationals
#                a = @round_down(BigFloat(a))
#             end
#         end

#         try
#             b = @round_up(BigFloat(string(b)))
#         catch
#             b = @round_up(BigFloat(b))

#            if !isa(b, BigFloat)
#                b = @round_up(BigFloat(b))
#            end
#         end

        new(a, b)
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

# strict inclusion:
isinside(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
isinside(x::Real, a::Interval) = isinside(promote(x,a)...)

## zero and one functions
zero(a::Interval) = Interval(zero(BigFloat))
one(a::Interval) = Interval(one(BigFloat))

## Addition

+(a::Interval, b::Interval) = @round(a.lo + b.lo, a.hi + b.hi)
+(a::Interval) = a

## Subtraction

-(a::Interval) = Interval(-a.hi, -a.lo)
-(a::Interval, b::Interval) = a + (-b) # @round(a.lo - b.hi, a.hi - b.lo)

## Multiplication

*(a::Interval, b::Interval) = @round(min( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi ),
                                        max( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi )
                                        )

## Division
function reciprocal(a::Interval)
    uno = one(BigFloat)
    z = zero(BigFloat)
    if isinside(z,a)
    #if z in a
        warn("\nInterval in denominator contains 0.")
        return Interval(-inf(z),inf(z))  # inf(z) returns inf of type of z
    end

    @round(uno/a.hi, uno/a.lo)
end

inv(a::Interval) = reciprocal(a)
/(a::Interval, b::Interval) = a*reciprocal(b)
//(a::Interval, b::Interval) = a / b    # to deal with rationals



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

    @round(max(a.lo, b.lo), min(a.hi, b.hi))

end

hull(a::Interval, b::Interval) = Interval(min(a.lo, b.lo), max(a.hi, b.hi))
union(a::Interval, b::Interval) = hull(a, b)


# Extending operators that mix Interval and Real
for fn in (:intersect, :hull, :union)
    @eval $(fn)(a::Interval, x::Real) = $(fn)(promote(a,x)...)
    @eval $(fn)(x::Real, a::Interval) = $(fn)(promote(x,a)...)
end

## Powers
# Integer power of an interval:
function ^(a::Interval, n::Integer)
    n < zero(n) && return reciprocal( a^(-n) )
    n == zero(n) && return one(a)
    n == one(n) && return a
    #
    ## NOTE: square(x) is deprecated in favor of x*x
    if n == 2*one(n)   # this is unnecessary as stands, but  mig(a)*mig(a) is supposed to be more efficient
        return @round(mig(a)^2, mag(a)^2)
    end
    #
    ## even power
    if n%2 == 0
        return @round(mig(a)^n, mag(a)^n)
    end
    ## odd power

    @round(a.lo^n, a.hi^n)
end
^(a::Interval, r::Rational) = a^( Interval(r) )

# Real power of an interval:
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
    @round(aRestricted.lo^x, aRestricted.hi^x)

end

# Interval power of an interval:
function ^(a::Interval, x::Interval)
    # Is x a thin interval?
    diam( x ) < eps( mid(x) ) && return a^(x.lo)
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation;\n",
                      "Interval is strictly negative and power is not an integer")
    #
    domainPow = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainPow)

    @round(begin
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
function sqrt(a::Interval)
    z = zero(BigFloat)
    z > a.hi && error("Undefined operation;\n",
                      "Interval is strictly negative and power is not an integer")
    #
    domainSqrt = Interval(z, inf(BigFloat))
    aRestricted = intersect(a, domainSqrt)

    @round(sqrt(aRestricted.lo), sqrt(aRestricted.hi))

end

## exp
exp(a::Interval) = @round(exp(a.lo), exp(a.hi))

## log
function log(a::Interval)
    z = zero(BigFloat)
    domainLog = Interval(z, inf(BigFloat))
    z > a.hi && error("Undefined log; Interval is strictly negative")
    aRestricted = intersect(a, domainLog)

    @round(log(aRestricted.lo), log(aRestricted.hi))
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
    #print(io, string(" [", lo, ", ", hi, "] with ", prec, " bits of precision"))
    #print(io, "[$(a.lo), $(a.hi)]")
    print(io, "[$(a.lo), $(a.hi)] with $prec bits of precision")

end


#end
