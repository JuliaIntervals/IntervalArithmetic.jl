"""
    Flavor{F}

A flavor defining how an interval behaves in edge cases. For instance, infinity
may or not be considered part of unbounded intervals.

Some flavors `F` include:
- `:set_based` (default): elements of an interval are real numbers. In
    particular, infinity is never part of an interval. This flavor is described
    and required in Part 2 of the IEEE Standard 1788-2015.
    Edge cases:
        - any unbounded interval does not contain infinity.
        - ``[0, 0] / [0, 0] = \\emptyset``.
        - ``x / [0, 0] = \\emptyset`` for any interval ``x``.
        - ``x \\times [0, 0] = [0, 0]`` for any interval ``x``.
- `:cset`: elements of an interval are either real numbers,
    or ``\\pm \\infty``, applying standard rule for arithmetic with infinity.
    Edge cases:
        - any unbounded interval contains infinity.
        - ``[0, 0] / [0, 0] = [-\\infty, \\infty]``.
        - ``x / [0, 0] = [-\\infty, \\infty]`` for any interval ``x``.
        - ``x \\times [0, 0] = [-\\infty, \\infty]`` for any unbounded interval
          ``x``.

!!! note
    Currently only the flavor `:set_based` is supported and implemented.

# Examples

```jldoctest
julia> IntervalArithmetic.is_valid_interval(Inf, Inf)
false

julia> isempty_interval(bareinterval(0)/bareinterval(0))
true

julia> isempty_interval(bareinterval(1)/bareinterval(0))
true

julia> isempty_interval(bareinterval(-Inf, Inf)/bareinterval(0))
true

julia> isthinzero(bareinterval(0)*bareinterval(-Inf, Inf))
true
```
"""
struct Flavor{F} end

#

"""
    zero_times_infinity([F::Flavor,] T<:NumTypes)

For the given flavor `F`, return ``0 \\times \\infty`` as an instance of type
`T`.
"""
zero_times_infinity(::Flavor{:set_based}, ::Type{T}) where {T<:NumTypes} = zero(T)

"""
    div_by_thin_zero([F::Flavor,] x::BareInterval)

For the given flavor `F`, divide `x` by the interval containing only ``0``.
"""
div_by_thin_zero(::Flavor{:set_based}, ::BareInterval{T}) where {T<:NumTypes} =
    emptyinterval(BareInterval{T})

"""
    contains_infinity([F::Flavor,] x::BareInterval)

For the given flavor `F`, test whether `x` contains infinity.
"""
contains_infinity(::Flavor{:set_based}, ::BareInterval) = false

"""
    is_valid_interval([F::Flavor,] a::Real, b::Real)

For the given flavor `F`, test whether ``[a, b]`` is a valid interval.
"""
is_valid_interval(::Flavor{:set_based}, a::Real, b::Real) = b - a ≥ 0
# to prevent issues with division by zero, e.g. `is_valid_interval(1//0, 1//0)`
is_valid_interval(::Flavor{:set_based}, a::Rational, b::Rational) =
    !((a > b) | (a == typemax(typeof(a))) | (b == typemin(typeof(b))))
