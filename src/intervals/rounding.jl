"""
    IntervalRounding

Interval rounding type.

Available rounding types:
- `:correct`: rounding via [RoundingEmulator.jl](https://github.com/JuliaIntervals/RoundingEmulator.jl)
and [CRlibm.jl](https://github.com/JuliaInterval/IntervalArithmetic.jl).
- `:none`: no rounding (non-rigorous numerics).
"""
struct IntervalRounding{T} end

#

for (f, fname) ∈ ((:+, :add), (:-, :sub), (:*, :mul), (:/, :div))
    g = Symbol(:_, fname, :_round)
    mpfr_f = Symbol(:mpfr_, fname)

    @eval begin
        $g(::IntervalRounding, x::T, y::T, ::RoundingMode) where {T<:Rational} = $f(x, y) # exact operation

        $g(::IntervalRounding{:correct}, x::T, y::T, ::RoundingMode{:Down}) where {T<:Union{Float32,Float64}} =
            RoundingEmulator.$(Symbol(fname, :_down))(x, y)
        $g(::IntervalRounding{:correct}, x::T, y::T, ::RoundingMode{:Up}) where {T<:Union{Float32,Float64}} =
            RoundingEmulator.$(Symbol(fname, :_up))(x, y)
        function $g(::IntervalRounding{:correct}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
            prec = max(precision(x), precision(y))
            bigx = BigFloat(x; precision = prec)
            bigy = BigFloat(y; precision = prec)
            bigz = BigFloat(; precision = prec)
            @ccall Base.MPFR.libmpfr.$mpfr_f(
                bigz::Ref{BigFloat},
                bigx::Ref{BigFloat},
                bigy::Ref{BigFloat},
                r::Base.MPFR.MPFRRoundingMode
            )::Int32
            return bigz
        end

        $g(::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = $f(x, y)
    end
end

#

_pow_round(ir::IntervalRounding, x::AbstractFloat, n::Integer, r::RoundingMode) =
    _pow_round(ir, promote(x, n)..., r)

_pow_round(::IntervalRounding, x::T, y::T, ::RoundingMode) where {T<:Rational} = ^(x, y) # exact operation
_pow_round(::IntervalRounding, x::Rational, n::Integer, ::RoundingMode) = ^(x, n) # exact operation

function _pow_round(::IntervalRounding{:correct}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
    prec = max(precision(x), precision(y))
    bigx = BigFloat(x; precision = prec)
    bigy = BigFloat(y; precision = prec)
    bigz = BigFloat(; precision = prec)
    @ccall Base.MPFR.libmpfr.mpfr_pow(
        bigz::Ref{BigFloat},
        bigx::Ref{BigFloat},
        bigy::Ref{BigFloat},
        r::Base.MPFR.MPFRRoundingMode
    )::Int32
    return bigz
end

_pow_round(::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = ^(x, y)

#

_inv_round(::IntervalRounding, x::Rational, ::RoundingMode) = inv(x) # exact operation

_inv_round(::IntervalRounding{:correct}, x::Union{Float32,Float64}, ::RoundingMode{:Down}) =
    RoundingEmulator.div_down(one(x), x)
_inv_round(::IntervalRounding{:correct}, x::Union{Float32,Float64}, ::RoundingMode{:Up}) =
    RoundingEmulator.div_up(one(x), x)
function _inv_round(::IntervalRounding{:correct}, x::AbstractFloat, r::RoundingMode)
    prec = precision(x)
    bigx = BigFloat(x; precision = prec)
    bigz = BigFloat(; precision = prec)
    @ccall Base.MPFR.libmpfr.mpfr_div(
        bigz::Ref{BigFloat},
        one(bigx)::Ref{BigFloat},
        bigx::Ref{BigFloat},
        r::Base.MPFR.MPFRRoundingMode
    )::Int32
    return bigz
end

_inv_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = inv(x)

#

_sqrt_round(::IntervalRounding{:correct}, x::Union{Float32,Float64}, ::RoundingMode{:Down}) =
    RoundingEmulator.sqrt_down(x)
_sqrt_round(::IntervalRounding{:correct}, x::Union{Float32,Float64}, ::RoundingMode{:Up}) =
    RoundingEmulator.sqrt_up(x)
function _sqrt_round(::IntervalRounding{:correct}, x::AbstractFloat, r::RoundingMode)
    prec = precision(x)
    bigx = BigFloat(x; precision = prec)
    bigz = BigFloat(; precision = prec)
    @ccall Base.MPFR.libmpfr.mpfr_sqrt(
        bigz::Ref{BigFloat},
        bigx::Ref{BigFloat},
        r::Base.MPFR.MPFRRoundingMode
    )::Int32
    return bigz
end

_sqrt_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = sqrt(x)

#

function _rootn_round(::IntervalRounding{:correct}, x::AbstractFloat, n::Integer, r::RoundingMode)
    prec = precision(x)
    bigx = BigFloat(x; precision = prec)
    bigz = BigFloat(; precision = prec)
    @ccall Base.MPFR.libmpfr.mpfr_rootn_ui(
        bigz::Ref{BigFloat},
        bigx::Ref{BigFloat},
        n::Culong,
        r::Base.MPFR.MPFRRoundingMode
    )::Int32
    return bigz
end

_rootn_round(::IntervalRounding{:none}, x::AbstractFloat, n::Integer, ::RoundingMode) = x^(1//n)

#

function _atan_round(::IntervalRounding{:correct}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
    prec = max(precision(x), precision(y))
    bigx = BigFloat(x; precision = prec)
    bigy = BigFloat(y; precision = prec)
    bigz = BigFloat(; precision = prec)
    @ccall Base.MPFR.libmpfr.mpfr_atan2(
        bigz::Ref{BigFloat},
        bigx::Ref{BigFloat},
        bigy::Ref{BigFloat},
        r::Base.MPFR.MPFRRoundingMode
    )::Int32
    return bigz
end

_atan_round(::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = atan(x, y)

#

for f ∈ [:cbrt, :exp2, :exp10, :cot, :sec, :csc, :tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh]
    f_round = Symbol(:_, f, :_round)
    mpfr_f = Symbol(:mpfr_, f)

    @eval begin
        function $f_round(::IntervalRounding{:correct}, x::AbstractFloat, r::RoundingMode)
            prec = precision(x)
            bigx = BigFloat(x; precision = prec)
            bigz = BigFloat(; precision = prec)
            @ccall Base.MPFR.libmpfr.$mpfr_f(
                bigz::Ref{BigFloat},
                bigx::Ref{BigFloat},
                r::Base.MPFR.MPFRRoundingMode
            )::Int32
            return bigz
        end

        $f_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = $f(x)
    end
end

for (f, g) ∈ [(:acot, :atan), (:acoth, :atanh)]
    f_round = Symbol(:_, f, :_round)
    g_round = Symbol(:_, g, :_round)

    @eval begin
        function $f_round(ir::IntervalRounding{:correct}, x::AbstractFloat, r::RoundingMode{:Down})
            prec = precision(x)
            bigx = BigFloat(x; precision = prec + 10)
            bigz = BigFloat(; precision = prec + 10)
            @ccall Base.MPFR.libmpfr.mpfr_div(
                bigz::Ref{BigFloat},
                one(bigx)::Ref{BigFloat},
                bigx::Ref{BigFloat},
                RoundUp::Base.MPFR.MPFRRoundingMode
            )::Int32
            bigw = $g_round(ir, bigz, r)
            return BigFloat(bigw, r; precision = prec)
        end
        function $f_round(ir::IntervalRounding{:correct}, x::AbstractFloat, r::RoundingMode{:Up})
            prec = precision(x)
            bigx = BigFloat(x; precision = prec + 32)
            bigz = BigFloat(; precision = prec + 32)
            @ccall Base.MPFR.libmpfr.mpfr_div(
                bigz::Ref{BigFloat},
                one(bigx)::Ref{BigFloat},
                bigx::Ref{BigFloat},
                RoundDown::Base.MPFR.MPFRRoundingMode
            )::Int32
            bigw = $g_round(ir, bigz, r)
            return BigFloat(bigw, r; precision = prec)
        end

        $f_round(::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = $f(x)
    end
end

# CRlibm functions

for f ∈ CRlibm.functions
    f_round = Symbol(:_, f, :_round)

    @eval begin
        $f_round(::IntervalRounding{:correct}, x::AbstractFloat, r::RoundingMode) = CRlibm.$f(x, r)

        $f_round(::IntervalRounding{:none}, x::AbstractFloat, r::RoundingMode) = $f(x)
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
