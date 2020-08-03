# This file is part of the IntervalArithmetic.jl package; MIT licensed

Base.literal_pow(::typeof(^), x::DecoratedInterval{T}, ::Val{p}) where {T,p} = x^p


# zero, one
zero(a::DecoratedInterval{T}) where T<:Real = DecoratedInterval(zero(T))
zero(::Type{DecoratedInterval{T}}) where T<:Real = DecoratedInterval(zero(T))
one(a::DecoratedInterval{T}) where T<:Real = DecoratedInterval(one(T))
one(::Type{DecoratedInterval{T}}) where T<:Real = DecoratedInterval(one(T))

# NaI: not-an-interval
"""`NaI` not-an-interval: [NaN, NaN]."""
nai(::Type{T}) where T<:Real = DecoratedInterval(Interval{T}(convert(T, NaN), convert(T, NaN)), ill)
nai(x::Interval{T}) where T<:Real = nai(T)
nai(x::DecoratedInterval{T}) where T<:Real = nai(T)
nai() = nai(precision(Interval)[1])
isnai(x::Interval) = isnan(x.lo) || isnan(x.hi)
isnai(x::DecoratedInterval) = isnai(interval(x)) && x.decoration == ill
isnan(x::Interval) = isnai(x)

## Bool functions
bool_functions = (
    :isempty, :isentire, :isunbounded,
    :isfinite, :isnan,
    :isthin, :iscommon
)

bool_binary_functions = (
    :<, :>, :!=, :⊆, :<=,
    :isinterior, :isdisjoint, :precedes, :strictprecedes
)

for f in bool_functions
    @eval $(f)(xx::DecoratedInterval) = $(f)(interval(xx))
end

for f in bool_binary_functions
    @eval $(f)(xx::DecoratedInterval, yy::DecoratedInterval) =
        $(f)(interval(xx), interval(yy))
end

in(x::T, a::DecoratedInterval) where T<:Real = in(x, interval(a))


function ==(x::DecoratedInterval, y::DecoratedInterval)
    isnai(x) && isnai(y) && return true
    return (==(interval(x), interval(y)))
end

## scalar functions: mig, mag and friends
scalar_functions = (
    :mig, :mag, :inf, :sup, :mid, :diam, :radius, :dist, :eps
)

for f in scalar_functions
    @eval $(f)(xx::DecoratedInterval{T}) where T = $f(interval(xx))
end


## Arithmetic function; / is treated separately
arithm_functions = ( :+, :-, :* )

+(xx::DecoratedInterval) =  xx
-(xx::DecoratedInterval) =  DecoratedInterval(-interval(xx), decoration(xx))
for f in arithm_functions
    @eval function $(f)(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}) where T
        x = interval(xx)
        y = interval(yy)
        r = $f(x, y)
        dec = min(decoration(xx), decoration(yy), decoration(r))
        DecoratedInterval(r, dec)
    end
end

# Division
function inv(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    dx = decoration(xx)
    dx = zero(T) ∈ x ? min(dx,trv) : dx
    r = inv(x)
    dx = min(decoration(r), dx)
    DecoratedInterval( r, dx )
end
function /(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}) where T
    x = interval(xx)
    y = interval(yy)
    r = x / y
    dy = decoration(yy)
    dy = zero(T) ∈ y ? min(dy, trv) : dy
    dy = min(decoration(xx), dy, decoration(r))
    DecoratedInterval(r, dy)
end

## fma
function fma(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}, zz::DecoratedInterval{T}) where T
    r = fma(interval(xx), interval(yy), interval(zz))
    d = min(decoration(xx), decoration(yy), decoration(zz))
    d = min(decoration(r), d)
    DecoratedInterval(r, d)
end


# power function must be defined separately and carefully
function ^(xx::DecoratedInterval{T}, n::Integer) where T
    x = interval(xx)
    r = x^n
    d = min(decoration(xx), decoration(r))
    n < 0 && zero(T) ∈ x && return DecoratedInterval(r, trv)
    DecoratedInterval(r, d)
end

function ^(xx::DecoratedInterval{T}, q::AbstractFloat) where T
    x = interval(xx)
    r = x^q
    d = min(decoration(xx), decoration(r))
    if x > zero(T) || (x.lo ≥ zero(T) && q > zero(T)) ||
            (isinteger(q) && q > zero(q)) || (isinteger(q) && zero(T) ∉ x)
        return DecoratedInterval(r, d)
    end
    DecoratedInterval(r, trv)
end

function ^(xx::DecoratedInterval{T}, q::Rational{S}) where {T, S<:Integer}
    x = interval(xx)
    r = x^q
    d = min(decoration(xx), decoration(r))
    if x > zero(T) || (x.lo ≥ zero(T) && q > zero(T)) ||
            (isinteger(q) && q > zero(q)) || (isinteger(q) && zero(T) ∉ x)
        return DecoratedInterval(r, d)
    end
    DecoratedInterval(r, trv)
end

function ^(xx::DecoratedInterval{T}, qq::DecoratedInterval{S}) where {T,S}
    x = interval(xx)
    q = interval(qq)
    r = x^q
    d = min(decoration(xx), decoration(qq), decoration(r))
    if x > zero(T) || (x.lo ≥ zero(T) && q.lo > zero(T)) ||
            (isthin(q) && isinteger(q.lo) && q.lo > zero(q)) ||
            (isthin(q) && isinteger(q.lo) && zero(T) ∉ x)
        return DecoratedInterval(r, d)
    end
    DecoratedInterval(r, trv)
end

^(xx::DecoratedInterval{T}, q::Interval{S}) where {T,S} =
    xx^DecoratedInterval(q)

## Discontinuous functions (sign, ceil, floor, trunc) and round
function sign(xx::DecoratedInterval{T}) where T
    r = sign(interval(xx))
    d = decoration(xx)
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function ceil(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    r = ceil(x)
    d = decoration(xx)
    if isinteger(x.hi)
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function floor(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    r = floor(x)
    d = decoration(xx)
    if isinteger(x.lo)
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function trunc(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    r = trunc(x)
    d = decoration(xx)
    if (isinteger(x.lo) && x.lo < zero(T)) || (isinteger(x.hi) && x.hi > zero(T))
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end

function round(xx::DecoratedInterval, ::RoundingMode{:Nearest})
    x = interval(xx)
    r = round(x)
    d = decoration(xx)
    if isinteger(2*x.lo) || isinteger(2*x.hi)
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function round(xx::DecoratedInterval, ::RoundingMode{:NearestTiesAway})
    x = interval(xx)
    r = round(x,RoundNearestTiesAway)
    d = decoration(xx)
    if isinteger(2*x.lo) || isinteger(2*x.hi)
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
round(xx::DecoratedInterval) = round(xx, RoundNearest)
round(xx::DecoratedInterval, ::RoundingMode{:ToZero}) = trunc(xx)
round(xx::DecoratedInterval, ::RoundingMode{:Up}) = ceil(xx)
round(xx::DecoratedInterval, ::RoundingMode{:Down}) = floor(xx)


## Define binary functions with no domain restrictions
binary_functions = ( :min, :max )

for f in binary_functions
    @eval function $(f)(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}) where T
        r = $f(interval(xx), interval(yy))
        d = min(decoration(r), decoration(xx), decoration(yy))
        DecoratedInterval(r, d)
    end
end

## abs
abs(xx::DecoratedInterval{T}) where T =
    DecoratedInterval(abs(interval(xx)), decoration(xx))


## Other (cancel and set) functions
other_functions = ( :cancelplus, :cancelminus, :intersect, :hull, :union )

for f in other_functions
    @eval $(f)(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}) where T =
        DecoratedInterval($(f)(interval(xx), interval(yy)), trv)
end

@doc """
    cancelplus(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" cancelplus

@doc """
    cancelminus(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" cancelminus

@doc """
    intersect(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" intersect

@doc """
    hull(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" hull

@doc """
    union(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" union


## Functions on unrestricted domains; tan and atan are treated separately
unrestricted_functions =(
    :exp, :exp2, :exp10,
    :sin, :cos,
    :atan,
    :sinh, :cosh, :tanh,
    :asinh )

for f in unrestricted_functions
    @eval function $(f)(xx::DecoratedInterval{T}) where T
        x = interval(xx)
        r = $f(x)
        d = min(decoration(r), decoration(xx))
        DecoratedInterval(r, d)
    end
end

function tan(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    r = tan(x)
    d = min(decoration(r), decoration(xx))
    if isunbounded(r)
        d = min(d, trv)
    end
    DecoratedInterval(r, d)
end

function decay(a::DECORATION)
    a == com && return dac
    a == dac && return def
    a == def && return trv
    a == trv && return trv
    ill
end

function atan(yy::DecoratedInterval{T}, xx::DecoratedInterval{T}) where T
    x = interval(xx)
    y = interval(yy)
    r = atan(y, x)
    d = decoration(r)
    d = min(d, decoration(xx), decoration(yy))
    # Check cases when decoration is trv and decays (from com or dac)
    if zero(T) ∈ y
        zero(T) ∈ x && return DecoratedInterval(r, trv)
        if x.hi < zero(T) && y.lo != y.hi && signbit(y.lo) && Int(d) > 2
            return DecoratedInterval(r, decay(d))
        end
    end
    DecoratedInterval(r, d)
end


# For domains, cf. table 9.1 on page 28 of the standard
# Functions with restricted domains:

# The function is unbounded at the bounded edges of the domain
restricted_functions1 = Dict(
    :log   => [0, ∞],
    :log2  => [0, ∞],
    :log10 => [0, ∞],
    :atanh => [-1, 1]
)

# The function is bounded at the bounded edge(s) of the domain
restricted_functions2 = Dict(
    :sqrt  => [0, ∞],
    :asin  => [-1, 1],
    :acos  => [-1, 1],
    :acosh => [1, ∞]
)

# Define functions with restricted domains on DecoratedInterval's:
for (f, domain) in restricted_functions1
    domain = Interval(domain...)
    @eval function Base.$(f)(xx::DecoratedInterval{T}) where T
        x = interval(xx)
        r = $(f)(x)
        d = min(decoration(xx), decoration(r))
        x ⪽ $(domain) && return DecoratedInterval(r, d)
        DecoratedInterval(r, trv)
    end
end

for (f, domain) in restricted_functions2
    domain = Interval(domain...)
    @eval function Base.$(f)(xx::DecoratedInterval{T}) where T
        x = interval(xx)
        r = $(f)(x)
        d = min(decoration(xx), decoration(r))
        x ⊆ $(domain) && return DecoratedInterval(r, d)
        DecoratedInterval(r, trv)
    end
end

function overlap(xx::DecoratedInterval, yy::DecoratedInterval) where T
    return overlap(interval_part(xx) , interval_part(yy))
end