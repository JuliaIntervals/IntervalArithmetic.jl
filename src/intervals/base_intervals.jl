# This file is part of the IntervalArithmetic.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

## Interval type

if haskey(ENV, "IA_VALID") == true
    const validity_check = true
else
    const validity_check = false
end


"""
    BaseInterval{T<:Real}

Interval representation of an interval. Use `IntervalBool` three valued logic
rather than `Bool` on comparisons and similar functions.
"""
struct BaseInterval{T<:Real}
    lo :: T
    hi :: T

    function BaseInterval{T}(a::Real, b::Real) where T<:Real
        if validity_check
            if is_valid_BaseInterval(a, b)
                new(a, b)
            else
                throw(ArgumentError("Interval of form [$a, $b] not allowed. " *
                    "Must have a ≤ b to construct BaseInterval(a, b)."))
            end
        end

        new(a, b)
    end
end

## Outer constructors

BaseInterval(a::T, b::T) where {T<:Real} = BaseInterval{T}(a, b)
BaseInterval(a::T) where {T<:Real} = BaseInterval(a, a)
BaseInterval(a::Tuple) = BaseInterval(a...)
BaseInterval(a::T, b::S) where {T<:Real, S<:Real} = BaseInterval(promote(a,b)...)

## Concrete constructors for Interval, to effectively deal only with Float64,
# BigFloat or Rational{Integer} intervals.
BaseInterval(a::T, b::T) where {T<:Integer} = BaseInterval(float(a), float(b))
BaseInterval(a::T, b::T) where {T<:Irrational} = BaseInterval(float(a), float(b))

eltype(::BaseInterval{T}) where {T<:Real} = T

BaseInterval(x::BaseInterval) = x
BaseInterval(x::Complex) = BaseInterval(real(x)) + im*BaseInterval(imag(x))

BaseInterval{T}(x) where {T} = BaseInterval(convert(T, x))

BaseInterval{T}(x::BaseInterval) where T = atomic(BaseInterval{T}, x)

size(x::BaseInterval) = (1,)


"""
    is_valid_BaseInterval(a::Real, b::Real)

Check if `(a, b)` constitute a valid interval
"""
function is_valid_interval(a::Real, b::Real)
    if isnan(a) || isnan(b)
        if isnan(a) && isnan(b)
            return true
        else
            return false
        end
    end

    if a > b
        if isinf(a) && isinf(b)
            return true  # empty interval = [∞,-∞]
        else
            return false
        end
    end

    if a == Inf || b == -Inf
        return false
    end

    return true
end

"""
    BaseInterval(a, b)

`BaseInterval(a, b)` checks whether [a, b] is a valid `BaseInterval`, which
is the case if `-∞ <= a <= b <= ∞`, using the (non-exported) `is_valid_interval`
function. If so, then a `BaseInterval(a, b)` object is returned; if not, then an
error is thrown.
"""
function BaseInterval(a::Real, b::Real)
    if !is_valid_interval(a, b)
        throw(ArgumentError("`[$a, $b]` is not a valid interval. Need `a ≤ b` to construct `BaseInterval(a, b)`."))
    end

    return BaseInterval(a, b)
end

BaseInterval(a::Real) = BaseInterval(a, a)
BaseInterval(a::BaseInterval) = a

"Make an interval even if a > b"
function force_interval(a, b)
    a > b && return BaseInterval(b, a)
    return BaseInterval(a, b)
end

"""
Computes the integer hash code for an `Interval` using the method for composite types used in `AutoHashEquals.jl`
"""
hash(x::BaseInterval, h::UInt) = hash(x.hi, hash(x.lo, hash(:Interval, h)))
