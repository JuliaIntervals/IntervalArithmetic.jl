# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Promotion rules

# TODO find a way to promote these (doesn't seem to be a way to do it in general)
promote_rule(::Type{Interval{T}}, ::Type{Interval{S}}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{Interval{T}}, ::Type{S}) where {T<:Real, S<:Real} =
    Interval{promote_type(T, S)}

promote_rule(::Type{BigFloat}, ::Type{Interval{T}}) where {T<:Real} =
    Interval{promote_type(T, BigFloat)}


# convert methods:
convert(::Type{F}, x::Bool) where {F<:AbstractFlavor} = convert(F, Int(x))
convert(::Type{F}, x::Real) where {F<:AbstractFlavor} = atomic(F, x)
convert(::Type{F}, x::T) where {T, F<:AbstractFlavor{T}} = F(x)
convert(::Type{F}, x::F) where {F<:AbstractFlavor} = x
convert(::Type{F}, x::G) where {F<:AbstractFlavor, G<:AbstractFlavor} = atomic(F, x)

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

atomic(::Type{F}, x::AbstractString) where {F<:AbstractFlavor} = parse(F, x)

@static if Sys.iswindows()  # Windows cannot round properly
    function atomic(::Type{F}, x::S) where {T, S, F<:AbstractFlavor{T}}
        isinf(x) && return wideinterval(F, T(x))

        F( parse(T, string(x), RoundDown),
           parse(T, string(x), RoundUp) )
    end

    function atomic(::Type{F}, x::Union{Irrational, Rational}) where {T, F<:AbstractFlavor{T}}
        isinf(x) && return wideinterval(F, T(x))

        F( T(x, RoundDown), T(x, RoundUp) )
        # the rounding up could be done as nextfloat of the rounded down one?
        # use @round_up and @round_down here?
    end

else
    function atomic(::Type{F}, x::S) where {T, S, F <: AbstractFlavor{T}}
        isinf(x) && return wideinterval(F, T(x))

        F( T(x, RoundDown), T(x, RoundUp) )
        # the rounding up could be done as nextfloat of the rounded down one?
        # use @round_up and @round_down here?
    end
end

function atomic(::Type{F}, x::S) where {T, S<:AbstractFloat, F<:AbstractFlavor{T}}
    isinf(x) && return wideinterval(F, x)

    xrat = rationalize(x)

    # This prevents that xrat returns a 0//1 when x is very small
    # or 1//0 when x is too large but finite
    if (x != zero(x) && xrat == 0) || isinf(xrat)
        xstr = string(x)
        return F(parse(T, xstr, RoundDown), parse(T, xstr, RoundUp))
    end

    return atomic(F, xrat)
end

function atomic(::Type{F}, x::Irrational{S}) where {T, S, F<:AbstractFlavor{Irrational{T}}}
    Flavor = flavortype(F)
    return atomic(F{Float64}, x)
end

atomic(::Type{F}, x::AbstractFlavor) where {T, F<:AbstractFlavor{T}} =
    F( T(inf(x), RoundDown), T(sup(x), RoundUp) )

# Complex numbers:
# TODO This one doesn't return an interval, not sure what it's suppose do do
# atomic(::Type{Interval{T}}, x::Complex{Bool}) where T<:AbstractFloat =
#     (x == im) ? one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function atomic(::Type{F}, x::Irrational) where {T<:Integer, F<:AbstractFlavor{Rational{T}}}
    Flavor = flavortype(F)
    a = float(atomic(Flavor{BigFloat}, x))
    atomic(F, a)
end

atomic(::Type{F}, x::S) where {T<:Integer, S<:Union{Integer, Rational}, F<:AbstractFlavor{Rational{T}}} =
    F(convert(Rational{T}, x))

atomic(::Type{F}, x::S) where {T<:Integer, S<:AbstractFloat, F<:AbstractFlavor{Interval{Rational{T}}}} =
    F(rationalize(T, x))
