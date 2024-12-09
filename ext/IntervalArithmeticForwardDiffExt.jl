module IntervalArithmeticForwardDiffExt

using IntervalArithmetic, ForwardDiff
using ForwardDiff: Dual, Partials, ≺, value, partials

# Needed to avoid method ambiguities:
ForwardDiff.can_dual(::Type{ExactReal}) = true
Dual(x::ExactReal) = Dual{Nothing, typeof(x), 0}(x.value)
Dual{T}(x::ExactReal) where {T} = Dual{T, typeof(x), 0}(x.value)
Dual{T, V}(x::ExactReal) where {T, V<:Real} = convert(Dual{T, V, 0}, x)
Dual{T, V, N}(x::ExactReal) where {T, V<:Real, N} = convert(Dual{T, V, N}, x)

Base.convert(::Type{Dual{T,V,N}}, x::ExactReal) where {T,V,N} = Dual{T}(V(x), zero(Partials{N,V}))

Base.promote_rule(::Type{Dual{T, V, N}}, ::Type{Interval{S}}) where {T, V, N, S<:Union{AbstractFloat, Rational}} =
    Dual{T,Interval{IntervalArithmetic.promote_numtype(V, S)},N}
Base.promote_rule(::Type{Interval{S}}, ::Type{Dual{T, V, N}}) where {S<:Union{AbstractFloat, Rational}, T, V, N} =
    Dual{T,Interval{IntervalArithmetic.promote_numtype(V, S)},N}
Base.promote_rule(::Type{ExactReal{S}}, ::Type{Dual{T, V, N}}) where {S<:Real, T, V, N} =
    Dual{T,ExactReal{IntervalArithmetic.promote_numtype(V, S)},N}
Base.promote_rule(::Type{Dual{T, V, N}}, ::Type{ExactReal{S}}) where {S<:Real, T, V, N} =
    Dual{T,ExactReal{IntervalArithmetic.promote_numtype(V, S)},N}

Base.:(==)(x::Union{BareInterval,Interval}, y::Dual) = isthin(x, y)
Base.:(==)(x::Dual, y::Union{BareInterval,Interval}) = y == x


function Base.:(^)(x::Dual{Txy,<:Interval}, y::Dual{Txy,<:Interval}) where {Txy}
    vx, vy = value(x), value(y)
    expv = vx^vy
    powval = vy * vx^(vy - interval(1))
    if all(isthinzero, values(partials(y)))
        return Dual{Txy}(expv, ForwardDiff._mul_partials(partials(x), partials(y), powval, one(expv)))
    elseif isthinzero(vx) && inf(vy) > 0
        return Dual{Txy}(expv, ForwardDiff._mul_partials(partials(x), partials(y), powval, zero(vx)))
    else
        return Dual{Txy}(expv, ForwardDiff._mul_partials(partials(x), partials(y), powval, expv * log(vx)))
    end
end

function Base.:(^)(x::Dual{Tx,<:Interval}, y::Dual{Ty,<:Interval}) where {Tx,Ty}
    if Ty ≺ Tx
        return x^value(y)
    else
        return value(x)^y
    end
end

function Base.:(^)(x::Dual{Tx,<:Interval}, y::Interval) where {Tx}
    v = value(x)
    expv = v^y
    if isthinzero(y) || all(isthinzero, values(partials(x)))
        return Dual{Tx}(expv, zero(partials(x)))
    else
        return Dual{Tx}(expv, partials(x) * y * v^(y - interval(1)))
    end
end

function Base.:(^)(x::Interval, y::Dual{Ty,<:Interval}) where {Ty}
    v = value(y)
    expv = x^v
    if isthinzero(x) && inf(v) > 0
        return Dual{Ty}(expv, zero(expv) * partials(y))
    else
        return Dual{Ty}(expv, expv * log(x) * partials(y))
    end
end

Base.:(^)(x::Dual{<:Any,I}, y::ExactReal) where {I<:Interval} = x^convert(I, y)

Base.:(^)(x::ExactReal, y::Dual{<:Any,I}) where {I<:Interval} = convert(I, x)^y

function Base.:(^)(x::Dual{Tx}, y::ExactReal) where {Tx}
    v = value(x)
    expv = v^y
    if iszero(y.value) || all(iszero, values(partials(x)))
        return Dual{Tx}(expv, zero(partials(x)))
    else
        return Dual{Tx}(expv, partials(x) * y * v^(y - 1))
    end
end

function Base.:(^)(x::ExactReal, y::Dual{<:Ty}) where {Ty}
    v = value(y)
    expv = x^v
    if iszero(x) && inf(v) > 0
        return Dual{Ty}(expv, zero(expv) * partials(y))
    else
        return Dual{Ty}(expv, expv * log(x) * partials(y))
    end
end

end
