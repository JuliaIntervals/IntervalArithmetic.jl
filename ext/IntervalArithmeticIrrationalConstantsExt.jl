module IntervalArithmeticIrrationalConstantsExt

import IntervalArithmetic as IA
import IrrationalConstants as IC

# Parse expressions defining the constant and use interval arithmetic to
# produce the correctly rounded intervals for the constants.

const _INTERVAL_IRRATIONAL_FUNCS = (:+, :-, :*, :/, :sqrt, :log, :inv)

_intervalize(x) = x
_intervalize(x::Number) = :(IA.bareinterval(BigFloat, $x))
_intervalize(x::Symbol) =
    x in _INTERVAL_IRRATIONAL_FUNCS ? x : :(IA.bareinterval(BigFloat, $x))
function _intervalize(ex::Expr)
    ex.head === :call || return ex
    return Expr(:call, _intervalize(ex.args[1]), map(_intervalize, ex.args[2:end])...)
end

macro interval_irrational(sym, def)
    constant = Expr(:., :IC, QuoteNode(sym))
    interval_def = _intervalize(def)
    return esc(quote
        IA._round(::Type{T}, ::typeof($constant), r::RoundingMode{:Down}) where {T<:IA.NumTypes} =
            IA.__round(T, IA.inf($interval_def), r)
        IA._round(::Type{T}, ::typeof($constant), r::RoundingMode{:Up}) where {T<:IA.NumTypes} =
            IA.__round(T, IA.sup($interval_def), r)
    end)
end

# Unfortunately we cannot extract the expression for the constant from the type,
# so we are essentially forced to repeat IrrationalConstants.jl here.

@interval_irrational twoπ 2 * π
@interval_irrational fourπ 4 * π
@interval_irrational halfπ π / 2
@interval_irrational quartπ π / 4

@interval_irrational invπ 1 / π
@interval_irrational inv2π 1 / (2 * π)
@interval_irrational inv4π 1 / (4 * π)
@interval_irrational fourinvπ 4 / π
@interval_irrational twoinvπ 2 / π

@interval_irrational sqrt2 sqrt(2)
@interval_irrational sqrt3 sqrt(3)
@interval_irrational sqrtπ sqrt(π)
@interval_irrational sqrt2π sqrt(2 * π)
@interval_irrational sqrt4π sqrt(4 * π)
@interval_irrational sqrthalfπ sqrt(π / 2)

@interval_irrational invsqrt2 1 / sqrt(2)
@interval_irrational invsqrtπ 1 / sqrt(π)
@interval_irrational invsqrt2π 1 / sqrt(2 * π)

@interval_irrational logtwo log(2)
@interval_irrational logten log(10)
@interval_irrational loghalf log(1 / 2)
@interval_irrational logπ log(π)
@interval_irrational log2π log(2 * π)
@interval_irrational log4π log(4 * π)

end
