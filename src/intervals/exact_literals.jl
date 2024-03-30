"""
    ExactReal

Real numbers with the guarantee that they are meant to representing exactly the
number described by its binary form. By using ExactReal, the user accept the
responsability of guaranteeing that they are using the number they think they
are using.

For example, ExactReal(0.1) means the user knows that `0.1` can not be
represented exactly as a binary number, and that they are using a slightly
different number.

ExactReal always display the value of the number without any rounding, which can
make the problem more manifest.
```
julia> ExactReal(0.1)
ExactReal{Float64}(0.1000000000000000055511151231257827021181583404541015625)
```

Since the value of the number is guaranteed to be exact, ExactReal can be used
with Interval without producing the NG flag.

```julia
julia> 0.5 * interval(1)
[0.5, 0.5]_com_NG

julia> ExactReal(0.5) * interval(1)
[0.5, 0.5]_com
```

See @exact_input for a convenience macro to escape literals in an expression,
for example a function definition.
"""
struct ExactReal{T <: Real} <: Real
    value::T
end

# Promotion to Interval
Base.promote_rule(::Type{Interval{T}}, ::Type{ExactReal{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{ExactReal{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

Base.convert(::Type{Interval{T}}, x::ExactReal) where {T<:NumTypes} =
    interval(T, x.value)

# Promotion to Real
Base.promote_rule(::Type{T}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.convert(::Type{T}, x::ExactReal) where {T<:Real} =
    convert(T, x.value)

# Remove the fallback for Real number that go to the constructor T(x) and
# would allow to create ExactReal from other sources than literals.
Base.convert(::Type{<:ExactReal}, x::Real) =
    throw(ArgumentError("converting to ExactReal is not allowed"))

interval(::Type{T}, x::ExactReal{T}) where {T<:NumTypes} = interval(T, x.value)
interval(::Type{T}, x::ExactReal{<:Integer}) where {T<:NumTypes} = interval(T, x.value)
interval(x::ExactReal) = interval(x.value)

Base.string(x::ExactReal{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.value, 2000, false, false, false, UInt8('.'), true)

Base.string(x::ExactReal) = string(x.value)

Base.show(io::IO, ::MIME"text/plain", x::ExactReal{T}) where {T<:AbstractFloat} =
    print(io, "ExactReal{$T}($(string(x)))")

# This is always exact
Base.:(-)(x::ExactReal) = ExactReal(-x.value)

"""
    has_exact_display(x::Real)

Determine if the display of `x` is equal to the bitwise value of `x`.

This is famously not true for the float displayed as `0.1`
    
See the doc of ExactReal for more info., which is equal to
`0.1000000000000000055511151231257827021181583404541015625` since `0.1`
can not be represented exactly as a binary number.
"""
has_exact_display(x::Real) = string(x) == string(ExactReal(x))

"""
    @exact_input

Replace each literal number in the expression by an ExactReal.

When defining a function, it makes the function compatible with both regular
regular numbers and Interval, without producing the NG flag.
```
julia> X = interval(1, 2)
[1.0, 2.0]_com

julia> f(x) = 1.2*x + 0.1
f (generic function with 1 method)

julia> f(X)
[1.29999, 2.50001]_com_NG

julia> @exact_input g(x) = 1.2*x + 0.1
g (generic function with 1 method)

julia> g(X)
[1.29999, 2.50001]_com

julia> g(1.4)
1.78
```

This means it is on the user to make sure that their input is parsed to
the value they want to use. In case of doubt, has_exact_display can be use
to check if the string representation of a Real is equal to its binary value.

This is not true, for example, for the float displayed as `0.1`.

See the doc of ExactReal for more info.
"""
macro exact_input(expr)
    exact_expr = postwalk(expr) do x
        x isa Real && return ExactReal(x)

        # Unwrap literal powers to be sure the expression uses Base.literal_pow
        if @capture(x, y_ ^ N_)
            if N isa ExactReal{<:Integer}
                return :($y ^ $N)
            end
        end

        return x
    end

    return esc(exact_expr)
end