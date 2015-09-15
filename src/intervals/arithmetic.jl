# This file is part of the ValidatedNumerics.jl package; MIT licensed

## in, \in, corresponds to isMember
function in{T<:Real}(x::T, a::Interval)
    isinf(x) && return false
    # isentire(a) && return true
    a.lo <= x <= a.hi
end


## Comparison of interval_parameters
## Equalities and neg-equalities
function ==(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return true
    a.lo == b.lo && a.hi == b.hi
end
!=(a::Interval, b::Interval) = !(a==b)

# issubset
function ⊆(a::Interval, b::Interval)
    isempty(a) && return true
    b.lo ≤ a.lo && a.hi ≤ b.hi
end

# Auxiliary functions: equivalent to </<=, but Inf <,<= Inf returning true
function islessprime{T<:Real}(a::T, b::T)
    (isinf(a) || isinf(b)) && a==b && return true
    a < b
end

# Interior
function interior(a::Interval, b::Interval)
    isempty(a) && return true
    islessprime(b.lo, a.lo) && islessprime(a.hi, b.hi)
end
const ⪽ = interior  # \subsetdot

# Disjoint:
function isdisjoint(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    islessprime(b.hi, a.lo) || islessprime(a.hi, b.lo)
end

# Weakly less, \le, <=
function <=(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    (a.lo ≤ b.lo) && (a.hi ≤ b.hi)
end

# Strict less: <
function <(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    islessprime(a.lo, b.lo) && islessprime(a.hi, b.hi)
end

# precedes
function precedes(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    a.hi ≤ b.lo
end

# strictpreceds
function strictprecedes(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return true
    # islessprime(a.hi, b.lo)
    a.hi < b.lo
end
const ≺ = strictprecedes # \prec


# zero, one
zero{T<:Real}(a::Interval{T}) = Interval(zero(T))
zero{T<:Real}(::Type{Interval{T}}) = Interval(zero(T))
one{T<:Real}(a::Interval{T}) = Interval(one(T))
one{T<:Real}(::Type{Interval{T}}) = Interval(one(T))


## Addition and subtraction

function +{T<:Real}(a::Interval{T}, b::Interval{T})
    (isempty(a) || isempty(b)) && return emptyinterval(T)
    @round(T, a.lo + b.lo, a.hi + b.hi)
end
+(a::Interval) = a

-{T<:Real}(a::Interval{T}) = @round(T, -a.hi, -a.lo)
function -{T<:Real}(a::Interval{T}, b::Interval{T})
    (isempty(a) || isempty(b)) && return emptyinterval(T)
    a + (-b)  # @round(a.lo - b.hi, a.hi - b.lo)
end


## Multiplication

function *{T<:Real}(a::Interval{T}, b::Interval{T})
    (isempty(a) || isempty(b)) && return emptyinterval(T)

    (a == zero(a) || b == zero(b)) && return zero(a)

    if b.lo >= zero(T)
        a.lo >= zero(T) && return @round(T, a.lo*b.lo, a.hi*b.hi)
        a.hi <= zero(T) && return @round(T, a.lo*b.hi, a.hi*b.lo)
        return @round(T, a.lo*b.hi, a.hi*b.hi) # in(zero(T), a)
    elseif b.hi <= zero(T)
        a.lo >= zero(T) && return @round(T, a.hi*b.lo, a.lo*b.hi)
        a.hi <= zero(T) && return @round(T, a.hi*b.hi, a.lo*b.lo)
        return @round(T, a.hi*b.lo, a.lo*b.lo) # in(zero(T), a)
    else
        a.lo > zero(T) && return @round(T, a.hi*b.lo, a.hi*b.hi)
        a.hi < zero(T) && return @round(T, a.lo*b.hi, a.lo*b.lo)
        return @round(T, min(a.lo*b.hi, a.hi*b.lo), max(a.lo*b.lo, a.hi*b.hi))
    end
    # @round(T, min( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi ),
    #         max( a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi ) )
end


## Division

function inv(a::Interval)
    isempty(a) && return emptyinterval(a)

    T = eltype(a)
    S = typeof(inv(a.lo))
    if in(zero(T), a)
        a.lo < zero(T) == a.hi && return Interval{S}(-Inf, inv(a.lo))
        a.lo == zero(T) < a.hi && return Interval{S}(inv(a.hi), Inf)
        a.lo < zero(T) < a.hi && return entireinterval(S)
        a == zero(a) && return emptyinterval(S)
    end

    @round(T, inv(a.hi), inv(a.lo))
end

function /{T<:Real}(a::Interval{T}, b::Interval{T})

    S = typeof(a.lo/b.lo)
    (isempty(a) || isempty(b)) && return emptyinterval(S)
    b == zero(b) && return emptyinterval(S)

    if b.lo > zero(T) # b strictly positive

        a.lo >= zero(T) && return @round(S, a.lo/b.hi, a.hi/b.lo)
        a.hi <= zero(T) && return @round(S, a.lo/b.lo, a.hi/b.hi)
        return @round(S, a.lo/b.lo, a.hi/b.lo) # in(zero(T), a)

    elseif b.hi < zero(T) # b strictly negative

        a.lo >= zero(T) && return @round(S, a.hi/b.hi, a.lo/b.lo)
        a.hi <= zero(T) && return @round(S, a.hi/b.lo, a.lo/b.hi)
        return @round(S, a.hi/b.hi, a.lo/b.hi) # in(zero(T), a)

    else   # b contains zero, but is not zero(b)

        a == zero(a) && return zero(Interval{S})

        if b.lo == zero(T)

            a.lo >= zero(T) && return @round(S, a.lo/b.hi, Inf)
            a.hi <= zero(T) && return @round(S, -Inf, a.hi/b.hi)
            return entireinterval(S)

        elseif b.hi == zero(T)

            a.lo >= zero(T) && return @round(S, -Inf, a.lo/b.lo)
            a.hi <= zero(T) && return @round(S, a.hi/b.lo, Inf)
            return entireinterval(S)

        else

            return entireinterval(S)

        end
    end
    # a * inv(b)
    # @round(S, min( a.lo/b.lo, a.lo/b.hi, a.hi/b.lo, a.hi/b.hi ),
    #           max( a.lo/b.lo, a.lo/b.hi, a.hi/b.lo, a.hi/b.hi ) )
end

//(a::Interval, b::Interval) = a / b    # to deal with rationals


## Scalar functions on intervals (no directed rounding used)

mag(a::Interval) = ifelse(isempty(a), convert(eltype(a), NaN),
    max( abs(a.lo), abs(a.hi) ))
mig(a::Interval) = ifelse(isempty(a), convert(eltype(a), NaN),
    ifelse(zero(a.lo) ∈ a, zero(a.lo), min(abs(a.lo), abs(a.hi))))


# Infimum and supremum of an interval
infimum(a::Interval) = a.lo
supremum(a::Interval) = a.hi


## Functions needed for generic linear algebra routines to work
real(a::Interval) = a
function abs(a::Interval)
    isempty(a) && return emptyinterval(a)
    Interval(mig(a), mag(a))
end


## Set operations

function intersect{T}(a::Interval{T}, b::Interval{T})
    isdisjoint(a,b) && return emptyinterval(T)

    #@round(T, max(a.lo, b.lo), min(a.hi, b.hi))
    Interval(max(a.lo, b.lo), min(a.hi, b.hi))
end

# Specific promotion rule for intersect:
intersect{T,S}(a::Interval{T}, b::Interval{S}) = intersect(promote(a,b)...)

hull{T}(a::Interval{T}, b::Interval{T}) = Interval(min(a.lo, b.lo), max(a.hi, b.hi))
union(a::Interval, b::Interval) = hull(a, b)


dist(a::Interval, b::Interval) = max(abs(a.lo-b.lo), abs(a.hi-b.hi))
eps(a::Interval) = max(eps(a.lo), eps(a.hi))


floor(a::Interval) = Interval(floor(a.lo), floor(a.hi))
ceil(a::Interval) = Interval(ceil(a.lo), ceil(a.hi))

mid(a::Interval) = ifelse(isentire(a), zero(a.lo), (a.lo + a.hi) / 2)
diam(a::Interval) = ifelse(isempty(a), convert(eltype(a), NaN), a.hi - a.lo)

# Should `radius` this yield diam(a)/2? This affects other functions!
radius(a::Interval) = ifelse(isempty(a), convert(eltype(a), NaN),
    (m = mid(a); max(m-a.lo, a.hi-m)))

midpoint_radius(a::Interval) = (mid(a), radius(a))

interval_from_midpoint_radius(midpoint, radius) = Interval(midpoint-radius, midpoint+radius)
