# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described in sections 9.5 of the
    IEEE Std 1788-2015 (Boolean functions of intervals), together with some 
    similar functions.
=#

"""
    isidentical(a, b)

Checks if the intervals `a` and `b` are identical.

Implement the `equal` function of the IEEE Std 1788-2015  (Table 9.3).
"""
function isidentical(a::F, b::F) where {F <: AbstractFlavor}
    isempty(a) && isempty(b) && return true
    a.lo == b.lo && a.hi == b.hi
end

"""
    isdistinct(a, b)

Checks if the intervals `a` and `b` are not identical.
"""
isdistinct(a::F, b::F) where {F <: AbstractFlavor} = !isidentical(a, b)

"""
    in(x, a)
    ∈(x, a)

Checks if the number `x` is a member of the interval `a`, treated as a set.

Implement the `isMember` function of the IEEE Std 1788-2015 (section 10.6.3).
"""
function in(x::Real, a::AbstractFlavor)
    isinf(x) && return false
    a.lo <= x <= a.hi
end

in(x::AbstractFlavor, y::AbstractFlavor) = throw(ArgumentError("$x ∈ $y is not defined"))
in(x::Real, a::Complex{F}) where {F <: AbstractFlavor} = x ∈ real(a) && 0 ∈ imag(a)
in(x::Complex{T}, a::Complex{F}) where {T <: Real, F <: AbstractFlavor} = real(x) ∈ real(a) && imag(x) ∈ imag(a)

"""
    issubset(a,b)
    ⊆(a,b)

Checks if all the points of the interval `a` are within the interval `b`.

Implement the `subset` function of the IEEE Std 1788-2015 (Table 9.3).
"""
function ⊆(a::AbstractFlavor, b::AbstractFlavor)
    isempty(a) && return true
    b.lo ≤ a.lo && a.hi ≤ b.hi
end

function ⊂(a::AbstractFlavor, b::AbstractFlavor)
    isidentical(a, b) && return false
    return a ⊆ b
end

⊇(a::AbstractFlavor, b::AbstractFlavor) = b ⊆ a
⊃(a::AbstractFlavor, b::AbstractFlavor) = b ⊂ a

"""
    isinterior(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `interior` function of the IEEE Std 1788-2015 (Table 9.3).
"""
function isinterior(a::AbstractFlavor, b::AbstractFlavor)
    isempty(a) && return true
    return islessprime(b.lo, a.lo) && islessprime(a.hi, b.hi)
end
const ⪽ = isinterior  # \subsetdot

"""
    isdisjoint(a,b)

Checks if all the points of the interval `a` are within the interior of
interval `b`.

Implement the `disjoint` function of the IEEE Std 1788-2015 (Table 9.3).
"""
function isdisjoint(a::AbstractFlavor, b::AbstractFlavor)
    (isempty(a) || isempty(b)) && return true
    return islessprime(b.hi, a.lo) || islessprime(a.hi, b.lo)
end

function isdisjoint(a::Complex{F}, b::Complex{F}) where {F <: AbstractFlavor}
    return isdisjoint(real(a),real(b)) || isdisjoint(imag(a),imag(b))
end