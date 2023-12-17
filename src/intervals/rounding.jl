# prevents multiple threads from calling `setprecision` concurrently, used in `_bigequiv`
const precision_lock = ReentrantLock()

"""
    _bigequiv(x)

Create a `BigFloat` with the same underlying precision.
"""
function _bigequiv(x::T) where {T<:NumTypes}
    lock(precision_lock) do
        setprecision(precision(float(T))) do
            return BigFloat(x)
        end
    end
end

_bigequiv(x::BigFloat) = x





"""
    IntervalRounding

Interval rounding type.

Available rounding types:
- `:fast` (unsupported): rounding via `prevfloat` and `nextfloat`.
- `:tight`: rounding via [RoundingEmulator.jl](https://github.com/matsueushi/RoundingEmulator.jl).
- `:slow`: rounding via `setrounding`.
- `:none`: no rounding (non-rigorous numerics).
"""
struct IntervalRounding{T} end

interval_rounding() = IntervalRounding{:tight}()

#

for (f, fname) ∈ ((:+, :add), (:-, :sub), (:*, :mul), (:/, :div))
    g = Symbol(:_, fname, :_round)

    @eval begin
        $g(x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} = $g(interval_rounding(), x, y, r)
        $g(x::T, y::T, ::RoundingMode) where {T<:Rational} = $f(x, y) # exact operation

        $g(::IntervalRounding, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} =
            $g(IntervalRounding{:slow}(), x, y, r)
        # $g(::IntervalRounding{:fast}, x::T, y::T, ::RoundingMode{:Down}) where {T<:AbstractFloat} =
        #     prevfloat($f(x, y))
        # $g(::IntervalRounding{:fast}, x::T, y::T, ::RoundingMode{:Up}) where {T<:AbstractFloat} =
        #     nextfloat($f(x, y))
        $g(::IntervalRounding{:tight}, x::T, y::T, ::RoundingMode{:Down}) where {T<:Union{Float32,Float64}} =
            RoundingEmulator.$(Symbol(fname, :_down))(x, y)
        $g(::IntervalRounding{:tight}, x::T, y::T, ::RoundingMode{:Up}) where {T<:Union{Float32,Float64}} =
            RoundingEmulator.$(Symbol(fname, :_up))(x, y)
        function $g(::IntervalRounding{:slow}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
            bigx = _bigequiv(x)
            bigy = _bigequiv(y)
            return setrounding(BigFloat, r) do
                return $f(bigx, bigy)
            end
        end
        $g(::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = $f(x, y)
    end
end

#

_pow_round(x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} = _pow_round(interval_rounding(), x, y, r)
_pow_round(x::AbstractFloat, n::Integer, r::RoundingMode) = _pow_round(promote(x, n)..., r)
_pow_round(x::T, y::T, ::RoundingMode) where {T<:Rational} = ^(x, y) # exact operation
_pow_round(x::Rational, n::Integer, ::RoundingMode) = ^(x, n) # exact operation

_pow_round(::IntervalRounding, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} =
    _pow_round(IntervalRounding{:slow}(), x, y, r)
# _pow_round(::IntervalRounding{:fast}, x::T, y::T, ::RoundingMode{:Down}) where {T<:AbstractFloat} =
#     prevfloat(^(x, y))
# _pow_round(::IntervalRounding{:fast}, x::T, y::T, ::RoundingMode{:Up}) where {T<:AbstractFloat} =
#     nextfloat(^(x, y))
function _pow_round(::IntervalRounding{:slow}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
    bigx = _bigequiv(x)
    bigy = _bigequiv(y)
    return setrounding(BigFloat, r) do
        return ^(bigx, bigy)
    end
end
_pow_round(::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = ^(x, y)

#

_inv_round(x::AbstractFloat, r::RoundingMode) = _inv_round(interval_rounding(), x, r)
_inv_round(x::Rational, ::RoundingMode) = inv(x) # exact operation

_inv_round(::IntervalRounding, x::AbstractFloat, r::RoundingMode) =
    _inv_round(IntervalRounding{:slow}(), x, r)
# _inv_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Down}) =
#     prevfloat(inv(x))
# _inv_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Up}) =
#     nextfloat(inv(x))
_inv_round(::IntervalRounding{:tight}, x::Union{Float32,Float64}, ::RoundingMode{:Down}) =
    RoundingEmulator.div_down(one(x), x)
_inv_round(::IntervalRounding{:tight}, x::Union{Float32,Float64}, ::RoundingMode{:Up}) =
    RoundingEmulator.div_up(one(x), x)
function _inv_round(::IntervalRounding{:slow}, x::AbstractFloat, r::RoundingMode)
    bigx = _bigequiv(x)
    return setrounding(BigFloat, r) do
        return inv(bigx)
    end
end
_inv_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = inv(x)

#

_sqrt_round(x::NumTypes, r::RoundingMode) = _sqrt_round(interval_rounding(), float(x), r) # rationals are converted to floats

_sqrt_round(::IntervalRounding, x::AbstractFloat, r::RoundingMode) =
    _sqrt_round(IntervalRounding{:slow}(), x, r)
# _sqrt_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Down}) =
#     prevfloat(sqrt(x))
# _sqrt_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Up}) =
#     nextfloat(sqrt(x))
_sqrt_round(::IntervalRounding{:tight}, x::Union{Float32,Float64}, ::RoundingMode{:Down}) =
    RoundingEmulator.sqrt_down(x)
_sqrt_round(::IntervalRounding{:tight}, x::Union{Float32,Float64}, ::RoundingMode{:Up}) =
    RoundingEmulator.sqrt_up(x)
function _sqrt_round(::IntervalRounding{:slow}, x::AbstractFloat, r::RoundingMode)
    bigx = _bigequiv(x)
    return setrounding(BigFloat, r) do
        return sqrt(bigx)
    end
end
_sqrt_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = sqrt(x)

#

_rootn_round(x::NumTypes, n::Integer, r::RoundingMode) = _rootn_round(interval_rounding(), float(x), n, r) # rationals are converted to floats

_rootn_round(::IntervalRounding, x::AbstractFloat, n::Integer, r::RoundingMode) =
    _rootn_round(IntervalRounding{:slow}(), x, n, r)
# _rootn_round(::IntervalRounding{:fast}, x::AbstractFloat, n::Integer, ::RoundingMode{:Down}) =
#     prevfloat(x^(1//n))
# _rootn_round(::IntervalRounding{:fast}, x::AbstractFloat, n::Integer, ::RoundingMode{:Up}) =
#     nextfloat(x^(1//n))
function _rootn_round(::IntervalRounding{:slow}, x::AbstractFloat, n::Integer, ::RoundingMode{:Down})
    r = BigFloat()
    ccall((:mpfr_rootn_ui, :libmpfr), Int32, (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFR.MPFRRoundingMode), r, x, convert(Culong, n), MPFR.MPFRRoundDown)
    return r
end
function _rootn_round(::IntervalRounding{:slow}, x::AbstractFloat, n::Integer, ::RoundingMode{:Up})
    r = BigFloat()
    ccall((:mpfr_rootn_ui, :libmpfr), Int32, (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFR.MPFRRoundingMode), r, x, convert(Culong, n), MPFR.MPFRRoundUp)
    return r
end
_rootn_round(::IntervalRounding{:none}, x::AbstractFloat, n::Integer, ::RoundingMode) = x^(1//n)

#

_atan_round(x::T, y::T, r::RoundingMode) where {T<:NumTypes} = _atan_round(interval_rounding(), promote(float(x), float(y))..., r) # rationals are converted to floats

_atan_round(::IntervalRounding, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat} =
    _atan_round(IntervalRounding{:slow}(), x, y, r)
# _atan_round(::IntervalRounding{:fast}, x::T, y::T, ::RoundingMode{:Down}) where {T<:AbstractFloat} =
#     prevfloat(atan(x, y))
# _atan_round(::IntervalRounding{:fast}, x::T, y::T, ::RoundingMode{:Up}) where {T<:AbstractFloat} =
#     nextfloat(atan(x, y))
function _atan_round(::IntervalRounding{:slow}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
    bigx = _bigequiv(x)
    bigy = _bigequiv(y)
    return setrounding(BigFloat, r) do
        return atan(bigx, bigy)
    end
end
_atan_round(::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = atan(x, y)

#

for f ∈ [:cbrt, :exp2, :exp10, :cot, :sec, :csc, :acot, :tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth]
    f_round = Symbol(:_, f, :_round)

    @eval begin
        $f_round(x::NumTypes, r::RoundingMode) = $f_round(interval_rounding(), float(x), r) # rationals are converted to floats

        $f_round(::IntervalRounding, x::AbstractFloat, r::RoundingMode) = $f_round(IntervalRounding{:slow}(), x, r)
        # $f_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Down}) =
        #     prevfloat($f(x))
        # $f_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Up}) =
        #     nextfloat($f(x))
        function $f_round(::IntervalRounding{:slow}, x::AbstractFloat, r::RoundingMode)
            bigx = _bigequiv(x)
            return setrounding(BigFloat, r) do
                return $f(bigx)
            end
        end
        $f_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = $f(x)
    end
end

#

for f ∈ CRlibm.functions
    if isdefined(Base, f)
        f_round = Symbol(:_, f, :_round)

        @eval begin
            $f_round(x::NumTypes, r::RoundingMode) = $f_round(interval_rounding(), float(x), r) # rationals are converted to floats

            $f_round(::IntervalRounding, x::AbstractFloat, r::RoundingMode) = $f_round(IntervalRounding{:slow}(), x, r)
            # $f_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Down}) =
            #     prevfloat($f(x))
            # $f_round(::IntervalRounding{:fast}, x::AbstractFloat, ::RoundingMode{:Up}) =
            #     nextfloat($f(x))
            $f_round(::IntervalRounding{:slow}, x::AbstractFloat, r::RoundingMode) = CRlibm.$f(x, r)
            function $f_round(::IntervalRounding{:slow}, x::BigFloat, r::RoundingMode)
                return setrounding(BigFloat, r) do
                    return $f(x)
                end
            end
            $f_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = $f(x)
        end
    end
end





"""
    @round(T, ex1, ex2)

Macro for internal use that creates an interval by rounding down `ex1` and
rounding up `ex2`. Each expression may consist of only a *single* operation that
needs rounding, e.g. `a.lo + b.lo` or `sin(a.lo)`. It also handles `min(...)`
and `max(...)`, where the arguments are each themselves single operations.

The macro uses the internal `_round_expr` function to transform e.g. `a + b` into
`+(a, b, RoundDown)`.
"""
macro round(T, ex1, ex2)
    return :(_unsafe_bareinterval($(esc(T)), $(_round_expr(ex1, RoundDown)), $(_round_expr(ex2, RoundUp))))
end

"""
    _round_expr(ex::Expr, rounding_mode::RoundingMode)

Transforms a single expression by applying a rounding mode, e.g.

- `a + b` into `+(a, b, RoundDown)`
- `sin(a)` into `sin(a, RoundDown)`
"""
function _round_expr(ex::Expr, r::RoundingMode)
    if ex.head == :call
        op = ex.args[1]
        if op ∈ (:min, :max)
            mapped_args = _round_expr.(ex.args[2:end], r)
            return :( $op($(mapped_args...)) )
        elseif op ∈ (:typemin, :typemax, :one, :zero)
            return :( $(esc(ex)) )
        elseif length(ex.args) == 3 # binary operator
            if op == :+
                return :( _add_round($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            elseif op == :-
                return :( _sub_round($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            elseif op == :*
                return :( _mul_round($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            elseif op == :/
                return :( _div_round($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            elseif op == :^
                return :( _pow_round($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            elseif op == :_unbounded_mul
                return :( _unbounded_mul($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            else
                op2 = Symbol(:_, op, :_round)
                return :( $op2($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            end
        elseif op ∈ (:+, :-) # unary operator that does not need rounding
            return :( $(esc(ex)) )
        else # unary operator
            op2 = Symbol(:_, op, :_round)
            return :( $op2($(esc(ex.args[2])), $r) )
        end
    else
        return :( $(esc(ex)) )
    end
end

_round_expr(ex, _) = ex
