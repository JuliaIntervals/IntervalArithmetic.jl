# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Promotion rules

promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{Interval{T}}, ::Type{S}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{BigFloat}, ::Type{Interval{T}}) where T<:Real =
    Interval{promote_type(T, BigFloat)}


# convert methods:
convert(::Type{Interval{T}}, x::Bool) where {T} = convert(Interval{T}, Int(x))
convert(::Type{Interval{T}}, x::Real) where {T} = atomic(Interval{T}, x)
convert(::Type{Interval{T}}, x::T) where {T<:Real} = Interval{T}(x)
convert(::Type{Interval{T}}, x::Interval{T}) where {T} = x
convert(::Type{Interval{T}}, x::Interval) where {T} = atomic(Interval{T}, x)

convert(::Type{Interval}, x::Real) = (T = typeof(float(x)); convert(Interval{T}, x))
convert(::Type{Interval}, x::Interval) = x

"""
    atomic(::Type{<:Interval}, x)

Construct the tightest interval of a given type that contains the value `x`.

If `x` is an `AbstractString`, the interval will be created by calling `parse`.

# Examples

Construct an `Interval{Float64}` containing a given `BigFloat`:

```julia
julia> x = big"0.1"
1.000000000000000000000000000000000000000000000000000000000000000000000000000002e-01

julia> i = IntervalArithmetic.atomic(Interval{Float64}, x)
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
julia> i1 = IntervalArithmetic.atomic(Interval{Float32}, "0.1")
[0.0999999, 0.100001]

julia> i2 = IntervalArithmetic.atomic(Interval{Float32}, 1//10)
[0.0999999, 0.100001]

julia> i1 === i2
true

julia> i.lo <= 1//10 <= i.hi
true
```
"""
function atomic end

# Integer intervals:
atomic(::Type{Interval{T}}, x::T) where {T<:Integer} = Interval{T}(x)

# Floating point intervals:
atomic(::Type{Interval{T}}, x::AbstractString) where T<:AbstractFloat =
    parse(Interval{T}, x)

@static if Sys.iswindows()  # Windows cannot round properly
    function atomic(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:Real}
        isinf(x) && return wideinterval(T(x))

        Interval{T}( parse(T, string(x), RoundDown),
                     parse(T, string(x), RoundUp) )
    end

    function atomic(::Type{Interval{T}}, x::Union{Irrational,Rational}) where {T<:AbstractFloat}
        isinf(x) && return wideinterval(T(x))

        Interval{T}( T(x, RoundDown), T(x, RoundUp) )
        # the rounding up could be done as nextfloat of the rounded down one?
        # use @round_up and @round_down here?
    end

else
    function atomic(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:Real}
        isinf(x) && return wideinterval(T(x))

        Interval{T}( T(x, RoundDown), T(x, RoundUp) )
        # the rounding up could be done as nextfloat of the rounded down one?
        # use @round_up and @round_down here?
    end
end

function atomic(::Type{Interval{T}}, x::S) where {T<:AbstractFloat, S<:AbstractFloat}
    isinf(x) && return wideinterval(T(x))

    xrat = T == BigFloat ? rationalize(BigInt, x) : rationalize(x) # Issue #410

    # This prevents that xrat returns a 0//1 when x is very small
    # or 1//0 when x is too large but finite
    if (x != zero(x) && xrat == 0) || isinf(xrat)
        xstr = string(x)
        return Interval(parse(T, xstr, RoundDown), parse(T, xstr, RoundUp))
    end

    return atomic(Interval{T}, xrat)
end

atomic(::Type{Interval{Irrational{T}}}, x::Irrational{S}) where {T, S} =
    float(atomic(Interval{Float64}, x))

function atomic(::Type{Interval{T}}, x::Interval) where T<:AbstractFloat
    Interval{T}( T(x.lo, RoundDown), T(x.hi, RoundUp) )
end

# Complex numbers:
atomic(::Type{Interval{T}}, x::Complex{Bool}) where T<:AbstractFloat =
    (x == im) ? one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function atomic(::Type{Interval{Rational{Int}}}, x::Irrational)
    a = float(atomic(Interval{BigFloat}, x))
    atomic(Interval{Rational{Int}}, a)
end

function atomic(::Type{Interval{Rational{BigInt}}}, x::Irrational)
    a = atomic(Interval{BigFloat}, x)
    atomic(Interval{Rational{BigInt}}, a)
end

atomic(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:Integer} =
    Interval(x*one(Rational{T}))

atomic(::Type{Interval{Rational{T}}}, x::Rational{S}) where
    {T<:Integer, S<:Integer} = Interval(x*one(Rational{T}))

atomic(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:Float64} =
    Interval(rationalize(T, x))

atomic(::Type{Interval{Rational{T}}}, x::S) where {T<:Integer, S<:BigFloat} =
    Interval(rationalize(T, x))
