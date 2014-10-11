##
## Last modification: 1 Oct 2014
## Luis Benet & David P. Sanders
## Universidad Nacional Autónoma de México (UNAM)
##
## Julia module for handling interval arithmetic
##


## Interval constructor
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

Interval{T<:Real}(a::T,b::T) = Interval{T}(a,b)  # not sure why this is necessary, but it is used in Rational
Interval(a::Interval) = a
Interval(a::Tuple) = Interval(a...)
Interval(a::Real) = Interval(a, a)

# Convertion and promotion

convert{T<:Real}(::Type{Interval{T}}, x::Real) = Interval(convert(T,x))
promote_rule{T<:Real, A<:Real}(::Type{Interval{T}}, ::Type{A}) = Interval{T}
promote_rule{T<:Real}(::Type{BigFloat}, ::Type{Interval{T}}) = Interval{T}


## Output
function show(io::IO, a::Interval)
    lo = a.lo
    hi = a.hi

    print(io, "[$(a.lo), $(a.hi)]")

    if typeof(a.lo) == typeof(a.hi) == BigFloat
        prec = a.lo.prec
        print(io, " with $prec bits of precision")
    end

end


# end    # this end is required if Intervals.jl is a module on its own
