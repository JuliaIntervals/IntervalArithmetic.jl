

## Equalities and neg-equalities
==(a::Interval, b::Interval) = a.lo == b.lo && a.hi == b.hi
!=(a::Interval, b::Interval) = a.lo != b.lo || a.hi != b.hi

## Inclusion/containment functions
# in(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
in(x::Real, a::Interval) = a.lo <= x <= a.hi

# strict inclusion:
isinside(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
isinside(x::Real, a::Interval) = a.lo < x < a.hi

⊊(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
⊆(a::Interval, b::Interval) = b.lo ≤ a.lo && a.hi ≤ b.hi

## zero and one functions
zero(a::Interval) = Interval(zero(a.lo))
one(a::Interval) = Interval(one(a.lo))


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
    # uno = one(BigFloat)
    # z = zero(BigFloat)
    if isinside(0, a)
        #if z in a
        warn("\nInterval in denominator contains 0.")
        return Interval(-inf(a.lo),inf(a.lo))  # inf(z) returns inf of type of z
    end

    @round(1 / a.hi, 1 / a.lo)
end

inv(a::Interval) = reciprocal(a)
/(a::Interval, b::Interval) = a * reciprocal(b)
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


# this definition of empty_interval is not nice:
const empty_interval = Interval(Inf)  # interval from Inf to Inf
isempty(x::Interval) = x == empty_interval
const ∅ = empty_interval

function intersect(a::Interval, b::Interval)
    if isempty(a,b)
        # warn("Intersection is empty")
        return empty_interval
    end

    @round(max(a.lo, b.lo), min(a.hi, b.hi))

end

hull(a::Interval, b::Interval) = Interval(min(a.lo, b.lo), max(a.hi, b.hi))
union(a::Interval, b::Interval) = hull(a, b)

