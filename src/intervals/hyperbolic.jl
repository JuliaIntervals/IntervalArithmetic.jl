# This file is part of the IntervalArithmetic.jl package; MIT licensed


function sinh{T}(a::Interval{T})
    isempty(a) && return a

    return @round(sinh(a.lo), sinh(a.hi))
end

function cosh{T}(a::Interval{T})
    isempty(a) && return a

    return @round(cosh(mig(a)), cosh(mag(a)))
end

# function tanh(a::Interval{Float64})
#     isempty(a) && return a
#
#     float(tanh(big53(a)))
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
    domain = Interval(one(eltype(a)), Inf)
    a = a ∩ domain
    isempty(a) && return a

    return @round(acosh(a.lo), acosh(a.hi))
end


function atanh(a::Interval{BigFloat})
    domain = Interval(-one(eltype(a)), one(eltype(a)))
    a = a ∩ domain

    isempty(a) && return a

    res_lo = @round_down(atanh(a.lo))
    res_hi = @round_up(atanh(a.hi))

    # The IEEE Std 1788-2015 does not allow intervals like of the
    # form Interval(∞,∞) and Interval(-∞,-∞)
    (res_lo == res_hi == Inf || res_lo == res_hi == -Inf) && return emptyinterval(a)  # IEEE 1788-2015 does not allow intervals consisting only of ∞, i.e. Interval(∞,∞) and Interval(-∞,-∞)

    return Interval(res_lo, res_hi)
end

# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :asinh, :acosh, :atanh)

    @eval function ($f)(a::Interval{Float64})
        isempty(a) && return a

        convert(Interval{Float64}, ($f)(big53(a)) )
    end
end
