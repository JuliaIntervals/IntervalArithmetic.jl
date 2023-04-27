# internal mechanism

"""
    wrap_literals(T, expr1, expr2)

Take expressions and make each literal (e.g. 0.1, 1, etc.) into a corresponding
interval construction.
"""
wrap_literals(T, expr) = transform(expr, :atomic, :($T))

function wrap_literals(T, expr1, expr2)
    x = transform(expr1, :atomic, :($T))
    y = transform(expr2, :atomic, :($T))
    return :(interval($T, inf($x), sup($y)))
end

"""
    transform(expr, f, T)

Transform a string by applying the function `f` and type `T` to each argument.
For instance, `:(x + y)` is transformed into `:(f(T, x) + f(T, y))`.
"""
transform(x, f, T) = :($f($T, $x))

transform(x::Symbol, f, T) = :($f($T, $(esc(x))))

function transform(expr::Expr, f, T)
    if (expr.head == :(.) && expr.args[2] isa QuoteNode) || expr.head == :ref || expr.head == :macrocall
        return :($f($T, $(esc(expr))))
    end

    new_expr = copy(expr)

    first = 1  # where to start processing arguments

    if expr.head == :call || expr.head == :(.)
        first = 2  # skip operator
        if expr.args[1] ∉ (:+, :-, :*, :/, :^)  # escape standard function
            new_expr.args[1] = :($(esc(expr.args[1])))
        end
    end

    for (i, arg) ∈ enumerate(expr.args)
        if i ≥ first
            new_expr.args[i] = transform(arg, f, T)
        end
    end

    return new_expr
end

# macro constructors

"""
    @interval(expr)
    @interval(expr1, expr2)

Create an interval according to the IEEE Standard 1788-2015. Each number literal
is converted into an interval whose bound type is given by `default_numtype()`.

See also: [`interval`](@ref), [`±`](@ref), [`..`](@ref), [`@tinterval`](@ref)
and [`@I_str`](@ref).

# Examples
```jldoctest
julia> setformat(:full);

julia> @interval π-1
Interval{Float64}(2.141592653589793, 2.1415926535897936)

julia> @interval 1 2
Interval{Float64}(1.0, 2.0)
```
"""
macro interval(expr)
    return wrap_literals(default_numtype(), expr)
end

macro interval(expr1, expr2)
    return wrap_literals(default_numtype(), expr1, expr2)
end

"""
    @tinterval(T, expr)
    @tinterval(T, expr1, expr2)

Create an interval according to the IEEE Standard 1788-2015. Each number literal
is converted into an interval whose bound type is given by `T`.

See also: [`interval`](@ref), [`±`](@ref), [`..`](@ref), [`@interval`](@ref) and
[`@I_str`](@ref).

# Examples
```jldoctest
julia> setformat(:full);

julia> @tinterval Rational{Int32} π-1 π
Interval{Rational{Int32}}(54633275//25510582, 85563208//27235615)

julia> @tinterval Float32 π-1 π
Interval{Float32}(2.1415925f0, 3.1415927f0)
```
"""
macro tinterval(T, expr)
    return wrap_literals(:($T), expr)
end

macro tinterval(T, expr1, expr2)
    return wrap_literals(:($T), expr1, expr2)
end

"""
    I"str"

Create an interval according to the IEEE Standard 1788-2015. This is
semantically equivalent to `parse(Interval{default_numtype()}, str)`.

# Examples
```jldoctest
julia> setformat(:full);

julia> I"[3, 4]"
Interval{Float64}(3.0, 4.0)

julia> I"0.1"
Interval{Float64}(0.09999999999999999, 0.1)
```
"""
macro I_str(str)
    return parse(Interval{default_numtype()}, str)
end
