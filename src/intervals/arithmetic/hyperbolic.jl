# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Hyperbolic functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3.
=#
for f in (:sinh, :tanh, :asinh)
    @eval begin
        """
            $($f)(a::Interval)
        
        Implement the `$($f)` function of the IEEE Std 1788-2015 (Table 9.1).
        """
        function ($f)(a::F) where {F<:Interval}
            isempty(a) && return a
            return @round(F, ($f)(a.lo), ($f)(a.hi))
        end
    end 
end

"""
    cosh(a::Interval)

Implement the `cosh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function cosh(a::F) where {F<:Interval}
    isempty(a) && return a

    return @round(F, cosh(mig(a)), cosh(mag(a)))
end

"""
    acosh(a::Interval)

Implement the `acosh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function acosh(a::F) where {F<:Interval}
    domain = F(1, Inf)
    a = a ∩ domain
    isempty(a) && return a

    return @round(F, acosh(a.lo), acosh(a.hi))
end

"""
    atanh(a::Interval)

Implement the `atanh` function of the IEEE Std 1788-2015 (Table 9.1).
"""
function atanh(a::F) where {F<:Interval}
    domain = F(-1, 1)
    a = a ∩ domain

    isempty(a) && return a

    res_lo = @round_down(atanh(a.lo))
    res_hi = @round_up(atanh(a.hi))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞) for set based intervals
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)

    return F(res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :asinh, :acosh, :atanh)
    @eval function ($f)(a::F) where {F<:Interval{Float64}}
        isempty(a) && return a

        return atomic(F, ($f)(big53(a)) )
    end
end
