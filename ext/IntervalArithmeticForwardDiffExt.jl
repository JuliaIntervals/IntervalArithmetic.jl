module IntervalArithmeticForwardDiffExt

using IntervalArithmetic, ForwardDiff
using IntervalArithmetic: isempty_domain, overlap_domain, intersect_domain, in_domain, leftof
using ForwardDiff: Dual, Partials, ≺, value, partials, DiffRules

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

# ForwardDiff's `^` methods use `iszero(partials(x))`, which is undecidable for
# non-thin intervals. Use a recursive thin-zero test instead. `NestedInterval`
# supports intervals nested in up to four `Dual` layers.
const NestedInterval = let
    U = Interval
    for _ in 1:4
        U = Union{U, Dual{T,<:U} where {T}}
    end
    U
end
_isthinzero(x::Interval) = isthinzero(x)
_isthinzero(x::BareInterval) = isthinzero(x)
_isthinzero(x::Real) = iszero(x)
_isthinzero(d::Dual) = _isthinzero(value(d)) && all(_isthinzero, partials(d))

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

function Base.:(^)(x::Dual{Tx,<:NestedInterval}, y::Interval) where {Tx}
    v = value(x)
    expv = v^y
    if isthinzero(y) || all(_isthinzero, values(partials(x)))
        return Dual{Tx}(expv, zero(partials(x)))
    else
        return Dual{Tx}(expv, partials(x) * y * v^(y - interval(1)))
    end
end

# A `y::Real` method would be ambiguous with ForwardDiff's generated `^`
# methods and its `Dual^Dual` tag methods, so define the relevant concrete
# exponent types instead.
for R in (:Integer, :Rational, :AbstractFloat, :Irrational)
    @eval function Base.:(^)(x::Dual{Tx,<:NestedInterval}, y::$R) where {Tx}
        v = value(x)
        expv = v^y
        if iszero(y) || all(_isthinzero, values(partials(x)))
            return Dual{Tx}(expv, zero(partials(x)))
        else
            return Dual{Tx}(expv, partials(x) * y * v^(y - 1))
        end
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
    if iszero(y.value) || all(_isthinzero, values(partials(x)))
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

# ForwardDiff support for `BareInterval`, which is not a subtype of `Number`.

ForwardDiff.can_dual(::Type{<:BareInterval}) = true

function ForwardDiff.derivative(f::F, x::BareInterval) where {F}
    T = typeof(ForwardDiff.Tag(f, typeof(x)))
    return ForwardDiff.extract_derivative(T, f(Dual{T}(x, Partials((one(x),)))))
end

# Bare intervals nested in up to four `Dual` layers.
const NestedBareInterval = let
    U = BareInterval
    for _ in 1:4
        U = Union{U, Dual{T,<:U} where {T}}
    end
    U
end

# numtype of the bare interval at the center of a nest of `Dual` layers
_numtype_bare(x::BareInterval) = numtype(x)
_numtype_bare(d::Dual) = _numtype_bare(value(d))

Base.:+(d::Dual{T,<:NestedBareInterval}, x::BareInterval) where {T} = Dual{T}(value(d) + x, partials(d))
Base.:+(x::BareInterval, d::Dual{<:Any,<:NestedBareInterval}) = d + x
Base.:-(d::Dual{T,<:NestedBareInterval}, x::BareInterval) where {T} = Dual{T}(value(d) - x, partials(d))
Base.:-(x::BareInterval, d::Dual{T,<:NestedBareInterval}) where {T} = Dual{T}(x - value(d), -partials(d))
Base.:*(d::Dual{T,<:NestedBareInterval}, x::BareInterval) where {T} = Dual{T}(value(d) * x, partials(d) * x)
Base.:*(x::BareInterval, d::Dual{<:Any,<:NestedBareInterval}) = d * x
Base.:/(d::Dual{T,<:NestedBareInterval}, x::BareInterval) where {T} = Dual{T}(value(d) / x, partials(d) / x)
Base.:/(x::BareInterval, d::Dual{<:Any,<:NestedBareInterval}) = x * inv(d)

# Extend ForwardDiff's partial scaling to bare intervals.
Base.:*(p::Partials, x::BareInterval) = Partials(ForwardDiff.scale_tuple(p.values, x))
Base.:*(x::BareInterval, p::Partials) = p * x
Base.:/(p::Partials, x::BareInterval) = Partials(ForwardDiff.div_tuple_by_scalar(p.values, x))
ForwardDiff._mul_partial(p::BareInterval, x::BareInterval) = p * x
ForwardDiff._mul_partial(p::BareInterval, x::ExactReal) = p * x
ForwardDiff._mul_partial(p::Dual, x::BareInterval) = p * x
ForwardDiff._div_partial(p::BareInterval, x::BareInterval) = p / x
ForwardDiff._div_partial(p::BareInterval, x::ExactReal) = p / x
ForwardDiff._div_partial(p::Dual, x::BareInterval) = p / x

# Derivative rules may return either bare intervals or real coefficients.
ForwardDiff.dual_definition_retval(::Val{T}, val::BareInterval, deriv, partial::Partials) where {T} =
    Dual{T}(val, deriv * partial)
ForwardDiff.dual_definition_retval(::Val{T}, val::BareInterval, deriv1, partial1::Partials,
                                   deriv2, partial2::Partials) where {T} =
    Dual{T}(val, ForwardDiff._mul_partials(partial1, partial2, deriv1, deriv2))

# Use general integer powers to scale partials via `_mul_partial`.
# Match ForwardDiff's `Val` specializations to avoid ambiguities, and use a
# variable exponent to avoid recursing through `literal_pow`.
for p in 0:3
    @eval Base.literal_pow(::typeof(^), x::Dual{T,<:NestedBareInterval}, ::Val{$p}) where {T} =
        (n = $p; x^n)
end
Base.literal_pow(::typeof(^), x::Dual{T,<:NestedBareInterval}, ::Val{p}) where {T,p} = (n = p; x^n)

# Integer and rational exponents are exactly representable, and keep their
# `IntervalArithmetic` semantics for a base straddling zero.
for R in (:Integer, :Rational)
    @eval function Base.:(^)(x::Dual{Tx,<:NestedBareInterval}, y::$R) where {Tx}
        v = value(x)
        expv = v^y
        if iszero(y) || all(_isthinzero, values(partials(x)))
            return Dual{Tx}(expv, zero(partials(x)))
        else
            return Dual{Tx}(expv, partials(x) * exact(y) * v^(y - 1))
        end
    end
end

function Base.:(^)(x::Dual{Tx,<:NestedBareInterval}, y::BareInterval) where {Tx}
    v = value(x)
    expv = v^y
    if isthinzero(y) || all(_isthinzero, values(partials(x)))
        return Dual{Tx}(expv, zero(partials(x)))
    else
        return Dual{Tx}(expv, partials(x) * y * v^(y - bareinterval(1)))
    end
end

# `true` and `false` scale a dual without naming an interval of their own.
# ForwardDiff's `(Dual, Bool)` method inspects `signbit(value(d))`; an interval
# has no single sign bit and does not distinguish ±0.
Base.:*(d::Dual{T,<:NestedBareInterval}, x::Bool) where {T} = x ? d : zero(d)
Base.:*(x::Bool, d::Dual{T,<:NestedBareInterval}) where {T} = d * x

DiffRules._abs_deriv(x::Dual{T,<:NestedBareInterval}) where {T} =
    Dual{T}(DiffRules._abs_deriv(value(x)), zero(partials(x)))

# Derivative rules for bare intervals
#
# The rules tabulated by `DiffRules` embed bare numbers, and ForwardDiff splices
# them into its `Dual` methods unchanged. Vendor them with `ExactReal` or enclosing
# bare interval.

_rigorous(x::Integer) = :(exact($x))
_rigorous(c::AbstractIrrational) = :(bareinterval(_numtype_bare(x), $c, $c))
_rigorous(x::Number) = error("no rigorous `BareInterval` form for the constant `$x`")
function _rigorous(s::Symbol)
    s === :π && return _rigorous(π)
    s ∈ (:x, :y, :vx, :vy) && return s
    return error("unrecognized symbol `$s` in a derivative rule")
end
function _rigorous(ex::Expr)
    ex.head === :call || error("unsupported expression head `$(ex.head)` in a derivative rule")
    return Expr(:call, ex.args[1], map(_rigorous, ex.args[2:end])...)
end

# The functions of one argument that `DiffRules` tabulates and
# `IntervalArithmetic` implements on `BareInterval`. `+`, `-`, `sin` and `cos`
# are absent because ForwardDiff differentiates them without consulting the
# rule table.
const BARE_UNARY_RULES = (
    :abs, :abs2, :acos, :acosh, :acot, :acoth, :asin, :asinh, :atan, :atanh,
    :cbrt, :cosd, :cosh, :cospi, :cot, :coth, :csc, :csch, :deg2rad, :exp,
    :exp10, :exp2, :expm1, :inv, :log, :log10, :log1p, :log2, :rad2deg, :sec,
    :sech, :sind, :sinh, :sinpi, :sqrt, :tan, :tanh,
)

for f in BARE_UNARY_RULES
    rule = _rigorous(DiffRules.diffrule(:Base, f, :x))
    # Share subexpressions between the value and the derivative, as ForwardDiff
    # does for its own rules: a derivative that repeats the value (`exp`, `inv`,
    # `tan`, …) otherwise evaluates it twice per `Dual` layer.
    work = ForwardDiff.qualified_cse!(quote
        val = $f(x)
        deriv = $rule
    end)
    @eval function Base.$f(d::Dual{T,<:NestedBareInterval}) where {T}
        x = value(d)
        $work
        return ForwardDiff.dual_definition_retval(Val{T}(), val, deriv, partials(d))
    end
end

# Binary rules with a bare interval on one side. ForwardDiff's `Dual`-`Dual`
# methods carry bare intervals through unchanged; its `Dual`-`Real` methods do
# not apply, because a `BareInterval` is not a `Real`.
# `^` and the field operations are defined above.
for f in (:atan, :hypot)
    dvx, _ = DiffRules.diffrule(:Base, f, :vx, :y)
    _, dvy = DiffRules.diffrule(:Base, f, :x, :vy)
    @eval begin
        function Base.$f(x::Dual{Tx,<:NestedBareInterval}, y::BareInterval) where {Tx}
            vx = value(x)
            val = Base.$f(vx, y)
            return ForwardDiff.dual_definition_retval(Val{Tx}(), val, $(_rigorous(dvx)), partials(x))
        end
        function Base.$f(x::BareInterval, y::Dual{Ty,<:NestedBareInterval}) where {Ty}
            vy = value(y)
            val = Base.$f(x, vy)
            return ForwardDiff.dual_definition_retval(Val{Ty}(), val, $(_rigorous(dvy)), partials(y))
        end
    end
end

end
