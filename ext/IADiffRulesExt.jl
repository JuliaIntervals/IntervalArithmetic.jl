module IADiffRulesExt

using IntervalArithmetic, DiffRules

function DiffRules._abs_deriv(x::Interval)
    r = sign(bareinterval(x))
    d = decoration(x)
    d = min(d, ifelse(in_interval(0, x), trv, d)) # if `x` contains 0, then `trv` decoration
    return IntervalArithmetic._unsafe_interval(r, d, isguaranteed(x))
end

end
