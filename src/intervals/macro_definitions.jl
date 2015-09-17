# This file is part of the ValidatedNumerics.jl package; MIT licensed

@doc doc"""The `@interval` macro is the main way to create an interval of `BigFloat`s.
It converts each expression into a thin interval that is guaranteed to contain the true value passed
by the user in the one or two expressions passed to it.
It takes the hull of the resulting intervals (if necessary, i.e. when given two expressions)
to give a guaranteed containing interval.

Examples:
```
    @interval(0.1)

    @interval(0.1, 0.2)

    @interval(1/3, 1/6)

    @interval(1/3^2)
```
""" ->

macro interval(expr1, expr2...)
    make_interval(:(interval_parameters.precision_type), expr1, expr2)
end

@doc doc"""The `floatinterval` macro constructs an interval with `Float64` entries,
instead of `BigFloat`.""" ->

macro floatinterval(expr1, expr2...)
    make_interval(Float64, expr1, expr2)
end

macro biginterval(expr1, expr2...)
    make_interval(BigFloat, expr1, expr2)
end

macro make_interval(T, expr1, expr2...)
    make_interval(T, expr1, expr2)
end
