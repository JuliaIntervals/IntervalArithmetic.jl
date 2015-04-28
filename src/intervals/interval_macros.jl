
## Macros for directed rounding:

# Use the following empty definitions for rounding types other than Float64:
Base.set_rounding(whatever, rounding_mode) = ()
Base.get_rounding(whatever) = ()

if VERSION > v"0.4-"
    Base.Rounding.get_rounding_raw(whatever) = ()
    Base.Rounding.set_rounding_raw(whatever, rounding_mode) = ()
end


macro rounding(T, expr, rounding_mode)
    quote
        with_rounding($T, $rounding_mode) do
            $expr
        end
    end
end


macro round(T, expr1, expr2)
    quote
        Interval(@rounding($T, $expr1, RoundDown), @rounding($T, $expr2, RoundUp))
    end
end


@doc doc"""`thin_interval` takes an expression and makes a "thin" interval
by rounding it downwards and upwards.

*This should never be called directly by user code*.

Rather, it is used from the `transf` function which passes suitable expressions
to process objects of different types.

Note that this does not necessarily produce true "thin" intervals (of zero width,
i.e. with identical start- and end- points). Rather, it produces an interval that
is *as thin as possible*, i.e. if the result is `a`, such that `nextfloat(a.lo) == a.hi`.

Nonetheless, a *true* thin interval of zero width may be created by passing it directly
a `Float64` or `BigFloat`.
""" ->

macro thin_interval(expr)
    quote
        @round(BigFloat, $expr, $expr)
    end
end

macro thin_float_interval(expr)
    quote
        @round(Float64, $expr, $expr)
    end
end


## Wrap user input for correct rounding:
# These transf functions are called after the initial @interval macro has been expanded

# big_transf(x::String)    =  @thin_interval(BigFloat(x))
big_transf(x::String)    =  @thin_interval(@compat parse(BigFloat,x))
big_transf(x::MathConst) =  @thin_interval(big(x))

# big_transf(x::Integer)   =  @thin_interval(BigFloat("$x"))
big_transf(x::Integer)   =  @thin_interval(@compat parse(BigFloat,"$x"))
big_transf(x::Rational)  =  big_transf(x.num) / big_transf(x.den)
big_transf(x::Float64)   =  big_transf(rationalize(x))  # NB: converts a float to a rational

big_transf(x::BigFloat)  =  @thin_interval(x)  # NB: this will give a true thin interval (zero width)
big_transf(x::Interval)  =  convert(Interval{BigFloat}, x)


float_transf(x::String)    =  @thin_float_interval(parsefloat(x))
float_transf(x::MathConst) =  convert(Interval{Float64}, @thin_interval(big(x)))   # this should be improved

float_transf(x::Integer)   =  @thin_float_interval(float(x))
float_transf(x::Rational)  =  float_transf(x.num) / float_transf(x.den)
float_transf(x::Float64)   =  float_transf(rationalize(x))  # NB: converts a float to a rational

float_transf(x::BigFloat)  =  @thin_float_interval(convert(Float64, x))  # NB: this will give a true thin interval (zero width)
float_transf(x::Interval)  =  convert(Interval{Float64}, x)


@doc doc"""`transform` transforms a string by applying the function `transf` to each argument, e.g
`:(x+y)` is transformed to (approximately)
`:(transf(x) + transf(y))`
""" ->
transform(x, f) = :($f($(esc(x))))   # use if x is not an expression

function transform(expr::Expr, f::Symbol)

    if expr.head == :(.)   # e.g. a.lo
        return :($f($(esc(expr))))
    end

    new_expr = copy(expr)


    first = 1  # where to start processing arguments
    if expr.head == :call
        first = 2  # skip operator
    end

    for (i, arg) in enumerate(expr.args)
        i < first && continue
        #@show i,arg

        new_expr.args[i] = transform(arg, f)

    end

    return new_expr
end


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
"""->

macro interval(expr1, expr2...)

    expr1 = transform(expr1, :big_transf)

    if isempty(expr2)  # only one argument
        return expr1
    end

    expr2 = transform(expr2[1], :big_transf)

    :(hull($expr1, $expr2))   # BigFloat by default
end

@doc doc"""The `floatinterval` macro constructs an interval with `Float64` entries,
instead of `BigFloat`. It is just a wrapper of the `@interval` macro.""" ->

macro floatinterval(expr1, expr2...)

    expr1 = transform(expr1, :float_transf)

    if isempty(expr2)  # only one argument
        return expr1
    end

    expr2 = transform(expr2[1], :float_transf)

    :(hull($expr1, $expr2))   # BigFloat by default
end



function float(x::Interval)
    # @round(BigFloat, convert(Float64, x.lo), convert(Float64, x.hi))
    convert(Interval{Float64}, x)
end
