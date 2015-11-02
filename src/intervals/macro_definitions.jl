# This file is part of the ValidatedNumerics.jl package; MIT licensed

doc"""The `@interval` macro is the main method to create an interval.
It converts each expression into a narrow interval that is guaranteed to contain the true value passed by the user in the one or two expressions passed to it.
When passed two expressions, it takes the hull of the resulting intervals
to give a guaranteed containing interval.

Examples:
```
    @interval(0.1)

    @interval(0.1, 0.2)

    @interval(1/3, 1/6)

    @interval(1/3^2)
```
"""
macro interval(expr1, expr2...)
    make_interval(:(parameters.precision_type), expr1, expr2)
end

doc"The `@floatinterval` macro constructs an interval with `Float64` entries."
macro floatinterval(expr1, expr2...)
    make_interval(Float64, expr1, expr2)
end

doc"The `@biginterval` macro constructs an interval with `BigFloat` entries."
macro biginterval(expr1, expr2...)
    make_interval(BigFloat, expr1, expr2)
end
