# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Promotion

## Promotion rules

# Avoid ambiguity with ForwardDiff:

promote_rule{T<:Real, N, R<:Real}(::Type{Interval{T}},
    ::Type{ForwardDiff.Dual{N,R}}) = ForwardDiff.Dual{N, Interval{promote_type(T,R)}}


promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{S}) =
    Interval{promote_type(T, S)}

promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) =
    Interval{promote_type(T, BigFloat)}


## Conversion rules

# convert{T<:Real}(::Type{Interval}, x::T) = convert(Interval{Float64}, x)

doc"""
`split_interval_string` deals with strings of the form `"[3.5, 7.2]"`
"""
function split_interval_string(T, x::AbstractString)
    if !(contains(x, "["))  # string like "3.1"
        return @round(parse(T, x), parse(T, x))
    end

    m = match(r"\[(.*),(.*)\]", x)  # string like "[1, 2]"

    if m == nothing
        throw(ArgumentError("Unable to process string $x as interval"))
    end

    @round(parse(T, m.captures[1]), parse(T, m.captures[2]))
end


# Floating point intervals:

convert{T<:AbstractFloat}(::Type{Interval{T}}, x::AbstractString) =
    split_interval_string(T, x)

function convert{T<:AbstractFloat, S<:Real}(::Type{Interval{T}}, x::S)
    Interval{T}( T(x, RoundDown), T(x, RoundUp) )
    # the rounding up could be down as nextfloat of the rounded down one
end

function convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Float64)
    II = convert(Interval{T}, rationalize(x))
    # This prevents that rationalize(x) returns a zero when x is very small
    if x != zero(x) && II == zero(Interval{T})
        II = Interval{T}(string(x))
    end
    II
end

function convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Interval)
    Interval{T}( T(x.lo, RoundDown), T(x.hi, RoundUp) )
end


# Complex numbers:
convert{T<:AbstractFloat}(::Type{Interval{T}}, x::Complex{Bool}) = (x == im) ?
    one(T)*im : throw(ArgumentError("Complex{Bool} not equal to im"))


# Rational intervals
function convert(::Type{Interval{Rational{Int}}}, x::Irrational)
    a = float(convert(Interval{BigFloat}, x))
    convert(Interval{Rational{Int}}, a)
end

function convert(::Type{Interval{Rational{BigInt}}}, x::Irrational)
    a = convert(Interval{BigFloat}, x)
    convert(Interval{Rational{BigInt}}, a)
end

convert{T<:Integer, S<:Integer}(::Type{Interval{Rational{T}}}, x::S) =
    Interval(x*one(Rational{T}))

convert{T<:Integer, S<:Integer}(::Type{Interval{Rational{T}}}, x::Rational{S}) =
    Interval(x*one(Rational{T}))

convert{T<:Integer, S<:Float64}(::Type{Interval{Rational{T}}}, x::S) =
    Interval(rationalize(T, x))

convert{T<:Integer, S<:BigFloat}(::Type{Interval{Rational{T}}}, x::S) =
    Interval(rationalize(T, x))
