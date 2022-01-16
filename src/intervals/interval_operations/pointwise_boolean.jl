# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains functions not specified in the IEEE Std 1788-2015,
    extending boolean operations defined for reals to intervals.

    This is different from what is described in sections 9.5 of the
    IEEE Std 1788-2015 (Boolean functions of intervals), since we deal here
    with what is needed for drop-in replacement of floats by intervals,
    and not what is reasonnable to do with intervals in a separate execution
    environment.

    Essentially, julia is better at composability and we are more ambitious
    that what the standard ever expected, so we have some extra problems
    to solve.

    We use a trait system, defining the operation with an extra
    `PointwisePolitic` argument defining how it should be handled.

    The default operations use `IntervalArithmetic.pointwise_politic()`,
    so in order to change the default behavior this function has to be
    redefined.

    We define every operations using the default `PointwisePolitic{:ternary}()`
    and then use it to define all the others.
=#
"""
    PointwisePolitic{P}

Define which politic we use to extend pointwise comparison of 

Valid value for the politic identifier `P` are
    - `:is_all` : A boolean operation is extended by asking "is it true for
        all elements of the interval(s) involved".
        This is self-consistent, but breaks the usual rules for negation.
        For example with this politic, `((-1..3) == 0) == false` because it
        answers the question "are all elements in (-1..3) equal to zero".
        However its negation is `false` too: `((-1..3) != 0) == false`.
        This *silently* breaks any code relying on such operation in conditional
        statements like `if x == 0 ... else ... end`.
    - `:interval` : A pointwise boolean operation `B` return the set of all
        possible outcome as a `BooleanInterval`.
        This is safe but very strict, always erroring when an interval is used
        in a conditional statement.
    - `:ternary` (default) : With this politics return `missing` when the
        boolean operation does not return the same answer for all elements
        of the involved interval(s).
        This only causes error in conditional statements when hitting `missing`.
        When it does not error it is safe.

The current pointwise politic can be changed by overriding the function
`IntervalArithmetic.pointwise_politic()`.

Example
=======

          | (-1..3) > 2   | (-1..3) <= 2  | (-1..1) > 2 | (-1..1) < 2 |
----------|---------------|---------------|-------------|-------------|
:is_all   | false         | false         | false       | true        |
:interval | [true, false] | [true, false] | [false]     | [true]      |
:ternary  | missing       | missing       | false       | true        |

"""
struct PointwisePolitic{P} end

pointwise_bool_operations = [
    :(==), :(!=), :<, :(<=), :>, :(>=)
]

pointwise_bool_functions = [
    :isinf, :isfinite, :isinteger, :iszero
]

## :ternary
function ==(::PointwisePolitic{:ternary}, x::Interval, y::Interval)
    isthin(x) && isthin(y) && x.lo == y.lo && return true
    (x.hi < y.lo || x.lo > y.hi) && return false
    return missing
end

function <(::PointwisePolitic{:ternary}, x::Interval, y::Interval)
    strictprecedes(x, y) && return true
    precedes(y, x) && return false
    return missing
end

function <=(::PointwisePolitic{:ternary}, x::Interval, y::Interval)
    precedes(x, y) && return true
    strictprecedes(y, x) && return false
    return missing
end

!=(::PointwisePolitic{:ternary}, x::Interval, y::Interval) = !(==(PointwisePolitic{:ternary}(), x, y))
>(::PointwisePolitic{:ternary}, x::Interval, y::Interval) = !<=(PointwisePolitic{:ternary}(), x, y)
>=(::PointwisePolitic{:ternary}, x::Interval, y::Interval) = !<(PointwisePolitic{:ternary}(), x, y)

# Boolean functions
# NOTE this interacts with flavors.
function isinf(::PointwisePolitic{:ternary}, x::Interval)
    if contains_infinity(x)
        isthing(x) && return true
        return missing
    end

    return false
end

isfinite(::PointwisePolitic{:ternary}, x::Interval) = !isinf(PointwisePolitic{:ternary}(), x)
iszero(::PointwisePolitic{:ternary}, x::Interval) = ==(PointwisePolitic{:ternary}(), x, 0)

function isinteger(::PointwisePolitic{:ternary}, x::Interval)
    (x.lo == x.hi) && isinteger(x.lo) && return true
    floor(x.hi) < ceil(x.lo) && return false
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
    @eval function $op(::PointwisePolitic{:interval}, x::Interval, y::Interval)
        return BooleanInterval($op(PointwisePolitic{:ternary}(), x, y))
    end
end

for f in pointwise_bool_functions
    @eval function $f(::PointwisePolitic{:interval}, x::Interval)
        return BooleanInterval($f(PointwisePolitic{:ternary}(), x))
    end
end


## :is_all
for op in pointwise_bool_operations
    @eval function $op(::PointwisePolitic{:is_all}, x::Interval, y::Interval)
        ternary_res = $op(PointwisePolitic{:ternary}(), x, y)
        ismissing(ternary_res) && return false
        return ternary_res
    end
end

for f in pointwise_bool_functions
    @eval function $f(::PointwisePolitic{:is_all}, x::Interval)
        ternary_res = $f(PointwisePolitic{:ternary}(), x)
        ismissing(ternary_res) && return false
        return ternary_res
    end
end


## Number-interval comparisons
for op in pointwise_bool_operations
    @eval function $op(P::PointwisePolitic, x::F, y::Real) where {F<:Interval}
        return $op(P, x, F(y))
    end

    @eval function $op(P::PointwisePolitic, x::Real, y::F) where {F<:Interval}
        return $op(P, F(x), y)
    end
end


## Default behaviors
pointwise_politic() = PointwisePolitic{:ternary}()

for op in pointwise_bool_operations
    @eval $op(x::Interval, y::Interval) = $op(pointwise_politic(), x, y)
    @eval $op(x::Interval, y::Real) = $op(pointwise_politic(), x, y)
    @eval $op(x::Real, y::Interval) = $op(pointwise_politic(), x, y)
end

for f in pointwise_bool_functions
    @eval $f(x::Interval) = $f(pointwise_politic(), x)
end
