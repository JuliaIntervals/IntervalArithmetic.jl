# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Macros for directed rounding:

# Use the following empty definitions for rounding types other than Float64:
Base.set_rounding(whatever, rounding_mode) = ()
Base.get_rounding(whatever) = ()

if VERSION > v"0.4-"
    Base.Rounding.get_rounding_raw(whatever) = ()
    Base.Rounding.set_rounding_raw(whatever, rounding_mode) = ()
end


macro with_rounding(T, expr, rounding_mode)
    quote
        with_rounding($T, $rounding_mode) do
            $expr
        end
    end
end


@doc doc"""The `@round` macro creates a rounded interval according to the current
interval rounding mode. It is the main function used to create intervals in the
library (e.g. when adding two intervals, etc.). It uses the interval rounding mode
(see get_interval_rounding())""" ->
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

@doc doc"""`split_interval_string` deals with strings of the form
\"[3.5, 7.2]\"""" ->

function split_interval_string(T, x::AbstractString)
    if !(contains(x, "["))
        return @thin_round(T, parse(T,x))
    end


    m = match(r"\[(.*),(.*)\]", x)

    if m == nothing
        throw(ArgumentError("Unable to process string $x as interval"))
    end

    @round(T, parse(T, m.captures[1]), parse(T, m.captures[2]))


end


@doc doc"""`make_interval` is used by `@interval` to create intervals from
individual elements of different types""" ->
make_interval(::Type{BigFloat}, x::AbstractString)    =  split_interval_string(BigFloat, x) #@thin_round(BigFloat, parse(BigFloat,x))
make_interval(::Type{BigFloat}, x::Irrational) =  @thin_round(BigFloat, big(x))
make_interval(::Type{BigFloat}, x::Integer)   =  Interval(BigFloat(x))  # no rounding -- dangerous if very big integer
# but conversion from BigInt to BigFloat with correct rounding seems to be broken anyway # @thin_interval(BigFloat("$x"))

make_interval(::Type{BigFloat}, x::Rational)  =  make_interval(BigFloat, x.num) / make_interval(BigFloat, x.den)
function make_interval(::Type{BigFloat}, x::Float64)
    isinf(x) && return Interval(convert(BigFloat,x))
    make_interval(BigFloat, rationalize(x))  # NB: converts a float to a rational -- this could be slow
end

make_interval(::Type{BigFloat}, x::BigInt)    =  @thin_round(BigFloat, convert(BigFloat, x))

make_interval(::Type{BigFloat}, x::BigFloat)  =  @thin_round(BigFloat, 1.*x)  # convert to possibly different BigFloat precision
make_interval(::Type{BigFloat}, x::Interval)  =  @round(BigFloat, big(1.*x.lo), big(1.*x.hi))


make_interval(::Type{Float64}, x::AbstractString)    =  split_interval_string(Float64, x) #@thin_round(Float64, parse(Float64, x))
make_interval(::Type{Float64}, x::Irrational) =  make_interval(Float64, make_interval(BigFloat, x))

make_interval(::Type{Float64}, x::Integer)   =  Interval(float(x))    # assumes the int is representable
make_interval(::Type{Float64}, x::Rational)  =  make_interval(Float64, x.num) / make_interval(Float64, x.den)
function make_interval(::Type{Float64}, x::Float64)
    isinf(x) && return Interval(x)
    make_interval(Float64, rationalize(x))  # NB: converts a float to a rational -- could be slow
end

make_interval(::Type{Float64}, x::BigInt)    =  @thin_round(BigFloat, convert(Float64, x))
make_interval(::Type{Float64}, x::BigFloat)  =  @thin_round(BigFloat, convert(Float64, x))
make_interval(::Type{Float64}, x::Interval)  =  @round(BigFloat, convert(Float64, x.lo), convert(Float64, x.hi)) # NB: BigFloat to Float64 conversion uses *BigFloat* rounding mode


function make_interval(::Type{Rational{Int}}, x::Irrational)
    a = make_interval(Float64, make_interval(BigFloat, x))
    make_interval(Rational{Int}, a)
end
function make_interval(::Type{Rational{BigInt}}, x::Irrational)
    a = @thin_round(BigFloat, big(x))
    make_interval(Rational{BigInt}, a)
end
make_interval{T<:Integer, S<:Integer}(::Type{Rational{T}}, x::S)   =
    Interval(one(Rational{T})*x)
make_interval{T<:Integer, S<:Integer}(::Type{Rational{T}}, x::Rational{S})  =
    Interval(one(Rational{T})*x)
make_interval{T<:Integer}(::Type{Rational{T}}, x::Float64)   =
    Interval(rationalize(x))  # NB: converts a float to a rational -- this could be slow
make_interval{T<:Integer}(::Type{Rational{T}}, x::BigFloat)  =
    Interval(convert(Rational{BigInt}, rationalize(x)))  # NB: converts a float to a rational -- this could be slow
make_interval{T<:Integer}(::Type{Rational{T}}, x::Interval)  =
    Interval(convert(Rational{T}, rationalize(x.lo)), convert(Rational{T}, rationalize(x.hi)))


@doc doc"""`transform` transforms a string by applying the function `f` and type `T` to each argument, i.e.
`:(x+y)` is transformed to `:(f(T, x) + f(T, y))`
""" ->
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

    for (i, arg) in enumerate(expr.args)
        i < first && continue
        #@show i,arg

        new_expr.args[i] = transform(arg, f, T)
    end

    return new_expr
end


# Called by interval and floatinterval macros
@doc doc"""`make_interval` does the hard work of taking expressions
and making each literal (0.1, 1, etc.) into a corresponding interval construction,
by calling `transform`.""" ->

function make_interval(T, expr1, expr2)
    expr1 = transform(expr1, :make_interval, T)

    if isempty(expr2)  # only one argument
        return expr1
    end

    expr2 = transform(expr2[1], :make_interval, T)

    :(hull($expr1, $expr2))
end


float(x::Interval) = make_interval(Float64, x)

## Change type of interval rounding:


@doc doc"""`get_interval_rounding()` returns the current interval rounding mode.
There are two possible rounding modes:

- :narrow  -- changes the floating-point rounding mode to `RoundUp` and `RoundDown`.
This gives the narrowest possible interval.

- :wide -- Leaves the floating-point rounding mode in `RoundNearest` and uses
`prevfloat` and `nextfloat` to achieve directed rounding. This creates an interval of width 2`eps`.
""" ->

get_interval_rounding() = interval_parameters.rounding

function set_interval_rounding(mode)
    if mode ∉ [:wide, :narrow]
        throw(ArgumentError("Only possible interval rounding modes are `:wide` and `:narrow`"))
    end

    interval_parameters.rounding = mode  # a symbol
end
