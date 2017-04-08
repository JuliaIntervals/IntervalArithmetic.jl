using IntervalArithmetic


"""Macro to make a version of a multidimensional function that acts on
an `IntervalBox` and returns an `IntervalBox`.
Both the original n-argument function and the `IntervalBox` version are defined.

Example:

    @intervalbox f(x, y) = (x + y, x - y)

    X = IntervalBox(1..1, 2..2)
    f(X)

(No significant error checking is performed!)
"""

macro intervalbox(ex)
    # @show ex
    # @show ex.head
    if ex.head != :(=)
        throw(ArgumentError("Not a function definition."))
    end

    if ex.args[1].head != :call
        throw(ArgumentError("Not a function definition."))
    end

    f = ex.args[1].args[1]  # function name
    f = esc(f)
    ex.args[1].args[1] = f  # escape the function name in the original code


    new_ex = Expr(:block)

    push!(new_ex.args, ex)  # the function call

    push!(new_ex.args,  :( ($f)(X::IntervalBox) = IntervalBox( $f(X...)...) ) )

    #@show new_ex
    new_ex
end
