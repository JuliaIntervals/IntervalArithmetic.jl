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

function Base.:(^)(x::Dual{<:Any, I}, y::ExactReal) where I<:Interval
    return x^convert(I, y)
end

function Base.:(^)(x::ExactReal, y::Dual{<:Any, I}) where I<:Interval
    return convert(I, x)^y
end

function Base.max(x::Dual{T,V,N}, y::AbstractFloat) where {T,V<:Interval,N}
    if sup(value(x)) < y
        return Dual{T,V,N}(interval(y,y), interval(0,0) * partials(x))
    elseif inf(value(x)) > y
        return Dual{T,V,N}(value(x), interval(1,1) * partials(x))
    else
        return Dual{T,V,N}(interval(y,sup(value(x))), interval(0,1) * partials(x))
    end
end
function Base.max(y::AbstractFloat, x::Dual{T,V,N}) where {T,V<:Interval,N}
    return max(x, y)
end

function Base.max(x::Dual{T,Dual{T2,V2,N2},N}, y::AbstractFloat) where {T,T2,V2<:Interval,N2,N}
    if sup(value(value(x))) < y
        return Dual{T,Dual{T2,V2,N2},N}(Dual{T2,V2,N2}(interval(y,y)), interval(0,0) * partials(x))
    elseif inf(value(value(x))) > y
        return Dual{T,Dual{T2,V2,N2},N}(value(x), interval(1,1) * partials(x))
    else
        return Dual{T,Dual{T2,V2,N2},N}(Dual{T2,V2,N2}(interval(y,sup(value(value(x)))), partials(value(x))), interval(0,1) * partials(x))
    end
end
function Base.max(y::AbstractFloat, x::Dual{T,Dual{T2,V2,N2},N}) where {T,T2,V2<:Interval,N2,N}
    return max(x, y)
end

function Base.min(x::Dual{T,V,N}, y::AbstractFloat) where {T,V<:Interval,N}
    if inf(value(x)) > y
        return Dual{T,V,N}(interval(y,y), interval(0,0) * partials(x))
    elseif sup(value(x)) < y
        return Dual{T,V,N}(value(x), interval(1,1) * partials(x))
    else
        return Dual{T,V,N}(interval(inf(value(x)),y), interval(0,1) * partials(x))
    end
end
function Base.min(y::AbstractFloat, x::Dual{T,V,N}) where {T,V<:Interval,N}
    return min(x, y)
end

function Base.min(x::Dual{T,Dual{T2,V2,N2},N}, y::AbstractFloat) where {T,T2,V2<:Interval,N2,N}
    if inf(value(value(x))) > y
        return Dual{T,Dual{T2,V2,N2},N}(Dual{T2,V2,N2}(interval(y,y)), interval(0,0) * partials(x))
    elseif sup(value(value(x))) < y
        return Dual{T,Dual{T2,V2,N2},N}(value(x), interval(1,1) * partials(x))
    else
        return Dual{T,Dual{T2,V2,N2},N}(Dual{T2,V2,N2}(interval(inf(value(value(x))),y), partials(value(x))), interval(0,1) * partials(x))
    end
end
function Base.min(y::AbstractFloat, x::Dual{T,Dual{T2,V2,N2},N}) where {T,T2,V2<:Interval,N2,N}
    return min(x, y)
end

function Base.clamp(i::Dual{T,V,N}, lo::AbstractFloat, hi::AbstractFloat) where {T,V<:Interval,N}
    return min(max(i, lo), hi)
end

function Base.clamp(i::Dual{T,Dual{T2,V2,N2},N}, lo::AbstractFloat, hi::AbstractFloat) where {T,T2,V2<:Interval,N2,N}
    return min(max(i, lo), hi)
end

end
