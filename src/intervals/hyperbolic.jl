# This file is part of the IntervalArithmetic.jl package; MIT licensed


function sinh(a::Interval)
    isempty(a) && return a

    return @round(sinh(a.lo), sinh(a.hi))
end

function cosh(a::Interval)
    isempty(a) && return a

    return @round(cosh(mig(a)), cosh(mag(a)))
end

# function tanh(a::Interval{Float64})
#     isempty(a) && return a
#
#     float(tanh(bigequiv(a)))
# end

function tanh(a::Interval{BigFloat})
    isempty(a) && return a

    return @round(tanh(a.lo), tanh(a.hi))
end


function asinh(a::Interval{BigFloat})
    isempty(a) && return a

    return @round(asinh(a.lo), asinh(a.hi))
end


function acosh(a::Interval{BigFloat})
    domain = Interval(one(BigFloat), Inf)
    a = a ∩ domain
    isempty(a) && return a

    return @round(acosh(a.lo), acosh(a.hi))
end


function atanh(a::Interval{BigFloat})
    domain = Interval(-one(BigFloat), one(BigFloat))
    a = a ∩ domain

    isempty(a) && return a

    res_lo = @round_down(atanh(a.lo))
    res_hi = @round_up(atanh(a.hi))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞)
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)  # IEEE 1788-2015 does not allow intervals consisting only of ∞, i.e. Interval(∞,∞) and Interval(-∞,-∞)

    return Interval(res_lo, res_hi)
end

coth(a::Interval{BigFloat}) = 1/tanh(a)

csch(a::Interval{BigFloat}) = 1/sinh(a)

sech(a::Interval{BigFloat}) = 1/cosh(a)
# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :asinh, :acosh, :atanh, :coth, :csch, :sech)

    @eval function ($f)(a::Interval{T}) where T
        isempty(a) && return a

        atomic(Interval{T}, ($f)(bigequiv(a)) )
    end
end
