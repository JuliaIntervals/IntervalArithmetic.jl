# TODO Add support for Cset flavor
# TODO Properly document everything
# TODO Make Cset the default ?
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
        - `(0..0)/(0..0) ≛ (-Inf..Inf)`  # TODO Check that
        - `(0..0)*(-Inf..Inf) ≛ 0`
        - `Inf ∈ (0..Inf) == false`
- `:cset` (not implemented) : Elements of an interval are either real numbers
    or `±Inf`, applying standard rule for arithmetic with infinity.
    The edge cases are  # TODO Check those rules
        - `x/(0..0) ≛ (-Inf..Inf)`
        - `(0..0)/(0..0) ≛ (-Inf..Inf)`
        - `(0..0)*(-Inf..Inf) ≛ (-Inf..Inf)`
        - `Inf ∈ (0..Inf) == true`
"""
abstract type Flavor{F} end

const SetBased = Flavor{:set_based}

current_flavor() = Flavor{:set_based}()

"""
    zero_times_infinity(::Flavor, T)

Return the result of zero times positive infinity for the given flavor.
"""
zero_times_infinity(::SetBased, ::Type{T}) where T = zero(T)

"""
    inv_of_zero(::Flavor, T)

Inverse of the interval containing only `0`.
"""
function div_by_zero(::SetBased, x::Interval{T}) where T
    0 ∈ x && return RR(T)
    return emptyinterval(T)
end

contains_infinity(::SetBased, x::Interval) = false