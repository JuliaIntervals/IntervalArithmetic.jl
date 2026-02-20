"""
    IntervalRounding

Interval rounding type.

Available rounding types:
- `:correct`: rounding via [RoundingEmulator.jl](https://github.com/JuliaIntervals/RoundingEmulator.jl) and [CRlibm.jl](https://github.com/JuliaInterval/IntervalArithmetic.jl); fallback to MPFR.
- `:ulp`: rounding via [CoreMath.jl](https://github.com/JuliaMath/CoreMath.jl) (default rounding to nearest) with `prevfloat` and `nextfloat`; fallback to MPFR.
- `:none`: no rounding (non-rigorous numerics).
"""
struct IntervalRounding{T} end

#

_fround(f::Function, x, y, r) = _fround(f, default_rounding(), x, y, r)
_fround(f::Function, x, r)    = _fround(f, default_rounding(), x, r)

# +, -, *, /, inv, sqrt

for (f, fname) ∈ ((:+, :add), (:-, :sub), (:*, :mul), (:/, :div))

    mpfr_f = Symbol(:mpfr_, fname)

    @eval begin
        _fround(::typeof($f), ::IntervalRounding, x::T, y::T, ::RoundingMode) where {T<:Rational} = $f(x, y) # exact operation

        function _fround(::typeof($f), ::Union{IntervalRounding{:correct},IntervalRounding{:ulp}}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
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

        _fround(::typeof($f), ir::IntervalRounding{:correct}, x::Float16, y::Float16, r::RoundingMode) =
            Float16(_fround($f, ir, Float64(x), Float64(y), r), r)
        _fround(::typeof($f), ::IntervalRounding{:correct}, x::T, y::T, ::RoundingMode{:Down}) where {T<:Union{Float32,Float64}} =
            RoundingEmulator.$(Symbol(fname, :_down))(x, y)
        _fround(::typeof($f), ::IntervalRounding{:correct}, x::T, y::T, ::RoundingMode{:Up}) where {T<:Union{Float32,Float64}} =
            RoundingEmulator.$(Symbol(fname, :_up))(x, y)

        _fround(::typeof($f), ir::IntervalRounding{:ulp}, x::T, y::T, r::RoundingMode) where {T<:Union{Float16,Float32}} =
            T(_fround($f, ir, Float64(x), Float64(y), r), r)
        _fround(::typeof($f), ::IntervalRounding{:ulp}, x::Float64, y::Float64, ::RoundingMode{:Down}) = prevfloat($f(x, y))
        _fround(::typeof($f), ::IntervalRounding{:ulp}, x::Float64, y::Float64, ::RoundingMode{:Up}) = nextfloat($f(x, y))

        _fround(::typeof($f), ::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = $f(x, y)
    end
end

_fround(::typeof(inv), ::IntervalRounding, x::Rational, ::RoundingMode) = inv(x) # exact operation

_fround(::typeof(inv), ::IntervalRounding, x::AbstractFloat, r::RoundingMode) = _fround(/, one(x), x, r)

_fround(::typeof(inv), ::IntervalRounding{:none}, x::T, ::RoundingMode) where {T<:AbstractFloat} = inv(x)

function _fround(::typeof(sqrt), ::Union{IntervalRounding{:correct},IntervalRounding{:ulp}}, x::T, r::RoundingMode) where {T<:AbstractFloat}
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

_fround(::typeof(sqrt), ir::IntervalRounding{:correct}, x::Float16, r::RoundingMode) =
    Float16(_fround(sqrt, ir, Float64(x), r), r)
_fround(::typeof(sqrt), ::IntervalRounding{:correct}, x::T, ::RoundingMode{:Down}) where {T<:Union{Float32,Float64}} =
    RoundingEmulator.sqrt_down(x)
_fround(::typeof(sqrt), ::IntervalRounding{:correct}, x::T, ::RoundingMode{:Up}) where {T<:Union{Float32,Float64}} =
    RoundingEmulator.sqrt_up(x)

_fround(::typeof(sqrt), ir::IntervalRounding{:ulp}, x::T, r::RoundingMode) where {T<:Union{Float16,Float32}} =
    T(_fround(sqrt, ir, Float64(x), r), r)
_fround(::typeof(sqrt), ::IntervalRounding{:ulp}, x::Float64, ::RoundingMode{:Down}) = prevfloat(sqrt(x))
_fround(::typeof(sqrt), ::IntervalRounding{:ulp}, x::Float64, ::RoundingMode{:Up}) = nextfloat(sqrt(x))

_fround(::typeof(sqrt), ::IntervalRounding{:none}, x::AbstractFloat, ::RoundingMode) = sqrt(x)

# 1-argument functions

for f ∈ (:cbrt, :exp, :exp2, :exp10, :expm1, # exponential
         :log, :log2, :log10, :log1p, # logarithmic
         :sin, :sinpi, :cos, :cospi, :tan, :cot, :sec, :csc, :asin, :acos, :atan, :acot, # trigonometric
         :sinh, :tanh, :asinh, :cosh, :coth, :sech, :csch, :acosh, :atanh, :acoth) # hyperbolic

    mpfr_f = Symbol(:mpfr_, f)
    coremath_f = Symbol(:cr_, f)

    @eval function _fround(::typeof($f), ::Union{IntervalRounding{:correct},IntervalRounding{:ulp}}, x::AbstractFloat, r::RoundingMode)
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

    if f ∈ CRlibm.functions
        @eval _fround(::typeof($f), ::IntervalRounding{:correct}, x::Float16, r::RoundingMode) = Float16(_fround($f, Float64(x), r), r)
        @eval _fround(::typeof($f), ::IntervalRounding{:correct}, x::Union{Float32,Float64}, r::RoundingMode) = CRlibm.$f(x, r)
    end

    @eval _fround(::typeof($f), ::IntervalRounding{:ulp}, x::Union{Float16,Float32,Float64}, ::RoundingMode{:Down}) = prevfloat(CoreMath.$coremath_f(x))
    @eval _fround(::typeof($f), ::IntervalRounding{:ulp}, x::Union{Float16,Float32,Float64}, ::RoundingMode{:Up}) = nextfloat(CoreMath.$coremath_f(x))

    @eval _fround(::typeof($f), ::IntervalRounding{:none}, x::AbstractFloat, r::RoundingMode) = $f(x)
end

# 2-argument functions

_fround(::typeof(^), ::IntervalRounding, x::Rational, n::Integer, ::RoundingMode) = ^(x, n) # exact operation

_fround(::typeof(^), ir::IntervalRounding, x::AbstractFloat, n::Integer, r::RoundingMode) =
    _fround(^, ir, promote(x, n)..., r)

for (f, fname) ∈ ((:^, :pow), (:atan, :atan2))

    mpfr_f = Symbol(:mpfr_, fname)
    coremath_f = Symbol(:cr_, fname)

    @eval begin
        function _fround(::typeof($f), ::Union{IntervalRounding{:correct},IntervalRounding{:ulp}}, x::T, y::T, r::RoundingMode) where {T<:AbstractFloat}
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

        _fround(::typeof($f), ::IntervalRounding{:ulp}, x::T, y::T, ::RoundingMode{:Down}) where {T<:Union{Float16,Float32,Float64}} = prevfloat(CoreMath.$coremath_f(x, y))
        _fround(::typeof($f), ::IntervalRounding{:ulp}, x::T, y::T, ::RoundingMode{:Up}) where {T<:Union{Float16,Float32,Float64}} = nextfloat(CoreMath.$coremath_f(x, y))

        _fround(::typeof($f), ::IntervalRounding{:none}, x::T, y::T, ::RoundingMode) where {T<:AbstractFloat} = $f(x, y)
    end
end

function rootn end # defined in arithmetic/power.jl

function _fround(::typeof(rootn), ::Union{IntervalRounding{:correct},IntervalRounding{:ulp}}, x::AbstractFloat, n::Integer, r::RoundingMode)
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

_fround(::typeof(rootn), ::IntervalRounding{:none}, x::AbstractFloat, n::Integer, ::RoundingMode) = x^(1//n)





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
            if op == :_unbounded_mul
                return :( _unbounded_mul($(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            else
                return :( _fround($op, $(esc(ex.args[2])), $(esc(ex.args[3])), $r) )
            end
        elseif op ∈ (:+, :-) # unary operator that does not need rounding
            return :( $(esc(ex)) )
        else # unary operator
            return :( _fround($op, $(esc(ex.args[2])), $r) )
        end
    else
        return :( $(esc(ex)) )
    end
end

_round_expr(ex, _) = ex
