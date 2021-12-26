# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains functions not specified in the IEEE Std 1788-2015,
    extending real boolean operations to intervals.

    This is different from what is described in sections 9.5 of the
    IEEE Std 1788-2015 (Boolean functions of intervals), since we deal here
    with what is needed for drop in replacement of Float by intervals,
    and not what is reasonnable to do with intervals in a separate execution
    environment.

    Essentially, julia is better at composability that what the standard
    ever expected from a programming language so we have some extra problems
    to solve.
=#

# TODO Need help for the names x_x
# TODO Fetch the tests from NumberInterval.jl for the ternary politic
# TODO More globally, test the file (especially isinf and isfinite)
# TODO Add a :ternary_with_warning politic for the default?
# TODO Add iszero
"""
    PointwisePolitic{P}

Define which politic we use to extend pointwise comparison of 

Valid value for the politic identifier `P` are
    - `:binary_consistent` : A pointwise boolean operation `B` is interpreted
        as `B(X::Interval) = all(B(x) for x in X)`.
        This is self-consistent, but breaks the usual rules for negation.
        For example with this politic, `iszero((-1..3)) == false` and
        `(!iszero)((-1..3)) == false`.
        This *silently* breaks any code relying on such operation conditional
        statements.
    - `:boolean_intervals` : A pointwise boolean operation `B` return the set
        of all outcomes `B(X) = {B(x) | x ∈ X}`.
        This is safe, erroring whenever an invterval is used in a conditional
        statement.
    - `:ternary_logic` (default) : With this politics we use the same logic as for
        `:boolean_intervals`, with the following substitutions to get
        normal `Bool` whenever possible:
            - `{true}` -> `true`
            - `{false}` -> `false`
            - `{true, false}` -> `missing`
        This only causes error in conditional statements when hitting `missing`
        and it is safe.
"""
struct PointwisePolitic{P} end

const BinaryConsistent = PointwisePolitic{:binary_consistent}
const BooleanIntervals = PointwisePolitic{:boolean_intervals}
const TernaryLogic = PointwisePolitic{:ternary_logic}

bool_operations = [
    :(==), :(!=), :<, :(<=), :>, :(>=)
]

bool_functions = [
    :isinf, :isfinite
]

## Ternary logic

function ==(::TernaryLogic, x::Interval, y::Interval)
    isthin(x) && isthin(y) && x.lo == y.lo && return true
    return missing
end

function <(::TernaryLogic, x::Interval, y::Interval)
    strictprecedes(x, y) && return true
    precedes(y, x) && return false
    return missing
end

function <=(::TernaryLogic, x::Interval, y::Interval)
    precedes(x, y) && return true
    strictprecedes(y, x) && return false
    return missing
end

# TODO We got a warning in VSCode there
!=(::TernaryLogic, x::Interval, y::Interval) = !(==(TernaryLogic(), x, y))
>(::TernaryLogic, x::Interval, y::Interval) = !<(TernaryLogic(), x, y)
>=(::TernaryLogic, x::Interval, y::Interval) = !<=(TernaryLogic(), x, y)

# Boolean functions
function isinf(::TernaryLogic, x::Interval)
    if x.lo === -Inf || x.hi === Inf
        isthin(x) && return true
        return missing
    end
    return false
end

isfinite(::TernaryLogic, x::Interval) = !isinf(TernaryLogic(), x)


## Boolean Intervals
struct BooleanInterval
    has_true::Bool
    has_false::Bool
end

function BooleanInterval(arg)
    ismissing(arg) && return BooleanInterval(true, true)
    arg && return BooleanInterval(true, false)
    return BooleanInterval(false, true)
end

for op in bool_operations
    @eval function $op(::BooleanIntervals, x::Interval, y::Interval)
        return BooleanInterval($op(TernaryLogic(), x, y))
    end
end

for f in bool_functions
    @eval function $f(::BooleanInterval, x::Interval)
        return BooleanInterval($f(TernaryLogic(), x))
    end
end


## Binary consistent
for op in bool_operations
    @eval function $op(::BinaryConsistent, x::Interval, y::Interval)
        ternary_res = $op(TernaryLogic, x, y)
        ismissing(ternary_res) && return false
        return BooleanInterval(ternary_res)
    end
end

for f in bool_functions
    @eval function $f(::BinaryConsistent, x::Interval, y::Interval)
        ternary_res = $f(TernaryLogic, x)
        ismissing(ternary_res) && return false
        return BooleanInterval(ternary_res)
    end
end


## Number-interval comparisons
for op in bool_operations
    @eval function $op(P::PointwisePolitic, x::F, y::Real) where {F<:Interval}
        return $op(P, x, F(y))
    end

    @eval function $op(P::PointwisePolitic, x::Real, y::F) where {F<:Interval}
        return $op(P, F(x), y)
    end
end


## Default behaviors
pointwise_politic() = TernaryLogic()

for op in bool_operations
    @eval $op(x::Interval, y::Interval) = $op(pointwise_politic(), x, y)
    @eval $op(x::Interval, y::Real) = $op(pointwise_politic(), x, y)
    @eval $op(x::Real, y::Interval) = $op(pointwise_politic(), x, y)
end

for f in bool_functions
    @eval $f(x::Interval) = $f(pointwise_politic(), x)
end
