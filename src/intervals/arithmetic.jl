# This file is part of the IntervalArithmetic.jl package; MIT licensed


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
function islessprime(a::T, b::T) where T<:Real
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


# zero, one, typemin, typemax
zero(a::Interval{T}) where T<:Real = Interval(zero(T))
zero(::Type{Interval{T}}) where T<:Real = Interval(zero(T))
one(a::Interval{T}) where T<:Real = Interval(one(T))
one(::Type{Interval{T}}) where T<:Real = Interval(one(T))
typemin(::Type{Interval{T}}) where T<:AbstractFloat = wideinterval(typemin(T))
typemax(::Type{Interval{T}}) where T<:AbstractFloat = wideinterval(typemax(T))
typemin(::Type{Interval{T}}) where T<:Integer = Interval(typemin(T))
typemax(::Type{Interval{T}}) where T<:Integer = Interval(typemax(T))

## Addition and subtraction

+(a::Interval) = a
-(a::Interval) = Interval(-a.hi, -a.lo)

function +(a::Interval{T}, b::T) where {T<:Real}
    isempty(a) && return emptyinterval(T)
    @round(a.lo + b, a.hi + b)
end
+(b::T, a::Interval{T}) where {T<:Real} = a+b

function -(a::Interval{T}, b::T) where {T<:Real}
    isempty(a) && return emptyinterval(T)
    @round(a.lo - b, a.hi - b)
end
function -(b::T, a::Interval{T}) where {T<:Real}
    isempty(a) && return emptyinterval(T)
    @round(b - a.hi, b - a.lo)
end

function +(a::Interval{T}, b::Interval{T}) where T<:Real
    (isempty(a) || isempty(b)) && return emptyinterval(T)
    @round(a.lo + b.lo, a.hi + b.hi)
end

function -(a::Interval{T}, b::Interval{T}) where T<:Real
    (isempty(a) || isempty(b)) && return emptyinterval(T)
    @round(a.lo - b.hi, a.hi - b.lo)
end


## Multiplication
function *(x::T, a::Interval{T}) where {T<:Real}
    isempty(a) && return emptyinterval(T)
    (iszero(a) || iszero(x)) && return zero(Interval{T})

    if x ≥ 0.0
        return @round(a.lo*x, a.hi*x)
    else
        return @round(a.hi*x, a.lo*x)
    end
end

*(a::Interval{T}, x::T) where {T<:Real} = x*a

"a * b where 0 * Inf is special-cased"
function checked_mult(a::T, b::T, r::RoundingMode) where T

    # println("checked_mult a=$a b=$b")

    if (a == 0 && isinf(b)) || (isinf(a) && b == 0)
        return zero(T)
    end

    return *(a, b, r)
end

function mult(op, a::Interval{T}, b::Interval{T}) where T<:Real
    if b.lo >= zero(T)
        a.lo >= zero(T) && return @round( op(a.lo, b.lo), op(a.hi, b.hi) )
        a.hi <= zero(T) && return @round( op(a.lo, b.hi), op(a.hi, b.lo) )
        return @round(a.lo*b.hi, a.hi*b.hi)   # zero(T) ∈ a
    elseif b.hi <= zero(T)
        a.lo >= zero(T) && return @round( op(a.hi, b.lo), op(a.lo, b.hi) )
        a.hi <= zero(T) && return @round( op(a.hi, b.hi), op(a.lo, b.lo) )
        return @round(a.hi*b.lo, a.lo*b.lo)   # zero(T) ∈ a
    else
        a.lo > zero(T) && return @round( op(a.hi, b.lo), op(a.hi, b.hi) )
        a.hi < zero(T) && return @round( op(a.lo, b.hi), op(a.lo, b.lo) )
        return @round(min( op(a.lo, b.hi), op(a.hi, b.lo) ),
                        max( op(a.lo, b.lo), op(a.hi, b.hi) ) )
    end
end

function *(a::Interval{T}, b::Interval{T}) where T<:Real
    (isempty(a) || isempty(b)) && return emptyinterval(T)

    (iszero(a) || iszero(b)) && return zero(Interval{T})

    (isfinite(a) && isfinite(b)) && return mult(*, a, b)

    return mult(checked_mult, a, b)
end


## Division
function /(a::Interval{T}, x::T) where {T<:Real}
    isempty(a) && return emptyinterval(T)
    iszero(x) && return emptyinterval(T)
    iszero(a) && return zero(Interval{T})

    if x ≥ 0.0
        return @round(a.lo/x, a.hi/x)
    else
        return @round(a.hi/x, a.lo/x)
    end
end

function inv(a::Interval{T}) where T<:Real
    isempty(a) && return emptyinterval(a)

    if zero(T) ∈ a
        a.lo < zero(T) == a.hi && return @round(T(-Inf), inv(a.lo))
        a.lo == zero(T) < a.hi && return @round(inv(a.hi), T(Inf))
        a.lo < zero(T) < a.hi && return entireinterval(T)
        a == zero(a) && return emptyinterval(T)
    end

    @round(inv(a.hi), inv(a.lo))
end

function /(a::Interval{T}, b::Interval{T}) where T<:Real

    S = typeof(a.lo / b.lo)
    (isempty(a) || isempty(b)) && return emptyinterval(S)
    iszero(b) && return emptyinterval(S)

    if b.lo > zero(T) # b strictly positive

        a.lo >= zero(T) && return @round(a.lo/b.hi, a.hi/b.lo)
        a.hi <= zero(T) && return @round(a.lo/b.lo, a.hi/b.hi)
        return @round(a.lo/b.lo, a.hi/b.lo)  # zero(T) ∈ a

    elseif b.hi < zero(T) # b strictly negative

        a.lo >= zero(T) && return @round(a.hi/b.hi, a.lo/b.lo)
        a.hi <= zero(T) && return @round(a.hi/b.lo, a.lo/b.hi)
        return @round(a.hi/b.hi, a.lo/b.hi)  # zero(T) ∈ a

    else   # b contains zero, but is not zero(b)

        iszero(a) && return zero(Interval{S})

        if iszero(b.lo)

            a.lo >= zero(T) && return @round(a.lo/b.hi, T(Inf))
            a.hi <= zero(T) && return @round(T(-Inf), a.hi/b.hi)
            return entireinterval(S)

        elseif iszero(b.hi)

            a.lo >= zero(T) && return @round(T(-Inf), a.lo/b.lo)
            a.hi <= zero(T) && return @round(a.hi/b.lo, T(Inf))
            return entireinterval(S)

        else

            return entireinterval(S)

        end
    end
end

function extended_div(a::Interval{T}, b::Interval{T}) where T<:Real

    S = typeof(a.lo / b.lo)
    if 0 < b.hi && 0 > b.lo && 0 ∉ a
        if a.hi < 0
            return (Interval(T(-Inf), /(a.hi, b.hi, RoundUp)), Interval(/(a.hi, b.lo, RoundDown), T(Inf)))

        elseif a.lo > 0
            return (Interval(T(-Inf), /(a.lo, b.lo, RoundUp)), Interval(/(a.lo, b.hi, RoundDown), T(Inf)))

        end
    elseif 0 ∈ a && 0 ∈ b
        return (entireinterval(S), emptyinterval(S))
    else
        return (a / b, emptyinterval(S))
    end
end

//(a::Interval, b::Interval) = a / b    # to deal with rationals


function min_ignore_nans(args...)
    min(Iterators.filter(x->!isnan(x), args)...)
end

function max_ignore_nans(args...)
    max(Iterators.filter(x->!isnan(x), args)...)
end



## fma: fused multiply-add
function fma(a::Interval{T}, b::Interval{T}, c::Interval{T}) where T
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
        min_ignore_nans(lo1, lo2, lo3, lo4)
    end

    hi = setrounding(T, RoundUp) do
        hi1 = fma(a.lo, b.lo, c.hi)
        hi2 = fma(a.lo, b.hi, c.hi)
        hi3 = fma(a.hi, b.lo, c.hi)
        hi4 = fma(a.hi, b.hi, c.hi)
        max_ignore_nans(hi1, hi2, hi3, hi4)
    end

    Interval(lo, hi)
end


## Scalar functions on intervals (no directed rounding used)

function mag(a::Interval{T}) where T<:Real
    isempty(a) && return convert(eltype(a), NaN)
    # r1, r2 = setrounding(T, RoundUp) do
    #     abs(a.lo), abs(a.hi)
    # end
    max( abs(a.lo), abs(a.hi) )
end

function mig(a::Interval{T}) where T<:Real
    isempty(a) && return convert(eltype(a), NaN)
    zero(a.lo) ∈ a && return zero(a.lo)
    r1, r2 = setrounding(T, RoundDown) do
        abs(a.lo), abs(a.hi)
    end
    min( r1, r2 )
end


# Infimum and supremum of an interval
inf(a::Interval) = a.lo
sup(a::Interval) = a.hi


## Functions needed for generic linear algebra routines to work
real(a::Interval) = a

function abs(a::Interval)
    isempty(a) && return emptyinterval(a)
    Interval(mig(a), mag(a))
end

function abs2(a::Interval)
    sqr(a)
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
eps(a::Interval) = Interval(max(eps(a.lo), eps(a.hi)))
eps(::Type{Interval{T}}) where T<:Real = Interval(eps(T))

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

function sign(a::Interval)
    isempty(a) && return emptyinterval(a)
    return Interval(sign(a.lo), sign(a.hi))
end

"""
    signbit(x::Interval)

Returns an interval containing `true` (`1`) if the value of the sign of any element in `x` is negative, containing `false` (`0`)
if any element in `x` is non-negative, and an empy interval if `x` is empty.

# Examples
```jldoctest
julia> signbit(@interval(-4))
[1, 1]

julia> signbit(@interval(5))
[0, 0]

julia> signbit(@interval(-4,5))
[0, 1]
```
"""
function signbit(a::Interval)
    isempty(a) && return emptyinterval(a)
    return Interval(signbit(a.hi), signbit(a.lo))
end

for Typ in (:Interval, :Real, :Float64, :Float32, :Signed, :Unsigned)
    @eval begin
        copysign(a::$Typ, b::Interval) = abs(a)*(1-2signbit(b))
        flipsign(a::$Typ, b::Interval) = a*(1-2signbit(b))
    end
end

for Typ in (:Real, :Float64, :Float32, :Signed, :Unsigned)
    @eval begin
        copysign(a::Interval, b::$Typ) = abs(a)*(1-2signbit(b))
        flipsign(a::Interval, b::$Typ) = a*(1-2signbit(b))
    end
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

# Compare pg. 64 of the IEEE 1788-2015 standard:
"""
    mid(a::Interval, α=0.5)

Find an intermediate point at a relative position `α`` in the interval `a`.
The default is the true midpoint at `α = 0.5`.

Assumes 0 ≤ α ≤ 1.

Warning: if the parameter `α = 0.5` is explicitly set, the behavior differs
from the default case if the provided `Interval` is not finite, since when
`α` is provided `mid` simply replaces `+∞` (respectively `-∞`) by `prevfloat(+∞)`
(respecively `nextfloat(-∞)`) for the computation of the intermediate point.
"""
function mid(a::Interval{T}, α) where T

    isempty(a) && return convert(T, NaN)

    lo = (a.lo == -∞ ? nextfloat(T(-∞)) : a.lo)
    hi = (a.hi == +∞ ? prevfloat(T(+∞)) : a.hi)

    β = convert(T, α)

    midpoint = β * (hi - lo) + lo
    isfinite(midpoint) && return midpoint
    #= Fallback in case of overflow: hi - lo == +∞.
       This case can not be the default one as it does not pass several
       IEEE1788-2015 tests for small floats.
    =#
    return (1 - β) * lo + β * hi
end

"""
    mid(a::Interval)

Find the midpoint of interval `a`.

For intervals of the form `[-∞, x]` or `[x, +∞]` where `x` is finite, return
respectively `nextfloat(-∞)` and `prevfloat(+∞)`. Note that it differs from the
behavior of `mid(a, α=0.5)`.
"""
function mid(a::Interval{T}) where T

    isempty(a) && return convert(T, NaN)
    isentire(a) && return zero(a.lo)

    a.lo == -∞ && return nextfloat(a.lo)
    a.hi == +∞ && return prevfloat(a.hi)

    midpoint = (a.lo + a.hi) / 2
    isfinite(midpoint) && return midpoint
    #= Fallback in case of overflow: a.hi + a.lo == +∞ or a.hi + a.lo == -∞.
       This case can not be the default one as it does not pass several
       IEEE1788-2015 tests for small floats.
    =#
    return a.lo / 2 + a.hi / 2
end

mid(a::Interval{Rational{T}}) where T = (1//2) * (a.lo + a.hi)

"""
    diam(a::Interval)

Return the diameter (length) of the `Interval` `a`.
"""
function diam(a::Interval{T}) where T<:Real
    isempty(a) && return convert(T, NaN)

    @round_up(a.hi - a.lo) # cf page 64 of IEEE1788
end

# Should `radius` this yield diam(a)/2? This affects other functions!
"""
    radius(a::Interval)

Return the radius of the `Interval` `a`, such that
`a ⊆ m ± radius`, where `m = mid(a)` is the midpoint.
"""
function radius(a::Interval)
    isempty(a) && return convert(eltype(a), NaN)
    m = mid(a)
    return max(m - a.lo, a.hi - m)
end

function radius(a::Interval{Rational{T}}) where T
    m = (a.lo + a.hi) / 2
    return max(m - a.lo, a.hi - m)
end

# cancelplus and cancelminus
"""
    cancelminus(a, b)

Return the unique interval `c` such that `b+c=a`.

See Section 12.12.5 of the IEEE-1788 Standard for
Interval Arithmetic.
"""
function cancelminus(a::Interval{T}, b::Interval{T}) where T<:Real
    (isempty(a) && (isempty(b) || !isunbounded(b))) && return emptyinterval(T)

    (isunbounded(a) || isunbounded(b) || isempty(b)) && return entireinterval(T)

    diam(a) < diam(b) && return entireinterval(T)

    c_lo = @round_down(a.lo - b.lo)
    c_hi = @round_up(a.hi - b.hi)

    c_lo > c_hi && return entireinterval(T)

    c_lo == Inf && return Interval(prevfloat(c_lo), c_hi)
    c_hi == -Inf && return Interval(c_lo, nextfloat(c_hi))

    a_lo = @round_down(b.lo + c_lo)
    a_hi = @round_up(b.hi + c_hi)

    if a_lo ≤ a.lo ≤ a.hi ≤ a_hi
        (nextfloat(a.hi) < a_hi || prevfloat(a.lo) > a_hi) &&
            return entireinterval(T)
        return Interval(c_lo, c_hi)
     end

    return entireinterval(T)
end
cancelminus(a::Interval, b::Interval) = cancelminus(promote(a, b)...)

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
