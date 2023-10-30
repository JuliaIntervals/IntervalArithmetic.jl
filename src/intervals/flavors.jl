"""
    Flavor{F}

Super type of all interval flavors.

A flavor defines (following the IEEE Std 1788-2015) how an interval behaves
in edge cases. This mostly makes a difference when dealing with
infinity and division by zero.

Currently only Flavor{:set_based} is supported.

- `:set_based` (default) : Elements of an interval are real number.
    In particular, infinity is never part of an interval and is only used as a
    shorthand.
    For example, the interval `(2..Inf)` contain all real number greater than 2.
    In particular, this means that `(Inf..Inf)` is an empty interval, and division
    by a thin zero returns the empty interval.
    The edge cases are
        - `isequal_interval(x/(0..0), ∅)`
        - `isequal_interval((0..0)/(0..0), ∅)`
        - `isequal_interval((0..0)*(-Inf..Inf), 0)`
        - `in_interval(Inf, (0..Inf)) == false`
    This flavor is described and required in part 2 of the IEEE Std 1799-2015.
- `:cset` (not implemented) : Elements of an interval are either real numbers
    or `±Inf`, applying standard rule for arithmetic with infinity.
    The edge cases are
        - `isequal_interval(x/(0..0), (-Inf..Inf))`
        - `isequal_interval((0..0)/(0..0), (-Inf..Inf))`
        - `isequal_interval((0..0)*(-Inf..Inf), (-Inf..Inf))`
        - `in_interval(Inf, (0..Inf)) == true`
"""
struct Flavor{F} end

default_flavor() = Flavor{:set_based}()

# :set_based

"""
    zero_times_infinity(::Flavor, ::Type{T})

Return the result of zero times positive infinity for the given flavor
and number type `T`.
"""
zero_times_infinity(::Flavor{:set_based}, ::Type{T}) where {T<:NumTypes} = zero(T)

zero_times_infinity(::Type{T}) where {T<:NumTypes} = zero_times_infinity(default_flavor(), T)

"""
    div_by_thin_zero(::Flavor, x::BareInterval)

Divide `x` by the interval containing only `0`.
"""
div_by_thin_zero(::Flavor{:set_based}, ::BareInterval{T}) where {T<:NumTypes} =
    emptyinterval(BareInterval{T})

div_by_thin_zero(x::BareInterval) = div_by_thin_zero(default_flavor(), x)

contains_infinity(::Flavor{:set_based}, ::BareInterval) = false

contains_infinity(x::BareInterval) = contains_infinity(default_flavor(), x)

"""
    is_valid_interval(a, b)

Check if `(a, b)` constitute a valid interval.
"""
is_valid_interval(::Flavor{:set_based}, a, b) = b - a ≥ 0

is_valid_interval(a, b) = is_valid_interval(default_flavor(), a, b)

is_valid_interval(a) = is_valid_interval(a, a)
