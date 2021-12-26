# This file is part of the IntervalArithmetic.jl package; MIT licensed

# convert methods:
convert(::Type{F}, x::Bool) where {F<:Interval} = convert(F, Int(x))
# TODO Introduce "BoundType" union for that kind of cases instead of AbstractFloat
# NOTE I believe there was a PR for this
convert(::Type{F}, x::S) where {F<:Interval, S<:AbstractFloat} = atomic(F, x)
convert(::Type{Interval{T}}, x::S) where {T, S<:Number} = atomic(Interval{promote_type(S, T)}, x)
convert(::Type{Interval{T}}, x::Interval) where T = atomic(Interval{T}, x)
convert(::Type{F}, x::F) where {F<:Interval} = x

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

atomic(::Type{F}, x::AbstractString) where {T, F<:Interval{T}} = parse(F, x)

@static if Sys.iswindows()  # Windows cannot round properly
    function atomic(::Type{F}, x::S) where {T, S, F<:Interval{T}}
        isinf(x) && return wideinterval(F, T(x))

        return F( parse(T, string(x), RoundDown),
                  parse(T, string(x), RoundUp) )
    end

    function atomic(::Type{F}, x::Union{Irrational, Rational}) where {T, F<:Interval{T}}
        isinf(x) && return wideinterval(F, T(x))

        return F( T(x, RoundDown), T(x, RoundUp) )
    end

else
    function atomic(::Type{F}, x::S) where {T, S, F<:Interval{T}}
        isinf(x) && return wideinterval(F, T(x))

        F( T(x, RoundDown), T(x, RoundUp) )
        # the rounding up could be done as nextfloat of the rounded down one?
        # use @round_up and @round_down here?
    end
end

function atomic(::Type{F}, x::S) where {T, S<:AbstractFloat, F<:Interval{T}}
    isinf(x) && return wideinterval(F, x)

    xrat = rationalize(x)

    # This prevents that xrat returns a 0//1 when x is very small
    # or 1//0 when x is too large but finite
    if (!iszero(x) && iszero(xrat)) || isinf(xrat)
        xstr = string(x)
        return F(parse(T, xstr, RoundDown), parse(T, xstr, RoundUp))
    end

    return atomic(F, xrat)
end

function atomic(::Type{F}, x::Interval) where {T, F<:Interval{T}}
    return F( T(inf(x), RoundDown), T(sup(x), RoundUp) )
end

# Complex numbers:
# TODO This one doesn't return an interval, not sure what it's suppose do do
# atomic(::Type{Interval{T}}, x::Complex{Bool}) where T<:AbstractFloat =
#     (x == im) ? one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function atomic(::Type{F}, x::Irrational) where {T<:Integer, F<:Interval{Rational{T}}}
    Flavor = flavortype(F)
    a = float(atomic(Flavor{BigFloat}, x))
    atomic(F, a)
end

atomic(::Type{F}, x::S) where {T<:Integer, S<:Integer, F<:Interval{Rational{T}}} =
    F(convert(Rational{T}, x))

atomic(::Type{F}, x::S) where {T<:Integer, S<:Rational, F<:Interval{Rational{T}}} =
    F(convert(Rational{T}, x))

atomic(::Type{F}, x::S) where {T<:Integer, S<:AbstractFloat, F<:Interval{Interval{Rational{T}}}} =
    F(rationalize(T, x))
