"""
    Flavor{F}

Super type of all interval flavors.

A flavor defines (following the IEEE Std 1788-2015) how an interval behave
in edge cases. This mostly makes a difference when dealing with
infinity and division by zero.

Currently only Flavor{:set_based} is supported.

- `:set_based` (default) : Elements of an interval are real number.
    In particular, infinity is never part of an interval and is only used as a
    shorthand.
    For example, the interval `(2..Inf)` contain all real number greater than 2.
    In particular, this means that `(Inf..Inf)` is an empty interval, and division
    by a thin zero return the empty interval.
    The edge cases are
        - `x/(0..0) ≛ ∅`
        - `(0..0)/(0..0) ≛ ∅`
        - `(0..0)*(-Inf..Inf) ≛ 0`
        - `Inf ∈ (0..Inf) == false`
    This flavor is described and required in part 2 of the IEEE Std 1799-2015.
- `:cset` (not implemented) : Elements of an interval are either real numbers
    or `±Inf`, applying standard rule for arithmetic with infinity.
    The edge cases are
        - `x/(0..0) ≛ (-Inf..Inf)`
        - `(0..0)/(0..0) ≛ (-Inf..Inf)`
        - `(0..0)*(-Inf..Inf) ≛ (-Inf..Inf)`
        - `Inf ∈ (0..Inf) == true`
"""
struct Flavor{F} end

current_flavor() = Flavor{:set_based}()

# :set_based
"""
    zero_times_infinity(::Flavor, ::Type{T})

Return the result of zero times positive infinity for the given flavor
and number type `T`.
"""
zero_times_infinity(::Flavor{:set_based}, ::Type{T}) where T = zero(T)

"""
    div_by_thin_zero(::Flavor, x)

Divide `x` by the interval containing only `0`.
"""
function div_by_thin_zero(::Flavor{:set_based}, x::Interval{T}) where T
    return emptyinterval(T)
end

contains_infinity(::Flavor{:set_based}, x::Interval) = false

"""
    is_valid_interval(a::Real, b::Real)

Check if `(a, b)` constitute a valid interval.
"""
function is_valid_interval(::Flavor{:set_based}, a::Real, b::Real)
    if isnan(a) || isnan(b)
        return false
    end

    a > b && return false

    if a == Inf || b == -Inf
        return false
    end

    return true
end

# Default
zero_times_infinity(T) = zero_times_infinity(current_flavor(), T)
div_by_thin_zero(x) = div_by_thin_zero(current_flavor(), x)
contains_infinity(x) = contains_infinity(current_flavor(), x)
is_valid_interval(a, b) = is_valid_interval(current_flavor(), a, b)
is_valid_interval(a::Real) = is_valid_interval(a, a)