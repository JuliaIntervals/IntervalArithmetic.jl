"""
    round_expr(ex::Expr, rounding_mode::RoundingMode)

Transforms a single expression by applying a rounding mode, e.g.

- `a + b` into `+(a, b, RoundDown)`
- `sin(a)` into `sin(a, RoundDown)`
"""
function round_expr(ex::Expr, rounding_mode::RoundingMode)

    if ex.head == :call

        op = ex.args[1]

        if op ∈ (:min, :max)
            mapped_args = round_expr.(ex.args[2:end], [rounding_mode]) # only in 0.5 and 0.6; in 0.6, can remove [...] around rounding_mode
            return :($op($(mapped_args...)))
        end


        if length(ex.args) == 3  # binary operator
            return :( $op( $(esc(ex.args[2])), $(esc(ex.args[3])), $rounding_mode) )

        else  # unary operator
            return :( $op($(esc(ex.args[2])), $rounding_mode ) )
        end
    else
        return ex
    end
end

round_expr(ex, rounding_mode) = ex  # generic fallback that doesn't round


"""
    @round(ex1, ex2)

Macro for internal use that creates an interval by rounding down `ex1` and rounding up `ex2`.
Each expression may consist of only a *single* operation that needs rounding, e.g.
`a.lo + b.lo` or `sin(a.lo)`.
It also handles `min(...)` and `max(...)`, where the arguments are each themselves
single operations.

The macro uses the internal `round_expr` function to transform e.g.
`a + b` into `+(a, b, RoundDown)`.

The user-facing equivalent is `@interval`, which can handle much more general cases.
"""
macro round(ex1, digits=ex2)
     :(Interval($(round_expr(ex1, RoundDown)), $(round_expr(ex2, RoundUp))))
end

macro round_down(ex1)
     round_expr(ex1, RoundDown)
end

macro round_up(ex1)
     round_expr(ex1, RoundUp)
end
