# This file is part of the IntervalArithmetic.jl package; MIT licensed


## Comparisons



"""
    isless(a, b)

Checks if the interval `a` is weakly less than interval `b`.

Corresponds to the IEEE Standard `less` function (Table 10.3).
"""
function isless(a::F, b::F) where {F <: AbstractFlavor}
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    (a.lo ≤ b.lo) && (a.hi ≤ b.hi)
end

# Equivalent to < but Inf < Inf returning true
# TODO double check, should probably flavor dependant
function islessprime(a::Real, b::Real)
    (isinf(a) || isinf(b)) && a == b && return true
    return a < b
end

"""
    isstrictless(a, b)

Checks if the interval `a` is strictly less than interval `b`.

Implement the `strictLess` function of the IEEE Std 1788-2015 (Table 10.3).
"""
function isstrictless(a::F, b::F) where {F <: AbstractFlavor}
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    islessprime(a.lo, b.lo) && islessprime(a.hi, b.hi)  # TODO check this line in the standard
end

"""
    precedes(a, b)

Checks if the interval `a` is to the left of interval `b`.

Corresponds to the IEEE Standard `precedes` function (Table 10.3).
"""
function precedes(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return true
    a.hi ≤ b.lo
end
const ≼ = precedes # \preccurlyeq

"""
    strictprecedes(a, b)

Checks if the interval `a` is strictly to the left of interval `b`.

Corresponds to the IEEE Standard `strictPrecedes` function (Table 10.3).
"""
function strictprecedes(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return true
    a.hi < b.lo
end

# zero, one, typemin, typemax
# These are not defined in the IEEE standard
# TODO move these early in the loading process
# TODO move these to the conversion file
real(a::Interval) = a
zero(a::F) where {T <: Real, F <: AbstractFlavor{T}} = F(zero(T))
zero(::Type{F}) where {T <: Real, F <: AbstractFlavor{T}} = F(zero(T))
one(a::F) where {T <: Real, F <: AbstractFlavor{T}} = F(one(T))
one(::Type{F}) where {T <: Real, F <: AbstractFlavor{T}} = F(one(T))
typemin(::Type{F}) where {T <: Real, F <: AbstractFlavor{T}} = wideinterval(F, typemin(F))
typemax(::Type{F}) where {T <: Real, F <: AbstractFlavor{T}} = wideinterval(F, typemax(T))
typemin(::Type{F}) where {T <: Integer, F <: AbstractFlavor{T}} = F(typemin(T))
typemax(::Type{F}) where {T <: Integer, F <: AbstractFlavor{T}} = F(typemax(T))


"""
    extended_div(a::AbstractFlavor, b::AbstractFlavor)

Two-output division.

Corresponds to the IEEE standard `mulRevToPair` function (section 10.5.5).
"""
# TODO check this function and corresponding github issue (iirc)
# TODO check for flavor dependent edge cases
# TODO move to its own file
function extended_div(a::F, b::F) where {T, F <: AbstractFlavor{T}}
    if 0 < b.hi && 0 > b.lo && 0 ∉ a
        if a.hi < 0
            return (F(T(-Inf), a.hi / b.hi), F(a.hi / b.lo, T(Inf)))

        elseif a.lo > 0
            return (F(T(-Inf), a.lo / b.lo), F(a.lo / b.hi, T(Inf)))

        end
    elseif 0 ∈ a && 0 ∈ b
        return (RR(F), emptyinterval(F))
    else
        return (a / b, emptyinterval(F))
    end

    return (a / b, emptyinterval(S))
end

dist(a::Interval, b::Interval) = max(abs(a.lo-b.lo), abs(a.hi-b.hi))
eps(a::Interval) = Interval(max(eps(a.lo), eps(a.hi)))
eps(::Type{Interval{T}}) where T<:Real = Interval(eps(T))

interval_from_midpoint_radius(midpoint, radius) = Interval(midpoint-radius, midpoint+radius)

isinteger(a::Interval) = (a.lo == a.hi) && isinteger(a.lo)

convert(::Type{Integer}, a::Interval) = isinteger(a) ?
        convert(Integer, a.lo) : throw(ArgumentError("Cannot convert $a to integer"))
