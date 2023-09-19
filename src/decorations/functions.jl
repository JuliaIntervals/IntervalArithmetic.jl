# This file is part of the IntervalArithmetic.jl package; MIT licensed

Base.literal_pow(::typeof(^), x::DecoratedInterval{T}, ::Val{p}) where {T,p} = x^p


# zero, one
zero(::DecoratedInterval{T}) where {T<:NumTypes} = DecoratedInterval(zero(T))
zero(::Type{DecoratedInterval{T}}) where {T<:NumTypes} = DecoratedInterval(zero(T))
one(::DecoratedInterval{T}) where {T<:NumTypes} = DecoratedInterval(one(T))
one(::Type{DecoratedInterval{T}}) where {T<:NumTypes} = DecoratedInterval(one(T))

## Bool functions

Base.:(==)(::DecoratedInterval, ::DecoratedInterval) =
    throw(ArgumentError("`==` is purposely not supported, use `isequalinterval` instead"))

const bool_functions = (
    :isemptyinterval, :isentireinterval, :isunbounded, :isbounded,
    :isthin, :iscommon
)

const bool_binary_functions = (
    :isweaksubset, :isweaksupset, :isstrictsubset, :isstrictsupset,
    :isinterior, :isdisjointinterval, :precedes, :strictprecedes, :isstrictless, :isweakless,
    :isequalinterval, :overlap
)

for f in bool_functions
    @eval $(f)(xx::DecoratedInterval) = $(f)(interval(xx))
end

for f in bool_binary_functions
    @eval function $(f)(xx::DecoratedInterval, yy::DecoratedInterval)
        (isnai(xx) || isnai(yy)) && return false
        $(f)(interval(xx), interval(yy))
    end
end

ismember(x::Real, a::DecoratedInterval) = ismember(x, interval(a))


## scalar functions: mig, mag and friends
scalar_functions = (
    :mig, :mag, :inf, :sup, :mid, :diam, :radius, :eps, :midradius
)

for f in scalar_functions
    @eval $(f)(xx::DecoratedInterval)= $f(interval(xx))
end

dist(xx::DecoratedInterval, yy::DecoratedInterval) = dist(interval(xx), interval(yy))

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
    @eval $(f)(xx::Real, yy::DecoratedInterval) = $(f)(DecoratedInterval(xx), yy)
    @eval $(f)(xx::DecoratedInterval, yy::Real) = $(f)(xx, DecoratedInterval(yy))
end

# Division
function inv(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    dx = decoration(xx)
    dx = ismember(zero(T), x) ? min(dx, trv) : dx
    r = inv(x)
    dx = min(decoration(r), dx)
    DecoratedInterval( r, dx )
end
/(xx::Real, yy::DecoratedInterval) = DecoratedInterval(xx) / yy
/(xx::DecoratedInterval, yy::Real) = xx / DecoratedInterval(yy)
function /(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}) where T
    x = interval(xx)
    y = interval(yy)
    r = x / y
    dy = decoration(yy)
    dy = ismember(zero(T), y) ? min(dy, trv) : dy
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
    n < 0 && ismember(zero(T), x) && return DecoratedInterval(r, trv)
    DecoratedInterval(r, d)
end

function ^(xx::DecoratedInterval{T}, q::AbstractFloat) where T
    x = interval(xx)
    r = x^q
    d = min(decoration(xx), decoration(r))
    if inf(x) > zero(T) || (inf(x) ≥ zero(T) && q > zero(T)) ||
            (isinteger(q) && q > zero(q)) || (isinteger(q) && !ismember(zero(T), x))
        return DecoratedInterval(r, d)
    end
    DecoratedInterval(r, trv)
end

function ^(xx::DecoratedInterval{T}, q::Rational{S}) where {T, S<:Integer}
    x = interval(xx)
    r = x^q
    d = min(decoration(xx), decoration(r))
    if inf(x) > zero(T) || (inf(x) ≥ zero(T) && q > zero(T)) ||
            (isinteger(q) && q > zero(q)) || (isinteger(q) && !ismember(zero(T), x))
        return DecoratedInterval(r, d)
    end
    DecoratedInterval(r, trv)
end

function ^(xx::DecoratedInterval{T}, qq::DecoratedInterval{S}) where {T,S}
    x = interval(xx)
    q = interval(qq)
    r = x^q
    d = min(decoration(xx), decoration(qq), decoration(r))
    if inf(x) > zero(T) || (inf(x) ≥ zero(T) && inf(q) > zero(T)) ||
            (isthin(q) && isinteger(inf(q)) && inf(q) > zero(T)) ||
            (isthin(q) && isinteger(inf(q)) && !ismember(zero(T), x))
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
    if isinteger(sup(x))
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function floor(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    r = floor(x)
    d = decoration(xx)
    if isinteger(inf(x))
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function trunc(xx::DecoratedInterval{T}) where T
    x = interval(xx)
    r = trunc(x)
    d = decoration(xx)
    if (isinteger(inf(x)) && inf(x) < zero(T)) || (isinteger(sup(x)) && sup(x) > zero(T))
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end

function round(xx::DecoratedInterval, ::RoundingMode{:Nearest})
    x = interval(xx)
    r = round(x)
    d = decoration(xx)
    if isinteger(2*inf(x)) || isinteger(2*sup(x))
        d = min(d, dac)
    end
    isthin(r) && return DecoratedInterval(r, d)
    DecoratedInterval(r, min(d,def))
end
function round(xx::DecoratedInterval, ::RoundingMode{:NearestTiesAway})
    x = interval(xx)
    r = round(x,RoundNearestTiesAway)
    d = decoration(xx)
    if isinteger(2*inf(x)) || isinteger(2*sup(x))
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
other_functions = ( :cancelplus, :cancelminus, :intersectinterval, :hull )

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
    intersectinterval(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" intersectinterval

@doc """
    hull(xx, yy)

Decorated interval extension; the result is decorated as `trv`,
following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
""" hull



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
    if ismember(zero(T), y)
        ismember(zero(T), x) && return DecoratedInterval(r, trv)
        if sup(x) < zero(T)
            inf(y) < zero(T) && return DecoratedInterval(r, min(d, def))
            return DecoratedInterval(r, min(d, dac))
        end
    end
    DecoratedInterval(r, d)
end


# For domains, cf. table 9.1 on page 28 of the standard
# Functions with restricted domains:

# The function is unbounded at the bounded edges of the domain
restricted_functions1 = Dict(
    :log   => unsafe_interval(Float64, 0.0, Inf),
    :log2  => unsafe_interval(Float64, 0.0, Inf),
    :log10 => unsafe_interval(Float64, 0.0, Inf),
    :atanh => unsafe_interval(Float64, -1.0, 1.0)
)

# The function is bounded at the bounded edge(s) of the domain
restricted_functions2 = Dict(
    :sqrt  => unsafe_interval(Float64, 0.0, Inf),
    :asin  => unsafe_interval(Float64, -1.0, 1.0),
    :acos  => unsafe_interval(Float64, -1.0, 1.0),
    :acosh => unsafe_interval(Float64, 1.0, Inf)
)

# Define functions with restricted domains on DecoratedInterval's:
for (f, domain) in restricted_functions1
    @eval function Base.$(f)(xx::DecoratedInterval{T}) where T
        x = interval(xx)
        r = $(f)(x)
        d = min(decoration(xx), decoration(r))
        isinterior(x, $domain) && return DecoratedInterval(r, d)
        DecoratedInterval(r, trv)
    end
end

for (f, domain) in restricted_functions2
    @eval function Base.$(f)(xx::DecoratedInterval{T}) where T
        x = interval(xx)
        r = $(f)(x)
        d = min(decoration(xx), decoration(r))
        isweaksubset(x, $domain) && return DecoratedInterval(r, d)
        DecoratedInterval(r, trv)
    end
end
