# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains boolean operations defined for intervals.

    As there is no common consensus on how these operations should be defined for intervals,
    in addition to the behavior defined by the IEEE Std 1788-2015 (sec. 10.5.10),
    the file also implements different policies to handle these operations, allowing the user
    to choose the one most suited for their use case.

    We use a trait system, defining the operation with an extra
    `PointwisePolicy` argument defining how it should be handled.

    The default operations use `IntervalArithmetic.pointwise_policy()`,
    so in order to change the default behavior this function has to be
    redefined.
=#
"""
    PointwisePolicy{P}

Define which policy we use to extend pointwise comparison of

Valid values for the policy identifier `P` are
    - `:ieee` (default): Boolean operations as defined in the IEEE Std 1788-2015,
      see section 10.5.10
    - `:certainly` : A boolean operation is extended by asking "is it true for
        all elements of the interval(s) involved".
        This is self-consistent, but breaks the usual rules for negation of
        boolean operations.
        For example with this policy, `((-1..3) == 0) == false` because it
        answers the question "are all elements in (-1..3) equal to zero".
        However we also have `((-1..3) != 0) == false`, contrary to what is
        usually expected for the symbols `==` and `!=`.
        This *silently* breaks any code relying on such operation in conditional
        statements like `if x == 0 ... else ... end`.
    - `:interval` : A pointwise boolean operation `B` return the set of all
        possible outcome as a `BooleanInterval`.
        This is safe but very strict, always erroring when an interval is used
        in a conditional statement.
    - `:ternary`: With this policy return `missing` when the
        boolean operation does not return the same answer for all elements
        of the involved interval(s).
        This only causes error in conditional statements when hitting `missing`.
        When it does not error it is safe.

The current pointwise policy can be changed by overriding the function
`IntervalArithmetic.pointwise_policy()`.

Example
=======

          | (-1..3) > 2   | (-1..3) <= 2  | (-1..1) > 2 | (-1..1) < 2 |
----------|---------------|---------------|-------------|-------------|
:certainly   | false         | false         | false       | true        |
:interval | [true, false] | [true, false] | [false]     | [true]      |
:ternary  | missing       | missing       | false       | true        |

"""
struct PointwisePolicy{P} end

const pointwise_bool_operations = (
    :(==), :(!=), :<, :(<=), :>, :(>=)
)

const pointwise_bool_functions = (
    :isinf, :isfinite, :isinteger, :iszero
)

## :ieee
# See Table 10.3
==(::PointwisePolicy{:ieee}, x::Interval, y::Interval) = inf(x) == inf(y) && sup(x) == sup(y)

<(::PointwisePolicy{:ieee}, x::Interval, y::Interval) = isstrictless(x, y)

<=(::PointwisePolicy{:ieee}, x::Interval, y::Interval) = isweaklyless(x, y)

!=(::PointwisePolicy{:ieee}, x::Interval, y::Interval) = !(==(PointwisePolicy{:ieee}(), x, y))
>(::PointwisePolicy{:ieee}, x::Interval, y::Interval) = !<=(PointwisePolicy{:ieee}(), x, y)
>=(::PointwisePolicy{:ieee}, x::Interval, y::Interval) = !<(PointwisePolicy{:ieee}(), x, y)

# Boolean functions
# NOTE this interacts with flavors.
isinf(::PointwisePolicy{:ieee}, x::Interval) = contains_infinity(x) && isthin(x)

isfinite(::PointwisePolicy{:ieee}, x::Interval) = !isinf(PointwisePolicy{:ieee}(), x)
iszero(::PointwisePolicy{:ieee}, x::Interval) = isthinzero(x)

isinteger(::PointwisePolicy{:ieee}, x::Interval) = (inf(x) == sup(x)) && isinteger(inf(x))


## :ternary
function ==(::PointwisePolicy{:ternary}, x::Interval, y::Interval)
    isthin(x) && isthin(y) && inf(x) == inf(y) && return true
    (sup(x) < inf(y) || inf(x) > sup(y)) && return false
    return missing
end

function <(::PointwisePolicy{:ternary}, x::Interval, y::Interval)
    strictprecedes(x, y) && return true
    precedes(y, x) && return false
    return missing
end

function <=(::PointwisePolicy{:ternary}, x::Interval, y::Interval)
    precedes(x, y) && return true
    strictprecedes(y, x) && return false
    return missing
end

!=(::PointwisePolicy{:ternary}, x::Interval, y::Interval) = !(==(PointwisePolicy{:ternary}(), x, y))
>(::PointwisePolicy{:ternary}, x::Interval, y::Interval) = !<=(PointwisePolicy{:ternary}(), x, y)
>=(::PointwisePolicy{:ternary}, x::Interval, y::Interval) = !<(PointwisePolicy{:ternary}(), x, y)

# Boolean functions
# NOTE this interacts with flavors.
function isinf(::PointwisePolicy{:ternary}, x::Interval)
    if contains_infinity(x)
        isthin(x) && return true
        return missing
    end

    return false
end

isfinite(::PointwisePolicy{:ternary}, x::Interval) = !isinf(PointwisePolicy{:ternary}(), x)
iszero(::PointwisePolicy{:ternary}, x::Interval) = ==(PointwisePolicy{:ternary}(), x, 0)

function isinteger(::PointwisePolicy{:ternary}, x::Interval)
    (inf(x) == sup(x)) && isinteger(inf(x)) && return true
    floor(sup(x)) < ceil(inf(x)) && return false
    return missing
end


## :interval
"""
    BooleanInterval

Type representing a set containing `true` and/or `false`.

Test what it contains using `in`. For example `true in BooleanInterval(true, false)`.
"""
struct BooleanInterval
    has_true::Bool
    has_false::Bool

    function BooleanInterval(a::Bool, b::Bool)
        a == b && throw(ArgumentError("boolean interval with content [$a, $b] doesn't make sense."))
        return new(true, true)
    end

    function BooleanInterval(a::Bool)
        a && return new(true, false)
        return new(false, true)
    end

    BooleanInterval(::Missing) = new(true, true)
end

in(bool::Bool, bi::BooleanInterval) = bool ? bi.has_true : bi.has_false

function show(io::IO, bi::BooleanInterval)
    true in bi && false in bi && return print(io, "[true, false]")
    true in bi && return print(io, "[true]")
    false in bi && return print(io, "[false]")
end

for op in pointwise_bool_operations
    @eval function $op(::PointwisePolicy{:interval}, x::Interval, y::Interval)
        return BooleanInterval($op(PointwisePolicy{:ternary}(), x, y))
    end
end

for f in pointwise_bool_functions
    @eval function $f(::PointwisePolicy{:interval}, x::Interval)
        return BooleanInterval($f(PointwisePolicy{:ternary}(), x))
    end
end


## :certainly
for op in pointwise_bool_operations
    @eval function $op(::PointwisePolicy{:certainly}, x::Interval, y::Interval)
        ternary_res = $op(PointwisePolicy{:ternary}(), x, y)
        ismissing(ternary_res) && return false
        return ternary_res
    end
end

for f in pointwise_bool_functions
    @eval function $f(::PointwisePolicy{:certainly}, x::Interval)
        ternary_res = $f(PointwisePolicy{:ternary}(), x)
        ismissing(ternary_res) && return false
        return ternary_res
    end
end


## Number-interval comparisons
for op in pointwise_bool_operations
    @eval function $op(P::PointwisePolicy, x::F, y::Real) where {F<:Interval}
        return $op(P, x, F(y, y))
    end

    @eval function $op(P::PointwisePolicy, x::Real, y::F) where {F<:Interval}
        return $op(P, F(x, x), y)
    end
end


## Default behaviors
pointwise_policy() = PointwisePolicy{:ieee}()

for op in pointwise_bool_operations
    @eval $op(x::Interval, y::Interval) = $op(pointwise_policy(), x, y)
    @eval $op(x::Interval, y::Real) = $op(pointwise_policy(), x, y)
    @eval $op(x::Real, y::Interval) = $op(pointwise_policy(), x, y)
end

for f in pointwise_bool_functions
    @eval $f(x::Interval) = $f(pointwise_policy(), x)
end
