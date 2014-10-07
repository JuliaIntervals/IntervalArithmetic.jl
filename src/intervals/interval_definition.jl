##
## Last modification: 1 Oct 2014
## Luis Benet & David P. Sanders
## Universidad Nacional Autónoma de México (UNAM)
##
## Julia module for handling interval arithmetic
##


## Interval constructor
immutable Interval <: Real
    lo :: Real
    hi :: Real

    function Interval(a::Real, b::Real)

        if a > b
            a, b = b, a
        end

        new(a, b)
    end
end

Interval(a::Interval) = a
Interval(a::Tuple) = Interval(a...)
Interval(a::Real) = Interval(a, a)

# Convertion and promotion

convert(::Type{Interval}, x::Real) = Interval(x)
promote_rule{A<:Real}(::Type{Interval}, ::Type{A}) = Interval
promote_rule(::Type{BigFloat}, ::Type{Interval}) = Interval


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
