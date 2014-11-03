##
## Luis Benet & David P. Sanders
## Universidad Nacional Autónoma de México (UNAM)
##
## Julia module for interval arithmetic
##


## Interval type

immutable Interval{T<:Real} <: Real
    lo :: T
    hi :: T

    function Interval(a::Real, b::Real)

        if a > b
            a, b = b, a
        end

        new(a, b)
    end
end


## Outer constructors

Interval{T<:Real}(a::T,b::T) = Interval{T}(a,b)  # not sure why this is necessary, but it is used in Rational
Interval(a::Interval) = a
Interval(a::Tuple) = Interval(a...)
Interval(a::Real) = Interval(a, a)
Interval{T<:Real, S<:Real}(a::T, b::S) = Interval(promote(a,b)...)


## Convertion and promotion

convert{T<:Real}(::Type{Interval{T}}, x::Interval) = Interval(convert(T,x.lo), convert(T,x.hi))
convert{T<:Real}(::Type{Interval{T}}, x::Real) = Interval(convert(T,x))
promote_rule{T<:Real, S<:Real}(::Type{Interval{T}}, ::Type{Interval{S}}) = Interval{promote_type(T,S)}
promote_rule{T<:Real, A<:Real}(::Type{Interval{T}}, ::Type{A}) = Interval{T}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) = Interval{T}


## Output

function basic_show(io::IO, a::Interval)
    if isempty(a)
        output = "∅"
    else
        output = "[$(a.lo), $(a.hi)]"
        output = replace(output, "inf", "∞")
        output
    end

    print(io, output)
end

show(io::IO, a::Interval) = basic_show(io, a)
show(io::IO, a::Interval{BigFloat}) = ( basic_show(io, a); print(io, " with $(a.lo.prec) bits of precision") )
