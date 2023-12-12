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
julia> IntervalArithmetic.default_flavor()
IntervalArithmetic.Flavor{:set_based}()

julia> isempty_interval(bareinterval(Inf, Inf))
┌ Warning: invalid interval, empty interval is returned
└ @ IntervalArithmetic ~/work/IntervalArithmetic.jl/IntervalArithmetic.jl/src/intervals/construction.jl:202
true

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

"""
    default_flavor()

Return the default flavor used to handle edge cases.
"""
default_flavor() = Flavor{:set_based}()

"""
    zero_times_infinity([F::Flavor=default_flavor()], T<:NumTypes)

For the given flavor `F`, return ``0 \\times \\infty`` as an instance of type
`T`.
"""
zero_times_infinity(::Flavor{:set_based}, ::Type{T}) where {T<:NumTypes} = zero(T)

zero_times_infinity(::Type{T}) where {T<:NumTypes} = zero_times_infinity(default_flavor(), T)

"""
    div_by_thin_zero([F::Flavor=default_flavor()], x::BareInterval)

For the given flavor `F`, divide `x` by the interval containing only ``0``.
"""
div_by_thin_zero(::Flavor{:set_based}, ::BareInterval{T}) where {T<:NumTypes} =
    emptyinterval(BareInterval{T})

div_by_thin_zero(x::BareInterval) = div_by_thin_zero(default_flavor(), x)

"""
    contains_infinity([F::Flavor=default_flavor()], x::BareInterval)

For the given flavor `F`, test whether `x` contains infinity.
"""
contains_infinity(::Flavor{:set_based}, ::BareInterval) = false

contains_infinity(x::BareInterval) = contains_infinity(default_flavor(), x)

"""
    is_valid_interval([F::Flavor=default_flavor()], a::Real, b::Real)

For the given flavor `F`, test whether ``[a, b]`` is a valid interval.
"""
is_valid_interval(::Flavor{:set_based}, a::Real, b::Real) = b - a ≥ 0

is_valid_interval(a::Real, b::Real) = is_valid_interval(default_flavor(), a, b)
