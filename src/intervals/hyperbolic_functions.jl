# This file is part of the ValidatedNumerics.jl package; MIT licensed


function sinh(a::Interval{Float64})
    isempty(a) && return a
    return Interval(sinh(a.lo, RoundDown), sinh(a.hi, RoundUp))
end

function sinh(a::Interval{BigFloat})
    isempty(a) && return a
    return @controlled_round(BigFloat, sinh(a.lo), sinh(a.hi))
end


function cosh(a::Interval{Float64})
    isempty(a) && return a
    return Interval(cosh(mig(a), RoundDown), cosh(mag(a), RoundUp))
end

function cosh(a::Interval{BigFloat})
    isempty(a) && return a
    return @controlled_round(BigFloat, cosh(mig(a)), cosh(mag(a)))
end


function tanh(a::Interval{Float64})
    isempty(a) && return a
    res = with_bigfloat_precision(53) do
        aa = Interval(big(a.lo), big(a.hi))
        float( tanh(aa) )
    end
    return res
end

function tanh(a::Interval{BigFloat})
    isempty(a) && return a
    return @controlled_round(BigFloat, tanh(a.lo), tanh(a.hi))
end


function asinh(a::Interval{Float64})
    isempty(a) && return a
    res = with_bigfloat_precision(53) do
        aa = Interval(big(a.lo), big(a.hi))
        float( asinh(aa) )
    end
    return res
end

function asinh(a::Interval{BigFloat})
    isempty(a) && return a
    @controlled_round(BigFloat, asinh(a.lo), asinh(a.hi))
end


function acosh(a::Interval{Float64})
    domain = Interval(one(eltype(a)), Inf)
    a = a ∩ domain
    isempty(a) && return a
    res = with_bigfloat_precision(53) do
        aa = Interval(big(a.lo), big(a.hi))
        float( acosh(aa) )
    end
    return res
end

function acosh(a::Interval{BigFloat})
    domain = Interval(one(eltype(a)), Inf)
    a = a ∩ domain
    isempty(a) && return a
    @controlled_round(BigFloat, acosh(a.lo), acosh(a.hi))
end


function atanh(a::Interval{Float64})
    domain = Interval(-one(eltype(a)), one(eltype(a)))
    a = a ∩ domain
    (isempty(a) || abs(a) == one(a)) && return emptyinterval(a)
    res = with_bigfloat_precision(53) do
        aa = Interval(big(a.lo), big(a.hi))
        float( atanh(aa) )
    end
    return res
end

function atanh(a::Interval{BigFloat})
    domain = Interval(-one(eltype(a)), one(eltype(a)))
    a = a ∩ domain
    isempty(a) && return a
    @controlled_round(BigFloat, atanh(a.lo), atanh(a.hi))
end
