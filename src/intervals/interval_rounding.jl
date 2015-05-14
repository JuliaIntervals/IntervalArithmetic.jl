
## Macros for directed rounding:

# Use the following empty definitions for rounding types other than Float64:
Base.set_rounding(whatever, rounding_mode) = ()
Base.get_rounding(whatever) = ()

if VERSION > v"0.4-"
    Base.Rounding.get_rounding_raw(whatever) = ()
    Base.Rounding.set_rounding_raw(whatever, rounding_mode) = ()
end


const INTERVAL_ROUNDING = [:narrow]  # or :wide
# TODO: replace by an enum in 0.4

@doc doc"""`get_interval_rounding()` returns the current interval rounding mode.
There are two possible rounding modes:

- :narrow  -- changes the floating-point rounding mode to `RoundUp` and `RoundDown`.
This gives the narrowest possible interval.

- :wide -- Leaves the floating-point rounding mode in `RoundNearest` and uses
`prevfloat` and `nextfloat` to achieve directed rounding. This creates an interval of width 2`eps`.
""" ->

get_interval_rounding() = INTERVAL_ROUNDING[end]

function set_interval_rounding(mode)
    if mode ∉ [:wide, :narrow]
        error("Only possible interval rounding modes are `:wide` and `:narrow`")
    end

    INTERVAL_ROUNDING[end] = mode  # a symbol
end


set_interval_rounding(:narrow)


macro with_rounding(T, expr, rounding_mode)
    quote
        with_rounding($T, $rounding_mode) do
            $expr
        end
    end
end


@doc doc"""The `@round` macro creates a rounded interval according to the current interval rounding mode.
It is the main function used to create intervals in the library (e.g. when adding two intervals, etc.).
It uses the interval rounding mode (see get_interval_rounding())""" ->
macro round(T, expr1, expr2)
    #@show "round", expr1, expr2
    quote
        mode = get_interval_rounding()

        if mode == :wide  #works with any rounding mode set, but the result will depend on the rounding mode
            # we assume RoundNearest
            Interval(prevfloat($expr1), nextfloat($expr2))

        else # mode == :narrow
            Interval(@with_rounding($T, $expr1, RoundDown), @with_rounding($T, $expr2, RoundUp))
        end

    end
end

@doc doc"""`@thin_round` possibly saves one operation compared to `@round`.""" ->
macro thin_round(T, expr)
    quote
        mode = get_interval_rounding()

        if mode == :wide  #works with any rounding mode set, but the result will depend on the rounding mode
            # we assume RoundNearest
            temp = $expr  # evaluate the expression
            Interval(prevfloat(temp), nextfloat(temp))

        else # mode == :narrow
            Interval(@with_rounding($T, $expr, RoundDown), @with_rounding($T, $expr, RoundUp))

        end
    end
end


@doc doc"""`make_interval` is used by `@interval` to create intervals from individual elements of different types"""->
make_interval(::Type{BigFloat}, x::String)    =  @thin_round(BigFloat, @compat parse(BigFloat,x))
make_interval(::Type{BigFloat}, x::MathConst) =  @thin_round(BigFloat, big(x))
make_interval(::Type{BigFloat}, x::Integer)   =  Interval(BigFloat(x))  # no rounding -- dangerous if very big integer
# but conversion from BigInt to BigFloat with correct rounding seems to be broken anyway # @thin_interval(BigFloat("$x"))

make_interval(::Type{BigFloat}, x::Rational)  =  make_interval(BigFloat, x.num) / make_interval(BigFloat, x.den)
make_interval(::Type{BigFloat}, x::Float64)   =  make_interval(BigFloat, rationalize(x))  # NB: converts a float to a rational -- this could be slow

make_interval(::Type{BigFloat}, x::BigInt)    =  @thin_round(BigFloat, convert(BigFloat, x))

make_interval(::Type{BigFloat}, x::BigFloat)  =  @thin_round(BigFloat, 1.*x)  # convert to possibly different BigFloat precision
make_interval(::Type{BigFloat}, x::Interval)  =  @round(BigFloat, big(1.*x.lo), big(1.*x.hi))



make_interval(::Type{Float64}, x::String)    =  @thin_round(Float64, @compat parse(Float64, x))
make_interval(::Type{Float64}, x::MathConst) =  make_interval(Float64, make_interval(BigFloat, x))

make_interval(::Type{Float64}, x::Integer)   =  Interval(float(x))    # assumes the int is representable
make_interval(::Type{Float64}, x::Rational)  =  make_interval(Float64, x.num) / make_interval(Float64, x.den)
make_interval(::Type{Float64}, x::Float64)   =  make_interval(Float64, rationalize(x))  # NB: converts a float to a rational -- could be slow

make_interval(::Type{Float64}, x::BigInt)    =  make_interval(Float64, make_interval(BigFloat, x))
make_interval(::Type{Float64}, x::BigFloat)  =  @thin_round(BigFloat, convert(Float64, x))
make_interval(::Type{Float64}, x::Interval)  =  @round(BigFloat, convert(Float64, x.lo), convert(Float64, x.hi)) # NB: BigFloat to Float64 conversion uses *BigFloat* rounding mode



@doc doc"""`transform` transforms a string by applying the function `transf` to each argument, e.g
`:(x+y)` is transformed to (approximately)
`:(transf(x) + transf(y))`
""" ->
transform(x, f, T) = :($f($T, $(esc(x))))   # use if x is not an expression

function transform(expr::Expr, f::Symbol, T)

    if expr.head == :(.)   # e.g. a.lo
        return :($f($T, $(esc(expr))))
    end

    new_expr = copy(expr)


    first = 1  # where to start processing arguments
    if expr.head == :call
        first = 2  # skip operator
    end

    for (i, arg) in enumerate(expr.args)
        i < first && continue
        #@show i,arg

        new_expr.args[i] = transform(arg, f, T)

    end

    return new_expr
end


# Called by interval and floatinterval macros
function make_interval(T, expr1, expr2)
    expr1 = transform(expr1, :make_interval, T)

    if isempty(expr2)  # only one argument
        return expr1
    end

    expr2 = transform(expr2[1], :make_interval, T)

    :(hull($expr1, $expr2))
end

macro make_interval(T, expr1, expr2...)
    make_interval(T, expr1, expr2)
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
    make_interval(BigFloat, expr1, expr2)
end

@doc doc"""The `floatinterval` macro constructs an interval with `Float64` entries,
instead of `BigFloat`. It is just a wrapper of the `@interval` macro.""" ->

macro floatinterval(expr1, expr2...)
    make_interval(Float64, expr1, expr2)
end


float(x::Interval) = convert(Interval{Float64}, x)
