# This file is part of the ValidatedNumerics.jl package; MIT licensed


function sinh{T}(a::Interval{T})
    isempty(a) && return a
    return Interval(sinh(a.lo, RoundDown), sinh(a.hi, RoundUp))
end

function cosh{T}(a::Interval{T})
    isempty(a) && return a
    return Interval(cosh(mig(a), RoundDown), cosh(mag(a), RoundUp))
end

function tanh(a::Interval{Float64})
    isempty(a) && return a

    to_float(tanh(big53(a)))
end

function tanh(a::Interval{BigFloat})
    isempty(a) && return a
    return @round(BigFloat, tanh(a.lo), tanh(a.hi))
end


function asinh(a::Interval{BigFloat})
    isempty(a) && return a
    @round(BigFloat, asinh(a.lo), asinh(a.hi))
end


function acosh(a::Interval{BigFloat})
    domain = Interval(one(eltype(a)), Inf)
    a = a ∩ domain
    isempty(a) && return a
    @round(BigFloat, acosh(a.lo), acosh(a.hi))
end


function atanh(a::Interval{BigFloat})
    domain = Interval(-one(eltype(a)), one(eltype(a)))
    a = a ∩ domain
    isempty(a) && return a
    @round(BigFloat, atanh(a.lo), atanh(a.hi))
end

# Float64 versions of functions missing from CRlibm:
for f in (:tanh, :asinh, :acosh, :atanh)

    @eval function ($f)(a::Interval{Float64})
        isempty(a) && return a

        to_float(($f)(big53(a)))
    end
end
