# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""
    @interval

Macro creating an interval.

It converts each expression into a narrow interval that is guaranteed to contain
the true value passed by the user in the one or two expressions passed to it.
When passed two expressions, it takes the hull of the resulting intervals
to give a guaranteed containing interval.

Examples:
```
    @interval(0.1)

    @interval(0.1, 0.2)

    @interval(1/3, 1/6)

    @interval(1/3^2)
```

Note that the returned interval is of the default flavor. See the documentation
of `Interval` for more information about the defaul interval falvor.
"""
macro interval(expr1, expr2...)
    make_interval(Float64, expr1, expr2)
end

"""
    @floatinterval

Construct an interval with `Float64` bounds from an expression.
"""
macro floatinterval(expr1, expr2...)
    make_interval(Float64, expr1, expr2)
end

"""
    @biginterval

Construct an interval with `BigFloat` bounds from an expression.
"""
macro biginterval(expr1, expr2...)
    make_interval(BigFloat, expr1, expr2)
end



"""
    transform(expr, f, T)

Transform a string by applying the function `f` and type
`T` to each argument, i.e. `:(x+y)` is transformed to `:(f(T, x) + f(T, y))`
"""
transform(x::Symbol, f, T) = :($f($T, $(esc(x))))   # use if x is not an expression
transform(x, f, T) = :($f($T, $x))

function transform(expr::Expr, f::Symbol, T)

    if expr.head in ( :(.), :ref )   # of form  a.lo  or  a[i]
        return :($f($T, $(esc(expr))))
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
        return :($f($T, $(esc(expr))))  # hack: pass straight through
    end

    for (i, arg) in enumerate(expr.args)
        i < first && continue
        #@show i,arg

        new_expr.args[i] = transform(arg, f, T)
    end

    return new_expr
end


"""
    make_interval(T, expr1, expr2)

Take expressions and make each literal (0.1, 1, etc.) into a corresponding
interval construction.
"""
function make_interval(T, expr1, expr2)
    # @show expr1, expr2

    expr1 = transform(expr1, :atomic, :($Interval{$T}))

    if isempty(expr2)  # only one argument
        return :(Interval($expr1))
    end

    expr2 = transform(expr2[1], :atomic, :($Interval{$T}))

    :(interval(inf($expr1), sup($expr2)))
end
