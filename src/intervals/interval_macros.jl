
## Macros for directed rounding:

# (Could use "with rounding" to ensure previous rounding mode is correctly reset)

#evaluate(expr) = eval(Main, expr)

macro round_down(expr)
#     value = evaluate(expr)

#     if typeof(value) == Float64
#         quote
#             set_rounding(Float64, RoundDown)
#             $expr
#         end

#     else

        quote
            #set_rounding(BigFloat, RoundDown)
            #with_rounding(BigFloat, RoundDown) do
            set_rounding(BigFloat, RoundDown)
            set_rounding(Float64, RoundDown)
                $expr
      #      set_rounding(BigFloat, RoundNearest)
      #      set_rounding(Float64, RoundNearest)


           # end
        end
#     end
end

macro new_round_down(expr, T)

    if T in (:Float64, :BigFloat)
        quote
            with_rounding($T, RoundDown) do
                $expr
            end
        end

    else
        expr
    end

end

macro rounding(expr, T, rounding_mode)

    if T in (:Float64, :BigFloat)
        quote
            set_rounding($T, $rounding_mode)
            temp = $expr
            set_rounding($T, RoundNearest)
            temp
        end

    else
        expr
    end

end

macro all_rounding(expr, rounding_mode)
    quote
        set_rounding(Float64, $rounding_mode)
        set_rounding(BigFloat, $rounding_mode)

        temp = $expr

        set_rounding(Float64, RoundNearest)
        set_rounding(BigFloat, RoundNearest)

        temp
    end

end


macro round_up(expr)
    quote
        set_rounding(BigFloat, RoundUp)
        set_rounding(Float64, RoundUp)
         #with_rounding(BigFloat, RoundUp) do
            $expr
        #end
      #  set_rounding(BigFloat, RoundNearest)
      #  set_rounding(Float64, RoundNearest)

    end
end


## Wrap user input for correct rounding:


macro thin_interval(expr)
    quote
        Interval(@round_down($expr), @round_up($expr))
    end
end



transform(a::MathConst) =  ( @thin_interval(big(a)))
transform(a::BigFloat)  =  ( @thin_interval(a))
transform(a::Number)    = :( @thin_interval(BigFloat(string($a))) )


function transform(a::Symbol)

    value = eval(Main, a)   # should use module_parent

    if isa(value, MathConst) || isa(value, Number)
        transform(value)
    else
        a  # symbols like :+
    end
end

function transform(expr::Expr)

    if expr.head == :(.)   # e.g. a.lo
        value = eval(Main, expr)
        return transform(value)
    end

    ex = copy(expr)
    for (i, arg) in enumerate(expr.args)
        # println(i, " ", arg)
        ex.args[i] = transform(arg)
    end
    return ex
end


# The main way to create an interval is the following @interval macro
# It converts each expression into a small interval that is guaranteed to contain the true value passed
# by the user in the one or two expressions
# It then takes the hull of the resulting two intervals to give a guaranteed containing interval

macro interval(expr1, expr2...)

    expr1 = transform(expr1)

    use_float = false

    if isempty(expr2)
        expr2 = expr1
    else
        if length(expr2) > 1 && ( expr2[2] in (:Float64, :(ValidatedNumerics.Float64)) )
            use_float = true
        end

        expr2 = transform(expr2[1])
    end

    if use_float
        return :(floatinterval(hull($expr1, $expr2)))

    else
        return :(hull($expr1, $expr2))   # BigFloat by default
    end
end



# macro round(expr1, expr2)
#     quote
#         Interval(@round_down($expr1), @round_up($expr2))
#     end
# end

macro round(expr1, expr2)
    quote
        Interval(@all_rounding($expr1, RoundDown), @all_rounding($expr2, RoundUp))
    end
end



# macro floatinterval(expr1, expr2)

#     expr3 = @interval($expr1, $expr2)
#     I = eval(expr3)

#     quote
#         set_rounding(Float64, RoundDown)
#         f1 = float(I.lo)

#         set_rounding(Float64, RoundUp)
#         f2 = float(I.hi)

#         Interval(f1, f2)

#     end

# end


function round_BigFloat_to_float(x, rounding_mode::RoundingMode)
     with_rounding(BigFloat, rounding_mode) do
        convert(Float64, x)
    end
end

function floatinterval(x::Interval)
    lo = round_BigFloat_to_float(x.lo, RoundDown)
    hi = round_BigFloat_to_float(x.hi, RoundUp)

    Interval(lo, hi)
end

macro floatinterval(expr1, expr2...)

    if isempty(expr2)
        expr2 = expr1
    end

    :(floatinterval(@interval($expr1, $expr2)))
end
