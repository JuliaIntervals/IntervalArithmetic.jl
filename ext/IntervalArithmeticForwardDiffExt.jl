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

# ForwardDiff's `^` methods use `iszero(partials(x))`, which is undecidable for
# non-thin intervals. Use a recursive thin-zero test instead. `NestedInterval`
# supports intervals nested in up to four `Dual` layers.
const NestedInterval = let
    U = Union{Interval, BareInterval}
    for _ in 1:4
        U = Union{U, Dual{T,<:U} where {T}}
    end
    U
end
_isthinzero(x::Interval) = isthinzero(x)
_isthinzero(x::BareInterval) = isthinzero(x)
_isthinzero(x::Real) = iszero(x)
_isthinzero(d::Dual) = _isthinzero(value(d)) && all(_isthinzero, partials(d))
# Use thin-zero checks for interval partials when ForwardDiff supports them.
@static if isdefined(ForwardDiff, :unwrap_dual)
    ForwardDiff._iszero_tuple(::Type{<:Union{Interval, BareInterval}}, tup::Tuple) =
        all(_isthinzero, tup)
end

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
# Real constants and derivative coefficients are treated as exact. Use
# decorated `Interval`s to track this assumption through `isguaranteed`.

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

# Convert nested dual values and partials to bare intervals, treating reals as exact.
_bare(x::BareInterval) = x
_bare(x::Real) = bareinterval(x)
_bare(d::Dual{T,<:NestedBareInterval}) where {T} = d
_bare(d::Dual{T}) where {T} = Dual{T}(_bare(value(d)), _bare(partials(d)))
_bare(p::Partials) = Partials(map(_bare, p.values))

Base.:+(d::Dual{T}, x::BareInterval) where {T} = (db = _bare(d); Dual{T}(value(db) + x, partials(db)))
Base.:+(x::BareInterval, d::Dual) = d + x
Base.:-(d::Dual{T}, x::BareInterval) where {T} = (db = _bare(d); Dual{T}(value(db) - x, partials(db)))
Base.:-(x::BareInterval, d::Dual{T}) where {T} = (db = _bare(d); Dual{T}(x - value(db), -partials(db)))
Base.:*(d::Dual{T}, x::BareInterval) where {T} = (db = _bare(d); Dual{T}(value(db) * x, partials(db) * x))
Base.:*(x::BareInterval, d::Dual) = d * x
Base.:/(d::Dual{T}, x::BareInterval) where {T} = (db = _bare(d); Dual{T}(value(db) / x, partials(db) / x))
Base.:/(x::BareInterval, d::Dual) = x * inv(d)

# Extend ForwardDiff's partial scaling to bare intervals.
Base.:*(p::Partials, x::BareInterval) = Partials(ForwardDiff.scale_tuple(p.values, x))
Base.:*(x::BareInterval, p::Partials) = p * x
Base.:/(p::Partials, x::BareInterval) = Partials(ForwardDiff.div_tuple_by_scalar(p.values, x))
ForwardDiff._mul_partial(p::BareInterval, x::BareInterval) = p * x
ForwardDiff._mul_partial(p::BareInterval, x::Real) = p * exact(x)
ForwardDiff._mul_partial(p::Real, x::BareInterval) = exact(p) * x
ForwardDiff._mul_partial(p::Dual, x::BareInterval) = p * x
ForwardDiff._div_partial(p::BareInterval, x::BareInterval) = p / x
ForwardDiff._div_partial(p::BareInterval, x::Real) = p / exact(x)
ForwardDiff._div_partial(p::Real, x::BareInterval) = exact(p) / x
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

# Convert floating-point and irrational exponents to thin bare intervals.
# Integer and rational exponents retain their semantics for bases crossing zero.
for R in (:AbstractFloat, :Irrational)
    @eval Base.:(^)(x::Dual{Tx,<:NestedBareInterval}, y::$R) where {Tx} = x^bareinterval(y)
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

# Treat real operands as exact. Delegate `ExactReal` and dual-dual operations
# to ForwardDiff to avoid recursion and preserve its arithmetic rules.
for f in (:+, :-, :*, :/)
    # Match ForwardDiff's `AMBIGUOUS_TYPES` to avoid method ambiguities.
    for R in (:AbstractFloat, :Irrational, :Integer, :Rational, :Real)
        @eval begin
            Base.$f(d::Dual{T,<:NestedBareInterval}, x::$R) where {T} = $f(d, exact(x))
            Base.$f(x::$R, d::Dual{T,<:NestedBareInterval}) where {T} = $f(exact(x), d)
        end
    end
    @eval begin
        Base.$f(d::Dual{T,<:NestedBareInterval}, x::ExactReal) where {T} =
            invoke($f, Tuple{Dual{T}, Real}, d, x)
        Base.$f(x::ExactReal, d::Dual{T,<:NestedBareInterval}) where {T} =
            invoke($f, Tuple{Real, Dual{T}}, x, d)
        Base.$f(x::Dual{Tx,<:NestedBareInterval}, y::Dual{Ty}) where {Tx,Ty} =
            invoke($f, Tuple{Dual{Tx}, Dual{Ty}}, x, y)
        Base.$f(x::Dual{Tx}, y::Dual{Ty,<:NestedBareInterval}) where {Tx,Ty} =
            invoke($f, Tuple{Dual{Tx}, Dual{Ty}}, x, y)
        Base.$f(x::Dual{Tx,<:NestedBareInterval}, y::Dual{Ty,<:NestedBareInterval}) where {Tx,Ty} =
            invoke($f, Tuple{Dual{Tx}, Dual{Ty}}, x, y)
    end
end

# ForwardDiff's `(Dual, Bool)` method inspects `signbit(value(d))`; an interval
# has no single sign bit and does not distinguish ±0.
Base.:*(d::Dual{T,<:NestedBareInterval}, x::Bool) where {T} = x ? d : zero(d)
Base.:*(x::Bool, d::Dual{T,<:NestedBareInterval}) where {T} = d * x

end
