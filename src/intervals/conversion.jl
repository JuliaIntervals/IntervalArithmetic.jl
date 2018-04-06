# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Promotion rules

promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{Interval{T}}, ::Type{S}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{BigFloat}, ::Type{Interval{T}}) where T<:Real =
    Interval{promote_type(T, BigFloat)}


# convert methods:
convert(::Type{Interval{T}}, x) where {T} = closure(Interval{T}, x)
convert(::Type{Interval{T}}, x::T) where {T} = Interval{T}(x)
convert(::Type{Interval{T}}, x::Interval{T}) where {T} = x
convert(::Type{Interval{T}}, x::Interval) where {T} = closure(Interval{T}, x)

convert(::Type{Interval}, x::Real) = (T = typeof(float(x)); convert(Interval{T}, x))
convert(::Type{Interval}, x::Interval) = x

"""
    closure(::Type{<:Interval}, x)

Construct the tightest interval of a given type that contains the value `x`.

If `x` is an `AbstractString`, the interval will be created by calling `parse`.

# Examples

Construct an `Interval{Float64}` containing a given `BigFloat`:

```julia
julia> x = big"0.1"
1.000000000000000000000000000000000000000000000000000000000000000000000000000002e-01

julia> i = IntervalArithmetic.closure(Interval{Float64}, x)
[0.0999999, 0.100001]

julia> i isa Interval{Float64}
true

julia> i.lo <= x <= i.hi
true

julia> i.hi === nextfloat(i.lo)
true
```

Construct an `Interval{Float32}` containing a the real number 0.1 in two ways:

```julia
julia> i1 = IntervalArithmetic.closure(Interval{Float32}, "0.1")
[0.0999999, 0.100001]

julia> i2 = IntervalArithmetic.closure(Interval{Float32}, 1//10)
[0.0999999, 0.100001]

julia> i1 === i2
true

julia> i.lo <= 1//10 <= i.hi
true
```
"""
function closure end

# Integer intervals:
closure(::Type{Interval{T}}, x::T) where {T<:Integer} = Interval{T}(x)

# Floating point intervals:
closure(::Type{Interval{T}}, x::AbstractString) where T<:AbstractFloat =
    parse(Interval{T}, x)

function closure(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:Real}
    isinf(x) && return wideinterval(T(x))

    Interval{T}( T(x, RoundDown), T(x, RoundUp) )
    # the rounding up could be done as nextfloat of the rounded down one?
    # use @round_up and @round_down here?
end

function closure(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:AbstractFloat}
    isinf(x) && return wideinterval(x)#Interval{T}(prevfloat(T(x)), nextfloat(T(x)))
    # isinf(x) && return Interval{T}(prevfloat(x), nextfloat(x))

    xrat = rationalize(x)

    # This prevents that xrat returns a 0//1 when x is very small
    # or 1//0 when x is too large but finite
    if (x != zero(x) && xrat == 0) || isinf(xrat)
        xstr = string(x)
        return Interval(parse(T, xstr, RoundDown), parse(T, xstr, RoundUp))
    end

    return closure(Interval{T}, xrat)
end

function closure(::Type{Interval{T}}, x::Interval) where T<:AbstractFloat
    Interval{T}( T(x.lo, RoundDown), T(x.hi, RoundUp) )
end

# Complex numbers:
closure(::Type{Interval{T}}, x::Complex{Bool}) where T<:AbstractFloat =
    (x == im) ? one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function closure(::Type{Interval{Rational{Int}}}, x::Irrational)
    a = float(closure(Interval{BigFloat}, x))
    closure(Interval{Rational{Int}}, a)
end

function closure(::Type{Interval{Rational{BigInt}}}, x::Irrational)
    a = closure(Interval{BigFloat}, x)
    closure(Interval{Rational{BigInt}}, a)
end

closure(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:Integer} =
    Interval(x*one(Rational{T}))

closure(::Type{Interval{Rational{T}}}, x::Rational{S}) where
    {T<:Integer, S<:Integer} = Interval(x*one(Rational{T}))

closure(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:Float64} =
    Interval(rationalize(T, x))

closure(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:BigFloat} =
    Interval(rationalize(T, x))
