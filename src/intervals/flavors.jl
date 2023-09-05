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
        - `isequalinterval(x/(0..0), ∅)`
        - `isequalinterval((0..0)/(0..0), ∅)`
        - `isequalinterval((0..0)*(-Inf..Inf), 0)`
        - `ismember(Inf, (0..Inf)) == false`
    This flavor is described and required in part 2 of the IEEE Std 1799-2015.
- `:cset` (not implemented) : Elements of an interval are either real numbers
    or `±Inf`, applying standard rule for arithmetic with infinity.
    The edge cases are
        - `isequalinterval(x/(0..0), (-Inf..Inf))`
        - `isequalinterval((0..0)/(0..0), (-Inf..Inf))`
        - `isequalinterval((0..0)*(-Inf..Inf), (-Inf..Inf))`
        - `ismember(Inf, (0..Inf)) == true`
"""
struct Flavor{F} end

current_flavor() = Flavor{:set_based}()

# :set_based

"""
    zero_times_infinity(::Flavor, ::Type{T})

Return the result of zero times positive infinity for the given flavor
and number type `T`.
"""
zero_times_infinity(::Flavor{:set_based}, ::Type{T}) where {T<:NumTypes} = zero(T)

zero_times_infinity(::Type{T}) where {T<:NumTypes} = zero_times_infinity(current_flavor(), T)

"""
    div_by_thin_zero(::Flavor, x::Interval)

Divide `x` by the interval containing only `0`.
"""
div_by_thin_zero(::Flavor{:set_based}, ::Interval{T}) where {T<:NumTypes} =
    emptyinterval(T)

div_by_thin_zero(x::Interval) = div_by_thin_zero(current_flavor(), x)

contains_infinity(::Flavor{:set_based}, ::Interval) = false

contains_infinity(x::Interval) = contains_infinity(current_flavor(), x)

"""
    is_valid_interval(a, b)

Check if `(a, b)` constitute a valid interval.
"""
is_valid_interval(::Flavor{:set_based}, ::Type{T}, a, b) where {T<:NumTypes} =
    !(isnan(a) | isnan(b) | (a > b) | (a == typemax(T)) | (b == typemin(T)))

is_valid_interval(::Type{T}, a, b) where {T<:NumTypes} = is_valid_interval(current_flavor(), T, a, b)

is_valid_interval(a, b) = is_valid_interval(default_numtype(), a, b)

is_valid_interval(a) = is_valid_interval(a, a)
