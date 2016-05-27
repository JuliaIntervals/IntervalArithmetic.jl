# This file is part of the ValidatedNumerics.jl package; MIT licensed


## Comparisons

"""
    ==(a,b)

Checks if the intervals `a` and `b` are equal.
"""
function ==(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return true
    a.lo == b.lo && a.hi == b.hi
end
!=(a::Interval, b::Interval) = !(a==b)


# Auxiliary functions: equivalent to </<=, but Inf <,<= Inf returning true
function islessprime{T<:Real}(a::T, b::T)
    (isinf(a) || isinf(b)) && a==b && return true
    a < b
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

+(a::Interval) = a
-(a::Interval) = Interval(-a.hi, -a.lo)

function +{T<:Real}(a::Interval{T}, b::Interval{T})
    (isempty(a) || isempty(b)) && return emptyinterval(T)
    @round(T, a.lo + b.lo, a.hi + b.hi)
end

function -{T<:Real}(a::Interval{T}, b::Interval{T})
    (isempty(a) || isempty(b)) && return emptyinterval(T)
    @round(T, a.lo - b.hi, a.hi - b.lo)
end


## Multiplication

function *{T<:Real}(a::Interval{T}, b::Interval{T})
    (isempty(a) || isempty(b)) && return emptyinterval(T)

    (a == zero(a) || b == zero(b)) && return zero(a)

    if b.lo >= zero(T)
        a.lo >= zero(T) && return @round(T, a.lo*b.lo, a.hi*b.hi)
        a.hi <= zero(T) && return @round(T, a.lo*b.hi, a.hi*b.lo)
        return @round(T, a.lo*b.hi, a.hi*b.hi)   # zero(T) ∈ a
    elseif b.hi <= zero(T)
        a.lo >= zero(T) && return @round(T, a.hi*b.lo, a.lo*b.hi)
        a.hi <= zero(T) && return @round(T, a.hi*b.hi, a.lo*b.lo)
        return @round(T, a.hi*b.lo, a.lo*b.lo)   # zero(T) ∈ a
    else
        a.lo > zero(T) && return @round(T, a.hi*b.lo, a.hi*b.hi)
        a.hi < zero(T) && return @round(T, a.lo*b.hi, a.lo*b.lo)
        return @round(T, min(a.lo*b.hi, a.hi*b.lo), max(a.lo*b.lo, a.hi*b.hi))
    end
end


## Division

function inv{T<:Real}(a::Interval{T})
    isempty(a) && return emptyinterval(a)

    if zero(T) ∈ a
        a.lo < zero(T) == a.hi && return @round(T, -Inf, inv(a.lo))
        a.lo == zero(T) < a.hi && return @round(T, inv(a.hi), Inf)
        a.lo < zero(T) < a.hi && return entireinterval(T)
        a == zero(a) && return emptyinterval(T)
    end

    @round(T, inv(a.hi), inv(a.lo))
end

function /{T<:Real}(a::Interval{T}, b::Interval{T})

    S = typeof(a.lo / b.lo)
    (isempty(a) || isempty(b)) && return emptyinterval(S)
    b == zero(b) && return emptyinterval(S)

    if b.lo > zero(T) # b strictly positive

        a.lo >= zero(T) && return @round(S, a.lo/b.hi, a.hi/b.lo)
        a.hi <= zero(T) && return @round(S, a.lo/b.lo, a.hi/b.hi)
        return @round(S, a.lo/b.lo, a.hi/b.lo)  # zero(T) ∈ a

    elseif b.hi < zero(T) # b strictly negative

        a.lo >= zero(T) && return @round(S, a.hi/b.hi, a.lo/b.lo)
        a.hi <= zero(T) && return @round(S, a.hi/b.lo, a.lo/b.hi)
        return @round(S, a.hi/b.hi, a.lo/b.hi)  # zero(T) ∈ a

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
end

//(a::Interval, b::Interval) = a / b    # to deal with rationals


## fma: fused multiply-add
function fma{T}(a::Interval{T}, b::Interval{T}, c::Interval{T})
    #T = promote_type(eltype(a), eltype(b), eltype(c))

    (isempty(a) || isempty(b) || isempty(c)) && return emptyinterval(T)

    if isentire(a)
        b == zero(b) && return c
        return entireinterval(T)
    elseif isentire(b)
        a == zero(a) && return c
        return entireinterval(T)
    end

    lo = setrounding(T, RoundDown) do
        lo1 = fma(a.lo, b.lo, c.lo)
        lo2 = fma(a.lo, b.hi, c.lo)
        lo3 = fma(a.hi, b.lo, c.lo)
        lo4 = fma(a.hi, b.hi, c.lo)
        min(lo1, lo2, lo3, lo4)
    end
    hi = setrounding(T, RoundUp) do
        hi1 = fma(a.lo, b.lo, c.hi)
        hi2 = fma(a.lo, b.hi, c.hi)
        hi3 = fma(a.hi, b.lo, c.hi)
        hi4 = fma(a.hi, b.hi, c.hi)
        max(hi1, hi2, hi3, hi4)
    end
    Interval(lo, hi)
end


## Scalar functions on intervals (no directed rounding used)

function mag{T<:Real}(a::Interval{T})
    isempty(a) && return convert(eltype(a), NaN)
    # r1, r2 = setrounding(T, RoundUp) do
    #     abs(a.lo), abs(a.hi)
    # end
    max( abs(a.lo), abs(a.hi) )
end

function mig{T<:Real}(a::Interval{T})
    isempty(a) && return convert(eltype(a), NaN)
    zero(a.lo) ∈ a && return zero(a.lo)
    r1, r2 = setrounding(T, RoundDown) do
        abs(a.lo), abs(a.hi)
    end
    min( r1, r2 )
end


# Infimum and supremum of an interval
infimum(a::Interval) = a.lo
supremum(a::Interval) = a.hi


## Functions needed for generic linear algebra routines to work
real(a::Interval) = a

function abs(a::Interval)
    isempty(a) && return emptyinterval(a)
    Interval(mig(a), mag(a))
end

function min(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return emptyinterval(a)
    Interval( min(a.lo, b.lo), min(a.hi, b.hi))
end

function max(a::Interval, b::Interval)
    (isempty(a) || isempty(b)) && return emptyinterval(a)
    Interval( max(a.lo, b.lo), max(a.hi, b.hi))
end



dist(a::Interval, b::Interval) = max(abs(a.lo-b.lo), abs(a.hi-b.hi))
eps(a::Interval) = max(eps(a.lo), eps(a.hi))


## floor, ceil, trunc, sign, roundTiesToEven, roundTiesToAway
function floor(a::Interval)
    isempty(a) && return emptyinterval(a)
    Interval(floor(a.lo), floor(a.hi))
end

function ceil(a::Interval)
    isempty(a) && return emptyinterval(a)
    Interval(ceil(a.lo), ceil(a.hi))
end

function trunc(a::Interval)
    isempty(a) && return emptyinterval(a)
    Interval(trunc(a.lo), trunc(a.hi))
end

function sign{T<:Real}(a::Interval{T})
    isempty(a) && return emptyinterval(a)

    a == zero(a) && return a
    if a ≤ zero(a)
        zero(T) ∈ a && return Interval(-one(T), zero(T))
        return Interval(-one(T))
    elseif a ≥ zero(a)
        zero(T) ∈ a && return Interval(zero(T), one(T))
        return Interval(one(T))
    end
    return Interval(-one(T), one(T))
end

# RoundTiesToEven is an alias of `RoundNearest`
const RoundTiesToEven = RoundNearest
# RoundTiesToAway is an alias of `RoundNearestTiesAway`
const RoundTiesToAway = RoundNearestTiesAway

"""
    round(a::Interval[, RoundingMode])

Returns the interval with rounded to an interger limits.

For compliance with the IEEE Std 1788-2015, "roundTiesToEven" corresponds
to `round(a)` or `round(a, RoundNearest)`, and "roundTiesToAway"
to `round(a, RoundNearestTiesAway)`.
"""
round(a::Interval) = round(a, RoundNearest)
round(a::Interval, ::RoundingMode{:ToZero}) = trunc(a)
round(a::Interval, ::RoundingMode{:Up}) = ceil(a)
round(a::Interval, ::RoundingMode{:Down}) = floor(a)

function round(a::Interval, ::RoundingMode{:Nearest})
    isempty(a) && return emptyinterval(a)
    Interval(round(a.lo), round(a.hi))
end

function round(a::Interval, ::RoundingMode{:NearestTiesAway})
    isempty(a) && return emptyinterval(a)
    Interval(round(a.lo, RoundNearestTiesAway), round(a.hi, RoundNearestTiesAway))
end

# mid, diam, radius
function mid(a::Interval)
    isentire(a) && return zero(a.lo)
    (a.lo + a.hi) / 2
end

function diam{T<:Real}(a::Interval{T})
    isempty(a) && return convert(T, NaN)
    @setrounding(T, a.hi - a.lo, RoundUp) #cf page 64 of IEEE1788
end

# Should `radius` this yield diam(a)/2? This affects other functions!
function radius(a::Interval)
    isempty(a) && return convert(eltype(a), NaN)
    m = mid(a)
    max(m - a.lo, a.hi - m)
end

# cancelplus and cancelminus
"""
    cancelminus(a, b)

Return the unique interval `c` such that `b+c=a`.
"""
function cancelminus(a::Interval, b::Interval)
    T = promote_type(eltype(a), eltype(b))

    (isempty(a) && (isempty(b) || !isunbounded(b))) && return emptyinterval(T)

    (isunbounded(a) || isunbounded(b) || isempty(b)) && return entireinterval(T)

    a.lo - b.lo > a.hi - b.hi && return entireinterval(T)

    # The following is needed to avoid finite precision problems
    ans = false
    if diam(a) == diam(b)
        prec = T == Float64 ? 128 : 128+precision(BigFloat)
        ans = setprecision(prec) do
            diam(@biginterval(a)) < diam(@biginterval(b))
        end
    end
    ans && return entireinterval(T)

    @round(T, a.lo - b.lo, a.hi - b.hi)
end

"""
    cancelplus(a, b)

Returns the unique interval `c` such that `b-c=a`;
it is equivalent to `cancelminus(a, −b)`.
"""
cancelplus(a::Interval, b::Interval) = cancelminus(a, -b)


# midpoint-radius forms
midpoint_radius(a::Interval) = (mid(a), radius(a))

interval_from_midpoint_radius(midpoint, radius) = Interval(midpoint-radius, midpoint+radius)

isinteger(a::Interval) = (a.lo == a.hi) && isinteger(a.lo)

convert(::Type{Integer}, a::Interval) = isinteger(a) ?
        convert(Integer, a.lo) : throw(ArgumentError("Cannot convert $a to integer"))
