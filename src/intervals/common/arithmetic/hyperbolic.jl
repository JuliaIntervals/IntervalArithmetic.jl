# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Hyperbolic functions"
    in the IEEE standard (sections 9.1).
=#

for f in (:sinh, :cosh, :tanh, :asinh)
    @eval begin
        function ($f)(a::F) where {F<:AbstractFlavor}
            isempty(a) && return a
        
            return @round(F, ($f)(a.lo), ($f)(a.hi))
        end

        docstring = """
            $f(a::AbstractFlavor)
        
        Corresponds to the IEEE standard `$f` function (Table 9.1).
        """

        @doc ($f) docstring
    end 
end

"""
    acosh(a::AbstractFlavor)

Corresponds to the IEEE standard `acosh` function (Table 9.1).
"""
function acosh(a::F) where {F<:AbstractFlavor}
    domain = F(1, Inf)
    a = a ∩ domain
    isempty(a) && return a

    return @round(F, acosh(a.lo), acosh(a.hi))
end

"""
    atanh(a::AbstractFlavor)

Corresponds to the IEEE standard `atanh` function (Table 9.1).
"""
function atanh(a::F) where {F<:AbstractFlavor}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    res_lo = @round_down(atanh(a.lo))
    res_hi = @round_up(atanh(a.hi))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞) for set based intervals
    # TODO check for flavor dependent behavior
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)

    return F(res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :asinh, :acosh, :atanh)
    @eval function ($f)(a::F) where {F<:AbstractFlavor{Float64}}
        isempty(a) && return a

        return atomic(F, ($f)(big53(a)) )
    end
end
