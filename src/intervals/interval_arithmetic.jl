

## Equalities and neg-equalities
==(a::Interval, b::Interval) = a.lo == b.lo && a.hi == b.hi
!=(a::Interval, b::Interval) = a.lo != b.lo || a.hi != b.hi

## Inclusion/containment functions
# in(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
in(x::Real, a::Interval) = a.lo <= x <= a.hi

# strict inclusion:
#isinside(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
#isinside(x::Real, a::Interval) = a.lo < x < a.hi

⊊(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
⊆(a::Interval, b::Interval) = b.lo ≤ a.lo && a.hi ≤ b.hi



## zero and one functions
zero{T}(a::Interval{T}) = Interval(zero(T))
one{T}(a::Interval{T}) = Interval(one(T))


## Addition

+{T}(a::Interval{T}, b::Interval{T}) = @round(T, a.lo + b.lo, a.hi + b.hi)
+(a::Interval) = a

## Subtraction

-{T}(a::Interval{T}) = @round(T, -a.hi, -a.lo)
-(a::Interval, b::Interval) = a + (-b) # @round(a.lo - b.hi, a.hi - b.lo)

## Multiplication

*{T}(a::Interval{T}, b::Interval{T}) = @round(T,
                                     min( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi ),
                                     max( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi )
                                     )

## Division
function inv{T}(a::Interval{T})
    if a.lo < zero(T) < a.hi  # strict inclusion
        return Interval(-inf(T), inf(T))  # inf(z) returns inf of type of z
    end

    @round(T, inv(a.hi), inv(a.lo))
end

/(a::Interval, b::Interval) = a * inv(b)
//(a::Interval, b::Interval) = a / b    # to deal with rationals



## Some scalar functions on intervals; no direct rounding used
diam(a::Interval) = a.hi - a.lo
mid(a::Interval) = one(a.lo) / 2 * (a.hi + a.lo)
mag(a::Interval) = max( abs(a.lo), abs(a.hi) )
mig(a::Interval) = zero(a.lo) in a ? zero(a.lo) : min( abs(a.lo), abs(a.hi) )


## Functions needed for generic linear algebra routines to work
<(a::Interval, b::Interval) = a.hi < b.lo
real(a::Interval) = a
abs(a::Interval) = Interval(mig(a), mag(a))


# isempty(a::Interval, b::Interval) = a.hi < b.lo || b.hi < a.lo


# this definition of empty_interval is not nice:
const empty_interval = Interval(Inf)  # interval from Inf to Inf
isempty(x::Interval) = x == empty_interval
const ∅ = empty_interval

function intersect{T}(a::Interval{T}, b::Interval{T})
    if a.hi < b.lo || b.hi < a.lo
        # warn("Intersection is empty")
        return empty_interval
    end

    @round(T, max(a.lo, b.lo), min(a.hi, b.hi))

end

hull{T}(a::Interval{T}, b::Interval{T}) = @round(T, min(a.lo, b.lo), max(a.hi, b.hi))
union(a::Interval, b::Interval) = hull(a, b)

