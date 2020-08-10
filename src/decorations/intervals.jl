# This file is part of the IntervalArithmetic.jl package; MIT licensed

# Decorated intervals, following the IEEE 1758-2015 standard

"""
    DECORATION

Enumeration constant for the types of interval decorations.
The nomenclature of the follows the IEEE-1788 (2015) standard
(sect 11.2):

- `com -> 4`: common: bounded, non-empty
- `dac -> 3`: defined (nonempty) and continuous
- `def -> 2`: defined (nonempty)
- `trv -> 1`: always true (no information)
- `ill -> 0`: nai ("not an interval")
"""
@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# Note that `isweaklyless`, and hence ``<` and `min`, are automatically defined for enums

abstract type AbstractRealDecoratedInterval{T, F} <: AbstractRealFlavor{T} end
abstract type AbstractNonRealDecoratedInterval{T, F} <: AbstractNonRealFlavor{T} end

"""
    AbstractDecoratedInterval

A *decorated* interval is an interval, together with a *decoration*, i.e.
a flag that records the status of the interval when thought of as the result
of a previously executed sequence of functions acting on an initial interval.
"""
const AbstractDecoratedInterval{T, F} = Union{AbstractRealDecoratedInterval{T, F}, AbstractNonRealDecoratedInterval{T, F}}

decoratedtypes = [(:RealDecoratedInterval, AbstractRealFlavor, AbstractRealDecoratedInterval),
                  (:NonRealDecoratedInterval, AbstractNonRealFlavor, AbstractNonRealDecoratedInterval)]

for (DecoratedFlavor, InnerFlavor, Supertype) in decoratedtypes
    decorateddef = quote
        struct $DecoratedFlavor{T, F<:$InnerFlavor{T}} <: $Supertype{T, F}
            interval::F
            decoration::DECORATION

            function $DecoratedFlavor{T, F}(I::F, d::DECORATION) where {T, F<:$InnerFlavor{T}}
                dd = decoration(I)
                dd <= trv && return new{T, F}(I, dd)
                d == ill && return new{T, F}(nai(I), d)
                return new{T, F}(I, d)
            end
        end

        $DecoratedFlavor(I::F, d::DECORATION) where {T, F<:$InnerFlavor{T}} =
            DecoratedInterval{T, F}(I, d)

        $DecoratedFlavor(I::AbstractDecoratedInterval, dec::DECORATION) = $DecoratedFlavor(I.interval, dec)

        # Automatic decorations for an interval
        $DecoratedFlavor(I::AbstractFlavor) = DecoratedInterval(I, decoration(I))
    end

    @eval $decorateddef
end


# DecoratedInterval
if Interval <: AbstractRealFlavor
    const DecoratedInterval = RealDecoratedInterval
else
    const DecoratedInterval = NonRealDecoratedInterval
end
defaultdoc = """
    DecoratedInterval

Default type of decorated interval, currently set to `$DecoratedInterval`.

Not that the inner interval is of the default interval type. See the documentation
of `Interval` for more information about the default interval type.
"""
@doc defaultdoc DecoratedInterval

function DecoratedInterval(a::T, b::T, d::DECORATION) where {T<:Real}
    a > b && return DecoratedInterval(nai(T), ill)
    DecoratedInterval(Interval(a, b), d)
end

DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(a..., d)

DecoratedInterval(a::T, b::S, d::DECORATION) where {T<:Real, S<:Real} =
    DecoratedInterval(promote(a, b)..., d)

DecoratedInterval(a::T, d::DECORATION) where {T<:Real} =
    DecoratedInterval(Interval(a, a), d)

function DecoratedInterval(a::T, b::T) where {T<:Real}
    a > b && return DecoratedInterval(nai(T), ill)
    DecoratedInterval(Interval(a, b))
end

DecoratedInterval(a::T, b::T) where {T<:Integer} =
    DecoratedInterval(float(a),float(b))

DecoratedInterval(a::T) where {T<:Real} = DecoratedInterval(Interval(a, a))

DecoratedInterval(a::T, b::S) where {T<:Real, S<:Real} =
    DecoratedInterval(promote(a, b)...)

DecoratedInterval(a::Tuple) = DecoratedInterval(a...)

interval(x::AbstractDecoratedInterval) = x.interval
decoration(x::AbstractDecoratedInterval) = x.decoration

# Automatic decorations for an Interval
function decoration(I::AbstractFlavor)
    isnai(I) && return ill           # nai()
    isempty(I) && return trv         # emptyinterval
    isunbounded(I) && return dac     # unbounded
    com                              # common
end

# Promotion and conversion, and other constructors

promote_rule(::Type{D}, ::Type{S}) where {T<:Real, S<:Real, F<:AbstractFlavor{T}, D<:AbstractDecoratedInterval{T, F}} =
    D{promote_type(T, S), F}

promote_rule(::Type{DecoratedInterval{T}}, ::Type{DecoratedInterval{S}}) where
    {T<:Real, S<:Real} = DecoratedInterval{promote_type(T, S)}

convert(::Type{DecoratedInterval{T}}, x::S) where {T<:Real, S<:Real} =
    DecoratedInterval( Interval(T(x, RoundDown), T(x, RoundUp)) )

convert(::Type{DecoratedInterval{T}}, x::S) where {T<:Real, S<:Integer} =
    DecoratedInterval( Interval(T(x), T(x)) )

function convert(::Type{DecoratedInterval{T}}, xx::DecoratedInterval) where {T<:Real}
    x = interval(xx)
    x = atomic(Interval{T},x)
    DecoratedInterval( x, decoration(xx) )
end

convert(::Type{DecoratedInterval{T}}, x::AbstractString) where {T<:AbstractFloat} =
    parse(DecoratedInterval{T}, x)

big(x::DecoratedInterval) = DecoratedInterval(big(interval(x)), decoration(x))

macro decorated(ex...)
    if(!(ex[1] isa String))
        local x

        if length(ex) == 1
            x = :(@interval($(esc(ex[1]))))
        else
            x = :($(esc(ex[1])), $(esc(ex[2])))
        end

        :(DecoratedInterval($x))
    else
        s = ex[1]
        parse(DecoratedInterval{Float64}, s)
    end
end
