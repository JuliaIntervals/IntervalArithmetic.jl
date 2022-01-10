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

function atomic(::Type{F}, x) where {T, F<:Interval{T}}
    return Interval(T(x, RoundDown), T(x, RoundUp))
end

function atomic(::Type{F}, x::AbstractFloat) where {T, F<:Interval{T}}
    lo = T(x, RoundDown)
    hi = T(x, RoundUp)
    if x == lo
        lo = prevfloat(lo)
    end
    if x == hi
        hi = nextfloat(hi)
    end
    return Interval(lo, hi)
end

function atomic(::Type{F}, x::Interval) where {T, F<:Interval{T}}
    return Interval(T(x.lo, RoundDown), T(x.hi, RoundUp))
end

"""
    widen(x)

Widen the lowest and highest bounds of `x` to the previous and next representable
floating-point numbers, respectively.
"""
widen(x::F) where {T<:AbstractFloat, F<:Interval{T}} =
    F(prevfloat(inf(x)), nextfloat(sup(x)))

"""
    wideinterval(x::AbstractFloat)
    wideinterval(::Interval, x::AbstractFloat)

Returns the interval `[prevfloat(x), nextfloat(x)]`.

Note that if no interval flavor is given, the returned interval is of the
default interval flavor. See the documentation of `Interval` for more
information about the default interval falvor.
"""
wideinterval(::Type{F}, x::T) where {F<:Interval, T<:AbstractFloat} =
    F(prevfloat(x), nextfloat(x))
wideinterval(x::T) where {T<:AbstractFloat} = wideinterval(Interval, x)

"""
    big53(x::Interval{Float64})

Create an equivalent `BigFloat` interval to a given `Float64` interval.
"""
function big53(a::Interval{Float64})
    setprecision(BigFloat, 53) do  # precision of Float64
        return atomic(Interval{BigFloat}, a)
    end
end

"""
    big53(x::Float64)

Convert `x` to `BigFloat`.
"""
function big53(x::Float64)
    setprecision(BigFloat, 53) do
        return BigFloat(x)
    end
end

function Base.setrounding(f::Function, ::Type{Rational{T}}, 
                          rounding_mode::RoundingMode) where T
    setrounding(f, float(Rational{T}), rounding_mode)
end

float(x::Interval{T}) where T = atomic(Interval{float(T)}, x)
big(x::Interval) = atomic(Interval{BigFloat}, x)