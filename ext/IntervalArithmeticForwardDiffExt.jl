module IntervalArithmeticForwardDiffExt

using IntervalArithmetic, ForwardDiff
using IntervalArithmetic: isempty_domain, overlap_domain, intersect_domain, in_domain, leftof
using ForwardDiff: Dual, Partials, ≺, value, partials

ForwardDiff.can_dual(::Type{ExactReal}) = true

# needed to resolve method ambiguities
ForwardDiff.Dual{T}(value::ExactReal) where {T} = Dual{T}(value, ())
ForwardDiff.Dual(value::ExactReal) = Dual{Nothing}(value)
ForwardDiff.Dual{T,V,N}(x::ExactReal) where {T,V,N} = convert(Dual{T,V,N}, x)
ForwardDiff.Dual{T,V}(x::ExactReal) where {T,V} = convert(Dual{T,V}, x)

Base.convert(::Type{Dual{T,V,N}}, x::ExactReal) where {T,V,N} = Dual{T}(V(x), zero(Partials{N,V}))

Base.promote_rule(::Type{Dual{T, V, N}}, ::Type{Interval{S}}) where {T, V, N, S<:IntervalArithmetic.NumTypes} =
    Dual{T,Interval{IntervalArithmetic.promote_numtype(V, S)},N}
Base.promote_rule(::Type{Interval{S}}, ::Type{Dual{T, V, N}}) where {S<:IntervalArithmetic.NumTypes, T, V, N} =
    Dual{T,Interval{IntervalArithmetic.promote_numtype(V, S)},N}
Base.promote_rule(::Type{ExactReal{S}}, ::Type{Dual{T, V, N}}) where {S<:Real, T, V, N} =
    Dual{T,ExactReal{IntervalArithmetic.promote_numtype(V, S)},N}
Base.promote_rule(::Type{Dual{T, V, N}}, ::Type{ExactReal{S}}) where {S<:Real, T, V, N} =
    Dual{T,ExactReal{IntervalArithmetic.promote_numtype(V, S)},N}

Base.:(==)(x::Interval, y::Dual) = x == value(y)
Base.:(==)(x::Dual, y::Interval) = value(x) == y
Base.:<(x::Interval, y::Dual) = x < value(y)
Base.:<(x::Dual, y::Interval) = value(x) < y

# ForwardDiff's rules for `^` use `iszero(partials(x))`, `iszero(x)` and `y > 0`,
# which are undecidable for non-thin intervals, and they compute `y - 1` in the
# type of `y`. The rules below are ForwardDiff's, with thin-zero tests and an
# enclosure of `y - 1`. `NestedInterval` supports intervals nested in up to four
# `Dual` layers.
const NestedInterval = let
    U = Interval
    for _ in 1:4
        U = Union{U, Dual{T,<:U} where {T}}
    end
    U
end

_isthinzero(x::Interval) = isthinzero(x)
_isthinzero(x::Real) = iszero(x)
_isthinzero(d::Dual) = _isthinzero(value(d)) && all(_isthinzero, partials(d))

# interval at the core of nested duals
_interval(x::Interval) = x
_interval(d::Dual) = _interval(value(d))

# `y` as the interval it is promoted to in an operation with `x`
_promote(x, y) = convert(promote_type(typeof(_interval(x)), typeof(y)), y)

# enclosure of `y - 1`, where `x` is the base
_decrement(x, y::Union{Interval,Dual,Integer,Rational}) = y - exact(1)
_decrement(x, y::Union{AbstractFloat,Irrational}) = _promote(x, y) - exact(1)

# `x^y` where only `x` carries the partials
function _pow_x(x::Dual{Tx}, y) where {Tx}
    v = value(x)
    expv = v^y
    if _isthinzero(y) || all(_isthinzero, values(partials(x)))
        return Dual{Tx}(expv, zero(partials(x)) * y) # `y` passes on its NG flag
    else
        return Dual{Tx}(expv, partials(x) * y * v^_decrement(x, y))
    end
end

# `x^y` where only `y` carries the partials
function _pow_y(x, y::Dual{Ty}) where {Ty}
    v = value(y)
    expv = x^v
    if _isthinzero(x) && inf(_interval(v)) > 0
        return Dual{Ty}(expv, zero(expv) * partials(y))
    else
        return Dual{Ty}(expv, expv * log(x) * partials(y))
    end
end

function Base.:(^)(x::Dual{Txy,<:NestedInterval}, y::Dual{Txy,<:NestedInterval}) where {Txy}
    vx, vy = value(x), value(y)
    expv = vx^vy
    powval = vy * vx^_decrement(vx, vy)
    if all(_isthinzero, values(partials(y)))
        logval = one(expv)
    elseif _isthinzero(vx) && inf(_interval(vy)) > 0
        logval = zero(vx)
    else
        logval = expv * log(vx)
    end
    return Dual{Txy}(expv, ForwardDiff._mul_partials(partials(x), partials(y), powval, logval))
end

Base.:(^)(x::Dual{Tx,<:NestedInterval}, y::Dual{Ty,<:NestedInterval}) where {Tx,Ty} =
    Ty ≺ Tx ? _pow_x(x, y) : _pow_y(x, y)

# A `y::Real` method would be ambiguous with ForwardDiff's generated `^`
# methods and its `Dual^Dual` tag methods, so define the relevant concrete
# exponent types instead.
for R in (:Interval, :Integer, :Rational, :AbstractFloat, :Irrational)
    @eval Base.:(^)(x::Dual{Tx,<:NestedInterval}, y::$R) where {Tx} = _pow_x(x, y)
end

Base.:(^)(x::Interval, y::Dual{Ty,<:NestedInterval}) where {Ty} = _pow_y(x, y)

Base.:(^)(x::Dual{<:Any,<:NestedInterval}, y::ExactReal) = x^_promote(x, y)

Base.:(^)(x::ExactReal, y::Dual{<:Any,<:NestedInterval}) = _promote(y, x)^y

# Piecewise functions

# a constant piece (e.g. `@exact Returns(value)`) returns a real instead of a `Dual`,
# which is the same value with vanishing partials
_piece_dual(out::Dual, ::Dual{T,Interval{S}}) where {T,S} = out
_piece_dual(out::Real, dual::Dual{T,Interval{S}}) where {T,S} =
    Dual{T}(interval(S, out), zero(partials(dual)))

function (piecewise::Piecewise)(dual::Dual{T,<:Interval}) where {T}
    X = value(dual)
    input_domain = Domain(X)
    if !overlap_domain(input_domain, piecewise)
        return Dual{T}(emptyinterval(X), emptyinterval(X) .* partials(dual))
    end

    if !in_domain(input_domain, piecewise)
        dec = trv
    elseif any(x -> in_domain(x, input_domain), discontinuities(piecewise, 1))
        dec = def
    else
        dec = com
    end

    dual_piece_outputs = []
    for (piece_domain, f) in pieces(piecewise)
        piece_input = intersect_domain(input_domain, piece_domain)
        isempty_domain(piece_input) && continue
        sub_X = interval(inf(piece_input), sup(piece_input), decoration(X))
        sub_dual = Dual{T}(sub_X, partials(dual))
        push!(dual_piece_outputs, _piece_dual(f(sub_dual), sub_dual))
    end

    piece_outputs = value.(dual_piece_outputs)
    dec = min(dec, minimum(decoration.(piece_outputs)))
    primal = IntervalArithmetic.setdecoration(reduce(hull, piece_outputs), dec)

    doutputs = partials.(dual_piece_outputs)
    partial = map(zip(doutputs...)) do pp
        pdec = min(dec, minimum(decoration.(pp)))
        return IntervalArithmetic.setdecoration(reduce(hull, pp), pdec)
    end

    return Dual{T}(primal, tuple(partial...))
end

#

ForwardDiff.DiffRules._abs_deriv(x::Dual{T,<:Interval}) where {T} =
    Dual{T}(ForwardDiff.DiffRules._abs_deriv(value(x)), zero(partials(x)))

end
