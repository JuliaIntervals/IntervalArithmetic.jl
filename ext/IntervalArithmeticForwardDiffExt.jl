module IntervalArithmeticForwardDiffExt

using IntervalArithmetic, ForwardDiff
using ForwardDiff: Dual, ≺, value, partials

function isconstant_interval(x)
    all(isthinzero.(values(partials(x))))
end

function Base.:(^)(x::Dual{Txy, <:Interval}, y::Dual{Txy, <:Interval}) where Txy
    vx, vy = value(x), value(y)
    expv = vx^vy
    powval = vy * vx^(vy - interval(1))
    if isconstant_interval(y)
        logval = one(expv)
    elseif isthinzero(vx) && inf(vy) > 0
        logval = zero(vx)
    else
        logval = expv * log(vx)
    end
    new_partials = ForwardDiff._mul_partials(partials(x), partials(y), powval, logval)
    return Dual{Txy}(expv, new_partials)
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
    expv = v^y
    if isthinzero(y) || isconstant_interval(x)
        new_partials = zero(partials(x))
    else
        new_partials = partials(x) * y * v^(y - interval(1))
    end
    return Dual{Tx}(expv, new_partials)
end

function Base.:(^)(x::Interval, y::Dual{Ty, <:Interval}) where Ty
    v = value(y)
    expv = x^v
    deriv = (isthinzero(x) && inf(v) > 0) ? zero(expv) : expv*log(x)
    return Dual{Ty}(expv, deriv * partials(y))
end

end
