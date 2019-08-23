# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described in sections 9.5 of the
    IEEE Std 1788-2015 (Boolean functions of intervals) and/or required for
    set-based flavor in section 10.5.9.
    
    Some other (non required) related functions are also present, as well as
    some of the "Recommended operations" (section 10.6.3).
=#

# Equivalent to `<` but with Inf < Inf being true.
function islessprime(a::Real, b::Real)
    (isinf(a) || isinf(b)) && a == b && return true
    return a < b
end

"""
    isidentical(a, b)

Checks if the intervals `a` and `b` are identical.

Implement the `equal` function of the IEEE Std 1788-2015  (Table 9.3).
"""
function isidentical(a::AbstractFlavor, b::AbstractFlavor)
    isempty(a) && isempty(b) && return true
    a.lo == b.lo && a.hi == b.hi
end

"""
    isdistinct(a, b)

Checks if the intervals `a` and `b` are not identical.
"""
isdistinct(a::F, b::F) where {F <: AbstractFlavor} = !isidentical(a, b)

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

"""
    ⊆(a,b)

Checks if `a` is a strict subset of interval `b`.
"""
function ⊂(a::AbstractFlavor, b::AbstractFlavor)
    isidentical(a, b) && return false
    return a ⊆ b
end

⊇(a::AbstractFlavor, b::AbstractFlavor) = b ⊆ a
⊃(a::AbstractFlavor, b::AbstractFlavor) = b ⊂ a

"""
    isless(a, b)

Checks if the interval `a` is weakly less than interval `b`.

Note that this is not equivalent as saying every element of `a` is less than
any element of `b`.

Implement the `less` function of the IEEE Std 1788-2015 (Table 10.3).
"""
function isless(a::F, b::F) where {F <: AbstractFlavor}
    isempty(a) && isempty(b) && return true
    (isempty(a) || isempty(b)) && return false
    (a.lo ≤ b.lo) && (a.hi ≤ b.hi)
end

"""
    precedes(a, b)

Checks if the interval `a` is to the left of interval `b`.

Implement the `precedes` function of the IEEE Std 1788-2015 (Table 10.3).
"""
function precedes(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return true
    a.hi ≤ b.lo
end

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
strictprecedes(a, b)

Checks if the interval `a` is strictly to the left of interval `b`.

Implement the `strictPrecedes` function of the IEEE Std 1788-2015 (Table 10.3).
"""
function strictprecedes(a::F, b::F) where {F <: AbstractFlavor}
    (isempty(a) || isempty(b)) && return true
    a.hi < b.lo
end

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
