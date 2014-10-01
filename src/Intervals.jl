## Intervals.jl
##
## Last modification: 2014.06.09
## Luis Benet and David P. Sanders, UNAM
##
## Julia module for handling Interval arithmetics
##

#module Intervals

import Base: in, zero, one, abs, real, show,
sqrt, exp, log, sin, cos, tan, inv,
union, intersect, isempty,
convert, promote_rule,
BigFloat, string

export
@round_down, @round_up, @round, @interval, @thin_interval, transform,
Interval, diam, mid, mag, mig, hull, isinside

## Change the default precision:


## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = big(a) < big(b)




## Interval constructor
immutable Interval <: Real
    lo :: Real
    hi :: Real

    function Interval(a::Real, b::Real)

        if a > b
            a, b = b, a
        end

        new(a, b)
    end
end

Interval(a::Interval) = a
Interval(a::Tuple) = Interval(a...)
Interval(a::Real) = Interval(a, a)

# Convertion and promotion

convert(::Type{Interval}, x::Real) = Interval(x)
promote_rule{A<:Real}(::Type{Interval}, ::Type{A}) = Interval
promote_rule(::Type{BigFloat}, ::Type{Interval}) = Interval

## Equalities and neg-equalities
==(a::Interval, b::Interval) = a.lo == b.lo && a.hi == b.hi
!=(a::Interval, b::Interval) = a.lo != b.lo || a.hi != b.hi

## Inclusion/containment functions
in(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
in(x::Real, a::Interval) = a.lo <= x <= a.hi

# strict inclusion:
isinside(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
isinside(x::Real, a::Interval) = isinside(promote(x,a)...)

## zero and one functions
zero(a::Interval) = Interval(big(0.0))
one(a::Interval) = Interval(big(1.0))


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
mig(a::Interval) = 0 in a ? big(0.0) : min( abs(a.lo), abs(a.hi) )


## Functions needed for generic linear algebra routines to work
<(a::Interval, b::Interval) = a.hi < b.lo
real(a::Interval) = a
abs(a::Interval) = Interval(mig(a), mag(a))


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



## Output
function show(io::IO, a::Interval)
    lo = a.lo
    hi = a.hi

    print(io, "[$(a.lo), $(a.hi)]")

    if typeof(a.lo) == typeof(a.hi) == BigFloat
        prec = a.lo.prec
        print(io, " with $prec bits of precision")
    end

end


# end    # this end is required if Intervals.jl is a module on its own
