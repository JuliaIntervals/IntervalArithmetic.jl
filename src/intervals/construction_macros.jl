# This file is part of the IntervalArithmetic.jl package; MIT licensed

"""
    @interval

Macro creating an interval.

Walk through the expression to convert each number literal into an interval
construct.

Example
=======
    @interval sin(0.1) + cos(0.2)

is equivalent to

    sin(I"0.1") + cos(I"0.2")
"""
macro interval(expr)
    return wrap_literals(Interval{default_bound()}, expr)
end

macro interval(expr1, expr2)
    return wrap_literals(Interval{default_bound()}, expr1, expr2)
end

macro interval(T, expr1, expr2)
    return wrap_literals(:(Interval{$T}), expr1, expr2)
end

"""
    @floatinterval

Construct an interval with `Float64` bounds from an expression.

See `@interval` for details.
"""
macro floatinterval(expr)
    return wrap_literals(Interval{Float64}, expr)
end

macro floatinterval(expr1, expr2)
    return wrap_literals(Interval{Float64}, expr1, expr2)
end

"""
    @biginterval

Construct an interval with `BigFloat` bounds from an expression.

See `@interval` for details.
"""
macro biginterval(expr)
    return wrap_literals(Interval{BigFloat}, expr)
end

macro biginterval(expr1, expr2)
    return wrap_literals(Interval{BigFloat}, expr1, expr2)
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
        new_expr.args[i] = transform(arg, f, T)
    end

    return new_expr
end


"""
    wrap_literals(F, expr1, expr2)

Take expressions and make each literal (0.1, 1, etc.) into a corresponding
interval construction_macros.
"""
function wrap_literals(F, expr)
    return transform(expr, :atomic, :($F))
end

function wrap_literals(F, expr1, expr2)
    expr1 = transform(expr1, :atomic, :($F))
    expr2 = transform(expr2, :atomic, :($F))

    return :(checked_interval(inf($expr1), sup($expr2)))
end

"""
    I"expr"

Parse a string as an `Interval`, according to the grammar specified
in Section 9.7 of the IEEE Std 1788-2015, with some extensions.

See `parse(::Interval, ::AbstractString)` for more details.

Strictly guarantee that the returned interval tightly enclose the typed in
numbers, something that constructors that do not use strings can not guarantee.

Example
=======
julia> I"[3, 4]"
[3, 4]

julia> I"0.1"
[0.0999999, 0.100001]
"""
macro I_str(ex)
    @interval(ex)
end
