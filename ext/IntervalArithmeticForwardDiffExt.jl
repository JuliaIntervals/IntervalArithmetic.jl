module IntervalArithmeticForwardDiffExt

using IntervalArithmetic, ForwardDiff
using ForwardDiff: Dual, ≺, value, partials

function Base.:(^)(x::Dual{Txy, <:Interval}, y::Dual{Txy, <:Interval}) where Txy
    vx, vy = value(x), value(y)
    primal = vx^vy
    powval = vy * vx^(vy - interval(1))
    logval = primal * log(vx)
    new_partials = _mul_partials(partials(x), partials(y), powval, logval)
    return Dual{Txy}(primal, new_partials)
end

function Base.:(^)(x::Dual{Tx, <:Interval}, y::Dual{Ty, <:Interval}) where {Tx, Ty}
    if Ty ≺ Tx 
        return x^value(y)
    else
        return value(x)^y
    end
end

function Base.:(^)(x::Dual{Tx, <:Interval}, y::Interval) where Tx
    v = value(x)
    new_partials = partials(x) * y * v^(y - interval(1))
    return Dual{Tx}(v^y, new_partials)
end

function Base.:(^)(x::Interval, y::Dual{Ty, <:Interval}) where Ty
    v = value(y)
    primal = x^v
    deriv = primal*log(x)
    return Dual{Ty}(primal, deriv * partials(y))
end

end
