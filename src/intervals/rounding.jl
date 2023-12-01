#= Design summary:

This is a so-called "traits-based" design, as follows.

The main body of the file defines versions of elementary functions with all allowed
interval rounding types, e.g.
+(IntervalRounding{:fast}(), a, b, RoundDown)
+(IntervalRounding{:tight}(), a, b, RoundDown)
+(IntervalRounding{:accurate}(), a, b, RoundDown)
+(IntervalRounding{:slow}(), a, b, RoundDown)
+(IntervalRounding{:none}(), a, b, RoundDown)

The current allowed rounding types are
- :fast  # fast, tight (correct) rounding with errorfree arithmetic via FastRounding.jl
- :tight  # tight (correct) rounding with improved errorfree arithmetic via RoundingEmulator.jl
- :accurate  # fast "accurate" rounding using prevfloat and nextfloat  (slightly wider than needed)
- :slow  # tight (correct) rounding by changing rounding mode (slow)
- :none  # no rounding (for speed comparisons; no enclosure is guaranteed)

All function on intervals are then defined by default as
    +(IntervalArithmetic.interval_rounding(), a, b, RoundDown)

By rededfining `IntervalArithmetic.interval_rounding()`, the user can
select the default.

Moreover the `:slow` rounding mode is used as a fallback if the chosen
rounding mode is not available.
This is done by defining the generic case as
    +(::IntervalRounding, a, b, RoundDown) = +(IntervalRounding{:slow}(), a, b, RoundDown)
=#


"""
    IntervalRounding{T}

Interval rounding trait type.

Allowed rounding types are
- `:tight`: fast, tight (correct) rounding with errorfree arithmetic via
            FastRounding.jl.
- `:accurate`: fast "accurate" rounding using prevfloat and nextfloat
               (slightly wider than needed).
- `:slow`: tight (correct) rounding by changing rounding mode (slow).
- `:none`: no rounding (for speed comparisons; no enclosure is guaranteed).
"""
struct IntervalRounding{T} end

## Default
const rounding_types = (:fast, :tight, :accurate, :slow, :none)

interval_rounding() = IntervalRounding{:tight}()

# BigFloat conversion
Base.convert(::Type{BigFloat}, x, rounding_mode::RoundingMode) =
    setrounding(BigFloat, rounding_mode) do
        convert(BigFloat, x)
    end

# Parsing from string
Base.parse(::Type{T}, x::AbstractString, rounding_mode::RoundingMode) where T = setrounding(Float64, rounding_mode) do
    return float(parse(T, x))
end

# use higher precision float parser to get round issues on Windows
@static if Sys.iswindows()
    function Base.parse(::Type{Float64}, s::AbstractString, r::RoundingMode)
        a = setprecision(BigFloat, 53) do
                setrounding(BigFloat, r) do
                    parse(BigFloat, s)   # correctly takes account of rounding mode
                end
            end

        return Float64(a, r)
    end

    function Base.parse(::Type{T}, s::AbstractString, r::RoundingMode) where {T <: Union{Float16, Float32}}
        return T(parse(Float64, s, r), r)
    end
end


## Functions that are the same for all rounding types:
Base.:+(a::T, ::RoundingMode) where {T<:AbstractFloat} =  a  # ignore rounding
Base.:-(a::T, ::RoundingMode) where {T<:AbstractFloat} = -a  # ignore rounding
Base.zero(::Interval{T}, ::RoundingMode) where {T<:AbstractFloat} = zero(T)
Base.zero(::Type{T}, ::RoundingMode) where {T<:AbstractFloat} = zero(T)

## Rationals
# TODO Restore full support for rational intervals
# no-ops for rational rounding:
for f ∈ (:+, :-, :*, :/)
    @eval Base.$f(a::T, b::T, ::RoundingMode) where {T<:Rational} = $f(a, b)
end

function Base.sqrt(a::T, rounding_mode::RoundingMode) where {T<:Rational}
    setrounding(float(T), rounding_mode) do
        return sqrt(float(a))
    end
end


for f ∈ (:exp2, :exp10, :cbrt)
    @eval function Base.$f(x::BigFloat, r::RoundingMode)  # add BigFloat functions with rounding:
        setrounding(BigFloat, r) do
            $f(x)
        end
    end
end


rounding_directions = [
    (:down, RoundingMode{:Down}, prevfloat),
    (:up, RoundingMode{:Up}, nextfloat)
]

for (dir, RoundingDirection, outfloat) ∈ rounding_directions
    #= :fast and :tight for functions supported by FastRounding.jl
        and RoundingEmulator.jl respectively =#
    # NOTE RoundingEmulator.jl only works with Float32 and Float64
    for (op, f) ∈ ( (:+, :add), (:-, :sub), (:*, :mul), (:/, :div) )
        @eval function Base.$op(::IntervalRounding{:fast}, a, b, ::$RoundingDirection)
            return FastRounding.$(Symbol(f, "_round"))(a, b, $RoundingDirection())
        end

        @eval function Base.$op(
                ::IntervalRounding{:tight}, a::T, b::T,
                ::$RoundingDirection) where {T<:Union{Float32, Float64}}
            return RoundingEmulator.$(Symbol(f, "_", dir))(a, b)
        end
    end

    # Sqrt
    @eval function Base.sqrt(::IntervalRounding{:fast}, a, ::$RoundingDirection)
        return FastRounding.sqrt_round(a, $dir)
    end

    @eval function Base.sqrt(::IntervalRounding{:tight}, a::Union{Float32, Float64}, ::$RoundingDirection)
        return RoundingEmulator.$(Symbol("sqrt_", dir))(a)
    end

    # Inverse
    @eval function Base.inv(::IntervalRounding{:fast}, a, ::$RoundingDirection)
        return FastRounding.inv_round(a, $dir)
    end

    @eval function Base.inv(::IntervalRounding{:tight}, a::Union{Float32, Float64}, ::$RoundingDirection)
        return RoundingEmulator.$(Symbol("div_", dir))(one(a), a)
    end

    #= :accurate and :slow =#
    # Power
    @eval function Base.:^(::IntervalRounding{:accurate}, a::AbstractFloat, b, ::$RoundingDirection)
        return $outfloat(a^b)
    end

    @eval function Base.:^(::IntervalRounding{:slow}, a::BigFloat, b::AbstractFloat, ::$RoundingDirection)
        setrounding(BigFloat, $RoundingDirection()) do
            return a^b
        end
    end

    # Correct rounding of other floats must pass through BigFloat
    @eval function Base.:^(::IntervalRounding{:slow}, a::T, b, ::$RoundingDirection) where {T<:AbstractFloat}
        setprecision(BigFloat, 53) do
            return T(^(IntervalRounding{:slow}, BigFloat(a), b, $RoundingDirection()))
        end
    end

    # Binary function
    for f ∈ (:+, :-, :*, :/, :^, :atan)
        @eval function Base.$f(::IntervalRounding{:accurate}, a::T, b::T, ::$RoundingDirection) where {T<:AbstractFloat}
            return $outfloat($f(a, b))
        end

        @eval function Base.$f(::IntervalRounding{:slow}, a::T, b::T, ::$RoundingDirection) where {T<:AbstractFloat}
            setrounding(T, $RoundingDirection()) do
                return $f(a, b)
            end
        end
    end

    # Unary functions not in CRlibm
    for f ∈ (:sqrt, :inv, :cot, :sec, :csc, :acot,
            :tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth)
        @eval function Base.$f(::IntervalRounding{:accurate}, a::AbstractFloat, ::$RoundingDirection)
            return $outfloat($f(a))
        end

        @eval function Base.$f(::IntervalRounding{:slow}, a::T, ::$RoundingDirection) where {T<:AbstractFloat}
            setrounding(T, $RoundingDirection()) do
                return $f(a)
            end
        end
    end

    # Functions defined in CRlibm
    for f ∈ CRlibm.functions
        if isdefined(Base, f)
            @eval function Base.$f(::IntervalRounding{:accurate}, a::AbstractFloat, ::$RoundingDirection)
                return $outfloat($f(a))
            end

            @eval function Base.$f(::IntervalRounding{:slow}, a::AbstractFloat, ::$RoundingDirection)
                return CRlibm.$f(a, $RoundingDirection())
            end
        else
            @eval function $f(::IntervalRounding{:accurate}, a::AbstractFloat, ::$RoundingDirection)
                return $outfloat($f(a))
            end

            @eval function $f(::IntervalRounding{:slow}, a::AbstractFloat, ::$RoundingDirection)
                return CRlibm.$f(a, $RoundingDirection())
            end
        end
    end
end

#= Default definitions, fallback and :none =#
# Unary functions
for f ∈ vcat(CRlibm.functions, [:sqrt, :inv, :cot, :sec, :csc, :acot, :tanh, :coth, :sech, :csch, :asinh, :acosh, :atanh, :acoth])
    if isdefined(Base, f)
        @eval Base.$f(a::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), a, r)
        @eval Base.$f(a::Real, r::RoundingMode) = $f(interval_rounding(), float(a), r)

        # Fallback to :slow if the requested interval rounding is unavailable
        @eval function Base.$f(::IntervalRounding, a, r::RoundingMode)
            return $f(IntervalRounding{:slow}(), a, r)
        end

        # No rounding
        @eval function Base.$f(::IntervalRounding{:none}, a, r::RoundingMode)
            return $f(a)
        end
    else
        @eval $f(a::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), a, r)
        @eval $f(a::Real, r::RoundingMode) = $f(interval_rounding(), float(a), r)

        # Fallback to :slow if the requested interval rounding is unavailable
        @eval function $f(::IntervalRounding, a, r::RoundingMode)
            return $f(IntervalRounding{:slow}(), a, r)
        end

        # No rounding
        @eval function $f(::IntervalRounding{:none}, a, r::RoundingMode)
            return $f(a)
        end
    end
end

# Binary functions
for f ∈ (:+, :-, :*, :/, :^, :atan)
    @eval Base.$f(a::T, b::T, r::RoundingMode) where {T<:AbstractFloat} = $f(interval_rounding(), a, b, r)
    @eval Base.$f(a::Real, b::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), promote(a, b)..., r)
    @eval Base.$f(a::AbstractFloat, b::Real, r::RoundingMode) = $f(interval_rounding(), promote(a, b)..., r)
    @eval Base.$f(a::AbstractFloat, b::AbstractFloat, r::RoundingMode) = $f(interval_rounding(), promote(a, b)..., r)
    @eval Base.$f(a::Real, b::Real, r::RoundingMode) = $f(interval_rounding(), float(a), float(b), r)

    # Fallback to :slow if the requested interval rounding is unavailable
    @eval function Base.$f(::IntervalRounding, a, b, r::RoundingMode)
        return $f(IntervalRounding{:slow}(), a, b, r)
    end

    # No rounding
    @eval function Base.$f(::IntervalRounding{:none}, a, b, r::RoundingMode)
        return $f(a, b)
    end
end

# prevents multiple threads from calling `setprecision` concurrently, used in `_bigequiv`
const precision_lock = ReentrantLock()

"""
    _bigequiv(x)

Create a `BigFloat` equivalent with the same underlying precision as `x`.
"""
function _bigequiv(x::BareInterval{T}) where {T<:NumTypes}
    lock(precision_lock) do
        setprecision(precision(float(T))) do
            return BareInterval{BigFloat}(x)
        end
    end
end

function _bigequiv(x::T) where {T<:NumTypes}
    lock(precision_lock) do
        setprecision(precision(float(T))) do
            return BigFloat(x)
        end
    end
end
