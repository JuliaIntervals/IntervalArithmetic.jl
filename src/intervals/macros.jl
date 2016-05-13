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


# Macros for directed rounding:

macro setrounding(T, expr, rounding_mode)
    quote
        setrounding($T, $rounding_mode) do
            $expr
        end
    end
end


doc"""The `@round` macro creates a rounded interval according to the current
interval rounding mode. It is the main function used to create intervals in the
library (e.g. when adding two intervals, etc.). It uses the interval rounding mode (see rounding(Interval))"""
macro round(T, expr1, expr2)
    #@show "round", expr1, expr2
    quote
        mode = rounding(Interval)

        if mode == :wide  #works with any rounding mode set, but the result will depend on the rounding mode
            # we assume RoundNearest
            Interval(prevfloat($expr1), nextfloat($expr2))

        else # mode == :narrow
            lo = @setrounding($T, $expr1, RoundDown)
            hi = @setrounding($T, $expr2, RoundUp)
            Interval(lo, hi)
        end
    end
end


doc"""`@thin_round` possibly saves one operation compared to `@round`."""
macro thin_round(T, expr)
    quote
        @round($T, $expr, $expr)
    end
end



doc"""`transform` transforms a string by applying the function `f` and type
`T` to each argument, i.e. `:(x+y)` is transformed to `:(f(T, x) + f(T, y))`
"""
transform(x, f, T) = :($f($(esc(T)), $(esc(x))))   # use if x is not an expression

function transform(expr::Expr, f::Symbol, T)

    if expr.head in ( :(.), :ref )   # of form  a.lo  or  a[i]
        return :($f($(esc(T)), $(esc(expr))))
    end

    new_expr = copy(expr)


    first = 1  # where to start processing arguments

    if expr.head == :call
        if expr.args[1] ∈ (:+, :-, :*, :/, :^)
            first = 2  # skip operator
        else   # escape standard function:
            new_expr.args[1] = :($(esc(expr.args[1])))
            first = 2
        end
    end

    if expr.head == :macrocall  # handles BigInts etc.
        return :($f($(esc(T)), $(esc(expr))))  # hack: pass straight through
    end

    for (i, arg) in enumerate(expr.args)
        i < first && continue
        #@show i,arg

        new_expr.args[i] = transform(arg, f, T)
    end

    return new_expr
end


# Called by interval and floatinterval macros
doc"""`make_interval` does the hard work of taking expressions
and making each literal (0.1, 1, etc.) into a corresponding interval construction,
by calling `transform`."""

function make_interval(T, expr1, expr2)
    expr1 = transform(expr1, :convert, :(Interval{$T}))

    if isempty(expr2)  # only one argument
        return expr1
    end

    expr2 = transform(expr2[1], :convert, :(Interval{$T}))

    # :(hull($expr1, $expr2))
    :(Interval(($expr1).lo, ($expr2).hi))
end
